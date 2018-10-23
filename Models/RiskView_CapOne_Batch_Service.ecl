/*--SOAP--
<message name="RiskView CapOne Batch Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="FFDOptionsMask"	type="xsd:string"/>	
</message>
*/
/*--INFO-- Contains Capital One specific RiskView Pre-Screen Score and Version 3 Attributes*/
/*--HELP-- 
<pre>
&lt;Batch_In&gt;
  &lt;Row&gt;
    	&lt;AcctNo&gt;&lt;/AcctNo&gt;
			&lt;ADL&gt;&lt;/ADL&gt;
			&lt;ADLScore&gt;&lt;/ADLScore&gt;
    	&lt;SSN&gt;&lt;/SSN&gt;
    	&lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;		
    	&lt;Street_Addr&gt;&lt;/Street_Addr&gt;
    	&lt;P_City_Name&gt;&lt;/P_City_Name&gt;
    	&lt;St&gt;&lt;/St&gt;
    	&lt;Z5&gt;&lt;/Z5&gt;
			&lt;HistorydateYYYYMM&gt;&lt;/HistorydateYYYYMM&gt;
  &lt;/Row&gt;
&lt;/Batch_In&gt;
</pre>
*/

import address, risk_indicators, models, riskwise, ut, fcra_opt_out, gateway, FFD;


export RiskView_CapOne_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

batchin := dataset([],Models.layouts.Layout_CapOne_Batch_In) 		: stored('batch_in',few);	
gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	SELF.servicename := le.servicename;
	SELF.url := IF(le.servicename IN ['targus'], '', le.url); // Don't allow Targus Gateway
	SELF := le;
END;
gateways := PROJECT(gateways_in, gw_switch(LEFT));


boolean	IncludePreScreen := false;	// current process passing in true, HOWEVER, cap one said prescreen score would not be needed for this
boolean doVersion3 := true;					// current process passing in true
boolean	IsPreScreen := true;				// current process passing in true
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
boolean OutputConsumerStatements := strFFDOptionsMask_in[1] = '1';	


// add sequence to matchup later to add acctno to output
LayoutBatchInPlusSeq := RECORD
	unsigned4 seq;
	Models.layouts.Layout_CapOne_Batch_In;
END;

LayoutBatchInPlusSeq into_seq(batchin le, integer C) := TRANSFORM
	self.seq := C;
	self := le;
END;
batchinseq := project(batchin, into_seq(left,counter));



Risk_Indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
	// new fields specifically for this product, kettle will be getting these and passing them in
	self.DID := (unsigned)le.ADL;
	self.score := (unsigned)le.ADLScore;
	// as of 3/29, prescreen score is no longer included in this output and therefore we wont need the didcount
	// self.in_country := le.ADLCount;	// instead of changing layout input, i will use in_country to store the ADLCount from kettle to use in iid_getDID_PrepOutput

	// clean up input
	ssn_val := le.ssn;
	hphone_val := '';//riskwise.cleanPhone(le.home_phone); -- not being passed in by cap one per ian caton
	wphone_val := '';//riskwise.cleanphone(le.work_phone); -- not being passed in by cap one per ian caton
	dob_val := '';//riskwise.cleandob(le.dob); -- not being passed in by cap one per ian caton
	dl_num_clean := '';//riskwise.cleanDL_num(le.dl_number); -- not being passed in by cap one per ian caton

	self.seq := le.seq;
	self.ssn := ssn_val;
	self.dob := '';//dob_val; -- not being passed in by cap one per ian caton
	self.age := '';//if ((integer)le.age = 0 and (integer)le.dob != 0, (string3)ut.GetAgeI((integer)le.dob), (le.age)); -- not being passed in by cap one per ian caton
	
	self.phone10 := hphone_val;
	self.wphone10 := wphone_val;
	
	cleaned_name := Address.CleanPersonFML73(le.UnparsedFullName);
	boolean valid_cleaned := le.UnParsedFullName <> '';
	
	self.fname := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[6..25], ''));
	self.lname := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[46..65], ''));
	self.mname := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[26..45], ''));
	self.suffix := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[66..70], ''));	
	self.title := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[1..5],''));

	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( le.street_addr, le.p_City_name, le.St, le.Z5 ) ;											

	SELF.in_streetAddress := le.street_addr;
	SELF.in_city := le.p_City_name;
	SELF.in_state := le.St;
	SELF.in_zipCode := le.Z5;
		
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..65];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := clean_a2[117..121];
	self.zip4 := clean_a2[122..125];
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
	
	self.dl_number := '';//stringlib.stringtouppercase(dl_num_clean);
	self.dl_state := '';//stringlib.stringtouppercase(le.dl_state); -- not being passed in by cap one per ian caton
	
	// if the record level history date isn't populated yet, use the default value of 999999
	self.historydate := if(le.HistoryDateYYYYMM=0, risk_indicators.iid_constants.default_history_date, le.historydateYYYYMM); 
	self := [];
END;
cleanIn := project(batchinseq, into_in(left));



// set variables for passing to bocashell function fcra
unsigned1 bsVersion := 3;
boolean   isUtility := false;
boolean 	require2ele := false;;
unsigned1 dppa := 0;	// not needed for FCRA
unsigned1 glba := 0;	// not needed for FCRA
boolean   isLn := false;	// not needed anymore
boolean 	doRelatives := false;	// fcra does not use relatives
boolean 	doDL := false;	// fcra does not use dl
boolean 	doVehicle := false;	
boolean 	doDerogs := true;
boolean 	ofacOnly := true;
boolean 	suppressNearDups := false;
boolean 	fromBIID := false;
boolean 	excludeWatchlists := true;	// turned off the ofac searching as it is not used in FCRA
boolean 	fromIT1O := false;
unsigned1 ofacVersion := 1;
boolean 	includeOfac := false;
boolean 	includeAddWatchlists := false;
real    	watchlistThreshold := 0.84;
boolean 	doScore := false;
boolean 	nugen := true;  
boolean   ADL_Based_Shell := false;

unsigned8 BSOptions := 	risk_indicators.iid_constants.BSOptions.IncludePreScreen +	
												risk_indicators.iid_constants.BSOptions.IsCapOneBatch;			// this will tell iid_getDID_PrepOutput to not call the neutral roxie

// per bug 36019, CapitalOne will be allowed to get the prescreen model and attributes together in one batch
// they currently want riskview attributes (which doesn't use adl based shell) and the RVP1003 model (which needs the adl based shell)
// so we need 2 calls to the bocashell for them  (clam2 will always be the ADL based shell)
clam := Risk_Indicators.Boca_Shell_Function_FCRA(cleanIn, gateways, dppa, glba, isUtility, isLN, 
																								 require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
																								 suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
																								 ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
																								 bsVersion, isPreScreen, doScore, nugen, ADL_Based_Shell, datarestriction:=DataRestriction,
																								 BSOptions:=BSOptions, datapermission:=DataPermission);



attr := Models.getRVAttributes(clam, ''/*account_value*/, IsPreScreen);


checkBoolean(boolean x) := if(x, '1', '0');
cap4Byte := '9998';	// real distances are capped at 9998, 9999 means can't calculate
cap10ByteNeg := '-999999999';



Layout_working := RECORD
	unsigned seq;
	unsigned DID;
	boolean suppress;
	models.Layout_CapOne_RiskView_Batch_Out;
  string1 consumerstatement;
END;

Layout_working intoAttributes(attr le, clam rt) := TRANSFORM
	self.seq := le.seq;
	self.did := rt.did;
  // if the transaction can't get a score, don't return the DID for logging the inquiry
  self.inquiry_lexid := if(riskview.constants.noscore(rt.iid.nas_summary,rt.iid.nap_summary, rt.address_verification.input_address_information.naprop, rt.truedid), 
  '', 
  (string12)rt.did);
	
	// Version3
	self.index11 := '6';
	self.isRecentUpdate := checkBoolean(le.version3.isRecentUpdate);
	self.NumSources := TRIM((string)le.version3.NumSources);
	
	self.isPhoneFullNameMatch := le.version3.VerifiedPhoneFullName;
	self.isPhoneLastNameMatch := le.version3.VerifiedPhoneLastName;
	self.isSSNInvalid :=le.version3.InvalidSSN;
	self.isPhoneInvalid := le.version3.InvalidPhone;
	self.isAddrInvalid := le.version3.InvalidAddr;
	self.isDLInvalid := le.version3.InvalidDL;
	self.isNoVer := checkBoolean(le.version3.isNoVer);
	
	self.isDeceased := le.version3.SSNDeceased;
	
	self.DeceasedDate := TRIM(le.version3.DeceasedDate);
	self.isSSNValid := le.version3.SSNValid;
	self.isRecentIssue := le.version3.RecentIssue;
	self.LowIssueDate := TRIM(le.version3.LowIssueDate);
	self.HighIssueDate := TRIM(le.version3.HighIssueDate);
	self.IssueState := le.version3.IssueState;
	self.isNonUS := le.version3.NonUS;
	self.isIssued3 := le.version3.Issued3;
	self.isIssuedAge5 := le.version3.IssuedAge5;

	self.IALenOfRes := TRIM(le.version3.IALenOfRes);
	self.IADwellType := le.version3.IADwellType;
	self.IALandUseCode := le.version3.IALandUseCode;
	self.IAAssessedValue := TRIM(le.version3.IAAssessedValue);
	self.IAisOwnedBySubject := le.version3.IAOwnedBySubject;
	self.IAisFamilyOwned := le.version3.IAFamilyOwned;
	self.IAisOccupantOwned := le.version3.IAOccupantOwned;
	self.IALastSaleAmount := TRIM(le.version3.IALastSaleAmount);
	self.IAisNotPrimaryRes := le.version3.IANotPrimaryRes;
	self.IAPhoneListed := TRIM(le.version3.IAPhoneListed);
	self.IAPhoneNumber := TRIM(le.version3.IAPhoneNumber);

	self.CALenOfRes := TRIM(le.version3.CALenOfRes);
	self.CADwellType := le.version3.CADwellType;
	self.CALandUseCode := le.version3.CALandUseCode;
	self.CAAssessedValue := TRIM(le.version3.CAAssessedValue);
	self.CAisOwnedBySubject := le.version3.CAOwnedBySubject;
	self.CAisFamilyOwned := le.version3.CAFamilyOwned;
	self.CAisOccupantOwned := le.version3.CAOccupantOwned;
	self.CALastSaleAmount := TRIM(le.version3.CALastSaleAmount);
	self.CAisNotPrimaryRes := le.version3.CANotPrimaryRes;
	self.CAPhoneListed := TRIM(le.version3.CAPhoneListed);
	self.CAPhoneNumber := TRIM(le.version3.CAPhoneNumber);
	
	self.PALenOfRes := TRIM(le.version3.PALenOfRes);
	self.PADwellType := le.version3.PADwellType;
	self.PALandUseCode := le.version3.PALandUseCode;
	self.PAAssessedValue := TRIM(le.version3.PAAssessedValue);
	self.PAisOwnedBySubject := le.version3.PAOwnedBySubject;
	self.PAisFamilyOwned := le.version3.PAFamilyOwned;
	self.PAisOccupantOwned := le.version3.PAOccupantOwned;
	self.PALastSaleAmount := TRIM(le.version3.PALastSaleAmount);
	self.PAPhoneListed := TRIM(le.version3.PAPhoneListed);
	self.PAPhoneNumber := TRIM(le.version3.PAPhoneNumber);
	
	distCap := 9999;
	
	self.isInputCurrMatch := le.version3.InputCurrMatch;
	self.DistInputCurr := if((integer)le.version3.DistInputCurr > distCap, 
													cap4Byte, 
													le.version3.DistInputCurr);
	self.isDiffState := le.version3.DiffState;
	self.AssessedDiff := if((integer)le.version3.AssessedDiff < -999999999,
													cap10ByteNeg,
													le.version3.AssessedDiff);
	self.EcoTrajectory := le.version3.EcoTrajectory;
	
	self.isInputPrevMatch := le.version3.InputPrevMatch;
	self.DistCurrPrev := if((integer)le.version3.DistCurrPrev > distCap, 
													cap4Byte,
													le.version3.DistCurrPrev);
	self.isDiffState2 := le.version3.DiffState2;
	self.AssessedDiff2 := if((integer)le.version3.AssessedDiff2 < -999999999,
														cap10ByteNeg,
														le.version3.AssessedDiff2);
	self.EcoTrajectory2 := le.version3.EcoTrajectory2;
	
	self.mobility_indicator := le.version3.mobility_indicator;
	self.statusAddr := le.version3.statusAddr;
	self.statusAddr2 := le.version3.statusAddr2;
	self.statusAddr3 := le.version3.statusAddr3;

	self.addrChanges30 := TRIM((string)le.version3.addrChanges30);
	self.addrChanges90 := TRIM( (string)le.version3.addrChanges90);
	self.addrChanges180 := TRIM((string)le.version3.addrChanges180);
	self.addrChanges12 := TRIM((string)le.version3.addrChanges12);
	self.addrChanges24 := TRIM((string)le.version3.addrChanges24);
	self.addrChanges36 := TRIM((string)le.version3.addrChanges36);
	self.addrChanges60 := TRIM((string)le.version3.addrChanges60);
	
	self.property_owned_total_v2 := TRIM((string)le.version3.property_owned_total);
	self.property_owned_assessed_total_v2 := TRIM((string)le.version3.property_owned_assessed_total);
	self.property_historically_owned_v2 := TRIM((string)le.version3.property_historically_owned);
	
	self.numPurchase30 := TRIM((string)le.version3.numPurchase30);
	self.numPurchase90 := TRIM((string)le.version3.numPurchase90);
	self.numPurchase180 := TRIM((string)le.version3.numPurchase180);
	self.numPurchase12 := TRIM((string)le.version3.numPurchase12);
	self.numPurchase24 := TRIM((string)le.version3.numPurchase24);
	self.numPurchase36 := TRIM((string)le.version3.numPurchase36);
	self.numPurchase60 := TRIM((string)le.version3.numPurchase60);
	self.numSold30 := TRIM((string)le.version3.numSold30);
	self.numSold90 := TRIM((string)le.version3.numSold90);
	self.numSold180 := TRIM((string)le.version3.numSold180);
	self.numSold12 := TRIM((string)le.version3.numSold12);
	self.numSold24 := TRIM((string)le.version3.numSold24);
	self.numSold36 := TRIM((string)le.version3.numSold36);
	self.numSold60 := TRIM((string)le.version3.numSold60);
	self.numWatercraft := TRIM((string)le.version3.numWatercraft);
	self.numWatercraft30 := TRIM((string)le.version3.numWatercraft30);
	self.numWatercraft90 := TRIM((string)le.version3.numWatercraft90);
	self.numWatercraft180 := TRIM((string)le.version3.numWatercraft180);
	self.numWatercraft12 := TRIM((string)le.version3.numWatercraft12);
	self.numWatercraft24 := TRIM((string)le.version3.numWatercraft24);
	self.numWatercraft36 := TRIM((string)le.version3.numWatercraft36);
	self.numWatercraft60 := TRIM((string)le.version3.numWatercraft60);
	self.numAircraft := TRIM((string)le.version3.numAircraft);
	self.numAircraft30 := TRIM((string)le.version3.numAircraft30);
	self.numAircraft90 := TRIM((string)le.version3.numAircraft90);
	self.numAircraft180 := TRIM((string)le.version3.numAircraft180);
	self.numAircraft12 := TRIM((string)le.version3.numAircraft12);
	self.numAircraft24 := TRIM((string)le.version3.numAircraft24);
	self.numAircraft36 := TRIM((string)le.version3.numAircraft36);
	self.numAircraft60 := TRIM((string)le.version3.numAircraft60);
	self.wealth_indicator := le.version3.wealth_indicator;
	
	self.total_number_derogs_v2 := TRIM((string)le.version3.total_number_derogs);
	self.felonies := TRIM((string)le.version3.felonies);
	self.felonies30 := TRIM((string)le.version3.felonies30);
	self.felonies90 := TRIM((string)le.version3.felonies90);
	self.felonies180 := TRIM((string)le.version3.felonies180);
	self.felonies12 := TRIM((string)le.version3.felonies12);
	self.felonies24 := TRIM((string)le.version3.felonies24);
	self.felonies36 := TRIM((string)le.version3.felonies36);
	self.felonies60 := TRIM((string)le.version3.felonies60);
	self.num_liens := TRIM((string)le.version3.num_liens);
	self.num_unreleased_liens := TRIM((string)le.version3.num_unreleased_liens);
	self.num_unreleased_liens30 := TRIM((string)le.version3.num_unreleased_liens30);
	self.num_unreleased_liens90 := TRIM((string)le.version3.num_unreleased_liens90);
	self.num_unreleased_liens180 := TRIM((string)le.version3.num_unreleased_liens180);
	self.num_unreleased_liens12 := TRIM((string)le.version3.num_unreleased_liens12);
	self.num_unreleased_liens24 := TRIM((string)le.version3.num_unreleased_liens24);
	self.num_unreleased_liens36 := TRIM((string)le.version3.num_unreleased_liens36);
	self.num_unreleased_liens60 := TRIM((string)le.version3.num_unreleased_liens60);
	self.num_released_liens := TRIM((string)le.version3.num_released_liens);
	self.num_released_liens30 := TRIM((string)le.version3.num_released_liens30);
	self.num_released_liens90 := TRIM((string)le.version3.num_released_liens90);
	self.num_released_liens180 := TRIM((string)le.version3.num_released_liens180);
	self.num_released_liens12 := TRIM((string)le.version3.num_released_liens12);
	self.num_released_liens24 := TRIM((string)le.version3.num_released_liens24);
	self.num_released_liens36 := TRIM((string)le.version3.num_released_liens36);
	self.num_released_liens60 := TRIM((string)le.version3.num_released_liens60);
	
	self.bankruptcy_count := TRIM((string)le.version3.bankruptcy_count);
	self.filing_type := le.version3.filing_type;
	self.disposition_v2 := le.version3.disposition;
	self.bankruptcy_count30 := TRIM((string)le.version3.bankruptcy_count30);
	self.bankruptcy_count90 := TRIM((string)le.version3.bankruptcy_count90);
	self.bankruptcy_count180 := TRIM((string)le.version3.bankruptcy_count180);
	self.bankruptcy_count12 := TRIM((string)le.version3.bankruptcy_count12);
	self.bankruptcy_count24 := TRIM((string)le.version3.bankruptcy_count24);
	self.bankruptcy_count36 := TRIM((string)le.version3.bankruptcy_count36);
	self.bankruptcy_count60 := TRIM((string)le.version3.bankruptcy_count60);
	self.eviction_count := TRIM((string)le.version3.eviction_count);
	self.eviction_count30 := TRIM((string)le.version3.eviction_count30);
	self.eviction_count90 := TRIM((string)le.version3.eviction_count90);
	self.eviction_count180 := TRIM((string)le.version3.eviction_count180);
	self.eviction_count12 := TRIM((string)le.version3.eviction_count12);
	self.eviction_count24 := TRIM((string)le.version3.eviction_count24);
	self.eviction_count36 := TRIM((string)le.version3.eviction_count36);
	self.eviction_count60 := TRIM((string)le.version3.eviction_count60);

	self.num_nonderogs := TRIM((string)le.version3.num_nonderogs);
	self.num_nonderogs30 := TRIM((string)le.version3.num_nonderogs30);
	self.num_nonderogs90 := TRIM((string)le.version3.num_nonderogs90);
	self.num_nonderogs180 := TRIM((string)le.version3.num_nonderogs180);
	self.num_nonderogs12 := TRIM((string)le.version3.num_nonderogs12);
	self.num_nonderogs24 := TRIM((string)le.version3.num_nonderogs24);
	self.num_nonderogs36 := TRIM((string)le.version3.num_nonderogs36);
	self.num_nonderogs60 := TRIM((string)le.version3.num_nonderogs60);
	self.num_proflic := TRIM((string)le.version3.num_proflic);
	self.proflic_type := le.version3.proflic_type;
	self.expire_date_last_proflic := TRIM((string)le.version3.expire_date_last_proflic);
	self.num_proflic30 := TRIM((string)le.version3.num_proflic30);
	self.num_proflic90 := TRIM((string)le.version3.num_proflic90);
	self.num_proflic180 := TRIM((string)le.version3.num_proflic180);
	self.num_proflic12 := TRIM((string)le.version3.num_proflic12);
	self.num_proflic24 := TRIM((string)le.version3.num_proflic24);
	self.num_proflic36 := TRIM((string)le.version3.num_proflic36);
	self.num_proflic60 := TRIM((string)le.version3.num_proflic60);
	self.num_proflic_exp30 := TRIM((string)le.version3.num_proflic_exp30);
	self.num_proflic_exp90 := TRIM((string)le.version3.num_proflic_exp90);
	self.num_proflic_exp180 := TRIM((string)le.version3.num_proflic_exp180);
	self.num_proflic_exp12 := TRIM((string)le.version3.num_proflic_exp12);
	self.num_proflic_exp24 := TRIM((string)le.version3.num_proflic_exp24);
	self.num_proflic_exp36 := TRIM((string)le.version3.num_proflic_exp36);
	self.num_proflic_exp60 := TRIM((string)le.version3.num_proflic_exp60);
	
	self.isAddrHighRisk := TRIM(le.version3.AddrHighRisk);
	self.isPhoneHighRisk := TRIM(le.version3.PhoneHighRisk);
	self.isAddrPrison := TRIM(le.version3.AddrPrison);
	self.isZipPOBox := TRIM(le.version3.ZipPOBox);
	self.isZipCorpMil := TRIM(le.version3.ZipCorpMil);
	self.phoneStatus := TRIM(le.version3.phoneStatus);
	self.isPhonePager := TRIM(le.version3.PhonePager);
	self.isPhoneMobile := TRIM(le.version3.PhoneMobile);
	self.isPhoneZipMismatch := TRIM(le.version3.PhoneZipMismatch);
	self.phoneAddrDist := if((integer)le.version3.phoneAddrDist > distCap, 
													 cap4Byte,
													 le.version3.phoneAddrDist);
	
	self.SecurityFreeze := checkBoolean(le.version3.securityfreeze);
	self.SecurityAlert := checkBoolean(le.version3.securityalert);
	self.IdTheftFlag := checkBoolean(le.version3.idtheftflag);
	self.CorrectedFlag := checkBoolean(le.version3.correctedflag);

	// Version3 only
	self.AgeOldestRecord := le.version3.AgeOldestRecord; 
	self.AgeNewestRecord := le.version3.AgeNewestRecord; 
	self.IAAgeOldestRecord := le.version3.IAAgeOldestRecord;
	self.IAAgeNewestRecord := le.version3.IAAgeNewestRecord;
	self.IAAgeLastSale := le.version3.IAAgeLastSale;
	self.CAAgeOldestRecord := le.version3.CAAgeOldestRecord;
	self.CAAgeNewestRecord := le.version3.CAAgeNewestRecord;
	self.CAAgeLastSale := le.version3.CAAgeLastSale;
	self.PAAgeOldestRecord := le.version3.PAAgeOldestRecord;
	self.PAAgeNewestRecord := le.version3.PAAgeNewestRecord;
	self.PAAgeLastSale := le.version3.PAAgeLastSale;
	self.PropAgeOldestPurchase := le.version3.PropAgeOldestPurchase;
	self.PropAgeNewestPurchase := le.version3.PropAgeNewestPurchase;
	self.PropAgeNewestSale := le.version3.PropAgeNewestSale;
	self.DerogAge := le.version3.DerogAge;
	self.FelonyAge := le.version3.FelonyAge;
	self.LienFiledAge := le.version3.LienFiledAge;
	self.LienReleasedAge := le.version3.LienReleasedAge;
	self.BankruptcyAge := le.version3.BankruptcyAge;
	self.EvictionAge := le.version3.EvictionAge;
	self.ProfLicAge := le.version3.ProfLicAge;

	self.SSNNotFound := le.version3.SSNNotFound;
	self.VerifiedName := TRIM((string)le.version3.VerifiedName);
	self.VerifiedSSN := TRIM((string)le.version3.VerifiedSSN);
	self.VerifiedPhone := TRIM((string)le.version3.VerifiedPhone);
	self.VerifiedAddress := TRIM((string)le.version3.VerifiedAddress);
	self.VerifiedDOB := TRIM((string)le.version3.VerifiedDOB);
	self.InferredMinimumAge := le.version3.InferredMinimumAge;
	self.BestReportedAge := le.version3.BestReportedAge;
	self.SubjectSSNCount := TRIM((string)le.version3.SubjectSSNCount);
	self.SubjectAddrCount := TRIM((string)le.version3.SubjectAddrCount);
	self.SubjectPhoneCount := TRIM((string)le.version3.SubjectPhoneCount);
	self.SubjectSSNRecentCount := TRIM((string)le.version3.SubjectSSNRecentCount);
	self.SubjectAddrRecentCount := TRIM((string)le.version3.SubjectAddrRecentCount);
	self.SubjectPhoneRecentCount := TRIM((string)le.version3.SubjectPhoneRecentCount);
	self.SSNIdentitiesCount := TRIM((string)le.version3.SSNIdentitiesCount);
	self.SSNAddrCount := TRIM((string)le.version3.SSNAddrCount);
	self.SSNIdentitiesRecentCount := TRIM((string)le.version3.SSNIdentitiesRecentCount);
	self.SSNAddrRecentCount := TRIM((string)le.version3.SSNAddrRecentCount);
	self.InputAddrIdentitiesCount := TRIM((string)le.version3.InputAddrIdentitiesCount);
	self.InputAddrSSNCount := TRIM((string)le.version3.InputAddrSSNCount);
	self.InputAddrPhoneCount := TRIM((string)le.version3.InputAddrPhoneCount);
	self.InputAddrIdentitiesRecentCount := TRIM((string)le.version3.InputAddrIdentitiesRecentCount);
	self.InputAddrSSNRecentCount := TRIM((string)le.version3.InputAddrSSNRecentCount);
	self.InputAddrPhoneRecentCount := TRIM((string)le.version3.InputAddrPhoneRecentCount);
	self.PhoneIdentitiesCount := TRIM((string)le.version3.PhoneIdentitiesCount);
	self.PhoneIdentitiesRecentCount := TRIM((string)le.version3.PhoneIdentitiesRecentCount);
	self.SSNIssuedPriorDOB := le.version3.SSNIssuedPriorDOB;
	
	self.InputAddrTaxYr := le.version3.InputAddrTaxYr;
	self.InputAddrTaxMarketValue := TRIM((string)le.version3.InputAddrTaxMarketValue);
	self.InputAddrAVMTax := TRIM((string)le.version3.InputAddrAVMTax);
	self.InputAddrAVMSalesPrice := TRIM((string)le.version3.InputAddrAVMSalesPrice);
	self.InputAddrAVMHedonic := TRIM((string)le.version3.InputAddrAVMHedonic);
	self.InputAddrAVMValue := TRIM((string)le.version3.InputAddrAVMValue);
	self.InputAddrAVMConfidence := TRIM((string)le.version3.InputAddrAVMConfidence);
	self.InputAddrCountyIndex := trim (stringlib.stringfindreplace( realformat( le.version3.InputAddrCountyIndex, 5, 2 ), ' ', '0' ));
	self.InputAddrTractIndex := trim(stringlib.stringfindreplace( realformat( le.version3.InputAddrTractIndex, 5, 2 ), ' ', '0' ));    
	self.InputAddrBlockIndex := trim(stringlib.stringfindreplace( realformat( le.version3.InputAddrBlockIndex, 5, 2 ), ' ', '0' ));    
	
	self.CurrAddrTaxYr := le.version3.CurrAddrTaxYr;
	self.CurrAddrTaxMarketValue := TRIM((string)le.version3.CurrAddrTaxMarketValue);
	self.CurrAddrAVMTax := TRIM((string)le.version3.CurrAddrAVMTax);
	self.CurrAddrAVMSalesPrice := TRIM((string)le.version3.CurrAddrAVMSalesPrice);
	self.CurrAddrAVMHedonic := TRIM((string)le.version3.CurrAddrAVMHedonic);
	self.CurrAddrAVMValue := TRIM((string)le.version3.CurrAddrAVMValue);
	self.CurrAddrAVMConfidence := TRIM((string)le.version3.CurrAddrAVMConfidence);
	self.CurrAddrCountyIndex := trim(stringlib.stringfindreplace( realformat( le.version3.CurrAddrCountyIndex, 5, 2 ), ' ', '0' ));    
  self.CurrAddrTractIndex := trim(stringlib.stringfindreplace( realformat( le.version3.CurrAddrTractIndex, 5, 2 ), ' ', '0' ));    
	self.CurrAddrBlockIndex := trim(stringlib.stringfindreplace( realformat( le.version3.CurrAddrBlockIndex, 5, 2 ), ' ', '0' ));    
		
	self.PrevAddrTaxYr := le.version3.PrevAddrTaxYr;
	self.PrevAddrTaxMarketValue := TRIM((string)le.version3.PrevAddrTaxMarketValue);
	self.PrevAddrAVMTax := TRIM((string)le.version3.PrevAddrAVMTax);
	self.PrevAddrAVMSalesPrice := TRIM((string)le.version3.PrevAddrAVMSalesPrice);
	self.PrevAddrAVMHedonic := TRIM((string)le.version3.PrevAddrAVMHedonic);
	self.PrevAddrAVMValue := TRIM((string)le.version3.PrevAddrAVMValue);
	self.PrevAddrAVMConfidence := TRIM((string)le.version3.PrevAddrAVMConfidence);
	self.PrevAddrCountyIndex := trim(stringlib.stringfindreplace( realformat( le.version3.PrevAddrCountyIndex, 5, 2 ), ' ', '0' ));    
	self.PrevAddrTractIndex := trim(stringlib.stringfindreplace( realformat( le.version3.PrevAddrTractIndex, 5, 2 ), ' ', '0' ));    
	self.PrevAddrBlockIndex := trim(stringlib.stringfindreplace( realformat( le.version3.PrevAddrBlockIndex, 5, 2 ), ' ', '0' ));    
	
	self.EducationAttendedCollege := le.version3.EducationAttendedCollege;
	self.EducationProgram2Yr := le.version3.EducationProgram2Yr;
	self.EducationProgram4Yr := le.version3.EducationProgram4Yr;
	self.EducationProgramGraduate := le.version3.EducationProgramGraduate;
	self.EducationInstitutionPrivate := le.version3.EducationInstitutionPrivate;
	self.EducationInstitutionRating := le.version3.EducationInstitutionRating;
	
	self.PredictedAnnualIncome := le.version3.PredictedAnnualIncome;
	
	self.PropNewestSalePrice := TRIM((string)le.version3.PropNewestSalePrice);
	self.PropNewestSalePurchaseIndex := trim(stringlib.stringfindreplace( realformat( le.version3.PropNewestSalePurchaseIndex, 5, 2 ), ' ', '0' ));   
	
	self.SubPrimeSolicitedCount := TRIM((string)le.version3.SubPrimeSolicitedCount);
	self.SubPrimeSolicitedCount01 := TRIM((string)le.version3.SubPrimeSolicitedCount01);
	self.SubprimeSolicitedCount03 := TRIM((string)le.version3.SubprimeSolicitedCount03);
	self.SubprimeSolicitedCount06 := TRIM((string)le.version3.SubprimeSolicitedCount06);
	self.SubPrimeSolicitedCount12 := TRIM((string)le.version3.SubPrimeSolicitedCount12);
	self.SubPrimeSolicitedCount24 := TRIM((string)le.version3.SubPrimeSolicitedCount24);
	self.SubPrimeSolicitedCount36 := TRIM((string)le.version3.SubPrimeSolicitedCount36);
	self.SubPrimeSolicitedCount60 := TRIM((string)le.version3.SubPrimeSolicitedCount60);
	
	self.LienFederalTaxFiledTotal := TRIM((string)le.version3.LienFederalTaxFiledTotal);
	self.LienTaxOtherFiledTotal := TRIM((string)le.version3.LienTaxOtherFiledTotal);
	self.LienForeclosureFiledTotal := TRIM((string)le.version3.LienForeclosureFiledTotal);
	self.LienPreforeclosureFiledTotal := TRIM((string)le.version3.LienPreforeclosureFiledTotal);
	self.LienLandlordTenantFiledTotal := TRIM((string)le.version3.LienLandlordTenantFiledTotal);
	self.LienJudgmentFiledTotal := TRIM((string)le.version3.LienJudgmentFiledTotal);
	self.LienSmallClaimsFiledTotal := TRIM((string)le.version3.LienSmallClaimsFiledTotal);
	self.LienOtherFiledTotal := TRIM((string)le.version3.LienOtherFiledTotal);
	self.LienFederalTaxReleasedTotal := TRIM((string)le.version3.LienFederalTaxReleasedTotal);
	self.LienTaxOtherReleasedTotal := TRIM((string)le.version3.LienTaxOtherReleasedTotal);
	self.LienForeclosureReleasedTotal := TRIM((string)le.version3.LienForeclosureReleasedTotal);
	self.LienPreforeclosureReleasedTotal := TRIM((string)le.version3.LienPreforeclosureReleasedTotal);
	self.LienLandlordTenantReleasedTotal := TRIM((string)le.version3.LienLandlordTenantReleasedTotal);
	self.LienJudgmentReleasedTotal := TRIM((string)le.version3.LienJudgmentReleasedTotal);
	self.LienSmallClaimsReleasedTotal := TRIM((string)le.version3.LienSmallClaimsReleasedTotal);
	self.LienOtherReleasedTotal := TRIM((string)le.version3.LienOtherReleasedTotal);
	
	self.LienFederalTaxFiledCount := TRIM((string)le.version3.LienFederalTaxFiledCount);
	self.LienTaxOtherFiledCount := TRIM((string)le.version3.LienTaxOtherFiledCount);
	self.LienForeclosureFiledCount := TRIM((string)le.version3.LienForeclosureFiledCount);
	self.LienPreforeclosureFiledCount := TRIM((string)le.version3.LienPreforeclosureFiledCount);
	self.LienLandlordTenantFiledCount := TRIM((string)le.version3.LienLandlordTenantFiledCount);
	self.LienJudgmentFiledCount := TRIM((string)le.version3.LienJudgmentFiledCount);
	self.LienSmallClaimsFiledCount := TRIM((string)le.version3.LienSmallClaimsFiledCount);
	self.LienOtherFiledCount := TRIM((string)le.version3.LienOtherFiledCount);
	self.LienFederalTaxReleasedCount := TRIM((string)le.version3.LienFederalTaxReleasedCount);
	self.LienTaxOtherReleasedCount := TRIM((string)le.version3.LienTaxOtherReleasedCount);
	self.LienForeclosureReleasedCount := TRIM((string)le.version3.LienForeclosureReleasedCount);
	self.LienPreforeclosureReleasedCount := TRIM((string)le.version3.LienPreforeclosureReleasedCount);
	self.LienLandlordTenantReleasedCount := TRIM((string)le.version3.LienLandlordTenantReleasedCount);
	self.LienJudgmentReleasedCount := TRIM((string)le.version3.LienJudgmentReleasedCount);
	self.LienSmallClaimsReleasedCount := TRIM((string)le.version3.LienSmallClaimsReleasedCount);
	self.LienOtherReleasedCount := TRIM((string)le.version3.LienOtherReleasedCount);
	
	self.ProfLicTypeCategory := le.version3.ProfLicTypeCategory;
	
	self.PhoneEDAAgeOldestRecord := le.version3.PhoneEDAAgeOldestRecord;
	self.PhoneEDAAgeNewestRecord := le.version3.PhoneEDAAgeNewestRecord;
	self.PhoneOtherAgeOldestRecord := le.version3.PhoneOtherAgeOldestRecord;
	self.PhoneOtherAgeNewestRecord := le.version3.PhoneOtherAgeNewestRecord;
	
	self.PrescreenOptOut := le.version3.PrescreenOptOut;
  self.ConsumerStatement := le.v4_consumerstatement;

	self := [];
END;
attributes_temp := join(attr, clam, left.seq=right.seq, intoAttributes(left, right));


Layout_working blankAttributes(attributes_temp le) := TRANSFORM
	SELF.seq := le.seq;
	SELF.acctno := le.acctno;
	SELF.SecurityFreeze := le.SecurityFreeze; 
	SELF.PrescreenOptOut := le.PrescreenOptOut;
  SELF.isNoVer := le.isNoVer;
	self.did := le.did;
	SELF := [];
END;
blank_attributes := PROJECT(attributes_temp (SecurityFreeze = '1' or ConsumerStatement = '1'), blankAttributes(LEFT));

attributes := attributes_temp (SecurityFreeze <> '1' and ConsumerStatement <> '1') + blank_attributes;


// no prescreen score needed


// wAcctNo is the normal processing results
wAcctNo := join(attributes, batchinseq, left.seq=right.seq, transform(layout_working, self.acctno := right.acctno, self := left));


// use the fields in the clam as filters to suppress records for pre-screen product
// filtered_pre_screen_recs := join(wAcctNo, clam, left.seq=right.seq, transform(layout_working, self.acctno := left.acctno,
layout_working calculateSuppression( wAcctNo le, clam ri ) := TRANSFORM
	// only consider a score for threshold suppression if it was calculated.  If blank for that score, set 999
	opt_out_hit := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, ri.iid.iid_flags );

	self.suppress := ( ri.ssn_verification.validation.deceased or opt_out_hit );

	self.prescreenoptout := map(
		opt_out_hit => '1',
		'0'
	); 

	self := le;
end;
filtered_pre_screen_recs := join(wAcctNo, clam, left.seq=right.seq, calculateSuppression(left,right) );


// create dataset of suppressed output, to join back to only those records which pass the filters
acct_seq_only := project(batchinseq, transform(layout_working, self.seq := left.seq, self.acctno := left.acctno, self := []));

temp_layout := record
	unsigned did;
	models.Layout_CapOne_RiskView_Batch_Out;
end;

temp_layout applySuppression( filtered_pre_screen_recs le, acct_seq_only ri ) := TRANSFORM

		self.prescreenoptout := le.prescreenoptout;

		self := if(le.suppress, ri, le);
END;
final1 := join(filtered_pre_screen_recs, acct_seq_only, left.seq=right.seq, applySuppression(LEFT,RIGHT), keep(1) );

// remove the DID from the layout
final := project(final1, transform(models.Layout_CapOne_RiskView_Batch_Out, self := left));

OUTPUT(final, NAMED('Results'));

ConsumerStatementResults1 := project(clam.ConsumerStatements, 
	transform(FFD.layouts.ConsumerStatementBatchFullFlat,
		self.UniqueId := left.uniqueId;
		self.StatementID := (string)left.statementID;
		self.dateAdded := // renamed timestamp to be dateAdded to match what krishna's team is doing
			intformat(left.timestamp.year, 4, 1) + 
			intformat(left.timestamp.month, 2, 1) + 
			intformat(left.timestamp.day, 2, 1) +
			' ' +
			intformat(left.timestamp.hour24, 2, 1) + 
			intformat(left.timestamp.minute, 2, 1) + 
			intformat(left.timestamp.second, 2, 1);
		self.recordtype := left.statementtype;	// renamed the statement type to be recordtype like krishna's team is doing instead to be more generic since it also includes disputes now as well
		self := left,
		self := []));

empty_ds := dataset([], FFD.layouts.ConsumerStatementBatchFullFlat);

ConsumerStatementResults_temp := if(OutputConsumerStatements, ConsumerStatementResults1, empty_ds);
		
ConsumerStatementResults := join(final1, ConsumerStatementResults_temp, left.did=(unsigned)right.uniqueid, 
			transform(FFD.layouts.ConsumerStatementBatchFullFlat, 
			self.acctno := left.acctno, self := right));

			
output(ConsumerStatementResults, named('CSDResults'));  


ENDMACRO;
// Models.RiskView_CapOne_Batch_Service();