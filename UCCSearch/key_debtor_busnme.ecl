
import doxie;

base_file_1 := UCCSearch.File_In_Debtors(trim(name,left,right)!='');


export key_debtor_busnme := index(base_file_1,{name},{base_file_1},'~thor_dell400_2::key::ucc_debtor_busname_all');


