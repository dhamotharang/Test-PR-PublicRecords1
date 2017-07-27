layout_abn_amro := record
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
end;

f := dataset('~thor_data400::in::abn_20050809', layout_abn_amro, CSV(HEADING(1),QUOTE('"')));

count(f);

output(enth(f,1000),all);
