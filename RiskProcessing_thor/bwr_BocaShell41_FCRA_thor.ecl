#workunit('name','FCRA Bocashell 4.1 Process on thor');

// Reads sample data from input file, makes a SOAP call to service specified and (optionally),
// saves results in output file. 
// Before running:
//   choose (or define) input file name and, if needed, output file name as well;
//   choose (or define) input layout;
//   check the number of records to read from input;
//   uncomment file-output, if needed;
//   check that the data restrictions are set appropriately, specifically  EN and EQ
//   eyeball is how many records you want to see on output, similar to record_limit except this is your intermediate result output count

IMPORT _Control, address, AID, AutoStandardI, Gateway, Risk_Indicators, RiskWise, ut;
onThor := _Control.Environment.OnThor;

//====================================================
//=============== Configurable options =============== 
//====================================================

unsigned record_limit :=   0;    //number of records to read from input file; 0 means ALL
unsigned1 eyeball := 10;
string DataRestrictionMask := '1000010001000100000000000'; // to restrict fares, experian, transunion and experian FCRA 
// Commenting out LastSeenThreshhold since it doesn't get passed through the FCRA shell
// unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 
history_date   := 0; // if this is set to 0, use historydateYYYYMM on input file. Use this historydate if it is > 0.
 
//===================  input-output files  ======================
infile_name :=  '~tfuerstenberg::in::wellsfargo_2377_app_in';
outfile_name := '~lweiner::out::fcrashell41_' + thorlib.wuid();	// this will output your work unit number in your filename;

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

Batch_In := PROJECT(inds, TRANSFORM(Risk_Indicators.CDIP_Layouts.Batch_In,
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
	SELF.HistoryDateYYYYMM := LEFT.HistoryDateYYYYMM;));

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
	bsVersion           := 41;
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
					(STRING3)ut.GetAgeI_asOf((unsigned)le.dob, (UNSIGNED)Risk_Indicators.iid_constants.myGetDate(historydate)), 
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
  #IF(OnThor)  
    SELF.prim_range    := '';
    SELF.predir        := '';
    SELF.prim_name     := '';
    SELF.addr_suffix   := '';
    SELF.postdir       := '';
    SELF.unit_desig    := '';
    SELF.sec_range     := '';
    SELF.p_city_name   := '';
    SELF.st            := '';
    SELF.z5            := '';
    SELF.zip4          := '';
    SELF.lat           := '';
    SELF.long          := '';
    SELF.addr_type     := '';
    SELF.addr_status   := '';
    SELF.county        := '';
    SELF.geo_blk       := '';
  #ELSE
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
  #END
  
	SELF.dl_number := StringLib.StringToUppercase(riskwise.cleanDL_num(le.dl_number));
	SELF.dl_state  := StringLib.StringToUppercase(le.dl_state);

	SELF.ip_address := le.ip_addr;

// to speed up the query, accept the LexID on input instead of appending it again.
	// SELF.DID := (UNSIGNED)le.LexID;
	// SELF.score := if((UNSIGNED)le.lexid<>0, 100, 0);  // hard code the score to something greater than 0 to avoid trying to append DID by SSN in Risk_Indicators.iid_getDID_prepOutput
		
	SELF := [];
END;
	
iid_prep_acct_roxie := PROJECT(inds_dist, iidPrep(LEFT));

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
	iid_prep_acct := iid_prep_acct_thor;
#ELSE
	iid_prep_acct := iid_prep_acct_roxie;
#END

iid_prep := PROJECT( iid_prep_acct, Risk_Indicators.Layout_Input );
	
clam := risk_indicators.Boca_Shell_Function_FCRA( iid_prep, gateways, dppa, glb, isUtility, ln_branded, 
					require2ele, includeRel, includeDL, includeVeh, includeDerog, ofac_only, suppressNearDups, from_biid, excludeWatchlists, 
					from_IT1O, ofac_version, include_ofac, addtl_watchlists, watchlist_threshold, bsversion, isPreScreen, doScore, nugen, 
					ADL_Based_Shell := false, DataRestriction := DataRestrictionMask, IN_AppendBest := AppendBest, BSOptions := BSOptions, DataPermission := DataPermission);

layout_final := record
	STRING AccountNumber;
	risk_indicators.Layout_Boca_Shell;
	string errorcode;
end;

layout_final toFinal( clam le, iid_prep_acct ri ) := TRANSFORM
	self.AccountNumber := ri.acctno;
	self := le;
	self.errorcode := '';
end;
preEdina := join( clam, iid_prep_acct, left.seq=right.seq, toFinal(left,right), keep(1) );

OUTPUT (choosen(preEdina, eyeball), NAMED ('result'));
OUTPUT (preEdina, , outfile_name, CSV(QUOTE('"')));
// OUTPUT (preEdina, , outfile_name, __compressed__);

edina := Risk_Indicators.ToEdina_v41(preEdina, isFCRA, DataRestrictionMask);

output(edina, named('edina'));
output(edina,, outfile_name+'_edina_v41',CSV(QUOTE('"')));
// output(edina,, outfile_name+'_edina_v41',__compressed__);
