import ut;

ds := bankruptcyv2.file_bankruptcy_search_v3_supp_bip(~(delete_flag = 'D' or court_code+case_number in bankruptcyv2.Suppress.court_code_caseno));

export file_bankruptcy_search_v3_bip := ds;
