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

layout_stat := record
unsigned1 maxsize_DESCRIPTION1 := max(group, length(trim(abn_amro_in.DESCRIPTION1)));
unsigned1 maxsize_HOUSEHOLD_KEY := max(group, length(trim(abn_amro_in.HOUSEHOLD_KEY)));
unsigned1 maxsize_INDIVIDUAL_KEY := max(group, length(trim(abn_amro_in.INDIVIDUAL_KEY)));
unsigned1 maxsize_NAME_FULL := max(group, length(trim(abn_amro_in.NAME_FULL)));
unsigned1 maxsize_MAILING_ADDRESS_1 := max(group, length(trim(abn_amro_in.MAILING_ADDRESS_1)));
unsigned1 maxsize_MAILING_ADDRESS_2 := max(group, length(trim(abn_amro_in.MAILING_ADDRESS_2)));
unsigned1 maxsize_MAILING_CITY := max(group, length(trim(abn_amro_in.MAILING_CITY)));
unsigned1 maxsize_MAILING_STATE := max(group, length(trim(abn_amro_in.MAILING_STATE)));
unsigned1 maxsize_MAILING_ZIP_CODE := max(group, length(trim(abn_amro_in.MAILING_ZIP_CODE)));
unsigned1 maxsize_PHONE := max(group, length(trim(abn_amro_in.PHONE)));
end;

fstat := table(abn_amro_in, layout_stat, few);

output(fstat,all);

