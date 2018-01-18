import bankrupt,doxie, data_services;

f := bankrupt.file_bk_main;

export key_bkrupt_full := index(f, {typeof(case_number) s_casenum := case_number, 
							 typeof(court_code) s_courtcode := court_code, 
							 typeof(seq_number) s_seqnumber := seq_number}, 
							 {f}, 
							 data_services.data_location.prefix() + 'thor_data400::key::bkrupt_full_' + doxie.version_superKey);