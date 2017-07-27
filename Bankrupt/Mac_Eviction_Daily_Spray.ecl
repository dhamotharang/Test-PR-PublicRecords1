export Mac_Eviction_Daily_Spray(sourceIP,sourcefile,filedate,group_name='\'thor_dell400\'',email_target='\' \'') := 
macro
#uniquename(spray_eviction)
#uniquename(super_eviction)
#uniquename(recordsize)

#workunit('name','Eviction Daily Spray '+filedate);

%recordsize% :=810;

%spray_eviction% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::eviction_'+filedate ,-1,,,true,true);

%super_eviction% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::eviction_Delete','~thor_data400::base::eviction_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::eviction_father'),
				FileServices.AddSuperFile('~thor_data400::base::eviction_father', '~thor_data400::base::eviction',, true),
				FileServices.ClearSuperFile('~thor_data400::base::eviction'),
				FileServices.AddSuperFile('~thor_data400::base::eviction', '~thor_data400::in::eviction_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::eviction_Delete',true));

sequential(%spray_eviction%,%super_eviction%)
 : success(FileServices.sendemail(if(email_target<>' ',email_target,Bankrupt.Spray_Notification_Email_Address),'eviction Spray Succeeded','eviction Spray Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ',email_target,Bankrupt.Spray_Notification_Email_Address),'eviction Spray Failure','eviction Spray Failure'))
 ;

endmacro;