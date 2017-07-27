import bankrupt,doxie,ut;

f := bankrupt.file_bk_search_bldg;

export key_bkrupt_casenum_fcra := index (f, 
  {typeof(case_number) s_casenum := case_number, 
   typeof(court_code) s_courtcode := court_code, 
   typeof(seq_number) s_seqnumber := seq_number}, 
  {f},'~thor_data400::key::bankrupt::fcra::' + doxie.Version_SuperKey + '::casenum');