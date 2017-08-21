layout_abn_amro_csv_in := record
string seq;
string did;
string DESCRIPTION1;
string HOUSEHOLD_KEY;
string INDIVIDUAL_KEY;
string NAME_FULL;
string MAILING_ADDRESS_1;
string MAILING_ADDRESS_2;
string MAILING_CITY;
string MAILING_STATE;
string MAILING_ZIP_CODE;
string PHONE;
string bdid;
string group_id;
string confidence_level;
string best_CompanyName;
string best_addr1;
string best_city;
string best_state;
string best_zip;
string best_zip4;
string best_phone;
string best_fein;
string contact_title;
string contact_title_rank;
string contact_fname;
string contact_mname;
string contact_lname;
string contact_name_suffix;
string contact_is_business_owner;
string SIC_Code1;
string SIC_Code2;
string SIC_Code3;
string Number_Of_Employees;
string Annual_Sales;
end;

abn_amro_in := dataset('~thor_data400::TMTEST::ABN_AMRO_C2BTest_Out_CSV', layout_abn_amro_csv_in, csv(heading(1),separator(','),terminator('\n'),quote('"')));

count(abn_amro_in);
output(choosen(abn_amro_in,1000),all);



// Output file for transfer
output(abn_amro_in,,'TMTEST::ABN_AMRO_C2BTest_Out_CSV_Pipe',csv(
heading(
'seq,did,DESCRIPTION1,HOUSEHOLD_KEY,INDIVIDUAL_KEY,NAME_FULL,MAILING_ADDRESS_1,MAILING_ADDRESS_2,' +
'MAILING_CITY,MAILING_STATE,MAILING_ZIP_CODE,PHONE,bdid,group_id,confidence_level,best_CompanyName,' +
'best_addr1,best_city,best_state,best_zip,best_zip4,best_phone,best_fein,contact_title,contact_title_rank,' +
'contact_fname,contact_mname,contact_lname,contact_name_suffix,contact_is_business_owner,' +
'SIC_Code1,SIC_Code2,SIC_Code3,Number_Of_Employees,Annual_Sales\n'),
separator('|'),
terminator('\n')));
