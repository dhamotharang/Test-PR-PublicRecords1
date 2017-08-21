layout_bbb_demographic_out := record
string12 bdid;
string6  bbb_id;
string60 company_name;
string100 address;
string12 country;
string14 phone;
string12 revenues := '';
string7  number_employees := '';
end;

bbb_dmg := dataset('~thor_data400::TMTEST::BBB_Demographics_Append', layout_bbb_demographic_out, flat);

output(bbb_dmg,,'TMTEST::BBB_Demographics_Append_Tab_Delimited', csv(
heading(
'bdid\tbbb_id\tcompany_name\taddress\tcountry\tphone\trevenues\tnumber_employees\t\n'),
separator('\t'),
terminator('\n')), overwrite);