export Spray_PullZip_File(string sourceIP,string sourcefile,string filedate,string group_name='thor_dell400') := function

#workunit('name','Pull Zip Spray (Katrina) '+filedate);
recordsize:=6;
spray_first := FileServices.SprayFixed(sourceIP,sourcefile, recordsize, group_name,'~thor_data400::in::pull_zip_'+filedate ,-1,,,true,true);
clear_super := fileservices.clearsuperfile('~thor_data400::base::pull_zip',true);
add_super := fileservices.addsuperfile('~thor_data400::base::pull_zip','~thor_data400::in::pull_zip_'+filedate);

spray_actions := sequential(spray_first,clear_super,add_super);

start_spray := output('Spraying Pull Zip file...') : success(spray_actions);

return sequential(start_spray, 
                  doxie.Test_PullZip_File, 
									doxie.Proc_Build_Key_pullZip);
end;