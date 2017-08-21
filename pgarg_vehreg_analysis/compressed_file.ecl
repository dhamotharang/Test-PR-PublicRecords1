dOriginal     :=     dataset('~thor_dell400_2::base::ln_tu_File_In_Base_All_UID',LN_TU.Layout_clean_addr_record,flat); 

output(dOriginal,,'~thor_data400::base::ln_tu_File_In_Base_All_UID',__compressed__);