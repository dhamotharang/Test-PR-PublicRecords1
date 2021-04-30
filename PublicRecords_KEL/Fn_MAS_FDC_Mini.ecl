IMPORT AID_Build, ADVO, AlloyMedia_student_list,  American_student_list, AutoKey, AVM_V2, BankruptcyV3, BBB2, BIPV2, BIPV2_Best, BIPV2_Build, Business_Risk_BIP, BusReg, CalBus, CellPhone, Certegy, Corp2, 
		Cortera, Cortera_Tradeline, Data_Services, DCAV2, Death_Master,  Doxie, Doxie_Files, DriversV2, DMA, dx_BestRecords, dx_ConsumerFinancialProtectionBureau, dx_DataBridge, DX_Email, 
		dx_Cortera_Tradeline, dx_Equifax_Business_Data, dx_Gong, dx_Header, dx_Infutor_NARB, dx_PhonesInfo, dx_PhonesPlus, dx_Relatives_v3, EBR, Email_Data, emerges, Experian_CRDB, FAA, FBNv2, FLAccidents_Ecrash, Fraudpoint3, Gong, 
		GovData, Header, Header_Quick, InfoUSA, IRS5500, InfutorCID, Inquiry_AccLogs, LiensV2, LN_PropertyV2, MDR, OSHAIR, Phonesplus_v2, Prof_License_Mari, 
		Prof_LicenseV2, Relationship, Risk_Indicators, RiskView, RiskWise, SAM, SexOffender, STD, Suppress, Targus, thrive, USPIS_HotList, Utilfile, ut,
		VehicleV2, Watercraft, Watchdog, UCCV2, YellowPages, dx_OSHAIR, drivers;

//anything below in the miniFDC will be passed into the mini attributes then back into the FDC, we are not calling any keys twice. 
//we keep all of this data and pass it back into the FDC and normalize it out to use it again for searching when needed



EXPORT Fn_MAS_FDC_Mini(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) Input_all,
									PublicRecords_KEL.Interface_Options Options,
									PublicRecords_KEL.Join_Interface_Options JoinFlags,
									DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput = DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII)
									) := FUNCTION
	
	
	linkingOptions := MODULE(BIPV2.mod_sources.iParams)
		EXPORT STRING DataRestrictionMask		:= Options.Data_Restriction_Mask; // Note: Must unfortunately leave as undefined STRING length to match the module definition
		EXPORT BOOLEAN ignoreFares					:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore FARES data - since the Business Shell doesn't accept this input default it to FALSE to always utilize whatever the DataRestrictionMask allows
		EXPORT BOOLEAN ignoreFidelity				:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore Fidelity data - since the Business Shell doesn't accept this input default it to FALSE to always utilize whatever the DataRestrictionMask allows
		EXPORT BOOLEAN AllowAll							:= IF(Options.Allowed_Sources = Business_Risk_BIP.Constants.AllowDNBDMI, TRUE, FALSE); // When TRUE this will unmask DNB DMI data - NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY
		EXPORT BOOLEAN AllowGLB							:= Risk_Indicators.iid_constants.GLB_OK(Options.GLBAPurpose, FALSE /*isFCRA*/);
		EXPORT BOOLEAN AllowDPPA						:= Risk_Indicators.iid_constants.DPPA_OK(Options.DPPAPurpose, FALSE /*isFCRA*/);
		EXPORT UNSIGNED1 DPPAPurpose				:= Options.DPPAPurpose;
		EXPORT UNSIGNED1 GLBPurpose					:= Options.GLBAPurpose;
		EXPORT BOOLEAN IncludeMinors				:= TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
		EXPORT BOOLEAN LNBranded						:= TRUE; // Not entirely certain what effect this has
	END;
	// kFetchLinkSearchLevel := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel);

  mod_access := MODULE(Doxie.IDataAccess)
    EXPORT glb := options.GLBAPurpose;
    EXPORT dppa := options.DPPAPurpose;
    EXPORT DataPermissionMask := options.Data_Permission_Mask;
    EXPORT DataRestrictionMask := options.Data_Restriction_Mask;
    EXPORT UNSIGNED1 lexid_source_optout := Options.LexIdSourceOptout;
    EXPORT STRING transaction_id := Options.TransactionID; // esp transaction id or batch uid
    EXPORT UNSIGNED6 global_company_id := Options.GlobalCompanyId; // mbs gcid
  END;


  unsigned1 iType := IF(Options.IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);

	

	experian_permitted := Options.Data_Restriction_Mask[risk_indicators.iid_constants.posExperianRestriction]<>risk_indicators.iid_constants.sTrue;
	eq_permitted := Options.Data_Restriction_Mask[risk_indicators.iid_constants.posEquifaxRestriction]<>risk_indicators.iid_constants.sTrue;
	BOOLEAN Util :=  IF(Options.IndustryClass = 'UTILI' OR Options.IndustryClass = 'DRMKT', TRUE, FALSE);

	wdog_perm := dx_BestRecords.Functions.get_perm_type(glb_flag := 	Risk_Indicators.iid_constants.glb_ok(Options.GLBAPurpose, Options.isFCRA), 
																											utility_flag := Util, 
																											filter_exp_flag := ~experian_permitted, 
																											filter_eq_flag := ~eq_permitted, 
																											pre_glb_flag := (Options.Data_Restriction_Mask[23] = '1'),
																											marketing_flag := Options.isMarketing);	
	
	Layouts_FDC  := PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options);
	Common       := PublicRecords_KEL.ECL_Functions.Common(Options, JoinFlags);
	CFG_File     := PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile;
	Regulated    := PublicRecords_KEL.ECL_Functions.Constants.Regulated;
	NotRegulated := PublicRecords_KEL.ECL_Functions.Constants.NotRegulated;
	BlankString  := PublicRecords_KEL.ECL_Functions.Constants.BlankString;
	SetDPMBitmap := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue;
	Environment := IF(Options.IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA); // for CCPA Suppression calls

 // If there weren't any records in the mini-fdc input, then this must be the mini fdc run.

	// Records from GLB sources might NOT be GLBA Regulated depending on if they are older than GLBA Laws
	PreGLBRegulatedRecord := PublicRecords_KEL.ECL_Functions.Constants.PreGLBRegulatedRecord;
	
	// Death Master records are GLB regulated if glb_flag = 'Y'
	GLBARegulatedDeathMasterRecord(STRING glb_flag) := glb_flag = 'Y';

	// Additionally records from certain states are not allowed to be used unless we have a DPPA in a specific set of values
	GetDPPAState := PublicRecords_KEL.ECL_Functions.Constants.GetDPPAState;

	// Phones Plus Scoring Keys are GLB regulated dppa_glb_flag is 'G' or 'B'
	GLBARegulatedPhonesPlusRecord(STRING dppa_glb_flag) := IF(TRIM(dppa_glb_flag,LEFT,RIGHT) IN ['G','B'], TRUE, FALSE);
	
	DPPARegulatedWaterCraftRecord(STRING dppa_flag) := IF(TRIM(dppa_flag, LEFT, RIGHT) = 'Y', TRUE, FALSE);	

	// Property Source 
	LN_PropertyV2_Src(STRING ln_fares_id) := MDR.sourceTools.fProperty(ln_fares_id);

	// Data cleaning functions needed to get raw data ready for KEL
	Doxie_Files__Key_Offenders_Src(STRING data_type) := CASE(data_type,
				'1' => MDR.sourceTools.src_Accurint_DOC, //DC
				'2' => MDR.sourceTools.src_Accurint_Crim_Court,//CC
				'5' => MDR.sourceTools.src_Accurint_Arrest_Log, //AL
					'');
		
	CleanSIC(STRING SICCode) := STD.Str.Filter(SICCode, '0123456789')[1..4];
	CleanNAIC(STRING NAICCode) := STD.Str.Filter(NAICCode, '0123456789')[1..6];		
	

	glb_ok := Risk_Indicators.iid_constants.glb_ok(Options.GLBAPurpose, Options.isFCRA);
	dppa_ok := Risk_Indicators.iid_constants.dppa_ok(Options.DPPAPurpose, Options.isFCRA);	

ArchiveDate(string datevalue_in1, string datevalue_in2 = '' ):= function
	
	DateValue := TRIM(datevalue_in1);
	DateValue2 := TRIM(datevalue_in2);
	
	datechooser(string datevalue) := function
	
	cleanDate := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date((STRING) TRIM(DateValue))[1];
	cleanDate2 := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateValue[1..6]+'01')[1];
	validDatechooser := MAP( (STRING)DateValue NOT IN ['', '0'] AND cleanDate.yearfilled and cleanDate.Monthfilled and cleanDate.dayfilled and cleanDate.DateValid => (STRING) DateValue,//if we have a full valid date keep it
													(STRING)DateValue NOT IN ['', '0'] and length(TRIM(DateValue)) = 7 and cleanDate2.DateValid  => cleanDate2.ValidPortion_01,//if we have a YYYYMMD number keep [1..6] + 01 cleaned if its valid
														(STRING)DateValue IN ['', '0'] OR (INTEGER)cleanDate.ValidPortion_01 = 0 OR REGEXFIND('[^0-9.]',  DateValue, NOCASE)=> '',//if the date is cleaned to 00000000 or is not numeric set to ''
														cleanDate.ValidPortion_01);	//else keep it, this should only be good dates			


		
	return validDatechooser;
	end;
	
	date1 := datechooser(datevalue);
	
return If(date1 = '', datechooser(datevalue2), date1);	
	
end;	
	
	DOBPaddingLayout := RECORD
		UNSIGNED4 DOB;
		STRING8 DOBPadded;
	END;
	CleanDateOfBirth(UNSIGNED4 dob_in) := FUNCTION
		Result := MAP(
			STD.Date.IsValidDate(dob_in)										=> ROW({dob_in, ''}, DOBPaddingLayout),
			STD.Date.IsValidDate((UNSIGNED4)(((STRING)dob_in)[1..6] + '01'))	=> ROW({(((STRING)dob_in)[1..6] + '01'), 'YYYYMM01'}, DOBPaddingLayout),
			STD.Date.IsValidDate((UNSIGNED4)(((STRING)dob_in)[1..4] + '0101'))	=> ROW({(((STRING)dob_in)[1..4] + '0101'), 'YYYY0101'}, DOBPaddingLayout),
																					ROW({dob_in, ''}, DOBPaddingLayout));
		
		RETURN Result;
	END;
	

	Input_pre_override := Input_all((INTEGER)p_inpclnarchdt > 0); //inputs without contacts

	//if we have a mini fdc popualted here lets get this ready to use


//all overrides and suppressions are gathered in the mini FDC the passed to the FDC
	//FCRA overrides are NOT archivable 
	Input_getoverides:= PublicRecords_KEL.MAS_get.FCRA_Overrides(Options, JoinFlags).GetOverrideFlags(Input_pre_override);		

	SixthRepInput := Input_getoverides(RepNumber = 6);


	Input_pre := Input_getoverides(RepNumber <> 6);

	input :=Join(Input_pre, Input_pre_override, 
					left.G_ProcBusUID = right.G_ProcBusUID and
					left.G_ProcUID = right.G_ProcUID,
						TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII_Overrides,
							self.G_ProcBusUID := right.G_ProcBusUID,
							self.G_ProcUID := right.G_ProcUID,
							SELF.P_LexID := right.P_LexID,
							SELF.P_InpClnEmail := right.P_InpClnEmail,
							SELF.P_InpClnDL := right.P_InpClnDL,	
							SELF.P_InpClnSSN := right.P_InpClnSSN,
							SELF.P_InpClnNameLast := right.P_InpClnNameLast,
							SELF.P_InpClnSurname1 := right.P_InpClnSurname1,
							SELF.P_InpClnSurname2 := right.P_InpClnSurname2,
							SELF.P_InpClnNameMid := right.P_InpClnNameMid,
							SELF.P_InpClnNameFirst := right.P_InpClnNameFirst,
							SELF.P_InpClnDOB := right.P_InpClnDOB,
							SELF := left,
							SELF := []));


	//6th rep is nonfcra only so we can skip overrides
	//we only need this lexid to go through 3 datasets so we are keeping this seperated to avoid extra searching
	Input6thRep := project(SixthRepInput, TRANSFORM(Layouts_FDC.Layout_FDC,	
							SELF.UIDAppend := IF( left.G_ProcBusUID < 1, left.G_ProcUID, left.G_ProcBusUID ),
							SELF.G_ProcUID := left.G_ProcUID,
							SELF.P_LexID := left.P_LexID,
							SELF.G_ProcBusUID := left.G_ProcBusUID,
							SELF.P_InpClnEmail := left.P_InpClnEmail,
							SELF.P_InpClnDL := left.P_InpClnDL,	
							SELF.P_InpClnSSN := left.P_InpClnSSN,
							SELF.P_InpClnNameLast := left.P_InpClnNameLast,
							SELF.P_InpClnSurname1 := left.P_InpClnSurname1,
							SELF.P_InpClnSurname2 := left.P_InpClnSurname2,
							SELF.P_InpClnNameMid := left.P_InpClnNameMid,
							SELF.P_InpClnNameFirst := left.P_InpClnNameFirst,
							SELF.P_InpClnDOB := left.P_InpClnDOB,
							SELF.P_InpClnAddrPrimRng := LEFT.P_InpClnAddrPrimRng,
							SELF.P_InpClnAddrPrimName := LEFT.P_InpClnAddrPrimName,
							SELF.P_InpClnAddrZip5 := LEFT.P_InpClnAddrZip5,
							SELF.P_InpClnPhoneHome := LEFT.P_InpClnPhoneHome,
							self := left;
							SELF := []));
							

	// Now put together the FDC bundle				
	Input_FDC := JOIN(Input, BusinessInput, 
						LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID, 
						TRANSFORM(Layouts_FDC.Layout_FDC,
							SELF.UIDAppend := IF( RIGHT.G_ProcBusUID < 1, LEFT.G_ProcUID, RIGHT.G_ProcBusUID ),
							SELF.G_ProcUID := LEFT.G_ProcUID,
							SELF.P_LexID := LEFT.P_LexID,
							SELF.G_ProcBusUID := RIGHT.G_ProcBusUID,
							SELF.B_LexIDUlt := RIGHT.B_LexIDUlt, // UltID
							SELF.B_LexIDOrg := RIGHT.B_LexIDOrg, // OrgID
							SELF.B_LexIDLegal := RIGHT.B_LexIDLegal, // SeleID
							SELF.B_LexIDSite := RIGHT.B_LexIDSite, // PowID
							SELF.B_LexIDLoc := RIGHT.B_LexIDLoc, // ProxID
							SELF.B_InpClnTIN := RIGHT.B_InpClnTIN,
							SELF.P_InpClnEmail := LEFT.P_InpClnEmail,
							SELF.P_InpClnDL := LEFT.P_InpClnDL,	
							SELF.P_InpClnSSN := LEFT.P_InpClnSSN,
							SELF.P_InpClnNameLast := LEFT.P_InpClnNameLast,
							SELF.P_InpClnSurname1 := left.P_InpClnSurname1,
							SELF.P_InpClnSurname2 := left.P_InpClnSurname2,				
							SELF.P_InpClnNameMid := LEFT.P_InpClnNameMid,
							SELF.P_InpClnNameFirst := LEFT.P_InpClnNameFirst,
							SELF.P_InpClnDOB := LEFT.P_InpClnDOB,
							SELF.P_InpClnAddrPrimRng := LEFT.P_InpClnAddrPrimRng,
							SELF.P_InpClnAddrPrimName := LEFT.P_InpClnAddrPrimName,
							SELF.P_InpClnAddrZip5 := LEFT.P_InpClnAddrZip5,
							SELF.P_InpClnPhoneHome := LEFT.P_InpClnPhoneHome,
							SELF.P_InpClnArchDt := if(LEFT.P_InpClnArchDt <> '',LEFT.P_InpClnArchDt, right.b_InpClnArchDt);
							SELF.AddressGeoLink  := (trim(LEFT.P_InpClnAddrStateCode, left, right) + trim(left.P_InpClnAddrCnty, left, right) + trim(left.P_InpClnAddrGeo, left, right)),
							self := left;
							SELF := []), FULL OUTER );

	Input_Phone_Consumer_recs :=
		NORMALIZE( Input, 2, // Consumer input can contain a homephone and a workphone
			TRANSFORM( Layouts_FDC.LayoutPhoneGeneric_inputs,
				SELF.UIDAppend := LEFT.G_ProcUID,
				SELF.Phone := CHOOSE( COUNTER, LEFT.P_InpClnPhoneHome, LEFT.P_InpClnPhoneWork),
				SELF := LEFT,
				SELF := []
			)
		);

	Input_Address_Consumer_recs :=
		PROJECT( Input,
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
				SELF.UIDAppend       := LEFT.G_ProcUID,
				SELF.PrimaryRange    := LEFT.P_InpClnAddrPrimRng,
				SELF.Predirectional  := LEFT.P_InpClnAddrPreDir,
				SELF.PrimaryName     := LEFT.P_InpClnAddrPrimName,
				SELF.AddrSuffix      := LEFT.P_InpClnAddrSffx,
				SELF.Postdirectional := LEFT.P_InpClnAddrPostDir,
				SELF.City            := LEFT.P_InpClnAddrCity,
				SELF.State           := LEFT.P_InpClnAddrState,
				SELF.ZIP5            := LEFT.P_InpClnAddrZip5,
				SELF.SecondaryRange  := LEFT.P_InpClnAddrSecRng,
				SELF.AddressGeoLink  := (trim(LEFT.P_InpClnAddrStateCode, left, right) + trim(left.P_InpClnAddrCnty, left, right) + trim(left.P_InpClnAddrGeo, left, right)),
				SELF := LEFT,
				SELF := []
			)
		);
	
	Input_Address_Business_recs :=
		PROJECT( BusinessInput,
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
				SELF.UIDAppend       := LEFT.G_ProcBusUID,
				SELF.PrimaryRange    := LEFT.B_InpClnAddrPrimRng,
				SELF.Predirectional  := LEFT.B_InpClnAddrPreDir,
				SELF.PrimaryName     := LEFT.B_InpClnAddrPrimName,
				SELF.AddrSuffix      := LEFT.B_InpClnAddrSffx,
				SELF.Postdirectional := LEFT.B_InpClnAddrPostDir,
				SELF.City            := LEFT.B_InpClnAddrCity,
				SELF.State           := LEFT.B_InpClnAddrState,
				SELF.ZIP5            := LEFT.B_InpClnAddrZip5,
				SELF.SecondaryRange  := LEFT.B_InpClnAddrSecRng,
				SELF.CityCode        := Doxie.Make_CityCode(LEFT.B_InpClnAddrCity),
				SELF.AddressGeoLink  := (trim(LEFT.B_InpClnAddrStateCode, left, right) + trim(left.B_InpClnAddrCnty, left, right) + trim(left.B_InpClnAddrGeo, left, right)),
				self.p_inpclnarchdt := left.b_inpclnarchdt;
				SELF := LEFT,
				SELF := []
			)
		);
		
	

	Input_Address_All_pre := (Input_Address_Consumer_recs + Input_Address_Business_recs)(PrimaryName != '' AND ZIP5 != '');
	Input_Address_All := dedup(sort(Input_Address_All_pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode);	
	

    
	//need to use did from fid key instead of plexid in case input address is valid but not tied to P_lexid				
	InputLexidsTrans := project(Input_FDC(p_lexid >0), transform({unsigned6 did;}, self.did := left.P_LexID, self := []));
	InputLexids := SET((InputLexidsTrans), DID);	




/*************************************************************************************************************/	

	
	//to find searchable datasets seach for '//for searching'
	//they should all be towards the top of this fdc code, if you fine one below please move it up
	
		
	//check if we need to make a call to contacts or if we did this already
	Run_Contacts_Key := Common.DoFDCJoin_BIPV2_Build__kfetch_contact_linkids = TRUE ;

//First call to contact key with business to get lexid's associated with businesses

	Temp_Bus_contact := IF(Run_Contacts_Key, PublicRecords_KEL.mas_get.Contact_LinkIDs(Input_FDC, PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID, linkingOptions, mod_access, PublicRecords_KEL.ECL_Functions.Constants.BUSINESS_CONTACT_PROPERTY_LIMIT));


	contacts := join(input_FDC, Temp_Bus_contact,
				LEFT.UIDAppend = RIGHT.UniqueID and
					IF(ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <> '',ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) ,ArchiveDate((string)right.dt_first_seen_contact)) <= LEFT.P_InpClnArchDt[1..8],
					transform(Layouts_FDC.Layout_BIPV2_Build__kfetch_contact_linkids,
						self.UIDAppend := right.UniqueID,
						self.g_procuid := right.UniqueID,
						self.p_inpclnarchdt := left.p_inpclnarchdt,
						SELF.B_LexIDUlt := left.B_LexIDUlt,
						SELF.B_LexIDOrg := left.B_LexIDOrg,
						SELF.B_LexIDLegal := left.B_LexIDLegal,
						self := right,
						self := []));
						
	
	With_BIPV2_Build_contact_linkids := DENORMALIZE(Input_FDC, contacts,
			IF(ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <> '',ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) ,ArchiveDate((string)right.dt_first_seen_contact)) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2_Build__kfetch_contact_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BIPV2_Build__kfetch_contact_linkids, 
																						self.P_LexID := left.contact_did,
																						self.UIDAppend := left.UIDAppend,
																						self.g_procuid := left.UIDAppend,
																						self.src := LEFT.Source, //many sources in business header
																						SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, Is_Business_Header := TRUE, Marketing_state := left.company_address.st, KELPermissions := CFG_File),																				
																						self.Archive_Date := IF(ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported) <> '',ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported) ,ArchiveDate((string)left.dt_first_seen_contact));																					
																						self.dt_first_seen := (INTEGER)archivedate((string)left.dt_first_seen);																								
																						SELF.JobTitle := IF(TRIM(LEFT.contact_job_title_derived) != '', TRIM(LEFT.contact_job_title_derived), TRIM(LEFT.contact_job_title_raw)),//use derived if its populated else use raw
																						SELF.Status := IF(TRIM(LEFT.contact_status_derived) != '', TRIM(LEFT.contact_status_derived), TRIM(LEFT.contact_status_raw)),//use derived if its populated else use raw
																						self := left, 
																						self := []));
					SELF := LEFT,
					SELF := []));	
				

				


	//transform business contact into input layout and dedup
	//only keep contacts within the past 3 years for 'extra' searching, keep 3 years for build date padding
	temp_Contacts := project(Contacts, transform(Layouts_FDC.Layout_FDC, self.P_LexID := left.contact_did, self.UIDAppend := left.UIDAppend, self.g_procuid := left.UIDAppend, self.P_InpClnArchDt := LEFT.P_InpClnArchDt,self.P_InpClnSurname1 := left.contact_name.lname, self.Contact_date := if(left.dt_last_seen_contact>(integer)LEFT.P_InpClnArchDt[1..8],(integer)LEFT.P_InpClnArchDt[1..8],left.dt_last_seen_contact), self := left, self := []));		
	Bus_contact_Second := temp_Contacts((P_LexID > 0) and (ut.daysapart((string)Contact_date, P_InpClnArchDt[1..8]) < ut.DaysInNYears(3)));



	// Only keep 100 contacts per business for LexID searching to improve performance
	Business_Contact_LexIDs_Temp := DEDUP(SORT(Bus_contact_Second, UIDAppend, P_LexID), WHOLE RECORD);
	Business_Contact_LexIDs := DEDUP(DEDUP(SORT(Business_Contact_LexIDs_Temp, UIDAppend, P_LexID), UIDAppend, P_LexID), UIDAppend, KEEP(100));	
/*************************************************************************************************************/
	//transform business contact into input layout and dedup
	Input_Plus_Contacts := (Input_FDC + Business_Contact_LexIDs)(P_LexID > 0);

	//for searching
	Input_FDC_Business_Contact_LexIDs := DEDUP(SORT(Input_Plus_Contacts, UIDAppend, P_LexID), UIDAppend, P_LexID);		//we use this later


/*************************************************************************************************************/


	Key_dx_Header__key_did_hhid :=
			JOIN(Input_FDC, dx_Header.key_did_hhid(),
			Common.DoFDCJoin_dx_Header__key_did_hhid =TRUE  and 
			LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did) and right.ver=1,
				TRANSFORM(Layouts_FDC.Layout_dx_Header__key_did_hhid,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.g_procuid := LEFT.g_procuid,
					SELF.did := LEFT.P_LexID,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.HouseHoldKeys,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					self.Archive_Date :=  '';		//no dates.			
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.HHID_Join_LIMIT));


	deduped_HHIDS:= DEDUP(SORT(Key_dx_Header__key_did_hhid,UIDAppend,hhid),UIDAppend,hhid);


	With_Key_dx_Header__key_did_hhid := DENORMALIZE(With_BIPV2_Build_contact_linkids, deduped_HHIDS,
				LEFT.UIDAppend=RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_dx_Header__key_did_hhid := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));	
						

	//hhid returned is used to search did 
	Key_dx_Header__key_hhid_did :=
			JOIN(deduped_HHIDS, dx_Header.key_hhid_did(), //no dates - does not need date selected.
			Common.DoFDCJoin_dx_Header__key_did_hhid =TRUE  and 
			LEFT.hhid_relat > 0 AND
				KEYED(LEFT.hhid_relat =RIGHT.hhid_relat),
				TRANSFORM(Layouts_FDC.Layout_dx_Header__key_hhid_did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.g_procuid := LEFT.g_procuid,
					SELF.hhid_relat := LEFT.hhid_relat,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.HouseHoldKeys,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					self.Archive_Date :=  '';		//no dates.		
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.HHID_Join_LIMIT));

	
	With_Key_dx_Header__key_hhid_did := DENORMALIZE(With_Key_dx_Header__key_did_hhid, Key_dx_Header__key_hhid_did,
				LEFT.UIDAppend=RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_dx_Header__key_hhid_did := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		
						         
		ismarketing := if(Options.isMarketing,'MARKETING','');
		sourcecoderelatives := if(Options.isMarketing,MDR.sourceTools.src_Marketing_Relatives_Data,MDR.sourceTools.src_Relatives_Data);
		HeaderRelatives :=  IF(Common.DoFDCJoin_Relatives__Key_Relatives_v3 = TRUE , Relationship.proc_GetRelationshipNeutral(PROJECT(Input_FDC_Business_Contact_LexIDs(P_LexID > 0), TRANSFORM(Relationship.layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.P_Lexid)),
																	TopNCount:=100,
																	RelativeFlag :=TRUE,AssociateFlag:=TRUE,
																	doAtmost:=TRUE,MaxCount:=PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000, RelKeyFlag:= ismarketing).result);
																	
																	
		Key_Relatives__Key_Relatives_V3_Unsuppressed := Join(Input_FDC_Business_Contact_LexIDs,HeaderRelatives, 
																				LEFT.P_Lexid = RIGHT.DID1 and
																				#expand(PublicRecords_KEL.ECL_Functions.Constants.rel_filter),
																			TRANSFORM(Layouts_FDC.Layout_Relatives__Key_Relatives_V3,
																					SELF.UIDAppend := LEFT.UIDAppend,
																					SELF.g_procuid := LEFT.g_procuid,
																					SELF.P_LexID := LEFT.P_LexID,
																					SELF.Src := sourcecoderelatives; 
																					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																					self.Archive_Date :=  '';		//not archivable.						
																					SELF.CoSourceCount := COUNT(RIGHT.rels);
																					SELF.CoSourceSum := SUM(RIGHT.rels, Cnt);
																					SELF := RIGHT, 
																					SELF := LEFT,
																					SELF := []));
		
	Key_Relatives__Key_Relatives_V3 := Suppress.MAC_SuppressSource(Key_Relatives__Key_Relatives_V3_Unsuppressed, mod_access, did_field := did1, data_env := Environment);	
	

	With_Key_Relatives_V3_Records := 
		DENORMALIZE(With_Key_dx_Header__key_hhid_did, Key_Relatives__Key_Relatives_V3,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Relatives__Key_Relatives_V3 := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));					




/*************************************************************************************************************/
	All_Relatives := Key_Relatives__Key_Relatives_V3(did2 >0);//both marketing and non marketing relatives.
	
	Seperate_relatives := All_Relatives(did1 IN InputLexids);//we only want input lexid relatives NOT contact relatives

	RelativesLexids := project(Seperate_relatives, TRANSFORM(Layouts_FDC.Layout_FDC, self.P_lexid := LEFT.did2, SELF.UIDAppend := LEFT.UIDAppend, SELF := LEFT, SELF := []));//take the relatives of inputs and assign them to plexid
 	
	Seperate_HouseHold_Lexids := Key_dx_Header__key_hhid_did(P_LexID IN InputLexids);//we only want input lexid hhids NOT contact hhids

  HHIDLexids_preadl := PROJECT(Seperate_HouseHold_Lexids(did >0), TRANSFORM(Layouts_FDC.Layout_FDC, SELF.P_LexID := LEFT.did; SELF := LEFT; SELF := []));
		
	//for searching
	//this HHID Dataset can go to ADL Seq ONLY please use other HHID dataset Input_HHIDLexids below for other key searching
  Input_HHIDLexids_Input6thRep_preADL := DEDUP(SORT(((Input_FDC + HHIDLexids_preadl + Input6thRep)(P_LexID > 0)), UIDAppend, P_LexID), UIDAppend, P_LexID);
 
/*************************************************************************************************************/
	
	
	Header__key_ADL_segmentation_Records := 
		JOIN(Input_HHIDLexids_Input6thRep_preADL, Header.key_ADL_segmentation, //adl seg is nonFCRA only for now
				Common.DoFDCJoin_Header__key_ADL_segmentation = TRUE  and  
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Header__key_ADL_segmentation,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.ADL,
					SELF.DPMBitmap := SetDPMBitmap( Source :=  SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  '';		//no dates
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), KEEP(1));
						
	//we only want to keep lexids from households with core or corevnossn
	HHIDs_ADL_Lexids := Header__key_ADL_segmentation_Records(did  NOT IN InputLexids);
	HHIDs_ADLs_Good_Lexids := HHIDs_ADL_Lexids(ind1 = PublicRecords_KEL.ECL_Functions.Constants.HouseHoldCORE OR ind1 = PublicRecords_KEL.ECL_Functions.Constants.HouseHoldCOREVNOSSN);
	
	//we do not want to filter input lexeds on the above adl catigories like HHID	
	Input_ADL_Lexids := Header__key_ADL_segmentation_Records(did IN InputLexids);

  HHIDLexids := PROJECT(HHIDs_ADLs_Good_Lexids, TRANSFORM(Layouts_FDC.Layout_FDC, SELF.P_LexID := LEFT.did; SELF := LEFT; SELF := []));


	With_Header__key_ADL_segmentation_Records_original := DENORMALIZE(With_Key_Relatives_V3_Records, (HHIDs_ADLs_Good_Lexids+Input_ADL_Lexids),
				LEFT.UIDAppend = RIGHT.UIDAppend and 
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Header__key_ADL_segmentation := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		
						
	With_Header__key_ADL_segmentation_Records_6threp := DENORMALIZE(Input6thRep, (HHIDs_ADLs_Good_Lexids+Input_ADL_Lexids),
				LEFT.UIDAppend = RIGHT.UIDAppend and 
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Header__key_ADL_segmentation := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));	
	
/*************************************************************************************************************/
//for searching	

  Input_HHIDLexids := DEDUP(SORT((Input_FDC + HHIDLexids)(P_LexID > 0), UIDAppend, P_LexID), UIDAppend, P_LexID);
	Input_FDC_RelativesLexids_HHIDLexids_LexIDs := DEDUP(SORT((RelativesLexids + Input_HHIDLexids )(P_LexID > 0), UIDAppend, P_LexID), UIDAppend, P_LexID);

	Business_Contact_LexIDs_Input6thRep := DEDUP(SORT((Business_Contact_LexIDs + Input6thRep)(P_LexID > 0), UIDAppend, P_LexID), UIDAppend, P_LexID);

	Input_FDC_RelativesLexids_Business_Contact_LexIDs_Input6thRep := DEDUP(SORT((Input_FDC + RelativesLexids + Business_Contact_LexIDs_Input6thRep)(P_LexID > 0), UIDAppend, P_LexID), UIDAppend, P_LexID);

  Input_FDC_RelativesLexids_HHIDLexids_Business_Contact_LexIDs_Input6thRep := DEDUP(SORT((Input_FDC_RelativesLexids_HHIDLexids_LexIDs + Business_Contact_LexIDs_Input6thRep)(P_LexID > 0), UIDAppend, P_LexID), UIDAppend, P_LexID);


/*************************************************************************************************************/

/* Best person by Business Sele Contact Lexids from Watchdog Keys */				
	//per data team watchdog ccpa records are being suppressed at build time, therefore we do not need to suppress on our end
	Best_Person__Key_Watchdog_Records := IF(Common.DoFDCJoin_Best_Person__Key_Watchdog ,  //watchdog data is not archivable
				dx_BestRecords.append((Input_FDC_RelativesLexids_HHIDLexids_Business_Contact_LexIDs_Input6thRep)(P_LexID>0), P_LexID, wdog_perm, use_distributed := false));

	nonFCRA_watchdog_temp :=  project(Best_Person__Key_Watchdog_Records,transform(Layouts_FDC.Layout_Best_Person__Key_Watchdog, self.rec  := left._best, self  := left, self := []));


	With_Best_Person__Key_Watchdog_original := DENORMALIZE(With_Header__key_ADL_segmentation_Records_original, nonFCRA_watchdog_temp,
				LEFT.UIDAppend = RIGHT.UIDAppend and 
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Best_Person__Key_Watchdog := project(rows(right),transform(Layouts_FDC.Layout_Best_Person__Key_Watchdog, 
																																	SELF.UIDAppend := LEFT.UIDAppend,
																																	SELF.G_ProcUID := LEFT.G_ProcUID,
																																	SELF.P_LexID := LEFT.P_LexID,
																																	SELF.src := MDR.SourceTools.src_Best_Person,
																																	SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA ,  KELPermissions := CFG_File);
																																	self.Archive_Date :=  '';		//not archivable	
																																	self.rec  := left.rec, 
																																	self := []));
																													SELF := LEFT,
																													SELF := []), ALL);  
																													
	With_Best_Person__Key_Watchdog_6threp := DENORMALIZE(With_Header__key_ADL_segmentation_Records_6threp, nonFCRA_watchdog_temp,
				LEFT.UIDAppend = RIGHT.UIDAppend and 
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Best_Person__Key_Watchdog := project(rows(right),transform(Layouts_FDC.Layout_Best_Person__Key_Watchdog, 
																																	SELF.UIDAppend := LEFT.UIDAppend,
																																	SELF.G_ProcUID := LEFT.G_ProcUID,
																																	SELF.P_LexID := LEFT.P_LexID,
																																	SELF.src := MDR.SourceTools.src_Best_Person,
																																	SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA ,  KELPermissions := CFG_File);
																																	self.Archive_Date :=  '';		//not archivable
																																	self.rec  := left.rec, 
																																	self := []));
																													SELF := LEFT,
																													SELF := []), ALL);  			
			
	Best_Person__Key_Watchdog_FCRA_nonEN_Records := 
		JOIN(Input_FDC, Watchdog.Key_Watchdog_FCRA_nonEN, //watchdog data is not archivable
				Common.DoFDCJoin_Best_Person__Key_Watchdog_FCRA = TRUE  and
				Options.Data_Restriction_Mask[Risk_Indicators.iid_constants.posEquifaxRestriction] <> '1' and
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Best_Person__Key_Watchdog_FCRA_nonEN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.src := PublicRecords_KEL.ECL_Functions.Constants.Watchdog_NonEN_FCRA,
					//source for FCRA best person has to be the below string for DRM bit Risk_Indicators.iid_constants.posEquifaxRestriction to work
					SELF.DPMBitmap := SetDPMBitmap( Source :=  SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  '';		//not archivable	
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob);
					SELF.dob := DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), KEEP(1));
					

	
	Best_Person__Key_Watchdog_FCRA_nonEQ_Records := 
		JOIN(Input_FDC, Watchdog.Key_Watchdog_FCRA_nonEQ, //watchdog data is not archivable
				Common.DoFDCJoin_Best_Person__Key_Watchdog_FCRA = TRUE  and
				Options.Data_Restriction_Mask[Risk_Indicators.iid_constants.posEquifaxRestriction] = '1' AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Best_Person__Key_Watchdog_FCRA_nonEQ,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.src := PublicRecords_KEL.ECL_Functions.Constants.Watchdog_NonEQ_FCRA,
					//source for FCRA best person has to be the below string for DRM bit Risk_Indicators.iid_constants.posEquifaxRestriction to work
					SELF.DPMBitmap := SetDPMBitmap( Source :=  SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  '';		//not archivable	
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob);
					SELF.dob := DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), KEEP(1));
	
	
	With_Best_Person__Key_Watchdog_FCRA_nonEN := DENORMALIZE(With_Best_Person__Key_Watchdog_original, Best_Person__Key_Watchdog_FCRA_nonEN_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));	
	
	With_Best_Person__Key_Watchdog_FCRA_nonEQ := DENORMALIZE(With_Best_Person__Key_Watchdog_FCRA_nonEN, Best_Person__Key_Watchdog_FCRA_nonEQ_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	//DRM bit is checked in Common to ensure we only use the correct FCRA SSN here
	Best_SSN_FCRA := Project((Best_Person__Key_Watchdog_FCRA_nonEN_Records+Best_Person__Key_Watchdog_FCRA_nonEQ_Records), transform(Layouts_FDC.Layout_FDC, 
																				self.P_InpClnSSN := Left.SSN , 
																				self.UIDAppend := left.UIDAppend, 
																				self.g_procuid := left.g_procuid, 
																				self := left, 
																				self := []));
	
																														
	Best_SSN_NonFCRA := Project(nonFCRA_watchdog_temp(rec.did IN InputLexids), transform(Layouts_FDC.Layout_FDC, //we pass contacts into here, we only want to keep input best ssn
																				self.P_InpClnSSN := Left.rec.SSN, 
																				self.UIDAppend := left.UIDAppend, 
																				self.g_procuid := left.g_procuid, 
																				self := left, 
																				self := []));	
																				
	Best_Phone_NonFCRA := Project(nonFCRA_watchdog_temp(rec.did IN InputLexids), transform(Layouts_FDC.LayoutPhoneGeneric_inputs, //we pass contacts into here, we only want to keep input best ssn
																				self.phone := Left.rec.phone, 
																				self.UIDAppend := left.UIDAppend, 
																				self.g_procuid := left.g_procuid, 
																				self := left, 
																				self := []));
/*************************************************************************************************************/	
//for searching																		
	Input_Best_SSN_nonFCRA := Dedup(Sort((Best_SSN_NonFCRA+Input_FDC)((integer)P_InpClnSSN>0), UIDAppend, P_InpClnSSN),UIDAppend, P_InpClnSSN);
	Input_Best_SSN_FCRA := Dedup(Sort((Best_SSN_FCRA+Input_FDC)((integer)P_InpClnSSN>0), UIDAppend, P_InpClnSSN),UIDAppend, P_InpClnSSN);
/*************************************************************************************************************/
	
	Key_QH_SSN :=	
			JOIN(Input_Best_SSN_nonFCRA, autokey.Key_SSN(header_quick.str_AutokeyName),//non FCRA only
				Common.DoFDCJoin_Quick_Header__key_wild_SSN = TRUE  AND
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN[1] = RIGHT.s1 AND
							LEFT.P_InpClnSSN[2] = RIGHT.s2 AND
							LEFT.P_InpClnSSN[3] = RIGHT.s3 AND
							LEFT.P_InpClnSSN[4] = RIGHT.s4 AND
							LEFT.P_InpClnSSN[5] = RIGHT.s5 AND
							LEFT.P_InpClnSSN[6] = RIGHT.s6 AND
							LEFT.P_InpClnSSN[7] = RIGHT.s7 AND
							LEFT.P_InpClnSSN[8] = RIGHT.s8 AND
							LEFT.P_InpClnSSN[9] = RIGHT.s9),
				TRANSFORM(Layouts_FDC.Layout_Doxie__key_wild_SSN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.P_InpClnSSN := LEFT.P_InpClnSSN,
					self.lname := right.dph_lname;
					self.fname := right.pfname;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
	
/*************************************************************************************************************/
//for searching
	temp_QH_SSN := project(Key_QH_SSN, transform(Layouts_FDC.Layout_FDC, self.P_LexID := left.did,  self := left, self := []));		
	lexids_for_QH := temp_QH_SSN+ Input_FDC_RelativesLexids_HHIDLexids_Business_Contact_LexIDs_Input6thRep;
	clean_QH := dedup(sort(lexids_for_QH,	UIDAppend, P_LexID), UIDAppend, P_LexID);		// Header_Quick.Key_Did_FCRA/Header_Quick.Key_Did. FCRA/NonFCRA have the same layout.		
/*************************************************************************************************************/

	Header_Quick__Key_Did := IF(Options.IsFCRA, Header_Quick.Key_Did_FCRA, Header_Quick.Key_Did);
	
		Header_Quick__Key_Did_Records_Unsuppressed :=  JOIN(clean_QH, Header_Quick__Key_Did,
				common.DoFDCJoin_Doxie__Key_Header = TRUE  and 
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.did) and
				IF(Options.isMarketing,(PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src) IN PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES OR PublicRecords_KEL.ECL_Functions.Common_Functions.IsMarketingAllowedKey(PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src), right.st)), TRUE) and
				IF(Options.isFCRA ,(PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src) IN SET(PublicRecords_KEL.ECL_Functions.Constants.Allowed_Consumer_Header_SRC(Options.isFCRA), Src)),PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src) IN SET(PublicRecords_KEL.ECL_Functions.Constants.Allowed_Consumer_Header_SRC, Src) ) and
				(Header.isPreGLB_LIB(right.dt_nonglb_last_seen, right.dt_first_seen, PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src), options.Data_Restriction_Mask) or glb_ok) and				
				(~mdr.Source_is_DPPA(PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src)) OR(dppa_ok AND drivers.state_dppa_ok(header.translateSource(PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src)), Options.DPPAPurpose , PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src))) or Options.isFCRA) AND 		
				 PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src) not in PublicRecords_KEL.ECL_Functions.Constants.masked_header_sources(options.Data_Restriction_Mask, Options.isFCRA),	
				TRANSFORM(Layouts_FDC.Layout_Header_Quick__Key_Did,//for corrections we need to start out with the same layout as header.
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob);
					SELF.dob := DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PublicRecords_KEL.ECL_Functions.Constants.PreGLBRegulatedRecord(right.Src, right.dt_nonglb_last_seen, right.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := PublicRecords_KEL.ECL_Functions.Constants.GetDPPAState(PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(right.src)),Marketing_State := right.st, KELPermissions := CFG_File, Is_Consumer_Header := TRUE),
					SELF.HeaderRec := FALSE,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
				
	searchWildKey := if(options.isFCRA, Input_Best_SSN_FCRA, Input_Best_SSN_nonFCRA);

	//gather lexids from input ssn
		Key_wild_SSN :=	//	No dates does not need DateSelector
			JOIN(searchWildKey, dx_Header.key_wild_SSN(iType),
				Common.DoFDCJoin_Dx_Header__key_wild_SSN = TRUE  AND
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN[1] = RIGHT.s1 AND
							LEFT.P_InpClnSSN[2] = RIGHT.s2 AND
							LEFT.P_InpClnSSN[3] = RIGHT.s3 AND
							LEFT.P_InpClnSSN[4] = RIGHT.s4 AND
							LEFT.P_InpClnSSN[5] = RIGHT.s5 AND
							LEFT.P_InpClnSSN[6] = RIGHT.s6 AND
							LEFT.P_InpClnSSN[7] = RIGHT.s7 AND
							LEFT.P_InpClnSSN[8] = RIGHT.s8 AND
							LEFT.P_InpClnSSN[9] = RIGHT.s9),
				TRANSFORM(Layouts_FDC.Layout_Doxie__key_wild_SSN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.P_InpClnSSN := LEFT.P_InpClnSSN,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

		Key_wild_phone :=	//	No dates does not need DateSelector
			JOIN(Input_Phone_Consumer_recs, dx_Header.key_wild_phone(iType),
				Common.DoFDCJoin_Dx_Header__key_wild_phone = TRUE AND 
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone[4..10] = RIGHT.p7 AND
							   LEFT.Phone[1..3] = RIGHT.p3),
				TRANSFORM(Layouts_FDC.Layout_Header_key_wild_phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));


/*************************************************************************************************************/
//for searching
	temp_wild_SSN := project(Key_wild_SSN, transform(Layouts_FDC.Layout_FDC, self.P_LexID := left.did,  self := left, self := []));			
	temp_wild_phone := project(Key_wild_phone, transform(Layouts_FDC.Layout_FDC, self.P_LexID := left.did,  self := left, self := []));		
	lexids_for_Header := temp_wild_phone + temp_wild_SSN + Input_FDC_RelativesLexids_HHIDLexids_Business_Contact_LexIDs_Input6thRep;
	clean_Header := dedup(sort(lexids_for_Header, UIDAppend, P_LexID), UIDAppend, P_LexID);
	

/*************************************************************************************************************/

	Doxie__Key_Header_Records_Unsuppressed := JOIN(clean_Header, dx_header.key_header(iType),
				common.DoFDCJoin_Doxie__Key_Header = TRUE  and 
			LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.s_did) and
				IF(Options.isMarketing,(right.src IN PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES OR PublicRecords_KEL.ECL_Functions.Common_Functions.IsMarketingAllowedKey(right.src, right.st)), TRUE) and
				IF(Options.isFCRA ,(right.src IN SET(PublicRecords_KEL.ECL_Functions.Constants.Allowed_Consumer_Header_SRC(Options.isFCRA), Src)),right.src IN SET(PublicRecords_KEL.ECL_Functions.Constants.Allowed_Consumer_Header_SRC, Src) ) and
				(Header.isPreGLB_LIB(right.dt_nonglb_last_seen, right.dt_first_seen, right.src, options.Data_Restriction_Mask) or glb_ok) and				
				(~mdr.Source_is_DPPA(RIGHT.src) OR(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src), Options.DPPAPurpose , RIGHT.src)) or Options.isFCRA) AND 		
				 right.src not in PublicRecords_KEL.ECL_Functions.Constants.masked_header_sources(options.Data_Restriction_Mask, Options.isFCRA),	
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Header,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob);
					SELF.dob := DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF.HeaderRec := TRUE,
					SELF.DPMBitmap := SetDPMBitmap( Source := right.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PublicRecords_KEL.ECL_Functions.Constants.PreGLBRegulatedRecord(right.Src, right.dt_nonglb_last_seen, right.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := PublicRecords_KEL.ECL_Functions.Constants.GetDPPAState(right.src), Marketing_State := right.st, KELPermissions := CFG_file, Is_Consumer_Header := TRUE),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));


	temp_QH_REcords := project(Header_Quick__Key_Did_Records_Unsuppressed, transform(Layouts_FDC.Layout_Doxie__Key_Header, self := left, self := []));
	
	//after we decided what data we need to use lets add this together and get ready for overrides
	InputCorrectionsHeaderQuick := temp_QH_REcords+Doxie__Key_Header_Records_Unsuppressed;

	InputCorrectionsHeaderQuick_No_corrections := project(InputCorrectionsHeaderQuick, transform(Layouts_FDC.tempHeader, self := left, self := []));//returned if not FCRA and current
	
	//isminipop keeps us from calling to this key twice
	GetCorrectionsHeaderQuick := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Doxie__Key_Header = TRUE,
															PublicRecords_KEL.MAS_get.Header_Corrections_Function_Roxie(InputCorrectionsHeaderQuick), InputCorrectionsHeaderQuick_No_corrections);//consumer only since FCRA only -- no business in FCRA

	//already together may as well only do this once
	Header_Quick_Header_Records := Suppress.MAC_SuppressSource(GetCorrectionsHeaderQuick, mod_access, did_field := did, data_env := Environment);

	//need to put qh back in its layout which is basically the same as header but need this for uses
	
	
	real_Header_and_Quick_with_ingestdate_appended := join(Header_Quick_Header_Records, dx_Header.key_first_ingest(iType),
				options.UseIngestDate AND common.DoFDCJoin_Doxie__Key_Header = TRUE and 
				left.rid<>0 and 
				keyed(left.rid=right.rid),
			transform(Layouts_FDC.tempHeader,
				self.first_ingest_date := right.first_ingest_date,
				self := left
				), left outer, atmost(1000), keep(1));
	
		Header_Quick__Key_Did_Records_final := IF(options.UseIngestDate, real_Header_and_Quick_with_ingestdate_appended(headerrec = FALSE), Header_Quick_Header_Records(headerrec = FALSE));
	Doxie__Key_Header_Records_final := IF(options.UseIngestDate, real_Header_and_Quick_with_ingestdate_appended(headerrec = TRUE), Header_Quick_Header_Records(headerrec = TRUE));

	With_Doxie__Key_QuickHeader_original := DENORMALIZE(With_Best_Person__Key_Watchdog_FCRA_nonEQ, Header_Quick__Key_Did_Records_final,
			IF(~options.UseIngestDate, 
					ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8], 
					IF(right.first_ingest_date<>0, 
								ArchiveDate((string)right.first_ingest_date) <= LEFT.P_InpClnArchDt[1..8], 
										ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8])) and
				LEFT.UIDAppend = RIGHT.UIDAppend and 
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Header_Quick__Key_Did :=  project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Header_Quick__Key_Did, 
									SELF.DPMBitmap := left.DPMBitmap,
									self.dt_first_seen :=  (integer)archivedate((string)left.dt_first_seen);
									self.Archive_Date := MAP(~options.UseIngestDate => ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported),//FCRA, no use ingest
												left.first_ingest_date<>0 => ArchiveDate((string)left.first_ingest_date), //populated use it
												ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported));//else the old way	
									SELF := LEFT,
									SELF := []));
					SELF := LEFT,
					SELF := []));  

	With_Doxie__Key_QuickHeader_6threp := DENORMALIZE(With_Best_Person__Key_Watchdog_6threp, Header_Quick__Key_Did_Records_final,
			IF(~options.UseIngestDate, 
					ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8], 
					IF(right.first_ingest_date<>0, 
								ArchiveDate((string)right.first_ingest_date) <= LEFT.P_InpClnArchDt[1..8], 
										ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8])) and
				LEFT.UIDAppend = RIGHT.UIDAppend and 
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Header_Quick__Key_Did :=  project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Header_Quick__Key_Did, 
									SELF.DPMBitmap := left.DPMBitmap,
									self.dt_first_seen :=  (integer)archivedate((string)left.dt_first_seen);
									self.Archive_Date := MAP(~options.UseIngestDate => ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported),//FCRA, no use ingest
												left.first_ingest_date<>0 => ArchiveDate((string)left.first_ingest_date), //populated use it
												ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported));//else the old way	
									SELF := LEFT,
									SELF := []));
					SELF := LEFT,
					SELF := []));  

	With_Doxie__Key_Header_original := DENORMALIZE(With_Doxie__Key_QuickHeader_original, Doxie__Key_Header_Records_final,
			IF(~options.UseIngestDate, 
					ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8], 
					IF(right.first_ingest_date<>0, 
								ArchiveDate((string)right.first_ingest_date) <= LEFT.P_InpClnArchDt[1..8], 
										ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8])) and
				LEFT.UIDAppend = RIGHT.UIDAppend and 
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie__Key_Header := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Doxie__Key_Header, 
						SELF.DPMBitmap := left.DPMBitmap,
						self.dt_first_seen :=  (integer)archivedate((string)left.dt_first_seen);
						self.Archive_Date := MAP(~options.UseIngestDate => ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported),//FCRA, no use ingest
												left.first_ingest_date<>0 => ArchiveDate((string)left.first_ingest_date), //populated use it
												ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported));//else the old way	
						SELF := LEFT,
						SELF := []));
					SELF := LEFT,
					SELF := []));  

	With_Doxie__Key_Header_6threp := DENORMALIZE(With_Doxie__Key_QuickHeader_6threp, Doxie__Key_Header_Records_final,
			IF(~options.UseIngestDate, 
					ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8], 
					IF(right.first_ingest_date<>0, 
								ArchiveDate((string)right.first_ingest_date) <= LEFT.P_InpClnArchDt[1..8], 
										ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8])) and
				LEFT.UIDAppend = RIGHT.UIDAppend and 
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie__Key_Header := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Doxie__Key_Header, 
						SELF.DPMBitmap := left.DPMBitmap,
						self.dt_first_seen :=  (integer)archivedate((string)left.dt_first_seen);
						self.Archive_Date := MAP(~options.UseIngestDate => ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported),//FCRA, no use ingest
												left.first_ingest_date<>0 => ArchiveDate((string)left.first_ingest_date), //populated use it
												ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported));//else the old way	
						SELF := LEFT,
						SELF := []));
					SELF := LEFT,
					SELF := []));  
	
	Header_original := NORMALIZE(With_Doxie__Key_Header_original, LEFT.Dataset_Doxie__Key_Header, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));	
	Header_6threp := NORMALIZE(With_Doxie__Key_Header_6threp, LEFT.Dataset_Doxie__Key_Header, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));	
	
	
	// Header: consumer only
	Key_Header_Addr_Hist_temp := 
			JOIN((Input_FDC_RelativesLexids_Business_Contact_LexIDs_Input6thRep), dx_Header.key_addr_hist(iType), 
				Common.DoFDCJoin_Header__Key_Addr_Hist = TRUE  AND 
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did) and
				ArchiveDate((string)right.date_first_seen) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Header__Key_Addr_Hist_temp,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.date_first_seen :=  (integer)archivedate((string)right.date_first_seen);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));


	Key_Header_Addr_Hist := 
			JOIN(Key_Header_Addr_Hist_temp, AID_Build.Key_AID_Base, 
				Common.DoFDCJoin_Header__Key_Addr_Hist = TRUE  AND 
				KEYED(LEFT.Rawaid = RIGHT.Rawaid),
				TRANSFORM(Layouts_FDC.Layout_Header__Key_Addr_Hist,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.date_first_seen :=  (integer)archivedate((string)left.date_first_seen);
					SELF := LEFT,
					SELF.v_city_name := RIGHT.v_city_name;
					SELF.st := RIGHT.st;
					SELF.zip4 := RIGHT.zip4;
					SELF.StateCode := RIGHT.county[1..2];         
					SELF.county := RIGHT.county[3..5];         
					SELF.geo_lat := RIGHT.geo_lat;
					SELF.geo_long := RIGHT.geo_long;
					SELF.geo_blk := RIGHT.geo_blk;
					SELF.geo_match := RIGHT.geo_match;
					SELF.Geo_Link := self.StateCode + self.county + self.geo_blk ;	
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_SEARCH_FID_JOIN_LIMIT), KEEP(1));

	AddrHistToHeader := join(Key_Header_Addr_Hist, (Header_6threp+Header_original),
											LEFT.UIDAppend = RIGHT.UIDAppend  AND
											left.s_did<>0 and left.zip<>'' and left.prim_name<>'' and
											left.s_did=right.did and 
											left.zip=right.zip and
											left.prim_range=right.prim_range and
											left.prim_name=right.prim_name and
											ut.NNEQ(left.sec_range,right.sec_range),  // allow for NNEQ on sec range
												TRANSFORM(Layouts_FDC.Layout_Header__Key_Addr_Hist,
													SELF.Src := right.src,
													SELF.DPMBitmap := right.DPMBitmap,//we already filtered header for permissions just need to join the left overs
													self.Archive_Date :=  ArchiveDate((string)left.date_first_seen);
													self.date_first_seen :=  (integer)archivedate((string)left.date_first_seen);
													self := left),		
													left outer);

	AddrHistToHeaderSlim 	:= Dedup(sort(AddrHistToHeader, WHOLE RECORD));


	With_Header_Addr_Hist_Records_original := DENORMALIZE(With_Doxie__Key_Header_original, AddrHistToHeaderSlim,
		LEFT.UIDAppend = RIGHT.UIDAppend and 
				left.g_procuid = right.g_procuid, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Header__Key_Addr_Hist := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	With_Header_Addr_Hist_Records_6threp := DENORMALIZE(With_Doxie__Key_Header_6threp, AddrHistToHeaderSlim,
		LEFT.UIDAppend = RIGHT.UIDAppend and 
				left.g_procuid = right.g_procuid, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Header__Key_Addr_Hist := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	
			
	Layouts_FDC.Layout_ConsumerStatementFlags Normalize_(RECORDOF(Input) le, RECORDOF(Input.ConsumerStatements) ri) := TRANSFORM
						SELF.Timestamp := ri.Timestamp;
						SELF.UIDAppend := le.G_ProcUID;
						SELF.corrected_flag := le.ConsumerFlags.corrected_flag;
						SELF.consumer_statement_flag := le.ConsumerFlags.consumer_statement_flag;
						SELF.dispute_flag := le.ConsumerFlags.dispute_flag;
						SELF.security_freeze := le.ConsumerFlags.security_freeze;
						SELF.security_alert := le.ConsumerFlags.security_alert;
						SELF.id_theft_flag := le.ConsumerFlags.id_theft_flag;
						SELF.legal_hold_alert := le.ConsumerFlags.legal_hold_alert;
						SELF.datefirstseen := (string)ri.Timestamp.year + 
																				if(length((STRING)ri.Timestamp.month) = 1, ('0'+(STRING)ri.Timestamp.month), (STRING)ri.Timestamp.month)+ 
																				if(length((STRING)ri.Timestamp.day) = 1, ('0'+(STRING)ri.Timestamp.day), (STRING)ri.Timestamp.day);							
						SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.PersonContext;															
						SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
						self.Archive_Date :=  '';//not archivable
						SELF := ri;
						self := le;						
					self := [];
				END;
				
	ConsumerStatementFlags_Norm :=NORMALIZE(Input, LEFT.ConsumerStatements, Normalize_(LEFT, RIGHT));

	With_ConsumerStatementFlags := DENORMALIZE(With_Header_Addr_Hist_Records_original, ConsumerStatementFlags_Norm, 
				LEFT.UIDAppend = RIGHT.UIDAppend AND 
				LEFT.g_procuid = RIGHT.g_procuid AND 
				LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_ConsumerStatementFlags := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		
	
	
	RETURN (With_ConsumerStatementFlags+With_Header_Addr_Hist_Records_6threp);
	
	END;