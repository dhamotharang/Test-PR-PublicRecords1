export file_bankruptcy_search_v3_daily := project(file_bankruptcy_search_v3_daily_bip, transform(BankruptcyV2.layout_bankruptcy_search_v3_supp ,self := left));
