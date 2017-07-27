#workunit('name', 'Experian Header Stats ');

ehf := BusData.File_Experian_Header_In;

Layout_EHF_Slim := record
string38	Company_Name;
string50	Street_Address;
string13	City;
string2	State;
string5	Orig_Zip;
string4	Orig_Zip4;
string10	Phone;
string10	File_Establish_Date;
string4	SIC_1;
string4	SIC_2;
string4	SIC_3;
string4	SIC_4;
string20	Officer_Last_Name;
string20	Officer_First_Name;
string10	Officer_Middle_Initial;
string5	Officer_Generation;
string10	Officer_Title;
string9	Experian_File_Number;
string10	Most_Recent_Trade_Date;
string10	Demo_Update_Date;
string10	Most_Recent_Bankruptcy_Filing_Date;
string10	Most_Recent_Judgment_Filing_Date;
string10	Most_Recent_Tax_Lien_Filing_Date;
string10	Most_Recent_Collection_Reported_Date;
string10	Most_Recent_Bank_Reported_Date;
string10	Corporate_Record_Extract_Date;
string10	Most_Recent_Lease_Extract_Date;
string9	Tax_ID;
string3	Corporate_Record_Status;
string4	Inquiry_Count_Last_9_Months;
string4   err_stat;
end;

Layout_EHF_Slim InitEHF(BusData.Layout_Experian_Header_In l) := transform
self := l;
end;

ehf_init := project(ehf, InitEHF(left));

Layout_EHF_Stat := record
ehf_init.state;
integer4 Company_Name_Cnt := count(group, ehf_init.Company_Name <> '');
integer4 Street_Address_Cnt := count(group, ehf_init.Street_Address <> '');
integer4 City_Cnt := count(group, ehf_init.City <> '');
integer4 State_Cnt := count(group, ehf_init.State <> '');
integer4 Orig_Zip_Cnt := count(group, ehf_init.Orig_Zip <> '');
integer4 Orig_Zip4_Cnt := count(group, ehf_init.Orig_Zip4 <> '');
integer4 Phone_Cnt := count(group, ehf_init.Phone <> '');
integer4 File_Establish_Date_Cnt := count(group, ehf_init.File_Establish_Date <> '');
integer4 SIC_1_Cnt := count(group, ehf_init.SIC_1 <> '');
integer4 SIC_2_Cnt := count(group, ehf_init.SIC_2 <> '');
integer4 SIC_3_Cnt := count(group, ehf_init.SIC_3 <> '');
integer4 SIC_4_Cnt := count(group, ehf_init.SIC_4 <> '');
integer4 Officer_Last_Name_Cnt := count(group, ehf_init.Officer_Last_Name <> '');
integer4 Officer_First_Name_Cnt := count(group, ehf_init.Officer_First_Name <> '');
integer4 Officer_Middle_Initial_Cnt := count(group, ehf_init.Officer_Middle_Initial <> '');
integer4 Officer_Generation_Cnt := count(group, ehf_init.Officer_Generation <> '');
integer4 Officer_Title_Cnt := count(group, ehf_init.Officer_Title <> '');
integer4 Experian_File_Number_Cnt := count(group, ehf_init.Experian_File_Number <> '');
integer4 Most_Recent_Trade_Date_Cnt := count(group, ehf_init.Most_Recent_Trade_Date <> '');
integer4 Demo_Update_Date_Cnt := count(group, ehf_init.Demo_Update_Date <> '');
integer4 Most_Recent_Bankruptcy_Filing_Date_Cnt := count(group, ehf_init.Most_Recent_Bankruptcy_Filing_Date <> '');
integer4 Most_Recent_Judgment_Filing_Date_Cnt := count(group, ehf_init.Most_Recent_Judgment_Filing_Date <> '');
integer4 Most_Recent_Tax_Lien_Filing_Date_Cnt := count(group, ehf_init.Most_Recent_Tax_Lien_Filing_Date <> '');
integer4 Most_Recent_Collection_Reported_Date_Cnt := count(group, ehf_init.Most_Recent_Collection_Reported_Date <> '');
integer4 Most_Recent_Bank_Reported_Date_Cnt := count(group, ehf_init.Most_Recent_Bank_Reported_Date <> '');
integer4 Corporate_Record_Extract_Date_Cnt := count(group, ehf_init.Corporate_Record_Extract_Date <> '');
integer4 Most_Recent_Lease_Extract_Date_Cnt := count(group, ehf_init.Most_Recent_Lease_Extract_Date <> '');
integer4 Tax_ID_Cnt := count(group, ehf_init.Tax_ID <> '');
integer4 Corporate_Record_Status_Cnt := count(group, ehf_init.Corporate_Record_Status <> '');
integer4 Inquiry_Count_Last_9_Months_Cnt := count(group, ehf_init.Inquiry_Count_Last_9_Months <> '');

// clean address error stats
integer4 err_stat_S := count(group, ehf_init.err_stat[1] = 'S');
integer4 err_stat_E := count(group, ehf_init.err_stat[1] = 'E');
integer4 err_stat_U := count(group, ehf_init.err_stat[1] = 'U');
integer4 err_stat_other := count(group, ehf_init.err_stat[1] not in ['S','E','U']);

integer4 total:= count(group);
end;

ehf_stat := table(ehf_init, Layout_EHF_Stat, state, few);

output(ehf_stat);