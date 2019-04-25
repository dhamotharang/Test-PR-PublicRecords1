// EXPORT SBA_Business_Shell_New_Samples_Logs := 'todo';

#workunit('name', 'Small_Business_Analytics_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT, Scoring_Project_Macros, zz_Koubsky_SALT, salt23;

oldinputfile := '~scoring_project::in::businessshell_xml_20160825';

fileout := '~bbraaten::test::SBA_inputsample_test2';

BeginDate := '20180101';
	EndDate := ut.getdate;

AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 50;

// outputFile := '~bpahl::out::Small_Business_Risk_SAOT_' + BeginDate + '-' + EndDate + '_' + AccountIDs[1];

File := Score_Logs.Files_index.File_TransactionID; 
File_nonFCRA := File(StringLib.StringToUpperCase(product) NOT IN Score_Logs.FCRA_Transaction_Constants.product);
LogFile := INDEX(File_nonFCRA, {transaction_id}, {File_nonFCRA}, '~foreign::' + '10.173.44.105' + '::' +
																			'thor_data400::key::acclogs_scoring::20180506::xml_transactionid');


// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['SMALLBUSINESSANALYTICS'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['SMALLBUSINESSANALYTICS'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

// output(LogsRaw(product = 'SMALLBUSINESSANALYTICS'));
// linerec := {STRING line};

logs_raw_layout:= record
	RECORDOF(LogsRaw);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
		
end;

Logs := PROJECT(LogsRaw, TRANSFORM(logs_raw_layout, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, 'String SmallBusinessAnalytics>', 'String SmallBusinessAnalytics>String TransactionId>' + LEFT.Transaction_Id + 'String /TransactionId>');
																		SELF.outputxml := 'String SmallBusinessAnalytics>' + LEFT.outputxml + 'String /SmallBusinessAnalytics>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs, 500), NAMED('Sample_Yesterday_Logs'));

// RiskView3Table := table(Logs,
	// {
		// customer_id,
		// Total := count(group)
	// },
	// customer_id
// );
// output(RiskView3Table, named('Logs'));




Scoring_Project_Refresh_Samples.New_Samples_layouts.SBALayout parse_inputxml () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	// SELF.EndUserCompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.companyname					:= TRIM(XMLTEXT('SearchBy/Company/CompanyName'));
	SELF.altcompanyname					:= TRIM(XMLTEXT('SearchBy/Company/AlternateCompanyName'));
	SELF.streetaddress1				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Company/Address/StreetAddress1'));
	SELF.streetaddress2				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Company/Address/StreetAddress2'));
	SELF.City					:= TRIM(XMLTEXT('SearchBy/Company/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/Company/Address/State'));
	SELF.zip9						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Company/Address/Zip5'));
	SELF.FEIN									:= TRIM(XMLTEXT('SearchBy/Company/FEIN'));
	SELF.Phone10				:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/Company/Phone'));
	SELF.Rep_FirstName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Name/First'));
	SELF.Rep_LastName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Name/Last'));
	SELF.Rep_SSN								:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/AuthorizedRep1/SSN'));
	SELF.Rep_dateofbirth								:= XMLTEXT('SearchBy/AuthorizedRep1/DOB');
	SELF.rep_streetaddress1						:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/AuthorizedRep1/Address/StreetAddress1'));
	SELF.rep_streetaddress2						:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/AuthorizedRep1/Address/StreetAddress2'));
	SELF.Rep_City							:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/City'));
	SELF.Rep_State							:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/State'));
	SELF.Rep_Zip								:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/AuthorizedRep1/Address/Zip5'));
	SELF.rep_dlnumber								:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DriverLicenseNumber'));
	SELF.rep_dlstate						:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DriverLicenseState'));
	SELF.rep_phone10						:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/AuthorizedRep1/Phone'));
	SELF.Rep2_FirstName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Name/First'));
	SELF.Rep2_LastName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Name/Last'));
	SELF.Rep2_SSN								:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/AuthorizedRep2/SSN'));
	SELF.Rep2_dateofbirth								:= XMLTEXT('SearchBy/AuthorizedRep2/DOB');
	SELF.Rep2_streetaddress1						:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/AuthorizedRep2/Address/StreetAddress1'));
	SELF.Rep2_streetaddress2						:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/AuthorizedRep2/Address/StreetAddress2'));
	SELF.Rep2_City							:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Address/City'));
	SELF.Rep2_State							:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Address/State'));
	SELF.Rep2_Zip								:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/AuthorizedRep2/Address/Zip5'));
	SELF.Rep2_DLnumber								:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/DriverLicenseNumber'));
	SELF.Rep2_dlstate						:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/DriverLicenseState'));
	SELF.Rep2_Phone10						:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/AuthorizedRep2/Phone'));
	SELF.Rep3_FirstName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Name/First'));
	SELF.Rep3_LastName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Name/Last'));
	SELF.Rep3_SSN								:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/AuthorizedRep3/SSN'));
	SELF.Rep3_dateofbirth								:= XMLTEXT('SearchBy/AuthorizedRep3/DOB');
	SELF.Rep3_streetaddress1						:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/AuthorizedRep3/Address/StreetAddress1'));
	SELF.Rep3_streetaddress2						:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/AuthorizedRep3/Address/StreetAddress2'));
	SELF.Rep3_City							:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Address/City'));
	SELF.Rep3_State							:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Address/State'));
	SELF.Rep3_Zip								:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/AuthorizedRep3/Address/Zip5'));
	SELF.Rep3_DLnumber								:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/DriverLicenseNumber'));
	SELF.Rep3_DLState						:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/DriverLicenseState'));
	SELF.Rep3_Phone10						:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/AuthorizedRep3/Phone'));
	self.Models			 					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Name')));
	self.Attributes 					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/AttributesVersionRequest/Name')));
	SELF := [];
END;
// parsedInput2 := PARSE(Logs, inputxml, parseInput(), XML('SmallBusinessAnalytics'));

// OUTPUT(CHOOSEN(parsedInput2, 300), NAMED('Sample_Parsed_Input'));

Scoring_Project_Refresh_Samples.New_Samples_layouts.SBALayout parseInput (Logs l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	self.TransactionID := l.TransactionID;
	// self.TransactionDate := l.DateTime;
	logs_temp := project(ut.ds_oneRecord, transform(logs_raw_layout,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp := parse(logs_temp, inputxml, parse_inputxml(), XML('SmallBusinessAnalyticsRequest'));
	
	self := temp[1];
	
	SELF := [];
END;

cleanLogs := project(Logs, parseInput(left));


logsaccount := cleanLogs;
OUTPUT(CHOOSEN(logsaccount, 20000), NAMED('logsaccount'));



prii_layout := RECORD
  integer8 date_added;
  string customer;
  string source_info;
  integer1 perm_flag;
  string seq;
  integer8 acctno;
  string companyname;
  string altcompanyname;
  string streetaddress1;
  string streetaddress2;
  string city;
  string state;
  string zip9;
  string prim_range;
  string predir;
  string prim_name;
  string addr_suffix;
  string postdir;
  string unit_desig;
  string sec_range;
  string zip5;
  string zip4;
  string lat;
  string long;
  string addr_type;
  string addr_status;
  string county;
  string geo_block;
  string fein;
  string phone10;
  string ipaddr;
  string companyurl;
  string sic_code;
  string naic_code;
  string bus_lexid;
  string bus_structure;
  string years_in_business;
  string bus_start_date;
  string yearly_revenue;
  string fax_number;
  string rep_fullname;
  string rep_nametitle;
  string rep_firstname;
  string rep_middlename;
  string rep_lastname;
  string rep_namesuffix;
  string rep_formerlastname;
  string rep_streetaddress1;
  string rep_streetaddress2;
  string rep_city;
  string rep_state;
  string rep_zip;
  string rep_prim_range;
  string rep_predir;
  string rep_prim_name;
  string rep_addr_suffix;
  string rep_postdir;
  string rep_unit_desig;
  string rep_sec_range;
  string rep_zip5;
  string rep_zip4;
  string rep_lat;
  string rep_long;
  string rep_addr_type;
  string rep_addr_status;
  string rep_county;
  string rep_geo_block;
  string rep_ssn;
  string rep_dateofbirth;
  string rep_phone10;
  string rep_age;
  string rep_dlnumber;
  string rep_dlstate;
  string rep_email;
  string rep_lexid;
  string rep2_fullname;
  string rep2_nametitle;
  string rep2_firstname;
  string rep2_middlename;
  string rep2_lastname;
  string rep2_namesuffix;
  string rep2_formerlastname;
  string rep2_streetaddress1;
  string rep2_streetaddress2;
  string rep2_city;
  string rep2_state;
  string rep2_zip;
  string rep2_prim_range;
  string rep2_predir;
  string rep2_prim_name;
  string rep2_addr_suffix;
  string rep2_postdir;
  string rep2_unit_desig;
  string rep2_sec_range;
  string rep2_zip5;
  string rep2_zip4;
  string rep2_lat;
  string rep2_long;
  string rep2_addr_type;
  string rep2_addr_status;
  string rep2_county;
  string rep2_geo_block;
  string rep2_ssn;
  string rep2_dateofbirth;
  string rep2_phone10;
  string rep2_age;
  string rep2_dlnumber;
  string rep2_dlstate;
  string rep2_email;
  string rep2_lexid;
  string rep3_fullname;
  string rep3_nametitle;
  string rep3_firstname;
  string rep3_middlename;
  string rep3_lastname;
  string rep3_namesuffix;
  string rep3_formerlastname;
  string rep3_streetaddress1;
  string rep3_streetaddress2;
  string rep3_city;
  string rep3_state;
  string rep3_zip;
  string rep3_prim_range;
  string rep3_predir;
  string rep3_prim_name;
  string rep3_addr_suffix;
  string rep3_postdir;
  string rep3_unit_desig;
  string rep3_sec_range;
  string rep3_zip5;
  string rep3_zip4;
  string rep3_lat;
  string rep3_long;
  string rep3_addr_type;
  string rep3_addr_status;
  string rep3_county;
  string rep3_geo_block;
  string rep3_ssn;
  string rep3_dateofbirth;
  string rep3_phone10;
  string rep3_age;
  string rep3_dlnumber;
  string rep3_dlstate;
  string rep3_email;
  string rep3_lexid;
  string dppa_purpose;
  string glba_purpose;
  string data_restriction_mask;
  string data_permission_mask;
  string industryclass;
  integer8 historydate;
  string busshellversion;
  string powid;
  string proxid;
  string seleid;
  string orgid;
  string ultid;
 END;



oldfile := dataset(oldinputfile, prii_layout, thor);
OUTPUT(CHOOSEN(oldfile, eyeball), NAMED('oldfile'));
output(count(oldfile));



FindMaxAccount := choosen(sort(oldfile, -acctno), 5);
MaxAccount := max(FindMaxAccount, acctno);
output(MaxAccount, named('max_account_rvv3'));


// SBA := logsaccount(attributes = 'SMALLBUSINESSATTRV1');
// Output(choosen(logsaccount (attributes = 'SMALLBUSINESSATTRV1'), 100), named('SMALLBUSINESSATTRV1'));
// count(SBA);

// filteredSSN := logsaccount(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', zip9));
// filteredzip := filteredSSN(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', 	fein));
// OUTPUT(CHOOSEN(filteredzip, 200), NAMED('filteredzip'));



goodinfo := logsaccount( companyname != '' and streetaddress1 != ''and zip9 != '' and fein != '');
																						

OUTPUT(CHOOSEN(goodinfo, eyeball), NAMED('goodinfo'));
output(count(goodinfo));

DedupedData := dedup(goodinfo, companyname, streetaddress1, zip9, fein, all); //sorted by ssn since all blank ssn's have been removed;
OUTPUT(CHOOSEN(DedupedData, eyeball), NAMED('DedupedData'));
output(count(DedupedData));
countnew := count(DedupedData);

DedupedDatas_1_0 := oldfile(perm_flag = 0);
output(count(DedupedDatas_1_0), named('DedupedDatas_1_0'));

DedupedDatas_1_1 := oldfile(perm_flag = 1);
output(count(DedupedDatas_1_1), named('DedupedDatas_1_1'));

DedupedDatas_1_2 := oldfile(perm_flag = 2);
output(count(DedupedDatas_1_2), named('DedupedDatas_1_2'));

DedupedDatas_1_3 := oldfile(perm_flag = 3);
output(count(DedupedDatas_1_3), named('DedupedDatas_1_3'));

DedupedDatas_1_4 := oldfile(perm_flag = 4);
output(count(DedupedDatas_1_4), named('DedupedDatas_1_4'));

// _choose := (10000 - countnew);
// newReflagged_old_4 := choosen(Reflagged_oldfiles_1_4, _choose);
// output(count(newReflagged_old_4), named('newReflagged_old_4'));


// keepers := sort(Reflagged_oldfiles_1_0+Reflagged_oldfiles_1_1+Reflagged_oldfiles_1_2+Reflagged_oldfiles_1_3+Reflagged_oldfiles_1_4, date_added);
keepers := sort(DedupedDatas_1_0+DedupedDatas_1_2+DedupedDatas_1_3+DedupedDatas_1_4, date_added);
output(choosen(keepers, eyeball));
output(count(keepers), named('keepers'));


Scoring_Project_Macros.Regression.Business_shell_PII Rearrange( prii_layout l, integer c) := TRANSFORM
	// self.Date_added := (Integer)20151022;
	self.acctno := l.acctno;
	// self.Perm_Flag := If(c <= 10000, 0, if(c >10000 and c <= 20000, 1,if(c >20000 and c <= 30000, 2, if(c >30000 and c <= 40000, 3, 4))));
		self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  	
	// self.rep_firstname := l.rep_firstname;
  // self.rep_middlename  := l.rep_middlename;
  // self.rep_lastname  := l.lastname;
  // self.rep_streetaddress1  := l.streetaddress;
  // self.rep_city  := l.city;
  // self.rep_state  := l.state;
  // self.rep_zip := l.zip;
  // self.rep_phone10 := l.workphone;
  // self.rep_ssn := l.ssn;
  // self.rep_dateofbirth := l.dateofbirth;
  // self.rep_dlnumber := l.dlnumber;
  // self.rep_dlstate := l.dlstate;
	// self.companyname := l.name_company;
  // self.altcompanyname := l.alt_company_name;
  // self.streetaddress1 := l.street_addr2;
  // self.city := l.p_city_name_2;
  // self.state := l.st_2;q
  // self.zip9 := l.z5_2;
  // self.zip4 := l.zip4_2;
  // self.phone10 := l.phoneno;
  // self.fein := l.fein;	
	// self.historydate := 999999;
	self := l;
  self := [];
END;
Reflagged_oldfile := project(keepers, Rearrange(left, counter));
output(choosen(Reflagged_oldfile, eyeball));
output(count(Reflagged_oldfile), named('Reflagged_Logs'));

wNew0Reflagged_oldfile := Reflagged_oldfile(perm_flag = 0);
output(count(wNew0Reflagged_oldfile), named('New_Test_SampleNew0Reflagged_oldfile'));
wNew1Reflagged_oldfile := Reflagged_oldfile(perm_flag = 1);
output(count(wNew1Reflagged_oldfile), named('New_Test_SampleNew1Reflagged_oldfile'));
wNew2Reflagged_oldfile := Reflagged_oldfile(perm_flag = 2);
output(count(wNew2Reflagged_oldfile), named('New_Test_SampleNew2Reflagged_oldfile'));
wNew3Reflagged_oldfile := Reflagged_oldfile(perm_flag = 3);
output(count(wNew3Reflagged_oldfile), named('New_Test_SampleNew3Reflagged_oldfile'));
wNew4Reflagged_oldfile := Reflagged_oldfile(perm_flag = 4);
output(count(wNew4Reflagged_oldfile), named('New_Test_SampleNew4Reflagged_oldfile'));


// Scoring_Project_Macros.Business_shell_PII format_them(Scoring_Project_Refresh_Samples.New_Samples_layouts.SBALayout l, integer c) := Transform
prii_layout format_them(Scoring_Project_Refresh_Samples.New_Samples_layouts.SBALayout l, integer c) := Transform
	self.Date_added := (integer)ut.getdate;
	self.Customer := l.accountid;
	self.Source_Info := 'acclogs_scoring';
	self.Perm_Flag := 4;
	// self.AccountNumber := c + MaxAccount;
	// self.acctno := c + MaxAccount;
		self.rep_state := if(length(l.rep_state) > 2, l.rep_city, l.rep_state);
	self.rep_city := if(length(l.rep_state) > 2, l.rep_state, l.rep_city);
		self.historydate := 999999;
	self:=l;
	self:=[];
End;


Formatted_New := project(DedupedData, format_them(left, counter));
OUTPUT(CHOOSEN(Formatted_New, eyeball), NAMED('Formatted_New'));
output(count(Formatted_New));



New_right := join(Reflagged_oldfile, Formatted_New,  left.companyname = right.companyname and
																									left.streetaddress1 = right.streetaddress1 and
																									left.fein = right.fein and 
																									left.zip9 = right.zip9 and 
																									left.Rep_SSN = right.Rep_SSN, right only);  //dataset with ssn's that are not in the old dataset;
																									
sort_large_sample := Sort(New_right, fein, Rep_SSN, Date_added); //sort by date added for dedup

deduped_new := sort_large_sample(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
dedupold:= deduped_new(Date_added <> (Integer)ut.getdate);

ut.MAC_Pick_Random(deduped_new,New_5000,10000);   //grabs 5000 of new deduped rocrods;

prii_layout add_acct(prii_layout le, integer c) := Transform
	self.acctno := c + (integer)MaxAccount;
	self:= le;
	self:= [];
End;

Formatted_acct_New := project(New_5000, add_acct(left, counter));

new_large_sample := Reflagged_oldfile + Formatted_acct_New;																									
																									
// new_large_sample := keepers + New_right; //add "new_right" to old dataset;
output(choosen(new_large_sample, eyeball), named('new_and_old'));

wNew0 := new_large_sample(perm_flag = 0);
output(count(wNew0), named('New_Test_SampleNew0'));
wNew1 := new_large_sample(perm_flag = 1);
output(count(wNew1), named('New_Test_SampleNew1'));
wNew2 := new_large_sample(perm_flag = 2);
output(count(wNew2), named('New_Test_SampleNew2'));
wNew3 := new_large_sample(perm_flag = 3);
output(count(wNew3), named('New_Test_SampleNew3'));
wNew4 := new_large_sample(perm_flag = 4);
output(count(wNew4), named('New_Test_SampleNew4'));

Sorted_Sample := Sort(new_large_sample, perm_flag);

// fileout2 := '~bbraaten::SBA::Test::state_sample';


// output(Sorted_Sample (length(rep_state) > 2));
// test := Sorted_Sample(length(rep_state) > 2);

// OUTPUT(choosen(test, 25),,fileout2, thor,  expire(18),overwrite);


output(choosen(Sorted_Sample, eyeball), named('Sorted_Sample'));

OUTPUT(choosen(Sorted_Sample, 50000),,fileout, thor, overwrite);
Sorted_Sample_salt := choosen(Sorted_Sample, 50000);

zz_Koubsky_SALT.mac_profile(Sorted_Sample_salt); 