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

#option('outputLimit', 100);

layout_abn_amro_out := record
string6  seq;
string12 did;
string1  DESCRIPTION1;
string8  HOUSEHOLD_KEY;
string8  INDIVIDUAL_KEY;
string35 NAME_FULL;
string35 MAILING_ADDRESS_1;
string35 MAILING_ADDRESS_2;
string20 MAILING_CITY;
string2  MAILING_STATE;
string9  MAILING_ZIP_CODE;
string12 PHONE;
string12 bdid;
string12 group_id;
string1  confidence_level;
string120 best_CompanyName;
string120 best_addr1;
string30	best_city;
string2	best_state;
string5	best_zip;
string4	best_zip4;
string10  best_phone;
string9   best_fein;
string35 contact_title;
string3  contact_title_rank;
string20 contact_fname;
string20 contact_mname;
string20 contact_lname;
string5  contact_name_suffix;
string   contact_is_business_owner;
string4  SIC_Code1;
string4  SIC_Code2;
string4  SIC_Code3;
string9  Number_Of_Employees;
string12 Annual_Sales;
end;

layout_abn_amro_out FormatFixed(abn_amro_in l) := transform
self.seq := intformat((integer)l.seq, 6, 1);
self.did := if((integer)l.did <> 0, intformat((integer)l.did, 12, 1), '');
self.bdid := if((integer)l.bdid <> 0, intformat((integer)l.bdid, 12, 1), '');
self.group_id := if((integer)l.group_id <> 0, intformat((integer)l.group_id, 12, 1), '');
self.contact_title_rank := intformat((integer)l.contact_title_rank, 3, 1);
self := l;
end;

abn_amro_out := project(abn_amro_in, FormatFixed(left));

output(abn_amro_out,,'TMTEST::ABN_AMRO_C2BTest_Out_Fixed', overwrite);

output(choosen(abn_amro_out,5000),all);
