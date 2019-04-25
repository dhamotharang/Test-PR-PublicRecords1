IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT,doxie, Scoring_Project_Macros, zz_bbraaten2, zz_connors;



Boolean RunAll 						:= false;

Boolean isFraudPoint31505   := true;
fileoldFPv3 := '~Scoring_Project::in::FraudPoint_XML_FP31505_0_20160419';
FileoutFPv3 := '~rjc::in::test_fpv3_new_test4';

BeginDate := '20160419';
EndDate := (STRING8)STD.DATE.TODAY();

AccountIDs := ['']; // leave this alone
eyeball := 300;

// ******************************************************************************
File := Score_Logs.Files_index.File_TransactionID; 
File_nonFCRA := File(StringLib.StringToUpperCase(product) NOT IN Score_Logs.FCRA_Transaction_Constants.product);
LogFile := INDEX(File_nonFCRA, {transaction_id}, {File_nonFCRA}, ut.foreign_prod +'thor_data400::key::acclogs_scoring::'+doxie.Version_SuperKey+'::xml_transactionid');
// ********************************************************************************
#if (isFraudPoint31505 or RunAll)
LogsRawFraud := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FRAUDPOINT'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FRAUDPOINT'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

logs_raw_layoutFraud := record
	RECORDOF(LogsRawFraud);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;

LogsFraud := PROJECT(LogsRawFraud, TRANSFORM(logs_raw_layoutFraud, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<FraudPoint>', '<FraudPoint><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<FraudPoint>' + LEFT.outputxml + '</FraudPoint>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));																					
																											
																											
OUTPUT(CHOOSEN(LogsFraud, eyeball), NAMED('Sample_Raw_LogsFraud'));

zz_bbraaten2.New_Samples_layouts.FraudAdvisor_Layout parse_inputxmlFraud () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/Name/Last'));
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/SSN'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/DOB')) + Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/DOB/Year'), XMLTEXT('SearchBy/DOB/Month'), XMLTEXT('SearchBy/DOB/Day'));
	SELF.Address				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Address/StreetAddress1'), XMLTEXT('SearchBy/Address/StreetAddress2'), XMLTEXT('SearchBy/Address/StreetNumber'), XMLTEXT('SearchBy/Address/StreetPreDirection'), XMLTEXT('SearchBy/Address/StreetName'),
															XMLTEXT('SearchBy/Address/StreetSuffix'), XMLTEXT('SearchBy/Address/StreetPostDirection'), XMLTEXT('SearchBy/Address/UnitDesignation'), XMLTEXT('SearchBy/Address/UnitNumber'));
	SELF.City						:= TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Address/Zip5'));
	SELF.DL							:= TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/Phone10'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WPhone10'));
	self.FP_Model				:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/FraudPointModel')));
	self.FP_Model2				:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/OptionValue/ModelOption/ModelOptions')));
	self.FP_Attributes	:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/FraudAttributesRequests/name')));
	self.FP_Attributes2	:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/AttributesVersionRequest')));

	SELF := [];
END;

zz_bbraaten2.New_Samples_layouts.FraudAdvisor_Layout parseInputFraud (LogsFraud l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_temp := project(ut.ds_oneRecord, transform(logs_raw_layoutFraud,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_Fraud := parse(logs_temp, inputxml, parse_inputxmlFraud(), XML('FraudPoint'));
	
	self := temp_Fraud[1];
	
	SELF := [];
END;

cleanLogsFraud := project(LogsFraud, parseInputFraud(left));
OUTPUT(CHOOSEN(cleanLogsFraud, eyeball), NAMED('cleanLogsFraud'));


logsaccountFraud := cleanLogsFraud;




FPv3 := logsaccountFraud( FP_Model = 'FP31505_0');
OUTPUT(CHOOSEN(FPv3, eyeball), NAMED('FPv3'));

OriginalDataFPv3 := DATASET(fileoldFPv3, zz_bbraaten2.New_Samples_layouts.Output_structure, thor);

//zz_connors.NonFCRA_FP3_temp_log(FPv3, OriginalDataFpv3, FileoutFPv3);
FindMaxAccountFPv3 := choosen(sort(OriginalDatafpv3, -accountnumber), 5);
MaxAccountFPv3 := max(FindMaxAccountFPv3, accountnumber);

filteredSSNFPv3 := FPv3(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzipFPv3 := filteredSSNFPv3(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));

goodinfoFPv3 := filteredzipFPv3(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											 and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != '' and (homephone != '' or workphone != ''));

keepers0FPv3 := OriginalDataFPv3(perm_flag = 0);
keepers1FPv3 := OriginalDataFPv3(perm_flag = 1);
keepers2FPv3 := OriginalDataFPv3(perm_flag = 2);
keepers3FPv3 := OriginalDataFPv3(perm_flag = 3);
keepers4FPv3 := OriginalDataFPv3(perm_flag = 4);

// keepersFPv3 := sort(keepers0FPv3+keepers2FPv3+keepers3FPv3+keepers4FPv3, accountnumber);

perm1 := choosen(keepers1FPv3, 2000);
perm0 := choosen(keepers0FPv3, 2000);
perm2 := choosen(keepers2FPv3, 2000);
perm3 := choosen(keepers3FPv3, 2000);

full_old := perm0+perm1+perm2+perm3;

zz_bbraaten2.New_Samples_layouts.output_structure Rearrange(zz_bbraaten2.New_Samples_layouts.output_structure l, integer c) := TRANSFORM
	// self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  	
	self.zip := l.zip[1..5];
	self.homephone := if(l.homephone[1] = '0', '', l.homephone);
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self := l;
  self := [];
END;


Reflagged_LogsFPv3 := project(full_old, Rearrange(left, counter));

DedupedDataFPv3 := dedup(goodinfoFPv3, SSN, all); //sorted by ssn since all blank ssn's have been removed;


zz_bbraaten2.New_Samples_layouts.Output_structure format_themFPv3(zz_bbraaten2.New_Samples_layouts.FraudAdvisor_Layout l, integer c) := Transform
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


ut.MAC_Pick_Random(deduped_newFPv3,New_5000FPv3,2000);   //grabs 2000 of new deduped rocrods;
//output(New_5000FPv3, named('New_5000FPv3'));

// Transform to add account number after grabbing the 5000 new records. (12-13-2016)
zz_bbraaten2.New_Samples_layouts.Output_structure add_acctFPv3(zz_bbraaten2.New_Samples_layouts.Output_structure le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccountFPv3;
	self:= le;
	self:= [];
End;

Formatted_acct_NewFPv3 := project(New_5000FPv3, add_acctFPv3(left, counter));


New_Test_SampleFPv3 := dedupoldFPv3 + Formatted_acct_NewFPv3 ; //adds back to old file;


Sorted_SampleFPv3 := Sort(New_Test_SampleFPv3, perm_flag, date_added);

finalFPv3 := OUTPUT(choosen(Sorted_SampleFPv3, 25000),,FileoutFPv3, thor, overwrite);
//NonFCRA_FP3_temp_log(FPv3_model, OriginalDataFpv3, FileoutFPv3);

//zz_bbraaten2.NonFCRA_New_Samples_Logs.NonFCRA_New_Samples_Logs_FPv3(FPv3, OriginalDataFPv3, FileoutFPv3);

#end




//****************************************************************************
/* NonFCRA_FP3_temp_log (DATASET(zz_bbraaten2.New_Samples_layouts.FraudAdvisor_Layout) FPv3,dataset(zz_bbraaten2.New_Samples_layouts.Output_structure)OriginalDatafpv3, String Fileoutfpv3) := FUNCTION 
   
   FindMaxAccountFPv3 := choosen(sort(OriginalDatafpv3, -accountnumber), 5);
   MaxAccountFPv3 := max(FindMaxAccountFPv3, accountnumber);
   
   filteredSSNFPv3 := FPv3(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
   filteredzipFPv3 := filteredSSNFPv3(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));
   
   goodinfoFPv3 := filteredzipFPv3(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
   											 and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != '' and (homephone != '' or workphone != ''));
   
   keepers0FPv3 := OriginalDataFPv3(perm_flag = 0);
   keepers1FPv3 := OriginalDataFPv3(perm_flag = 1);
   keepers2FPv3 := OriginalDataFPv3(perm_flag = 2);
   keepers3FPv3 := OriginalDataFPv3(perm_flag = 3);
   keepers4FPv3 := OriginalDataFPv3(perm_flag = 4);
   
   // keepersFPv3 := sort(keepers0FPv3+keepers2FPv3+keepers3FPv3+keepers4FPv3, accountnumber);
   
   perm1 := choosen(keepers1FPv3, 2000);
   perm0 := choosen(keepers0FPv3, 2000);
   perm2 := choosen(keepers2FPv3, 2000);
   perm3 := choosen(keepers3FPv3, 2000);
   
   full_old := perm0+perm1+perm2+perm3;
   
   zz_bbraaten2.New_Samples_layouts.output_structure Rearrange(zz_bbraaten2.New_Samples_layouts.output_structure l, integer c) := TRANSFORM
   	// self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  	
   	self.zip := l.zip[1..5];
   	self.homephone := if(l.homephone[1] = '0', '', l.homephone);
   	self.history_date := 999999;
   	self.historydateyyyymm := 999999;
   	self := l;
     self := [];
   END;
   
   
   Reflagged_LogsFPv3 := project(full_old, Rearrange(left, counter));
   
   DedupedDataFPv3 := dedup(goodinfoFPv3, SSN, all); //sorted by ssn since all blank ssn's have been removed;
   
   
   zz_bbraaten2.New_Samples_layouts.Output_structure format_themFPv3(zz_bbraaten2.New_Samples_layouts.FraudAdvisor_Layout l, integer c) := Transform
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
   
   
   ut.MAC_Pick_Random(deduped_newFPv3,New_5000FPv3,2000);   //grabs 2000 of new deduped rocrods;
   //output(New_5000FPv3, named('New_5000FPv3'));
   
   // Transform to add account number after grabbing the 5000 new records. (12-13-2016)
   zz_bbraaten2.New_Samples_layouts.Output_structure add_acctFPv3(zz_bbraaten2.New_Samples_layouts.Output_structure le, integer c) := Transform
   	self.AccountNumber := c + (integer)MaxAccountFPv3;
   	self:= le;
   	self:= [];
   End;
   
   Formatted_acct_NewFPv3 := project(New_5000FPv3, add_acctFPv3(left, counter));
   
   
   New_Test_SampleFPv3 := dedupoldFPv3 + Formatted_acct_NewFPv3 ; //adds back to old file;
   
   
   Sorted_SampleFPv3 := Sort(New_Test_SampleFPv3, perm_flag, date_added);
   
   finalFPv3 := OUTPUT(choosen(Sorted_SampleFPv3, 25000),,FileoutFPv3, thor, overwrite);
   
   return finalFPv3;
   
   
   end;
*/
