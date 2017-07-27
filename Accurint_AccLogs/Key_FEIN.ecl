import doxie, Data_Services; // not requested - not created. would need to added to keybuild

d := DATASET([],{unsigned6 FEIN, unsigned6 record_id});
					
export Key_FEIN := INDEX(d, {d}, Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::' + doxie.Version_SuperKey + '::fein');
