
import data_services;


base_file_1 := UCCSearch.File_In_Debtors(trim(orig_filing_num,left,right)!='');


export key_filing_number := index(base_file_1,{orig_filing_num},{base_file_1},data_services.data_location.prefix() + 'thor_dell400_2::key::ucc_filing_number_all');
