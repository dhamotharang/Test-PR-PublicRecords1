import ut;

supp := file_bankruptcy_main_v3_supplemented(~(delete_flag = 'D' or court_code+case_number in bankruptcyv2.Suppress.court_code_caseno));

export file_bankruptcy_main_v3 := supp;