f := TM_Test.File_SGA_Contact_In;


layout_sga_contact_stat := record
integer4 total:= count(group);
integer4 MainContactID_cnt := count(group, f.MainContactID <> '');
integer4 MainCompanyID_cnt := count(group, f.MainCompanyID  <> ''); 
integer4 Active_cnt := count(group, f.Active <> ''); 
integer4 FirstName_cnt := count(group, f.FirstName <> ''); 
integer4 MidInital_cnt := count(group, f.MidInital <> ''); 
integer4 LastName_cnt := count(group, f.LastName <> ''); 
integer4 Age_cnt := count(group, (integer)f.Age <> 0); 
integer4 Gender_cnt := count(group, f.Gender <> ''); 
integer4 PrimaryTitle_cnt := count(group, f.PrimaryTitle <> ''); 
integer4 TitleLevel1_cnt := count(group, (integer)f.TitleLevel1 <> 0); 
integer4 PrimaryDept_cnt := count(group, f.PrimaryDept <> ''); 
integer4 SecondTitle_cnt := count(group, f.SecondTitle <> ''); 
integer4 TitleLevel2_cnt := count(group, (integer)f.TitleLevel2 <> 0); 
integer4 SecondDept_cnt := count(group, f.SecondDept <> ''); 
integer4 ThirdTitle_cnt := count(group, f.ThirdTitle <> ''); 
integer4 TitleLevel3_cnt := count(group, (integer)f.TitleLevel3 <> 0); 
integer4 ThirdDept_cnt := count(group, f.ThirdDept <> ''); 
integer4 SkillCategory_cnt := count(group, f.SkillCategory <> ''); 
integer4 SkillSubCategory_cnt := count(group, f.SkillSubCategory <> ''); 
integer4 ReportTo_cnt := count(group, f.ReportTo <> ''); 
integer4 OfficePhone_cnt := count(group, f.OfficePhone <> ''); 
integer4 OfficeExt_cnt := count(group, f.OfficeExt <> ''); 
integer4 OfficeFax_cnt := count(group, f.OfficeFax <> '');    
integer4 OfficeEmail_cnt := count(group, f.OfficeEmail <> '');   
integer4 DirectDial_cnt := count(group, f.DirectDial <> ''); 
integer4 MobilePhone_cnt := count(group, f.MobilePhone <> ''); 
integer4 OfficeAddress1_cnt := count(group, f.OfficeAddress1 <> ''); 
integer4 OfficeAddress2_cnt := count(group, f.OfficeAddress2 <> ''); 
integer4 OfficeCity_cnt := count(group, f.OfficeCity <> ''); 
integer4 OfficeState_cnt := count(group, f.OfficeState <> ''); 
integer4 OfficeZip_cnt := count(group, f.OfficeZip <> ''); 
integer4 OfficeCountry_cnt := count(group, f.OfficeCountry <> ''); 
integer4 School_cnt := count(group, f.School <> ''); 
integer4 Degree_cnt := count(group, f.Degree <> ''); 
integer4 GraduationYear_cnt := count(group, (integer)f.GraduationYear <> 0); 
integer4 Country_cnt := count(group, f.Country <> ''); 
integer4 Salary_cnt := count(group, (integer)f.Salary <> 0); 
integer4 Bonus_cnt := count(group, (integer)f.Bonus <> 0); 
integer4 Compensation_cnt := count(group, (integer)f.Compensation <> 0); 
integer4 Citizenship_cnt := count(group, f.Citizenship <> ''); 
integer4 DiversityCandidate_cnt := count(group, f.DiversityCandidate <> ''); 
integer4 EntryDate_cnt := count(group, f.EntryDate <> ''); 
integer4 LastUpdate_cnt := count(group, f.LastUpdate <> ''); 
integer4 Biography_cnt := count(group, f.Biography <> ''); 
end;

fstat := table(f, layout_sga_contact_stat, few);

output(fstat);