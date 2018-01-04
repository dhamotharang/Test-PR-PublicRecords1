import bankrupt,doxie, data_services;

f := Bankrupt.file_bk_search_bldg;

export key_bkrupt_casenum := index(f,{typeof(case_number) s_casenum := case_number, 
							 typeof(court_code) s_courtcode := court_code, 
							 typeof(seq_number) s_seqnumber := seq_number}, 
							 {f},
							 data_services.data_location.prefix() + 'thor_data400::key::bkrupt_casenum_' + doxie.Version_SuperKey);