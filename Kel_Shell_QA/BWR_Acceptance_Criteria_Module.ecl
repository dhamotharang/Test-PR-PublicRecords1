﻿Import STD;

// step 1
// update AC_Lay here...
Base_Lay:=Kel_Shell_QA.Layouts.AC_Lay;

logical_file_name:='~jastad01::100k_current_business_ks-1008_w20191021-092827_masterlayout.csv';

unique_id:='p_inpacct';
Tag:= regexreplace('~',logical_file_name,'');
sample_size:=0;

//***************************************************************************************************************************

input_file:=dataset(logical_file_name,Base_Lay,CSV(HEADING(single), QUOTE('"')));

inut_file_records:= if(sample_size=0, choosen(input_file,all),choosen(input_file,sample_size) );


// get logical file layout and convert into set
get_lay:=STD.File.GetLogicalFileAttribute(logical_file_name,'ECL');
regex_replace:= regexreplace('[{RECORD ; END}]',get_lay,' ');
filtered_lay:=nothor(STD.STr.SplitWords(trim(regex_replace,left,right),' ')); 
 // output(filtered_lay);

 // step 2
// run this action Attribute 
parallel(Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Professional License'),
         Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Assets'),
         Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'B2B Trade'),
         Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay, 'Criminal History'),
         Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Bankruptcy History'),
                                                                Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Business Input Validation'),
                                                                Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Validation'),
                                                                Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Business Asset Attributes'),
                                                                Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Business Derog - Bankruptcy History'),
                                                                Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Secretary of State'),
                                                                Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Best BII')
                                                                Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Business Judgments')
                                                                Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Business Derogs - Landlord Tenant Disputes')
                                                                Kel_Shell_QA.AC_automated_file(unique_field, inut_file_records, Tag, filtered_lay,'Business Derogs - Lien and Judgment History')
                                                                );


EXPORT BWR_Acceptance_Criteria_Module := 'todo';
