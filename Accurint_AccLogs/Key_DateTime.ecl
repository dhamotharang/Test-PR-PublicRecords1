import doxie, Data_Services;

d := DATASET([],{string8 Date, string16 Time, unsigned6 record_id});
					
export key_datetime := INDEX(d, {d}, Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::' + doxie.Version_SuperKey + '::DateTime');
