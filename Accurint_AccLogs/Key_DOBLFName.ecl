import doxie, Data_Services;

d := DATASET([],{integer4 dob, string10 orig_company_id, string20 lname, string20 fname, unsigned6 record_id});
					
export Key_DOBLFName := INDEX(d, {dob, orig_company_id} , {lname, fname, record_id}, Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::' + doxie.Version_SuperKey + '::dob');
