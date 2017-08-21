f := dataset('~thor_data400::TMTEST::amex_iclic_test_fileb',TM_Test.Layout_Amex_iCLIC_Test_Base_Append, flat);

layout_slim := record
f.bdid;
f.SIC_Code1;
f.CEO_Name;
f.CEO_Title;
f.phone;
f.phone_type;
f.Type_Of_Business;
f.Number_Of_Employees;
f.Annual_Sales;
f.Executive_Name;
f.Executive_Title;
f.duns_flag;
end;

fslim := table(f, layout_slim);

layout_stat := record
cnt := count(group);
cnt_bdid := count(group, fslim.bdid<>0);
cnt_SIC_Code1 := count(group, fslim.bdid<>0 and fslim.SIC_Code1<>'');
cnt_CEO_Name := count(group, fslim.bdid<>0 and  fslim.CEO_Name <> '');
cnt_CEO_Title := count(group, fslim.bdid<>0 and  fslim.CEO_Name <> '' and fslim.CEO_Title <> '');
cnt_phone := count(group, fslim.bdid<>0 and  fslim.phone <> '');
cnt_phone_type := count(group, fslim.bdid<>0 and  fslim.phone <> ''and fslim.phone_type <> '');
cnt_Type_Of_Business := count(group, fslim.bdid<>0 and fslim.Type_Of_Business<>'');
cnt_Number_Of_Employees := count(group, fslim.bdid<>0 and fslim.Number_Of_Employees<>'');
cnt_Annual_Sales := count(group, fslim.bdid<>0 and fslim.Annual_Sales<>'');
cnt_Executive_Name := count(group, fslim.bdid<>0 and fslim.Executive_Name <>'');
cnt_Executive_Title := count(group, fslim.bdid<>0 and fslim.Executive_Title<>'');
cnt_duns_flag := count(group, fslim.bdid<>0 and fslim.duns_flag='Y');
end;

fstat := table(fslim, layout_stat, few);

output(fstat, all);

