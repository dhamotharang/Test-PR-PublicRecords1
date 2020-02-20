﻿IMPORT _Control, address, AID, AutoStandardI, Gateway, Risk_Indicators, riskprocessing, RiskWise, ut, STD;

#option('pickBestEngine', false); // workaround to fix property key issues in Vault
#workunit('priority','high');
onThor := _Control.Environment.OnThor; // TRUE = use thor (distributed) logic. FALSE = use keyed joins.
settingsOK := OnThor and _Control.Environment.OnVault and _Control.LibraryUse.ForceOff_AllLibraries;

#WORKUNIT('name', 'FCRA Bocashell 5.4' + 	if(settingsOK,  ' THOR ', ERROR(9,'Toggle OnThor OnVault LibraryUse') ) );  // throw an error here if the controls aren't set correctly
// #OPTION('multiplePersistInstances', FALSE); // doesn't rename the persist files for each job
#OPTION('embeddedWarningsAsErrors',0);
#STORED('did_add_force', if(onThor, 'thor', 'roxi') );  // stored parameter used inside the DID append macro to determine which version of the macro to use

// Reads sample data from input file, runs the service on thor, and saves results in output file. 
// Before running:
//   choose (or define) input file name and, if needed, output file name as well;
//   choose (or define) input layout;
//   check the number of records to read from input;
//   uncomment file-output, if needed;
//   check that the data restrictions are set appropriately, specifically  EN and EQ
//   eyeball is how many records you want to see on output, similar to record_limit except this is your intermediate result output count

//====================================================
//=============== Configurable options =============== 
//====================================================

record_limit := ALL;    //number of records to read from input file. ALL runs entire file
// record_limit := 0;    //number of records to read from input file. ALL runs entire file
unsigned1 eyeball := 10;
string DataRestrictionMask := '1000010001000100000000000'; // to restrict fares, experian, transunion and experian FCRA 
boolean RetainInputDID := FALSE; //Change to TRUE to retain the input LexID
string IntendedPurpose := 'APPLICATION';


//===================  input-output files  ======================
infile_name :=  '~foreign::' + _control.IPAddress.dataland_dali + '::lweiner::in::rv5t_dev_val_inputs_100k_did';
outfile_name := '~dvstemp::out::fcrashell54_' + thorlib.wuid();	// this will output your work unit number in your filename;
// outfile_name := '~dvstemp::out::fcrashell50_' + thorlib.wuid();	// this will output your work unit number in your filename;

//==================  input file layout  ========================
layout_input := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    string historydate;
    string LexID;
  END;
ds_in := dataset (infile_name, layout_input, csv(quote('"')));
//=================
output(count(ds_in));


inds := CHOOSEN (ds_in, record_limit);
// inds := ds_in(account in accounts);
OUTPUT (choosen(inds, eyeball), NAMED ('input'));

	batch_in50 := record
		Risk_Indicators.Layout_Batch_In /*- HistoryDateYYYYMM*/; //???
		string20 HistoryDateTimeStamp;
		STRING12 	LexID;
		string email;
	end;
  
Batch_In := PROJECT(inds, TRANSFORM(batch_in50,
	SELF.seq := COUNTER;
	SELF.AcctNo := LEFT.Account;
	SELF.SSN := LEFT.SSN;
	SELF.unParsedFullName := '';
	SELF.Name_First := LEFT.FirstName;
	SELF.Name_Middle := LEFT.MiddleName;
	SELF.Name_Last := LEFT.LastName;
	SELF.Name_Suffix := '';
	SELF.DOB := LEFT.DateOfBirth;
	SELF.street_addr := LEFT.StreetAddress;
	SELF.Prim_Range := '';
	SELF.Predir := '';
	SELF.Prim_Name := '';
	SELF.Suffix := '';
	SELF.Postdir := '';
	SELF.Unit_Desig := '';
	SELF.Sec_Range := '';
	SELF.p_City_name := LEFT.City;
	SELF.St := LEFT.State;
	SELF.Z5 := LEFT.zip;
	SELF.Age := '';
	SELF.DL_Number := LEFT.DLNumber;
	SELF.DL_State := LEFT.DLState;	
	SELF.Home_Phone := LEFT.HomePhone;
	SELF.Work_Phone := LEFT.WorkPhone;
	SELF.ip_addr := '';
	self.email := left.email;
  SELF.lexid := left.lexid;
	
    // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
		// self.historydateyyyymm := 201801;  
		// self.historyDateTimeStamp := '20180101 00000100';  

	//	self.historydateyyyymm := 999999;  
	//	self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  


  self.historydateyyyymm := map(
			regexfind('^\\d{8} \\d{8}$', LEFT.historydate) => (unsigned)LEFT.historydate[..6],
			regexfind('^\\d{8}$',        LEFT.historydate) => (unsigned)LEFT.historydate[..6],
			                                                (unsigned)LEFT.historydate
	);
	
  self.historyDateTimeStamp := map(
      LEFT.historydate in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			regexfind('^\\d{8} \\d{8}$', LEFT.historydate) => LEFT.historydate,
			regexfind('^\\d{8}$',        LEFT.historydate) => LEFT.historydate +   ' 00000100',
			regexfind('^\\d{6}$',        LEFT.historydate) => LEFT.historydate + '01 00000100',		                                                
			                                                  LEFT.historydate
	)
	)	);

inds_dist := DISTRIBUTE(Batch_In); //Distribute randomly

//====================================================
//======== DO NOT CHANGE ANYTHING BELOW HERE. ======== 
//====================================================
	/* IID & Boca Shell Values */
  string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission;
  unsigned1 DPPA := 0;
	unsigned1 GLB  := AutoStandardI.Constants.GLBPurpose_default;
	boolean FilterLiens := DataRestrictionMask[risk_indicators.iid_constants.posLiensJudgRestriction]='1' ;
  boolean isPreScreen := false;
  gateways := Gateway.Constants.void_gateway;
	isUtility           := false;
	includeRel          := false;
	includeDL           := true;
	includeVeh          := false;
	includeDerog        := true;
	bsVersion           := 54;
	isFCRA              := true;  
	ln_branded          := false;
	ofac_only           := true;
	suppressNearDups    := false;
	require2ele         := false; 
	from_biid           := false;
	excludeWatchlists   := false;
	from_IT1O           := false;
	ofac_version        := 1;	
	include_ofac        := false;
	addtl_watchlists    := false;
	watchlist_threshold := 0.84;
	dob_radius          := -1;	
	doScore             := true;
	nugen               := true;
	unsigned1 AppendBest := 1;		// search best file

	unsigned8 BSOptions := 	if(RetainInputDID, 
	risk_indicators.iid_constants.BSOptions.RetainInputDID, 0) |
	if(FilterLiens, Risk_Indicators.iid_constants.BSOptions.FilterLiens, 0);
	
layout_acctno := RECORD
	STRING30 acctno;
	Risk_Indicators.Layout_Input;
END;
	
layout_acctno iidPrep( inds_dist le, INTEGER c ) := TRANSFORM
	// save input data for output
	SELF.acctno := le.acctno;

	SELF.seq := le.seq;
	historydate := if(le.historyDateTimeStamp<>'',(unsigned)le.historyDateTimeStamp[1..6], le.historydateyyyymm);
  self.historydate := historydate;
	self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(le.historydateTimeStamp, le.historydateyyyymm);
  
  
	SELF.ssn := le.ssn;
	SELF.dob := le.dob;
	SELF.age := if ((INTEGER)le.age = 0 and (integer)le.dob != 0,
					(STRING3)ut.Age((unsigned)le.dob, (UNSIGNED)Risk_Indicators.iid_constants.myGetDate(historydate)), 
					(STRING)((INTEGER)le.age));
	SELF.phone10  := le.home_phone;
	SELF.wphone10 := le.work_phone;

	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	BOOLEAN valid_cleaned := le.UnParsedFullName <> '';
		
	SELF.fname  := STD.Str.ToUpperCase(IF(le.Name_First=''   AND valid_cleaned, cleaned_name[6..25], le.Name_First));
	SELF.lname  := STD.Str.ToUpperCase(IF(le.Name_Last=''    AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
	SELF.mname  := STD.Str.ToUpperCase(IF(le.Name_Middle=''  AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
	SELF.suffix := STD.Str.ToUpperCase(IF(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
	SELF.title  := STD.Str.ToUpperCase(IF(valid_cleaned, cleaned_name[1..5],''));

	street_address := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											

	SELF.in_streetAddress := street_address;
	SELF.in_city          := le.p_City_name;
	SELF.in_state         := le.St;
	SELF.in_zipCode       := le.Z5;
	//If running on Thor, we will call the AID address cache macro to populate these fields in the next transform to save processing time.
	
	// #IF(onThor)
		// SELF.prim_range    := '';
		// SELF.predir        := '';
		// SELF.prim_name     := '';
		// SELF.addr_suffix   := '';
		// SELF.postdir       := '';
		// SELF.unit_desig    := '';
		// SELF.sec_range     := '';
		// SELF.p_city_name   := '';
		// SELF.st            := '';
		// SELF.z5            := '';
		// SELF.zip4          := '';
		// SELF.lat           := '';
		// SELF.long          := '';
		// SELF.addr_type     := '';
		// SELF.addr_status   := '';
		// SELF.county        := '';
		// SELF.geo_blk       := '';
	// #ELSE
		SELF.prim_range    := clean_a2[1..10];
		SELF.predir        := clean_a2[11..12];
		SELF.prim_name     := clean_a2[13..40];
		SELF.addr_suffix   := clean_a2[41..44];
		SELF.postdir       := clean_a2[45..46];
		SELF.unit_desig    := clean_a2[47..56];
		SELF.sec_range     := clean_a2[57..65];
		SELF.p_city_name   := clean_a2[90..114];
		SELF.st            := clean_a2[115..116];
		SELF.z5            := clean_a2[117..121];
		SELF.zip4          := clean_a2[122..125];
		SELF.lat           := clean_a2[146..155];
		SELF.long          := clean_a2[156..166];
		SELF.addr_type     := clean_a2[139];
		SELF.addr_status   := clean_a2[179..182];
		SELF.county        := clean_a2[143..145];
		SELF.geo_blk       := clean_a2[171..177];	
	// #END

	SELF.dl_number := STD.Str.ToUpperCase(riskwise.cleanDL_num(le.dl_number));
	SELF.dl_state  := STD.Str.ToUpperCase(le.dl_state);

	self.email_address := STD.Str.ToUpperCase(le.email);
	SELF.ip_address := le.ip_addr;

// to speed up the query, accept the LexID on input instead of appending it again.
	SELF.DID := (UNSIGNED)le.LexID;
	SELF.score := if((UNSIGNED)le.lexid<>0, 100, 0);  // hard code the score to something greater than 0 to avoid trying to append DID by SSN in Risk_Indicators.iid_getDID_prepOutput
	
	SELF := [];
END;
	
iid_prep_acct_roxie := PROJECT(inds_dist, iidPrep(LEFT,COUNTER)) : PERSIST('~BOCASHELLFCRA::shell54_batchin_with_seq', expire(3));  // use persist instead of independent

// Now get ready to call AID Address Cache macro, which we will use if running thor version
r_layout_input_PlusRaw	:= RECORD
	layout_acctno;
	// add these 3 fields to existing layout anytime i want to use this macro
	STRING60	Line1;
	STRING60	LineLast;
	UNSIGNED8	rawAID;
end;

r_layout_input_PlusRaw	prep_for_AID(iid_prep_acct_roxie le)	:= transform
	SELF.Line1		:=	TRIM(STD.Str.ToUpperCase(le.in_streetAddress));
	SELF.LineLast	:=	address.addr2fromcomponents(STD.Str.ToUpperCase(le.in_city), STD.Str.ToUpperCase(le.in_state),  le.in_zipCode);
	SELF.rawAID			:=	0;
	SELF	:=	le;
end;
aid_prepped	:=	PROJECT(iid_prep_acct_roxie, prep_for_AID(left));

UNSIGNED4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;

AID.MacAppendFromRaw_2Line(	aid_prepped,
														Line1,
														LineLast,
														rawAID,
														my_dataset_with_address_cache,
														lAIDAppendFlags);

layout_acctno getCleanAddr_thor(my_dataset_with_address_cache le) := TRANSFORM
	SELF.prim_range      := le.aidwork_acecache.prim_range;
	SELF.predir          := le.aidwork_acecache.predir;
	SELF.prim_name       := le.aidwork_acecache.prim_name;
	SELF.addr_suffix     := le.aidwork_acecache.addr_suffix;
	SELF.postdir         := le.aidwork_acecache.postdir;
	SELF.unit_desig      := le.aidwork_acecache.unit_desig;
	SELF.sec_range       := le.aidwork_acecache.sec_range;
	SELF.p_city_name     := le.aidwork_acecache.p_city_name;
	SELF.st              := le.aidwork_acecache.st;
	SELF.z5              := le.aidwork_acecache.zip5;
	SELF.zip4            := le.aidwork_acecache.zip4;
	SELF.lat             := le.aidwork_acecache.geo_lat;
	SELF.long            := le.aidwork_acecache.geo_long;
	SELF.addr_type 			 := risk_indicators.iid_constants.override_addr_type(le.in_streetAddress, le.aidwork_acecache.rec_type[1],le.aidwork_acecache.cart);
	SELF.addr_status     := le.aidwork_acecache.err_stat;
	SELF.county          := le.aidwork_acecache.county[3..5]; //bytes 1-2 are state code, 3-5 are county number
	SELF.geo_blk         := le.aidwork_acecache.geo_blk;	
	self := le;
END;

iid_prep_acct_thor := PROJECT(my_dataset_with_address_cache, getCleanAddr_thor(LEFT));

#IF(onThor)
	// iid_prep_acct := iid_prep_acct_thor;
	iid_prep_acct := iid_prep_acct_roxie;  // for comparing apples to apples in address results, use the address cleaner roxie uses
#ELSE
	iid_prep_acct := iid_prep_acct_roxie;
#END	

iid_prep := PROJECT( iid_prep_acct, Risk_Indicators.Layout_Input );
output(choosen(iid_prep, eyeball), named('iid_prep'));

	
clam := risk_indicators.Boca_Shell_Function_FCRA( iid_prep, gateways, dppa, glb, isUtility, ln_branded, 
					require2ele, includeRel, includeDL, includeVeh, includeDerog, ofac_only, suppressNearDups, from_biid, excludeWatchlists, 
					from_IT1O, ofac_version, include_ofac, addtl_watchlists, watchlist_threshold, bsversion, isPreScreen, doScore, nugen, 
					ADL_Based_Shell := false, DataRestriction := DataRestrictionMask, 
					IN_AppendBest := AppendBest, BSOptions := BSOptions, DataPermission := DataPermission);


layout_final := record
	STRING AccountNumber;
	risk_indicators.Layout_Boca_Shell;
	string errorcode;
end;


riskprocessing.layouts.layout_internal_shell_noDatasets toFinal( clam le, iid_prep_acct ri ) := TRANSFORM
	self.AccountNumber := ri.acctno;
	self := le;
	self.errorcode := '';
  self := [];
end;
preEdina := join( clam, iid_prep_acct, left.seq=right.seq, toFinal(left,right), keep(1) );

OUTPUT (choosen(preEdina, eyeball), NAMED ('result'));
OUTPUT (preEdina, , outfile_name, CSV(QUOTE('"')));


f := project(preEdina, transform(riskprocessing.layouts.layout_internal_shell, self := left, self := []));
OUTPUT(CHOOSEN(f, eyeball), NAMED('infile'));

edina := Risk_Indicators.ToEdina_54(f, isFCRA, DataRestrictionMask, IntendedPurpose);

OUTPUT(CHOOSEN(edina,eyeball), NAMED('edina'));
OUTPUT(edina,, outfile_name+'_edina',CSV(QUOTE('"'))); // Write to disk.



