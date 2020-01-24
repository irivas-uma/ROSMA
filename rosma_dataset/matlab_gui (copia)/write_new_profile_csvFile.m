function write_new_profile_csvFile(handles,id,name,surname,age,gender)

T = readtable(handles.filename);
%delete(handles.filename)

[n,~] = size(T);
T.id{n+1} = id
T.name{n+1} = name
T.surname{n+1} = surname;
T.age{n+1} = age;
T.gender{n+1} = gender;
% 
% writetable(T,handles.filename)