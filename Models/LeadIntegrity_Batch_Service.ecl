/*--SOAP--
<message name="LeadIntegrity_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ModelName" type="xsd:string"/>
	<part name="Version" type="xsd:integer"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/> 
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="DisableDoNotMailFilter" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Lead Integrity Batch Service*/
/*--HELP--
<pre>
&lt;dataset&gt;
   &lt;row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
			&lt;LexID&gt;&lt;/LexID&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
      &lt;Name_First&gt;&lt;/Name_First&gt;
      &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
      &lt;Name_Last&gt;&lt;/Name_Last&gt;
      &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
      &lt;DOB&gt;&lt;/DOB&gt;
      &lt;street_addr&gt;&lt;/street_addr&gt;
      &lt;p_City_name&gt;&lt;/p_City_name&gt;
      &lt;St&gt;&lt;/St&gt;
      &lt;Z5&gt;&lt;/Z5&gt;
      &lt;DL_Number&gt;&lt;/DL_Number&gt;
      &lt;DL_State&gt;&lt;/DL_State&gt;
      &lt;Home_Phone&gt;&lt;/Home_Phone&gt;
      &lt;Work_Phone&gt;&lt;/Work_Phone&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import address, risk_indicators, models, riskwise, ut, STD;


export LeadIntegrity_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

batchin := dataset([],Models.layouts.Layout_LeadIntegrity_Batch_In) 			: stored('batch_in',few);
gateways_in := Gateway.Configuration.Get();

unsigned1 prep_dppa := 0 :		stored('DPPAPurpose');
unsigned1 glb := RiskWise.permittedUse.GLBA : stored('GLBPurpose');
unsigned1 attributesVersionTemp := 1      : stored('Version');
string ModelName_in := '' : stored('ModelName');
model_name := STD.Str.ToLowerCase( modelname_in );
string5   industry_class_val := '';
boolean   isUtility := false;
boolean   ofac_Only := false;
unsigned1 ofac_version_      := 1        : stored('OFACVersion');

string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned3 history_date := 999999 		: stored('HistoryDateYYYYMM');
boolean DisableDoNotMailFilter := false		:	stored('DisableDoNotMailFilter');

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');

unsigned1 dppa := if(~DisableDoNotMailFilter, 0, prep_dppa);
// Apparently if <Version/> gets passed into the Roxie via XML it gets interpreted as a 0 instead of using the default value of 1, causing nothing to be returned.  
// Override this situation back to the default value of 1.
attributesVersion := IF(attributesVersionTemp <= 1, 1, attributesVersionTemp);

bsVersion := max( attributesVersion,
	map(
		attributesVersion >= 4 => 41,
		model_name in ['msn1106_0'] => 4,
		3
	)
);

// add sequence to matchup later to add acctno to output
Models.layouts.Layout_LeadIntegrity_Batch_In into_seq(batchin le, integer C) := TRANSFORM
	self.seq := C;
	self := le;
END;
batchinseq := project(batchin, into_seq(left,counter));


risk_indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
	self.did 		:= le.LexId;
	self.score := if(le.lexid<>0, 100, 0);  // hard code the DID score to 100 if DID is passed in on input

	// clean up input
	dob_val := riskwise.cleandob(le.dob);
	dl_num_clean := riskwise.cleanDL_num(le.dl_number);

	self.seq := le.seq;	
	self.ssn := IF(le.ssn='000000000','',le.ssn);	// blank out social if it is all 0's
	self.dob := dob_val;
	self.age := if ((integer)dob_val != 0,(STRING3)ut.Age((integer)dob_val), '');
	
	self.phone10 := le.Home_Phone;
	self.wphone10 := le.Work_Phone;
	
	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	boolean valid_cleaned := le.UnParsedFullName <> '';
	
	self.fname := STD.Str.touppercase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First));
	self.lname := STD.Str.touppercase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
	self.mname := STD.Str.touppercase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
	self.suffix := STD.Str.touppercase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
	self.title := STD.Str.touppercase(if(valid_cleaned, cleaned_name[1..5],''));

	street_address := le.street_addr;
	clean_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											

	SELF.in_streetAddress := street_address;
	SELF.in_city := le.p_City_name;
	SELF.in_state := le.St;
	SELF.in_zipCode := le.Z5;
		
	self.prim_range := Address.CleanFields(clean_addr).prim_range;
	self.predir := Address.CleanFields(clean_addr).predir;
	self.prim_name := Address.CleanFields(clean_addr).prim_name;
	self.addr_suffix := Address.CleanFields(clean_addr).addr_suffix;
	self.postdir := Address.CleanFields(clean_addr).postdir;
	self.unit_desig := Address.CleanFields(clean_addr).unit_desig;
	self.sec_range := Address.CleanFields(clean_addr).sec_range;
	self.p_city_name := Address.CleanFields(clean_addr).p_city_name;
	self.st := Address.CleanFields(clean_addr).st;
	self.z5 := Address.CleanFields(clean_addr).zip;
	self.zip4 := Address.CleanFields(clean_addr).zip4;
	self.lat := Address.CleanFields(clean_addr).geo_lat;
	self.long := Address.CleanFields(clean_addr).geo_long;
	self.addr_type := Address.CleanFields(clean_addr).rec_type[1];
	self.addr_status := Address.CleanFields(clean_addr).err_stat;
	self.county := Address.CleanFields(clean_addr).county[3..5]; // we only want the county fips, not all 5.  first 2 are the state fips
	self.geo_blk := Address.CleanFields(clean_addr).geo_blk;
	
	self.dl_number := STD.Str.touppercase(dl_num_clean);
	self.dl_state := STD.Str.touppercase(le.dl_state);
	self.historydate := if(le.historydateYYYYMM=0, history_date, le.historydateYYYYMM);
	self := [];
END;
cleanIn := project(batchinseq, into_in(left));

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
self.servicename := if(ofac_version_ = 4 and attributesVersion >= 4 and le.servicename = 'bridgerwlc', le.servicename, '');
self.url := if(ofac_version_ = 4 and attributesVersion >= 4 and le.servicename = 'bridgerwlc', le.url, ''); 		
self := le;
end;
gateways := project(gateways_in, gw_switch(left));

// set variables for passing to bocashell function
BOOLEAN includeDLverification := IF(attributesVersion >= 4, TRUE, FALSE);
boolean 	require2ele := false;
boolean   isLn := false;	// not needed anymore
boolean   doRelatives := true;
boolean   doDL := false;
boolean   doVehicle := false;
boolean   doDerogs := true;
boolean   suppressNearDups := false;
boolean   fromBIID := false;
boolean   isFCRA := false;
boolean   fromIT1O := false;
boolean   doScore := false;
boolean   nugen := true;	
	BOOLEAN include_ofac := IF(attributesVersion >= 4, TRUE, FALSE);
	UNSIGNED1 ofacVersion := map(attributesVersion >= 4 and ofac_version_ = 4 => 4,
                               attributesVersion >= 4 => 2, 
                                                            1);
	BOOLEAN includeAdditionalWatchlists := IF(attributesVersion >= 4, TRUE, FALSE);
  REAL    global_watchlist_threshold := if(ofacVersion in [1, 2, 3], 0.84, 0.85);
BOOLEAN excludeWatchlists := IF(attributesVersion >= 4, FALSE, TRUE); // Attributes 4.1 return a watchlist hit, so don't exclude watchlists
// For ITA we can't use FARES Data
BOOLEAN filterOutFares := TRUE;
append_best := if( model_name = 'msn1106_0' or attributesVersion >= 4, 2, 0 );

unsigned8 BSOptions := IF(attributesVersion >= 4, risk_indicators.iid_constants.BSOptions.IncludeDoNotMail + 
																										risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
																										risk_indicators.iid_constants.BSOptions.IncludeDoNotMail);
                                                    
if(ofacVersion = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

/* ***************************************
	 *     Gather Boca Shell Results:      *
   *************************************** */
iid := Risk_Indicators.InstantID_Function(cleanIn, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																					suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, include_ofac, includeAdditionalWatchlists, global_watchlist_threshold,
																					in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission,
                                                                                    LexIdSourceOptout := LexIdSourceOptout, 
                                                                                    TransactionID := TransactionID, 
                                                                                    BatchUID := BatchUID, 
                                                                                    GlobalCompanyID := GlobalCompanyID);

clam := Risk_Indicators.Boca_Shell_Function(iid, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																						doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																						BSOptions := BSOptions, DataPermission := DataPermission,
                                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                                        TransactionID := TransactionID, 
                                                                                        BatchUID := BatchUID, 
                                                                                        GlobalCompanyID := GlobalCompanyID);
		

LeadIntegrity := Models.get_LeadIntegrity_Attributes(clam,attributesVersion);

models.layouts.layout_LeadIntegrity_attributes_batch dnmSuppression( cleanIn le, clam ri ) := TRANSFORM
	dnm := if( risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsDoNotMail, ri.iid.iid_flags), '1', '0' );
		self.DoNotMail := IF(attributesVersion IN [1, 3], dnm, ''); // Blank out the appropriate DoNotMail attributesVersion field
		self.Version4.DoNotMail := IF(attributesVersion IN [4], dnm, ''); // Blank out the appropriate DoNotMail attributesVersion field
		self.seq := (string)le.seq;
		self.did := ri.did;
  	self := [];
END;
suppressed_do_not_mail := join(cleanIn, clam, left.seq=right.seq, dnmSuppression(left,right), keep(1), left outer );

with_dnm := join(LeadIntegrity, suppressed_do_not_mail, left.seq=right.seq,
					transform(models.layouts.layout_LeadIntegrity_attributes_batch, 
										self.donotmail := right.doNotMail,
										self.version4.donotmail := right.version4.donotmail,
										self := if((right.DoNotMail='1' OR RIGHT.Version4.DoNotMail='1') AND ~DisableDoNotMailFilter, right, left) ) );

with_ACCTNO := join(batchinseq, with_dnm, left.seq=(unsigned)right.seq, transform(models.layouts.layout_LeadIntegrity_attributes_batch,
				self.acctno := left.acctno;
				self := right));
	

model := case( trim(model_name),
	'anmk909_0' => ungroup(Models.ANMK909_0_1( clam )),
	'msn1106_0' => ungroup(Models.MSN1106_0_0( clam )),
	''          => dataset( [], Models.Layout_ModelOut ),
	fail( Models.Layout_ModelOut, 'Invalid model name requested' )
);

models.layouts.layout_LeadIntegrity_attributes_batch addScore( with_ACCTNO le, model ri ) := TRANSFORM
	// LI4 requirements state a 210 score override is thrown for DoNotMail hits.
	override210 := (Risk_Indicators.rcSet.isCodeFM(le.DoNotMail) or Risk_Indicators.rcSet.isCodeFM(le.Version4.DoNotMail)) and model_name='msn1106_0';


	self.scorename1 := STD.Str.ToUpperCase(trim(model_name));
	self.score1  := if( override210, '210', ri.score );
	self.reason1 := if( override210, 'FM', ri.ri[1].hri );
	self.reason2 := if( override210, '00', ri.ri[2].hri );
	self.reason3 := if( override210, '00', ri.ri[3].hri );
	self.reason4 := if( override210, '00', ri.ri[4].hri );
	// self.reason5 := if( override210, '00', ri.ri[5].hri );
	// self.reason6 := if( override210, '00', ri.ri[6].hri );
	self := le;
end;

with_model := join( with_ACCTNO, model, (integer)left.seq=right.seq, addScore(left,right), left outer );

   
	Models.layouts.layout_LeadIntegrity_attributes_batch_flattened flatten( with_model le ) := TRANSFORM
		self.did := (string)le.did;
		self := le;
		self.Version3__AgeOldestRecord := le.Version3.AgeOldestRecord;
		self.Version3__AgeNewestRecord := le.Version3.AgeNewestRecord;
		self.Version3__SrcsConfirmIDAddrCount := le.Version3.SrcsConfirmIDAddrCount;
		self.Version3__InvalidSSN := le.Version3.InvalidSSN;
		self.Version3__InvalidPhone := le.Version3.InvalidPhone;
		self.Version3__InvalidAddr := le.Version3.InvalidAddr;
		self.Version3__SSNDeceased := le.Version3.SSNDeceased;
		self.Version3__SSNIssued := le.Version3.SSNIssued;
		self.Version3__VerificationFailure := le.Version3.VerificationFailure;
		self.Version3__SSNNotFound := le.Version3.SSNNotFound;
		self.Version3__SSNFoundOther := le.Version3.SSNFoundOther;
		self.Version3__PhoneOther := le.Version3.PhoneOther;
		self.Version3__VerifiedName := le.Version3.VerifiedName;
		self.Version3__VerifiedSSN := le.Version3.VerifiedSSN;
		self.Version3__VerifiedPhone := le.Version3.VerifiedPhone;
		self.Version3__VerifiedPhoneFullName := le.Version3.VerifiedPhoneFullName;
		self.Version3__VerifiedPhoneLastName := le.Version3.VerifiedPhoneLastName;
		self.Version3__VerifiedAddress := le.Version3.VerifiedAddress;
		self.Version3__VerifiedDOB := le.Version3.VerifiedDOB;
		self.Version3__SubjectSSNCount := le.Version3.SubjectSSNCount;
		self.Version3__SubjectAddrCount := le.Version3.SubjectAddrCount;
		self.Version3__SubjectPhoneCount := le.Version3.SubjectPhoneCount;
		self.Version3__SubjectSSNRecentCount := le.Version3.SubjectSSNRecentCount;
		self.Version3__SubjectAddrRecentCount := le.Version3.SubjectAddrRecentCount;
		self.Version3__SubjectPhoneRecentCount := le.Version3.SubjectPhoneRecentCount;
		self.Version3__SSNIdentitiesCount := le.Version3.SSNIdentitiesCount;
		self.Version3__SSNAddrCount := le.Version3.SSNAddrCount;
		self.Version3__SSNIdentitiesRecentCount := le.Version3.SSNIdentitiesRecentCount;
		self.Version3__SSNAddrRecentCount := le.Version3.SSNAddrRecentCount;
		self.Version3__InputAddrIdentitiesCount := le.Version3.InputAddrIdentitiesCount;
		self.Version3__InputAddrSSNCount := le.Version3.InputAddrSSNCount;
		self.Version3__InputAddrPhoneCount := le.Version3.InputAddrPhoneCount;
		self.Version3__InputAddrIdentitiesRecentCount := le.Version3.InputAddrIdentitiesRecentCount;
		self.Version3__InputAddrSSNRecentCount := le.Version3.InputAddrSSNRecentCount;
		self.Version3__InputAddrPhoneRecentCount := le.Version3.InputAddrPhoneRecentCount;
		self.Version3__PhoneIdentitiesCount := le.Version3.PhoneIdentitiesCount;
		self.Version3__PhoneIdentitiesRecentCount := le.Version3.PhoneIdentitiesRecentCount;
		self.Version3__SSNLastNameCount := le.Version3.SSNLastNameCount;
		self.Version3__SubjectLastNameCount := le.Version3.SubjectLastNameCount;
		self.Version3__LastNameChangeCount01 := le.Version3.LastNameChangeCount01;
		self.Version3__LastNameChangeCount03 := le.Version3.LastNameChangeCount03;
		self.Version3__LastNameChangeCount06 := le.Version3.LastNameChangeCount06;
		self.Version3__LastNameChangeCount12 := le.Version3.LastNameChangeCount12;
		self.Version3__LastNameChangeCount24 := le.Version3.LastNameChangeCount24;
		self.Version3__LastNameChangeCount36 := le.Version3.LastNameChangeCount36;
		self.Version3__LastNameChangeCount60 := le.Version3.LastNameChangeCount60;
		self.Version3__SFDUAddrIdentitiesCount := le.Version3.SFDUAddrIdentitiesCount;
		self.Version3__SFDUAddrSSNCount := le.Version3.SFDUAddrSSNCount;
		self.Version3__SSNRecent := le.Version3.SSNRecent;
		self.Version3__SSNNonUS := le.Version3.SSNNonUS;
		self.Version3__SSN3Years := le.Version3.SSN3Years;
		self.Version3__SSNAfter5 := le.Version3.SSNAfter5;
		self.Version3__SSNIssuedPriorDOB := le.Version3.SSNIssuedPriorDOB;
		self.Version3__RelativesCount := le.Version3.RelativesCount;
		self.Version3__RelativesBankruptcyCount := le.Version3.RelativesBankruptcyCount;
		self.Version3__RelativesFelonyCount := le.Version3.RelativesFelonyCount;
		self.Version3__RelativesPropOwnedCount := le.Version3.RelativesPropOwnedCount;
		self.Version3__RelativesPropOwnedTaxTotal := le.Version3.RelativesPropOwnedTaxTotal;
		self.Version3__RelativesDistanceClosest := le.Version3.RelativesDistanceClosest;
		self.Version3__InputAddrDwellType := le.Version3.InputAddrDwellType;
		self.Version3__InputAddrLandUseCode := le.Version3.InputAddrLandUseCode;
		self.Version3__InputAddrApplicantOwned := le.Version3.InputAddrApplicantOwned;
		self.Version3__InputAddrFamilyOwned := le.Version3.InputAddrFamilyOwned;
		self.Version3__InputAddrOccupantOwned := le.Version3.InputAddrOccupantOwned;
		self.Version3__InputAddrAgeLastSale := le.Version3.InputAddrAgeLastSale;
		self.Version3__InputAddrNotPrimaryRes := le.Version3.InputAddrNotPrimaryRes;
		self.Version3__InputAddrActivePhoneList := le.Version3.InputAddrActivePhoneList;
		self.Version3__CurrAddrDwellType := le.Version3.CurrAddrDwellType;
		self.Version3__CurrAddrLandUseCode := le.Version3.CurrAddrLandUseCode;
		self.Version3__CurrAddrApplicantOwned := le.Version3.CurrAddrApplicantOwned;
		self.Version3__CurrAddrFamilyOwned := le.Version3.CurrAddrFamilyOwned;
		self.Version3__CurrAddrOccupantOwned := le.Version3.CurrAddrOccupantOwned;
		self.Version3__CurrAddrAgeLastSale := le.Version3.CurrAddrAgeLastSale;
		self.Version3__CurrAddrActivePhoneList := le.Version3.CurrAddrActivePhoneList;
		self.Version3__PrevAddrDwellType := le.Version3.PrevAddrDwellType;
		self.Version3__PrevAddrLandUseCode := le.Version3.PrevAddrLandUseCode;
		self.Version3__PrevAddrApplicantOwned := le.Version3.PrevAddrApplicantOwned;
		self.Version3__PrevAddrFamilyOwned := le.Version3.PrevAddrFamilyOwned;
		self.Version3__PrevAddrOccupantOwned := le.Version3.PrevAddrOccupantOwned;
		self.Version3__PrevAddrAgeLastSale := le.Version3.PrevAddrAgeLastSale;
		self.Version3__PrevAddrActivePhoneList := le.Version3.PrevAddrActivePhoneList;
		self.Version3__InputCurrAddrMatch := le.Version3.InputCurrAddrMatch;
		self.Version3__InputCurrAddrStateDiff := le.Version3.InputCurrAddrStateDiff;
		self.Version3__InputPrevAddrMatch := le.Version3.InputPrevAddrMatch;
		self.Version3__CurrPrevAddrStateDiff := le.Version3.CurrPrevAddrStateDiff;
		self.Version3__EducationAttendedCollege := le.Version3.EducationAttendedCollege;
		self.Version3__EducationProgram2Yr := le.Version3.EducationProgram2Yr;
		self.Version3__EducationProgram4Yr := le.Version3.EducationProgram4Yr;
		self.Version3__EducationProgramGraduate := le.Version3.EducationProgramGraduate;
		self.Version3__EducationInstitutionPrivate := le.Version3.EducationInstitutionPrivate;
		self.Version3__EducationInstitutionRating := le.Version3.EducationInstitutionRating;
		self.Version3__EducationFieldofStudyType := le.Version3.EducationFieldofStudyType;
		self.Version3__StatusMostRecent := le.Version3.StatusMostRecent;
		self.Version3__StatusPrevious := le.Version3.StatusPrevious;
		self.Version3__StatusNextPrevious := le.Version3.StatusNextPrevious;
		self.Version3__AddrChangeCount01 := le.Version3.AddrChangeCount01;
		self.Version3__AddrChangeCount03 := le.Version3.AddrChangeCount03;
		self.Version3__AddrChangeCount06 := le.Version3.AddrChangeCount06;
		self.Version3__AddrChangeCount12 := le.Version3.AddrChangeCount12;
		self.Version3__AddrChangeCount24 := le.Version3.AddrChangeCount24;
		self.Version3__AddrChangeCount36 := le.Version3.AddrChangeCount36;
		self.Version3__AddrChangeCount60 := le.Version3.AddrChangeCount60;
		self.Version3__PropOwnedCount := le.Version3.PropOwnedCount;
		self.Version3__PropOwnedHistoricalCount := le.Version3.PropOwnedHistoricalCount;
		self.Version3__PredictedAnnualIncome := le.Version3.PredictedAnnualIncome;
		self.Version3__PropAgeOldestPurchase := le.Version3.PropAgeOldestPurchase;
		self.Version3__PropAgeNewestPurchase := le.Version3.PropAgeNewestPurchase;
		self.Version3__PropAgeNewestSale := le.Version3.PropAgeNewestSale;
		self.Version3__PropPurchasedCount01 := le.Version3.PropPurchasedCount01;
		self.Version3__PropPurchasedCount03 := le.Version3.PropPurchasedCount03;
		self.Version3__PropPurchasedCount06 := le.Version3.PropPurchasedCount06;
		self.Version3__PropPurchasedCount12 := le.Version3.PropPurchasedCount12;
		self.Version3__PropPurchasedCount24 := le.Version3.PropPurchasedCount24;
		self.Version3__PropPurchasedCount36 := le.Version3.PropPurchasedCount36;
		self.Version3__PropPurchasedCount60 := le.Version3.PropPurchasedCount60;
		self.Version3__PropSoldCount01 := le.Version3.PropSoldCount01;
		self.Version3__PropSoldCount03 := le.Version3.PropSoldCount03;
		self.Version3__PropSoldCount06 := le.Version3.PropSoldCount06;
		self.Version3__PropSoldCount12 := le.Version3.PropSoldCount12;
		self.Version3__PropSoldCount24 := le.Version3.PropSoldCount24;
		self.Version3__PropSoldCount36 := le.Version3.PropSoldCount36;
		self.Version3__PropSoldCount60 := le.Version3.PropSoldCount60;
		self.Version3__WatercraftCount := le.Version3.WatercraftCount;
		self.Version3__WatercraftCount01 := le.Version3.WatercraftCount01;
		self.Version3__WatercraftCount03 := le.Version3.WatercraftCount03;
		self.Version3__WatercraftCount06 := le.Version3.WatercraftCount06;
		self.Version3__WatercraftCount12 := le.Version3.WatercraftCount12;
		self.Version3__WatercraftCount24 := le.Version3.WatercraftCount24;
		self.Version3__WatercraftCount36 := le.Version3.WatercraftCount36;
		self.Version3__WatercraftCount60 := le.Version3.WatercraftCount60;
		self.Version3__AircraftCount := le.Version3.AircraftCount;
		self.Version3__AircraftCount01 := le.Version3.AircraftCount01;
		self.Version3__AircraftCount03 := le.Version3.AircraftCount03;
		self.Version3__AircraftCount06 := le.Version3.AircraftCount06;
		self.Version3__AircraftCount12 := le.Version3.AircraftCount12;
		self.Version3__AircraftCount24 := le.Version3.AircraftCount24;
		self.Version3__AircraftCount36 := le.Version3.AircraftCount36;
		self.Version3__AircraftCount60 := le.Version3.AircraftCount60;
		self.Version3__DerogCount := le.Version3.DerogCount;
		self.Version3__FelonyCount := le.Version3.FelonyCount;
		self.Version3__FelonyCount01 := le.Version3.FelonyCount01;
		self.Version3__FelonyCount03 := le.Version3.FelonyCount03;
		self.Version3__FelonyCount06 := le.Version3.FelonyCount06;
		self.Version3__FelonyCount12 := le.Version3.FelonyCount12;
		self.Version3__FelonyCount24 := le.Version3.FelonyCount24;
		self.Version3__FelonyCount36 := le.Version3.FelonyCount36;
		self.Version3__FelonyCount60 := le.Version3.FelonyCount60;
		self.Version3__ArrestCount := le.Version3.ArrestCount;
		self.Version3__ArrestCount01 := le.Version3.ArrestCount01;
		self.Version3__ArrestCount03 := le.Version3.ArrestCount03;
		self.Version3__ArrestCount06 := le.Version3.ArrestCount06;
		self.Version3__ArrestCount12 := le.Version3.ArrestCount12;
		self.Version3__ArrestCount24 := le.Version3.ArrestCount24;
		self.Version3__ArrestCount36 := le.Version3.ArrestCount36;
		self.Version3__ArrestCount60 := le.Version3.ArrestCount60;
		self.Version3__LienCount := le.Version3.LienCount;
		self.Version3__LienFiledCount := le.Version3.LienFiledCount;
		self.Version3__LienFiledCount01 := le.Version3.LienFiledCount01;
		self.Version3__LienFiledCount03 := le.Version3.LienFiledCount03;
		self.Version3__LienFiledCount06 := le.Version3.LienFiledCount06;
		self.Version3__LienFiledCount12 := le.Version3.LienFiledCount12;
		self.Version3__LienFiledCount24 := le.Version3.LienFiledCount24;
		self.Version3__LienFiledCount36 := le.Version3.LienFiledCount36;
		self.Version3__LienFiledCount60 := le.Version3.LienFiledCount60;
		self.Version3__LienReleasedCount := le.Version3.LienReleasedCount;
		self.Version3__LienReleasedCount01 := le.Version3.LienReleasedCount01;
		self.Version3__LienReleasedCount03 := le.Version3.LienReleasedCount03;
		self.Version3__LienReleasedCount06 := le.Version3.LienReleasedCount06;
		self.Version3__LienReleasedCount12 := le.Version3.LienReleasedCount12;
		self.Version3__LienReleasedCount24 := le.Version3.LienReleasedCount24;
		self.Version3__LienReleasedCount36 := le.Version3.LienReleasedCount36;
		self.Version3__LienReleasedCount60 := le.Version3.LienReleasedCount60;
		self.Version3__BankruptcyCount := le.Version3.BankruptcyCount;
		self.Version3__BankruptcyCount01 := le.Version3.BankruptcyCount01;
		self.Version3__BankruptcyCount03 := le.Version3.BankruptcyCount03;
		self.Version3__BankruptcyCount06 := le.Version3.BankruptcyCount06;
		self.Version3__BankruptcyCount12 := le.Version3.BankruptcyCount12;
		self.Version3__BankruptcyCount24 := le.Version3.BankruptcyCount24;
		self.Version3__BankruptcyCount36 := le.Version3.BankruptcyCount36;
		self.Version3__BankruptcyCount60 := le.Version3.BankruptcyCount60;
		self.Version3__EvictionCount := le.Version3.EvictionCount;
		self.Version3__EvictionCount01 := le.Version3.EvictionCount01;
		self.Version3__EvictionCount03 := le.Version3.EvictionCount03;
		self.Version3__EvictionCount06 := le.Version3.EvictionCount06;
		self.Version3__EvictionCount12 := le.Version3.EvictionCount12;
		self.Version3__EvictionCount24 := le.Version3.EvictionCount24;
		self.Version3__EvictionCount36 := le.Version3.EvictionCount36;
		self.Version3__EvictionCount60 := le.Version3.EvictionCount60;
		self.Version3__NonDerogCount := le.Version3.NonDerogCount;
		self.Version3__NonDerogCount01 := le.Version3.NonDerogCount01;
		self.Version3__NonDerogCount03 := le.Version3.NonDerogCount03;
		self.Version3__NonDerogCount06 := le.Version3.NonDerogCount06;
		self.Version3__NonDerogCount12 := le.Version3.NonDerogCount12;
		self.Version3__NonDerogCount24 := le.Version3.NonDerogCount24;
		self.Version3__NonDerogCount36 := le.Version3.NonDerogCount36;
		self.Version3__NonDerogCount60 := le.Version3.NonDerogCount60;
		self.Version3__ProfLicCount := le.Version3.ProfLicCount;
		self.Version3__ProfLicCount01 := le.Version3.ProfLicCount01;
		self.Version3__ProfLicCount03 := le.Version3.ProfLicCount03;
		self.Version3__ProfLicCount06 := le.Version3.ProfLicCount06;
		self.Version3__ProfLicCount12 := le.Version3.ProfLicCount12;
		self.Version3__ProfLicCount24 := le.Version3.ProfLicCount24;
		self.Version3__ProfLicCount36 := le.Version3.ProfLicCount36;
		self.Version3__ProfLicCount60 := le.Version3.ProfLicCount60;
		self.Version3__ProfLicExpireCount01 := le.Version3.ProfLicExpireCount01;
		self.Version3__ProfLicExpireCount03 := le.Version3.ProfLicExpireCount03;
		self.Version3__ProfLicExpireCount06 := le.Version3.ProfLicExpireCount06;
		self.Version3__ProfLicExpireCount12 := le.Version3.ProfLicExpireCount12;
		self.Version3__ProfLicExpireCount24 := le.Version3.ProfLicExpireCount24;
		self.Version3__ProfLicExpireCount36 := le.Version3.ProfLicExpireCount36;
		self.Version3__ProfLicExpireCount60 := le.Version3.ProfLicExpireCount60;
		self.Version3__PropNewestSalePurchaseIndex := le.Version3.PropNewestSalePurchaseIndex;
		self.Version3__SubPrimeSolicitedCount := le.Version3.SubPrimeSolicitedCount;
		self.Version3__SubPrimeSolicitedCount01 := le.Version3.SubPrimeSolicitedCount01;
		self.Version3__SubprimeSolicitedCount03 := le.Version3.SubprimeSolicitedCount03;
		self.Version3__SubprimeSolicitedCount06 := le.Version3.SubprimeSolicitedCount06;
		self.Version3__SubPrimeSolicitedCount12 := le.Version3.SubPrimeSolicitedCount12;
		self.Version3__SubPrimeSolicitedCount24 := le.Version3.SubPrimeSolicitedCount24;
		self.Version3__SubPrimeSolicitedCount36 := le.Version3.SubPrimeSolicitedCount36;
		self.Version3__SubPrimeSolicitedCount60 := le.Version3.SubPrimeSolicitedCount60;
		self.Version3__DerogSeverityIndex := le.Version3.DerogSeverityIndex;
		self.Version3__DerogAge := le.Version3.DerogAge;
		self.Version3__FelonyAge := le.Version3.FelonyAge;
		self.Version3__ArrestAge := le.Version3.ArrestAge;
		self.Version3__LienFiledAge := le.Version3.LienFiledAge;
		self.Version3__LienReleasedAge := le.Version3.LienReleasedAge;
		self.Version3__BankruptcyAge := le.Version3.BankruptcyAge;
		self.Version3__BankruptcyType := le.Version3.BankruptcyType;
		self.Version3__EvictionAge := le.Version3.EvictionAge;
		self.Version3__ProfLicAge := le.Version3.ProfLicAge;
		self.Version3__ProfLicTypeCategory := le.Version3.ProfLicTypeCategory;
		self.Version3__PRSearchCollectionCount := le.Version3.PRSearchCollectionCount;
		self.Version3__PRSearchCollectionCount01 := le.Version3.PRSearchCollectionCount01;
		self.Version3__PRSearchCollectionCount03 := le.Version3.PRSearchCollectionCount03;
		self.Version3__PRSearchCollectionCount06 := le.Version3.PRSearchCollectionCount06;
		self.Version3__PRSearchCollectionCount12 := le.Version3.PRSearchCollectionCount12;
		self.Version3__PRSearchCollectionCount24 := le.Version3.PRSearchCollectionCount24;
		self.Version3__PRSearchCollectionCount36 := le.Version3.PRSearchCollectionCount36;
		self.Version3__PRSearchCollectionCount60 := le.Version3.PRSearchCollectionCount60;
		self.Version3__PRSearchIDVFraudCount := le.Version3.PRSearchIDVFraudCount;
		self.Version3__PRSearchIDVFraudCount01 := le.Version3.PRSearchIDVFraudCount01;
		self.Version3__PRSearchIDVFraudCount03 := le.Version3.PRSearchIDVFraudCount03;
		self.Version3__PRSearchIDVFraudCount06 := le.Version3.PRSearchIDVFraudCount06;
		self.Version3__PRSearchIDVFraudCount12 := le.Version3.PRSearchIDVFraudCount12;
		self.Version3__PRSearchIDVFraudCount24 := le.Version3.PRSearchIDVFraudCount24;
		self.Version3__PRSearchIDVFraudCount36 := le.Version3.PRSearchIDVFraudCount36;
		self.Version3__PRSearchIDVFraudCount60 := le.Version3.PRSearchIDVFraudCount60;
		self.Version3__PRSearchOtherCount := le.Version3.PRSearchOtherCount;
		self.Version3__PRSearchOtherCount01 := le.Version3.PRSearchOtherCount01;
		self.Version3__PRSearchOtherCount03 := le.Version3.PRSearchOtherCount03;
		self.Version3__PRSearchOtherCount06 := le.Version3.PRSearchOtherCount06;
		self.Version3__PRSearchOtherCount12 := le.Version3.PRSearchOtherCount12;
		self.Version3__PRSearchOtherCount24 := le.Version3.PRSearchOtherCount24;
		self.Version3__PRSearchOtherCount36 := le.Version3.PRSearchOtherCount36;
		self.Version3__PRSearchOtherCount60 := le.Version3.PRSearchOtherCount60;
		self.Version3__InputPhoneStatus := le.Version3.InputPhoneStatus;
		self.Version3__InputPhonePager := le.Version3.InputPhonePager;
		self.Version3__InputPhoneMobile := le.Version3.InputPhoneMobile;
		self.Version3__InputPhoneType := le.Version3.InputPhoneType;
		self.Version3__InputAreaCodeChange := le.Version3.InputAreaCodeChange;
		self.Version3__PhoneOtherAgeOldestRecord := le.Version3.PhoneOtherAgeOldestRecord;
		self.Version3__PhoneOtherAgeNewestRecord := le.Version3.PhoneOtherAgeNewestRecord;
		self.Version3__InvalidPhoneZip := le.Version3.InvalidPhoneZip;
		self.Version3__InputAddrValidation := le.Version3.InputAddrValidation;
		self.Version3__InputAddrHighRisk := le.Version3.InputAddrHighRisk;
		self.Version3__InputPhoneHighRisk := le.Version3.InputPhoneHighRisk;
		self.Version3__InputAddrPrison := le.Version3.InputAddrPrison;
		self.Version3__CurrAddrPrison := le.Version3.CurrAddrPrison;
		self.Version3__PrevAddrPrison := le.Version3.PrevAddrPrison;
		self.Version3__HistoricalAddrPrison := le.Version3.HistoricalAddrPrison;
		self.Version3__InputZipPOBox := le.Version3.InputZipPOBox;
		self.Version3__InputZipCorpMil := le.Version3.InputZipCorpMil;
		self.Version3__CreditBureauRecord := le.Version3.CreditBureauRecord;
		
		
		
	
		self.v4_AgeOldestRecord                     := le.version4.AgeOldestRecord;
		self.v4_AgeNewestRecord                     := le.version4.AgeNewestRecord;
		self.v4_RecentUpdate                        := le.version4.RecentUpdate;
		self.v4_SrcsConfirmIDAddrCount              := le.version4.SrcsConfirmIDAddrCount;
		self.v4_CreditBureauRecord                  := le.version4.CreditBureauRecord;
		self.v4_VerificationFailure                 := le.version4.VerificationFailure;
		self.v4_SSNNotFound                         := le.version4.SSNNotFound;
		self.v4_SSNFoundOther                       := le.version4.SSNFoundOther;
		self.v4_VerifiedName                        := le.version4.VerifiedName;
		self.v4_VerifiedSSN                         := le.version4.VerifiedSSN;
		self.v4_VerifiedPhone                       := le.version4.VerifiedPhone;
		self.v4_VerifiedAddress                     := le.version4.VerifiedAddress;
		self.v4_VerifiedDOB                         := le.version4.VerifiedDOB;
		self.v4_AgeRiskIndicator                    := le.version4.AgeRiskIndicator;
		self.v4_SubjectSSNCount                     := le.version4.SubjectSSNCount;
		self.v4_SubjectAddrCount                    := le.version4.SubjectAddrCount;
		self.v4_SubjectPhoneCount                   := le.version4.SubjectPhoneCount;
		self.v4_SubjectSSNRecentCount               := le.version4.SubjectSSNRecentCount;
		self.v4_SubjectAddrRecentCount              := le.version4.SubjectAddrRecentCount;
		self.v4_SubjectPhoneRecentCount             := le.version4.SubjectPhoneRecentCount;
		self.v4_SSNIdentitiesCount                  := le.version4.SSNIdentitiesCount;
		self.v4_SSNAddrCount                        := le.version4.SSNAddrCount;
		self.v4_SSNIdentitiesRecentCount            := le.version4.SSNIdentitiesRecentCount;
		self.v4_SSNAddrRecentCount                  := le.version4.SSNAddrRecentCount;
		self.v4_InputAddrPhoneCount                 := le.version4.InputAddrPhoneCount;
		self.v4_InputAddrPhoneRecentCount           := le.version4.InputAddrPhoneRecentCount;
		self.v4_PhoneIdentitiesCount                := le.version4.PhoneIdentitiesCount;
		self.v4_PhoneIdentitiesRecentCount          := le.version4.PhoneIdentitiesRecentCount;
		self.v4_PhoneOther                          := le.version4.PhoneOther;
		self.v4_SSNLastNameCount                    := le.version4.SSNLastNameCount;
		self.v4_SubjectLastNameCount                := le.version4.SubjectLastNameCount;
		self.v4_LastNameChangeAge                   := le.version4.LastNameChangeAge;
		self.v4_LastNameChangeCount01               := le.version4.LastNameChangeCount01;
		self.v4_LastNameChangeCount03               := le.version4.LastNameChangeCount03;
		self.v4_LastNameChangeCount06               := le.version4.LastNameChangeCount06;
		self.v4_LastNameChangeCount12               := le.version4.LastNameChangeCount12;
		self.v4_LastNameChangeCount24               := le.version4.LastNameChangeCount24;
		self.v4_LastNameChangeCount60               := le.version4.LastNameChangeCount60;
		self.v4_SFDUAddrIdentitiesCount             := le.version4.SFDUAddrIdentitiesCount;
		self.v4_SFDUAddrSSNCount                    := le.version4.SFDUAddrSSNCount;
		self.v4_SSNAgeDeceased                      := le.version4.SSNAgeDeceased;
		self.v4_SSNRecent                           := le.version4.SSNRecent;
		self.v4_SSNLowIssueAge                      := le.version4.SSNLowIssueAge;
		self.v4_SSNHighIssueAge                     := le.version4.SSNHighIssueAge;
		self.v4_SSNIssueState                       := le.version4.SSNIssueState;
		self.v4_SSNNonUS                            := le.version4.SSNNonUS;
		self.v4_SSN3Years                           := le.version4.SSN3Years;
		self.v4_SSNAfter5                           := le.version4.SSNAfter5;
		self.v4_SSNProblems                         := le.version4.SSNProblems;
		self.v4_RelativesCount                      := le.version4.RelativesCount;
		self.v4_RelativesBankruptcyCount            := le.version4.RelativesBankruptcyCount;
		self.v4_RelativesFelonyCount                := le.version4.RelativesFelonyCount;
		self.v4_RelativesPropOwnedCount             := le.version4.RelativesPropOwnedCount;
		self.v4_RelativesPropOwnedTaxTotal          := le.version4.RelativesPropOwnedTaxTotal;
		self.v4_RelativesDistanceClosest            := le.version4.RelativesDistanceClosest;
		self.v4_InputAddrAgeOldestRecord            := le.version4.InputAddrAgeOldestRecord;
		self.v4_InputAddrAgeNewestRecord            := le.version4.InputAddrAgeNewestRecord;
		self.v4_InputAddrHistoricalMatch            := le.version4.InputAddrHistoricalMatch;
		self.v4_InputAddrLenOfRes                   := le.version4.InputAddrLenOfRes;
		self.v4_InputAddrDwellType                  := le.version4.InputAddrDwellType;
		self.v4_InputAddrDelivery                   := le.version4.InputAddrDelivery;
		self.v4_InputAddrApplicantOwned             := le.version4.InputAddrApplicantOwned;
		self.v4_InputAddrFamilyOwned                := le.version4.InputAddrFamilyOwned;
		self.v4_InputAddrOccupantOwned              := le.version4.InputAddrOccupantOwned;
		self.v4_InputAddrAgeLastSale                := le.version4.InputAddrAgeLastSale;
		self.v4_InputAddrLastSalesPrice             := le.version4.InputAddrLastSalesPrice;
		self.v4_InputAddrMortgageType               := le.version4.InputAddrMortgageType;
		self.v4_InputAddrNotPrimaryRes              := le.version4.InputAddrNotPrimaryRes;
		self.v4_InputAddrActivePhoneList            := le.version4.InputAddrActivePhoneList;
		self.v4_InputAddrTaxValue                   := le.version4.InputAddrTaxValue;
		self.v4_InputAddrTaxYr                      := le.version4.InputAddrTaxYr;
		self.v4_InputAddrTaxMarketValue             := le.version4.InputAddrTaxMarketValue;
		self.v4_InputAddrAVMValue                   := le.version4.InputAddrAVMValue;
		self.v4_InputAddrAVMValue12                 := le.version4.InputAddrAVMValue12;
		self.v4_InputAddrAVMValue60                 := le.version4.InputAddrAVMValue60;
		self.v4_InputAddrCountyIndex                := le.version4.InputAddrCountyIndex;
		self.v4_InputAddrTractIndex                 := le.version4.InputAddrTractIndex;
		self.v4_InputAddrBlockIndex                 := le.version4.InputAddrBlockIndex;
		self.v4_InputAddrMedianIncome               := le.version4.InputAddrMedianIncome;
		self.v4_InputAddrMedianValue                := le.version4.InputAddrMedianValue;
		self.v4_InputAddrMurderIndex                := le.version4.InputAddrMurderIndex;
		self.v4_InputAddrCarTheftIndex              := le.version4.InputAddrCarTheftIndex;
		self.v4_InputAddrBurglaryIndex              := le.version4.InputAddrBurglaryIndex;
		self.v4_InputAddrCrimeIndex                 := le.version4.InputAddrCrimeIndex;
		self.v4_InputAddrMobilityIndex              := le.version4.InputAddrMobilityIndex;
		self.v4_InputAddrVacantPropCount            := le.version4.InputAddrVacantPropCount;
		self.v4_InputAddrBusinessCount              := le.version4.InputAddrBusinessCount;
		self.v4_InputAddrSingleFamilyCount          := le.version4.InputAddrSingleFamilyCount;
		self.v4_InputAddrMultiFamilyCount           := le.version4.InputAddrMultiFamilyCount;
		self.v4_CurrAddrAgeOldestRecord             := le.version4.CurrAddrAgeOldestRecord;
		self.v4_CurrAddrAgeNewestRecord             := le.version4.CurrAddrAgeNewestRecord;
		self.v4_CurrAddrLenOfRes                    := le.version4.CurrAddrLenOfRes;
		self.v4_CurrAddrDwellType                   := le.version4.CurrAddrDwellType;
		self.v4_CurrAddrApplicantOwned              := le.version4.CurrAddrApplicantOwned;
		self.v4_CurrAddrFamilyOwned                 := le.version4.CurrAddrFamilyOwned;
		self.v4_CurrAddrOccupantOwned               := le.version4.CurrAddrOccupantOwned;
		self.v4_CurrAddrAgeLastSale                 := le.version4.CurrAddrAgeLastSale;
		self.v4_CurrAddrLastSalesPrice              := le.version4.CurrAddrLastSalesPrice;
		self.v4_CurrAddrMortgageType                := le.version4.CurrAddrMortgageType;
		self.v4_CurrAddrActivePhoneList             := le.version4.CurrAddrActivePhoneList;
		self.v4_CurrAddrTaxValue                    := le.version4.CurrAddrTaxValue;
		self.v4_CurrAddrTaxYr                       := le.version4.CurrAddrTaxYr;
		self.v4_CurrAddrTaxMarketValue              := le.version4.CurrAddrTaxMarketValue;
		self.v4_CurrAddrAVMValue                    := le.version4.CurrAddrAVMValue;
		self.v4_CurrAddrAVMValue12                  := le.version4.CurrAddrAVMValue12;
		self.v4_CurrAddrAVMValue60                  := le.version4.CurrAddrAVMValue60;
		self.v4_CurrAddrCountyIndex                 := le.version4.CurrAddrCountyIndex;
		self.v4_CurrAddrTractIndex                  := le.version4.CurrAddrTractIndex;
		self.v4_CurrAddrBlockIndex                  := le.version4.CurrAddrBlockIndex;
		self.v4_CurrAddrMedianIncome                := le.version4.CurrAddrMedianIncome;
		self.v4_CurrAddrMedianValue                 := le.version4.CurrAddrMedianValue;
		self.v4_CurrAddrMurderIndex                 := le.version4.CurrAddrMurderIndex;
		self.v4_CurrAddrCarTheftIndex               := le.version4.CurrAddrCarTheftIndex;
		self.v4_CurrAddrBurglaryIndex               := le.version4.CurrAddrBurglaryIndex;
		self.v4_CurrAddrCrimeIndex                  := le.version4.CurrAddrCrimeIndex;
		self.v4_PrevAddrAgeOldestRecord             := le.version4.PrevAddrAgeOldestRecord;
		self.v4_PrevAddrAgeNewestRecord             := le.version4.PrevAddrAgeNewestRecord;
		self.v4_PrevAddrLenOfRes                    := le.version4.PrevAddrLenOfRes;
		self.v4_PrevAddrDwellType                   := le.version4.PrevAddrDwellType;
		self.v4_PrevAddrApplicantOwned              := le.version4.PrevAddrApplicantOwned;
		self.v4_PrevAddrFamilyOwned                 := le.version4.PrevAddrFamilyOwned;
		self.v4_PrevAddrOccupantOwned               := le.version4.PrevAddrOccupantOwned;
		self.v4_PrevAddrAgeLastSale                 := le.version4.PrevAddrAgeLastSale;
		self.v4_PrevAddrLastSalesPrice              := le.version4.PrevAddrLastSalesPrice;
		self.v4_PrevAddrTaxValue                    := le.version4.PrevAddrTaxValue;
		self.v4_PrevAddrTaxYr                       := le.version4.PrevAddrTaxYr;
		self.v4_PrevAddrTaxMarketValue              := le.version4.PrevAddrTaxMarketValue;
		self.v4_PrevAddrAVMValue                    := le.version4.PrevAddrAVMValue;
		self.v4_PrevAddrCountyIndex                 := le.version4.PrevAddrCountyIndex;
		self.v4_PrevAddrTractIndex                  := le.version4.PrevAddrTractIndex;
		self.v4_PrevAddrBlockIndex                  := le.version4.PrevAddrBlockIndex;
		self.v4_PrevAddrMedianIncome                := le.version4.PrevAddrMedianIncome;
		self.v4_PrevAddrMedianValue                 := le.version4.PrevAddrMedianValue;
		self.v4_PrevAddrMurderIndex                 := le.version4.PrevAddrMurderIndex;
		self.v4_PrevAddrCarTheftIndex               := le.version4.PrevAddrCarTheftIndex;
		self.v4_PrevAddrBurglaryIndex               := le.version4.PrevAddrBurglaryIndex;
		self.v4_PrevAddrCrimeIndex                  := le.version4.PrevAddrCrimeIndex;
		self.v4_AddrMostRecentDistance              := le.version4.AddrMostRecentDistance;
		self.v4_AddrMostRecentStateDiff             := le.version4.AddrMostRecentStateDiff;
		self.v4_AddrMostRecentTaxDiff               := le.version4.AddrMostRecentTaxDiff;
		self.v4_AddrMostRecentMoveAge               := le.version4.AddrMostRecentMoveAge;
		self.v4_AddrMostRecentIncomeDiff            := le.version4.AddrMostRecentIncomeDiff;
		self.v4_AddrMostRecentValueDIff             := le.version4.AddrMostRecentValueDIff;
		self.v4_AddrMostRecentCrimeDiff             := le.version4.AddrMostRecentCrimeDiff;
		self.v4_AddrRecentEconTrajectory            := le.version4.AddrRecentEconTrajectory;
		self.v4_AddrRecentEconTrajectoryIndex       := le.version4.AddrRecentEconTrajectoryIndex;
		self.v4_EducationAttendedCollege            := le.version4.EducationAttendedCollege;
		self.v4_EducationProgram2Yr                 := le.version4.EducationProgram2Yr;
		self.v4_EducationProgram4Yr                 := le.version4.EducationProgram4Yr;
		self.v4_EducationProgramGraduate            := le.version4.EducationProgramGraduate;
		self.v4_EducationInstitutionPrivate         := le.version4.EducationInstitutionPrivate;
		self.v4_EducationInstitutionRating          := le.version4.EducationInstitutionRating;
		self.v4_EducationFieldofStudyType           := le.version4.EducationFieldofStudyType;
		self.v4_AddrStability                       := le.version4.AddrStability;
		self.v4_StatusMostRecent                    := le.version4.StatusMostRecent;
		self.v4_StatusPrevious                      := le.version4.StatusPrevious;
		self.v4_StatusNextPrevious                  := le.version4.StatusNextPrevious;
		self.v4_AddrChangeCount01                   := le.version4.AddrChangeCount01;
		self.v4_AddrChangeCount03                   := le.version4.AddrChangeCount03;
		self.v4_AddrChangeCount06                   := le.version4.AddrChangeCount06;
		self.v4_AddrChangeCount12                   := le.version4.AddrChangeCount12;
		self.v4_AddrChangeCount24                   := le.version4.AddrChangeCount24;
		self.v4_AddrChangeCount60                   := le.version4.AddrChangeCount60;
		self.v4_EstimatedAnnualIncome               := le.version4.EstimatedAnnualIncome;
		self.v4_AssetOwner                          := le.version4.AssetOwner;
		self.v4_PropertyOwner                       := le.version4.PropertyOwner;
		self.v4_PropOwnedCount                      := le.version4.PropOwnedCount;
		self.v4_PropOwnedTaxTotal                   := le.version4.PropOwnedTaxTotal;
		self.v4_PropOwnedHistoricalCount            := le.version4.PropOwnedHistoricalCount;
		self.v4_PropAgeOldestPurchase               := le.version4.PropAgeOldestPurchase;
		self.v4_PropAgeNewestPurchase               := le.version4.PropAgeNewestPurchase;
		self.v4_PropAgeNewestSale                   := le.version4.PropAgeNewestSale;
		self.v4_PropNewestSalePrice                 := le.version4.PropNewestSalePrice;
		self.v4_PropNewestSalePurchaseIndex         := le.version4.PropNewestSalePurchaseIndex;
		self.v4_PropPurchasedCount01                := le.version4.PropPurchasedCount01;
		self.v4_PropPurchasedCount03                := le.version4.PropPurchasedCount03;
		self.v4_PropPurchasedCount06                := le.version4.PropPurchasedCount06;
		self.v4_PropPurchasedCount12                := le.version4.PropPurchasedCount12;
		self.v4_PropPurchasedCount24                := le.version4.PropPurchasedCount24;
		self.v4_PropPurchasedCount60                := le.version4.PropPurchasedCount60;
		self.v4_PropSoldCount01                     := le.version4.PropSoldCount01;
		self.v4_PropSoldCount03                     := le.version4.PropSoldCount03;
		self.v4_PropSoldCount06                     := le.version4.PropSoldCount06;
		self.v4_PropSoldCount12                     := le.version4.PropSoldCount12;
		self.v4_PropSoldCount24                     := le.version4.PropSoldCount24;
		self.v4_PropSoldCount60                     := le.version4.PropSoldCount60;
		self.v4_WatercraftOwner                     := le.version4.WatercraftOwner;
		self.v4_WatercraftCount                     := le.version4.WatercraftCount;
		self.v4_WatercraftCount01                   := le.version4.WatercraftCount01;
		self.v4_WatercraftCount03                   := le.version4.WatercraftCount03;
		self.v4_WatercraftCount06                   := le.version4.WatercraftCount06;
		self.v4_WatercraftCount12                   := le.version4.WatercraftCount12;
		self.v4_WatercraftCount24                   := le.version4.WatercraftCount24;
		self.v4_WatercraftCount60                   := le.version4.WatercraftCount60;
		self.v4_AircraftOwner                       := le.version4.AircraftOwner;
		self.v4_AircraftCount                       := le.version4.AircraftCount;
		self.v4_AircraftCount01                     := le.version4.AircraftCount01;
		self.v4_AircraftCount03                     := le.version4.AircraftCount03;
		self.v4_AircraftCount06                     := le.version4.AircraftCount06;
		self.v4_AircraftCount12                     := le.version4.AircraftCount12;
		self.v4_AircraftCount24                     := le.version4.AircraftCount24;
		self.v4_AircraftCount60                     := le.version4.AircraftCount60;
		self.v4_WealthIndex                         := le.version4.WealthIndex;
		self.v4_BusinessActiveAssociation           := le.version4.BusinessActiveAssociation;
		self.v4_BusinessInactiveAssociation         := le.version4.BusinessInactiveAssociation;
		self.v4_BusinessAssociationAge              := le.version4.BusinessAssociationAge;
		self.v4_BusinessTitle                       := le.version4.BusinessTitle;
		self.v4_BusinessInputAddrCount              := le.version4.BusinessInputAddrCount;
		self.v4_DerogSeverityIndex                  := le.version4.DerogSeverityIndex;
		self.v4_DerogCount                          := le.version4.DerogCount;
		self.v4_DerogRecentCount                    := le.version4.DerogRecentCount;
		self.v4_DerogAge                            := le.version4.DerogAge;
		self.v4_FelonyCount                         := le.version4.FelonyCount;
		self.v4_FelonyAge                           := le.version4.FelonyAge;
		self.v4_FelonyCount01                       := le.version4.FelonyCount01;
		self.v4_FelonyCount03                       := le.version4.FelonyCount03;
		self.v4_FelonyCount06                       := le.version4.FelonyCount06;
		self.v4_FelonyCount12                       := le.version4.FelonyCount12;
		self.v4_FelonyCount24                       := le.version4.FelonyCount24;
		self.v4_FelonyCount60                       := le.version4.FelonyCount60;
		self.v4_ArrestCount                         := le.version4.ArrestCount;
		self.v4_ArrestAge                           := le.version4.ArrestAge;
		self.v4_ArrestCount01                       := le.version4.ArrestCount01;
		self.v4_ArrestCount03                       := le.version4.ArrestCount03;
		self.v4_ArrestCount06                       := le.version4.ArrestCount06;
		self.v4_ArrestCount12                       := le.version4.ArrestCount12;
		self.v4_ArrestCount24                       := le.version4.ArrestCount24;
		self.v4_ArrestCount60                       := le.version4.ArrestCount60;
		self.v4_LienCount                           := le.version4.LienCount;
		self.v4_LienFiledCount                      := le.version4.LienFiledCount;
		self.v4_LienFiledTotal                      := le.version4.LienFiledTotal;
		self.v4_LienFiledAge                        := le.version4.LienFiledAge;
		self.v4_LienFiledCount01                    := le.version4.LienFiledCount01;
		self.v4_LienFiledCount03                    := le.version4.LienFiledCount03;
		self.v4_LienFiledCount06                    := le.version4.LienFiledCount06;
		self.v4_LienFiledCount12                    := le.version4.LienFiledCount12;
		self.v4_LienFiledCount24                    := le.version4.LienFiledCount24;
		self.v4_LienFiledCount60                    := le.version4.LienFiledCount60;
		self.v4_LienReleasedCount                   := le.version4.LienReleasedCount;
		self.v4_LienReleasedTotal                   := le.version4.LienReleasedTotal;
		self.v4_LienReleasedAge                     := le.version4.LienReleasedAge;
		self.v4_LienReleasedCount01                 := le.version4.LienReleasedCount01;
		self.v4_LienReleasedCount03                 := le.version4.LienReleasedCount03;
		self.v4_LienReleasedCount06                 := le.version4.LienReleasedCount06;
		self.v4_LienReleasedCount12                 := le.version4.LienReleasedCount12;
		self.v4_LienReleasedCount24                 := le.version4.LienReleasedCount24;
		self.v4_LienReleasedCount60                 := le.version4.LienReleasedCount60;
		self.v4_BankruptcyCount                     := le.version4.BankruptcyCount;
		self.v4_BankruptcyAge                       := le.version4.BankruptcyAge;
		self.v4_BankruptcyType                      := le.version4.BankruptcyType;
		self.v4_BankruptcyStatus                    := le.version4.BankruptcyStatus;
		self.v4_BankruptcyCount01                   := le.version4.BankruptcyCount01;
		self.v4_BankruptcyCount03                   := le.version4.BankruptcyCount03;
		self.v4_BankruptcyCount06                   := le.version4.BankruptcyCount06;
		self.v4_BankruptcyCount12                   := le.version4.BankruptcyCount12;
		self.v4_BankruptcyCount24                   := le.version4.BankruptcyCount24;
		self.v4_BankruptcyCount60                   := le.version4.BankruptcyCount60;
		self.v4_EvictionCount                       := le.version4.EvictionCount;
		self.v4_EvictionAge                         := le.version4.EvictionAge;
		self.v4_EvictionCount01                     := le.version4.EvictionCount01;
		self.v4_EvictionCount03                     := le.version4.EvictionCount03;
		self.v4_EvictionCount06                     := le.version4.EvictionCount06;
		self.v4_EvictionCount12                     := le.version4.EvictionCount12;
		self.v4_EvictionCount24                     := le.version4.EvictionCount24;
		self.v4_EvictionCount60                     := le.version4.EvictionCount60;
		self.v4_AccidentCount                       := le.version4.AccidentCount;
		self.v4_AccidentAge                         := le.version4.AccidentAge;
		self.v4_RecentActivityIndex                 := le.version4.RecentActivityIndex;
		self.v4_NonDerogCount                       := le.version4.NonDerogCount;
		self.v4_NonDerogCount01                     := le.version4.NonDerogCount01;
		self.v4_NonDerogCount03                     := le.version4.NonDerogCount03;
		self.v4_NonDerogCount06                     := le.version4.NonDerogCount06;
		self.v4_NonDerogCount12                     := le.version4.NonDerogCount12;
		self.v4_NonDerogCount24                     := le.version4.NonDerogCount24;
		self.v4_NonDerogCount60                     := le.version4.NonDerogCount60;
		self.v4_VoterRegistrationRecord             := le.version4.VoterRegistrationRecord;
		self.v4_ProfLicCount                        := le.version4.ProfLicCount;
		self.v4_ProfLicAge                          := le.version4.ProfLicAge;
		self.v4_ProfLicTypeCategory                 := le.version4.ProfLicTypeCategory;
		self.v4_ProfLicExpired                      := le.version4.ProfLicExpired;
		self.v4_ProfLicCount01                      := le.version4.ProfLicCount01;
		self.v4_ProfLicCount03                      := le.version4.ProfLicCount03;
		self.v4_ProfLicCount06                      := le.version4.ProfLicCount06;
		self.v4_ProfLicCount12                      := le.version4.ProfLicCount12;
		self.v4_ProfLicCount24                      := le.version4.ProfLicCount24;
		self.v4_ProfLicCount60                      := le.version4.ProfLicCount60;
		self.v4_PRSearchLocateCount                 := le.version4.PRSearchLocateCount;
		self.v4_PRSearchLocateCount01               := le.version4.PRSearchLocateCount01;
		self.v4_PRSearchLocateCount03               := le.version4.PRSearchLocateCount03;
		self.v4_PRSearchLocateCount06               := le.version4.PRSearchLocateCount06;
		self.v4_PRSearchLocateCount12               := le.version4.PRSearchLocateCount12;
		self.v4_PRSearchLocateCount24               := le.version4.PRSearchLocateCount24;
		self.v4_PRSearchPersonalFinanceCount        := le.version4.PRSearchPersonalFinanceCount;
		self.v4_PRSearchPersonalFinanceCount01      := le.version4.PRSearchPersonalFinanceCount01;
		self.v4_PRSearchPersonalFinanceCount03      := le.version4.PRSearchPersonalFinanceCount03;
		self.v4_PRSearchPersonalFinanceCount06      := le.version4.PRSearchPersonalFinanceCount06;
		self.v4_PRSearchPersonalFinanceCount12      := le.version4.PRSearchPersonalFinanceCount12;
		self.v4_PRSearchPersonalFinanceCount24      := le.version4.PRSearchPersonalFinanceCount24;
		self.v4_PRSearchOtherCount                  := le.version4.PRSearchOtherCount;
		self.v4_PRSearchOtherCount01                := le.version4.PRSearchOtherCount01;
		self.v4_PRSearchOtherCount03                := le.version4.PRSearchOtherCount03;
		self.v4_PRSearchOtherCount06                := le.version4.PRSearchOtherCount06;
		self.v4_PRSearchOtherCount12                := le.version4.PRSearchOtherCount12;
		self.v4_PRSearchOtherCount24                := le.version4.PRSearchOtherCount24;
		self.v4_PRSearchIdentitySSNs                := le.version4.PRSearchIdentitySSNs;
		self.v4_PRSearchIdentityAddrs               := le.version4.PRSearchIdentityAddrs;
		self.v4_PRSearchIdentityPhones              := le.version4.PRSearchIdentityPhones;
		self.v4_PRSearchSSNIdentities               := le.version4.PRSearchSSNIdentities;
		self.v4_PRSearchAddrIdentities              := le.version4.PRSearchAddrIdentities;
		self.v4_PRSearchPhoneIdentities             := le.version4.PRSearchPhoneIdentities;
		self.v4_SubPrimeOfferRequestCount           := le.version4.SubPrimeOfferRequestCount;
		self.v4_SubPrimeOfferRequestCount01         := le.version4.SubPrimeOfferRequestCount01;
		self.v4_SubPrimeOfferRequestCount03         := le.version4.SubPrimeOfferRequestCount03;
		self.v4_SubPrimeOfferRequestCount06         := le.version4.SubPrimeOfferRequestCount06;
		self.v4_SubPrimeOfferRequestCount12         := le.version4.SubPrimeOfferRequestCount12;
		self.v4_SubPrimeOfferRequestCount24         := le.version4.SubPrimeOfferRequestCount24;
		self.v4_SubPrimeOfferRequestCount60         := le.version4.SubPrimeOfferRequestCount60;
		self.v4_InputPhoneMobile                    := le.version4.InputPhoneMobile;
		self.v4_InputPhoneType                      := le.version4.InputPhoneType;
		self.v4_InputPhoneServiceType               := le.version4.InputPhoneServiceType;
		self.v4_InputAreaCodeChange                 := le.version4.InputAreaCodeChange;
		self.v4_PhoneEDAAgeOldestRecord             := le.version4.PhoneEDAAgeOldestRecord;
		self.v4_PhoneEDAAgeNewestRecord             := le.version4.PhoneEDAAgeNewestRecord;
		self.v4_PhoneOtherAgeOldestRecord           := le.version4.PhoneOtherAgeOldestRecord;
		self.v4_PhoneOtherAgeNewestRecord           := le.version4.PhoneOtherAgeNewestRecord;
		self.v4_InputPhoneHighRisk                  := le.version4.InputPhoneHighRisk;
		self.v4_InputPhoneProblems                  := le.version4.InputPhoneProblems;
		self.v4_OnlineDirectory                     := le.version4.OnlineDirectory;
		self.v4_InputAddrSICCode                    := le.version4.InputAddrSICCode;
		self.v4_InputAddrValidation                 := le.version4.InputAddrValidation;
		self.v4_InputAddrErrorCode                  := le.version4.InputAddrErrorCode;
		self.v4_InputAddrHighRisk                   := le.version4.InputAddrHighRisk;
		self.v4_CurrAddrCorrectional                := le.version4.CurrAddrCorrectional;
		self.v4_PrevAddrCorrectional                := le.version4.PrevAddrCorrectional;
		self.v4_HistoricalAddrCorrectional          := le.version4.HistoricalAddrCorrectional;
		self.v4_InputAddrProblems                   := le.version4.InputAddrProblems;
		self.v4_DoNotMail                           := le.version4.DoNotMail;
		// 4.1 Attributes
		SELF.v4_IdentityRiskLevel	:= le.version4.IdentityRiskLevel;
		SELF.v4_IDVerRiskLevel	:= le.version4.IDVerRiskLevel;
		SELF.v4_IDVerAddressAssocCount	:= le.version4.IDVerAddressAssocCount;
		SELF.v4_IDVerSSNCreditBureauCount	:= le.version4.IDVerSSNCreditBureauCount;
		SELF.v4_IDVerSSNCreditBureauDelete	:= le.version4.IDVerSSNCreditBureauDelete;
		SELF.v4_SourceRiskLevel	:= le.version4.SourceRiskLevel;
		SELF.v4_SourceWatchList	:= le.version4.SourceWatchList;
		SELF.v4_SourceOrderActivity	:= le.version4.SourceOrderActivity;
		SELF.v4_SourceOrderSourceCount	:= le.version4.SourceOrderSourceCount;
		SELF.v4_SourceOrderAgeLastOrder	:= le.version4.SourceOrderAgeLastOrder;
		SELF.v4_VariationRiskLevel	:= le.version4.VariationRiskLevel;
		SELF.v4_VariationIdentityCount	:= le.version4.VariationIdentityCount;
		SELF.v4_VariationMSourcesSSNCount	:= le.version4.VariationMSourcesSSNCount;
		SELF.v4_VariationMSourcesSSNUnrelCount	:= le.version4.VariationMSourcesSSNUnrelCount;
		SELF.v4_VariationDOBCount	:= le.version4.VariationDOBCount;
		SELF.v4_VariationDOBCountNew	:= le.version4.VariationDOBCountNew;
		SELF.v4_SearchVelocityRiskLevel	:= le.version4.SearchVelocityRiskLevel;
		SELF.v4_SearchUnverifiedSSNCountYear	:= le.version4.SearchUnverifiedSSNCountYear;
		SELF.v4_SearchUnverifiedAddrCountYear	:= le.version4.SearchUnverifiedAddrCountYear;
		SELF.v4_SearchUnverifiedDOBCountYear	:= le.version4.SearchUnverifiedDOBCountYear;
		SELF.v4_SearchUnverifiedPhoneCountYear	:= le.version4.SearchUnverifiedPhoneCountYear;
		SELF.v4_AssocRiskLevel	:= le.version4.AssocRiskLevel;
		SELF.v4_AssocSuspicousIdentitiesCount	:= le.version4.AssocSuspicousIdentitiesCount;
		SELF.v4_AssocCreditBureauOnlyCount	:= le.version4.AssocCreditBureauOnlyCount;
		SELF.v4_AssocCreditBureauOnlyCountNew	:= le.version4.AssocCreditBureauOnlyCountNew;
		SELF.v4_AssocCreditBureauOnlyCountMonth	:= le.version4.AssocCreditBureauOnlyCountMonth;
		SELF.v4_AssocHighRiskTopologyCount	:= le.version4.AssocHighRiskTopologyCount;
		SELF.v4_ValidationRiskLevel	:= le.version4.ValidationRiskLevel;
		SELF.v4_CorrelationRiskLevel	:= le.version4.CorrelationRiskLevel;
		SELF.v4_DivRiskLevel	:= le.version4.DivRiskLevel;
		SELF.v4_DivSSNIdentityMSourceCount	:= le.version4.DivSSNIdentityMSourceCount;
		SELF.v4_DivSSNIdentityMSourceUrelCount	:= le.version4.DivSSNIdentityMSourceUrelCount;
		SELF.v4_DivSSNLNameCountNew	:= le.version4.DivSSNLNameCountNew;
		SELF.v4_DivSSNAddrMSourceCount	:= le.version4.DivSSNAddrMSourceCount;
		SELF.v4_DivAddrIdentityCount	:= le.version4.DivAddrIdentityCount;
		SELF.v4_DivAddrIdentityCountNew	:= le.version4.DivAddrIdentityCountNew;
		SELF.v4_DivAddrIdentityMSourceCount	:= le.version4.DivAddrIdentityMSourceCount;
		SELF.v4_DivAddrSuspIdentityCountNew	:= le.version4.DivAddrSuspIdentityCountNew;
		SELF.v4_DivAddrSSNCount	:= le.version4.DivAddrSSNCount;
		SELF.v4_DivAddrSSNCountNew	:= le.version4.DivAddrSSNCountNew;
		SELF.v4_DivAddrSSNMSourceCount	:= le.version4.DivAddrSSNMSourceCount;
		SELF.v4_DivSearchAddrSuspIdentityCount	:= le.version4.DivSearchAddrSuspIdentityCount;
		SELF.v4_SearchComponentRiskLevel	:= le.version4.SearchComponentRiskLevel;
		SELF.v4_SearchSSNSearchCount	:= le.version4.SearchSSNSearchCount;
		SELF.v4_SearchAddrSearchCount	:= le.version4.SearchAddrSearchCount;
		SELF.v4_SearchPhoneSearchCount	:= le.version4.SearchPhoneSearchCount;
		SELF.v4_ComponentCharRiskLevel	:= le.version4.ComponentCharRiskLevel;
	END;

	flattened := project( with_model, flatten(LEFT) );

	output(flattened, named('Results'));


ENDMACRO;

// models.LeadIntegrity_Batch_Service();