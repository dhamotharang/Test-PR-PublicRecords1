import doxie, Data_Services;

d := DATASET([],{unsigned6 link_id, unsigned6 record_id});
					
export Key_linkID := INDEX(d, {d}, Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::' + doxie.Version_SuperKey + '::linkid');