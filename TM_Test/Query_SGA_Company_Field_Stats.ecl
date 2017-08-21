f := TM_Test.File_SGA_Company_In;


layout_sga_company_stat := record
integer4 total:= count(group);
integer4  MainCompanyID_cnt := count(group, f.MainCompanyID <> '');
integer4  CompanyName_cnt := count(group, f.CompanyName <> '');
integer4  Ticker_cnt := count(group, f.Ticker <> '');
integer4  FortuneRank_cnt := count(group, f.FortuneRank <> '');
integer4  PrimaryIndustry_cnt := count(group, f.PrimaryIndustry <> '');
integer4  Address1_cnt := count(group, f.Address1 <> '');
integer4  Address2_cnt := count(group, f.Address2 <> '');
integer4  City_cnt := count(group, f.City <> '');
integer4  State_cnt := count(group, f.State <> '');
integer4  Zip_Code_cnt := count(group, f.Zip_code <> '');
integer4  Country_cnt := count(group, f.Country <> '');
integer4  Region_cnt := count(group, f.Region <> '');
integer4  Phone_cnt := count(group, f.Phone <> '');
integer4  Extension_cnt := count(group, f.Extension <> '');
integer4  WebURL_cnt := count(group, f.WebURL <> '');
integer4  Sales_cnt := count(group, f.Sales <> '');
integer4  Employees_cnt := count(group, f.Employees <> '');
integer4  Competitors_cnt := count(group, f.Competitors <> '');
integer4  DivisionName_cnt := count(group, f.DivisionName <> '');
integer4  SICCode_cnt := count(group, f.SICCode <> '');
integer4  Auditor_cnt := count(group, f.Auditor <> '');
integer4  EntryDate_cnt := count(group, f.EntryDate <> '');
integer4  LastUpdate_cnt := count(group, f.LastUpdate <> '');
integer4  EntryStaffID_cnt := count(group, f.EntryStaffID <> '');
integer4  Description_cnt := count(group, f.Description <> '');
end;

fstat := table(f, layout_sga_company_stat, few);

output(fstat);