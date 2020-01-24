pfunction varargout = rosma_gui(varargin)

% Begin initialization code - DO NOT EDIT
%clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rosma_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @rosma_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before rosma_gui is made visible.
function rosma_gui_OpeningFcn(hObject, eventdata, handles, varargin)
if ~robotics.ros.internal.Global.isNodeActive
    rosinit('NodeName','rosma_gui');
end

dvrkImage = imread('dvrk.png');
axes(handles.axes2);
imshow(dvrkImage)

% Choose default command line output for rosma_gui
handles.output = hObject;

handles.pub_filename = rospublisher('/rosma/gui/filename','std_msgs/String');
handles.pub_stop = rospublisher('/rosma/gui/stop_recording','std_msgs/Bool');
handles.sub = rossubscriber('/dvrk/footpedals/coag','sensor_msgs/Joy', {@cbCoag,handles});

handles.tasks = {'Clipping (B1)'; 'Pea on a Peg (B2)'; ' Wire Chaser I (B3)'; ...
    'Post and Sleeve (I1)'; 'Wire Chaser II (I2)'; 'Pattern Cutting (I3)';...
    'Holiotomy (I4)'; 'Knot Tying (C2)'; 'Suturing (C2)'};

handles.t = uitable('Parent',handles.uipanel_experiment, ...
     'FontSize',14,'Visible','off',...
     'Data',cell(9,1),'RowName',handles.tasks,...
     'ColumnName','#Repetitions',...
     'Position',[10 70 320 260],'Units','characters');

% Update handles structure 
guidata(hObject, handles);

% Creating folders if they do not exist
files = dir(pwd);
if isempty(find(strcmp({files.name},'dvrk_dataset_csv')))
    mkdir('dvrk_dataset_csv');
end
if isempty(find(strcmp({files.name},'dvrk_dataset_bagfiles')))
    mkdir('dvrk_dataset_bagfiles');
end

if isempty(find(strcmp({files.name},'profiles.mat')))
    UserProfiles = table;
    UserProfiles.Id = {};
    UserProfiles.Name = {};
    UserProfiles.Surname = {};
    UserProfiles.Gender = {};
    UserProfiles.Age = {};
    UserProfiles.B1 = {};
    UserProfiles.B2 = {};
    UserProfiles.B3 = {};
    UserProfiles.I1 = {};
    UserProfiles.I2 = {};
    UserProfiles.I3 = {};
    UserProfiles.I4 = {};
    UserProfiles.C1 = {};
    UserProfiles.C2 = {};

    save('profiles.mat','UserProfiles');
end

% if isempty(find(strcmp({files.name},'experiment_info.mat')))
%     save('experiment_info.mat','');
% end

% --- Outputs from this function are returned to the command line.
function varargout = rosma_gui_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;

function figure1_CloseRequestFcn(hObject, eventdata, handles)
rosshutdown
delete(hObject)

% --- Executes during object creation, after setting all properties.
function uipanel_info_CreateFcn(hObject, eventdata, handles)
function figure1_CreateFcn(hObject, eventdata, handles)
function filename_txt_CreateFcn(hObject, eventdata, handles)
function load_user_uipanel_experiment_CreateFcn(hObject, eventdata, handles)
function load_task_CreateFcn(hObject, eventdata, handles)
function load_user_CreateFcn(hObject, eventdata, handles)
function uipanel_experiment_CreateFcn(hObject, eventdata, handles)
function skill_pop_CreateFcn(hObject, eventdata, handles)
function age_txt_CreateFcn(hObject, eventdata, handles)
function gender_pop_CreateFcn(hObject, eventdata, handles)
function surname_txt_CreateFcn(hObject, eventdata, handles)

% --- Executes on button press in new_user_pb.
function new_user_pb_Callback(hObject, eventdata, handles)
set(handles.uipanel_info,'Visible','off');
set(handles.new_user_pb,'Visible','off');
set(handles.begin_pb,'Visible','off')
set(handles.uipanel_set_profile,'Visible','on');

% --- Executes on button press in begin_pb.
function begin_pb_Callback(hObject, eventdata, handles)
set(handles.uipanel_info,'Visible','off');
set(handles.new_user_pb,'Visible','off');
set(handles.begin_pb,'Visible','off')
set(handles.uipanel_experiment,'Visible','on');

load profiles
users = strcat(UserProfiles.Name,{' '}, UserProfiles.Surname);
pop_str = [{'Load User'}; users];
set(handles.load_user,'String',pop_str);

task_str = [{'Select Task'};handles.tasks];
set(handles.load_task,'String',task_str);

% --- Executes on button press in save_profile_pb
function save_profile_pb_Callback(hObject, eventdata, handles)

load profiles

% Getting user info
handles.w = 1;
c = zeros(1,5);

while(handles.w)
    if (get(handles.save_profile_pb,'Value'))
        name = get(handles.name_txt,'String');
        if ~isempty(name)
            c(1) = 1;
        end
        
        surname = get(handles.surname_txt,'String');
        if ~isempty(surname)
            c(2) = 1;
        end

        age = get(handles.age_txt,'String');
        if ~isempty(age)
            c(3) = 1;
        end

        switch get(handles.gender_pop,'Value')
            case 2
                gender = 'Male';
                c(4) = 1;
            case 3
                gender = 'Female';
                c(4) = 1;
        end

        switch get(handles.skill_pop,'Value')
            case 2
                skill = 'T';
                n_id = sum(contains(UserProfiles.Id,'T'));
                c(5) = 1;
            case 3
                skill = 'S';
                n_id = sum(contains(UserProfiles.Id,'S'));
                c(5) = 1;
        end

        if sum(c) < 5
            set(handles.complete_txt,'Visible','on');
            set(handles.complete_pb,'Visible','on');
            set(handles.save_profile_pb,'enable','off')
            set(handles.save_profile_pb,'Value',0)
            uiwait;
            else handles.w = 0;
        end
    guidata(hObject, handles);    
    end
    pause(0.1)
end

% Saving user profile 
if isempty(n_id)
    n_id = 0;
end
num = n_id+1;
if num < 10
    numstr = strcat('0',num2str(num));
end
id = strcat(skill,numstr);

[n,~] = size(UserProfiles);
UserProfiles.Id{n+1} = id;
UserProfiles.Name{n+1} = name;
UserProfiles.Surname{n+1} = surname;
UserProfiles.Age{n+1} = age;
UserProfiles.Gender{n+1} = gender;
UserProfiles.B1{n+1} = 0;
UserProfiles.B2{n+1} = 0;
UserProfiles.B3{n+1} = 0;
UserProfiles.I1{n+1} = 0;
UserProfiles.I2{n+1} = 0;
UserProfiles.I3{n+1} = 0;
UserProfiles.I4{n+1} = 0;
UserProfiles.C1{n+1} = 0;
UserProfiles.C2{n+1} = 0;

save('profiles','UserProfiles');

user = {'B1','B2','B3','I1','I2','I3','I4','C1','C2'};
eval(strcat(id,'= user;'))
if isfile(strcat(pwd,'/experiment_info.mat'))
    eval(strcat('save(',char(39),'experiment_info',char(39),',',char(39),id,char(39),',',char(39),'-append',char(39),')'))
else
    eval(strcat('save(',char(39),'experiment_info',char(39),',',char(39),id,char(39),')'))
end

% Back to initial panel
back_pb_Callback(hObject, eventdata, handles)

% --- Executes on button press in complete_pb.
function complete_pb_Callback(hObject, eventdata, handles)
uiresume;
set(handles.save_profile_pb,'enable','on')
set(handles.complete_txt,'Visible','off');
set(handles.complete_pb,'Visible','off');


% --- Executes on button press in back_pb.
function back_pb_Callback(hObject, eventdata, handles)
show_init_panel(handles);
uiresume;
set(handles.uipanel_set_profile,'Visible','off');
set(handles.uipanel_clear,'Visible','off');
set(handles.clear_data,'Visible','off');
set(handles.uipanel_experiment,'Visible','off');
set(handles.t,'Visible','off')
set(handles.load_user,'Value',1);
set(handles.filename_txt,'Visible','off');
set(handles.load_task,'Visible','off')
set(handles.load_task,'Value',1);
set(handles.history,'Visible','off')
set(handles.start_pb,'Visible','off')
set(handles.stop_pb,'Visible','off')
set(handles.recording,'Visible','off')
set(handles.time,'Visible','off')
set(handles.start_pb,'Enable','on')

% Clear data for next entries
set(handles.name_txt,'String','')
set(handles.surname_txt,'String','')
set(handles.gender_pop,'Value',1)
set(handles.skill_pop,'Value',1)
set(handles.age_txt,'String','')

handles.w = 0;
guidata(hObject, handles);

% --- Executes on button press in pushbutton30.
function reset2_pb_Callback(hObject, eventdata, handles)
% Saving previous data into a zip file
zip(date,{strcat(pwd,'/dvrk_dataset_csv'),strcat(pwd,'/dvrk_dataset_bagfiles'),'profiles.mat'})

% Deleting files
delete('dvrk_dataset_csv/*')
delete('dvrk_dataset_bagfiles/*')
delete('experiment_info.mat');

% Creating profiles.mat 
UserProfiles = table;
UserProfiles.Id = {};
UserProfiles.Name = {};
UserProfiles.Surname = {};
UserProfiles.Gender = {};
UserProfiles.Age = {};

UserProfiles.B1 = {};
UserProfiles.B2 = {};
UserProfiles.B3 = {};

UserProfiles.I1 = {};
UserProfiles.I2 = {};
UserProfiles.I3 = {};
UserProfiles.I4 = {};

UserProfiles.C1 = {};
UserProfiles.C2 = {};

save('profiles.mat','UserProfiles');


% --- Executes on button press in reset2_pb.
function save_csv_pb_Callback(hObject, eventdata, handles)
% filename = 'rosma_experiment_info.csv';
% load profiles
% writetable(T,filename);


% --- Executes on selection change in load_user.
function load_user_Callback(hObject, eventdata, handles)
set(handles.t,'Visible','on')
set(handles.history,'Visible','on')
set(handles.load_task,'Visible','on')

% Search current user
load profiles
name_indx = get(handles.load_user,'Value');
name_str = get(handles.load_user,'String');
full_name = strsplit(name_str{name_indx});
indx = find(contains(UserProfiles.Name,full_name{1}));
if length(indx)>1
    indx2 = find(contains(UserProfiles.Surname,full_name{2}));
    indx = intersect(indx,indx2);
end
handles.current = indx;

handles.c_id = UserProfiles.Id{indx};
set(handles.history,'String',strcat('User',{' '},handles.c_id,{' '},'history'))

set(handles.t,'Data',{UserProfiles.B1{indx};UserProfiles.B2{indx};UserProfiles.B3{indx}; UserProfiles.I1{indx};UserProfiles.I2{indx};UserProfiles.I3{indx}; UserProfiles.I4{indx};UserProfiles.C1{indx};UserProfiles.C2{indx}})

guidata(hObject, handles);

% --- Executes on selection change in load_task.
function load_task_Callback(hObject, eventdata, handles)
set(handles.start_pb,'Visible','on');
set(handles.clear_data,'Visible','on')

n_task = get(handles.load_task,'Value');
str_task = get(handles.load_task,'String');
task_full = strsplit(str_task{n_task});
handles.c_task = task_full{end}(2:3);
guidata(hObject, handles);

% --- Executes on button press in start_cb.
function start_pb_Callback(hObject, eventdata, handles)
% Checking if dvrk is running
set(handles.start_pb,'userdata',1)

if find(strcmp(rosnode('list'),'/rosma'))
    
    set(handles.start_pb,'Enable','off');

    tic

    load profiles

    % Setting filename
    indx = handles.current;
    c_id = UserProfiles.Id{indx};

    eval(strcat('ntrial = UserProfiles.',handles.c_task,'{indx};'));
    if isempty(ntrial) 
        ntrial = 1; 
    else ntrial = ntrial +1;
    end
    if ntrial<10
        handles.str_ntrial = strcat('0',num2str(ntrial));
    else handles.str_ntrial = num2str(ntrial);
    end

    handles.filename = strcat(c_id,'_',handles.c_task,'_',handles.str_ntrial);
    set(handles.filename_txt,'Visible','on',...
        'String', strcat('Generating file',{' '},handles.filename));

    guidata(hObject, handles);
    
    msg = rosmessage('std_msgs/String');
    msg.Data = strcat(pwd,'/dvrk_dataset_csv/',handles.filename);
    send(handles.pub_filename,msg);
    set(handles.stop_pb,'Visible','on')
    set(handles.recording,'Visible','on')
    set(handles.time,'Visible','on')

    set(handles.stop_pb, 'userdata',0)
    
    n = 1;
    while(true)
        if rem(n,2) == 0
            set(handles.recording,'Visible','on')
        else 
            set(handles.recording,'Visible','off')
        end

        set(handles.time,'String',strcat('Time:',{' '},num2str(toc),{' '},'seconds'))

        if get(handles.stop_pb, 'userdata')
            break
        end

        n = n+1;
        pause(0.5);
    end

    %guidata(hObject, handles);
else
    set(handles.filename_txt,'Visible','on','String', 'DVRK node is not running!');
end

% --- Executes on button press in stop_pb2str
function stop_pb_Callback(hObject, eventdata, handles)
set(handles.start_pb,'userdata',0)

handles.c_time = toc;
set(handles.recording,'Visible','off')

set(handles.start_pb,'Enable','on')
set(handles.recording,'Visible','off')
set(handles.time,'Visible','off')

msg = rosmessage('std_msgs/Bool');
msg.Data = 1;
send(handles.pub_stop,msg);
 
set(handles.stop_pb, 'userdata',1)

% Checking if csv file has been saved
load profiles
indx = handles.current;

cd dvrk_dataset_csv
if ~isfile(handles.filename)
    set(handles.filename_txt,'String','File not saved. Repeat the experiment');
    
else 
    cd ..
    set(handles.filename_txt,'String','');
    
    % Saving changes in profiles.mat
    eval(strcat('UserProfiles.',handles.c_task,'{',num2str(indx),'} = UserProfiles.',handles.c_task,'{',num2str(indx),'}+1;'))
    save profiles UserProfiles
    
    % Updating table
    set(handles.t,'Data',{UserProfiles.B1{indx};UserProfiles.B2{indx};UserProfiles.B3{indx}; UserProfiles.I1{indx};UserProfiles.I2{indx};UserProfiles.I3{indx}; UserProfiles.I4{indx};UserProfiles.C1{indx};UserProfiles.C2{indx}})

    % Saving experiment info
    
    load experiment_info
    % n = column of the current task in the variable of the user
    eval( strcat('n = find (strcmp(',handles.c_id,',',char(39),handles.c_task,char(39),'));') )
    % m = Row of current user in UserProfiles
    eval( strcat( 'm = find(strcmp(UserProfiles.Id,',char(39),handles.c_id,char(39),'));'))
   
    % ntrial = number of trial for the current task
    eval( strcat('ntrial = UserProfiles.',handles.c_task,'{',num2str(m),'};'))
    eval( strcat('n = find (strcmp(',handles.c_id,'(1,:),',char(39),handles.c_task,char(39),'));'))    
    eval( strcat( handles.c_id,'{',num2str(ntrial+1),',',num2str(n),'} = ',num2str(handles.c_time),''))

    save('experiment_info',eval('handles.c_id'),'-append')
    
end


% --- Executes on button press in clear_data.
function clear_data_Callback(hObject, eventdata, handles)
set(handles.uipanel_clear,'Visible','on');
set(handles.filename_txt,'Visible','off')

% --- Executes on button press in back_clear.
function back_clear_Callback(hObject, eventdata, handles)
set(handles.uipanel_clear,'Visible','off');


% --- Executes on button press in clear_last.
function clear_last_Callback(hObject, eventdata, handles)
load profiles

indx = handles.current;
eval(strcat('UserProfiles.',handles.c_task,'{',num2str(indx),'} = UserProfiles.',handles.c_task,'{',num2str(indx),'}-1;'))
eval(strcat('if UserProfiles.',handles.c_task,'{',num2str(indx),'}<0,UserProfiles.',handles.c_task,'{',num2str(indx),'} = 0; end'))
save profiles UserProfiles

% Updating table
set(handles.t,'Data',{UserProfiles.B1{indx};UserProfiles.B2{indx};UserProfiles.B3{indx}; UserProfiles.I1{indx};UserProfiles.I2{indx};UserProfiles.I3{indx}; UserProfiles.I4{indx};UserProfiles.C1{indx};UserProfiles.C2{indx}})

% Delete csv file
cd dvrk_dataset_csv

delete(strcat(handles.c_id,'_',handles.c_task,'_',handles.str_ntrial));
cd ..
set(handles.uipanel_clear,'Visible','off');

load experiment_info
eval( strcat('[~,n] = find (strcmp(',handles.c_id,',',char(39),handles.c_task,char(39),'));') )

if n>=2
    eval(strcat(handles.c_id,'{end,',num2str(n),'} = []'))
end
save('experiment_info',eval('handles.c_id'),'-append')

% --- Executes on button press in clear_last.
function clear_all_Callback(hObject, eventdata, handles)
load profiles

indx = handles.current;
eval(strcat('UserProfiles.',handles.c_task,'{',num2str(indx),'} = 0;'))
save profiles UserProfiles

load experiment_info
eval( strcat('[~,n] = find (strcmp(',handles.c_id,',',char(39),handles.c_task,char(39),'));') )
eval(strcat(handles.c_id,'(2:end,',num2str(n),') = {0};'))
save('experiment_info',eval('handles.c_id'))

% Updating table
set(handles.t,'Data',{UserProfiles.B1{indx};UserProfiles.B2{indx};UserProfiles.B3{indx}; UserProfiles.I1{indx};UserProfiles.I2{indx};UserProfiles.I3{indx}; UserProfiles.I4{indx};UserProfiles.C1{indx};UserProfiles.C2{indx}})

% Delete csv files
cd dvrk_dataset_csv
d = dir; 
n = {d.name};
if length(n) >= 3
    delete(n{[contains(n,handles.c_id)]})
end
cd ..
set(handles.uipanel_clear,'Visible','off');

function name_txt_Callback(hObject, eventdata, handles)
function surname_txt_Callback(hObject, eventdata, handles)
function gender_pop_Callback(hObject, eventdata, handles)
function age_txt_Callback(hObject, eventdata, handles)
function skill_pop_Callback(hObject, eventdata, handles)


function cbCoag(src, msg,handles)
coag = msg.Buttons;
if coag 
    display('start')
    get(handles.start_pb,'userdata')
    if ~get(handles.start_pb,'userdata')
        %start_pb_Callback(~, ~, handles);
        display('start')
    end
end

