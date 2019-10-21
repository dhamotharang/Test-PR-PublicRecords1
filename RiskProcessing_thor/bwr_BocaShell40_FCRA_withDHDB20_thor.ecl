// Reads sample data from input file, runs bocashell 4.0 on thor, and appends the DHDB2.0 scores
// saves results in output files 
// Before running:
//   choose (or define) input file name and, if needed, output file name as well;
//   choose (or define) input layout;
//   check the number of records to read from input;
//   uncomment file-output, if needed;
//   check that the data restrictions are set appropriately, specifically  EN and EQ
//   eyeball is how many records you want to see on output, similar to record_limit except this is your intermediate result output count

IMPORT _Control, address, AID, AutoStandardI, Gateway, Risk_Indicators, RiskWise, ut;
onThor := _Control.Environment.OnThor; // TRUE = use thor (distributed) logic. FALSE = use keyed joins.
settingsOK := OnThor and _Control.Environment.OnVault and _Control.LibraryUse.ForceOff_AllLibraries;

#WORKUNIT('name', 'Shell 4.0 with DHDB2.0 scores' + 	if(settingsOK,  ' THOR ', ERROR(9,'Toggle OnThor OnVault LibraryUse') ) );  // throw an error here if the controls aren't set correctly

//====================================================
//=============== Configurable options =============== 
//====================================================

unsigned record_limit :=   0;    //number of records to read from input file; 0 means ALL
unsigned1 eyeball := 10;
string DataRestrictionMask := '1000010001000100000000000'; // to restrict fares, experian, transunion and experian FCRA 
string DataPermissionMask := '000000000000000000000000000000';

//===================  input-output files  ======================
prefix := '~foreign::' + _control.IPAddress.prod_thor_dali + '::';
infile_name :=  prefix + 'tfuerstenberg::in::wellsfargo_2377_app_in';
outfile_name := '~dvstemp::out::fcrashell40_dhdb20_' + thorlib.wuid();	// this will output your work unit number in your filename;

// Commenting out LastSeenThreshhold since it doesn't get passed through the FCRA shell
// unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 
history_date   := 0; // if this is set to 0, use historydateYYYYMM on input file. Use this historydate if it is > 0.
 
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
    integer historydateyyyymm;
  END;
 
ds_in := dataset (infile_name, layout_input, csv(quote('"')));
// ds_in1 := dataset (infile_name, layout_input, csv(quote('"')));
// ds_in := ds_in1(Account in ['67769','67775','67776','67778','67786','67790','67792','67801','67803','67805','67808']);
//=================
output(count(ds_in));

inds := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(inds, eyeball), NAMED ('input'));

layout_batch_in := record
	Risk_Indicators.CDIP_Layouts.Batch_In;
	string email;
end;

Batch_In := PROJECT(inds, TRANSFORM(layout_batch_in,
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
	SELF.email := left.email;
	SELF.HistoryDateYYYYMM := (unsigned)((string)LEFT.HistoryDateYYYYMM)[1..6];
  ));

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
	bsVersion           := 40;
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

  unsigned8 BSOptions := if(FilterLiens, Risk_Indicators.iid_constants.BSOptions.FilterLiens, 0);

layout_acctno := RECORD
	STRING30 acctno;
	Risk_Indicators.Layout_Input;
END;
	
layout_acctno iidPrep( inds_dist le) := TRANSFORM
	// save input data for output
	SELF.acctno := le.acctno;

	SELF.seq := le.seq;
	historydate := if(history_date=0, le.HistoryDateYYYYMM, history_date);
	SELF.historydate := historydate;							
	SELF.ssn := le.ssn;
	SELF.dob := le.dob;
	SELF.age := if ((INTEGER)le.age = 0 and (integer)le.dob != 0,
					(STRING3)ut.age((unsigned)le.dob, (UNSIGNED)Risk_Indicators.iid_constants.myGetDate(historydate)), 
					(STRING)((INTEGER)le.age));
	SELF.phone10  := le.home_phone;
	SELF.wphone10 := le.work_phone;

	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	BOOLEAN valid_cleaned := le.UnParsedFullName <> '';
		
	SELF.fname  := StringLib.StringToUppercase(IF(le.Name_First=''   AND valid_cleaned, cleaned_name[6..25], le.Name_First));
	SELF.lname  := StringLib.StringToUppercase(IF(le.Name_Last=''    AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
	SELF.mname  := StringLib.StringToUppercase(IF(le.Name_Middle=''  AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
	SELF.suffix := StringLib.StringToUppercase(IF(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
	SELF.title  := StringLib.StringToUppercase(IF(valid_cleaned, cleaned_name[1..5],''));

	street_address := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											

	SELF.in_streetAddress := street_address;
	SELF.in_city          := le.p_City_name;
	SELF.in_state         := le.St;
	SELF.in_zipCode       := le.Z5;
		//If running on Thor, we will call the AID address cache macro to populate these fields in the next transform to save processing time.
  // #IF(OnThor)  
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
  
	SELF.dl_number := StringLib.StringToUppercase(riskwise.cleanDL_num(le.dl_number));
	SELF.dl_state  := StringLib.StringToUppercase(le.dl_state);

	self.email_address := STD.Str.ToUpperCase(le.email);
	SELF.ip_address := le.ip_addr;

// to speed up the query, accept the LexID on input instead of appending it again.
	// SELF.DID := (UNSIGNED)le.LexID;
	// SELF.score := if((UNSIGNED)le.lexid<>0, 100, 0);  // hard code the score to something greater than 0 to avoid trying to append DID by SSN in Risk_Indicators.iid_getDID_prepOutput
		
	SELF := [];
END;
	
iid_prep_acct_roxie := PROJECT(inds_dist, iidPrep(LEFT)) : PERSIST('~BOCASHELLFCRA::shell40_batchin_with_seq', expire(3));  // use persist instead of independent;

// Now get ready to call AID Address Cache macro, which we will use if running thor version
r_layout_input_PlusRaw	:= RECORD
	layout_acctno;
	// add these 3 fields to existing layout anytime i want to use this macro
	STRING60	Line1;
	STRING60	LineLast;
	UNSIGNED8	rawAID;
end;

r_layout_input_PlusRaw	prep_for_AID(iid_prep_acct_roxie le)	:= transform
	SELF.Line1		:=	TRIM(stringlib.stringtouppercase(le.in_streetAddress));
	SELF.LineLast	:=	address.addr2fromcomponents(stringlib.stringtouppercase(le.in_city), stringlib.stringtouppercase(le.in_state),  le.in_zipCode);
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
	
clam := risk_indicators.Boca_Shell_Function_FCRA( iid_prep, gateways, dppa, glb, isUtility, ln_branded, 
					require2ele, includeRel, includeDL, includeVeh, includeDerog, ofac_only, suppressNearDups, from_biid, excludeWatchlists, 
					from_IT1O, ofac_version, include_ofac, addtl_watchlists, watchlist_threshold, bsversion, isPreScreen, doScore, nugen, 
					ADL_Based_Shell := false, DataRestriction := DataRestrictionMask, IN_AppendBest := AppendBest, BSOptions := BSOptions, DataPermission := DataPermission);


riskprocessing.layouts.layout_internal_shell_noDatasets toFinal( clam le, iid_prep_acct ri ) := TRANSFORM
	self.AccountNumber := ri.acctno;
	self := le;
	self.errorcode := '';
end;
preEdina := join( clam, iid_prep_acct, left.seq=right.seq, toFinal(left,right), keep(1) );

OUTPUT (choosen(preEdina, eyeball), NAMED ('result'));
OUTPUT (preEdina, , outfile_name, CSV(QUOTE('"')));


f := dataset(outfile_name, riskprocessing.layouts.layout_internal_shell_noDatasets, csv(quote('"'), maxlength(15000)));
output(choosen(f, eyeball), named('infile'));


risk_indicators.Layout_Boca_Shell_Edina_v4 convertToEdina_v4(f le) := transform
	self.address_verification.input_address_information.lres := le.lres;
	self.address_verification.address_history_1.lres := le.lres2;
	self.address_verification.address_history_2.lres := le.lres3;
	self.address_verification.input_address_information.addrPop := le.addrPop;
	self.address_verification.address_history_1.addrPop := le.addrPop2;
	self.address_verification.address_history_2.addrPop := le.addrPop3;
	self.address_verification.input_address_information.avm_land_use_code := le.avm.input_address_information.avm_land_use_code;
	self.address_verification.input_address_information.avm_recording_date := le.avm.input_address_information.avm_recording_date;
	self.address_verification.input_address_information.avm_assessed_value_year := le.avm.input_address_information.avm_assessed_value_year;
	self.address_verification.input_address_information.avm_sales_price := le.avm.input_address_information.avm_sales_price;  
	self.address_verification.input_address_information.avm_assessed_total_value := le.avm.input_address_information.avm_assessed_total_value;
	self.address_verification.input_address_information.avm_market_total_value := le.avm.input_address_information.avm_market_total_value;
	self.address_verification.input_address_information.avm_tax_assessment_valuation := le.avm.input_address_information.avm_tax_assessment_valuation;
	self.address_verification.input_address_information.avm_price_index_valuation := le.avm.input_address_information.avm_price_index_valuation;
	self.address_verification.input_address_information.avm_hedonic_valuation := le.avm.input_address_information.avm_hedonic_valuation;
	self.address_verification.input_address_information.avm_automated_valuation := le.avm.input_address_information.avm_automated_valuation;
	self.address_verification.input_address_information.avm_confidence_score := le.avm.input_address_information.avm_confidence_score;
	self.address_verification.input_address_information.avm_median_fips_level := le.avm.input_address_information.avm_median_fips_level;
	self.address_verification.input_address_information.avm_median_geo11_level := le.avm.input_address_information.avm_median_geo11_level;
	self.address_verification.input_address_information.avm_median_geo12_level := le.avm.input_address_information.avm_median_geo12_level;
	
	self.address_verification.address_history_1.avm_land_use_code := le.avm.address_history_1.avm_land_use_code;
	self.address_verification.address_history_1.avm_recording_date := le.avm.address_history_1.avm_recording_date;
	self.address_verification.address_history_1.avm_assessed_value_year := le.avm.address_history_1.avm_assessed_value_year;
	self.address_verification.address_history_1.avm_sales_price := le.avm.address_history_1.avm_sales_price;  
	self.address_verification.address_history_1.avm_assessed_total_value := le.avm.address_history_1.avm_assessed_total_value;
	self.address_verification.address_history_1.avm_market_total_value := le.avm.address_history_1.avm_market_total_value;
	self.address_verification.address_history_1.avm_tax_assessment_valuation := le.avm.address_history_1.avm_tax_assessment_valuation;
	self.address_verification.address_history_1.avm_price_index_valuation := le.avm.address_history_1.avm_price_index_valuation;
	self.address_verification.address_history_1.avm_hedonic_valuation := le.avm.address_history_1.avm_hedonic_valuation;
	self.address_verification.address_history_1.avm_automated_valuation := le.avm.address_history_1.avm_automated_valuation;
	self.address_verification.address_history_1.avm_confidence_score := le.avm.address_history_1.avm_confidence_score;
	self.address_verification.address_history_1.avm_median_fips_level := le.avm.address_history_1.avm_median_fips_level;
	self.address_verification.address_history_1.avm_median_geo11_level := le.avm.address_history_1.avm_median_geo11_level;
	self.address_verification.address_history_1.avm_median_geo12_level := le.avm.address_history_1.avm_median_geo12_level;
	
	SELF.Velocity_Counters.adlPerSSN_count := le.SSN_Verification.adlPerSSN_count;
	
	self.iid.socllowissue := (unsigned)le.iid.socllowissue;
	self.iid.soclhighissue := (unsigned)le.iid.soclhighissue;
	self.iid.areacodesplitdate := (unsigned)le.iid.areacodesplitdate;
	self.student.date_first_seen := (unsigned)le.student.date_first_seen;
	self.student.date_last_seen := (unsigned)le.student.date_last_seen;
	self.student.dob_formatted := (unsigned)le.student.dob_formatted;
	
	// new shell 2.5 fields				
	self.isFCRA := '1';
	self.fd_scores := [];	// fraudpoint not populated in non-fcra
	////////////
	
	//// new shell 3.0 fields
	self.cb_allowed := map(	dataRestrictionMask[14] not in ['1',''] and dataRestrictionMask[8]<>'1' and dataRestrictionMask[10]<>'1' => 'ALL',
			dataRestrictionMask[8]<>'1' => 'EQ',
			dataRestrictionMask[14] not in ['1',''] => 'EN',
			dataRestrictionMask[10]<>'1' => 'TN',
			'NONE');		// this should not happen
							
	self.iid.ConsumerFlags := le.ConsumerFlags;
	
	self.ssn_verification.inputsocscharflag := le.ssn_verification.validation.inputsocscharflag;
	
	SELF.Address_Verification.Address_History_1.addr_type := le.Address_Verification.addr_type2;
	self.Address_Verification.Address_History_2.addr_type := le.Address_Verification.addr_type3;

	self.input_dob_age := le.shell_input.age;
	
	self.Address_Verification.Input_Address_Information.building_area := (string)le.address_verification.input_address_information.building_area ;
	self.Address_Verification.Input_Address_Information.no_of_buildings := (string)le.address_verification.input_address_information.no_of_buildings ;
	self.Address_Verification.Input_Address_Information.no_of_stories := (string)le.address_verification.input_address_information.no_of_stories ;
	self.Address_Verification.Input_Address_Information.no_of_rooms := (string)le.address_verification.input_address_information.no_of_rooms ;
	self.Address_Verification.Input_Address_Information.no_of_bedrooms := (string)le.address_verification.input_address_information.no_of_bedrooms ;
	self.Address_Verification.Input_Address_Information.no_of_baths := (string)le.address_verification.input_address_information.no_of_baths;
	self.Address_Verification.Input_Address_Information.no_of_partial_baths := (string)le.address_verification.input_address_information.no_of_partial_baths ;
	self.Address_Verification.Input_Address_Information.parking_no_of_cars := (string)le.address_verification.input_address_information.parking_no_of_cars;
	self.Address_Verification.Input_Address_Information.avm_automated_valuation2 := le.avm.input_address_information.avm_automated_valuation2;
	self.Address_Verification.Input_Address_Information.avm_automated_valuation3 := le.avm.input_address_information.avm_automated_valuation3;
	self.Address_Verification.Input_Address_Information.avm_automated_valuation4 := le.avm.input_address_information.avm_automated_valuation4;
	self.Address_Verification.Input_Address_Information.avm_automated_valuation5 := le.avm.input_address_information.avm_automated_valuation5;
	self.Address_Verification.Input_Address_Information.avm_automated_valuation6 := le.avm.input_address_information.avm_automated_valuation6;
	
	self.address_verification.address_history_1.building_area := (string)le.address_verification.address_history_1.building_area ;
	self.address_verification.address_history_1.no_of_buildings := (string)le.address_verification.address_history_1.no_of_buildings ;
	self.address_verification.address_history_1.no_of_stories := (string)le.address_verification.address_history_1.no_of_stories ;
	self.address_verification.address_history_1.no_of_rooms := (string)le.address_verification.address_history_1.no_of_rooms ;
	self.address_verification.address_history_1.no_of_bedrooms := (string)le.address_verification.address_history_1.no_of_bedrooms ;
	self.address_verification.address_history_1.no_of_baths := (string)le.address_verification.address_history_1.no_of_baths;
	self.address_verification.address_history_1.no_of_partial_baths := (string)le.address_verification.address_history_1.no_of_partial_baths ;
	self.address_verification.address_history_1.parking_no_of_cars := (string)le.address_verification.address_history_1.parking_no_of_cars;
	self.Address_Verification.Address_History_1.avm_automated_valuation2 := le.avm.address_history_1.avm_automated_valuation2;
	self.Address_Verification.Address_History_1.avm_automated_valuation3 := le.avm.address_history_1.avm_automated_valuation3;
	self.Address_Verification.Address_History_1.avm_automated_valuation4 := le.avm.address_history_1.avm_automated_valuation4;
	self.Address_Verification.Address_History_1.avm_automated_valuation5 := le.avm.address_history_1.avm_automated_valuation5;
	self.Address_Verification.Address_History_1.avm_automated_valuation6 := le.avm.address_history_1.avm_automated_valuation6;
	
	self.bjl.liens := le.liens;
	
	// attribute fields added
	self.attributes.addrs_last30 := le.other_address_info.addrs_last30;
	self.attributes.addrs_last90 := le.other_address_info.addrs_last90;
	self.attributes.addrs_last12 := le.other_address_info.addrs_last12;
	self.attributes.addrs_last24 := le.other_address_info.addrs_last24;
	self.attributes.addrs_last36 := le.other_address_info.addrs_last36;
	self.attributes.date_first_purchase := le.other_address_info.date_first_purchase;	
	self.attributes.date_most_recent_purchase := le.other_address_info.date_most_recent_purchase;	
	self.attributes.date_most_recent_sale := le.other_address_info.date_most_recent_sale;	
	self.attributes.num_purchase30 := le.other_address_info.num_purchase30;
	self.attributes.num_purchase90 := le.other_address_info.num_purchase90;
	self.attributes.num_purchase180 := le.other_address_info.num_purchase180;
	self.attributes.num_purchase12 := le.other_address_info.num_purchase12;
	self.attributes.num_purchase24 := le.other_address_info.num_purchase24;
	self.attributes.num_purchase36 := le.other_address_info.num_purchase36;
	self.attributes.num_purchase60 := le.other_address_info.num_purchase60;
	self.attributes.num_sold30 := le.other_address_info.num_sold30;
	self.attributes.num_sold90 := le.other_address_info.num_sold90;
	self.attributes.num_sold180 := le.other_address_info.num_sold180;
	self.attributes.num_sold12 := le.other_address_info.num_sold12;
	self.attributes.num_sold24 := le.other_address_info.num_sold24;
	self.attributes.num_sold36 := le.other_address_info.num_sold36;
	self.attributes.num_sold60 := le.other_address_info.num_sold60;
	self.attributes.num_watercraft30 := le.watercraft.watercraft_count30;
	self.attributes.num_watercraft90 := le.watercraft.watercraft_count90;
	self.attributes.num_watercraft180 := le.watercraft.watercraft_count180;
	self.attributes.num_watercraft12 := le.watercraft.watercraft_count12;
	self.attributes.num_watercraft24 := le.watercraft.watercraft_count24;
	self.attributes.num_watercraft36 := le.watercraft.watercraft_count36;
	self.attributes.num_watercraft60 := le.watercraft.watercraft_count60;
	self.attributes.num_aircraft := le.aircraft.aircraft_count;
	self.attributes.num_aircraft30 := le.aircraft.aircraft_count30;
	self.attributes.num_aircraft90 := le.aircraft.aircraft_count90;
	self.attributes.num_aircraft180 := le.aircraft.aircraft_count180;
	self.attributes.num_aircraft12 := le.aircraft.aircraft_count12;
	self.attributes.num_aircraft24 := le.aircraft.aircraft_count24;
	self.attributes.num_aircraft36 := le.aircraft.aircraft_count36;
	self.attributes.num_aircraft60 := le.aircraft.aircraft_count60;
	self.attributes.total_number_derogs := le.total_number_derogs;
	self.attributes.date_last_derog := le.date_last_derog;
	self.attributes.felonies30 := le.bjl.criminal_count30;
	self.attributes.felonies90 := le.bjl.criminal_count90;
	self.attributes.felonies180 := le.bjl.criminal_count180;
	self.attributes.felonies12 := le.bjl.criminal_count12;
	self.attributes.felonies24 := le.bjl.criminal_count24;
	self.attributes.felonies36 := le.bjl.criminal_count36;
	self.attributes.felonies60 := le.bjl.criminal_count60;
	self.attributes.arrests := le.bjl.arrests_count;
	self.attributes.date_last_arrest := le.bjl.date_last_arrest;	
	self.attributes.arrests30 := le.bjl.arrests_count30;
	self.attributes.arrests90 := le.bjl.arrests_count90;
	self.attributes.arrests180 := le.bjl.arrests_count180;
	self.attributes.arrests12 := le.bjl.arrests_count12;
	self.attributes.arrests24 := le.bjl.arrests_count24;
	self.attributes.arrests36 := le.bjl.arrests_count36;
	self.attributes.arrests60 := le.bjl.arrests_count60;
	self.attributes.num_unreleased_liens30 := le.bjl.liens_unreleased_count30;
	self.attributes.num_unreleased_liens90 := le.bjl.liens_unreleased_count90;
	self.attributes.num_unreleased_liens180 := le.bjl.liens_unreleased_count180;
	self.attributes.num_unreleased_liens12 := le.bjl.liens_unreleased_count12;
	self.attributes.num_unreleased_liens24 := le.bjl.liens_unreleased_count24;
	self.attributes.num_unreleased_liens36 := le.bjl.liens_unreleased_count36;
	self.attributes.num_unreleased_liens60 := le.bjl.liens_unreleased_count60;
	self.attributes.num_released_liens30 := le.bjl.liens_released_count30;
	self.attributes.num_released_liens90 := le.bjl.liens_released_count90;
	self.attributes.num_released_liens180 := le.bjl.liens_released_count180;
	self.attributes.num_released_liens12 := le.bjl.liens_released_count12;
	self.attributes.num_released_liens24 := le.bjl.liens_released_count24;
	self.attributes.num_released_liens36 := le.bjl.liens_released_count36;
	self.attributes.num_released_liens60 := le.bjl.liens_released_count60;
	self.attributes.bankruptcy_count30 := le.bjl.bk_count30;
	self.attributes.bankruptcy_count90 := le.bjl.bk_count90;
	self.attributes.bankruptcy_count180 := le.bjl.bk_count180;
	self.attributes.bankruptcy_count12 := le.bjl.bk_count12;
	self.attributes.bankruptcy_count24 := le.bjl.bk_count24;
	self.attributes.bankruptcy_count36 := le.bjl.bk_count36;
	self.attributes.bankruptcy_count60 := le.bjl.bk_count60;
	self.attributes.eviction_count := le.bjl.eviction_count;
	self.attributes.date_last_eviction := le.bjl.last_eviction_date;
	self.attributes.eviction_count30 := le.bjl.eviction_count30;
	self.attributes.eviction_count90 := le.bjl.eviction_count90;
	self.attributes.eviction_count180 := le.bjl.eviction_count180;
	self.attributes.eviction_count12 := le.bjl.eviction_count12;
	self.attributes.eviction_count24 := le.bjl.eviction_count24;
	self.attributes.eviction_count36 := le.bjl.eviction_count36;
	self.attributes.eviction_count60 := le.bjl.eviction_count60;
	self.attributes.num_nonderogs := le.source_verification.num_nonderogs;
	self.attributes.num_nonderogs30 := le.source_verification.num_nonderogs30;
	self.attributes.num_nonderogs90 := le.source_verification.num_nonderogs90;
	self.attributes.num_nonderogs180 := le.source_verification.num_nonderogs180;
	self.attributes.num_nonderogs12 := le.source_verification.num_nonderogs12;
	self.attributes.num_nonderogs24 := le.source_verification.num_nonderogs24;
	self.attributes.num_nonderogs36 := le.source_verification.num_nonderogs36;
	self.attributes.num_nonderogs60 := le.source_verification.num_nonderogs60;
	self.attributes.num_proflic30 := le.professional_license.proflic_count30;
	self.attributes.num_proflic90 := le.professional_license.proflic_count90;
	self.attributes.num_proflic180 := le.professional_license.proflic_count180;
	self.attributes.num_proflic12 := le.professional_license.proflic_count12;
	self.attributes.num_proflic24 := le.professional_license.proflic_count24;
	self.attributes.num_proflic36 := le.professional_license.proflic_count36;
	self.attributes.num_proflic60 := le.professional_license.proflic_count60;
	self.attributes.num_proflic_exp30 := le.professional_license.expire_count30;
	self.attributes.num_proflic_exp90 := le.professional_license.expire_count90;
	self.attributes.num_proflic_exp180 := le.professional_license.expire_count180;
	self.attributes.num_proflic_exp12 := le.professional_license.expire_count12;
	self.attributes.num_proflic_exp24 := le.professional_license.expire_count24;
	self.attributes.num_proflic_exp36 := le.professional_license.expire_count36;
	self.attributes.num_proflic_exp60 := le.professional_license.expire_count60;
	
	self.infutor := le.infutor_phone;	// puts the infutor phone results into the infutor spot to match previous output
	self.iid.correctlast := if(le.iid.correctlast<>'', '1','0');	// brent doesn't want to see lastnames, so populate with a 1 or 0
	
	// new mappings for shell 4.0
	self.student.college_major := le.student.college_major;  // won't need this when college major put into the student section correctly
	self.velocity_counters.lnames_per_adl_created_6months := le.velocity_counters.lnames_per_adl180;
	self.address_verification.address_history_2.avm_automated_valuation := le.avm.address_history_2.avm_automated_valuation;
	
	self.address_verification.input_address_information.market_total_value := le.address_verification.input_address_information.assessed_amount;
	self.address_verification.address_history_1.market_total_value := le.address_verification.address_history_1.assessed_amount;
	self.address_verification.address_history_2.market_total_value := le.address_verification.address_history_2.assessed_amount;
	
	self.Other_Address_Info.unique_addr_cnt := le.address_history_summary.unique_addr_cnt;
	self.Other_Address_Info.avg_mo_per_addr := le.address_history_summary.avg_mo_per_addr;
	self.Other_Address_Info.addr_count2 := le.address_history_summary.addr_count2;
	self.Other_Address_Info.addr_count3 := le.address_history_summary.addr_count3;
	self.Other_Address_Info.addr_count6 := le.address_history_summary.addr_count6;
	self.Other_Address_Info.addr_count10 := le.address_history_summary.addr_count10;
	self.Other_Address_Info.lres_2mo_count := le.address_history_summary.lres_2mo_count;
	self.Other_Address_Info.lres_6mo_count := le.address_history_summary.lres_6mo_count ;
	self.Other_Address_Info.lres_12mo_count := le.address_history_summary.lres_12mo_count;
	self.Other_Address_Info.hist_addr_match := le.address_history_summary.hist_addr_match;	
	self.Other_Address_Info.address_history_advo_college_hit := le.address_history_summary.address_history_advo_college_hit;
	
	self.Address_Verification.Input_Address_Information.Address_Vacancy_Indicator	:= le.advo_input_addr.Address_Vacancy_Indicator	;
	self.Address_Verification.Input_Address_Information.Throw_Back_Indicator := le.advo_input_addr.Throw_Back_Indicator	;
	self.Address_Verification.Input_Address_Information.Seasonal_Delivery_Indicator := le.advo_input_addr.Seasonal_Delivery_Indicator;
	self.Address_Verification.Input_Address_Information.DND_Indicator := le.advo_input_addr.DND_Indicator	;
	self.Address_Verification.Input_Address_Information.College_Indicator := le.advo_input_addr.College_Indicator;
	self.Address_Verification.Input_Address_Information.Drop_Indicator	:= le.advo_input_addr.Drop_Indicator;
	self.Address_Verification.Input_Address_Information.Residential_or_Business_Ind	:= le.advo_input_addr.Residential_or_Business_Ind	;
	self.Address_Verification.Input_Address_Information.Mixed_Address_Usage := le.advo_input_addr.Mixed_Address_Usage;
	
	self.Address_Verification.Input_Address_Information.occupants_1yr := le.addr_risk_summary.occupants_1yr ;
	self.Address_Verification.Input_Address_Information.turnover_1yr_in := le.addr_risk_summary.turnover_1yr_in ;
	self.Address_Verification.Input_Address_Information.turnover_1yr_out := le.addr_risk_summary.turnover_1yr_out ;
	self.Address_Verification.Input_Address_Information.N_Vacant_Properties := le.addr_risk_summary.N_Vacant_Properties;
	self.Address_Verification.Input_Address_Information.N_Business_Count := le.addr_risk_summary.N_Business_Count ;
	self.Address_Verification.Input_Address_Information.N_SFD_Count := le.addr_risk_summary.N_SFD_Count ;
	self.Address_Verification.Input_Address_Information.N_MFD_Count := le.addr_risk_summary.N_MFD_Count;
	self.Address_Verification.Input_Address_Information.N_ave_building_age := le.addr_risk_summary.N_ave_building_age;
	self.Address_Verification.Input_Address_Information.N_ave_purchase_amount := le.addr_risk_summary.N_ave_purchase_amount ;
	self.Address_Verification.Input_Address_Information.N_ave_mortgage_amount := le.addr_risk_summary.N_ave_mortgage_amount ;
	self.Address_Verification.Input_Address_Information.N_ave_assessed_amount := le.addr_risk_summary.N_ave_assessed_amount ;
	self.Address_Verification.Input_Address_Information.N_ave_building_area := le.addr_risk_summary.N_ave_building_area ;
	self.Address_Verification.Input_Address_Information.N_ave_price_per_sf := le.addr_risk_summary.N_ave_price_per_sf ;
	self.Address_Verification.Input_Address_Information.N_ave_no_of_stories_count := le.addr_risk_summary.N_ave_no_of_stories_count ;
	self.Address_Verification.Input_Address_Information.N_ave_no_of_rooms_count := le.addr_risk_summary.N_ave_no_of_rooms_count ;
	self.Address_Verification.Input_Address_Information.N_ave_no_of_bedrooms_count := le.addr_risk_summary.N_ave_no_of_bedrooms_count ;
	self.Address_Verification.Input_Address_Information.N_ave_no_of_baths_count := le.addr_risk_summary.N_ave_no_of_baths_count ;	

	self.Address_Verification.Address_History_1.Address_Vacancy_Indicator	:= le.advo_addr_hist1.Address_Vacancy_Indicator	;
	self.Address_Verification.Address_History_1.Throw_Back_Indicator := le.advo_addr_hist1.Throw_Back_Indicator	;
	self.Address_Verification.Address_History_1.Seasonal_Delivery_Indicator := le.advo_addr_hist1.Seasonal_Delivery_Indicator;
	self.Address_Verification.Address_History_1.DND_Indicator := le.advo_addr_hist1.DND_Indicator	;
	self.Address_Verification.Address_History_1.College_Indicator := le.advo_addr_hist1.College_Indicator;
	self.Address_Verification.Address_History_1.Drop_Indicator	:= le.advo_addr_hist1.Drop_Indicator;
	self.Address_Verification.Address_History_1.Residential_or_Business_Ind	:= le.advo_addr_hist1.Residential_or_Business_Ind	;
	self.Address_Verification.Address_History_1.Mixed_Address_Usage := le.advo_addr_hist1.Mixed_Address_Usage;
	
	self.Address_Verification.Address_History_1.occupants_1yr := le.addr_risk_summary2.occupants_1yr ;
	self.Address_Verification.Address_History_1.turnover_1yr_in := le.addr_risk_summary2.turnover_1yr_in ;
	self.Address_Verification.Address_History_1.turnover_1yr_out := le.addr_risk_summary2.turnover_1yr_out ;
	self.Address_Verification.Address_History_1.N_Vacant_Properties := le.addr_risk_summary2.N_Vacant_Properties;
	self.Address_Verification.Address_History_1.N_Business_Count := le.addr_risk_summary2.N_Business_Count ;
	self.Address_Verification.Address_History_1.N_SFD_Count := le.addr_risk_summary2.N_SFD_Count ;
	self.Address_Verification.Address_History_1.N_MFD_Count := le.addr_risk_summary2.N_MFD_Count;
	self.Address_Verification.Address_History_1.N_ave_building_age := le.addr_risk_summary2.N_ave_building_age;
	self.Address_Verification.Address_History_1.N_ave_purchase_amount := le.addr_risk_summary2.N_ave_purchase_amount ;
	self.Address_Verification.Address_History_1.N_ave_mortgage_amount := le.addr_risk_summary2.N_ave_mortgage_amount ;
	self.Address_Verification.Address_History_1.N_ave_assessed_amount := le.addr_risk_summary2.N_ave_assessed_amount ;
	self.Address_Verification.Address_History_1.N_ave_building_area := le.addr_risk_summary2.N_ave_building_area ;
	self.Address_Verification.Address_History_1.N_ave_price_per_sf := le.addr_risk_summary2.N_ave_price_per_sf ;
	self.Address_Verification.Address_History_1.N_ave_no_of_stories_count := le.addr_risk_summary2.N_ave_no_of_stories_count ;
	self.Address_Verification.Address_History_1.N_ave_no_of_rooms_count := le.addr_risk_summary2.N_ave_no_of_rooms_count ;
	self.Address_Verification.Address_History_1.N_ave_no_of_bedrooms_count := le.addr_risk_summary2.N_ave_no_of_bedrooms_count ;
	self.Address_Verification.Address_History_1.N_ave_no_of_baths_count := le.addr_risk_summary2.N_ave_no_of_baths_count ;	

	self.student.file_type := le.student.file_type2;
	
	self := le;
end;
edina := project(f, convertToEdina_v4(left));
output(choosen(edina, eyeball), named('edina'));
output(edina,, outfile_name+'_edina_v4',CSV(QUOTE('"')));

// calculate the models with the boca shell results

MV := Models.MV361006_0_0(ungroup(project(f, transform(risk_indicators.Layout_Boca_Shell, self := left, self := [];))));
MX := Models.MX361006_0_0(ungroup(project(f, transform(risk_indicators.Layout_Boca_Shell, self := left, self := [];))));
WOMV := Models.WOMV002_0_0(ungroup(project(f, transform(risk_indicators.Layout_Boca_Shell, self := left, self := [];))));
MNC := Models.MNC21106_0_0(ungroup(project(f, transform(risk_indicators.Layout_Boca_Shell, self := left, self := [];))));
		
working_layout := record
	risk_indicators.Layout_Boca_Shell_Edina_v4 clam;
	real4 MV_score := 0;
	real4 MX_score := 0;
	real4 WOMV_score := 0;
	real4 MNC_score := 0;
end;

working_layout addModelMV( edina le, recordof(MV) ri) := TRANSFORM
	self.clam := le;
	self.MV_score := ri.score;
END;
withModel := join( edina, MV, left.seq=right.seq, addModelMV(left,right), left outer, keep(1) );


working_layout addModelMX( withModel le, recordof(MX) ri) := TRANSFORM
	self.clam := le.clam;
	self.MV_score := le.MV_score;
	self.MX_score := ri.score;
END;
withModel2 := join(withModel, MX, left.clam.seq=right.seq, addModelMX(left,right), left outer, keep(1));


working_layout addModelWOMV( withModel2 le, recordof(WOMV) ri) := TRANSFORM
	self.clam := le.clam;
	self.MV_score := le.MV_score;
	self.MX_score := le.MX_score;
	self.WOMV_score := ri.score;
END;
withModel3 := join(withModel2, WOMV, left.clam.seq=right.seq, addModelWOMV(left,right), left outer, keep(1));


working_layout addModelMNC( withModel3 le, recordof(MNC) ri) := TRANSFORM
	self.clam := le.clam;
	self.MV_score := le.MV_score;
	self.MX_score := le.MX_score;
	self.WOMV_score := le.WOMV_score;
	self.MNC_score := ri.score;
END;
withModel4 := join(withModel3, MNC, left.clam.seq=right.seq, addModelMNC(left,right), left outer, keep(1));


output(choosen(withModel4, eyeball), named('final'));
OUTPUT (withModel4, , outfile_name + '_final', CSV(QUOTE('"')));

