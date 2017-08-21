export Layout_ABN_AMRO_C2BTest_Out := record
unsigned4 seq;
unsigned6 did;
Layout_ABN_AMRO_C2BTest_In;
// Associated Business and name info
unsigned6 bdid;
unsigned6 group_id;
unsigned1 confidence_level;
string120 best_CompanyName;
string120 best_addr1;
string30	best_city;
string2	best_state;
string5	best_zip;
string4	best_zip4;
string10  best_phone;
string9   best_fein;
string35 contact_title;   // Title of Contact at Company if available
unsigned1 contact_title_rank;
string20 contact_fname;
string20 contact_mname;
string20 contact_lname;
string5  contact_name_suffix;
string1  contact_is_business_owner;  //'Y' or 'N'
// Associated Business Demographic Data
string4  SIC_Code1;
string4  SIC_Code2;
string4  SIC_Code3;
string9  Number_Of_Employees;
string12 Annual_Sales;
end;