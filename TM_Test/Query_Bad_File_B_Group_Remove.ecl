layout_fileb_temp := record
unsigned4 seq;
unsigned6 group_id;
unsigned  bdid;
unsigned6 did;
string AXP_Vendor_Key;
string Company_Name;
string Address_1;
string Address_2;
string City;
string State;
string Zip;
string Phone;
string Country_Code;
string duns_number;
string CEO_Name;
// principal clean name
string5  title;
string20 fname;
string20 mname;
string20 lname;
string5  name_suffix;
string3  name_score;
// clean phones
string10  phone10;
// Best Company Information
string120 best_CompanyName;
string60 best_addr1;
string60 best_addr2;
string10 best_phone;
string9  best_fein;
// Additional Appended data
string20 phone_type := '';
string35 CEO_Title := '';
string60 Type_Of_Business := '';
string8  SIC_Code1 := '';
string8  SIC_Code2 := '';
string8  SIC_Code3 := '';
string9  Number_Of_Employees := '';
string12 Annual_Sales := '';
string60 Executive_Name := '';
string35 Executive_Title := '';
string1  duns_flag := '';
end;

f := dataset('TMTEST::amex_iclic_test_fileb_group', layout_fileb_temp, flat);

// Format output layout
TM_Test.Layout_Output_File_B_Group FormatOutput(layout_fileb_temp l) := transform
self.group_id := intformat(l.group_id, 12, 1);
self.bdid := intformat(l.bdid, 12, 1);
self.did := if(l.did <> 0, intformat(l.did, 12, 1), '');
self := l;
end;

bad_group_list := [
1390124,
1686781,
303892,
8088379,
65908767,
9887307,
774198,
25532547,
55536096,
24346194,
115906397,
46696393,
68876377];

amex_bdid_group_out := project(f(group_id not in bad_group_list), FormatOutput(left));
amex_bdid_group_out_sort := sort(amex_bdid_group_out, AXP_Vendor_Key, group_id, -Company_Name, bdid);


output(amex_bdid_group_out_sort,,'tmtest::amex_iclic_test_File_B_Group',overwrite);
output(amex_bdid_group_out_sort,all);


