//cut and pasted from Models.RiskView_Service
// not all logic was copied as only wanted the RV 4 attributes - no scores or other versions of attributes/boca shell
/*--SOAP--
<message name="FcraInsurView_Service">
		<part name="FCRAInsurViewAttributesRequest" type="tns:XmlDataSet" cols="80"
  	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
		<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
</message>
*/

IMPORT Models, Risk_Indicators, Gateway, iesp, Risk_Reporting, Inquiry_AccLogs, STD;

export FcraInsurView_Service := MACRO
	#WEBSERVICE(FIELDS(
		'FCRAInsurViewAttributesRequest',
		'HistoryDateYYYYMM',
		'gateways',
		'DataRestrictionMask',
		'DataPermissionMask'	
	));

	rec_in     := iesp.fcrainsurviewattributes.t_FCRAInsurViewAttributesRequest;
	ds_in      := DATASET([],rec_in) : STORED('FCRAInsurViewAttributesRequest',few);	

  firstrow := ds_in[1] : INDEPENDENT;

	search := GLOBAL(firstRow.SearchBy);
	option := GLOBAL(firstRow.Options);
	users := GLOBAL(firstRow.User);
	string20 HistoryDateYYYYMM := '999999' : STORED('HistoryDateYYYYMM');
	
/* **********************************************
	 *  Fields needed for improved Scout Logging  *
	 **********************************************/
	string32 _LoginID               := ''	: STORED('_LoginID');
	outofbandCompanyID							:= '' : STORED('_CompanyID');
	string20 CompanyID              := if(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
	string20 FunctionName           := '' : STORED('_LogFunctionName');
	string50 ESPMethod              := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
	string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
	outofbandssnmask                := '' : STORED('SSNMask');
	string10 SSN_Mask               := if(users.SSNMask != '', users.SSNMask, outofbandssnmask);
	outofbanddobmask                := '' : STORED('DOBMask');
	string10 DOB_Mask               := if(users.DOBMask != '', users.DOBMask, outofbanddobmask);
	BOOLEAN DL_Mask                 := users.DLMask;
	BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
	BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');
	BOOLEAN DisableOutcomeTracking := Users.OutcomeTrackingOptOut;
	#stored('DisableBocaShellLogging', DisableOutcomeTracking); 

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(TRUE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.ISS_FcraInsurView__Service);
/* ************* End Scout Fields **************/
	
/* ***************************************
	 *           Search By:            *
   *************************************** */
	string62 fullname_value := search.Name.Full;
	string20 first_value := search.Name.First;
	string20 mname_value := search.Name.Middle;
	string20 last_value := search.Name.Last;
	string5 suffix_value := search.Name.Suffix;
	string3 prefix_value := search.Name.Prefix;
 	#stored('FirstName', first_value);
	#stored('MiddleName', mname_value);
	#stored('LastName', last_value);
	#stored('NameSuffix', suffix_value);
	Risk_indicators.MAC_unparsedfullname(title_val,fname_val,mname_val,lname_val,suffix_val,'FirstName','MiddleName','LastName','NameSuffix')

				
	STRING28 streetName := search.Address.StreetName;
	STRING10 streetNumber := search.Address.StreetNumber;
	STRING2 streetPreDirection := search.Address.StreetPreDirection;
	STRING2 streetPostDirection := search.Address.StreetPostDirection;
	STRING4 streetSuffix := search.Address.StreetSuffix;
	STRING8 UnitNumber := search.Address.UnitNumber;
	STRING10 UnitDesig := search.Address.UnitDesignation;
	STRING60 tempStreetAddr := Address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
	STRING60 in_streetAddress1 := IF(search.Address.StreetAddress1='', tempStreetAddr, search.Address.StreetAddress1);
	STRING60 in_streetAddress2 := search.Address.StreetAddress2;
	
	STRING120 addr_value := TRIM(in_streetAddress1) + ' ' + TRIM(in_streetAddress2);
	STRING25 city_value := search.Address.City;
	STRING2 state_value := search.Address.State;
	STRING5 zip_value := search.Address.Zip5;
	STRING18 County := search.Address.County;
	// Other PII
	tmpDOB := iesp.ECL2ESP.DateToString(search.DOB);
	STRING8 dob_value :=  IF(tmpDOB = '00000000', '', tmpDOB);
	string3 Age := (string) if(search.Age = 0, '', (string) search.Age);
	STRING9 socs_value := search.SSN;
	STRING10 HomePhone := search.HomePhone;
	STRING10 WorkPhone := search.WorkPhone;
	STRING50 Email := search.Email;
	string45 IPAddress := search.IPAddress;
	STRING15 DLNumber := search.DriverLicenseNumber;
	STRING2 DLState := search.DriverLicenseState;
	string12 LexID := (string) search.UniqueId;
	
/* ***************************************
	 *           Set User Values:            *
   *************************************** */
  STRING20 AccountNumber := users.AccountNumber;
	BOOLEAN Test_Data_Enabled := (boolean) users.TestDataEnabled;
	STRING32 Test_Data_Table_Name := StringLib.StringToUpperCase(TRIM(users.TestDataTableName, LEFT, RIGHT));
 
	STRING outOfBandDataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
  STRING DataRestriction := IF(TRIM(users.DataRestrictionMask) <> '', users.DataRestrictionMask, outOfBandDataRestriction);

	STRING outOfBandDataPermission := Risk_Indicators.iid_constants.default_DataPermission : STORED('DataPermissionMask');
  STRING DataPermission := MAP(TRIM(users.DataPermissionMask) <> '' => users.DataPermissionMask,
                                  TRIM(outOfBandDataPermission) <> ''  => outOfBandDataPermission,
                                                                           Risk_Indicators.iid_constants.default_DataPermission);
	string5 IndustryClass := users.IndustryClass; //not populated
	unsigned1 DPPAPurpose := 0; //not needed for FCRA
	unsigned1 GLBPurpose := 0; //not needed for FCRA
	
	string50 QueryId := users.QueryId; 
	 
 /* ***************************************
	 *           Set Options Values:            *
   *************************************** */
	 //hard code to always use Person context
	boolean UsePersonContext := true;// option.FFDOptionsMask[1] = '1';// this is coming from options tag now instead of out-of-band boolean option we had originally																 

	string intended_purpose := trim(option.IntendedPurpose);
	boolean inPersonApplicant := option.InPersonApplication;
	boolean FilterLiens := if(DataRestriction[risk_indicators.iid_constants.posLiensJudgRestriction]='1', true, false ); //DRM says don't run lnj or include is false so don't run lnj
	
	ISS.FCRAInsurView_Layouts.Layout_Attributes_In GetAttributeName(iesp.share.t_StringArrayItem le, integer c) := transform
		self.name := le.value;
	end;
	attributesInput := option.RequestedAttributeGroups;
	attributesIn := project(attributesInput,  GetAttributeName(left, counter))(name != '');

	gateways_in := Gateway.Configuration.Get();
	Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
		SELF.servicename := le.servicename;
		SELF.url := IF(le.servicename IN ['targus'], '', le.url); // Don't allow Targus Gateway
		SELF := le;
	END;
	gateways := PROJECT(gateways_in, gw_switch(LEFT));
	emptyRecord := ut.ds_oneRecord;

	doVersion4    := EXISTS(attributesIn(stringlib.stringtolowercase(name)='version4'));	// output version4 if requested

	IF(doVersion4 = false, FAIL('No attributes requested'));

/*****************Set other settings***************************************************/
	DoAddressAppend := FALSE;
	isCalifornia  := FALSE;//InPersonApplication or exists(settings(isCalifornia));
	bsVersion := 4; // return bsversion defaults to 1 / but can be passed in.
	// set variables for passing to bocashell function fcra
	boolean   isUtility := StringLib.StringToUpperCase(IndustryClass) = 'UTILI';
	boolean   require2ele := false;
	boolean   isLn := false; // not needed anymore
	boolean   doRelatives := false;
	boolean   doDL := false;
	boolean   doVehicle := false;
	boolean   doDerogs := true;
	boolean   ofacOnly := true;
	boolean   suppressNearDups := false;
	boolean   fromBIID := false;
	boolean   excludeWatchlists := true; // turned off the ofac searching as I don't think it is needed
	boolean   fromIT1O := false;
	unsigned1 ofacVersion := 1;
	boolean   includeOfac := false;
	boolean   includeAddWatchlists := false;
	real      watchlistThreshold := 0.84;
	boolean   doScore := false;
	boolean   isPreScreen := StringLib.StringToUpperCase(intended_purpose) = 'PRESCREENING';
	boolean 	isDirectToConsumerPurpose := StringLib.StringToUpperCase(intended_purpose) = Riskview.Constants.directToConsumer;	
	unsigned8 BSOptions := if( IsPreScreen, risk_indicators.iid_constants.BSOptions.IncludePreScreen, 0 ) + 
												 IF(DoAddressAppend, Risk_Indicators.iid_constants.BSOptions.IncludeAddressAppend, 0) +
												 if(FilterLiens, risk_indicators.iid_constants.BSOptions.FilterLiens, 0 ) +//DRM to drive Liens/Judgments											  
													Risk_Indicators.iid_constants.BSOptions.InsuranceFCRAMode +
													Risk_Indicators.iid_constants.BSOptions.InsuranceFCRABankruptcyException;
													
	ExperianTransaction := DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction]='0';	
/*****************Put in input layout*************************************************************/
	Risk_Indicators.Layout_Input intoInput(emptyRecord l, integer c) := TRANSFORM
		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, city_value, state_value, zip_value);

		self.DID := (integer) LexID; 	
		self.score := if(self.did<>0, 100, 0);
		//		self.seq := c;
		self.seq :=  (integer) AccountNumber; // Used for Validation of models
		history_date := trim(HistoryDateYYYYMM);
		self.historyDate := (integer) history_date; //should be 999999
		self.HistoryDateTimeStamp := '';
		self.ssn := IF(socs_value = '000000000', '', socs_value);	// blank out social if it is all 0's
		self.dob := IF(dob_value = '00000000','',dob_value);
		//make age archiveable
		self.age := if (Age in [''] and dob_value not in ['','0'], 
														(STRING3)ut.GetAgeI_asOf((unsigned)dob_value, (unsigned)risk_indicators.iid_constants.myGetDate((integer) history_date)), 
														(STRING3)Age);	
		self.phone10 := HomePhone;
		self.wphone10 := WorkPhone;
		//parsed name info
		cleaned_name := address.CleanPerson73(fullname_value);
		boolean valid_cleaned := fullname_value <> '';
		
		self.fname := stringlib.stringtouppercase(if(fname_val='' AND valid_cleaned, 
			address.cleanNameFields(cleaned_name).fname, fname_val));
		self.mname := stringlib.stringtouppercase(if(mname_val='' AND valid_cleaned, 
			address.cleanNameFields(cleaned_name).mname, mname_val));
		self.lname := stringlib.stringtouppercase(if(lname_val='' AND valid_cleaned, 
			address.cleanNameFields(cleaned_name).lname, lname_val));
		self.suffix := stringlib.stringtouppercase(if(suffix_val ='' AND valid_cleaned, 
			address.cleanNameFields(cleaned_name).name_suffix, suffix_val));	
		self.title := stringlib.stringtouppercase(title_val);
		//input address info
		self.in_streetAddress := addr_value;
		self.in_city := city_value;
		self.in_state := state_value;
		self.in_zipCode := zip_value;
		self.in_country := ''; //researched this and its not used in guts of boca shell
		//cleaned address info
		self.prim_range := clean_a2[1..10];
		self.predir := clean_a2[11..12];
		self.prim_name := clean_a2[13..40];
		self.addr_suffix := clean_a2[41..44];
		self.postdir := clean_a2[45..46];
		self.unit_desig := clean_a2[47..56];
		self.sec_range := clean_a2[57..64];
		self.p_city_name := clean_a2[90..114];
		self.st := clean_a2[115..116];
		self.z5 := MAP(TRIM(clean_a2[117..121]) <> '' => clean_a2[117..121], // If the cleaned zip is available, keep it
									 DoAddressAppend = TRUE => zip_value[1..5], // If we are running an Address Append and only ZIP is passed in it fails the address cleaner and has clean_a2 set to blank, set it to the input ZIP code. If Street Number + Zip are input it will clean the ZIP just fine.
									 '');
		self.zip4 := clean_a2[122..125];
		self.lat := clean_a2[146..155];
		self.long := clean_a2[156..166];
		self.addr_type := clean_a2[139];
		self.addr_status := clean_a2[179..182];
		self.county := clean_a2[143..145];
		self.geo_blk := clean_a2[171..177];
		self.country := '';		
		dl_num := stringlib.stringFilterOut(DLNumber,'-');
		dl_num2 := stringlib.stringFilterOut(dl_num,' ');
		self.dl_number := stringlib.stringtouppercase(dl_num2);
		self.dl_state := stringlib.stringtouppercase(DLState);
		self.email_address := Email;
		self.ip_address := IPAddress;			
		self := [];
	END;
 bsprep := PROJECT(emptyRecord, intoInput(LEFT, COUNTER	));
	/**********************Get boca shell data********************************************************/
	clam := Risk_Indicators.Boca_Shell_Function_FCRA(
		bsprep, gateways, DPPAPurpose, GLBPurpose, isUtility, isLN,
		require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
		suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
		ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
			bsVersion, isPreScreen, doScore, ADL_Based_Shell:=false, datarestriction:=datarestriction, BSOptions:=BSOptions,
			datapermission:=datapermission,IN_isDirectToConsumer:=isDirectToConsumerPurpose, IntendedPurpose := intended_purpose
	);
	adl_clam := Risk_Indicators.Boca_Shell_Function_FCRA(
		bsprep, gateways, DPPAPurpose, GLBPurpose, isUtility, isLN,
		require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
		suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
		ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
		bsVersion, isPreScreen, doScore, ADL_Based_Shell:=true, datarestriction:=datarestriction, BSOptions:=BSOptions,
		datapermission:=datapermission,IN_isDirectToConsumer:=isDirectToConsumerPurpose, IntendedPurpose := intended_purpose
	);

	clam_to_check := if(DoAddressAppend, adl_clam[1], clam[1]);
	clam_to_run := if(DoAddressAppend, adl_clam, clam);
	PreScreenOptOut := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, clam_to_check.iid.iid_flags );

	/**********************Log Boca Shell********************************************************/
	productID := Risk_Reporting.ProductID.ISS_FcraInsurView__Service;	
	intermediate_Log := IF(DisableOutcomeTracking, DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell), Risk_Reporting.To_LOG_Boca_Shell(IF(DoAddressAppend, adl_clam, clam), productID, bsVersion));
	#stored('Intermediate_Log', intermediate_log);

	clam_final := project(clam_to_run, transform(risk_indicators.Layout_Boca_Shell, 
		self.ConsumerFlags.security_freeze := false;
		self := left));
	
	/**********************Get attributes********************************************************/
	// get attributes
	attr := Models.getRVAttributes(clam_final, AccountNumber, isPreScreen,  if(isPrescreen, PreScreenOptOut, false), datarestriction, BSOptions);
	attributes := ungroup(attr);
	/**********************Output attributes********************************************************/	
	
	attributesWithFlags := project(attributes, 
		transform(ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags,
			self.ClearFields := if(left.v4_PrescreenOptOut = '1' OR
											//left.v4_ConsumerStatement = '1' OR // per team, we can provide back data if consumer statement
											left.v4_SecurityFreeze='1' OR
											(ExperianTransaction AND left.v4_VerificationFailure = '1'),
											true,
											false);
			self.ExperianTransaction := ExperianTransaction;
			self := left));
	idManip := project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.idManip(left));
	ssnChar := project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.ssnChar(left));
	inputAddr	:= project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.inputAddr(left)); 
	CurrAddr := project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.CurrAddr(left)); 	 
	PrevAddr:= project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.PrevAddr(left));
	RecAddr := project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.RecAddr(left)); 
	Educ := project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.Educ(left)); 
	AddrStabl := project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.AddrStabl(left));
	IncomeAsst :=  project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.IncomeAsst(left));
	busAssoc := project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.busAssoc(left));
	derogs :=  project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.derogs(left));
	profLic :=  project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.profLic(left));
	InqEvent :=  project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.InqEvent(left));
	PhnAddrRisk := project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.PhnAddrRisk(left));
	ConsmrRpt := project(attributesWithFlags, ISS.FCRAInsurView_AttributesV4.ConsmrRpt(left));
	
	ISS.FCRAInsurView_Layouts.FCRAInsurViewAttributesResponseWAcct addEcho(attributesWithFlags le, clam_final rt) := TRANSFORM
	
		InPersonApplication := inPersonApplicant and (
		(integer)(boolean)rt.iid.combo_firstcount+(integer)(boolean)rt.iid.combo_lastcount
		+(integer)(boolean)rt.iid.combo_addrcount+(integer)(boolean)rt.iid.combo_hphonecount
		+(integer)(boolean)rt.iid.combo_ssncount+(integer)(boolean)rt.iid.combo_dobcount) < 3;
		
		self.AccountNumber := AccountNumber;
		self.UniqueId := rt.did;
		self.Result.InputEcho := Search;
		self._Header.QueryId := QueryId;
		self._Header := [];
		self.Result.InsurViewAttributes.Version4.IdentityManipulation := if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_IdentityManipulationAttributes)[1], idManip[1]);
		self.Result.InsurViewAttributes.Version4.SSNCharacteristics := if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_SSNCharacteristicsAttributes)[1], ssnChar[1]);
		self.Result.InsurViewAttributes.Version4.InputAddress := if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_InputAddressAttributes)[1], inputAddr[1]);
		self.Result.InsurViewAttributes.Version4.CurrentAddress := if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_CurrentAddressAttributes)[1], CurrAddr[1]);
		self.Result.InsurViewAttributes.Version4.PreviousAddress := if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_PreviousAddressAttributes)[1], PrevAddr[1]);
		self.Result.InsurViewAttributes.Version4.MostRecentAddress :=if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_MostRecentAddressAttributes)[1], RecAddr[1]);
		self.Result.InsurViewAttributes.Version4.Education := if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_EducationAttributes)[1], Educ[1]);
		self.Result.InsurViewAttributes.Version4.AddressStability := if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_AddressStabilityAttributes)[1], AddrStabl[1]);
		self.Result.InsurViewAttributes.Version4.IncomeAsset:= if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_IncomeAssetAttributes)[1], IncomeAsst[1]);
		self.Result.InsurViewAttributes.Version4.BusinessAssociation := if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_BusinessAssociationAttributes)[1], busAssoc[1]);
		self.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord:= if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_DerogatoryPublicRecordAttributes)[1], derogs[1]);
		self.Result.InsurViewAttributes.Version4.ProfessionalLicense :=if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_ProfessionalLicenseAttributes)[1], profLic[1]);
		self.Result.InsurViewAttributes.Version4.InquiryEvents := if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_InquiryEventsAttributes)[1], InqEvent[1]);
		self.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk := if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_PhoneAndAddressRiskAttributes)[1], PhnAddrRisk[1]);
		self.Result.InsurViewAttributes.Version4.ConsumerReportedFlags :=if(InPersonApplication, dataset([],iesp.fcrainsurviewattributes.t_ConsumerReportedFlags)[1], ConsmrRpt[1]);
		
		self.Result.ConsumerStatements := project(rt.ConsumerStatements,
			transform(iesp.share_fcra.t_ConsumerStatement, self.dataGroup := '', self := left));
          
    // for inquiry logging, populate the consumer section with the DID and input fields
    // if the person is a noScore, don't log the DID
    self.Result.Consumer.LexID := if(riskview.constants.noscore(rt.iid.nas_summary,rt.iid.nap_summary, rt.address_verification.input_address_information.naprop, rt.truedid), 
        '', 
        (string12)rt.did);      
    searchDOB := iesp.ECL2ESP.t_DateToString8(search.DOB);
    SELF.Result.Consumer.Inquiry.DOB := IF((UNSIGNED)searchDOB > 0, searchDOB, '');
    self.Result.Consumer.Inquiry.Phone10 := search.HomePhone;
    self.Result.Consumer.Inquiry := search;   
	END;
			
	//final_wEcho := PROJECT(attributesWithFlags, addEcho(LEFT));	
	final_wEcho := join(attributesWithFlags, clam_final, left.seq=right.seq, addEcho(LEFT, right));			
	
	// for debugging
	// output(attributesWithFlags, named('attributesWithFlags'));
	// output(with_personContext, named('with_personcontext'));
	// output(PreScreenOptOut, named('PreScreenOptOut'));
	// output(clam_to_run, named('clam_to_run'));
	// output(clam_final, named('clam_final'));
	output(final_wEcho, named('Results'));
	
	intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell) : STORED('Intermediate_Log');

	// Note: All intermediate logs must have the following name schema:
	// Starts with 'LOG_' (Upper case is important!!)
	// Middle part is the database name, in this case: 'log__mbs__fcra'
	// Must end with '_intermediate__log'

	IF(~DisableOutcomeTracking and ~Test_Data_Enabled,	OUTPUT(intermediateLog, NAMED('LOG_log__mbs__fcra_intermediate__log')) );
	
	//Log to Deltabase
	Deltabase_Logging_prep := project(final_wEcho, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.ISS_FcraInsurView__Service,
																								 self.function_name := FunctionName,
																								 self.esp_method := ESPMethod,
																								 self.interface_version := InterfaceVersion,
																								 self.delivery_method := DeliveryMethod,
																								 self.date_added := (STRING8)Std.Date.Today(),
																								 self.death_master_purpose := DeathMasterPurpose,
																								 self.ssn_mask := SSN_Mask,
																								 self.dob_mask := DOB_Mask,
																								 self.dl_mask := (String)(Integer)DL_Mask,
																								 self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
																								 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																								 self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                 self.glb := GLBPurpose,
                                                 self.dppa := DPPAPurpose,
																								 self.data_restriction_mask := DataRestriction,
																								 self.data_permission_mask := DataPermission,
																								 self.industry := Industry_Search[1].Industry,
																								 self.i_attributes_name := attributesIn[1].name,
																								 self.i_ssn := search.SSN,
                                                 self.i_dob := dob_value,
                                                 self.i_name_full := fullname_value,
																								 self.i_name_first := first_value,
																								 self.i_name_last := last_value,
																								 self.i_lexid := (Integer)search.UniqueId, 
																								 self.i_address := IF(search.Address.StreetAddress2 <> '',
																																			search.Address.StreetAddress1 + ' ' + search.Address.StreetAddress2,
																																			search.Address.StreetAddress1),
																								 self.i_city := search.Address.City,
																								 self.i_state := search.Address.State,
																								 self.i_zip := search.Address.Zip5,
																								 self.i_dl := search.DriverLicenseNumber,
																								 self.i_dl_state := search.DriverLicenseState,
                                                 self.i_home_phone := HomePhone,
                                                 self.i_work_phone := WorkPhone,
																								 self.o_lexid    := (Integer)left.UniqueId,
																								 self := left,
																								 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	// #stored('Deltabase_Log', Deltabase_Logging);

	//Improved Scout Logging
	IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs__fcra_transaction__log__scout')));

ENDMACRO;
