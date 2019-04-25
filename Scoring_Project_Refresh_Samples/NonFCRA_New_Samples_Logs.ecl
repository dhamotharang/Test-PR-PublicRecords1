
IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT, Scoring_Project_Macros, Scoring_Project_Refresh_Samples, zz_Koubsky_SALT, SALT23;

EXPORT NonFCRA_New_Samples_Logs := module
shared eyeball := 100;

shared Scoring_Project_Refresh_Samples.New_Samples_layouts.output_structure Rearrange(Scoring_Project_Refresh_Samples.New_Samples_layouts.output_structure l, integer c) := TRANSFORM
	self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  	
	self.zip := l.zip[1..5];
	self.homephone := if(l.homephone[1] = '0', '', l.homephone);
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self := l;
  self := [];
END;


shared Scoring_Project_Refresh_Samples.New_Samples_layouts.output_structureBNK4 RearrangeBNK4(Scoring_Project_Refresh_Samples.New_Samples_layouts.output_structureBNK4 l, integer c) := TRANSFORM
	self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  	
	self.zip := l.zip[1..5];
	self.homephone := if(l.homephone[1] = '0', '', l.homephone);
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self := l;
  self := [];
END;

//***************************************************************************************************************


// ***************************************************************************************************************
EXPORT NonFCRA_New_Samples_Logs_FPv2_2 (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.FraudAdvisor_Layout) FPv2_AmericanExpress_model, dataset(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure) OriginalDatafpv2_2, string Fileoutfpv2_2) := FUNCTION 

FindMaxAccounFPv2 := choosen(sort(OriginalDatafpv2_2, -accountnumber), 5);
MaxAccounFPv2 := max(FindMaxAccounFPv2, accountnumber);

filteredSSN := FPv2_AmericanExpress_model(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzip := filteredSSN(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));


goodinfoFPv2 := filteredzip(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and address	 != '' and city != ''
											and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '000000001' and ssn != '00000' and dob != '' and homephone <> '9999999999' and homephone <> '7777777777' );
											

keepers0FPv2 := OriginalDatafpv2_2(perm_flag = 0);
keepers1FPv2 := OriginalDatafpv2_2(perm_flag = 1);
keepers2FPv2 := OriginalDatafpv2_2(perm_flag = 2);
keepers3FPv2 := OriginalDatafpv2_2(perm_flag = 3);
keepers4FPv2 := OriginalDatafpv2_2(perm_flag = 4);

keepersFPv2 := sort(keepers0FPv2+keepers2FPv2+keepers3FPv2+keepers4FPv2, accountnumber);

Reflagged_LogsFPv2 := project(keepersFPv2, Rearrange(left, counter));

DedupedDataFPv2 := dedup(goodinfoFPv2, SSN, lastname, firstname, Address, zip, all); //sorted by ssn since all blank ssn's have been removed;


Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure format_themFPv2(Scoring_Project_Refresh_Samples.New_Samples_layouts.FraudAdvisor_Layout l, integer c) := Transform
	self.Date_added := STD.DATE.TODAY();	
	self.streetaddress := l.Address;
	self.customer := 'FPv2_American_Express';
	self.source_info := 'acclogs_scoring';
	self.dateofbirth := l.dob;
	self.Perm_Flag := 4;
	//self.AccountNumber := c + (integer)MaxAccounFPv2;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;


Formatted_NewFPv2 := project(DedupedDataFPv2, format_themFPv2(left, counter));

New_rightFPv2 := join(Reflagged_LogsFPv2, Formatted_NewFPv2,  left.ssn = right.ssn
		/*not sure if */		and left.streetaddress = right.streetaddress
		/*this will work*/	and left.zip = right.zip
												and left.firstname = right.firstname
												and left.lastname = right.lastname, right only);  //dataset with ssn's that are not in the old dataset;

new_large_sampleFPv2 := Reflagged_LogsFPv2 + New_rightFPv2; //add "new_right" to old dataset;

sort_large_sampleFPv2 := Sort(new_large_sampleFPv2, ssn, Date_added); //sort by date added for dedup

//deduped_newFPv2 := sort_large_sampleFPv2(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
//dedupoldFPv2:= sort_large_sampleFPv2(Date_added <> (Integer)ut.getdate);

deduped_newFPv2 := sort_large_sampleFPv2(Date_added = STD.DATE.TODAY());  //seperates new and old records by date;
dedupoldFPv2:= sort_large_sampleFPv2(Date_added <> STD.DATE.TODAY());



ut.MAC_Pick_Random(deduped_newFPv2,New_5000FPv2,5000);   //grabs 5000 of new deduped rocrods;
//output(New_5000FPv2, named('New_5000FPv2'));
// Transform to add account number after grabbing the 5000 new records. (12-13-2016)

Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure add_acctFPv2(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccounFPv2;
	self:= le;
	self:= [];
End;

Formatted_acct_NewFPv2 := project(New_5000FPv2, add_acctFPv2(left, counter));

New_Test_SampleFPv2 := dedupoldFPv2 + Formatted_acct_NewFPv2 ; //adds back to old file;


Sorted_SampleFPv2 := Sort(New_Test_SampleFPv2, perm_flag, date_added);

finalFPv2 := OUTPUT(choosen(Sorted_SampleFPv2, 25000),,Fileoutfpv2_2, thor, overwrite);

finalFPv2_salt := choosen(Sorted_SampleFPv2, 25000);

zz_Koubsky_SALT.mac_profile(finalFPv2_salt);

return finalFPv2;

end; 

// ******************************************************************************************************************
 EXPORT NonFCRA_New_Samples_Logs_FPv3 (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.FraudAdvisor_Layout) FPv3,dataset(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure)OriginalDatafpv3, String Fileoutfpv3) := FUNCTION 

FindMaxAccountFPv3 := choosen(sort(OriginalDatafpv3, -accountnumber), 5);
MaxAccountFPv3 := max(FindMaxAccountFPv3, accountnumber);

filteredSSNFPv3 := FPv3(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzipFPv3 := filteredSSNFPv3(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));

goodinfoFPv3 := filteredzipFPv3(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											 and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != '' and dob != '10101' and (homephone != '' or workphone != ''));

keepers0FPv3 := OriginalDataFPv3(perm_flag = 0);
keepers1FPv3 := OriginalDataFPv3(perm_flag = 1);
keepers2FPv3 := OriginalDataFPv3(perm_flag = 2);
keepers3FPv3 := OriginalDataFPv3(perm_flag = 3);
keepers4FPv3 := OriginalDatafpv3(perm_flag = 4);

keepersFPv3 := sort(keepers0FPv3+keepers2FPv3+keepers3FPv3+keepers4FPv3, accountnumber);

Reflagged_LogsFPv3 := project(keepersFPv3, Rearrange(left, counter));

DedupedDataFPv3 := dedup(goodinfoFPv3, SSN, all); //sorted by ssn since all blank ssn's have been removed;


Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure format_themFPv3(Scoring_Project_Refresh_Samples.New_Samples_layouts.FraudAdvisor_Layout l, integer c) := Transform
	self.Date_added := Std.Date.Today();
	self.streetaddress := l.Address;
	self.customer := 'FraudPoint_3_XML_Logs_1051212';
	self.source_info := 'acclogs_scoring';
	self.dateofbirth := l.dob;
	self.Perm_Flag := 4;
	// self.AccountNumber := c + (integer)MaxAccountFPv3;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;


Formatted_NewFPv3 := project(DedupedDataFPv3, format_themFPv3(left, counter));

New_rightFPv3 := join(Reflagged_LogsFPv3, Formatted_NewFPv3,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;

new_large_sampleFPv3 := Reflagged_LogsFPv3 + New_rightFPv3; //add "new_right" to old dataset;

sort_large_sampleFPv3 := Sort(new_large_sampleFPv3, ssn, Date_added); //sort by date added for dedup

deduped_newFPv3 := sort_large_sampleFPv3(Date_added = Std.Date.Today());  //seperates new and old records by date;
dedupoldFPv3:= sort_large_sampleFPv3(Date_added <> Std.Date.Today());


ut.MAC_Pick_Random(deduped_newFPv3,New_5000FPv3,2000);   //grabs 5000 of new deduped rocrods;
//output(New_5000FPv3, named('New_5000FPv3'));

// Transform to add account number after grabbing the 5000 new records. (12-13-2016)
Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure add_acctFPv3(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccountFPv3;
	self:= le;
	self:= [];
End;

Formatted_acct_NewFPv3 := project(New_5000FPv3, add_acctFPv3(left, counter));


New_Test_SampleFPv3 := dedupoldFPv3 + Formatted_acct_NewFPv3 ; //adds back to old file;


Sorted_SampleFPv3 := Sort(New_Test_SampleFPv3, perm_flag, date_added);

finalFPv3 := OUTPUT(choosen(Sorted_SampleFPv3, 10000),,FileoutFPv3, thor, overwrite);
// finalFPv3 := OUTPUT(choosen(Sorted_SampleFPv3, 10000));

finalFPv3_salt := choosen(Sorted_SampleFPv3, 10000);

zz_Koubsky_SALT.mac_profile(finalFPv3_salt);

return finalFPv3;


end;

// ************************************************************************************************************************************************************************************************************************

EXPORT NonFCRA_New_Samples_Logs_LI_v4 (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.LeadIntegrity_Layout) LI_v4, dataset(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure) OriginalDataLI_v4, string FileoutLI_v4) := FUNCTION 

FindMaxAccountLI_v4 := choosen(sort(OriginalDataLI_v4, -accountnumber), 5);
MaxAccounLI_v4 := max(FindMaxAccountLI_v4, accountnumber);

filteredSSNLI_v4 := LI_v4(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzipLI_v4 := filteredSSNLI_v4(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));

goodinfoLI_v4 := filteredzipLI_v4(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											and state != '' and zip != '' and zip != '00000' and ssn != '' and ssn != '000000000' and ssn != '0000' );
											
DedupedDataLI_v4 := dedup(goodinfoLI_v4, SSN, all); //sorted by ssn since all blank ssn's have been removed;

keepers0LI_v4 := OriginalDataLI_v4(perm_flag = 0);
keepers1LI_v4 := OriginalDataLI_v4(perm_flag = 1);
keepers2LI_v4 := OriginalDataLI_v4(perm_flag = 2);
keepers3LI_v4 := OriginalDataLI_v4(perm_flag = 3);
keepers4LI_v4 := OriginalDataLI_v4(perm_flag = 4);

keepersLI_v4 := sort(keepers0LI_v4+keepers2LI_v4+keepers3LI_v4+keepers4LI_v4, accountnumber);

Reflagged_LogsLI_v4 := project(keepersLI_v4, Rearrange(left, counter));

Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure format_themLI_v4(Scoring_Project_Refresh_Samples.New_Samples_layouts.LeadIntegrity_Layout l, integer c) := Transform
	self.Date_added := Std.Date.Today();
	self.streetaddress := l.Address;
	self.customer := 'Generic';
	self.source_info := 'acclogs_scoring';
	self.dateofbirth := l.dob;
	self.Perm_Flag := 4;
	//self.AccountNumber := c + (integer)MaxAccounLI_v4;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;

Formatted_NewLI_v4 := project(DedupedDataLI_v4, format_themLI_v4(left, counter));

New_rightLI_v4 := join(Reflagged_LogsLI_v4, Formatted_NewLI_v4,  left.ssn = right.ssn
		/*not sure if */		and left.streetaddress = right.streetaddress
		/*this will work*/	and left.zip = right.zip
												and left.firstname = right.firstname
												and left.lastname = right.lastname, right only);  //dataset with ssn's that are not in the old dataset;
new_large_sampleLI_v4 := Reflagged_LogsLI_v4 + New_rightLI_v4; //add "new_right" to old dataset;

sort_large_sampleLI_v4 := Sort(new_large_sampleLI_v4, ssn, Date_added); //sort by date added for dedup

//deduped_newLI_v4 := sort_large_sampleLI_v4(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
//dedupoldLI_v4:= sort_large_sampleLI_v4(Date_added <> (Integer)ut.getdate);

deduped_newLI_v4 := sort_large_sampleLI_v4(Date_added = Std.Date.Today());  //seperates new and old records by date;
dedupoldLI_v4:= sort_large_sampleLI_v4(Date_added <> Std.Date.Today());

ut.MAC_Pick_Random(deduped_newLI_v4,New_5000LI_v4,5000);   //grabs 5000 of new deduped rocrods;
// Transform to add account number after grabbing the 5000 new records. (12-13-2016)

Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure add_acctLI_v4(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccounLI_v4;
	self:= le;
	self:= [];
End;

Formatted_acct_NewLI_v4 := project(New_5000LI_v4, add_acctLI_v4(left, counter));

New_Test_SampleLI_v4 := dedupoldLI_v4 + Formatted_acct_NewLI_v4 ; //adds back to old file;

Sorted_SampleLI_v4 := Sort(New_Test_SampleLI_v4, perm_flag, date_added);
//finalLI_v4 := output(choosen(Sorted_SampleLI_v4, all));

 finalLI_v4 :=  OUTPUT(choosen(Sorted_SampleLI_v4, 25000),,FileoutLI_v4, thor, overwrite);	


finalLI_v4_salt := choosen(Sorted_SampleLI_v4, 25000);

zz_Koubsky_SALT.mac_profile(finalLI_v4_salt);

return finalLI_v4;
end;

// ************************************************************************************************************************************************************************************************************************

EXPORT NonFCRA_New_Samples_Logs_BNk4 (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.BNK4_CBBL_Layout) BNK4, dataset(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4) OriginalDataBNK4, string NewFileBNK4) := FUNCTION 

FindMaxAccountBNK4 := choosen(sort(OriginalDataBNK4, -accountnumber), 5);
MaxAccounBNK4 := max(FindMaxAccountBNK4, accountnumber);

filteredSSNBNK4 := BNK4(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzipBNK4 := filteredSSNBNK4(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));

goodinfoBNK4 := filteredzipBNK4(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											and state != '' and zip != '' and zip != '00000' and ssn!= '999999999' and ssn != '' and ssn != '000000000' and ssn != '0000' );
											
DedupedDataBNK4 := dedup(goodinfoBNK4, SSN,  all); //sorted by ssn since all blank ssn's have been removed;

keepers0BNK4 := OriginalDataBNK4(perm_flag = 0);
keepers1BNK4 := OriginalDataBNK4(perm_flag = 1);
keepers2BNK4 := OriginalDataBNK4(perm_flag = 2);
keepers3BNK4 := OriginalDataBNK4(perm_flag = 3);
keepers4BNK4 := OriginalDataBNK4(perm_flag = 4);

keepersBNK4 := sort(keepers0BNK4+keepers2BNK4+keepers3BNK4+keepers4BNK4, accountnumber);

Reflagged_LogsBNK4 := project(keepersBNK4, RearrangeBNK4(left, counter));

Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4 format_themBNK4(Scoring_Project_Refresh_Samples.New_Samples_layouts.BNK4_CBBL_Layout l, integer c) := Transform
	self.Date_added := Std.Date.Today();
	self.streetaddress := l.Address;
	self.customer := 'Chase';
	self.source_info := 'acclogs_scoring';
	self.dateofbirth := l.DateOfBirth;
	self.homephone := l.homephone;
	self.name_company	:= l.companyname;
	self.street_addr2 := l.companyaddress;
	self.p_city_name_2 := l.companycity;
  self.st_2	 := l.companystate;
	self.z5_2	:= l.companyzip;
	self.fein  := l.fein;
	self.drm	:= l.datarestrictionmask;
	self.Perm_Flag := 4;
	//self.AccountNumber := c + (integer)MaxAccounBNK4;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;

Formatted_NewBNK4 := project(DedupedDataBNK4, format_themBNK4(left, counter));

New_rightBNK4 := join(Reflagged_LogsBNK4, Formatted_NewBNK4,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
new_large_sampleBNK4 := Reflagged_LogsBNK4 + New_rightBNK4; //add "new_right" to old dataset;

sort_large_sampleBNK4 := Sort(new_large_sampleBNK4, ssn, Date_added); //sort by date added for dedup

//deduped_newBNK4 := sort_large_sampleBNK4(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
//dedupoldBNK4:= sort_large_sampleBNK4(Date_added <> (Integer)ut.getdate);

deduped_newBNK4 := sort_large_sampleBNK4(Date_added = Std.Date.Today());  //seperates new and old records by date;
dedupoldBNK4:= sort_large_sampleBNK4(Date_added <> Std.Date.Today());

ut.MAC_Pick_Random(deduped_newBNK4,New_5000BNK4,5000);   //grabs 5000 of new deduped rocrods;

// Transform to add account number after grabbing the 5000 new records. (12-13-2016)
Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4 add_acctBNK4(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4 le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccounBNK4;
	self:= le;
	self:= [];
End;

Formatted_acct_NewBNK4 := project(New_5000BNK4, add_acctBNK4(left, counter));

New_Test_SampleBNK4 := dedupoldBNK4 + Formatted_acct_NewBNK4 ; //adds back to old file;

Sorted_SampleBNK4 := Sort(New_Test_SampleBNK4, perm_flag, date_added);
//finalBNK4 := output(choosen(Sorted_SampleBNK4, all));

 finalBNK4 := OUTPUT(choosen(Sorted_SampleBNK4, 25000),,NewFileBNK4, thor, overwrite);	
finalBNK4_salt := choosen(Sorted_SampleBNK4, 25000);

zz_Koubsky_SALT.mac_profile(finalBNK4_salt);
return finalBNK4;
end;

// ************************************************************************************************************************************************************************************************************************
//cbbl
EXPORT NonFCRA_New_Samples_Logs_cbbl (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.BNK4_CBBL_Layout) CBBL_2, dataset(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4) OriginalDatacbbl, string NewFilecbbl) := FUNCTION 

FindMaxAccountcbbl := choosen(sort(OriginalDatacbbl, -accountnumber), 5);
MaxAccouncbbl := max(FindMaxAccountcbbl, accountnumber);

filteredSSNcbbl := cbbl_2(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzipcbbl := filteredSSNcbbl(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));

goodinfocbbl := filteredzipcbbl(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											and state != '' and zip != '' and zip != '00000' and ssn!= '999999999' and ssn != '' and ssn != '000000000' and ssn != '0000' );
											
DedupedDatacbbl := dedup(goodinfocbbl, SSN,  all); //sorted by ssn since all blank ssn's have been removed;

keepers0cbbl := OriginalDatacbbl(perm_flag = 0);
keepers1cbbl := OriginalDatacbbl(perm_flag = 1);
keepers2cbbl := OriginalDatacbbl(perm_flag = 2);
keepers3cbbl := OriginalDatacbbl(perm_flag = 3);
keepers4cbbl := OriginalDatacbbl(perm_flag = 4);

keeperscbbl := sort(keepers0cbbl+keepers2cbbl+keepers3cbbl+keepers4cbbl, accountnumber);

Reflagged_Logscbbl := project(keeperscbbl, RearrangeBNK4(left, counter));

Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4 format_themcbbl(Scoring_Project_Refresh_Samples.New_Samples_layouts.BNK4_CBBL_Layout l, integer c) := Transform
	self.Date_added := Std.Date.Today();
	self.streetaddress := l.Address;
	self.customer := 'Chase';
	self.source_info := 'acclogs_scoring';
	self.dateofbirth := l.DateOfBirth;
	self.homephone := l.homephone;
	self.name_company	:= l.companyname;
	self.street_addr2 := l.companyaddress;
	self.p_city_name_2 := l.companycity;
  self.st_2	 := l.companystate;
	self.z5_2	:= l.companyzip;
	self.fein  := l.fein;
	self.drm	:= l.datarestrictionmask;
	self.Perm_Flag := 4;
	//self.AccountNumber := c + (integer)MaxAccounBNK4;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;

Formatted_Newcbbl := project(DedupedDatacbbl, format_themcbbl(left, counter));

New_rightcbbl := join(Reflagged_Logscbbl, Formatted_Newcbbl,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
new_large_samplecbbl := Reflagged_Logscbbl + New_rightcbbl; //add "new_right" to old dataset;

sort_large_samplecbbl := Sort(new_large_samplecbbl, ssn, Date_added); //sort by date added for dedup

//deduped_newBNK4 := sort_large_sampleBNK4(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
//dedupoldBNK4:= sort_large_sampleBNK4(Date_added <> (Integer)ut.getdate);

deduped_newcbbl := sort_large_samplecbbl(Date_added = Std.Date.Today());  //seperates new and old records by date;
dedupoldcbbl:= sort_large_samplecbbl(Date_added <> Std.Date.Today());

ut.MAC_Pick_Random(deduped_newcbbl,New_5000cbbl,5000);   //grabs 5000 of new deduped rocrods;

// Transform to add account number after grabbing the 5000 new records. (12-13-2016)
Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4 add_acctcbbl(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4 le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccouncbbl;
	self:= le;
	self:= [];
End;

Formatted_acct_Newcbbl := project(New_5000cbbl, add_acctcbbl(left, counter));

New_Test_Samplecbbl := dedupoldcbbl + Formatted_acct_Newcbbl ; //adds back to old file;

Sorted_Samplecbbl := Sort(New_Test_Samplecbbl, perm_flag, date_added);
//finalBNK4 := output(choosen(Sorted_SampleBNK4, all));

 finalcbbl := OUTPUT(choosen(Sorted_Samplecbbl, 25000),,NewFilecbbl, thor, overwrite);	
finalcbbl_salt := choosen(Sorted_Samplecbbl, 25000);

zz_Koubsky_SALT.mac_profile(finalcbbl_salt);
return finalcbbl;
end;

// ************************************************************************************************************************************************************************************************************************




export NonFCRA_New_Samples_Logs_PI02(DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.PI02_layout) PI02, dataset(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure) OriginalDataPI02, string FileoutPI02) := FUNCTION 

FindMaxAccountPI02 := choosen(sort(OriginalDataPI02, -accountnumber), 5);
MaxAccounPI02 := max(FindMaxAccountPI02, accountnumber);

filteredSSNPI02 := PI02(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzipPI02 := filteredSSNPI02(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));

goodinfoPI02 := filteredzipPI02(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											and state != '' and zip != '' and zip != '00000' and ssn!= '999999999' and ssn != '' and ssn != '000000000' and ssn != '0000' );
											
DedupedDataPI02 := dedup(goodinfoPI02, SSN,  all); //sorted by ssn since all blank ssn's have been removed;

keepers0PI02 := OriginalDataPI02(perm_flag = 0);
keepers1PI02 := OriginalDataPI02(perm_flag = 1);
keepers2PI02 := OriginalDataPI02(perm_flag = 2);
keepers3PI02 := OriginalDataPI02(perm_flag = 3);
keepers4PI02 := OriginalDataPI02(perm_flag = 4);

keepersPI02 := sort(keepers0PI02+keepers2PI02+keepers3PI02+keepers4PI02, accountnumber);

Reflagged_LogsPI02 := project(keepersPI02, Rearrange(left, counter));

Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure format_themPI02(Scoring_Project_Refresh_Samples.New_Samples_layouts.PI02_layout l, integer c) := Transform
	self.Date_added := STD.DATE.TODAY();
	self.streetaddress := l.Address;
	self.customer := 'Chase';
	self.source_info := 'acclogs_scoring';
	self.dateofbirth := l.DateOfBirth;
	self.Perm_Flag := 4;
	self.AccountNumber := c + (integer)MaxAccounPI02;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;

Formatted_NewPI02 := project(DedupedDataPI02, format_themPI02(left, counter));

New_rightPI02 := join(Reflagged_LogsPI02, Formatted_NewPI02,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
new_large_samplePI02 := Reflagged_LogsPI02 + New_rightPI02; //add "new_right" to old dataset;

sort_large_samplePI02 := Sort(new_large_samplePI02, ssn, Date_added); //sort by date added for dedup

//deduped_newPI02 := sort_large_samplePI02(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
//dedupoldPI02:= sort_large_samplePI02(Date_added <> (Integer)ut.getdate);

deduped_newPI02 := sort_large_samplePI02(Date_added = STD.DATE.TODAY());  //seperates new and old records by date;
dedupoldPI02:= sort_large_samplePI02(Date_added <> STD.DATE.TODAY());
ut.MAC_Pick_Random(deduped_newPI02,New_5000PI02,5000);   //grabs 5000 of new deduped rocrods;

// Transform to add account number after grabbing the 5000 new records. (12-13-2016)
Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure add_acctPI02(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccounPI02;
	self:= le;
	self:= [];
End;

Formatted_acct_NewPI02 := project(New_5000PI02, add_acctPI02(left, counter));

New_Test_SamplePI02 := dedupoldPI02 + Formatted_acct_NewPI02 ; //adds back to old file;



New_Test_SamplePI02keepers0PI02 := New_Test_SamplePI02(perm_flag = 0);
New_Test_SamplePI02keepers1PI02 := New_Test_SamplePI02(perm_flag = 1);
New_Test_SamplePI02keepers2PI02 := New_Test_SamplePI02(perm_flag = 2);
New_Test_SamplePI02keepers3PI02 := New_Test_SamplePI02(perm_flag = 3);
New_Test_SamplePI02keepers4PI02 := New_Test_SamplePI02(perm_flag = 4);

Sorted_SamplePI02 := Sort(New_Test_SamplePI02, perm_flag, date_added);
//finalPI02 := output(choosen(Sorted_SamplePI02, all));

 finalPI02 := OUTPUT(choosen(Sorted_SamplePI02, 25000),,FileoutPI02, thor, overwrite);	
finalPI02_salt := choosen(Sorted_SamplePI02, 25000);

zz_Koubsky_SALT.mac_profile(finalPI02_salt);
return finalPI02;
end;

// ************************************************************************************************************************************************************************************************************************

export NonFCRA_New_Samples_Logs_BIID(DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.BusinessIID_Layout) BIID, dataset(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4) OriginalDataBIID, string fileoutBIID) := FUNCTION 

FindMaxAccountBIID := choosen(sort(OriginalDataBIID, -accountnumber), 5);
MaxAccountBIID := max(FindMaxAccountBIID, accountnumber);

filteredSSNBIID := BIID(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', repssn));
filteredzipBIID := filteredSSNBIID(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', repzip));

goodinfoBIID := filteredzipBIID(replastname not in ['','MARSUPIAL'] and replastname[1..2] != 'AA' and repfirstname not in [''] and repaddress != '' and repcity != ''
											and repstate != '' and repzip != '' and repssn != '' and repssn != '000000000' and repssn != '00000' and CompanyName <> '' and companyaddress <> '' and companycity <> '' and companyzip <> '');
																					
DedupedDataBIID := dedup(goodinfoBIID, companyname, companyaddress, repssn, all); //sorted by ssn since all blank ssn's have been removed;

keepers0BIID := OriginalDataBIID(perm_flag = 0);
keepers1BIID := OriginalDataBIID(perm_flag = 1);
keepers2BIID := OriginalDataBIID(perm_flag = 2);
keepers3BIID := OriginalDataBIID(perm_flag = 3);
keepers4BIID := OriginalDataBIID(perm_flag = 4);
keepersBIID := sort(keepers0BIID+keepers2BIID+keepers3BIID+keepers4BIID, accountnumber);

Reflagged_LogsBIID := project(keepersBIID, RearrangeBNK4(left, counter));

Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4 format_themBIID(Scoring_Project_Refresh_Samples.New_Samples_layouts.BusinessIID_Layout l, integer c) := Transform
self.Date_added := Std.Date.Today();
self.Customer := 'Generic';
self.Source_Info := 'SAOT_logs';
self.Perm_Flag := 4;
//self.AccountNumber := c + MaxAccountBIID;	
self.name_company := l.CompanyName; 
self.street_addr2 :=	l.CompanyAddress; 
self.p_city_name_2 :=	l.CompanyCity; 
self.st_2 := l.CompanyState; 
self.z5_2 :=	l.CompanyZIP; 
self.fein :=	l.FEIN; 
self.phoneno :=	l.CompanyPhone10; 
self.firstname :=	l.RepFirstName; 
self.lastname := l.RepLastName; 
self.ssn :=	l.RepSSN; 
self.dateofbirth :=	l.RepDOB; 
self.streetaddress :=	l.RepAddress; 
self.city :=l.RepCity; 
self.state :=	l.RepState; 
self.zip :=	l.RepZip; 
self.dlnumber := l.RepDL; 
self.dlstate :=	l.RepDLState; 
self.homephone :=	l.RepPhone10; 
self.history_date := 999999;
self.historydateyyyymm := 999999;
self:=l;
self:=[];
End;

Formatted_NewBIID := project(DedupedDataBIID, format_themBIID(left, counter));

New_rightBIID := join(Reflagged_LogsBIID, Formatted_NewBIID,  left.ssn = right.ssn
																									and left.name_company = right.name_company
																									and left.p_city_name_2 = right.p_city_name_2, right only);  //dataset with ssn's that are not in the old dataset;
new_large_sampleBIID := Reflagged_LogsBIID + New_rightBIID; //add "new_right" to old dataset;

sort_large_sampleBIID := Sort(new_large_sampleBIID, ssn, Date_added); //sort by date added for dedup

//deduped_newBIID := sort_large_sampleBIID(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
//dedupoldBIID := sort_large_sampleBIID(Date_added <> (Integer)ut.getdate);

deduped_newBIID := sort_large_sampleBIID(Date_added = Std.Date.Today());  //seperates new and old records by date;
dedupoldBIID := sort_large_sampleBIID(Date_added <> Std.Date.Today());

ut.MAC_Pick_Random(deduped_newBIID,New_5000BIID,5000);   //grabs 5100 of new deduped rocrods;

// Transform to add account number after grabbing the 5000 new records. (12-13-2016)
Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4 add_acctBIID(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4 le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccountBIID;
	self:= le;
	self:= [];
End;

Formatted_acct_NewBIID := project(New_5000BIID, add_acctBIID(left, counter));

New_Test_SampleBIID := dedupoldBIID + Formatted_acct_NewBIID ;

wNew0BIID := New_Test_SampleBIID(perm_flag = 0);
wNew1BIID := New_Test_SampleBIID(perm_flag = 1);
wNew2BIID := New_Test_SampleBIID(perm_flag = 2);
wNew3BIID := New_Test_SampleBIID(perm_flag = 3);
wNew4BIID := New_Test_SampleBIID(perm_flag = 4);

Sorted_SampleBIID := Sort(New_Test_SampleBIID, perm_flag, date_added);

//finalBIID := output(choosen(Sorted_SampleBIID, all));


 finalBIID := OUTPUT(choosen(Sorted_SampleBIID, 25000),,fileoutBIID, thor, overwrite);
 
finalBIID_salt := choosen(Sorted_SampleBIID, 25000);

zz_Koubsky_SALT.mac_profile(finalBIID_salt); 
 
return finalBIID;
end;

// ************************************************************************************************************************************************************************************************************************

Export NonFCRA_New_Samples_Logs_IID(DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.InstantID_Layout) IID, dataset(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure) OriginalDataIID, string fileoutIID) := FUNCTION 

FindMaxAccountIID := choosen(sort(OriginalDataIID, -accountnumber), 5);
MaxAccountIID := max(FindMaxAccountIID, accountnumber);

ut.MAC_Pick_Random(IID,IID_20000,20000);  // triming down the number of records we are dealing with.  IID logs pull a few million in a month, way to many to deal with. 

filteredSSNIID := IID_20000(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzipIID := filteredSSNIID(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));


goodinfoIID := filteredzipIID(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and address != '' and city != ''
											and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != ''  );							
											
dedupedDataIID := dedup(goodinfoIID, SSN, all); //sorted by ssn since all blank ssn's have been removed;


keepers0IID := OriginalDataIID(perm_flag = 0);
keepers1IID := OriginalDataIID(perm_flag = 1);
keepers2IID := OriginalDataIID(perm_flag = 2);
keepers3IID := OriginalDataIID(perm_flag = 3);
keepers4IID := OriginalDataIID(perm_flag = 4);
keepersIID := sort(keepers0IID+keepers2IID+keepers3IID+keepers4IID, accountnumber);

Reflagged_LogsIID := project(keepersIID, Rearrange(left, counter));

Scoring_Project_Refresh_Samples.New_Samples_layouts.output_structure format_themIID(Scoring_Project_Refresh_Samples.New_Samples_layouts.InstantID_Layout l, integer c) := Transform
	self.Date_added := Std.Date.Today();
	self.Customer := 'General';
	self.Source_Info := 'SAOT_logs';
	self.Perm_Flag := 4;
	//self.AccountNumber := c + MaxAccountIID;
	self.streetaddress := l.address;
	self.dateofbirth := l.dob;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;

formatted_NewIID := project(DedupedDataIID, format_themIID(left, counter));

New_rightIID := join(Reflagged_LogsIID, Formatted_NewIID,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
new_large_sampleIID := Reflagged_LogsIID + New_rightIID; //add "new_right" to old dataset;

sort_large_sampleIID := Sort(new_large_sampleIID, ssn, Date_added); //sort by date added for dedup

//deduped_newIID := sort_large_sampleIID(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
//dedupoldIID := sort_large_sampleIID(Date_added <> (Integer)ut.getdate);

deduped_newIID := sort_large_sampleIID(Date_added = Std.Date.Today());  //seperates new and old records by date;
dedupoldIID := sort_large_sampleIID(Date_added <> Std.Date.Today());

ut.MAC_Pick_Random(deduped_newIID,New_5000IID,5000);   //grabs 5100 of new deduped rocrods;

// Transform to add account number after grabbing the 5000 new records. (12-13-2016)
Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure add_acctIID(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccountIID;
	self:= le;
	self:= [];
End;

Formatted_acct_NewIID := project(New_5000IID, add_acctIID(left, counter));

New_Test_SampleIID := dedupoldIID + Formatted_acct_NewIID ;

wNew0IID := New_Test_SampleIID(perm_flag = 0);
wNew1IID := New_Test_SampleIID(perm_flag = 1);
wNew2IID := New_Test_SampleIID(perm_flag = 2);
wNew3IID := New_Test_SampleIID(perm_flag = 3);
wNew4IID := New_Test_SampleIID(perm_flag = 4);

Sorted_SampleIID := Sort(New_Test_SampleIID, perm_flag, date_added);

//finalIID := output(choosen(Sorted_SampleIID, all));

finalIID := OUTPUT(choosen(Sorted_SampleIID, 25000),,fileoutIID, thor, overwrite);

finalIID_salt := choosen(Sorted_SampleIID, 25000);

zz_Koubsky_SALT.mac_profile(finalIID_salt); 

return finalIID;
end;
end;

