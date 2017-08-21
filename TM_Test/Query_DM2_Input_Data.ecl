f := TM_Test.File_DM2_In;


Layout_DM2_Test := record
string15  COID := f.datarec[1..15];
string30	Company_Name := f.datarec[16..45];
string30  Company_Mail_Stop := f.datarec[46..75];
string30  Company_Division := f.datarec[76..105];
string30  Company_Address := f.datarec[106..135];
string12  Company_PO_Box := f.datarec[136..147];
string13  Company_City := f.datarec[148..160];
string2   Company_State := f.datarec[161..162];
string10  Company_Zip := f.datarec[163..172];
string16  Phone := f.datarec[173..188];
string16  Fax := f.datarec[189..204];
string40  Email_Domain := f.datarec[205..244];
string1   lf := f.lf;
end;

dm2_data := table(f, Layout_DM2_Test);

count(dm2_data);
output(enth(dm2_data,200),all);
output(enth(dm2_data(Company_Mail_Stop <> ''),200),all);
output(enth(dm2_data(Company_Division <> ''),200),all);
