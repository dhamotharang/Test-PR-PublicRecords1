export Layout_Amex_Merchant_Out := record
string8  rid;
string12 group_id;
string12 bdid;
string1  bdid_mkt_flag := 'N';
string12 did := '';
// original input data
string13 BIN := '';
string25 Business_Name := '';
string25 DBA := '';
string25 Address1 := '';
string25 Address2 := '';
string25 City := '';
string2  State := '';
string10 Zipcode := '';
string1  Status := '';
string8  Acctclass8 := '';
string3  Industry := '';
string12 Business_Phone := '';
string4  SIC := '';
string25 Correspondence_Address1 := '';
string25 Correspondence_Address2 := '';
string25 Correspondence_City := '';
string2 Correspondence_State := '';
string10 Correspondence_Zip := '';
// best company information
string10  best_phone := '';
string9   best_fein := '';
string120 best_CompanyName := '';
string120 best_addr1 := '';
string30	best_city := '';
string2	best_state := '';
string5	best_zip := '';
string4	best_zip4 := '';
// additional business information
string1 input_phone_active := '';  // 'Y' - active, 'N' - not active, ' ' - don't know
string10 additional_phone2 := '';
string10 additional_phone3 := '';
string60 corp_org_type := '';
string1  corp_mkt_flag := 'N';   // 'Y' - corporate data is restricted by state
string4  SIC_Code1 := '';
string4  SIC_Code2 := '';
string4  SIC_Code3 := '';
// employee information
string35  emp_company_title := '';  // Title of Employee at Company if available
string10  emp_phone := '';
string9   emp_ssn := '';
string8   emp_dob := '';
string20  emp_fname := '';
string20  emp_mname := '';
string20  emp_lname := '';
string120 emp_addr1 := '';
string25  emp_city_name := '';
string2   emp_st := '';
string5   emp_zip := '';
string4   emp_zip4 := '';
end;