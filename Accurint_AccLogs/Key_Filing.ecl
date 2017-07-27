import doxie, Data_Services; // not requested - not created. would need to added to keybuild

d := DATASET([],{string17 Filing_Number, unsigned6 record_id});
					
export Key_Filing := INDEX(d, {d}, Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::' + doxie.Version_SuperKey + '::filing');
