import doxie, Data_Services;

d := DATASET([],{string17 ucc_number, unsigned6 record_id});
					
export Key_UCC := INDEX(d, {d}, Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::' + doxie.Version_SuperKey + '::UCC');
