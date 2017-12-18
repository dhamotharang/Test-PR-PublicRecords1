import doxie,data_services;


base_file_1 := UCCSearch.File_In_Debtors(trim(fname,left,right)!='' and trim(lname,left,right)!='');


export key_debtor_name := index(base_file_1,{fname,lname},{base_file_1},data_services.data_location.prefix() + 'thor_dell400_2::key::ucc_debtor_name_all');


