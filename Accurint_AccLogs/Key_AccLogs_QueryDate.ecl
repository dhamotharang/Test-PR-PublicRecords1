import doxie, Data_Services; // not requested - not created. would need to added to keybuild

d := DATASET([],{string8 dt_vendor_first_reported, string8 dt_vendor_last_reported, unsigned6 record_id});
					
export Key_AccLogs_QueryDate := INDEX(d, {d}, Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs_autokeydate_' + doxie.Version_SuperKey);
