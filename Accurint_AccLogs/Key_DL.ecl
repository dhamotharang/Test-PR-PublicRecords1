import doxie, Data_Services;

d := DATASET([],{string24 dl, unsigned6 record_id});
					
export Key_DL := INDEX(d, {d}, Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::' + doxie.Version_SuperKey + '::dl');
