dm2_in := TM_Test.File_DM2_In;

Layout_DM2_Test := record
string15  COID := dm2_in.datarec[1..15];
string30	Company_Name := dm2_in.datarec[16..45];
string30  Company_Mail_Stop := dm2_in.datarec[46..75];
string30  Company_Division := dm2_in.datarec[76..105];
string30  Company_Address := dm2_in.datarec[106..135];
string12  Company_PO_Box := dm2_in.datarec[136..147];
string13  Company_City := dm2_in.datarec[148..160];
string2   Company_State := dm2_in.datarec[161..162];
string10  Company_Zip := dm2_in.datarec[163..172];
string16  Phone := dm2_in.datarec[173..188];
string16  Fax := dm2_in.datarec[189..204];
string40  Email_Domain := dm2_in.datarec[205..244];
string1   lf := dm2_in.lf;
end;

dm2_data := table(dm2_in, Layout_DM2_Test);

layout_dm2_seq := record
unsigned4 rid;
unsigned4 seq := 0;
layout_dm2_test;
end;

f := dataset('TMTEST::dm2_seq', layout_dm2_seq, flat);

dm2_blank_address := project(f(Company_Address = '', Company_PO_Box = ''),
                             transform(TM_Test.Layout_DM2_Out, self := left));
					    
dm2_out_combined := TM_Test.dm2_out + dm2_blank_address;
dm2_out_sort := sort(dm2_out_combined, COID);

count(dm2_out_sort);
count(dm2_out_sort(Location_Phone <> ''));
count(dm2_out_sort(SIC <> ''));

output(enth(dm2_out_sort,200),all);
output(dm2_out_sort,,'OUT::DM2_Append',overwrite);

