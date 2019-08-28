/*--SOAP--
<message name="ITA_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ModelName" type="xsd:string"/>
	<part name="Version" type="xsd:integer"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
/*--INFO-- ITA Batch Service*/
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

import address, risk_indicators, models, riskwise, ut, dma, doxie, gateway, STD;


export ITA_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

batchin := dataset([],Models.layouts.Layout_LeadIntegrity_Batch_In) 			: stored('batch_in',few);
gateways := Gateway.Constants.void_gateway;

unsigned1 dppa := 0 		: stored('DPPAPurpose');
unsigned1 glb := RiskWise.permittedUse.GLBA : stored('GLBPurpose');
unsigned1 version := 1      : stored('Version');
string ModelName_in := '' : stored('ModelName');
model_name := STD.Str.ToLowerCase( modelname_in );
string5   industry_class_val := '';
boolean   isUtility := false;
boolean   ofac_Only := false;
boolean   ofacSearching := false;
boolean   excludewatchlists := true;
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

bsVersion := 3;

// add sequence to matchup later to add acctno to output
Models.layouts.Layout_LeadIntegrity_Batch_In into_seq(batchin le, integer C) := TRANSFORM
	self.seq := C;
	self := le;
END;
batchinseq := project(batchin, into_seq(left,counter));

unsigned3 history_date := 999999 		: stored('HistoryDateYYYYMM');

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');

Risk_Indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
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
	
	self.historydate := if(le.historydateyyyymm=0, history_date, le.historydateyyyymm) ;
	self := [];
END;
cleanIn := project(batchinseq, into_in(left));

// set variables for passing to bocashell function
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
// for ITA, we can't use FARES Data, so filter that out of the property searching
boolean 	filter_out_fares := true;  

iid := risk_indicators.InstantID_Function(cleanIn, gateways, dppa, glb, isUtility, isLn, ofac_only, 
								suppressNearDups, require2Ele, fromBIID, isFCRA, excludewatchlists, fromIT1O, 
								in_BSversion := bsVersion,in_DataRestriction:=DataRestriction, in_DataPermission:=DataPermission,
                                LexIdSourceOptout := LexIdSourceOptout, 
                                TransactionID := TransactionID, 
                                BatchUID := BatchUID, 
                                GlobalCompanyID := GlobalCompanyID);

clam := risk_indicators.Boca_Shell_Function(iid, gateways, dppa, glb, isUtility, isLn, doRelatives, doDL, 
								doVehicle, doDerogs, bsVersion, doScore, nugen, filter_out_fares,DataRestriction:=DataRestriction, DataPermission:=DataPermission,
                                LexIdSourceOptout := LexIdSourceOptout, 
                                TransactionID := TransactionID, 
                                BatchUID := BatchUID, 
                                GlobalCompanyID := GlobalCompanyID);

LeadIntegrity := Models.get_LeadIntegrity_Attributes(clam,version);
   
//add the do not mail search -- if we get a hit, return just the flag and blank everything else out
suppressed_do_not_mail := join(cleanIn, dma.key_DNM_Name_Address, 
					  keyed(left.prim_name = right.l_prim_name) and
			   keyed(left.prim_range = right.l_prim_range) and 
			   keyed(left.st = right.l_st) and
			   keyed(right.l_city_code in doxie.Make_CityCodes(left.p_city_name).rox) and 
			   keyed(left.z5= right.l_zip) and 
			   keyed(left.sec_range = right.l_sec_range) and 
			   keyed(left.lname = right.l_lname) and
			   keyed(left.fname = right.l_fname),
				 Transform(models.layouts.layout_LeadIntegrity_attributes_batch, self.DoNotMail := if(right.l_zip='', '0', '1'),
									self.seq := (string)left.seq, self := []) 
				 , left outer, keep(1));
// output(suppressed_do_not_mail, named('suppressed_do_not_mail'));

with_dnm := join(LeadIntegrity, suppressed_do_not_mail, left.seq=right.seq,
					transform(models.layouts.layout_LeadIntegrity_attributes_batch, 
										self := if(right.DoNotMail='1', right, left) ) );
// output(with_dnm, named('with_dnm'));

with_ACCTNO := join(batchinseq, with_dnm, left.seq=(unsigned)right.seq, transform(models.layouts.layout_LeadIntegrity_attributes_batch,
				self.acctno := left.acctno;
				self := right));
	

model := case( trim(model_name),
	'anmk909_0' => ungroup(Models.ANMK909_0_1( clam )),
	''          => dataset( [], Models.Layout_ModelOut ),
	fail( Models.Layout_ModelOut, 'Invalid model name requested' )
);

models.layouts.layout_LeadIntegrity_attributes_batch addScore( with_ACCTNO le, model ri ) := TRANSFORM
	self.score1 := ri.score;
	// self.scorename1 := ?
	self.reason1 := ri.ri[1].hri;
	self.reason2 := ri.ri[2].hri;
	self.reason3 := ri.ri[3].hri;
	self.reason4 := ri.ri[4].hri;
	self.reason5 := ri.ri[5].hri;
	self.reason6 := ri.ri[6].hri;
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
		self := [];
	END;

	flattened := project( with_model, flatten(LEFT) );

	output(flattened, named('Results'));


ENDMACRO;

// models.ITA_Batch_Service();