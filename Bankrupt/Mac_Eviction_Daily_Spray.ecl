export Mac_Eviction_Daily_Spray(sourcefile,filedate,group_name= '',email_target='\' \'') := 
macro
#uniquename(spray_eviction)
#uniquename(super_eviction)
#uniquename(recordsize)
#uniquename(sourceIP)

#workunit('name','Eviction Daily Spray '+filedate);

%recordsize% :=810;
%sourceIP% := _control.IPAddress.edata12;

%spray_eviction% := FileServices.SprayFixed(%sourceIP%,sourcefile, %recordsize%, group_name,'~thor_data400::in::eviction_'+filedate ,-1,,,true,true);

%super_eviction% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::eviction_Delete','~thor_data400::base::eviction_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::eviction_father'),
				FileServices.AddSuperFile('~thor_data400::base::eviction_father', '~thor_data400::base::eviction',, true),
				FileServices.ClearSuperFile('~thor_data400::base::eviction'),
				FileServices.AddSuperFile('~thor_data400::base::eviction', '~thor_data400::in::eviction_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::eviction_Delete',true));

sequential(%spray_eviction%,%super_eviction%)
 : success(FileServices.sendemail(if(email_target<>' ',email_target,'avenkatachalam@seisint.com'),'eviction Spray Succeeded','eviction Spray Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ',email_target,'avenkatachalam@seisint.com'),'eviction Spray Failure','eviction Spray Failure'))
 ;

endmacro;