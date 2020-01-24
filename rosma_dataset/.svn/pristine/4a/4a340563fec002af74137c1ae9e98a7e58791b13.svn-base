function handles = create_matFile()

if exist('profiles.mat')
    load profiles
    str = strcat('profiles--',string(datetime('now')));
    save(str,'UserProfiles')
end
    

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
