export Mac_BK_Daily_Spray(sourceIP,Mainfile,Searchfile,filedate,group_name ='\'thor_dell400\'',email_target='\' \'') := 
macro
#uniquename(spray_main)
#uniquename(spray_search)
#uniquename(super_main)
#uniquename(super_search)
#uniquename(recordsizeMain)
#uniquename(recordsizeSearch)
#uniquename(build_bk_keys)

#workunit('name','Bankruptcy Daily Spray '+filedate);

%recordsizeMain% :=1533;
%recordsizeSearch% :=478;

%spray_main% := FileServices.SprayFixed(sourceIP,Mainfile, %recordsizeMain%,group_name,'~thor_data400::in::bk_main_'+filedate ,-1,,,true,true);
%spray_search% := FileServices.SprayFixed(sourceIP,searchfile,%recordsizeSearch%,group_name,'~thor_data400::in::bk_search_'+filedate ,-1,,,true,true);
%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_Main_Delete','~thor_data400::base::bankrupt_main_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_main_father'),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_main_father', '~thor_data400::base::bankrupt_main',, true),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_main'),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_main', '~thor_data400::in::bk_main_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_main_delete',true));

%super_search% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_search_Delete','~thor_data400::base::bankrupt_search_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_search_father'),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_search_father', '~thor_data400::base::bankrupt_search',, true),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_search'),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_search', '~thor_data400::in::bk_search_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_search_delete',true));

%build_bk_keys% := bankrupt.proc_build_key;

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)

doxie.Mac_Daily_Email('BK','SUCC',%send_succ_msg%,if(email_target<>' ',email_target,Bankrupt.Spray_Notification_Email_Address));
doxie.Mac_Daily_Email('BK','FAIL',%send_fail_msg%,if(email_target<>' ',email_target,Bankrupt.Spray_Notification_Email_Address));


sequential(parallel(%spray_main%,%spray_search%),parallel(%super_main%,%super_search%),%build_bk_keys%) :
           success(%send_succ_msg%),
           failure(%send_fail_msg%);

endmacro;