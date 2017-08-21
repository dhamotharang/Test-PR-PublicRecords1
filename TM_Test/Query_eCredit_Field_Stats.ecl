// field population stats

fc := TM_Test.File_eCredit_Customer_Base;

layout_population_stats := record
Total_recs := count(group);
Non_Blank_Name := count(group, fc.Name <> '');
Non_Blank_Address1 := count(group, fc.Address1 <> '');
Non_Blank_Address2 := count(group, fc.Address2 <> '');
Non_Blank_City := count(group, fc.City <> '');
Non_Blank_Region := count(group, fc.Region <> '');
Non_Blank_Country := count(group, fc.Country <> '');
Non_Blank_PostalCode := count(group, fc.PostalCode <> '');
Non_Blank_PhoneNo := count(group, fc.PhoneNo <> '');
Non_Blank_FirstSaleDate := count(group, fc.FirstSaleDate <> '');
Non_Blank_LastSaleDate := count(group, fc.LastSaleDate <> '');
Non_Blank_Terms := count(group, fc.Terms <> '');
Non_Blank_CreditLimit := count(group, fc.CreditLimit <> '');
Non_Blank_HighBalance := count(group, fc.HighBalance <> '');
Non_Blank_AvgDaysToPay := count(group, fc.AvgDaysToPay <> '');
Non_Blank_WriteOffAmt := count(group, fc.WriteOffAmt <> '');
Non_Blank_LMTerms := count(group, fc.LMTerms <> '');
Non_Zero_BDID := count(group, fc.BDID <> 0);
Address_Clean_Success := count(group, fc.bus_err_stat[1] = 'S');
Address_Clean_Error := count(group, fc.bus_err_stat[1] = 'E');
Clean_Phone10 := count(group, fc.phone10 <> '');
end;

fc_population_stats := table(fc, layout_population_stats);

output(fc_population_stats);


