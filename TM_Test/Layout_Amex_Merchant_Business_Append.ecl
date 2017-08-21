export Layout_Amex_Merchant_Business_Append := record
TM_Test.Layout_Amex_Merchant_Base;
// Additional phone information
string1 input_phone_active := '';  // 'Y' - active, 'N' - not active, ' ' - don't know
string10 additional_phone2 := '';
string10 additional_phone3 := '';
string60 corp_org_type := '';
string1  corp_mkt_flag := 'N';   // 'Y' - corporate data is restricted by state
string4  SIC_Code1 := '';
string4  SIC_Code2 := '';
string4  SIC_Code3 := '';
end;

