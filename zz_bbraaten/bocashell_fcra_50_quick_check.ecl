// EXPORT bocashell_fcra_50_quick_check := 'todo';

IMPORT AID, address, riskwise, ut, Gateway, AutoStandardi, risk_indicators, RiskProcessing;

 onThor := TRUE;	//Use thor logic (distributed data)
// onThor := FALSE;  //Use roxie logic (Keyed JOINS): Use this for testing small batches.

#WORKUNIT('name', 'FCRA Boca Shell 5.0 ' + 	if(onThor, 'thor ', 'roxie ') );
#STORED('did_add_force', if(onThor, 'thor', 'roxi') );  // stored parameter used inside the DID append macro to determine which version of the macro to use
#OPTION('multiplePersistInstances', FALSE); // doesn't rename the persist files for each job
#OPTION('embeddedWarningsAsErrors',0);

RecordsToRun := 0;
//RecordsToRun := 0; //Run all records

eyeball_count := 10;

// test_file_name := '~lweiner::out::raw_input201603';
test_file_name := '~lweiner::out::fcra_bocashell_input_from_header';

BOOLEAN RetainInputDID := TRUE;
//BOOLEAN RetainInputDID := FALSE;

STRING DataRestriction := Risk_Indicators.iid_constants.default_DataRestriction;
STRING50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission;
	
BOOLEAN IncludeLnJ := FALSE;
	
inlayout := RECORD
  string30 account;
  string20 firstname;
  string1 middlename;
  string20 lastname;
  string50 streetaddress;
  string28 city;
  string2 state;
  string5 zip;
  string10 homephone;
  string9 ssn;
  string8 dateofbirth;
  string10 workphone;
  string income;
  string25 dlnumber;
  string2 dlstate;
  string balance;
  string chargeoffd;
  string formername;
  string email;
  string employername;
  string8 historydate;
  unsigned6 did;
END;
 
inds := IF(RecordsToRun=0, DATASET(test_file_name, inlayout, csv(quote('"'), heading(single))),
					CHOOSEN(DATASET(test_file_name, inlayout, csv(quote('"'), heading(single))), RecordsToRun));
 
inds_dist := DISTRIBUTE(inds); //Distribute randomly
 
 batch_in50 := RECORD
	Risk_Indicators.Layout_Batch_In - HistoryDateYYYYMM;
	STRING20 HistoryDateTimeStamp;
	STRING12 	LexID;
END;
	
Batch_In := PROJECT(inds_dist, TRANSFORM(batch_in50,
	SELF.seq := COUNTER,
	SELF.acctno := LEFT.account,
	SELF.SSN := LEFT.SSN,
	SELF.unParsedFullName := '',
	SELF.Name_First := LEFT.firstname,
	SELF.Name_Middle := LEFT.middlename,
	SELF.Name_Last := LEFT.lastname,
	SELF.Name_Suffix := '',
	SELF.dob := LEFT.dateofbirth,
	SELF.street_addr := LEFT.streetaddress,
	SELF.p_city_name := LEFT.City,
	SELF.st := LEFT.state,
	SELF.Z5 := LEFT.zip,
	SELF.DL_Number := LEFT.dlnumber,
	SELF.DL_State := LEFT.dlstate,
	SELF.Home_Phone := LEFT.homephone,
	SELF.Work_Phone := LEFT.workphone,
	SELF.LexID := (STRING)LEFT.did,
	SELF := []));
	
/* IID & Boca Shell Values */
UNSIGNED1 dppa := 0;
UNSIGNED1 glb  := AutoStandardI.Constants.GLBPurpose_default;
gateways := Gateway.Constants.void_gateway;
isUtility           := false;
includeRel          := false;
includeDL           := true;
includeVeh          := false;
includeDerog        := true;
bsVersion           := 50;
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
BOOLEAN isPreScreen := false;
UNSIGNED1 AppendBest := 1;		// search best file
BOOLEAN FilterLiens := DataRestriction[Risk_Indicators.iid_constants.posLiensJudgRestriction]='1' ;
UNSIGNED8 BSOptions := 	IF(RetainInputDID, Risk_Indicators.iid_constants.BSOptions.RetainInputDID, 0) +
												IF(FilterLiens, Risk_Indicators.iid_constants.BSOptions.FilterLiens, 0);
	
layout_acctno := RECORD
	UNSIGNED4 input_seq;
	STRING30 acctno;
	Risk_Indicators.Layout_Input;
END;
	
layout_acctno iidPrep( batch_in le, INTEGER c ) := TRANSFORM
	// save input data for output
	SELF.input_seq := le.seq;
	SELF.acctno := le.acctno;

	SELF.seq := c; // input seq is overwritten. abandon all hope, ye who enter here.
	historydate := if(le.HistoryDateTimeStamp='',
										Risk_Indicators.iid_constants.default_history_date,
										(UNSIGNED)le.HistoryDateTimeStamp[1..6]);
	SELF.historydate := if(le.historyDateTimeStamp<>'',(unsigned)le.historyDateTimeStamp[1..6], historydate);								
	SELF.historyDateTimeStamp := Risk_Indicators.iid_constants.mygetdateTimeStamp(le.historydateTimeStamp, historydate);							
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
	SELF.prim_range    := IF(onThor, '', clean_a2[1..10]);
	SELF.predir        := IF(onThor, '',clean_a2[11..12]);
	SELF.prim_name     := IF(onThor, '',clean_a2[13..40]);
	SELF.addr_suffix   := IF(onThor, '',clean_a2[41..44]);
	SELF.postdir       := IF(onThor, '',clean_a2[45..46]);
	SELF.unit_desig    := IF(onThor, '',clean_a2[47..56]);
	SELF.sec_range     := IF(onThor, '',clean_a2[57..65]);
	SELF.p_city_name   := IF(onThor, '',clean_a2[90..114]);
	SELF.st            := IF(onThor, '',clean_a2[115..116]);
	SELF.z5            := IF(onThor, '',clean_a2[117..121]);
	SELF.zip4          := IF(onThor, '',clean_a2[122..125]);
	SELF.lat           := IF(onThor, '',clean_a2[146..155]);
	SELF.long          := IF(onThor, '',clean_a2[156..166]);
	SELF.addr_type     := IF(onThor, '',clean_a2[139]);
	SELF.addr_status   := IF(onThor, '',clean_a2[179..182]);
	SELF.county        := IF(onThor, '',clean_a2[143..145]);
	SELF.geo_blk       := IF(onThor, '',clean_a2[171..177]);

	SELF.dl_number := StringLib.StringToUppercase(riskwise.cleanDL_num(le.dl_number));
	SELF.dl_state  := StringLib.StringToUppercase(le.dl_state);

	SELF.ip_address := le.ip_addr;

// to speed up the query, accept the LexID on input instead of appending it again.
	SELF.DID := (UNSIGNED)le.LexID;
	SELF.score := if((UNSIGNED)le.lexid<>0, 100, 0);  // hard code the score to something greater than 0 to avoid trying to append DID by SSN in Risk_Indicators.iid_getDID_prepOutput
		
	SELF := [];
END;
	
iid_prep_acct_roxie := PROJECT(batch_in, iidPrep(LEFT,COUNTER));

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

iid_prep_acct := IF(onThor, iid_prep_acct_thor, iid_prep_acct_roxie);

iid_prep := PROJECT( iid_prep_acct, Risk_Indicators.Layout_Input );

// OUTPUT(iid_prep,, '~lweiner::out::FCRA_Boca_Shell_50_prep_' + IF(onThor, 'thor_', 'roxie_') + thorlib.wuid(), __COMPRESSED__);

clam := Risk_Indicators.Boca_Shell_Function_FCRA( iid_prep, gateways, dppa, glb, isUtility, ln_branded, 
				require2ele, includeRel, includeDL, includeVeh, includeDerog, ofac_only, suppressNearDups, from_biid, excludeWatchlists, 
				from_IT1O, ofac_version, include_ofac, addtl_watchlists, watchlist_threshold, bsversion, isPreScreen, doScore, nugen, 
				ADL_Based_Shell := false, DataRestriction := DataRestriction, IN_AppendBest := AppendBest, BSOptions := BSOptions, 
				DataPermission := DataPermission, IncludeLnJ := IncludeLnJ, onThor := onThor);

RiskProcessing.Layouts.Layout_Internal_Shell-time_ms toFinal( clam le, iid_prep_acct ri ) := TRANSFORM
	SELF.AccountNumber := ri.acctno;
	SELF := le;
	SELF.errorcode := '';
END;
		
preEdina := JOIN( clam, iid_prep_acct, LEFT.seq=RIGHT.seq, toFinal(LEFT,RIGHT), KEEP(1) );

OUTPUT(CHOOSEN(preEdina, eyeball_count));
OUTPUT(preEdina,, '~bbraaten::out::FCRA_Boca_Shell_50_' + IF(onThor, 'thor_', 'roxie_') + thorlib.wuid(), __COMPRESSED__);	

// edina := Risk_Indicators.ToEdina_v50(PROJECT(preEdina,RiskProcessing.Layouts.Layout_Internal_Shell_nodatasets), isFCRA, DataRestriction);

// OUTPUT(CHOOSEN(edina, eyeball_count));
// OUTPUT(edina,, '~bbraaten::out::FCRA_Boca_Shell_50_Edina_' + IF(onThor, 'thor_', 'roxie_') + thorlib.wuid(), __COMPRESSED__);	
