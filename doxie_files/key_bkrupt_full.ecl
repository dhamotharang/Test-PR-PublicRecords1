import bankrupt,doxie;

f := bankrupt.file_bk_main;

export key_bkrupt_full := index(f, {typeof(case_number) s_casenum := case_number, 
							 typeof(court_code) s_courtcode := court_code, 
							 typeof(seq_number) s_seqnumber := seq_number}, {f}, '~thor_data400::key::bkrupt_full_' + doxie.version_superKey);