import doxie, data_services;

f := file_bk_search_bldg;

export key_prep_bankrupt_casenum := index(f,{typeof(case_number) s_casenum := case_number, 
							 typeof(court_code) s_courtcode := court_code, 
							 typeof(seq_number) s_seqnumber := seq_number}, {f},data_services.data_location.prefix('bankruptcy') + 'thor_data400::key::bkrupt_casenum_' + thorlib.wuid());