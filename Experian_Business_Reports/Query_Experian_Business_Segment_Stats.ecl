#workunit('name', 'Experian Business Segment Stats');

f := Experian_Business_Reports.File_All_Segments_In;

layout_slim := record
f.segment_code;
end;

fslim := table(f, layout_slim);

layout_stat := record
cnt_0010_Heading := count(group, (integer)fslim.segment_code = 0010);
cnt_1000_Executive_Summary := count(group, (integer)fslim.segment_code = 1000);
cnt_2000_Trade_Data := count(group, (integer)fslim.segment_code = 2000);
cnt_2010_Additional_Trade_Data := count(group, (integer)fslim.segment_code = 2010);
cnt_2015_Trade_Payment_Totals := count(group, (integer)fslim.segment_code = 2015);
cnt_2020_Trade_Payment_Trends := count(group, (integer)fslim.segment_code = 2020);
cnt_2025_Trade_Quarterly_Averages := count(group, (integer)fslim.segment_code = 2025);
cnt_4010_Bankruptcy := count(group, (integer)fslim.segment_code = 4010);
cnt_4020_Tax_Liens := count(group, (integer)fslim.segment_code = 4020);
cnt_4030_Judgment := count(group, (integer)fslim.segment_code = 4030);
cnt_4035_Attachment_Lien := count(group, (integer)fslim.segment_code = 4035);
cnt_4500_Collection_Accounts := count(group, (integer)fslim.segment_code = 4500);
cnt_4510_UCC_Filings := count(group, (integer)fslim.segment_code = 4510);
cnt_5000_Bank_Details := count(group, (integer)fslim.segment_code = 5000);
cnt_5600_Demographic_Data := count(group, (integer)fslim.segment_code = 5600);
cnt_5610_Additional_Demographic_Data := count(group, (integer)fslim.segment_code = 5610);
cnt_6000_Inquiries := count(group, (integer)fslim.segment_code = 6000);
cnt_6500_Government := count(group, (integer)fslim.segment_code = 6500);
cnt_7000_S_and_P_Parent_Name_Address := count(group, (integer)fslim.segment_code = 7000);
cnt_7010_S_and_P_Data := count(group, (integer)fslim.segment_code = 7010);
end;

fstat := table(fslim, layout_stat);

output(fstat);

