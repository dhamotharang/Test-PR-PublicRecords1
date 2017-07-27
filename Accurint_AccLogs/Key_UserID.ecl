import doxie, Data_Services;

d := DATASET([],{string20 user_ID, integer4 date_added, unsigned6 record_id});
					
export Key_UserID := INDEX(d, {user_ID, date_added}, {record_id}, 
			Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::' + doxie.Version_SuperKey + '::userid');
