import ut;

supp := file_bankruptcy_main_v3_supplemented(delete_flag <> 'D');

export file_bankruptcy_main_v3 := supp;