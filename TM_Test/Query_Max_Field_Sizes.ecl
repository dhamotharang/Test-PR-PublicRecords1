f := TM_Test.File_Amex_iCLIC_Test_In;

layout_stat := record
unsigned1 maxsize_AXP_Vendor_Key := max(group, length(trim(f.AXP_Vendor_Key)));
unsigned1 maxsize_Company_Name := max(group, length(trim(f.Company_Name)));
unsigned1 maxsize_Address_1 := max(group, length(trim(f.Address_1)));
unsigned1 maxsize_Address_2 := max(group, length(trim(f.Address_2)));
unsigned1 maxsize_City := max(group, length(trim(f.City)));
unsigned1 maxsize_State := max(group, length(trim(f.State)));
unsigned1 maxsize_Zip := max(group, length(trim(f.Zip)));
unsigned1 maxsize_Phone := max(group, length(trim(f.Phone)));
unsigned1 maxsize_Country_Code := max(group, length(trim(f.Country_Code)));
unsigned1 maxsize_duns_number := max(group, length(trim(f.duns_number)));
unsigned1 maxsize_CEO_Name := max(group, length(trim(f.CEO_Name)));
end;

fstat := table(f, layout_stat, few);

output(fstat,all);

