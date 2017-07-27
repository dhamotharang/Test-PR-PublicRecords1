export Mac_SLiens_Daily_Spray(sourceIP,sourcefile,filedate,group_name='\'thor_dell400\'',email_target='\' \'') := 
macro
#uniquename(spray_liens)
#uniquename(super_liens)
#uniquename(recordsize)
#uniquename(fullfile)
#uniquename(daily)
#uniquename(basefile)
#uniquename(baseout)

#workunit('name','Superior Liens Daily Spray ' + filedate);

%recordsize% := 1603;

%spray_liens% := FileServices.SprayFixed(sourceIP, sourcefile, %recordsize%, group_name, '~thor_data400::in::superior_liens_' + filedate , -1,,, true, true);
%fullfile%    := dataset('~thor_data400::base::superior_liens', liens_superior.Layout_superior_Liens, thor);
%daily%       := dataset('~thor_data400::in::superior_liens_' + filedate,liens_superior.Layout_superior_Liens, thor);
%basefile%    := %fullfile% + %daily%;
%baseout%     := output(%basefile%,, 'in::superior_liens_full_' + filedate, overwrite);

%super_liens% := sequential(%baseout%,
				FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::superior_liens_delete','~thor_data400::base::superior_liens_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::base::superior_liens_grandfather'),
				FileServices.AddSuperFile('~thor_data400::base::superior_liens_grandfather','~thor_data400::base::superior_liens_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::superior_liens_father'),
				FileServices.AddSuperFile('~thor_data400::base::superior_liens_father', '~thor_data400::base::superior_liens',, true),
				FileServices.ClearSuperFile('~thor_data400::base::superior_liens'),
				FileServices.AddSuperFile('~thor_data400::base::superior_liens', '~thor_data400::in::superior_liens_full_' + filedate), 
				// FileServices.ClearSuperFile('~thor_data400::in::superior_liens_did_in'),
				// FileServices.AddSuperFile('~thor_data400::in::superior_liens_did_in', '~thor_data400::in::superior_liens_full_' + filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::superior_liens_Delete', true));

sequential(%spray_liens%,%super_liens%)
 : success(FileServices.sendemail(if(email_target<>' ', email_target, liens_superior.Spray_Notification_Email_Address),'Superior Liens Spray Succeeded','Superior Liens Spray Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ', email_target, liens_superior.Spray_Notification_Email_Address),'Superior Liens Spray Failure','Superior Liens Spray Failure'))
 ;

endmacro;