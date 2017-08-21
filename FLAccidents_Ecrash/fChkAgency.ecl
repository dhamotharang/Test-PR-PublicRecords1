import lib_fileservices;

EXPORT fChkAgency := function

file_list := FileServices.LogicalFileList(namepattern := '*in::ecrash::agency*');

versionrec := record
string8 lVersion := if(regexfind('[0-9]{8}',file_list.name) = true, regexfind('[0-9]{8}',file_list.name, 0), '0');
end;

version_ds := table(file_list,versionrec,few);

getmaxvs := max(version_ds,lVersion);


add_file := if(FileServices.GetSuperFileSubCount('~thor_data400::in::ecrash::agency') = 0,FileServices.AddSuperFile('~thor_data400::in::ecrash::agency','~thor_data400::in::ecrash::agency.'+getmaxvs+'.csv'),Output('Agency_SuperFile_is_not_Empty'));

return add_file;
end;