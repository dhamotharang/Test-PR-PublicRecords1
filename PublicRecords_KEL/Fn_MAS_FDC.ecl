IMPORT AID_Build, ADVO, AlloyMedia_student_list,  American_student_list, AutoKey, AVM_V2, BankruptcyV3, BBB2, BIPV2, BIPV2_Best, BIPV2_Build, Business_Risk_BIP, BusReg, CalBus, CellPhone, Certegy, Corp2,
		Cortera, Data_Services, DCAV2, Death_Master,  Doxie, Doxie_Files, DriversV2, DMA, dx_BestRecords, dx_ConsumerFinancialProtectionBureau, dx_Cortera_Tradeline, dx_DataBridge, DX_Email,
		dx_Equifax_Business_Data, dx_Gong, dx_Header, dx_Infutor_NARB, dx_OSHAIR, dx_Relatives_v3, EBR, Email_Data, emerges, Experian_CRDB, FAA, FBNv2, FLAccidents_Ecrash, Fraudpoint3, Gong,
		GovData, Header, Header_Quick, InfoUSA, IRS5500, InfutorCID, Inquiry_AccLogs, LiensV2, LN_PropertyV2, MDR, Phonesplus_v2, Prof_License_Mari,
		Prof_LicenseV2, Relationship, Risk_Indicators, RiskView, RiskWise, SAM, SexOffender, STD, Suppress, Targus, thrive, USPIS_HotList, Utilfile, ut,
		VehicleV2, Watercraft, Watchdog, UCCV2, YellowPages;
/*
		[4:08 PM] Nicla, Laura (RIS-MIN)
		so... to tell if a key needs CCPA suppressions, a good starting place is to check if it has a global_sid
		field. If it does, then it probably needs to be suppressed. If it doesn't, it probably doesn't need to be
		suppressed (or can't currently be suppressed).

		[4:10 PM] Nicla, Laura (RIS-MIN)
		https://jira.rsi.lexisnexis.com/browse/CCPA-89 has the list of all the data packages the data team has
		updated for CCPA. Any key in one of those packages is fair game for suppression, so if it doesn't contain
		a global_sid field but is in one of those packages, it might need to be joined to another key to determine
		the suppressions.

*/

EXPORT Fn_MAS_FDC(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) Input_all,
									PublicRecords_KEL.Interface_Options Options,
									DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput = DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII),
									DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset_Mini = DATASET([], PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC)
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
	Common       := PublicRecords_KEL.ECL_Functions.Common(Options);
	CFG_File     := PublicRecords_KEL.CFG_Compile;
	Regulated    := PublicRecords_KEL.ECL_Functions.Constants.Regulated;
	NotRegulated := PublicRecords_KEL.ECL_Functions.Constants.NotRegulated;
	BlankString  := PublicRecords_KEL.ECL_Functions.Constants.BlankString;
	SetDPMBitmap := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue;
	Environment := IF(Options.IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA); // for CCPA Suppression calls

	IsMiniFDC := COUNT(FDCDataset_Mini) = 0; // If there weren't any records in the mini-fdc input, then this must be the mini fdc run.

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
	Set_Large_Cortera_SeleIDs := [1173819,1651059];

	FDCMiniPop := IF(IsMiniFDC, TRUE, FALSE);//Do we need to go get this data?

	Input_pre_override := Input_all((INTEGER)p_inpclnarchdt > 0); //inputs without contacts

	//if we have a mini fdc popualted here lets get this ready to use
	overridemini := project(FDCDataset_Mini, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII_Overrides,self := left; self := []));

	//get corrections early since we will need them for a lot of the FCRA datasets.
	//check to see if we need this or if we got this from the mini FDC.  we only should be calling to this once
	Input_getoverides:= IF(FDCMiniPop, PublicRecords_KEL.MAS_get.FCRA_Overrides(Options).GetOverrideFlags(Input_pre_override, FDCMiniPop), overridemini);

	SixthRepInput := Input_getoverides(RepNumber = 6);


	Input_pre := Input_getoverides(RepNumber <> 6);

	input :=	IF(NOT FDCMiniPop AND options.BestPIIAppend,
		Join(Input_pre, Input_pre_override,
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
							SELF.P_InpClnNameMid := right.P_InpClnNameMid,
							SELF.P_InpClnNameFirst := right.P_InpClnNameFirst,
							SELF.P_InpClnDOB := right.P_InpClnDOB,
							SELF := left,
							SELF := [])), Input_pre);


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
							SELF.P_InpClnNameMid := left.P_InpClnNameMid,
							SELF.P_InpClnNameFirst := left.P_InpClnNameFirst,
							SELF.P_InpClnDOB := left.P_InpClnDOB,
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
							SELF.P_InpClnNameMid := LEFT.P_InpClnNameMid,
							SELF.P_InpClnNameFirst := LEFT.P_InpClnNameFirst,
							SELF.P_InpClnDOB := LEFT.P_InpClnDOB,
							self := left;
							SELF := []), FULL OUTER );

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
				SELF.AddressGeoLink  := (trim(LEFT.P_InpClnAddrStateCode, left, right) + trim(left.P_InpClnAddrCnty, left, right) + trim(left.P_InpClnAddrGeo, left, right)),//inpclnaddrcnty is string6 but 3 digits so needs trimming				SELF.CityCode        := Doxie.Make_CityCode(LEFT.P_InpClnAddrCity), // doxie.Make_CityCodes(LEFT.InputCityClean).rox) ???
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
				SELF.AddressGeoLink  := (trim(LEFT.B_InpClnAddrStateCode, left, right) + trim(left.B_InpClnAddrCnty, left, right) + trim(left.B_InpClnAddrGeo, left, right)),//inpclnaddrcnty is string6 but 3 digits so needs trimming				SELF.CityCode        := Doxie.Make_CityCode(LEFT.P_InpClnAddrCity), // doxie.Make_CityCodes(LEFT.InputCityClean).rox) ???
				SELF := LEFT,
				SELF := []
			)
		);

		Previous_Address_Consumer_recs_pre :=
		PROJECT( Input_all,
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
				SELF.UIDAppend       := LEFT.G_ProcUID,
				SELF.PrimaryRange    := LEFT.previousaddrprimrng,
				SELF.Predirectional  := LEFT.previousaddrpredir,
				SELF.PrimaryName     := LEFT.previousaddrprimname,
				SELF.AddrSuffix      := LEFT.previousaddrsffx,
				SELF.Postdirectional := LEFT.PreviousAddrPostDir,
				// SELF.City            := LEFT.P_InpClnAddrCity,
				SELF.State           := LEFT.previousaddrstate,
				SELF.ZIP5            := LEFT.previousaddrzip5,
				SELF.SecondaryRange  := LEFT.previousaddrsecrng,
				SELF.AddressGeoLink  := (trim(LEFT.previousAddrStateCode, left, right) + trim(left.previousAddrCnty, left, right) + trim(left.previousAddrGeo, left, right)),//previousAddrCnty is string6 but 3 digits so needs trimming
				SELF := LEFT,
				SELF := []
			)
		);

Previous_Address_Consumer_recs := Previous_Address_Consumer_recs_pre((INTEGER)p_inpclnarchdt > 0);
Previous_Address_Consumer_recs_Contacts := Previous_Address_Consumer_recs_pre((INTEGER)p_inpclnarchdt = 0);

	Current_Address_Consumer_recs_pre :=
		PROJECT( Input_all,
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
				SELF.UIDAppend       := LEFT.G_ProcUID,
				SELF.PrimaryRange    := LEFT.currentaddrprimrng,
				SELF.Predirectional  := LEFT.currentaddrpredir,
				SELF.PrimaryName     := LEFT.currentaddrprimname,
				SELF.AddrSuffix      := LEFT.currentaddrsffx,
				SELF.Postdirectional := LEFT.CurrentAddrPostDir,
				// SELF.City            := LEFT.P_InpClnAddrCity,
				SELF.State           := LEFT.currentAddrState,
				SELF.ZIP5            := LEFT.currentaddrzip5,
				SELF.SecondaryRange  := LEFT.currentaddrsecrng,
				SELF.AddressGeoLink  := (trim(LEFT.currentAddrstateCode, left, right) + trim(left.currentAddrCnty, left, right) + trim(left.currentAddrGeo, left, right)),//currentAddrCnty is string6 but 3 digits so needs trimming
				SELF := LEFT,
				SELF := []
			)
		);

Current_Address_Consumer_recs := Current_Address_Consumer_recs_pre((INTEGER)p_inpclnarchdt > 0);
Current_Address_Consumer_recs_Contacts := Current_Address_Consumer_recs_pre((INTEGER)p_inpclnarchdt = 0);

		Emerging_Address_Consumer_recs :=
		PROJECT( Input,
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
				SELF.UIDAppend       := LEFT.G_ProcUID,
				SELF.PrimaryRange    := LEFT.Emergingaddrprimrng,
				SELF.Predirectional  := LEFT.Emergingaddrpredir,
				SELF.PrimaryName     := LEFT.Emergingaddrprimname,
				SELF.AddrSuffix      := LEFT.Emergingaddrsffx,
				SELF.Postdirectional := LEFT.EmergingAddrPostDir,
				// SELF.City            := LEFT.P_InpClnAddrCity,
				SELF.State           := LEFT.EmergingAddrState,
				SELF.ZIP5            := LEFT.Emergingaddrzip5,
				SELF.SecondaryRange  := LEFT.Emergingaddrsecrng,
				// SELF.AddressGeoLink  := (trim(LEFT.EmergingAddrStateCode, left, right) + trim(left.EmergingAddrCnty, left, right) + trim(left.EmergingAddrGeo, left, right)),//EmergingAddrCnty is string6 but 3 digits so needs trimming
				SELF := LEFT,
				SELF := []
			)
		);



	Input_Address_All_pre := (Input_Address_Consumer_recs + Input_Address_Business_recs)(PrimaryName != '' AND ZIP5 != '');
	Input_Address_All := dedup(sort(Input_Address_All_pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode);

	Combine_All_Address_Pre := (Previous_Address_Consumer_recs + Current_Address_Consumer_recs + Emerging_Address_Consumer_recs + Input_Address_All)( PrimaryName != '' AND ZIP5 != '');
	Combine_All_Address := dedup(sort(Combine_All_Address_Pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode);

	Input_Address_Previous_Pre := (Previous_Address_Consumer_recs + Input_Address_All)( PrimaryName != '' AND ZIP5 != '');
	Input_Address_Previous := dedup(sort(Input_Address_Previous_Pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode);

	Input_Address_Current_Pre := (Current_Address_Consumer_recs + Input_Address_All)( PrimaryName != '' AND ZIP5 != '');
	Input_Address_Current := dedup(sort(Input_Address_Current_Pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode);

	Input_Address_Emerging_Pre := (Emerging_Address_Consumer_recs + Input_Address_All)( PrimaryName != '' AND ZIP5 != '');
	Input_Address_Emerging := dedup(sort(Input_Address_Emerging_Pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode);

	Input_Address_Current_Previous_Pre := (Previous_Address_Consumer_recs + Current_Address_Consumer_recs + Input_Address_All)( PrimaryName != '' AND ZIP5 != '');
	Input_Address_Current_Previous := dedup(sort(Input_Address_Current_Previous_Pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode);

	Input_and_Contact_Current_Previous_Pre := (Input_Address_Current_Previous+Current_Address_Consumer_recs_Contacts+Previous_Address_Consumer_recs_Contacts)( PrimaryName != '' AND ZIP5 != '');
	Input_and_Contact_Current_Previous := dedup(sort(Input_and_Contact_Current_Previous_Pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode);


	Input_Phone_Consumer_recs :=
		NORMALIZE( Input, 2, // Consumer input can contain a homephone and a workphone
			TRANSFORM( Layouts_FDC.LayoutPhoneGeneric_inputs,
				SELF.UIDAppend := LEFT.G_ProcUID,
				SELF.Phone := CHOOSE( COUNTER, LEFT.P_InpClnPhoneHome, LEFT.P_InpClnPhoneWork),
				SELF := LEFT,
				SELF := []
			)
		);

	Input_Phone_Business_recs :=
		PROJECT( BusinessInput,
			TRANSFORM( Layouts_FDC.LayoutPhoneGeneric_inputs,
				SELF.UIDAppend := LEFT.G_ProcBusUID,
				SELF.Phone := LEFT.B_InpClnPhone,
				SELF := LEFT,
				SELF := []
			)
		);

	Input_Phone_All := (DEDUP(Input_Phone_Consumer_recs, Phone) + Input_Phone_Business_recs)(Phone != '');

    Input_Phone_Address_Combined_Recs :=
		NORMALIZE( Input, 2, // Consumer input can contain a homephone and a workphone
			TRANSFORM( Layouts_FDC.LayoutCombinedPhoneAddr,
				SELF.UIDAppend := LEFT.G_ProcUID,
				SELF.Phone := CHOOSE( COUNTER, LEFT.P_InpClnPhoneHome, LEFT.P_InpClnPhoneWork),
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

	//need to use did from fid key instead of plexid in case input address is valid but not tied to P_lexid
	InputLexidsTrans := project(Input_FDC, transform({unsigned6 did;}, self.did := left.P_LexID, self := []));
	InputLexids := SET((InputLexidsTrans), DID);





	// --------------------[ Contact records ]--------------------

	//check if we need to make a call to contacts or if we did this already
	Run_Contacts_Key := Common.DoFDCJoin_BIPV2_Build__kfetch_contact_linkids = TRUE AND FDCMiniPop;

//First call to contact key with business to get lexid's associated with businesses

	Temp_Bus_contact := PublicRecords_KEL.ecl_functions.DateSelector(IF(Run_Contacts_Key, PublicRecords_KEL.mas_get.Contact_LinkIDs(Input_FDC, PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID, linkingOptions, mod_access, PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,TRUE);

	// PublicRecords_KEL.ECL_Functions.Common_Functions.AppendSeq(BIPV2_Build__kfetch_contact_linkids, Input_FDC, Temp_Bus_contact, PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID);


	With_BIPV2_Build_contact_linkids := DENORMALIZE(Input_FDC, Temp_Bus_contact,
			FDCMiniPop AND
			LEFT.UIDAppend = RIGHT.UniqueID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2_Build__kfetch_contact_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BIPV2_Build__kfetch_contact_linkids,
																						self.P_LexID := left.contact_did,
																						self.UIDAppend := left.UniqueID,
																						self.g_procuid := left.UniqueID,
																						self.src := LEFT.Source, //many sources in business header
																						SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, Is_Business_Header := TRUE, Marketing_state := left.company_address.st, KELPermissions := CFG_File),
																						SELF.JobTitle := IF(TRIM(LEFT.contact_job_title_derived) != '', TRIM(LEFT.contact_job_title_derived), TRIM(LEFT.contact_job_title_raw)),//use derived if its populated else use raw
																						SELF.Status := IF(TRIM(LEFT.contact_status_derived) != '', TRIM(LEFT.contact_status_derived), TRIM(LEFT.contact_status_raw)),//use derived if its populated else use raw
																						self := left,
																						self := []));
					SELF := LEFT,
					SELF := []));

	With_BIPV2_Build_contact_linkids_From_Mini := JOIN(Input_FDC, FDCDataset_Mini,
			FDCMiniPop = FALSE AND
			LEFT.UIDAppend = RIGHT.UIDAppend and
			LEFT.g_procuid = RIGHT.g_procuid,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2_Build__kfetch_contact_linkids := Right.Dataset_BIPV2_Build__kfetch_contact_linkids,
					SELF := LEFT,
					SELF := []));

	Choose_BIPV2_Build_contact_linkids_Records := if(FDCMiniPop, With_BIPV2_Build_contact_linkids, With_BIPV2_Build_contact_linkids_From_Mini);

	//transform business contact into input layout and dedup
	Temp_Bus_contact_Second := project(Temp_Bus_contact, transform(Layouts_FDC.Layout_FDC, self.P_LexID := left.contact_did, self.UIDAppend := left.UniqueID, self.g_procuid := left.UniqueID, self := left, self := []));


	Layouts_FDC.Layout_FDC Normalize_Contacts(RecordOF(Layouts_FDC.Layout_FDC.Dataset_BIPV2_Build__kfetch_contact_linkids) ri, Layouts_FDC.Layout_FDC le) := TRANSFORM
		SELF := ri;
		SELF := le;
	END;

	FDCDataset_Mini_norm := normalize(FDCDataset_Mini, left.Dataset_BIPV2_Build__kfetch_contact_linkids, Normalize_Contacts(RIGHT,LEFT));

	temp_contacts_lexids := IF(FDCMiniPop,  Temp_Bus_contact_Second, FDCDataset_Mini_norm-Input_FDC);//if we already made a call to contacts in the miniFDC use that data.

	Filtered_contacts_Lexids := temp_contacts_lexids(P_LexID > 0);

	// Only keep 100 contacts per business for LexID searching to improve performance
	Business_Contact_LexIDs_Temp := DEDUP(SORT(Filtered_contacts_Lexids, UIDAppend, P_LexID), WHOLE RECORD);
	Business_Contact_LexIDs := DEDUP(Business_Contact_LexIDs_Temp, UIDAppend, KEEP(100));

	For_Lexid_Search := IF(Common.DoFDCJoinfn_IndexedSearchForXLinkIDs = TRUE, PROJECT(Business_Contact_LexIDs + Input_FDC, TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
				// Contatonation UIDAppend and P_LexID to form acctno when searching for businesses tied to a contact.
				SELF.acctno 			:= (STRING)LEFT.UIDAppend + ' ' + (STRING)LEFT.P_LexID,
				SELF.contact_did 	:= LEFT.P_LexID,
				SELF := [])));

	//after getting lexids use a different key to get all of the businesses these indidiuals are associated with
	Lookup_LinkIDs := PROJECT(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(For_Lexid_Search).uid_results_w_acct,
																			TRANSFORM(Layouts_FDC.Layout_FDC,
																								// split acocunt number back out into UIDAppend and LexID
																								SELF.UIDAppend := (INTEGER)STD.Str.GetNthWord(LEFT.acctno, 1),
																								SELF.P_LexID := (INTEGER)STD.Str.GetNthWord(LEFT.acctno, 2),
																								SELF.B_LexIDUlt := LEFT.UltID,
																								SELF.B_LexIDOrg := LEFT.OrgID,
																								SELF.B_LexIDLegal := LEFT.SeleID,
																								SELF.B_LexIDSite := LEFT.PowID,
																								SELF.B_LexIDLoc := LEFT.ProxID,
																								SELF := []));

      Lookup_And_Input_LinkIDs_Combined := JOIN(Input_FDC, Lookup_LinkIDs,
                                                                                        LEFT.P_LexID = RIGHT.P_LexID AND
                                                                                        LEFT.UIDAppend = RIGHT.UIDAppend,
                                                                                        TRANSFORM(RECORDOF(RIGHT),
                                                                                        SELF := LEFT,
                                                                                        SELF := RIGHT),
                                                                                        LEFT OUTER);

	Lookup_And_Input_LinkIDs := DEDUP(SORT(Lookup_And_Input_LinkIDs_Combined, UIDAppend, B_LexIDUlt, B_LexIDOrg, B_LexIDLegal), UIDAppend, B_LexIDUlt, B_LexIDOrg, B_LexIDLegal);

	//lets not run more records than we need to
	Unique_Raw_Lexid_Matches := DEDUP(SORT(Lookup_LinkIDs, UIDAppend, B_LexIDUlt, B_LexIDOrg, B_LexIDLegal, B_LexIDLoc, B_LexIDSite),	UIDAppend, B_LexIDUlt, B_LexIDOrg, B_LexIDLegal, B_LexIDLoc, B_LexIDSite);

	// Don't run a second search of the contact key by the input business, only search by LinkIDs that haven't already been searched.
	Unique_Raw_Lexid_Matches_Filtered := JOIN(Unique_Raw_Lexid_Matches, Input_FDC,
								LEFT.UIDAppend = RIGHT.UIDAppend AND
								(LEFT.B_LexIDUlt <> RIGHT.B_LexIDUlt OR
								LEFT.B_LexIDOrg <> RIGHT.B_LexIDOrg OR
								LEFT.B_LexIDLegal <> RIGHT.B_LexIDLegal),
					TRANSFORM(RECORDOF(LEFT),
								SELF := LEFT));

	//take businesses gathered with associated individuals and run these through contact key
	BIPV2_Build__kfetch_contact_linkids_with_seq :=
		PublicRecords_KEL.ecl_functions.DateSelector(IF(Common.DoFDCJoin_BIPV2_Build__kfetch_contact_linkids_slim = TRUE AND COUNT(Unique_Raw_Lexid_Matches_Filtered) < 200, PublicRecords_KEL.mas_get.Contact_Linkids(Unique_Raw_Lexid_Matches_Filtered, PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.PowID, linkingOptions, mod_access, PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,TRUE);

	Business_Contacts_slim := PROJECT(BIPV2_Build__kfetch_contact_linkids_with_seq, TRANSFORM(Layouts_FDC.Layout_BIPV2_Build__kfetch_contact_linkids_slim,
															SELF.UIDAppend := LEFT.UniqueID,
															SELF := LEFT,
															SELF := []));

	Business_Contacts_rolled := DEDUP(SORT(Business_Contacts_slim, UIDAppend, UltID, OrgID, SeleID, ProxID, contact_did, Source, dt_first_seen_contact, dt_last_seen_contact), UIDAppend, UltID, OrgID, SeleID, ProxID, contact_did, Source, dt_first_seen_contact, dt_last_seen_contact);

	//adding all reasults back together
	With_BIPV2_Build_contact_linkids_slim := DENORMALIZE(Choose_BIPV2_Build_contact_linkids_Records, Business_Contacts_rolled,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2_Build__kfetch_contact_linkids_slim := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BIPV2_Build__kfetch_contact_linkids_slim,
																						self.src := LEFT.Source, //many sources in business header
																						SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, Is_Business_Header := TRUE, Marketing_state := left.company_address.st, KELPermissions := CFG_File),
																						self := left,
																						self := []));
					SELF := LEFT,
					SELF := []));

	//transform business contact into input layout and dedup

	Input_Plus_Contacts := Input_FDC + Business_Contact_LexIDs;

	Clean_Input_Plus_Contacts := DEDUP(SORT(Input_Plus_Contacts, UIDAppend, P_LexID), UIDAppend, P_LexID);



BIPV2.IDAppendLayouts.AppendInput PrepBIPInputsele(Layouts_FDC.Layout_FDC le) := TRANSFORM
		SELF.request_id := le.G_ProcBusUID;
		SELF.seleid := le.B_LexIDLegal;
		SELF := [];
	END;

BIPV2.IDAppendLayouts.AppendInput PrepBIPInputprox(Layouts_FDC.Layout_FDC le) := TRANSFORM
		SELF.request_id := le.G_ProcBusUID;
		SELF.proxid := le.B_LexIDLoc;
		SELF.seleid := le.B_LexIDLegal;
		SELF := [];
	END;

	BIPBestInputsele := PROJECT(Input_FDC(B_LexIDLegal > 0), PrepBIPInputsele(LEFT));
	BIPBestInputprox := PROJECT(Input_FDC(B_LexIDLoc > 0 AND B_LexIDLegal > 0), PrepBIPInputprox(LEFT));

	BIP_Best_Records_Raw_sele := IF(Common.DoFDCJoin_BIPV2_Best__Key_LinkIds,
										BIPV2.IdAppendRoxie(BIPBestInputsele, ReAppend := FALSE).WithBest(
												fetchLevel := BIPV2.IdConstants.fetch_level_seleid,
												allBest := False,
												isMarketing := Options.isMarketing));

		BIP_Best_Records_Raw_Prox := IF(Common.DoFDCJoin_BIPV2_Best__Key_LinkIds,
										BIPV2.IdAppendRoxie(BIPBestInputprox, ReAppend := FALSE).WithBest(
												fetchLevel := BIPV2.IdConstants.Fetch_Level_ProxID,
												allBest := False,
												isMarketing := Options.isMarketing));

	BIP_Best_Records_Raw := 	BIP_Best_Records_Raw_sele+ BIP_Best_Records_Raw_Prox;


	BIP_Best_Records := PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, BIP_Best_Records_Raw,
		LEFT.G_ProcBusUID = RIGHT.Request_ID,
		TRANSFORM(Layouts_FDC.Layout_BIPV2_Best__Key_LinkIds,
				SELF.G_ProcBusUID := LEFT.G_ProcBusUID,
				SELF.B_LexIDUlt := LEFT.B_LexIDUlt,
				SELF.B_LexIDOrg := LEFT.B_LexIDOrg,
				SELF.B_LexIDLegal := LEFT.B_LexIDLegal,
				SELF.Company_SIC_Code1 := CleanSIC(RIGHT.Company_SIC_Code1),
				SELF.Company_NAICS_Code1 := CleanNAIC(RIGHT.Company_NAICS_Code1),
				SELF.Src := MDR.sourceTools.src_Best_Business,
				SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, BIPBitMask := CFG_File.Permit_NonFCRA),
				SELF := RIGHT,
				SELF := [])),FALSE,FALSE);

	With_BIP_Best_Records := DENORMALIZE(With_BIPV2_Build_contact_linkids_slim, BIP_Best_Records,
			LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID AND
			LEFT.B_LexIDUlt = RIGHT.B_LexIDUlt AND
			LEFT.B_LexIDOrg = RIGHT.B_LexIDOrg AND
			LEFT.B_LexIDLegal = RIGHT.B_LexIDLegal, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2_Best__Key_LinkIds := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));


	Best_Sele_Address_Clean := 	Project(BIP_Best_Records(Proxid = 0), transform(Layouts_FDC.LayoutAddressGeneric_inputs,
																SELF.UIDAppend       := LEFT.G_ProcBusUID,
																SELF.PrimaryRange    := LEFT.prim_range,
																SELF.Predirectional  := LEFT.predir,
																SELF.PrimaryName     := LEFT.prim_name,
																SELF.AddrSuffix      := LEFT.addr_suffix,
																SELF.Postdirectional := LEFT.postdir,
																SELF.City            := LEFT.p_city_name,
																SELF.State           := LEFT.st,
																SELF.ZIP5            := LEFT.zip,
																SELF.SecondaryRange  := LEFT.sec_range,
																SELF.CityCode        := Doxie.Make_CityCode(LEFT.p_city_name),
																SELF := LEFT,
																SELF := []
															)
														);


	Input_and_Best_Address := sort(Dedup(Input_Address_All + Best_Sele_Address_Clean(PrimaryName != '' AND ZIP5 != ''),
																				PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, UIDAppend),
																						PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, UIDAppend);

	// Input consumer + businses address, best business Sele address, previous and current address for input person
	Input_Address_BusBest_Current_Previous_Pre := (Input_Address_All + Best_Sele_Address_Clean + Previous_Address_Consumer_recs + Current_Address_Consumer_recs)( PrimaryName != '' AND ZIP5 != '');
	Input_Address_BusBest_Current_Previous := dedup(sort(Input_Address_BusBest_Current_Previous_Pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode);

	Layouts_FDC.Layout_ConsumerStatementFlags Normalize_(RECORDOF(Input) le, RECORDOF(Input.ConsumerStatements) ri) := TRANSFORM
						SELF.Timestamp := ri.Timestamp;
						SELF.UIDAppend := le.G_ProcUID;
						SELF.corrected_flag := le.ConsumerFlags.corrected_flag;
						SELF.consumer_statement_flag := le.ConsumerFlags.consumer_statement_flag;
						SELF.dispute_flag := le.ConsumerFlags.dispute_flag;
						SELF.security_freeze := le.ConsumerFlags.security_freeze;
						SELF.negative_alert := le.ConsumerFlags.negative_alert;
						SELF.id_theft_flag := le.ConsumerFlags.id_theft_flag;
						SELF.legal_hold_alert := le.ConsumerFlags.legal_hold_alert;
						SELF.datefirstseen := (string)ri.Timestamp.year +
																				if(length((STRING)ri.Timestamp.month) = 1, ('0'+(STRING)ri.Timestamp.month), (STRING)ri.Timestamp.month)+
																				if(length((STRING)ri.Timestamp.day) = 1, ('0'+(STRING)ri.Timestamp.day), (STRING)ri.Timestamp.day);
						SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.PersonContext;
						SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
						SELF := ri;
						self := le;
					self := [];
				END;

	ConsumerStatementFlags_Norm :=PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(Input, LEFT.ConsumerStatements, Normalize_(LEFT, RIGHT)),  false, false);

 	ConsumerStatementFlags_Norm_Mini := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_ConsumerStatementFlags, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));


	ConsumerStatementFlags := if(FDCMiniPop, ConsumerStatementFlags_Norm, ConsumerStatementFlags_Norm_Mini);

	With_ConsumerStatementFlags := DENORMALIZE(With_BIP_Best_Records, ConsumerStatementFlags,
				LEFT.UIDAppend = RIGHT.UIDAppend AND
				LEFT.g_procuid = RIGHT.g_procuid AND
				LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_ConsumerStatementFlags := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// Doxie_Files.Key_BocaShell_Crim_FCRA -- FCRA only
	Doxie_Files__Key_BocaShell_Crim_FCRA_Records :=
		PublicRecords_KEL.ecl_functions.DateSelector( JOIN(Input_FDC, Doxie_Files.Key_BocaShell_Crim_FCRA,
				Common.DoFDCJoin_Doxie_Files__Key_BocaShell_Crim_FCRA = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.DID),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_BocaShell_Crim_FCRA_Denorm,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	// Doxie_Files.Key_BocaShell_Crim_FCRA contains a child dataset so we need to add an extra step and NORMALIZE it before adding to the FDC bundle.
	Doxie_Files__Key_BocaShell_Crim_FCRA_Records_Norm := NORMALIZE(Doxie_Files__Key_BocaShell_Crim_FCRA_Records, LEFT.criminal_count,
			TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_BocaShell_Crim_FCRA,
								SELF := LEFT,
								SELF := RIGHT));

	// With_Doxie_Files__Key_BocaShell_Crim_FCRA := DENORMALIZE(With_BIP_Best_Records, Doxie_Files__Key_BocaShell_Crim_FCRA_Records_Norm,
	With_Doxie_Files__Key_BocaShell_Crim_FCRA := DENORMALIZE(With_ConsumerStatementFlags, Doxie_Files__Key_BocaShell_Crim_FCRA_Records_Norm,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// Doxie_Files.Key_Offenders(isFCRA) --	FCRA and NonFCRA
	Doxie_Files__Key_Offenders_Records :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Clean_Input_Plus_Contacts, Doxie_Files.Key_Offenders(Options.isFCRA),
				Common.DoFDCJoin_Doxie_Files__Key_Offenders = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.sdid),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenders,
					_src := Doxie_Files__Key_Offenders_Src(RIGHT.data_type);
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.data_type := IF( Options.isFCRA = TRUE, RIGHT.data_type, '' ), // populate only if using the FCRA key
					SELF.src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

		WithSuppressionsCrimOffenders := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																				Doxie_Files__Key_Offenders_Records(offender_key NOT IN crim_correct_ofk),
																				Doxie_Files__Key_Offenders_Records);

		GetOverrideCrimOffenders := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Doxie_Files__Key_Offenders = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideCrimOffenders(input_fdc));//consumer only since FCRA only -- no business in FCRA

		WithCorrectionsCrimOffenders := WithSuppressionsCrimOffenders+GetOverrideCrimOffenders;



	With_Doxie_Files__Key_Offenders := DENORMALIZE(With_Doxie_Files__Key_BocaShell_Crim_FCRA, WithCorrectionsCrimOffenders,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenders := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// Doxie_files.Key_Court_Offenses -- FCRA only (even though nonFCRA version of key exists)
	// Doxie_files.Key_Court_Offenses does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_FCRA_Records so we can join by offender key
	Doxie_files__Key_Court_Offenses_Records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(WithCorrectionsCrimOffenders, Doxie_files.Key_Court_Offenses(isFCRA := Options.isFCRA),
				Common.DoFDCJoin_Doxie_files__Key_Court_Offenses = TRUE AND
				KEYED(LEFT.offender_key = RIGHT.ofk),
				TRANSFORM(Layouts_FDC.Layout_Doxie_files__Key_Court_Offenses,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Accurint_Crim_Court,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_Crim_Court, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

		WithSuppressionsCrimCourt := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																		Doxie_files__Key_Court_Offenses_Records(offender_key NOT IN crim_correct_ofk),
																		Doxie_files__Key_Court_Offenses_Records);

		GetOverrideCrimCourt := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Doxie_files__Key_Court_Offenses = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideCrimCourt(input_fdc));//consumer only since FCRA only -- no business in FCRA

		WithCorrectionsCrimCourt := WithSuppressionsCrimCourt+GetOverrideCrimCourt;


	With_Doxie_files__Key_Court_Offenses := DENORMALIZE(With_Doxie_Files__Key_Offenders, WithCorrectionsCrimCourt,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_files__Key_Court_Offenses := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// Doxie_Files.Key_Offenses -- FCRA only (even though nonFCRA version of key exists)
	// Doxie_files.Key_Offenses does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_Records so we can join by offender key
	Doxie_Files__Key_Offenses_Records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(WithCorrectionsCrimOffenders, Doxie_Files.Key_Offenses(isFCRA := Options.isFCRA),
				Common.DoFDCJoin_Doxie_Files__Key_Offenses = TRUE AND
				KEYED(LEFT.offender_key = RIGHT.ok),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenses,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

		WithSuppressionsCrimOffenses := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																		Doxie_Files__Key_Offenses_Records(offender_key NOT IN crim_correct_ofk),
																		Doxie_Files__Key_Offenses_Records);

		GetOverrideCrimOffenses := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Doxie_Files__Key_Offenses = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideCrimOffenses(input_fdc));//consumer only since FCRA only -- no business in FCRA

		WithCorrectionsCrimOffenses := WithSuppressionsCrimOffenses+GetOverrideCrimOffenses;

	With_Doxie_Files__Key_Offenses := DENORMALIZE(With_Doxie_files__Key_Court_Offenses, WithCorrectionsCrimOffenses,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenses := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// Doxie_Files.Key_Offenders_Risk -- NonFCRA only
	Doxie_Files__Key_Offenders_Risk_Records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Clean_Input_Plus_Contacts, Doxie_Files.Key_Offenders_Risk,
				Common.DoFDCJoin_Doxie_Files__Key_Offenders_Risk = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.sdid),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenders_Risk,
					_src := Doxie_Files__Key_Offenders_Src(RIGHT.data_type);
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_Doxie_Files__Key_Offenders_Risk := DENORMALIZE(With_Doxie_Files__Key_Offenses, Doxie_Files__Key_Offenders_Risk_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenders_Risk := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// Doxie_Files.Key_Punishment -- NonFCRA only (even though FCRA version of key exists)
	// Doxie_Files.Key_Punishment does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_Records so we can join by offender key
	Doxie_Files__Key_Punishment_Records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Doxie_Files__Key_Offenders_Records, Doxie_Files.Key_Punishment(isFCRA := Options.isFCRA),
				Common.DoFDCJoin_Doxie_Files__Key_Punishment = TRUE AND
				KEYED(LEFT.offender_key = RIGHT.ok),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Punishment,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_Doxie_Files__Key_Punishment := DENORMALIZE(With_Doxie_Files__Key_Offenders_Risk, Doxie_Files__Key_Punishment_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Punishment := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// --------------------[ Bankruptcy records ]--------------------

	// BankruptcyV3.key_bankruptcyV3_did has a parameter to say if FCRA or nonFCRA - same file layout
	Bankruptcy_Files__Key_bankruptcy_did_Records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Clean_Input_Plus_Contacts, BankruptcyV3.key_bankruptcyV3_did(Options.isFCRA),
				Common.DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Bankruptcy__Key_did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	// BankruptcyV3.key_bankruptcyv3_search_full_bip has a parameter to say if FCRA or nonFCRA - same file layout
	Bankruptcy_Files__Key_Search_Records_pre :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Bankruptcy_Files__Key_bankruptcy_did_Records, BankruptcyV3.key_bankruptcyv3_search_full_bip(Options.isFCRA),
				Common.DoFDCJoin_Bankruptcy_Files__Bankruptcy__Key_Search = TRUE AND
				KEYED(LEFT.TmsID != '' AND
				LEFT.TmsID = RIGHT.TmsID) AND
				LEFT.court_code = RIGHT.court_code AND
				LEFT.case_number = RIGHT.case_number,
				TRANSFORM(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Bankruptcy,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Bankruptcy, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	// Left Only join to the Bankruptcy Withdrawn key to remove all Withdrawn records.
	Bankruptcy_Files__Key_Search_Records :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Bankruptcy_Files__Key_Search_Records_pre, BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,Options.IsFCRA),
				Common.DoFDCJoin_Bankruptcy_Files__Bankruptcy__Key_Search = TRUE AND
				KEYED(LEFT.TmsID = RIGHT.TmsID),
				TRANSFORM(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := LEFT,
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT),
				LEFT ONLY),FALSE,FALSE);

	WithSuppressionsBankruptcySEARCH := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												Bankruptcy_Files__Key_Search_Records(TRIM(tmsid) + TRIM(name_type)+ did NOT IN bankrupt_correct_cccn),
												Bankruptcy_Files__Key_Search_Records);

	GetBankoRemoveRecsOverrides := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
															WithSuppressionsBankruptcySEARCH((TRIM(court_code) + TRIM(case_number) NOT IN bankrupt_correct_RECORD_ID)),
															WithSuppressionsBankruptcySEARCH);//pull out corrected records since this requires different searching
																//checked in the override key and the search key, all of the date_filed fields are identical so it appears records with identical court code/case number do not get updated

	GetOverrideBankruptcy := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Bankruptcy_Files__Bankruptcy__Key_Search = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideBanko(Input_FDC));//consumer only since FCRA only -- no business in FCRA


	WithCorrectionsBankruptcy := GetBankoRemoveRecsOverrides+GetOverrideBankruptcy;

	With_Bankruptcy :=
		DENORMALIZE(With_Doxie_Files__Key_Punishment,WithCorrectionsBankruptcy,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Bankruptcy_Files__Key_Search := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	Bankruptcy_Files__Linkids_Key_Search := IF(Common.DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search = TRUE,
										BankruptcyV3.key_bankruptcyV3_linkids.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
										PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
										0, /*ScoreThreshold --> 0 = Give me everything*/
										PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
										BIPV2.IDconstants.JoinTypes.LimitTransformJoin));

	Bankruptcy_Files__Key_Linkid_Records :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Bankruptcy_Files__Linkids_Key_Search, BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,Options.IsFCRA),
				Common.DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search = TRUE AND
				KEYED(LEFT.TmsID = RIGHT.TmsID),
				TRANSFORM(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyV3_linkids_Key,
					SELF.UIDAppend := LEFT.UniqueID,
					SELF.ULTID := LEFT.ULTID,
					SELF.ORGID := LEFT.ORGID,
					SELF.SELEID := LEFT.SELEID,
					SELF := LEFT,
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT),
				LEFT ONLY),FALSE,FALSE);

		With_Business_Bankruptcy :=
		DENORMALIZE(With_Bankruptcy,Bankruptcy_Files__Key_Linkid_Records,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Bankruptcy_Files__Linkids_Key_Search := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyV3_linkids_Key,
															SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Bankruptcy, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
															SELF.Src := MDR.sourceTools.src_Bankruptcy,
															SELF := LEFT,
															SELF := []));
						SELF := LEFT,
						SELF := []));

	// --------------------[ Aircraft records ]--------------------

	// FAA.key_aircraft_did has a parameter to say if FCRA or nonFCRA - same file layout
	Key_Aircraft_did_Records := //	Not in Uses, no dates being mapped does not need DateSelector
			JOIN(Input_FDC, FAA.key_aircraft_did(Options.isFCRA),
				Common.DoFDCJoin_Aircraft_Files__FAA__Aircraft_did = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_FAA__key_aircraft_did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));


	// FAA.key_aircraft_id has a parameter to say if FCRA or nonFCRA - same file layout
	Key_Aircraft_ID_Records :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Key_Aircraft_did_Records, FAA.key_aircraft_id(Options.isFCRA),
				Common.DoFDCJoin_Aircraft_Files__FAA__Aircraft_ID = TRUE AND
				KEYED(LEFT.aircraft_id != 0 AND
				LEFT.aircraft_id = RIGHT.aircraft_id),
				TRANSFORM(Layouts_FDC.Layout_FAA__key_aircraft_id,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Aircrafts,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Aircrafts, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsAircraft := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																	Key_Aircraft_ID_Records((string)persistent_record_id not in air_correct_record_id ),
																	Key_Aircraft_ID_Records);

	//if there are corrections lets go find them
	GetOverrideAircraft := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Aircraft_Files__FAA__Aircraft_ID = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideAircraft(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsAircraft := WithSuppressionsAircraft+GetOverrideAircraft;



	With_Aircraft_ID_Records := DENORMALIZE(With_Business_Bankruptcy, WithCorrectionsAircraft,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_FAA__Key_Aircraft_IDs := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));


	// --------------------[ Watercraft records ]--------------------

	// Watercraft.key_watercraft_did has a parameter to say if FCRA or nonFCRA - same file layout
	Key_Watercraft_did_Records := //	Not in Uses, no dates being mapped does not need DateSelector
			JOIN(Input_FDC, Watercraft.key_watercraft_did(Options.isFCRA),
				Common.DoFDCJoin_Watercraft_Files__Watercraft_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.l_did),
				TRANSFORM(Layouts_FDC.Layout_Watercraft__key_watercraft_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	// Watercraft.key_watercraft_sid has a parameter to say if FCRA or nonFCRA - same file layout
	//
	// See WatercraftV2_Services.get_owner_records for other possible Join restrictions/criteria.
	//

	Key_Watercraft_sid_Records_unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Key_Watercraft_did_Records, Watercraft.key_watercraft_sid(Options.isFCRA),
					Common.DoFDCJoin_Watercraft_Files__Watercraft_SID = TRUE AND
					KEYED(LEFT.watercraft_key = RIGHT.watercraft_key) AND
					KEYED(LEFT.sequence_key = '' OR LEFT.sequence_key = RIGHT.sequence_key) AND
					KEYED(LEFT.state_origin = '' OR LEFT.state_origin = RIGHT.state_origin),
				TRANSFORM(Layouts_FDC.Layout_Watercraft__Key_Watercraft_SID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.fWatercraft(right.source_Code, right.state_origin);
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := DPPARegulatedWaterCraftRecord(RIGHT.dppa_flag), DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_Watercraft_sid_Records := Suppress.MAC_SuppressSource(Key_Watercraft_sid_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsWatercraft := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												Key_Watercraft_sid_Records((string)persistent_record_id not in water_correct_RECORD_ID),
												Key_Watercraft_sid_Records);

	//if there are corrections lets go find them
	GetOverrideWatercraft := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Watercraft_Files__Watercraft_SID = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideWatercraft(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsWatercraft := WithSuppressionsWatercraft+GetOverrideWatercraft;

	With_Watercraft_Records := DENORMALIZE(With_Aircraft_ID_Records, WithCorrectionsWatercraft,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Watercraft__Key_Watercraft_SID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	// --------------------[ ProfessionalLicense records ]--------------------
	// Prof_LicenseV2.Key_Proflic_Did has a parameter to say if FCRA or nonFCRA - same file layout
	Prof_LicenseV2__Key_Proflic_Did_Records_unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Prof_LicenseV2.Key_Proflic_Did(Options.IsFCRA),
				Common.DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Prof_LicenseV2__Key_Proflic_Did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Prof_LicenseV2__Key_Proflic_Did_Records := Suppress.MAC_SuppressSource(Prof_LicenseV2__Key_Proflic_Did_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsProfLic := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																Prof_LicenseV2__Key_Proflic_Did_Records(trim((string)prolic_key) not in proflic_correct_RECORD_ID),
																Prof_LicenseV2__Key_Proflic_Did_Records);

	//if there are corrections lets go find them
	GetOverrideProfLic := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideProfLic(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsProfLic := WithSuppressionsProfLic+GetOverrideProfLic;

	// Append Occupation and Category data to Proflic DID key Records by joining to Prof_LicenseV2.Key_LicenseType_lookup.
	// Prof_LicenseV2.Key_LicenseType_lookup has a parameter to say if FCRA or nonFCRA - same file layout
	Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(WithCorrectionsProfLic, Prof_LicenseV2.Key_LicenseType_lookup(Options.IsFCRA),
					Common.DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did = TRUE AND
					KEYED(LEFT.License_Type = RIGHT.License_Type) AND
					TRIM(RIGHT.License_Type) <> '',
				TRANSFORM(Layouts_FDC.Layout_Prof_LicenseV2__Key_Proflic_Did,
					SELF.Cleaned_License_Number := PublicRecords_KEL.ECL_Functions.Fn_Strip_Leading_Zeros(LEFT.license_number);
					SELF.Src := MDR.sourceTools.src_Professional_License;
					SELF.Occupation := RIGHT.Occupation,
					SELF.Category := RIGHT.Category,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Professional_License, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Generic_Restriction := LEFT.vendor = RiskView.Constants.directToConsumerPL_sources),
					SELF := LEFT,
					SELF := []),
				LEFT OUTER, ATMOST(100), KEEP(1)),FALSE,FALSE);

	With_Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records := DENORMALIZE(With_Watercraft_Records, Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records,
      LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
      TRANSFORM(Layouts_FDC.Layout_FDC,
          SELF.Dataset_Prof_LicenseV2__Key_Proflic_Did := ROWS(RIGHT),
          SELF := LEFT,
          SELF := []));

	// Prof_License_Mari.Key_Did has a parameter to say if FCRA or nonFCRA - same file layout
	Prof_License_Mari__Key_Did_Records_unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Prof_License_Mari.Key_Did(Options.IsFCRA),
				Common.DoFDCJoin_Prof_License_Mari__Key_Did = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_Prof_License_Mari__Key_Did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Prof_License_Mari__Key_Did_Records := Suppress.MAC_SuppressSource(Prof_License_Mari__Key_Did_Records_unsuppressed, mod_access, did_field := s_did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsMari := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																Prof_License_Mari__Key_Did_Records(trim((string)persistent_record_id) not in proflic_correct_RECORD_ID),
																Prof_License_Mari__Key_Did_Records);

	//if there are corrections lets go find them
	GetOverrideMari := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Prof_License_Mari__Key_Did = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideMari(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsMari := WithSuppressionsMari+GetOverrideMari;

	// Append Occupation and Category data to Proflic Mari DID records by joining to Prof_LicenseV2.Key_LicenseType_lookup.
	// Prof_LicenseV2.Key_LicenseType_lookup has a parameter to say if FCRA or nonFCRA - same file layout
	Prof_License_Mari__Key_Did_LicenseType_Lookup_Records :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(WithCorrectionsMari, Prof_LicenseV2.Key_LicenseType_lookup(Options.IsFCRA),
					Common.DoFDCJoin_Prof_License_Mari__Key_Did = TRUE AND
					KEYED(LEFT.std_license_desc = RIGHT.License_Type) AND
					TRIM(RIGHT.License_Type) <> '',
				TRANSFORM(Layouts_FDC.Layout_Prof_License_Mari__Key_Did,
					SELF.type_cd := CASE(LEFT.type_cd,
						'GR' => 'Y',
						'MD' => 'N',
						'');
					SELF.Cleaned_License_Number := PublicRecords_KEL.ECL_Functions.Fn_Strip_Leading_Zeros(LEFT.license_nbr);
					SELF.Src := MDR.sourceTools.src_Mari_Prof_Lic;
					SELF.Occupation := RIGHT.Occupation,
					SELF.Category := RIGHT.Category,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Mari_Prof_Lic, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Generic_Restriction := LEFT.std_source_upd IN Risk_Indicators.iid_constants.restricted_Mari_vendor_set),
					SELF := LEFT,
					SELF := []),
				LEFT OUTER, ATMOST(100), KEEP(1)),FALSE,FALSE);

	With_Prof_License_Mari__Key_Did_LicenseType_Lookup_Records := DENORMALIZE(With_Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records, Prof_License_Mari__Key_Did_LicenseType_Lookup_Records,
      LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
      TRANSFORM(Layouts_FDC.Layout_FDC,
          SELF.Dataset_Prof_License_Mari__Key_Did := ROWS(RIGHT),
          SELF := LEFT,
          SELF := []));

	// --------------------[ Emails ]--------------------

	Key_Email_Data__Key_DID :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Clean_Input_Plus_Contacts, dx_Email.Key_Did(Options.isFCRA),
					Common.DoFDCJoin_Email_Data__Key_DID = TRUE AND
					LEFT.P_LexID > 0 AND
					KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Email_Data__Key_Email_Temp,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_Email_Data__Key_Email_Address :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, dx_Email.Key_Email_Address(),
					Common.DoFDCJoin_Email_Data__Key_Email_Address = TRUE AND
					LEFT.P_InpClnEmail <> '' AND
					KEYED(LEFT.P_InpClnEmail = RIGHT.clean_email),
				TRANSFORM(Layouts_FDC.Email_Data__Key_Email_Temp,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_DX_Email__Key_Email_Payload_Full := Key_Email_Data__Key_DID + Key_Email_Data__Key_Email_Address;

	Key_DX_Email__Key_Email_Payload_DID_unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Key_DX_Email__Key_Email_Payload_Full, DX_Email.Key_Email_Payload(Options.isFCRA),
					Common.DoFDCJoin_DX_Email__Key_Email_Payload = TRUE AND
					KEYED(LEFT.email_rec_key = RIGHT.email_rec_key),
				TRANSFORM(Layouts_FDC.Layout_DX_Email__Key_Email_Payload,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Email_SRC,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Email_SRC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_DX_Email__Key_Email_Payload_DID := Suppress.MAC_SuppressSource(Key_DX_Email__Key_Email_Payload_DID_unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Email_Payload_Records := DENORMALIZE(With_Prof_License_Mari__Key_Did_LicenseType_Lookup_Records, Key_DX_Email__Key_Email_Payload_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DX_Email__Key_Email_Payload := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Key_Email_Data__Key_Did_FCRA :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Email_Data.Key_Did_FCRA,
					Common.DoFDCJoin_Email_Data__Key_Did_FCRA = TRUE AND
					LEFT.P_LexID > 0 AND
					KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Email_Data__Key_Did_FCRA,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Email_SRC,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsEmail := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																Key_Email_Data__Key_Did_FCRA((string100)email_rec_key not in email_data_correct_record_id),
																Key_Email_Data__Key_Did_FCRA);

	//if there are corrections lets go find them
	GetOverrideEmail := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Email_Data__Key_Did_FCRA = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideEmail(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsEmail := WithSuppressionsEmail+GetOverrideEmail;

	With_Email_Data__Key_Did_FCRA_Records := DENORMALIZE(With_Email_Payload_Records, WithCorrectionsEmail,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Email_Data__Key_Did_FCRA := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));



	// --------------------[ Business Header records ]--------------------

		Business_Header_Key_Linking := IF(Common.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids = TRUE,
																							PublicRecords_KEL.ecl_functions.DateSelector(BIPV2.Key_BH_Linking_Ids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Lookup_And_Input_LinkIDs),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									linkingOptions,
																									PublicRecords_KEL.ECL_Functions.Constants.Business_Header_LIMIT,
																									FALSE, /* dnbFullRemove */
																									TRUE, /* bypassContactSuppression */
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin,
																									mod_access := mod_access),FALSE,TRUE));

	With_Business_Header_Key_Linking := DENORMALIZE(With_Email_Data__Key_Did_FCRA_Records, Business_Header_Key_Linking,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2__Key_BH_Linking_kfetch2 := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BIPV2__Key_BH_Linking_kfetch2,
																											SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(Left.Source, 0, Left.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(Left.source), Is_Business_Header := TRUE, Marketing_state := left.st, KELPermissions := CFG_File),
																											SELF.sele_gold_boolean := LEFT.sele_gold = 'G';
																											SELF.is_sele_level_boolean := (BOOLEAN)LEFT.is_sele_level;
																											SELF.is_org_level_boolean := (BOOLEAN)LEFT.is_org_level;
																											SELF.is_ult_level_boolean := (BOOLEAN)LEFT.is_ult_level;
																											SELF.iscorp_boolean := LEFT.iscorp = 'T';
																											SELF.company_sic_code1 := CleanSIC(LEFT.company_sic_code1);
																											SELF.company_sic_code2 := CleanSIC(LEFT.company_sic_code2);
																											SELF.company_sic_code3 := CleanSIC(LEFT.company_sic_code3);
																											SELF.company_sic_code4 := CleanSIC(LEFT.company_sic_code4);
																											SELF.company_sic_code5 := CleanSIC(LEFT.company_sic_code5);
																											SELF.company_naics_code1 := CleanNAIC(LEFT.company_naics_code1);
																											SELF.company_naics_code2 := CleanNAIC(LEFT.company_naics_code2);
																											SELF.company_naics_code3 := CleanNAIC(LEFT.company_naics_code3);
																											SELF.company_naics_code4 := CleanNAIC(LEFT.company_naics_code4);
																											SELF.company_naics_code5 := CleanNAIC(LEFT.company_naics_code5);
																											self.src := Left.source, //many sources in business header
																											self := left,
																											self := []));
					SELF := LEFT,
					SELF := []));

	Associated_Business_Address := PROJECT(Business_Header_Key_Linking, TRANSFORM(Layouts_FDC.LayoutAddressGeneric_inputs,
																					SELF.UIDAppend      	:= LEFT.UniqueID,
																					SELF.PrimaryRange  		:= LEFT.prim_range_derived,
																					SELF.Predirectional 	:= LEFT.predir,
																					SELF.PrimaryName			:= LEFT.prim_name_derived,
																					SELF.AddrSuffix				:= LEFT.addr_suffix,
																					SELF.Postdirectional	:= LEFT.postdir,
																					SELF.City							:= LEFT.p_city_name,
																					SELF.State						:= LEFT.st,
																					SELF.ZIP5							:= LEFT.zip,
																					SELF.SecondaryRange		:= LEFT.sec_range,
																					SELF.CityCode        	:= Doxie.Make_CityCode(LEFT.p_city_name),
																					SELF := LEFT,
																					SELF := []));

	//Include associated business address by Seleid to get additional address info
	Input_Best_and_Business_Address := DEDUP(SORT(Input_and_Best_Address + Associated_Business_Address,
																				PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, UIDAppend),
																						PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, UIDAppend);

	// ----------[ Address (LexID match: consumer; Address match: consumer or business) ]----------


	// DNM: consumer address only; use consumer address data
	Key_DNM_Name_Address_Records := //	Key has no dates does not need DateSelector
		JOIN(Input_Address_All, DMA.Key_DNM_Name_Address,
				Common.DoFDCJoin_DMA__Key_DNM_Name_Address = TRUE AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND
				KEYED(LEFT.PrimaryName = RIGHT.l_prim_name AND
					LEFT.PrimaryRange = RIGHT.l_prim_range AND
					LEFT.State = RIGHT.l_st AND
					LEFT.ZIP5 = RIGHT.l_zip AND
					LEFT.SecondaryRange = RIGHT.l_sec_range AND
					WILD(RIGHT.l_city_code)),
				TRANSFORM(Layouts_FDC.Layout_DMA__Key_DNM_Name_Address,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.DoNotMail,
					SELF.DPMBitmap := SetDPMBitmap( Source := BlankString, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_DNM_Name_Address_Records := DENORMALIZE(With_Business_Header_Key_Linking, Key_DNM_Name_Address_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DMA__Key_DNM_Name_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	// FP: consumer address only; use consumer address data
	Key_Fraudpoint3_Address_Records := //	Key has no dates does not need DateSelector
		JOIN(Input_Address_All, Fraudpoint3.Key_Address,
				Common.DoFDCJoin_Fraudpoint3__Key_Address = TRUE AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND
				KEYED(LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.SecondaryRange = RIGHT.sec_range),
				TRANSFORM(Layouts_FDC.Layout_Fraudpoint3__Key_Address,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.FraudPoint3Source,
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.FraudPoint3Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_Fraudpoint3_Address_Records := DENORMALIZE(With_DNM_Name_Address_Records, Key_Fraudpoint3_Address_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Fraudpoint3__Key_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Key_Fraudpoint3_SSN_Records :=
	JOIN(Input_FDC, Fraudpoint3.Key_SSN, //Key has no dates does not need DateSelector
				Common.DoFDCJoin_Fraudpoint3__Key_SSN = TRUE AND
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN = RIGHT.ssn),
				TRANSFORM(Layouts_FDC.Layout_Fraudpoint3__Key_SSN,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.FraudPoint3Source,
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.FraudPoint3Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_Fraudpoint3_SSN_Records := DENORMALIZE(With_Fraudpoint3_Address_Records, Key_Fraudpoint3_SSN_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Fraudpoint3__Key_SSN := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	// USPIS_HotList: business and consumer agnostic--no name or companyname info provided
	Key_USPIS_HotList_addr_search_zip :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Address_All, USPIS_HotList.key_addr_search_zip,
				Common.DoFDCJoin_USPIS_HotList__key_addr_search_zip = TRUE AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND
				KEYED(LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.AddrSuffix = RIGHT.addr_suffix AND
					LEFT.Predirectional = RIGHT.predir AND
					LEFT.Postdirectional = RIGHT.postdir AND
					LEFT.SecondaryRange = RIGHT.sec_range),
				TRANSFORM(Layouts_FDC.Layout_USPIS_HotList__key_addr_search_zip,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.Hotlist,
					SELF.DPMBitmap := SetDPMBitmap( Source := BlankString, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_USPIS_HotList_Records := DENORMALIZE(With_Fraudpoint3_SSN_Records, Key_USPIS_HotList_addr_search_zip,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_USPIS_HotList__key_addr_search_zip := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Key_UtilFile_Address :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Address_Current, UtilFile.Key_Address,
			Common.DoFDCJoin_UtilFile__Key_Address = TRUE AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND
				KEYED(LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.State = RIGHT.st AND
					LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.SecondaryRange = RIGHT.sec_range),
				TRANSFORM(Layouts_FDC.Layout_UtilFile__Key_Address,
					SELF.Src := MDR.sourceTools.src_Utilities,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Utilities, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_UtilFile_Address_Records := DENORMALIZE(With_USPIS_HotList_Records, Key_UtilFile_Address,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UtilFile__Key_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Key_UtilFile_DID :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, UtilFile.Key_DID,
				Common.DoFDCJoin_UtilFile__Key_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_UtilFile__Key_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Utilities,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Utilities, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_UtilFile_DID_Records := DENORMALIZE(With_UtilFile_Address_Records, Key_UtilFile_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UtilFile__Key_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Input_Address_BusBest_Current_Previous_zip := DEDUP(SORT(Input_Address_BusBest_Current_Previous, UIDAppend, Zip5), UIDAppend, Zip5);

	Key_RiskWise_CityStZip:=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Address_BusBest_Current_Previous_zip, RiskWise.Key_CityStZip,
				Common.DoFDCJoin_RiskWise__Key_CityStZip = TRUE AND
				LEFT.ZIP5 <> '' AND
				KEYED(LEFT.ZIP5 = RIGHT.Zip5),
				TRANSFORM(Layouts_FDC.Layout_RiskWise__key_CityStZip,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.CityStateZip,
					SELF.DPMBitmap := SetDPMBitmap( BlankString, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_RiskWise_CityStZip_Records:= DENORMALIZE(With_UtilFile_DID_Records, Key_RiskWise_CityStZip,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_RiskWise__key_CityStZip := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));


	// ----------[ Person ]----------

	Death_did := IF(Options.isFCRA, Doxie.key_death_masterV2_ssa_DID_fcra, Doxie.Key_Death_MasterV2_SSA_DID);

	Key_Doxie__Death_MasterV2_SSA_DID_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Death_did,
				Common.DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.l_did),
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Death_MasterV2_SSA_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.src,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := GLBARegulatedDeathMasterRecord(RIGHT.glb_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_Doxie__Death_MasterV2_SSA_DID := Suppress.MAC_SuppressSource(Key_Doxie__Death_MasterV2_SSA_DID_unsuppressed, mod_access, did_field := l_did, gsid_field := global_sid, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsDeath := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												Key_Doxie__Death_MasterV2_SSA_DID((trim((string)state_death_id)) not in Death_correct_record_id AND (trim((string)did) + trim((string)state_death_id)) not in Death_correct_record_id),
												Key_Doxie__Death_MasterV2_SSA_DID);
	//if there are corrections lets go find them
	GetOverrideDeath := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND
																	(Common.DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID = TRUE OR Common.DoFDCJoin_DeathMaster__Key_SSN_SSA = TRUE),
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideDeath(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsDeath := WithSuppressionsDeath+GetOverrideDeath;

	With_Death_MasterV2_SSA_DID_Records :=
		DENORMALIZE(With_RiskWise_CityStZip_Records, WithCorrectionsDeath,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Doxie__Key_Death_MasterV2_SSA_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Key_DriversV2__DL_DID :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, DriversV2.Key_DL_DID,
				Common.DoFDCJoin_DriversV2__Key_DL_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_DriversV2__Key_DL_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Source_Code,
					SELF.dl_number := IF(STD.Str.FilterOut(RIGHT.dl_number, '1') = '', '', RIGHT.dl_number); // Filter any repeating 1's to be blank, bad data
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source_Code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.st, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_DriversV2__DL_DID_Records :=
		DENORMALIZE(With_Death_MasterV2_SSA_DID_Records, Key_DriversV2__DL_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DriversV2__Key_DL_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Key_DriversV2__DL_Number_Records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, DriversV2.Key_DL_Number,
				Common.DoFDCJoin_DriversV2__Key_DL_Number = TRUE AND
				LEFT.P_InpClnDL != '' AND
				KEYED(LEFT.P_InpClnDL = RIGHT.s_dl),
				TRANSFORM(Layouts_FDC.Layout_DriversV2__Key_DL_Number,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Source_Code,
					SELF.dl_number := IF(STD.Str.FilterOut(RIGHT.dl_number, '1') = '', '', RIGHT.dl_number); // Filter any repeating 1's to be blank, bad data
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source_Code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.st, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_DriversV2__DL_Number_Records :=
		DENORMALIZE(With_DriversV2__DL_DID_Records, Key_DriversV2__DL_Number_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DriversV2__Key_DL_Number := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Key_Certegy__Key_Certegy_DID := JOIN(Input_FDC, Certegy.key_certegy_did,
				Common.DoFDCJoin_Certegy__Key_Certegy_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Certegy__Key_Certegy_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Source_Code := MDR.sourceTools.src_Certegy,
					SELF.orig_dl_num := IF(STD.Str.FilterOut(RIGHT.orig_dl_num, '1') = '', '', RIGHT.orig_dl_num); // Filter any repeating 1's to be blank, bad data
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Certegy, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.orig_dl_state, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Key_Certegy__Key_Certegy_DID_Records := Suppress.MAC_SuppressSource(Key_Certegy__Key_Certegy_DID, mod_access, did_field := did, data_env := Environment);//Suppress CCPA fields

	With_Certegy__Key_Certegy_DID_Records :=
		DENORMALIZE(With_DriversV2__DL_Number_Records, Key_Certegy__Key_Certegy_DID_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Certegy__Key_Certegy_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	//FCRA version of this key does not need corrections because we only use this data in FCRA for count type attributes
	//if one day we decided to return more specific data from this key we would need coreections here too.
	Key_Doxie__Header_Address_Records_Unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Address_All, dx_header.key_header_address(iType),
				Common.DoFDCJoin_Doxie__Key_Header_Address = TRUE AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND
				KEYED(
					LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.SecondaryRange = RIGHT.sec_range),
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Header_Address,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Src,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(RIGHT.Src, RIGHT.dt_last_seen, RIGHT.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(RIGHT.src), Marketing_State := right.St, KELPermissions := CFG_File, Is_Consumer_Header := TRUE),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_Doxie__Header_Address_Records := Suppress.MAC_SuppressSource(Key_Doxie__Header_Address_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Doxie__Header_Address_Records :=
		DENORMALIZE(With_Certegy__Key_Certegy_DID_Records, Key_Doxie__Header_Address_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Doxie__Key_Header_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

// Person - Relatives
	Key_Relatives__Key_Relatives_V3_Unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Clean_Input_Plus_Contacts, Relationship.key_relatives_v3,
				Common.DoFDCJoin_Relatives__Key_Relatives_v3 = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did1),
				TRANSFORM(Layouts_FDC.Layout_Relatives__Key_Relatives_V3,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Relatives_Data;
					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF.CoSourceCount := COUNT(RIGHT.rels);
					SELF.CoSourceSum := SUM(RIGHT.rels, Cnt);
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.REL_HHID_Join_LIMIT)),FALSE,FALSE);

	Key_Relatives__Key_Relatives_V3 := Suppress.MAC_SuppressSource(Key_Relatives__Key_Relatives_V3_Unsuppressed, mod_access, did_field := did1, data_env := Environment);

	With_Key_Relatives_V3_Records :=
		DENORMALIZE(With_Doxie__Header_Address_Records, Key_Relatives__Key_Relatives_V3,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Relatives__Key_Relatives_V3 := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

// Person - Relatives	marketing
	Key_Relatives_Marketing__dx_Relatives_v3_Unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Clean_Input_Plus_Contacts, dx_Relatives_v3.Key_Marketing_Header_Relatives(),
				Common.DoFDCJoin_Marketing_Relatives__Key_Relatives_v3 = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did1),
				TRANSFORM(Layouts_FDC.Layout_Relatives__Key_Marketing_Header_Relatives,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Marketing_Relatives_Data;
					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF.CoSourceCount := COUNT(RIGHT.rels);
					SELF.CoSourceSum := SUM(RIGHT.rels, Cnt);
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.REL_HHID_Join_LIMIT)),FALSE,FALSE);

	Key_Relatives_Marketing__dx_Relatives_v3 := Suppress.MAC_SuppressSource(Key_Relatives_Marketing__dx_Relatives_v3_Unsuppressed, mod_access, did_field := did1, data_env := Environment);

	With_Key_Relatives_Marketing_Records :=
		DENORMALIZE(With_Key_Relatives_V3_Records, Key_Relatives_Marketing__dx_Relatives_v3,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Relatives__Key_Marketing_Header_Relatives3 := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	RelativesLexids := SET((Input_FDC), P_LexID);

	All_Relatives := (Key_Relatives__Key_Relatives_V3+ Key_Relatives_Marketing__dx_Relatives_v3);//both marketing and non marketing relatives.

	Seperate_relatives := All_Relatives(P_LexID IN RelativesLexids);//we only want input lexid relatives NOT contact relatives

	Relatives := project(Seperate_relatives, TRANSFORM(Layouts_FDC.Layout_FDC, self.P_lexid := LEFT.did2, SELF.UIDAppend := LEFT.UIDAppend, SELF := LEFT, SELF := []));//take the relatives of inputs and assign them to plexid

	//need to use did from fid key instead of plexid in case input address is valid but not tied to P_lexid
	InputRelativesTrans := project(Input_FDC + Relatives, transform({unsigned6 did;}, self.did := left.P_LexID, self := []));
	InputRelativesLexids := SET((InputRelativesTrans), DID);

	// ----------[ Phone ]----------

	Gong__Key_History_DID := dx_Gong.key_history_DID(iType);
	Gong__Key_History_DID_Records_Unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN( Input_FDC, Gong__Key_History_DID,
			Common.DoFDCJoin_Gong__Key_History_DID AND
			LEFT.P_LexID > 0 AND
			KEYED(LEFT.P_LexID = RIGHT.l_did),
			TRANSFORM(Layouts_FDC.Layout_Gong__Key_History_DID,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := RIGHT.Src,
				SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				SELF.Listing_Type := TRIM(RIGHT.Listing_Type_Bus + RIGHT.Listing_Type_Res + RIGHT.Listing_Type_Gov, ALL),
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []),
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Gong__Key_History_DID_Records := Suppress.MAC_SuppressSource(Gong__Key_History_DID_Records_Unsuppressed, mod_access, did_field := l_did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	DropOverrideGongDID := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												Gong__Key_History_DID_Records((trim((string12)did+(string10)phone10+(string8)dt_first_seen) not in	gong_correct_record_id) AND // old way - prior to 11/13/2012
														((string)persistent_record_id not in gong_correct_record_id)),  // new way - using persistent_record_id
												Gong__Key_History_DID_Records);

	//if there are corrections lets go find them
	GetOverrideGongDID := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND
																(Common.DoFDCJoin_Gong__Key_History_DID = TRUE OR Common.DoFDCJoin_Gong__Key_History_Address = TRUE OR Common.DoFDCJoin_Gong__Key_History_Phone = TRUE),
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideGong(Input_FDC));//consumer only since FCRA only -- no business in FCRA


	WithCorrectionsGongDID := DropOverrideGongDID+GetOverrideGongDID;

	With_Gong_History_DID_Records :=
		DENORMALIZE(With_Key_Relatives_Marketing_Records, WithCorrectionsGongDID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Gong__Key_History_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));


	Gong__Key_History_Address := dx_Gong.key_history_address(iType);
	Gong__Key_History_Address_Records_Unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN( Input_and_Best_Address, Gong__Key_History_Address,
			Common.DoFDCJoin_Gong__Key_History_Address AND
			LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND
			KEYED(
				LEFT.PrimaryName = RIGHT.prim_name AND
				LEFT.State = RIGHT.st AND
				LEFT.ZIP5 = RIGHT.z5 AND
				LEFT.PrimaryRange = RIGHT.prim_range AND
				LEFT.SecondaryRange = RIGHT.sec_range
			),
			TRANSFORM(Layouts_FDC.Layout_Gong__Key_History_Address,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := RIGHT.Src,
				SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				SELF.Listing_Type := TRIM(RIGHT.Listing_Type_Bus + RIGHT.Listing_Type_Res + RIGHT.Listing_Type_Gov, ALL),
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []),
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Gong__Key_History_Address_Records := Suppress.MAC_SuppressSource(Gong__Key_History_Address_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	DropOverrideGongAddr := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												Gong__Key_History_Address_Records((trim((string12)did+(string10)phone10+(string8)dt_first_seen) not in	gong_correct_record_id) AND // old way - prior to 11/13/2012
														((string)persistent_record_id not in gong_correct_record_id)),  // new way - using persistent_record_id
												Gong__Key_History_Address_Records);

	GetOverrideGongaddr := Project(GetOverrideGongDID,
																			transform(Layouts_FDC.Layout_Gong__Key_History_Address,
																			self := left,
																			self := []));

	WithCorrectionsGongAddr := DropOverrideGongAddr+GetOverrideGongaddr;

	With_Gong_History_Address_Records :=
		DENORMALIZE(With_Gong_History_DID_Records, WithCorrectionsGongAddr,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Gong__Key_History_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Gong__Key_History_Phone := dx_Gong.key_history_phone(iType);
	Gong__Key_History_Phone_Records_Unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN( Input_Phone_All, Gong__Key_History_Phone,
			Common.DoFDCJoin_Gong__Key_History_Phone AND
			LEFT.Phone != '' AND
			KEYED(
				LEFT.Phone[4..10] = RIGHT.p7 AND
				LEFT.Phone[1..3] = RIGHT.p3
			),
			TRANSFORM(Layouts_FDC.Layout_Gong__Key_History_Phone,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := RIGHT.Src,
				SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				SELF.Listing_Type := TRIM(RIGHT.Listing_Type_Bus + RIGHT.Listing_Type_Res + RIGHT.Listing_Type_Gov, ALL),
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []),
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Gong__Key_History_Phone_Records := Suppress.MAC_SuppressSource(Gong__Key_History_Phone_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	DropOverrideGongPhone := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												Gong__Key_History_Phone_Records((trim((string12)did+(string10)phone10+(string8)dt_first_seen) not in	gong_correct_record_id) AND // old way - prior to 11/13/2012
														((string)persistent_record_id not in gong_correct_record_id)),  // new way - using persistent_record_id
												Gong__Key_History_Phone_Records);

	GetOverrideGongPhone := Project(GetOverrideGongDID,
																			transform(Layouts_FDC.Layout_Gong__Key_History_Phone,
																			self := left,
																			self := []));

	WithCorrectionsGongPhone := DropOverrideGongPhone+GetOverrideGongPhone;

	With_Gong_History_Phone_Records :=
		DENORMALIZE(With_Gong_History_Address_Records, WithCorrectionsGongPhone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Gong__Key_History_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Targus__Key_History_Phone :=  IF( Options.isFCRA, Targus.Key_Targus_FCRA_Phone, Targus.Key_Targus_Phone );
	Targus__Key_History_Phone_Records_Unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN( Input_Phone_All, Targus__Key_History_Phone,
			Common.DoFDCJoin_Targus__Key_Targus_Phone AND
			LEFT.Phone != '' AND
			KEYED(
				LEFT.Phone[4..10] = RIGHT.p7 AND
				LEFT.Phone[1..3] = RIGHT.p3
			),
			TRANSFORM(Layouts_FDC.Layout_Targus__Key_Targus_Phone,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := MDR.sourceTools.src_Targus_White_pages,
				SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Targus_White_pages, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []),
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Targus__Key_History_Phone_Records := Suppress.MAC_SuppressSource(Targus__Key_History_Phone_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Targus_History_Phone_Records :=
		DENORMALIZE(With_Gong_History_Phone_Records, Targus__Key_History_Phone_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Targus__Key_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));


	InfutorCID__Key_Phone := IF( Options.isFCRA,  InfutorCID.Key_Infutor_Phone_FCRA ,InfutorCID.Key_Infutor_Phone);
	InfutorCID__Key_Phone_Records_Unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN( Input_Phone_All, InfutorCID__Key_Phone,
			Common.DoFDCJoin_InfutorCID__Key_Infutor_Phone AND
			LEFT.Phone != '' AND
			KEYED( LEFT.Phone = RIGHT.phone ),
			TRANSFORM(Layouts_FDC.Layout_InfutorCID__Key_Infutor_Phone,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := MDR.sourceTools.src_InfutorCID,
				SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InfutorCID, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []),
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	InfutorCID__Key_Phone_Records := Suppress.MAC_SuppressSource(InfutorCID__Key_Phone_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsInfutor := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												InfutorCID__Key_Phone_Records(trim((string)did)+trim(phone)+trim((string)dt_first_seen) not in infutor_correct_record_id and  // old way, using concatenated keys
																											trim(persistent_record_id) not in	infutor_correct_record_id),  // new way - using persistent_record_id
												InfutorCID__Key_Phone_Records);

	//if there are corrections lets go find them
	GetOverrideInfutor := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_InfutorCID__Key_Infutor_Phone = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideInfutor(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsInfutorPhone := WithSuppressionsInfutor+GetOverrideInfutor;

	With_InfutorCID_Phone_Records :=
		DENORMALIZE(With_Targus_History_Phone_Records, WithCorrectionsInfutorPhone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_InfutorCID__Key_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

/* Phone Records - By phone number*/
	Key_PhonesPlus_v2__Keys_ScoringPhone_Unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Phone_All, Phonesplus_v2.Keys_Scoring().phone.qa,
				Common.DoFDCJoin_PhonePlus_V2__ScoringPhone = TRUE AND
				LEFT.Phone <> '' AND
				KEYED(LEFT.Phone  = RIGHT.cellphone),
				TRANSFORM(Layouts_FDC.Layout_Phone__PhonesPlus_v2_Keys_Scoring_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := GLBARegulatedPhonesPlusRecord(RIGHT.glb_dppa_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.state, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_PhonesPlus_v2__Keys_ScoringPhone := Suppress.MAC_SuppressSource(Key_PhonesPlus_v2__Keys_ScoringPhone_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_PhonePlus_V2_ScoringPhone_Records :=
		DENORMALIZE(With_InfutorCID_Phone_Records, Key_PhonesPlus_v2__Keys_ScoringPhone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

/* I Verification Records - By Phone*/

	Key_Iverification__Keys_Iverification_phone_Unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Phone_All, Phonesplus_v2.Keys_Iverification().phone.qa,
				Common.DoFDCJoin_PhonePlus_V2__Iverification_Phone = TRUE AND
				LEFT.Phone <> '' AND
				KEYED(LEFT.Phone = RIGHT.phone),
				TRANSFORM(Layouts_FDC.Layout_Key_Iverification__Keys_Iverification_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Phone_Iver := right.phone,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_Iverification__Keys_Iverification_phone := Suppress.MAC_SuppressSource(Key_Iverification__Keys_Iverification_phone_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Key_Iverfication_phone_Records :=
		DENORMALIZE(With_PhonePlus_V2_ScoringPhone_Records, Key_Iverification__Keys_Iverification_Phone,
					LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
					TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Key_Iverification__Keys_Iverification_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

/* I Verification Records - By Lexid and Phone*/

	Key_Iverification__Keys_Iverification_Did_Phone_Unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Phone_All, Phonesplus_v2.Keys_Iverification().did_phone.qa,
				Common.DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone = TRUE AND
				LEFT.P_LexID != 0 AND LEFT.Phone <> '' AND
				KEYED(LEFT.P_LexID = RIGHT.did AND
							LEFT.Phone = RIGHT.phone),
					TRANSFORM(Layouts_FDC.Layout_Key_Iverification__Keys_Iverification_Did_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Phone_Iver := right.phone,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_Iverification__Keys_Iverification_Did_Phone := Suppress.MAC_SuppressSource(Key_Iverification__Keys_Iverification_Did_Phone_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Key_Iverfication_Did_Phone_Records :=
		DENORMALIZE(With_Key_Iverfication_phone_Records, Key_Iverification__Keys_Iverification_Did_Phone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Key_Iverification__Keys_Iverification_Did_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	/* Cellphone - Neustar Phone Records */

	Key_CellPhone__Key_Neustar_Phone := 	//Key has no dates does not need DateSelector
			JOIN(Input_Phone_All, CellPhone.key_neustar_phone,
				Common.DoFDCJoin_CellPhone__Key_Nustar_Phone = TRUE AND
				LEFT.Phone <> '' AND
				KEYED(LEFT.Phone = RIGHT.cellphone),
					TRANSFORM(Layouts_FDC.Layout_Key_CellPhone__Key_Neustar_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_Key_CellPhone__Key_Neustar_Phone_Records :=
		DENORMALIZE(With_Key_Iverfication_Did_Phone_Records, Key_CellPhone__Key_Neustar_Phone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Key_CellPhone__Key_Neustar_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

/* PhonesPlus_v2 - Phonesplus FDid Records */

//Get phone autokeys to fetch all the DID's associated for the input phone number

	Key_PhonesPlus_v2__Key_PhonesPlus_did_records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Phone_All, AutoKey.Key_Phone(Data_Services.Data_Location.Prefix('phonesPlus') + 'thor_data400::key::phonesplusv2_'),
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(RIGHT.p7 = LEFT.Phone[4..10]) AND
				KEYED(RIGHT.p3 = LEFT.Phone[1..3]),
					TRANSFORM(Layouts_FDC.LayoutPhoneAutoKeys,
					SELF.Fdid := RIGHT.did,
					SELF := LEFT,
					SELF.Archive_Date := ''), //this needs to be filled out to let the transform happen. The proper value will overwrite it.
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_PhonesPlus_v2__Key_PhonesPlus_Fdid_Unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Key_PhonesPlus_v2__Key_PhonesPlus_did_records, Phonesplus_v2.Key_Phonesplus_Fdid,
				Common.DoFDCJoin_PhonePlus_V2__Key_Phoneplus_FDid = TRUE AND
				LEFT.Fdid != 0 AND LEFT.Phone <> '' AND
				KEYED(LEFT.Fdid = RIGHT.fdid) AND
				LEFT.Phone = RIGHT.cellphone,
					TRANSFORM(Layouts_FDC.Layout_PhonesPlus_v2_Key_PhonePlus_Fdid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Source := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := GLBARegulatedPhonesPlusRecord(RIGHT.glb_dppa_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.origstate, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_PhonesPlus_v2__Key_PhonesPlus_Fdid := Suppress.MAC_SuppressSource(Key_PhonesPlus_v2__Key_PhonesPlus_Fdid_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_PhonesPlus_v2__Key_PhonePlus_Fdid_Records :=
		DENORMALIZE(With_Key_CellPhone__Key_Neustar_Phone_Records, Key_PhonesPlus_v2__Key_PhonesPlus_Fdid,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

					/*----------------------------------EDUCATION------------------------------------*/

	American_student_list__key_DID := IF( Options.isFCRA,  American_student_list.key_DID_FCRA, American_student_list.key_DID );
	Key_American_student_list__key_DID_Records_unsupressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Clean_Input_Plus_Contacts, American_student_list__key_DID,
			Common.DoFDCJoin_American_student_list__key_DID = True AND
			LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.L_did),
				TRANSFORM(Layouts_FDC.Layout_American_student_list__key_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	American_student_list__key_DID_Records := Suppress.MAC_SuppressSource(Key_American_student_list__key_DID_Records_unsupressed, mod_access, did_field := L_did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsAmericanStudent := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												American_student_list__key_DID_Records((string)key not in student_correct_record_id),
												American_student_list__key_DID_Records);

	//if there are corrections lets go find them
	GetOverrideAmericanStudent := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_American_student_list__key_DID = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideAmericanStudent(Input_FDC));//consumer only since FCRA only -- no business in FCRA


	WithCorrectionsAmericanStudent := WithSuppressionsAmericanStudent+GetOverrideAmericanStudent;


	With_American_student_list__key_DID := DENORMALIZE(With_PhonesPlus_v2__Key_PhonePlus_Fdid_Records, WithCorrectionsAmericanStudent,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_American_student_list__key_DID := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	AlloyMedia_student_list__key_DID := IF( Options.isFCRA,  AlloyMedia_student_list.key_DID_FCRA, AlloyMedia_student_list.key_DID );
	Key_AlloyMedia_student_list__key_DID_Records_unsupressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Clean_Input_Plus_Contacts, AlloyMedia_student_list__key_DID,
			Common.DoFDCJoin_AlloyMedia_student_list__key_DID =True AND
			LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_AlloyMedia_student_list__key_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	AlloyMedia_student_list__key_DID_Records := Suppress.MAC_SuppressSource(Key_AlloyMedia_student_list__key_DID_Records_unsupressed, mod_access, did_field := did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsAlloyStudent := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												AlloyMedia_student_list__key_DID_Records((trim(sequence_number) + trim(key_code) + (string)rawaid) not in student_correct_record_id),
												AlloyMedia_student_list__key_DID_Records);

	//if there are corrections lets go find them
	GetOverrideAlloyStudent := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_AlloyMedia_student_list__key_DID = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideAlloyStudent(Input_FDC));//consumer only since FCRA only -- no business in FCRA


	WithCorrectionsAlloyStudent := WithSuppressionsAlloyStudent+GetOverrideAlloyStudent;


	With_AlloyMedia_student_list__key_DID := DENORMALIZE(With_American_student_list__key_DID, WithCorrectionsAlloyStudent,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_AlloyMedia_student_list__key_DID := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	/* **************************************************************************

	                             Summary Section

	************************************************************************** */
Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Denorm :=
			JOIN(input_address_all, Risk_Indicators.Correlation_Risk.key_addr_dob_summary,
				Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_dob_summary = TRUE AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND
				KEYED(LEFT.PrimaryName = RIGHT.prim_name) AND
				KEYED(LEFT.PrimaryRange = RIGHT.prim_range) AND
				KEYED(LEFT.ZIP5 = RIGHT.zip),
				TRANSFORM(Layouts_FDC.Layout_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Denorm,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));


	//Risk_Indicators.Correlation_Risk.key_addr_dob_summary contains a child dataset so we need to add an extra step and NORMALIZE it before adding to the FDC bundle.
	Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Norm := PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Denorm , LEFT.summary,
			TRANSFORM(Layouts_FDC.Layout_Risk_Indicators__Correlation_Risk__key_addr_dob_summary,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := LEFT,
					SELF := RIGHT)),FALSE,FALSE);

	With_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Norm := DENORMALIZE(With_AlloyMedia_student_list__key_DID, Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Norm,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));


	Risk_Indicators__Correlation_Risk__key_addr_name_summary_Denorm :=
			JOIN(input_address_all, Risk_Indicators.Correlation_Risk.key_addr_name_summary,
				Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_name_summary = TRUE AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND
				KEYED(LEFT.PrimaryName = RIGHT.prim_name) AND
				KEYED(LEFT.PrimaryRange = RIGHT.prim_range) AND
				KEYED(LEFT.ZIP5 = RIGHT.zip),
				TRANSFORM(Layouts_FDC.Layout_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Denorm,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));


	//Risk_Indicators.Correlation_Risk.key_addr_dob_summary contains a child dataset so we need to add an extra step and NORMALIZE it before adding to the FDC bundle.
	Risk_Indicators__Correlation_Risk__key_addr_name_summary_Norm := PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(Risk_Indicators__Correlation_Risk__key_addr_name_summary_Denorm , LEFT.summary,
			TRANSFORM(Layouts_FDC.Layout_Risk_Indicators__Correlation_Risk__key_addr_name_summary,
								SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
								SELF := LEFT,
								SELF := RIGHT)),FALSE,FALSE);

	With_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Norm := DENORMALIZE(With_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Norm, Risk_Indicators__Correlation_Risk__key_addr_name_summary_Norm,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

// SSN Summary
   Risk_Indicators__Key_SSN_Addr_Summary :=
   		JOIN(input_address_all, Risk_Indicators.Correlation_Risk.key_ssn_addr_summary,
            Common.DoFDCJoin_Risk_Indicators__Key_SSN_Addr_Summary = TRUE AND
            LEFT.P_InpClnSSN <> '' AND LEFT.PrimaryName <> '' AND LEFT.ZIP5 <> '' AND
            KEYED(LEFT.P_InpClnSSN = RIGHT.SSN) AND
            KEYED(LEFT.PrimaryName = RIGHT.prim_name) AND
            KEYED(LEFT.PrimaryRange = RIGHT.prim_range) AND
            KEYED(LEFT.ZIP5 = RIGHT.zip),
            TRANSFORM(Layouts_FDC.Layout_ssn_addr_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                // SELF.HeaderHitFlag := FALSE;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []),
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));

     Risk_Indicators__Key_SSN_Addr_Summary_Norm_Records :=
        PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(Risk_Indicators__Key_SSN_Addr_Summary , left.summary,
          TRANSFORM(Layouts_FDC.Layout_ssn_addr_summary_records,
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                SELF := RIGHT,
                SELF := LEFT,
                SELF := [])), FALSE, FALSE);

   	With_SSN_Addr_Summary_Records := DENORMALIZE(With_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Norm, Risk_Indicators__Key_SSN_Addr_Summary_Norm_Records,
        LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_Risk_Indicators__Key_SSN_Addr_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

	Risk_Indicators__Key_SSN_dob_Summary :=
   		JOIN(input_address_all, Risk_Indicators.Correlation_Risk.key_ssn_dob_summary,
            Common.DoFDCJoin_Risk_Indicators__Key_SSN_dob_Summary = TRUE AND
            LEFT.P_InpClnSSN <> '' AND LEFT.P_InpClnDOB <> '' AND
            KEYED(LEFT.P_InpClnSSN = RIGHT.SSN) AND
            KEYED(LEFT.P_InpClnDOB = (STRING)RIGHT.dob),
            TRANSFORM(Layouts_FDC.Layout_ssn_dob_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                // SELF.HeaderHitFlag := FALSE;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []),
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));

     Risk_Indicators__Key_SSN_dob_Summary_Norm_Records :=
        PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(Risk_Indicators__Key_SSN_dob_Summary , left.summary,
          TRANSFORM(Layouts_FDC.Layout_ssn_dob_summary_records,
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                SELF := RIGHT,
                SELF := LEFT,
                SELF := [])), FALSE, FALSE);

   	With_SSN_DOB_Summary_Records := DENORMALIZE(With_SSN_Addr_Summary_Records, Risk_Indicators__Key_SSN_dob_Summary_Norm_Records,
        LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_Risk_Indicators__Key_SSN_dob_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

	 Risk_Indicators__Key_SSN_Name_Summary :=
   		JOIN(input_address_all, Risk_Indicators.Correlation_Risk.key_ssn_name_summary,
            Common.DoFDCJoin_Risk_Indicators__Key_SSN_Name_Summary = TRUE AND
            LEFT.P_InpClnSSN <> '' AND LEFT.P_InpClnNameFirst <> '' AND LEFT.P_InpClnNameLast <> '' AND
            KEYED(LEFT.P_InpClnSSN = RIGHT.SSN) AND
            KEYED(LEFT.P_InpClnNameFirst = RIGHT.fname) AND
            KEYED(LEFT.P_InpClnNameLast = RIGHT.lname),
            TRANSFORM(Layouts_FDC.Layout_ssn_name_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                // SELF.HeaderHitFlag := FALSE;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []),
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));

     Risk_Indicators__Key_SSN_Name_Summary_Norm_Records :=
        PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(Risk_Indicators__Key_SSN_Name_Summary , left.summary,
          TRANSFORM(Layouts_FDC.Layout_ssn_name_summary_records,
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                SELF := RIGHT,
                SELF := LEFT,
                SELF := [])), FALSE, FALSE);

   	With_SSN_Name_Summary_Records := DENORMALIZE(With_SSN_DOB_Summary_Records, Risk_Indicators__Key_SSN_Name_Summary_Norm_Records,
        LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_Risk_Indicators__Key_SSN_Name_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

	 Risk_Indicators__Key_SSN_phone_Summary :=
   		JOIN(Input_Phone_Address_Combined_Recs, Risk_Indicators.Correlation_Risk.key_ssn_phone_summary,
            Common.DoFDCJoin_Risk_Indicators__Key_SSN_Phone_Summary = TRUE AND
            LEFT.P_InpClnSSN <> '' AND LEFT.Phone <> '' AND
            KEYED(LEFT.P_InpClnSSN = RIGHT.SSN) AND
            KEYED(LEFT.Phone = RIGHT.Phone),
            TRANSFORM(Layouts_FDC.Layout_ssn_phone_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                // SELF.HeaderHitFlag := FALSE;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []),
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));

     Risk_Indicators__Key_SSN_Phone_Summary_Norm_Records :=
        PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(Risk_Indicators__Key_SSN_phone_Summary , left.summary,
          TRANSFORM(Layouts_FDC.Layout_ssn_phone_summary_records,
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                SELF := RIGHT,
                SELF := LEFT,
                SELF := [])), FALSE, FALSE);

   	With_SSN_Phone_Summary_Records := DENORMALIZE(With_SSN_Name_Summary_Records, Risk_Indicators__Key_SSN_Phone_Summary_Norm_Records,
        LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_Risk_Indicators__Key_SSN_Phone_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

	/* **************************************************************************

	                             BUSINESS SECTION

	************************************************************************** */


	// --------------------[ Tradeline records ]--------------------

	Tradeline_Key_LinkIds := IF(Common.DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds = TRUE,
															PublicRecords_KEL.ecl_functions.DateSelector(dx_Cortera_Tradeline.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
															PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
															0, /*ScoreThreshold --> 0 = Give me everything*/
															PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
															BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));



	With_Tradeline_Key_LinkIds := DENORMALIZE(With_SSN_Phone_Summary_Records, Tradeline_Key_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Cortera_Tradeline__Key_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Cortera_Tradeline__Key_LinkIds,
									SELF.DPMBitmap := SetDPMBitmap( Source := left.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
									SELF := LEFT,
									SELF := []));
					SELF := LEFT,
					SELF := []));

	// --------------------[ Address (business) ]--------------------

	Corp2_Kfetch_LinkIds_Corp := PublicRecords_KEL.ecl_functions.DateSelector(IF(Common.DoFDCJoin_Corp2__Key_LinkIDs_Corp = TRUE,
																							Corp2.Key_LinkIDs.Corp.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Lookup_And_Input_LinkIDs),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin)),FALSE,TRUE);


	With_Corp2_Key_LinkIds_Corp := DENORMALIZE(With_Tradeline_Key_LinkIds, Corp2_Kfetch_LinkIds_Corp,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Corp2__Kfetch_LinkIDs_Corp := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Corp2__Kfetch_LinkIDs_Corp,
																				self.src := MDR.sourceTools.fCorpV2( Left.corp_key, Left.corp_state_origin),
																				self.corp_sic_code := CleanSIC(LEFT.corp_sic_code);
																				self.corp_naic_code := CleanNAIC(LEFT.corp_naic_code);
																				SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																				self := left,
																				self := []));
					SELF := LEFT,
					SELF := []));


	UtilFile_Kfetch2_LinkIds := IF(Common.DoFDCJoin_UtilFile__Key_LinkIds = TRUE,
																							PublicRecords_KEL.ecl_functions.DateSelector(UtilFile.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_UtilFile_Key_LinkIds := DENORMALIZE(With_Corp2_Key_LinkIds_Corp, UtilFile_Kfetch2_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UtilFile__Kfetch2_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_UtilFile__Kfetch2_LinkIds,
																						self.src := MDR.sourceTools.src_Utilities,
																						SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																						self := left,
																						self := []));
					SELF := LEFT,
					SELF := []));

		Key_Aircraft_linkids_Records :=	IF(Common.DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids = TRUE,
																			PublicRecords_KEL.ecl_functions.DateSelector(FAA.key_aircraft_linkids.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																			PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																			0, /*ScoreThreshold --> 0 = Give me everything*/
																			PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																			BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

		With_Aircraft_linkids_Records := DENORMALIZE(With_UtilFile_Key_LinkIds, Key_Aircraft_linkids_Records,
				LEFT.G_ProcBusUID = RIGHT.UniqueID AND
				LEFT.B_LexIDUlt = RIGHT.ULTID AND
				LEFT.B_LexIDOrg = RIGHT.ORGID AND
				LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_FAA__key_aircraft_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_FAA__key_aircraft_linkids,
									SELF.Src := MDR.sourceTools.src_Aircrafts,
									SELF.DPMBitmap := SetDPMBitmap( Source := Self.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
									SELF := LEFT,
									SELF := []));
						SELF := LEFT,
						SELF := []));

		Key_Watercraft_LinkId_Records_unsuppressed := IF(Common.DoFDCJoin_Watercraft_Files__Watercraft_LinkId = TRUE,
																										PublicRecords_KEL.ecl_functions.DateSelector(Watercraft.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																										PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																										0, /*ScoreThreshold --> 0 = Give me everything*/
																										linkingOptions,
																										PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																										BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	Key_Watercraft_LinkId_Records := Suppress.MAC_SuppressSource(Key_Watercraft_LinkId_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Watercraft_LinkId_Records := DENORMALIZE(With_Aircraft_linkids_Records, Key_Watercraft_LinkId_Records,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Watercraft__Watercraft__Key_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Watercraft__Key_LinkIds,
									SELF.src := MDR.sourceTools.fWatercraft(left.Source_Code, left.State_Origin),
									SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := DPPARegulatedWaterCraftRecord(left.dppa_flag), DPPA_State := left.state_origin, KELPermissions := CFG_File),
									SELF := LEFT,
									SELF := []));
					SELF := LEFT,
					SELF := []));


	Key_Vehicle_linkids_Records_unsuppressed := IF(Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID = TRUE,
																								PublicRecords_KEL.ecl_functions.DateSelector(VehicleV2.Key_Vehicle_linkids.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								mod_access,
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								linkingOptions,
																								PublicRecords_KEL.ECL_Functions.Constants.VEHICLE_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	Temp_vehicle_linkid_records := Suppress.MAC_SuppressSource(Key_Vehicle_linkids_Records_unsuppressed, mod_access, did_field := append_did, data_env := Environment);

	// PublicRecords_KEL.ECL_Functions.Common_Functions.AppendSeq(Key_Vehicle_linkids_Records, Input_FDC,Temp_vehicle_linkid_records,PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID);

	With_Vehicle_linkids_Records := DENORMALIZE(With_Watercraft_LinkId_Records, Temp_vehicle_linkid_records,
			LEFT.G_ProcBusUID = RIGHT.uniqueId AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_VehicleV2__Key_Vehicle_LinkID_Key := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_LinkID_Key,
									SELF.Src := left.source_code,
									SELF.DPMBitmap := SetDPMBitmap( Source := left.source_code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := left.orig_state, KELPermissions := CFG_File),
									SELF := LEFT,
									SELF := []));
					SELF := LEFT,
					SELF := []));
	/* **************************************************************************

																Business and Consumer

	************************************************************************** */
	// --------------------[ Vehicle records ]--------------------

	Key_Vehicle_did_Records :=	//	Key not in uses, no dates used does not need dateselector
			JOIN(Input_FDC, VehicleV2.Key_Vehicle_DID,
				Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.append_did),
				TRANSFORM(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.VEHICLE_JOIN_LIMIT));

	Temp_Vehicle_linkids := project(Temp_vehicle_linkid_records, transform(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_DID,
					SELF := LEFT,
					SELF := []));

	Vehicle_all := Temp_Vehicle_linkids+Key_Vehicle_did_Records;

	Key_Vehicle_Party_Records_unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Vehicle_all, VehicleV2.Key_Vehicle_Party_Key,
		Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Party = TRUE AND
				KEYED(LEFT.vehicle_key = RIGHT.vehicle_key AND
					LEFT.iteration_key = RIGHT.iteration_key AND
					LEFT.sequence_key = RIGHT.sequence_key),
				TRANSFORM(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Party_Key,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.source_code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := RIGHT.orig_state, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.VEHICLE_JOIN_LIMIT)),FALSE,FALSE);

	Key_Vehicle_Party_Records := Suppress.MAC_SuppressSource(Key_Vehicle_Party_Records_unsuppressed, mod_access, did_field := append_did, data_env := Environment);

	Key_Vehicle_Main_Records_unsuppressed :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Vehicle_all, VehicleV2.Key_Vehicle_Main_Key,
		Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Main = TRUE AND
				KEYED(LEFT.vehicle_key = RIGHT.vehicle_key AND
					LEFT.iteration_key = RIGHT.iteration_key),
				TRANSFORM({Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Main_Key, RECORDOF(LEFT)}, // including RECORDOF(LEFT) in this layout so that we can retain the DID for CCPA file suppressions
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.cleaned_brand_date_1 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_1)[1].ValidPortion_01;
					SELF.cleaned_brand_date_2 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_2)[1].ValidPortion_01;
					SELF.cleaned_brand_date_3 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_3)[1].ValidPortion_01;
					SELF.cleaned_brand_date_4 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_4)[1].ValidPortion_01;
					SELF.cleaned_brand_date_5 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_5)[1].ValidPortion_01;
					SELF.Src := RIGHT.source_code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := RIGHT.state_origin, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.VEHICLE_JOIN_LIMIT)),FALSE,FALSE);

	Key_Vehicle_Main_Records := PROJECT(Suppress.MAC_SuppressSource(Key_Vehicle_Main_Records_unsuppressed, mod_access, did_field := append_did, data_env := Environment),
		TRANSFORM(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Main_Key, SELF := LEFT)); // Suppressing records, then transforming back to original key layout since we no longer need the append_did field from the vehicle did key.

	With_Vehicle_Party_Records := DENORMALIZE(With_Vehicle_linkids_Records, Key_Vehicle_Party_Records,
			(LEFT.G_ProcUID = RIGHT.G_ProcUID AND
			LEFT.P_LexID = RIGHT.P_LexID) OR
			(LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID AND
			LEFT.B_LexIDUlt = RIGHT.B_LexIDUlt AND
			LEFT.B_LexIDOrg = RIGHT.B_LexIDOrg AND
			LEFT.B_LexIDLegal = RIGHT.B_LexIDLegal), GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_VehicleV2__Key_Vehicle_Party_Key := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []), ALL);

	With_Vehicle_Main_Records := DENORMALIZE(With_Vehicle_Party_Records, Key_Vehicle_Main_Records,
			(LEFT.G_ProcUID = RIGHT.G_ProcUID AND
			LEFT.P_LexID = RIGHT.P_LexID) OR
			(LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID AND
			LEFT.B_LexIDUlt = RIGHT.B_LexIDUlt AND
			LEFT.B_LexIDOrg = RIGHT.B_LexIDOrg AND
			LEFT.B_LexIDLegal = RIGHT.B_LexIDLegal), GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_VehicleV2__Key_Vehicle_Main_Key := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []), ALL);

	// UCC Key Linkids

		UCC_LinkIds_Records := IF(Common.DoFDCJoin_UCC_Files__Key_Linkids = TRUE,
														PublicRecords_KEL.ecl_functions.DateSelector(UCCV2.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Lookup_And_Input_LinkIDs),
														PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
														0, /*ScoreThreshold --> 0 = Give me everything*/
														PublicRecords_KEL.ECL_Functions.Constants.UCC_JOIN_LIMIT,
														BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

		With_UCC_Linkid_records := DENORMALIZE(With_Vehicle_Main_Records, UCC_LinkIds_Records,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UCC__Key_LinkIds_key := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_UCC__Key_LinkIds_key,
									AllCharacters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
									AllNumbers := '0123456789';
									cleanTMSID := STD.Str.Filter(STD.Str.ToUpperCase(LEFT.TMSID), AllCharacters + AllNumbers);
									finalTMSID := IF(LENGTH(STD.Str.Filter(cleanTMSID, AllCharacters)) > 0 AND LENGTH(STD.Str.Filter(cleanTMSID, AllNumbers)) > 0, cleanTMSID, ''); // A valid TMSID will consist of both Characters and Numbers
									SELF.TMSID := finalTMSID;
									temp := If(LEFT.TMSID <> '', LEFT.TMSID,LEFT.RMSID);
									SELF.Src := MDR.sourceTools.src_UCCV2;
									SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_UCCV2, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File,
																					Generic_Restriction := temp[1..3] IN PublicRecords_KEL.ECL_Functions.Constants.Marketing_Allowed3 OR temp[1..2] IN PublicRecords_KEL.ECL_Functions.Constants.Marketing_Allowed2),
									SELF := LEFT,
									SELF := []))(TMSID != '');
					SELF := LEFT,
					SELF := []));

  UCC_LinkIds_Records_Deduped := DEDUP(SORT(UCC_LinkIds_Records, UniqueID, TMSID), UniqueID, TMSID);

 // UCC Party RMSID

	UCC_Party_RMSID_Records :=
		PublicRecords_KEL.ecl_functions.DateSelector(Join(UCC_LinkIds_Records_Deduped, UCCV2.Key_Rmsid_Party(),
			Common.DoFDCJoin_UCC_Files__Party_RMSID = TRUE AND
				KEYED(LEFT.tmsid = RIGHT.tmsid),
				TRANSFORM(Layouts_FDC.Layout_UCC__Key_RMSID_Party,
					SELF.G_ProcBusUID := LEFT.UniqueID,
					SELF.B_LexIDUlt := LEFT.ULTID,
					SELF.B_LexIDOrg := LEFT.ORGID,
					SELF.B_LexIDLegal := LEFT.SELEID,
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.UCC_JOIN_LIMIT)),FALSE,FALSE);

	With_UCC_RMSID_Party := DENORMALIZE(With_UCC_Linkid_records, UCC_Party_RMSID_Records,
			LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID AND
			LEFT.B_LexIDUlt = RIGHT.B_LexIDUlt AND
			LEFT.B_LexIDOrg = RIGHT.B_LexIDOrg AND
			LEFT.B_LexIDLegal = RIGHT.B_LexIDLegal, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
							SELF.Dataset_UCC__Key_RMSID_Party := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_UCC__Key_RMSID_Party,
							AllCharacters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
							AllNumbers := '0123456789';
							cleanTMSID := STD.Str.Filter(STD.Str.ToUpperCase(LEFT.TMSID), AllCharacters + AllNumbers);
							finalTMSID := IF(LENGTH(STD.Str.Filter(cleanTMSID, AllCharacters)) > 0 AND LENGTH(STD.Str.Filter(cleanTMSID, AllNumbers)) > 0, cleanTMSID, ''); // A valid TMSID will consist of both Characters and Numbers
							SELF.TMSID := finalTMSID;
							temp := If(LEFT.TMSID <> '', LEFT.TMSID,LEFT.RMSID);
							SELF.Src := MDR.sourceTools.src_UCCV2;
							SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_UCCV2, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File,
																							Generic_Restriction := temp[1..3] IN PublicRecords_KEL.ECL_Functions.Constants.Marketing_Allowed3 OR temp[1..2] IN PublicRecords_KEL.ECL_Functions.Constants.Marketing_Allowed2),
							SELF := LEFT,
							SELF := []))(TMSID != '');
					SELF := LEFT,
					SELF := []));

// UCC Main RMSID Data

	UCC_RMSID_Main_Records :=
		PublicRecords_KEL.ecl_functions.DateSelector(Join(UCC_LinkIds_Records_Deduped, UCCV2.Key_rmsid_main(),
			Common.DoFDCJoin_UCC_Files__Main_RMSID = TRUE AND
				KEYED(LEFT.tmsid = RIGHT.tmsid),
				TRANSFORM(Layouts_FDC.Layout_UCC__Key_RMSID_Main,
					SELF.G_ProcBusUID := LEFT.UniqueID,
					SELF.B_LexIDUlt := LEFT.ULTID,
					SELF.B_LexIDOrg := LEFT.ORGID,
					SELF.B_LexIDLegal := LEFT.SELEID,
					SELF := RIGHT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.UCC_JOIN_LIMIT)),FALSE,FALSE);

	With_UCC_RMSID_Main := DENORMALIZE(With_UCC_RMSID_Party, UCC_RMSID_Main_Records,
			LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID AND
			LEFT.B_LexIDUlt = RIGHT.B_LexIDUlt AND
			LEFT.B_LexIDOrg = RIGHT.B_LexIDOrg AND
			LEFT.B_LexIDLegal = RIGHT.B_LexIDLegal, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UCC__Key_RMSID_Main := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_UCC__Key_RMSID_Main,
							AllCharacters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
							AllNumbers := '0123456789';
							cleanTMSID := STD.Str.Filter(STD.Str.ToUpperCase(LEFT.TMSID), AllCharacters + AllNumbers);
							finalTMSID := IF(LENGTH(STD.Str.Filter(cleanTMSID, AllCharacters)) > 0 AND LENGTH(STD.Str.Filter(cleanTMSID, AllNumbers)) > 0, cleanTMSID, ''); // A valid TMSID will consist of both Characters and Numbers
							SELF.TMSID := finalTMSID;
							SELF.Src := MDR.sourceTools.src_UCCV2;
							SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_UCCV2, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File,
																					Generic_Restriction := RIGHT.filing_jurisdiction IN PublicRecords_KEL.ECL_Functions.Constants.Marketing_Allowed_UCC),

							SELF := LEFT,
							SELF := []))(TMSID != '');
					SELF := LEFT,
					SELF := []));

	BBB2_kfetch_BBB_LinkIds := IF(Common.DoFDCJoin_BBB2__kfetch_BBB_LinkIds = TRUE,
																							PublicRecords_KEL.ecl_functions.DateSelector(BBB2.Key_BBB_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_BBB2_Key_BBB_LinkIds := DENORMALIZE(With_UCC_RMSID_Main, BBB2_kfetch_BBB_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BBB2__kfetch_BBB_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BBB2__kfetch_BBB_LinkIds,
																						self.src := MDR.sourceTools.src_BBB_Member,
																						SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																						self := left,
																						self := []));
					SELF := LEFT,
					SELF := []));

	BBB2_kfetch_BBB_Non_Member_LinkIds := IF(Common.DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds = TRUE,
																							PublicRecords_KEL.ecl_functions.DateSelector(BBB2.Key_BBB_Non_Member_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_BBB2_Key_BBB_Non_Member_LinkIds := DENORMALIZE(With_BBB2_Key_BBB_LinkIds, BBB2_kfetch_BBB_Non_Member_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BBB2__kfetch_BBB_Non_Member_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BBB2__kfetch_BBB_Non_Member_LinkIds,
																						self.src := MDR.sourceTools.src_BBB_Non_Member,
																						SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																						self := left,
																						self := []));
					SELF := LEFT,
					SELF := []));

	BusReg__kfetch_busreg_company_linkids := IF(Common.DoFDCJoin_BusReg__kfetch_busreg_company_linkids = TRUE,
																						PublicRecords_KEL.ecl_functions.DateSelector(BusReg.key_busreg_company_linkids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_BusReg_key_busreg_company_linkids := DENORMALIZE(With_BBB2_Key_BBB_Non_Member_LinkIds, BusReg__kfetch_busreg_company_linkids,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BusReg__kfetch_busreg_company_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BusReg__kfetch_busreg_company_linkids,
																	self.src :=  MDR.sourceTools.src_Business_Registration,
																	SELF.rawfields.sic := CleanSIC(LEFT.rawfields.sic);
																	SELF.rawfields.naics := CleanNAIC(LEFT.rawfields.naics);
																	SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																	self := left,
																	self := []));
					SELF := LEFT,
					SELF := []));

	CalBus__kfetch_Calbus_LinkIDS := IF(Common.DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS = TRUE,
																						PublicRecords_KEL.ecl_functions.DateSelector(CalBus.Key_Calbus_LinkIDS.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_CalBus_key_Calbus_LinkIDS := DENORMALIZE(With_BusReg_key_busreg_company_linkids, CalBus__kfetch_Calbus_LinkIDS,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_CalBus__kfetch_Calbus_LinkIDS := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_CalBus__kfetch_Calbus_LinkIDS,
																		self.src := MDR.sourceTools.src_CalBus,
																		SELF.naics_code := CleanNAIC(LEFT.naics_code),
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																		self := left,
																		self := []));
					SELF := LEFT,
					SELF := []));



	Cortera__kfetch_LinkID_temp := IF(Common.DoFDCJoin_Cortera__kfetch_LinkID = TRUE,
																						PublicRecords_KEL.ecl_functions.DateSelector(Cortera.Key_LinkIDs.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));


	Cortera__kfetch_LinkID := Cortera__kfetch_LinkID_temp(SeleID NOT IN Set_Large_Cortera_SeleIDs);

	With_Cortera_Key_LinkIDs := DENORMALIZE(With_CalBus_key_Calbus_LinkIDS, Cortera__kfetch_LinkID,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Cortera__kfetch_LinkID := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Cortera__kfetch_LinkID,
																		self.src := MDR.sourceTools.src_Cortera,
																		SELF.primary_sic := CleanSIC(LEFT.primary_sic);
																		SELF.primary_naics := CleanNAIC(LEFT.primary_naics);
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																		self := left,
																		self := []));
					SELF := LEFT,
					SELF := []));

	DCAV2__kfetch_LinkIds := IF(Common.DoFDCJoin_DCAV2__kfetch_LinkIds = TRUE,
																						PublicRecords_KEL.ecl_functions.DateSelector(DCAV2.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								mod_access,
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_DCAV2_Key_LinkIds := DENORMALIZE(With_Cortera_Key_LinkIDs, DCAV2__kfetch_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DCAV2__kfetch_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_DCAV2__kfetch_LinkIds,
																		self.src := MDR.sourceTools.src_DCA,
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																		SELF.rawfields.sic1 := CleanSIC(LEFT.rawfields.sic1);
																		SELF.rawfields.sic2 := CleanSIC(LEFT.rawfields.sic2);
																		SELF.rawfields.sic3 := CleanSIC(LEFT.rawfields.sic3);
																		SELF.rawfields.sic4 := CleanSIC(LEFT.rawfields.sic4);
																		SELF.rawfields.sic5 := CleanSIC(LEFT.rawfields.sic5);
																		SELF.rawfields.sic6 := CleanSIC(LEFT.rawfields.sic6);
																		SELF.rawfields.sic7 := CleanSIC(LEFT.rawfields.sic7);
																		SELF.rawfields.sic8 := CleanSIC(LEFT.rawfields.sic8);
																		SELF.rawfields.sic9 := CleanSIC(LEFT.rawfields.sic9);
																		SELF.rawfields.sic10 := CleanSIC(LEFT.rawfields.sic10);
																		SELF.rawfields.naics1 := CleanNAIC(LEFT.rawfields.naics1);
																		SELF.rawfields.naics2 := CleanNAIC(LEFT.rawfields.naics2);
																		SELF.rawfields.naics3 := CleanNAIC(LEFT.rawfields.naics3);
																		SELF.rawfields.naics4 := CleanNAIC(LEFT.rawfields.naics4);
																		SELF.rawfields.naics5 := CleanNAIC(LEFT.rawfields.naics5);
																		SELF.rawfields.naics6 := CleanNAIC(LEFT.rawfields.naics6);
																		SELF.rawfields.naics7 := CleanNAIC(LEFT.rawfields.naics7);
																		SELF.rawfields.naics8 := CleanNAIC(LEFT.rawfields.naics8);
																		SELF.rawfields.naics9 := CleanNAIC(LEFT.rawfields.naics9);
																		SELF.rawfields.naics10 := CleanNAIC(LEFT.rawfields.naics10);
																		self := left,
																		self := []));
					SELF := LEFT,
					SELF := []));

	EBR_kfetch_5600_Demographic_Data_linkids := IF(Common.DoFDCJoin_EBR_kfetch_5600_Demographic_Data_linkids = TRUE,
																						PublicRecords_KEL.ecl_functions.DateSelector(EBR.Key_5600_Demographic_Data_linkids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								mod_access,
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								linkingOptions,
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_EBR_Key_5600_Demographic_Data_linkids := DENORMALIZE(With_DCAV2_Key_LinkIds, EBR_kfetch_5600_Demographic_Data_linkids,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_EBR_kfetch_5600_Demographic_Data_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_EBR_kfetch_5600_Demographic_Data_linkids,
																	self.src := MDR.sourceTools.src_EBR,
																	SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																	SELF.SIC_1_Code := CleanSIC(LEFT.SIC_1_Code);
																	SELF.SIC_2_Code := CleanSIC(LEFT.SIC_2_Code);
																	SELF.SIC_3_Code := CleanSIC(LEFT.SIC_3_Code);
																	SELF.SIC_4_Code := CleanSIC(LEFT.SIC_4_Code);
																	SELF.Sales_Actual := (STRING)(((INTEGER)EBR.fFix_amount_codes(LEFT.Sales_Actual))*100);
																	self := left,
																	self := []));
					SELF := LEFT,
					SELF := []));

	FBNv2__kfetch_LinkIds := IF(Common.DoFDCJoin_FBNv2__kfetch_LinkIds = TRUE,
																						 	PublicRecords_KEL.ecl_functions.DateSelector(FBNv2.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								mod_access,
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_FBNv2__Key_LinkIds := DENORMALIZE(With_EBR_Key_5600_Demographic_Data_linkids, FBNv2__kfetch_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_FBNv2__kfetch_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_FBNv2__kfetch_LinkIds,
															  SELF.SIC_Code := CleanSIC(LEFT.SIC_Code),
																self.src := MDR.sourceTools.src_FBNV2_BusReg,
																SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																self := left,
																self := []));
					SELF := LEFT,
					SELF := []));

	GovData__kfetch_IRS_NonProfit_linkIDs := IF(Common.DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs = TRUE,
																						 	PublicRecords_KEL.ecl_functions.DateSelector(GovData.key_IRS_NonProfit_linkIDs.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_GovData_key_IRS_NonProfit_linkIDs := DENORMALIZE(With_FBNv2__Key_LinkIds, GovData__kfetch_IRS_NonProfit_linkIDs,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_GovData__kfetch_IRS_NonProfit_linkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_GovData__kfetch_IRS_NonProfit_linkIDs,
																self.src := MDR.sourceTools.src_IRS_Non_Profit,
																SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																SELF.Reported_Earnings := (INTEGER)TRIM((STD.Str.Filter(LEFT.Negative_Rev_Amount, '-') + (STRING)LEFT.Form_990_Revenue_Amount), ALL);
																self := left,
																self := []));
					SELF := LEFT,
					SELF := []));

	IRS5500__kfetch_LinkID := IF(Common.DoFDCJoin_IRS5500__kfetch_LinkIDs = TRUE,
																						 PublicRecords_KEL.ecl_functions.DateSelector(IRS5500.Key_LinkIDs.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_IRS5500_Key_LinkIDs := DENORMALIZE(With_GovData_key_IRS_NonProfit_linkIDs, IRS5500__kfetch_LinkID,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_IRS5500__kfetch_LinkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_IRS5500__kfetch_LinkIDs,
																self.src := MDR.sourceTools.src_IRS_5500,
																SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																self := left,
																self := []));
					SELF := LEFT,
					SELF := []));

	OSHAIR__kfetch_OSHAIR_LinkIds := IF(Common.DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds = TRUE,
																						 PublicRecords_KEL.ecl_functions.DateSelector(dx_OSHAIR.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_OSHAIR_Key_LinkIds := DENORMALIZE(With_IRS5500_Key_LinkIDs, OSHAIR__kfetch_OSHAIR_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_OSHAIR__kfetch_OSHAIR_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_OSHAIR__kfetch_OSHAIR_LinkIds,
																		self.src := MDR.sourceTools.src_OSHAIR,
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																		SELF.SIC_Code := (BIG_ENDIAN UNSIGNED INTEGER2)CleanSIC((STRING)LEFT.SIC_Code);
																		SELF.NAICs_Code := CleanNAIC(LEFT.NAICs_Code);
																		SELF.NAICs_Secondary_Code := CleanNAIC(LEFT.NAICs_Secondary_Code);
																		SELF.inspection_type_code := MAP(LEFT.safety_pg_manufacturing_insp_flag = 'X'	=> '1',
																										 LEFT.safety_pg_construction_insp_flag = 'X'	=> '2',
																										 LEFT.safety_pg_maritime_insp_flag = 'X'		=> '3',
																										 LEFT.health_pg_manufacturing_insp_flag = 'X'	=> '4',
																										 LEFT.health_pg_construction_insp_flag = 'X'	=> '5',
																										 LEFT.health_pg_maritime_insp_flag = 'X'		=> '6',
																										 LEFT.migrant_farm_insp_flag = 'X'				=> '7',
																																							'');
																		self := left,
																		self := []));
					SELF := LEFT,
					SELF := []));

	SAM__kfetch_linkID := IF(Common.DoFDCJoin_SAM__kfetch_linkID = TRUE,
																						 PublicRecords_KEL.ecl_functions.DateSelector(SAM.key_linkID.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_SAM_key_linkID := DENORMALIZE(With_OSHAIR_Key_LinkIds, SAM__kfetch_linkID,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_SAM__kfetch_linkID := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_SAM__kfetch_linkID,
																	self.src := MDR.sourceTools.src_SAM_Gov_Debarred,
																	SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																	self := left,
																	self := []));
					SELF := LEFT,
					SELF := []));

	YellowPages__kfetch_yellowpages_linkids := IF(Common.DoFDCJoin_YellowPages__kfetch_yellowpages_linkids = TRUE,
																						PublicRecords_KEL.ecl_functions.DateSelector(YellowPages.key_yellowpages_linkids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_YellowPages_key_yellowpages_linkids := DENORMALIZE(With_SAM_key_linkID, YellowPages__kfetch_yellowpages_linkids,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_YellowPages__kfetch_yellowpages_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_YellowPages__kfetch_yellowpages_linkids,
																					self.src := MDR.sourceTools.src_Yellow_Pages,
																					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																					SELF.SIC_Code := CleanSIC(LEFT.SIC_Code);
																					SELF.sic2 := CleanSIC(LEFT.sic2);
																					SELF.sic3 := CleanSIC(LEFT.sic3);
																					SELF.sic4 := CleanSIC(LEFT.sic4);
																					SELF.NAICs_Code := CleanNAIC(LEFT.NAICs_Code);
																					self := left,
																					self := []));
					SELF := LEFT,
					SELF := []));

	Infutor__NARB_kfetch_LinkIds_Unsuppressed := IF(Common.DoFDCJoin_Infutor__NARB_kfetch_LinkIds = TRUE,
																						PublicRecords_KEL.ecl_functions.DateSelector(dx_Infutor_NARB.Key_Linkids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0,
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE)); /*ScoreThreshold --> 0 = Give me everything*/

	Temp_infutor_narb := Suppress.MAC_SuppressSource(Infutor__NARB_kfetch_LinkIds_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Infutor_NARB_Key_LinkIds := DENORMALIZE(With_YellowPages_key_yellowpages_linkids, Temp_infutor_narb,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Layout_Infutor_NARB__kfetch_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Infutor_NARB__kfetch_LinkIds,
																						self.src := LEFT.Source, //not set to mdr source tools on vault
																						SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																						SELF.sic1 := CleanSIC(LEFT.sic1);
																						SELF.sic2 := CleanSIC(LEFT.sic2);
																						SELF.sic3 := CleanSIC(LEFT.sic3);
																						SELF.sic4 := CleanSIC(LEFT.sic4);
																						SELF.sic5 := CleanSIC(LEFT.sic5);
																						self := left, self := []));
					SELF := LEFT,
					SELF := []));

	Equifax__Business_Data_kfetch_LinkIDs := IF(Common.DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs = TRUE,
																						PublicRecords_KEL.ecl_functions.DateSelector(dx_Equifax_Business_Data.Key_LinkIDs.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_Equifax_Business_Data_Key_LinkIDs := DENORMALIZE(With_Infutor_NARB_Key_LinkIds, Equifax__Business_Data_kfetch_LinkIDs,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Equifax_Business__Data_kfetch_LinkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Equifax_Business__Data_kfetch_LinkIDs,
																						self.src := MDR.sourceTools.src_Equifax_Business_Data,
																						SELF.DPMBitmap := SetDPMBitmap( Source := Self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																						SELF.efx_primsic := CleanSIC(LEFT.efx_primsic);
																						SELF.efx_secsic1 := CleanSIC(LEFT.efx_secsic1);
																						SELF.efx_secsic2 := CleanSIC(LEFT.efx_secsic2);
																						SELF.efx_secsic3 := CleanSIC(LEFT.efx_secsic3);
																						SELF.efx_secsic4 := CleanSIC(LEFT.efx_secsic4);
																						SELF.efx_primnaicscode := CleanNAIC(LEFT.efx_primnaicscode);
																						SELF.efx_secnaics1 := CleanNAIC(LEFT.efx_secnaics1);
																						SELF.efx_secnaics2 := CleanNAIC(LEFT.efx_secnaics2);
																						SELF.efx_secnaics3 := CleanNAIC(LEFT.efx_secnaics3);
																						SELF.efx_secnaics4 := CleanNAIC(LEFT.efx_secnaics4);
																						self := left,
																						self := []));
					SELF := LEFT,
					SELF := []));

	EBR__Key_0010_Header_linkids := IF(Common.DoFDCJoin_EBR__Key_0010_Header_linkids = TRUE,
																		PublicRecords_KEL.ecl_functions.DateSelector(EBR.Key_0010_Header_linkids.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																							mod_access,
																							PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																							0, // ScoreThreshold --&gt; 0 = Give me everything
																							linkingOptions,
																							PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM,
																							BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));


		With_EBR_Header_linkids := DENORMALIZE(With_Equifax_Business_Data_Key_LinkIDs, EBR__Key_0010_Header_linkids,
			LEFT.G_ProcBusUID = RIGHT.UniqueID  AND
			LEFT.UIDAppend = RIGHT.UniqueID  AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_EBR__Key_0010_Header_linkids :=
							PROJECT( ROWS(RIGHT), TRANSFORM(Layouts_FDC.Layout_EBR__Key_0010_Header_linkids,
								SELF.src := MDR.SourceTools.Src_EBR,
								SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
								SELF := LEFT,
								SELF := [])),
					SELF := LEFT,
					SELF := []));

	GetFileNumbers := Dedup(sort(EBR__Key_0010_Header_linkids,file_number, uniqueid),file_number, uniqueid);

	ebr__Key_2015_Trade_Payment_Totals_FILE_NUMBER :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(GetFileNumbers, ebr.Key_2015_Trade_Payment_Totals_FILE_NUMBER,
		Common.DoFDCJoin_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER = TRUE AND
			KEYED( LEFT.file_number = RIGHT.file_number ), //AND
			// LEFT.process_date = RIGHT.process_date,
			TRANSFORM(Layouts_FDC.Layout_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER,
					SELF.UIDAppend := LEFT.UniqueID,
					SELF.G_ProcUID := LEFT.UniqueID,
					SELF.B_LexIDUlt := LEFT.ULTID,
					SELF.B_LexIDOrg := LEFT.ORGID,
					SELF.B_LexIDLegal := LEFT.SELEID,
					self.src := MDR.SourceTools.Src_EBR,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM)),FALSE,FALSE);

	With_ebr_2015_Trade_Payment_Totals_FILE_NUMBER := DENORMALIZE(With_EBR_Header_linkids, ebr__Key_2015_Trade_Payment_Totals_FILE_NUMBER,
		LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
		TRANSFORM(Layouts_FDC.Layout_FDC,
				SELF.Dataset_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER := ROWS(RIGHT),
				SELF := LEFT,
				SELF := []));

	dx_DataBridge__Key_LinkIds :=
			IF(Common.DoFDCJoin_dx_DataBridge__Key_LinkIds = TRUE,
				PublicRecords_KEL.ecl_functions.DateSelector(dx_DataBridge.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
                                                        mod_access,
                                                        PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
                                                        0,
																												PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM,
																												BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_dx_DataBridge_LinkIds := DENORMALIZE(With_ebr_2015_Trade_Payment_Totals_FILE_NUMBER, dx_DataBridge__Key_LinkIds,
		LEFT.G_ProcBusUID = RIGHT.UniqueID AND
		LEFT.B_LexIDUlt = RIGHT.ULTID AND
		LEFT.B_LexIDOrg = RIGHT.ORGID AND
		LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
		TRANSFORM(Layouts_FDC.Layout_FDC,
				SELF.Dataset_dx_DataBridge__Key_LinkIds :=
						PROJECT( ROWS(RIGHT), TRANSFORM(Layouts_FDC.Layout_dx_DataBridge__Key_LinkIds,
							SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
							SELF.sic8_1 := CleanSIC(LEFT.sic8_1),
							SELF.sic8_2 := CleanSIC(LEFT.sic8_2),
							SELF.sic8_3 := CleanSIC(LEFT.sic8_3),
							SELF.sic8_4 := CleanSIC(LEFT.sic8_4),
							SELF.sic6_1 := CleanSIC(LEFT.sic6_1),
							SELF.sic6_2 := CleanSIC(LEFT.sic6_2),
							SELF.sic6_3 := CleanSIC(LEFT.sic6_3),
							SELF.sic6_4 := CleanSIC(LEFT.sic6_4),
							SELF.sic6_5 := CleanSIC(LEFT.sic6_5),
							SELF := LEFT,
							SELF := [])),
				SELF := LEFT,
				SELF := []));

	Experian_CRDB__Key_LinkIDs :=
			IF(Common.DoFDCJoin_Experian_CRDB__Key_LinkIDs = TRUE,
				PublicRecords_KEL.ecl_functions.DateSelector(Experian_CRDB.Key_LinkIDs.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																							mod_access,
																							PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																							0,
																							PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM,
																							BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	With_Experian_CRDB__LinkIDs := DENORMALIZE(With_dx_DataBridge_LinkIds, Experian_CRDB__Key_LinkIDs,
		LEFT.G_ProcBusUID = RIGHT.UniqueID AND
		LEFT.B_LexIDUlt = RIGHT.ULTID AND
		LEFT.B_LexIDOrg = RIGHT.ORGID AND
		LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
		TRANSFORM(Layouts_FDC.Layout_FDC,
				SELF.Dataset_Experian_CRDB__Key_LinkIDs :=
						PROJECT( ROWS(RIGHT), TRANSFORM(Layouts_FDC.Layout_Experian_CRDB__Key_LinkIDs,
							SELF.src := MDR.SourceTools.src_Experian_CRDB,
							SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
							SELF := LEFT,
							SELF := [])),
				SELF := LEFT,
				SELF := []));

	Key_Gong_History_LinkID_Records :=
			IF(Common.DoFDCJoin_Gong__Key_History_LinkIds = TRUE,
				PublicRecords_KEL.ecl_functions.DateSelector(dx_Gong.key_history_LinkIds.kfetch2(
						PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
						mod_access, // CCPA suppression
						PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
						0, /*ScoreThreshold --> 0 = Give me everything*/
						PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM,
						BIPV2.IDconstants.JoinTypes.LimitTransformJoin ),FALSE,TRUE));

	With_Gong_History_LinkID_Records := DENORMALIZE(With_Experian_CRDB__LinkIDs, Key_Gong_History_LinkID_Records,
			LEFT.G_ProcBusUID = RIGHT.UniqueID  AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Gong__Key_History_LinkIds :=
							PROJECT( ROWS(RIGHT), TRANSFORM(Layouts_FDC.Layout_Gong__Key_History_LinkIds,
								SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Gong_History, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
								SELF.src := MDR.sourceTools.src_Gong_History, //many sources in business header
								SELF.Listing_Type := TRIM(RIGHT.Listing_Type_Bus + RIGHT.Listing_Type_Res + RIGHT.Listing_Type_Gov, ALL);
								SELF := LEFT,
								SELF := [])),
					SELF := LEFT,
					SELF := []));

//accident
		FLAccidents_Ecrash__Key_EcrashV2_did :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, FLAccidents_Ecrash.Key_EcrashV2_did,
				Common.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.l_did),
				TRANSFORM(Layouts_FDC.Layout_FLAccidents_Ecrash__Key_EcrashV2_did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

		FLAccidents_Ecrash__key_EcrashV2_accnbr :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(FLAccidents_Ecrash__Key_EcrashV2_did, FLAccidents_Ecrash.key_EcrashV2_accnbr,
				Common.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash = TRUE AND
				KEYED(LEFT.accident_nbr = RIGHT.l_accnbr),
				TRANSFORM(Layouts_FDC.Layout_FLAccidents_Ecrash__key_EcrashV2_accnbr,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.src := MDR.sourceTools.src_Accidents_ECrash,
					SELF.driver_license_nbr := IF(STD.Str.FilterOut(RIGHT.driver_license_nbr, '1') = '', '', RIGHT.driver_license_nbr); // Filter any repeating 1's to be blank, bad data
					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

		With_FLAccidents_Ecrash__key_EcrashV2_accnbr := DENORMALIZE(With_Gong_History_LinkID_Records, FLAccidents_Ecrash__key_EcrashV2_accnbr,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

		FLAccidents_Ecrash__Key_ECrash4 :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(FLAccidents_Ecrash__Key_EcrashV2_did, FLAccidents_Ecrash.Key_ECrash4,
				Common.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash = TRUE AND
				KEYED(LEFT.accident_nbr = RIGHT.l_acc_nbr),
				TRANSFORM(Layouts_FDC.Layout_FLAccidents_Ecrash__Key_ECrash4,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.src := MDR.sourceTools.src_Accidents_ECrash,
					SELF.driver_dl_nbr := IF(STD.Str.FilterOut(RIGHT.driver_dl_nbr, '1') = '', '', RIGHT.driver_dl_nbr); // Filter any repeating 1's to be blank, bad data
					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

		With_FLAccidents_Ecrash__Key_ECrash4 := DENORMALIZE(With_FLAccidents_Ecrash__key_EcrashV2_accnbr, FLAccidents_Ecrash__Key_ECrash4,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_FLAccidents_Ecrash__Key_ECrash4 := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));


// Property
/* If we grab a LOT of propertyevent fields to output, expect long run times*/

/* Lookup by did (both FCRA and NonFCRA)*/

	Input_Contacts_Relatives := Dedup(sort(Relatives + Clean_Input_Plus_Contacts, P_LexID, UIDAppend), P_LexID, UIDAppend);

	PropertyV2__Key_Property_Did_Records :=	// dates not kept, does not need DateSelector
				JOIN(Input_Contacts_Relatives, LN_PropertyV2.key_Property_did(Options.isFCRA),
				Common.DoFDCJoin_PropertyV2__Key_Property_Did = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_PropertyV2_Data_Temp,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_DID_JOIN_LIMIT));

/* Lookup by seleid NonFCRA)*/

	PropertyV2__Key_Property_Linkids_kFetch2_Records := IF(Common.DoFDCJoin_PropertyV2__Key_Linkids_Key = TRUE, // dates not kept, does not need DateSelector
																											LN_PropertyV2.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																											PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																											0, /*ScoreThreshold --> 0 = Give me everything*/
																											linkingOptions,
																											PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																											BIPV2.IDconstants.JoinTypes.LimitTransformJoin));

	getbiprecords := project(PropertyV2__Key_Property_Linkids_kFetch2_Records, TRANSFORM(Layouts_FDC.Layout_PropertyV2_Data_Temp,
													self.b_lexidult := left.ultid,
													self.b_lexidorg := left.orgid,
													self.b_lexidlegal := left.seleid,
													self.UIDAppend := left.uniqueid,
													SELF := LEFT,
													SELF := [];));
/* Lookup by address (both FCRA and NonFCRA)*/

		PropertyV2__Key_Addr_Fid_Records :=	// dates not kept, does not need DateSelector
			JOIN(Input_Address_BusBest_Current_Previous, LN_PropertyV2.key_addr_fid(Options.isFCRA),
				Common.DoFDCJoin_PropertyV2__Key_Addr_Fid = TRUE AND
				KEYED(LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.Predirectional = RIGHT.predir AND
					LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.AddrSuffix = RIGHT.suffix AND
					LEFT.Postdirectional = RIGHT.postdir AND
					LEFT.SecondaryRange = RIGHT.sec_range AND
					LEFT.ZIP5 = RIGHT.zip AND
					RIGHT.source_code_2 = 'P'),
				TRANSFORM(Layouts_FDC.Layout_PropertyV2_Data_Temp,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Predirectional := LEFT.Predirectional,
					SELF.PrimaryName  := LEFT.PrimaryName,
					SELF.AddrSuffix  := LEFT.AddrSuffix,
					SELF.Postdirectional  := LEFT.Postdirectional,
					SELF.City  := LEFT.City,
					SELF.State  := LEFT.State,
					SELF.ZIP5  := LEFT.ZIP5,
					SELF.SecondaryRange := LEFT.SecondaryRange,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_ADDRESS_JOIN_LIMIT));


	Property_lookup_search_records_pre  := PropertyV2__Key_Property_Did_Records + getbiprecords + PropertyV2__Key_Addr_Fid_Records;

	Property_lookup_search_records := DEDUP(SORT(Property_lookup_search_records_pre, ln_fares_id, UIDAppend),ln_fares_id, UIDAppend);

/* Consumer and Business */


	PropertyV2__Key_Assessor_Fid_Records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Property_lookup_search_records, LN_PropertyV2.key_assessor_fid(Options.isFCRA),
				Common.DoFDCJoin_PropertyV2__Key_Assessor_Fid = TRUE AND
				KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id),
				TRANSFORM(Layouts_FDC.Layout_PropertyV2_Key_Assessor_Fid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Predirectional := LEFT.Predirectional,
					SELF.PrimaryName  := LEFT.PrimaryName,
					SELF.AddrSuffix  := LEFT.AddrSuffix,
					SELF.Postdirectional  := LEFT.Postdirectional,
					SELF.City  := LEFT.City,
					SELF.State  := LEFT.State,
					SELF.ZIP5  := LEFT.ZIP5,
					SELF.SecondaryRange := LEFT.SecondaryRange,
					SELF.Src := LN_PropertyV2_Src(RIGHT.ln_fares_id),
					SELF.fireplace_indicator := RIGHT.fireplace_indicator = 'Y',
					SELF.ln_mobile_home_indicator := RIGHT.ln_mobile_home_indicator = 'Y',
					SELF.ln_condo_indicator := RIGHT.ln_condo_indicator = 'Y',
					SELF.ln_property_tax_exemption := RIGHT.ln_property_tax_exemption = 'Y',
					SELF.current_record := RIGHT.current_record = 'Y',
					SELF.owner_occupied := RIGHT.owner_occupied = 'Y',
					SELF.date_first_seen := MAP(
																			RIGHT.tax_year<>'' 						 => (UNSIGNED)RIGHT.tax_year,
																			RIGHT.assessed_value_year<>''  => (UNSIGNED)RIGHT.assessed_value_year,
																			RIGHT.market_value_year<>'' 	 => (UNSIGNED)RIGHT.market_value_year,
																			RIGHT.certification_date<>'' 	 => (UNSIGNED)RIGHT.certification_date,
																			RIGHT.tape_cut_date<>'' 			 => (UNSIGNED)RIGHT.tape_cut_date,
																			RIGHT.recording_date<>'' 			 => (UNSIGNED)RIGHT.recording_date,
																			RIGHT.prior_recording_date<>'' => (UNSIGNED)RIGHT.prior_recording_date,
																																				(UNSIGNED)RIGHT.sale_date);
					SELF.DPMBitmap := SetDPMBitmap( Source := LN_PropertyV2_Src(RIGHT.ln_fares_id), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Marketing_State := Right.State_Code),
					SELF := RIGHT,
					self.prop_correct_ffid := left.prop_correct_ffid;
					self.prop_correct_lnfare := left.prop_correct_lnfare;
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_JOIN_LIMIT)),FALSE,FALSE);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsPropAssess := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												PropertyV2__Key_Assessor_Fid_Records(trim(ln_fares_id) not in prop_correct_lnfare),
												PropertyV2__Key_Assessor_Fid_Records);

	//if there are corrections lets go find them
	GetOverridePropAssess := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_PropertyV2__Key_Assessor_Fid = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverridePropAssess(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsPropAssess := WithSuppressionsPropAssess+GetOverridePropAssess;

	With_PropertyV2__Key_Assessor_Fid_Records := DENORMALIZE(With_FLAccidents_Ecrash__Key_ECrash4, WithCorrectionsPropAssess,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_PropertyV2__Key_Assessor_Fid := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	PropertyV2__Key_Deed_Fid_Records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Property_lookup_search_records, LN_PropertyV2.key_deed_fid(Options.isFCRA),
				Common.DoFDCJoin_PropertyV2__Key_Deed_Fid = TRUE AND
				KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id),
				TRANSFORM(Layouts_FDC.Layout_PropertyV2_Key_Deed_Fid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Predirectional := LEFT.Predirectional,
					SELF.PrimaryName  := LEFT.PrimaryName,
					SELF.AddrSuffix  := LEFT.AddrSuffix,
					SELF.Postdirectional  := LEFT.Postdirectional,
					SELF.City  := LEFT.City,
					SELF.State  := IF(TRIM(RIGHT.State,ALL) != '' , RIGHT.State, LEFT.State),
					SELF.ZIP5  := LEFT.ZIP5,
					SELF.SecondaryRange := LEFT.SecondaryRange,
					SELF.current_record := RIGHT.current_record = 'Y',
					SELF.timeshare_flag := RIGHT.timeshare_flag = 'Y',
					SELF.addl_name_flag := RIGHT.addl_name_flag = 'Y',
					SELF.Date_First_Seen := IF(RIGHT.contract_date<>'',(UNSIGNED)RIGHT.contract_date,(UNSIGNED)RIGHT.recording_date),
					SELF.Src := LN_PropertyV2_Src(RIGHT.ln_fares_id),
					SELF.DPMBitmap := SetDPMBitmap( Source := LN_PropertyV2_Src(RIGHT.ln_fares_id), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Marketing_State := Right.State),
					SELF := RIGHT,
					self.prop_correct_ffid := left.prop_correct_ffid;
					self.prop_correct_lnfare := left.prop_correct_lnfare;
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_JOIN_LIMIT)),FALSE,FALSE);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsPropDeed := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												PropertyV2__Key_Deed_Fid_Records(trim(ln_fares_id) not in prop_correct_lnfare),
												PropertyV2__Key_Deed_Fid_Records);

	//if there are corrections lets go find them
	GetOverridePropDeed := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_PropertyV2__Key_Deed_Fid = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverridePropDeed(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsPropDeed := WithSuppressionsPropDeed+GetOverridePropDeed;

	With_PropertyV2__Key_Deed_Fid_Records := DENORMALIZE(With_PropertyV2__Key_Assessor_Fid_Records, WithCorrectionsPropDeed,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_PropertyV2__Key_Deed_Fid_Fid := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

PropertyV2__Key_Search_Fid_Records :=	// dates not kept, does not need DateSelector
			JOIN(Property_lookup_search_records, LN_PropertyV2.key_search_fid(Options.isFCRA),
				Common.DoFDCJoin_PropertyV2__Key_Search_Fid = TRUE AND
				KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id),
				TRANSFORM(Layouts_FDC.Layout_PropertyV2_Key_Search_Fid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.G_ProcBusUID := LEFT.G_ProcBusUID,
					SELF.B_LexIDUlt := LEFT.B_LexIDUlt,
					SELF.B_LexIDOrg := LEFT.B_LexIDOrg,
					SELF.B_LexIDLegal := LEFT.B_LexIDLegal,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Predirectional := LEFT.Predirectional,
					SELF.PrimaryName  := LEFT.PrimaryName,
					SELF.AddrSuffix  := LEFT.AddrSuffix,
					SELF.Postdirectional  := LEFT.Postdirectional,
					SELF.City  := LEFT.City,
					SELF.State  := LEFT.State,
					SELF.ZIP5  := LEFT.ZIP5,
					SELF.SecondaryRange := LEFT.SecondaryRange,
					SELF.Src := LN_PropertyV2_Src(RIGHT.ln_fares_id),
					SELF.PartyIsBuyerOrOwner := RIGHT.source_code[1] = 'O',
					SELF.PartyIsBorrower := RIGHT.source_code[1] = 'B',
					SELF.PartyIsSeller := RIGHT.source_code[1] = 'S',
					SELF.PartyIsCareOf := RIGHT.source_code[1] = 'C',
					SELF.OwnerAddress := RIGHT.source_code[2] = 'O',
					SELF.SellerAddress := RIGHT.source_code[2] = 'S',
					SELF.PropertyAddress := RIGHT.source_code[2] = 'P',
					SELF.BorrowerAddress := RIGHT.source_code[2] = 'B',
					SELF.DPMBitmap := SetDPMBitmap( Source := LN_PropertyV2_Src(RIGHT.ln_fares_id), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Marketing_State := Right.ST),
					SELF := RIGHT,
					self.prop_correct_ffid := left.prop_correct_ffid;
					self.prop_correct_lnfare := left.prop_correct_lnfare;
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_SEARCH_FID_JOIN_LIMIT));

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsPropSearch := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												PropertyV2__Key_Search_Fid_Records(trim((STRING)persistent_record_id) not in prop_correct_lnfare),
												PropertyV2__Key_Search_Fid_Records);

	//if there are corrections lets go find them
	GetOverridePropSearch := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_PropertyV2__Key_Search_Fid = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverridePropSearch(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsPropSearch := WithSuppressionsPropSearch+GetOverridePropSearch;

	With_PropertyV2__Key_Search_Fid_Records := DENORMALIZE(With_PropertyV2__Key_Deed_Fid_Records, WithCorrectionsPropSearch,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_PropertyV2__Key_Search_Fid := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	addresses_for_AVM_pre := WithCorrectionsPropSearch(DID IN InputRelativesLexids);

	addresses_for_AVM :=
		PROJECT( addresses_for_AVM_pre(prim_name <> ''), //cleaning up garbage
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
				SELF.UIDAppend       := LEFT.UIDAppend,
				SELF.PrimaryRange    := LEFT.prim_range,
				SELF.PrimaryName     := LEFT.prim_name,
				SELF.State           := LEFT.st,
				SELF.ZIP5            := LEFT.zip,
				SELF.SecondaryRange  := LEFT.sec_range,
				self := LEFT,
				Self := [];));

	addresses_for_AVM_slim := dedup(sort((addresses_for_AVM+Input_Address_Current_Previous), PrimaryRange, PrimaryName, SecondaryRange, State, ZIP5, UIDAppend ),PrimaryRange, PrimaryName, SecondaryRange, State, ZIP5, UIDAppend );//dedup by avm keyed fields

	AVM_V2__Key_AVM_Address_Records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(addresses_for_AVM_slim, IF( Options.isFCRA, AVM_V2.Key_AVM_Address_FCRA, AVM_V2.Key_AVM_Address) ,
				Common.DoFDCJoin_AVM_V2__Key_AVM_Address = TRUE AND
				KEYED(LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.State = RIGHT.st AND
					LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.SecondaryRange = RIGHT.sec_range),
				TRANSFORM(Layouts_FDC.Layout_AVM_V2_Key_AVM_Address_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Predirectional := LEFT.Predirectional,
					SELF.PrimaryName  := LEFT.PrimaryName,
					SELF.AddrSuffix  := LEFT.AddrSuffix,
					SELF.Postdirectional  := LEFT.Postdirectional,
					SELF.City  := LEFT.City,
					SELF.State  := LEFT.State,
					SELF.ZIP5  := LEFT.ZIP5,
					SELF.SecondaryRange := LEFT.SecondaryRange,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.AVM,
					SELF.DPMBitmap := SetDPMBitmap( Source := BlankString, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF.avm_correct_ffid := LEFT.avm_correct_ffid,
					SELF.avm_correct_RECORD_ID := LEFT.avm_correct_ffid,
					SELF := RIGHT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	WithSuppressionsAVM := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												AVM_V2__Key_AVM_Address_Records((trim(prim_range) + trim(prim_name) + trim(sec_range) not in avm_correct_RECORD_ID)),
												AVM_V2__Key_AVM_Address_Records);

	GetOverrideAVMAddress := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND	Common.DoFDCJoin_AVM_V2__Key_AVM_Address = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideAVM(Input_Address_Consumer_recs));//consumer only since FCRA only -- no business in FCRA


	AVM_V2__Key_AVM_Address_Norm_Records := PROJECT(WithSuppressionsAVM, TRANSFORM(Layouts_FDC.Layout_AVM_V2_Key_AVM_Address_Norm_Records,
				SELF.IsCurrent := TRUE,
				SELF := LEFT,
				SELF := [])) +
			NORMALIZE(WithSuppressionsAVM, left.history, TRANSFORM(Layouts_FDC.Layout_AVM_V2_Key_AVM_Address_Norm_Records,
				SELF.IsCurrent := FALSE,
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []));

	WithOverrideAVM := GetOverrideAVMAddress + AVM_V2__Key_AVM_Address_Norm_Records;

	With_AVM_V2_Key_AVM_Records := DENORMALIZE(With_PropertyV2__Key_Search_Fid_Records, WithOverrideAVM,
			LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_AVM_V2__Key_AVM_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));



	/*----------------------------------LienJudgement------------------------------------*/
	/*DID Keys have a parameter to say if FCRA or nonFCRA - same file layout*/
LienJudgement_DID_Key := IF(Options.IsFCRA, liensv2.key_liens_did_FCRA, liensv2.key_liens_DID);

	LienJudgement_DID_Records :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Clean_Input_Plus_Contacts, LienJudgement_DID_Key,
				Common.DoFDCJoin_LiensV2_key_liens_main_ID_Records = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_LienJudgement_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

/* kFetch2 LiensV2.Key_LinkIds.Key.  Used to Populate the SeleLienJudgment ASSOCIATION*/
	LiensV2_Key_party_Linkids_Records := IF(Common.DoFDCJoin_LiensV2_Key_party_Linkids_Records = TRUE,
														LiensV2.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
														PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
														0, /*ScoreThreshold --> 0 = Give me everything*/
														PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
														BIPV2.IDconstants.JoinTypes.LimitTransformJoin));

	Temp_LienJudgement_DID_Records := project(LienJudgement_DID_Records, transform(Layouts_FDC.Layout_Key_party_Linkids_Records,
					SELF.did := (STRING)LEFT.DID,
					SELF := LEFT,
					SELF := []));

	Temp_LienJudgement_linkids := project(LiensV2_Key_party_Linkids_Records, transform(Layouts_FDC.Layout_Key_party_Linkids_Records,
					SELF.UIDAppend := LEFT.UniqueID,
					SELF.G_ProcBusUID := LEFT.UniqueID,
					SELF := LEFT,
					SELF := []));

	LienJudgement_all := Temp_LienJudgement_DID_Records+Temp_LienJudgement_linkids;

	With_LiensV2_Key_LinkIds_Records  := DENORMALIZE(With_AVM_V2_Key_AVM_Records, LiensV2_Key_party_Linkids_Records,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
                    SELF.Dataset_LiensV2__Key_party_Linkids_Records := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Key_party_Linkids_Records,
										SELF.Src :=  PublicRecords_KEL.ECL_Functions.Constants.Set_Liens_Sources(LEFT.TMSID), //set marketing sources, else L2
										SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
										self := left,
										self := []));
					SELF := LEFT,
					SELF := []));
/*key_liens_main_id Keys have a parameter to say if FCRA or nonFCRA - same file layout*/
	LiensV2_key_liens_main_ID_Records := IF( Options.isFCRA, LiensV2.key_liens_main_ID_FCRA, LiensV2.key_liens_main_ID );

	LiensV2_key_liens_main_ID_Records_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(LienJudgement_all,LiensV2_key_liens_main_ID_Records,
			Common.DoFDCJoin_LiensV2_key_liens_main_ID_Records =True AND
				KEYED(LEFT.tmsid = RIGHT.tmsid AND
							LEFT.rmsid = RIGHT.rmsid),
				TRANSFORM(Layouts_FDC.Layout_LiensV2_key_liens_main_ID_Records,
										SELF.UIDAppend := LEFT.UIDAppend,
										SELF.G_ProcUID := LEFT.G_ProcUID,
										SELF.P_LexID := (INTEGER)LEFT.did;
										SELF.B_LexIDUlt := LEFT.ULTID,
										SELF.B_LexIDOrg := LEFT.ORGID,
										SELF.B_LexIDLegal := LEFT.SELEID,
										SELF.tmsid := LEFT.tmsid,
										SELF.rmsid := LEFT.rmsid,
										SELF := RIGHT,
										SELF := LEFT,
										SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_LiensV2_key_liens_main_ID_Records:= Suppress.MAC_SuppressSource(LiensV2_key_liens_main_ID_Records_unsuppressed, mod_access, did_field := P_LexID , data_env := Environment);

	//only drop suppression/correction records in FCRA current mode

	WithSuppressionsLiensMain := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																Key_LiensV2_key_liens_main_ID_Records(trim((string)persistent_record_id) not in lien_correct_tmsid_rmsid AND
																		(string50)tmsid + (string50)rmsid not in lien_correct_tmsid_rmsid), //this is the old way before 2012 and should never be used but putting it here just because
																Key_LiensV2_key_liens_main_ID_Records);

	//if there are corrections lets go find them
	GetOverrideLiensMain := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_LiensV2_key_liens_main_ID_Records = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideLiensMain(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsLiensMain := WithSuppressionsLiensMain+GetOverrideLiensMain;
	With_liens_main_Records := DENORMALIZE(With_LiensV2_Key_LinkIds_Records , WithCorrectionsLiensMain,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
                    SELF.Dataset_LiensV2_key_liens_main_ID_Records := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_LiensV2_key_liens_main_ID_Records,
                    SELF.Src :=  PublicRecords_KEL.ECL_Functions.Constants.Set_Liens_Sources(LEFT.TMSID),//set marketing sources, else L2
                    filingStatus := LEFT.Filing_Status[1];
                    SELF.Filing_Status := filingStatus,
                    SELF.FilingStatusDescription := filingStatus.filing_status_desc,
                    SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
										self := left,
										self := []));
					SELF := LEFT,
					SELF := []), ALL);

	/* Key_Liens_Party_ID Keys have a parameter to say if FCRA or nonFCRA - same file layout*/
	LiensV2_Key_Liens_Party_ID_Records_unsuppressed := IF( Options.isFCRA, LiensV2.Key_Liens_Party_ID_FCRA, LiensV2.Key_Liens_Party_ID	 );

	Key_LiensV2_Key_Liens_Party_ID_Records_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(LienJudgement_DID_Records,LiensV2_Key_Liens_Party_ID_Records_unsuppressed,
			Common.DoFDCJoin_LiensV2_key_liens_main_ID_Records =True AND
             KEYED(LEFT.tmsid = RIGHT.tmsid) AND
							KEYED(LEFT.rmsid = RIGHT.rmsid) AND
							left.did=(unsigned)right.did,//we only need to keep the records from party with a matching lexid, some are 0's. old shell does this too
				TRANSFORM(Layouts_FDC.Layout_LiensV2_Key_Liens_Party_ID_Records,
                    SELF.UIDAppend := LEFT.UIDAppend,
                    SELF.G_ProcUID := LEFT.G_ProcUID,
                    SELF.P_LexID := LEFT.P_LexID,
                    SELF := RIGHT,
                    SELF := LEFT,
                    SELF := []),
                    ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	LiensV2_Key_Liens_Party_ID_Records:= Suppress.MAC_SuppressSource(Key_LiensV2_Key_Liens_Party_ID_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsLiensParty := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																LiensV2_Key_Liens_Party_ID_Records(trim((string)persistent_record_id) not in lien_correct_tmsid_rmsid AND
																	(string50)tmsid + (string50)rmsid not in lien_correct_tmsid_rmsid), //this is the old way before 2012 and should never be used but putting it here just because,
																LiensV2_Key_Liens_Party_ID_Records);

	//if there are corrections lets go find them
	GetOverrideLiensParty := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_LiensV2_key_liens_main_ID_Records = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideLiensParty(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsLiensParty := WithSuppressionsLiensParty+GetOverrideLiensParty;

	With_Liens_Party_Records := DENORMALIZE(With_liens_main_Records, WithCorrectionsLiensParty,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
                  SELF.Dataset_LiensV2_Key_Liens_Party_ID_Records := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_LiensV2_Key_Liens_Party_ID_Records,
                  SELF.Src :=  PublicRecords_KEL.ECL_Functions.Constants.Set_Liens_Sources(LEFT.TMSID),//set marketing sources, else L2
                  debtor_name := Risk_Indicators.iid_constants.CreateFullName(LEFT.Title, LEFT.FName, LEFT.MName, LEFT.LName, LEFT.Name_Suffix);
                  plaintiff_name := IF(TRIM(LEFT.CName) != '', LEFT.CName, Risk_Indicators.iid_constants.CreateFullName(LEFT.Title, LEFT.FName, LEFT.MName, LEFT.LName, LEFT.Name_Suffix));
                  SELF.DebtorName := debtor_name;
                  SELF.PlaintiffName := plaintiff_name;
                  SELF.SubjectsName := IF(LEFT.name_type = 'D', debtor_name, plaintiff_name);
                  SELF.DID := (STRING)((UNSIGNED8)LEFT.DID); // Drop the leading 0's
                  SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
									self := left,
									self := []));
					SELF := LEFT,
					SELF := []), ALL);




/* Best person by Business Sele Contact Lexids from Watchdog Keys */
	//per data team watchdog ccpa records are being suppressed at build time, therefore we do not need to suppress on our end
	Best_Person__Key_Watchdog_Records := IF(Common.DoFDCJoin_Best_Person__Key_Watchdog AND FDCMiniPop,  //watchdog data is not archivable
				dx_BestRecords.append((Clean_Input_Plus_Contacts+Input6thRep)(P_LexID>0), P_LexID, wdog_perm, use_distributed := false));

	nonFCRA_watchdog_temp :=  project(Best_Person__Key_Watchdog_Records,transform(Layouts_FDC.Layout_Best_Person__Key_Watchdog, self.rec  := left._best, self  := left, self := []));


	norm_nonFCRA_watchdog := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Best_Person__Key_Watchdog, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));

	//choose if we want minifdc version or go get this data now
	nonFCRA_watchdogChooser := if(FDCMiniPop, nonFCRA_watchdog_temp, norm_nonFCRA_watchdog);

	With_Best_Person__Key_Watchdog_original := DENORMALIZE(With_Liens_Party_Records, nonFCRA_watchdogChooser,
				LEFT.UIDAppend = RIGHT.UIDAppend and
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Best_Person__Key_Watchdog := project(rows(right),transform(Layouts_FDC.Layout_Best_Person__Key_Watchdog,
																																	SELF.UIDAppend := LEFT.UIDAppend,
																																	SELF.G_ProcUID := LEFT.G_ProcUID,
																																	SELF.P_LexID := LEFT.P_LexID,
																																	SELF.src := MDR.SourceTools.src_Best_Person,
																																	SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA ,  KELPermissions := CFG_File);
																																	// self.rec  := left._best,
																																	self.rec  := left.rec,
																																	self := []));
																													SELF := LEFT,
																													SELF := []), ALL);

	With_Best_Person__Key_Watchdog_6threp := DENORMALIZE(Input6thRep, nonFCRA_watchdogChooser,
				LEFT.UIDAppend = RIGHT.UIDAppend and
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Best_Person__Key_Watchdog := project(rows(right),transform(Layouts_FDC.Layout_Best_Person__Key_Watchdog,
																																	SELF.UIDAppend := LEFT.UIDAppend,
																																	SELF.G_ProcUID := LEFT.G_ProcUID,
																																	SELF.P_LexID := LEFT.P_LexID,
																																	SELF.src := MDR.SourceTools.src_Best_Person,
																																	SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA ,  KELPermissions := CFG_File);
																																	// self.rec  := left._best,
																																	self.rec  := left.rec,
																																	self := []));
																													SELF := LEFT,
																													SELF := []), ALL);

	Best_Person__Key_Watchdog_FCRA_nonEN_Records :=
		JOIN(Input_FDC, Watchdog.Key_Watchdog_FCRA_nonEN, //watchdog data is not archivable
				Common.DoFDCJoin_Best_Person__Key_Watchdog_FCRA_nonEN = TRUE AND FDCMiniPop and
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Best_Person__Key_Watchdog_FCRA_nonEN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.src := PublicRecords_KEL.ECL_Functions.Constants.Watchdog_NonEN_FCRA,
					//source for FCRA best person has to be the below string for DRM bit Risk_Indicators.iid_constants.posEquifaxRestriction to work
					SELF.DPMBitmap := SetDPMBitmap( Source :=  SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));



	Best_Person__Key_Watchdog_FCRA_nonEQ_Records :=
		JOIN(Input_FDC, Watchdog.Key_Watchdog_FCRA_nonEQ, //watchdog data is not archivable
				Common.DoFDCJoin_Best_Person__Key_Watchdog_FCRA_nonEQ = TRUE AND FDCMiniPop and
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Best_Person__Key_Watchdog_FCRA_nonEQ,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.src := PublicRecords_KEL.ECL_Functions.Constants.Watchdog_NonEQ_FCRA,
					//source for FCRA best person has to be the below string for DRM bit Risk_Indicators.iid_constants.posEquifaxRestriction to work
					SELF.DPMBitmap := SetDPMBitmap( Source :=  SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));


	norm_FCRA_watchdognonEN := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));

	//choose if we want minifdc version or go get this data now
	FCRA_watchdogChoosernonEN := if(FDCMiniPop, Best_Person__Key_Watchdog_FCRA_nonEN_Records, norm_FCRA_watchdognonEN);

	With_Best_Person__Key_Watchdog_FCRA_nonEN := DENORMALIZE(With_Best_Person__Key_Watchdog_original, FCRA_watchdogChoosernonEN,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	norm_FCRA_watchdognonEQ := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));

	//choose if we want minifdc version or go get this data now
	FCRA_watchdogChoosernonEQ := if(FDCMiniPop, Best_Person__Key_Watchdog_FCRA_nonEQ_Records, norm_FCRA_watchdognonEQ);

	With_Best_Person__Key_Watchdog_FCRA_nonEQ := DENORMALIZE(With_Best_Person__Key_Watchdog_FCRA_nonEN, FCRA_watchdogChoosernonEQ,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	//DRM bit is checked in Common to ensure we only use the correct FCRA SSN here
	Best_SSN_FCRA := Project((FCRA_watchdogChoosernonEN+FCRA_watchdogChoosernonEQ), transform(Layouts_FDC.Layout_FDC,
																				self.P_InpClnSSN := Left.SSN ,
																				self.UIDAppend := left.UIDAppend,
																				self.g_procuid := left.g_procuid,
																				self := left,
																				self := []));

	Input_Best_SSN_FCRA := Dedup(Sort(Best_SSN_FCRA+Input_FDC, UIDAppend, P_InpClnSSN),UIDAppend, P_InpClnSSN);

	Best_SSN_NonFCRA := Project(nonFCRA_watchdogChooser(rec.did IN InputLexids), transform(Layouts_FDC.Layout_FDC, //we pass contacts into here, we only want to keep input best ssn
																				self.P_InpClnSSN := Left.rec.SSN,
																				self.UIDAppend := left.UIDAppend,
																				self.g_procuid := left.g_procuid,
																				self := left,
																				self := []));

	Input_Best_SSN_nonFCRA := Dedup(Sort(Best_SSN_NonFCRA+Input_FDC, UIDAppend, P_InpClnSSN),UIDAppend, P_InpClnSSN);


	Key_QH_SSN :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, autokey.Key_SSN(header_quick.str_AutokeyName),//non FCRA only
				Common.DoFDCJoin_Dx_Header__key_wild_SSN = TRUE AND FDCMiniPop AND
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);


	temp_QH_SSN := project(Key_QH_SSN, transform(Layouts_FDC.Layout_FDC, self.P_LexID := left.did,  self := left, self := []));
	lexids_for_QH := Clean_Input_Plus_Contacts + temp_QH_SSN+Input6thRep;

		clean_QH := dedup(sort(lexids_for_QH,	UIDAppend, P_LexID), UIDAppend, P_LexID);		// Header_Quick.Key_Did_FCRA/Header_Quick.Key_Did. FCRA/NonFCRA have the same layout.
	Header_Quick__Key_Did_Records_Unsuppressed :=  IF(common.DoFDCJoin_Doxie__Key_Header AND FDCMiniPop, PublicRecords_KEL.mas_get.Person_Quick_Header_LexID(clean_QH, Options, CFG_File));

	//if we have header from the mini fdc then we do not need to get this data again so lets normalize what we have
	norm_QuickHeader := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Header_Quick__Key_Did, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));

	//choose if we want minifdc version or go get this data now
	QuickHeaderChooser := if(FDCMiniPop, Header_Quick__Key_Did_Records_Unsuppressed, norm_QuickHeader);

	//gather lexids from input ssn
		Key_wild_SSN :=	//	No dates does not need DateSelector
			JOIN(Input_Best_SSN_nonFCRA, dx_Header.key_wild_SSN(),//non FCRA only
				Common.DoFDCJoin_Dx_Header__key_wild_SSN = TRUE AND FDCMiniPop AND
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	//transform ssn lookup key results into input layout
	temp_wild_SSN := project(Key_wild_SSN, transform(Layouts_FDC.Layout_FDC, self.P_LexID := left.did,  self := left, self := []));

	lexids_for_Header := Clean_Input_Plus_Contacts + temp_wild_SSN+Input6thRep;

	clean_Header := dedup(sort(lexids_for_Header, UIDAppend, P_LexID), UIDAppend, P_LexID);
	Doxie__Key_Header_Records_Unsuppressed := IF(common.DoFDCJoin_Doxie__Key_Header AND FDCMiniPop, PublicRecords_KEL.mas_get.Person_Header_LexID(clean_Header, Options, CFG_File, iType));

	//if we have header from the mini fdc then we do not need to get this data again so lets normalize what we have
	norm_Header := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Doxie__Key_Header, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));

	//choose if we want minifdc version or go get this data now
	HeaderChooser := if(FDCMiniPop, Doxie__Key_Header_Records_Unsuppressed, norm_Header);



	temp_QH_REcords := project(QuickHeaderChooser, transform(Layouts_FDC.Layout_Doxie__Key_Header, self := left, self := []));
	//after we decided what data we need to use lets add this together and get ready for overrides
	InputCorrectionsHeaderQuick := temp_QH_REcords+HeaderChooser;

	InputCorrectionsHeaderQuick_No_corrections := project(InputCorrectionsHeaderQuick, transform(Layouts_FDC.tempHeader, self := left, self := []));//returned if not FCRA and current
	//isminipop keeps us from calling to this key twice
	GetCorrectionsHeaderQuick := IF(FDCMiniPop And (unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Doxie__Key_Header = TRUE,
															PublicRecords_KEL.MAS_get.Header_Corrections_Function_Roxie(InputCorrectionsHeaderQuick), InputCorrectionsHeaderQuick_No_corrections);//consumer only since FCRA only -- no business in FCRA

	//already together may as well only do this once
	Header_Quick_Header_Records := PublicRecords_KEL.ecl_functions.DateSelector(Suppress.MAC_SuppressSource(GetCorrectionsHeaderQuick, mod_access, did_field := did, data_env := Environment),FALSE,FALSE);

	//need to put qh back in its layout which is basically the same as header but need this for uses
	Header_Quick__Key_Did_Records_final := Header_Quick_Header_Records(headerrec = FALSE);
	Doxie__Key_Header_Records_final := Header_Quick_Header_Records(headerrec = TRUE);

	With_Doxie__Key_QuickHeader_original := DENORMALIZE(With_Best_Person__Key_Watchdog_FCRA_nonEQ, Header_Quick__Key_Did_Records_final,
				LEFT.UIDAppend = RIGHT.UIDAppend and
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Header_Quick__Key_Did :=  project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Header_Quick__Key_Did,
									SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(left.src), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PublicRecords_KEL.ECL_Functions.Constants.PreGLBRegulatedRecord(left.Src, left.dt_nonglb_last_seen, left.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := PublicRecords_KEL.ECL_Functions.Constants.GetDPPAState(PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(left.src)), KELPermissions := CFG_File, Is_Consumer_Header := TRUE),
									SELF := LEFT,
									SELF := []));
					SELF := LEFT,
					SELF := []));

	With_Doxie__Key_QuickHeader_6threp := DENORMALIZE(With_Best_Person__Key_Watchdog_6threp, Header_Quick__Key_Did_Records_final,
				LEFT.UIDAppend = RIGHT.UIDAppend and
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Header_Quick__Key_Did :=  project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Header_Quick__Key_Did,
									SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(left.src), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PublicRecords_KEL.ECL_Functions.Constants.PreGLBRegulatedRecord(left.Src, left.dt_nonglb_last_seen, left.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := PublicRecords_KEL.ECL_Functions.Constants.GetDPPAState(PublicRecords_KEL.ECL_Functions.Constants.SetQuickHeaderSource(left.src)), KELPermissions := CFG_File, Is_Consumer_Header := TRUE),
									SELF := LEFT,
									SELF := []));
					SELF := LEFT,
					SELF := []));

	With_Doxie__Key_Header_original := DENORMALIZE(With_Doxie__Key_QuickHeader_original, Doxie__Key_Header_Records_final,
				LEFT.UIDAppend = RIGHT.UIDAppend and
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie__Key_Header := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Doxie__Key_Header,
						SELF.DPMBitmap := SetDPMBitmap( Source := left.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PublicRecords_KEL.ECL_Functions.Constants.PreGLBRegulatedRecord(left.Src, left.dt_nonglb_last_seen, left.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := PublicRecords_KEL.ECL_Functions.Constants.GetDPPAState(RIGHT.src), Marketing_State := left.st, KELPermissions := CFG_file, Is_Consumer_Header := TRUE),
						SELF := LEFT,
						SELF := []));
					SELF := LEFT,
					SELF := []));

	With_Doxie__Key_Header_6threp := DENORMALIZE(With_Doxie__Key_QuickHeader_6threp, Doxie__Key_Header_Records_final,
				LEFT.UIDAppend = RIGHT.UIDAppend and
				left.g_procuid = right.g_procuid, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie__Key_Header := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Doxie__Key_Header,
						SELF.DPMBitmap := SetDPMBitmap( Source := left.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PublicRecords_KEL.ECL_Functions.Constants.PreGLBRegulatedRecord(left.Src, left.dt_nonglb_last_seen, left.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := PublicRecords_KEL.ECL_Functions.Constants.GetDPPAState(RIGHT.src), Marketing_State := left.st, KELPermissions := CFG_file, Is_Consumer_Header := TRUE),
						SELF := LEFT,
						SELF := []));
					SELF := LEFT,
					SELF := []));

	// Header: consumer only
	Key_Header_Addr_Hist_temp :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN((Clean_Input_Plus_Contacts+Input6thRep), dx_Header.key_addr_hist(iType),
				Common.DoFDCJoin_Header__Key_Addr_Hist = TRUE AND FDCMiniPop AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_Header__Key_Addr_Hist_temp,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);


	Key_Header_Addr_Hist :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Key_Header_Addr_Hist_temp, AID_Build.Key_AID_Base,
				Common.DoFDCJoin_Header__Key_Addr_Hist = TRUE AND FDCMiniPop AND
				KEYED(LEFT.Rawaid = RIGHT.Rawaid),
				TRANSFORM(Layouts_FDC.Layout_Header__Key_Addr_Hist,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_SEARCH_FID_JOIN_LIMIT)),FALSE,FALSE);

	AddrHistToHeader := join(Key_Header_Addr_Hist, Doxie__Key_Header_Records_final,
											LEFT.UIDAppend = RIGHT.UIDAppend and FDCMiniPop AND
											left.s_did<>0 and left.zip<>'' and left.prim_name<>'' and
											left.s_did=right.did and
											left.zip=right.zip and
											left.prim_range=right.prim_range and
											left.prim_name=right.prim_name and
											ut.NNEQ(left.sec_range,right.sec_range),  // allow for NNEQ on sec range
												TRANSFORM(Layouts_FDC.Layout_Header__Key_Addr_Hist,
													SELF.Src := right.src,
													SELF.DPMBitmap := SetDPMBitmap( Source := right.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
													self := left),
													left outer);

	AddrHistToHeaderSlim 	:= Dedup(sort(AddrHistToHeader, WHOLE RECORD));

 	norm_mini_addr_Hist := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Header__Key_Addr_Hist, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));

	Addr_Hist_Records := if(FDCMiniPop, AddrHistToHeaderSlim, norm_mini_addr_Hist);

	With_Header_Addr_Hist_Records_original := DENORMALIZE(With_Doxie__Key_Header_original, Addr_Hist_Records,
		LEFT.UIDAppend = RIGHT.UIDAppend and
				left.g_procuid = right.g_procuid, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Header__Key_Addr_Hist := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	With_Header_Addr_Hist_Records_6threp := DENORMALIZE(With_Doxie__Key_Header_6threp, Addr_Hist_Records,
		LEFT.UIDAppend = RIGHT.UIDAppend and
				left.g_procuid = right.g_procuid, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Header__Key_Addr_Hist := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));


    Death_MasterV2_SSN_SSA_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(IF(Options.IsFCRA, Input_Best_SSN_FCRA, Input_Best_SSN_nonFCRA), Death_Master.key_ssn_ssa(Options.IsFCRA),
				Common.DoFDCJoin_DeathMaster__Key_SSN_SSA = TRUE AND
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN = RIGHT.ssn),
				TRANSFORM(Layouts_FDC.Layout_Death_MasterV2__key_ssn_ssa,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.P_InpClnSSN := LEFT.P_InpClnSSN,
					SELF.Src := RIGHT.src,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := GLBARegulatedDeathMasterRecord(RIGHT.glb_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	Key_Death_MasterV2_SSN_SSA := Suppress.MAC_SuppressSource(Death_MasterV2_SSN_SSA_unsuppressed, mod_access, did_field := did, gsid_field := global_sid, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsDeathSSN := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												Key_Death_MasterV2_SSN_SSA((trim((string)state_death_id)) not in Death_correct_record_id AND
																			(trim((string)did) + trim((string)state_death_id)) not in Death_correct_record_id),
												Key_Death_MasterV2_SSN_SSA);

	GetOverrideDeathSSN := Project(GetOverrideDeath,
																			transform(Layouts_FDC.Layout_Death_MasterV2__key_ssn_ssa,
																			self := left,
																			self := []));

	WithCorrectionsDeathSSN := WithSuppressionsDeathSSN+GetOverrideDeathSSN;

	With_Death_MasterV2_SSN_SSA :=
		DENORMALIZE(With_Header_Addr_Hist_Records_original, WithCorrectionsDeathSSN,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Death_MasterV2__key_ssn_ssa := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));
	//----------------------------------surname------------------------------------

	property_addresses_for_Advo_pre := PropertyV2__Key_Search_Fid_Records(DID IN InputLexids);//advo we need to search by input proeprties the input lexid is tied to, getting rid of unneeded inputs

	property_addresses_for_Advo :=
		PROJECT( property_addresses_for_Advo_pre(zip <> '' AND prim_name <> ''),  //cleaning up garbage
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
				SELF.UIDAppend       := LEFT.UIDAppend,
				SELF.PrimaryRange    := LEFT.prim_range,
				SELF.PrimaryName     := LEFT.prim_name,
				SELF.AddrSuffix      := LEFT.suffix,
				SELF.Predirectional  := LEFT.predir,
				SELF.Postdirectional := LEFT.postdir,
				SELF.ZIP5            := LEFT.zip,
				SELF.SecondaryRange  := LEFT.sec_range,
				self := LEFT,
				Self := [];));

	// Search advo by all address hierarchy records that are tied to the input LexID. Since we also search address hierarchy by business contacts, we need to do some special filtering here.
	addr_hist_addresses_for_advo_pre := NORMALIZE(With_Header_Addr_Hist_Records_original, LEFT.Dataset_Header__Key_Addr_Hist, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));
	addr_hist_addresses_for_advo_filtered := addr_hist_addresses_for_advo_pre(P_LexID = s_did);

	addr_hist_addresses_for_advo :=
		PROJECT( addr_hist_addresses_for_advo_filtered(zip <> '' AND prim_name <> ''),  //cleaning up garbage
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
				SELF.UIDAppend       := LEFT.UIDAppend,
				SELF.PrimaryRange    := LEFT.prim_range,
				SELF.PrimaryName     := LEFT.prim_name,
				SELF.AddrSuffix      := LEFT.suffix,
				SELF.Predirectional  := LEFT.predir,
				SELF.Postdirectional := LEFT.postdir,
				SELF.ZIP5            := LEFT.zip,
				SELF.SecondaryRange  := LEFT.sec_range,
				self := LEFT,
				Self := [];));

	addresses_for_Advo_slim := dedup(sort((property_addresses_for_Advo + addr_hist_addresses_for_advo + Input_Best_and_Business_Address), PrimaryRange, PrimaryName, AddrSuffix, SecondaryRange, Predirectional, Postdirectional, SecondaryRange, ZIP5, UIDAppend )
																								,PrimaryRange, PrimaryName, AddrSuffix, SecondaryRange, Predirectional, Postdirectional, SecondaryRange, ZIP5, UIDAppend  );//dedup by advo keyed fields

	// ADVO: business and consumer
	ADVO__Key_Addr1_History := IF(Options.IsFCRA, ADVO.Key_Addr1_FCRA_History, ADVO.Key_Addr1_History);
	Key_Advo_Addr1_History_Records :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(addresses_for_Advo_slim, ADVO__Key_Addr1_History,
				Common.DoFDCJoin_ADVO__Key_Addr1_History = TRUE AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND
				KEYED(LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.AddrSuffix = RIGHT.addr_suffix AND
					LEFT.Predirectional = RIGHT.predir AND
					LEFT.Postdirectional = RIGHT.postdir AND
					LEFT.SecondaryRange = RIGHT.sec_range),
				TRANSFORM(Layouts_FDC.Layout_ADVO__Key_Addr1_History,
					SELF.Src := MDR.sourceTools.src_advo_valassis,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_advo_valassis, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	WithSuppressionsAdvoHist := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
												Key_Advo_Addr1_History_Records((trim(zip) + trim(prim_range) + trim(prim_name) + trim(sec_range) not in ADVO_correct_record_id)),
												Key_Advo_Addr1_History_Records);

	GetOverrideAdvoAddress := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND	Common.DoFDCJoin_ADVO__Key_Addr1_History = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideAdvo(Input_Address_Consumer_recs));//consumer only since FCRA only -- no business in FCRA

	WithOverrideAdvoHist := GetOverrideAdvoAddress + WithSuppressionsAdvoHist;

	With_ADVO_History_Records := DENORMALIZE(With_Death_MasterV2_SSN_SSA, Key_Advo_Addr1_History_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_ADVO__Key_Addr1_History := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));


	temp_contacts_surnames := project(Temp_Bus_contact, transform(Layouts_FDC.Layout_FDC, self.P_InpClnNameLast := left.contact_name.lname, self.UIDAppend := left.UniqueID, self.g_procuid := left.UniqueID, self := left, self := []));


 Input_surnames := Input_FDC + temp_contacts_surnames(P_InpClnNameLast<>'');

Input_surnames_dedup := DEDUP(SORT(Input_surnames,UIDAppend,P_InpClnNameLast),UIDAppend,P_InpClnNameLast);
dx_CFPB__key_Census_Surnames := IF( Options.isFCRA, dx_ConsumerFinancialProtectionBureau.key_census_surnames(TRUE), dx_ConsumerFinancialProtectionBureau.key_census_surnames(False));
	Key_CFPB__key_Census_Surnames :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_surnames_dedup, dx_CFPB__key_Census_Surnames,
			Common.DoFDCJoin_dx_CFPB__key_Census_Surnames =TRUE AND
			LEFT.P_InpClnNameLast <> '' AND
				KEYED(LEFT.P_InpClnNameLast =RIGHT.name),
				TRANSFORM(Layouts_FDC.Layout_dx_CFPB_key_Census_Surnames,
					SELF.name := LEFT.P_InpClnNameLast,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.CFBPSurname,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src , FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_Key_CFPB__key_Census_Surnames := DENORMALIZE(With_ADVO_History_Records, Key_CFPB__key_Census_Surnames,
				LEFT.UIDAppend=RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_dx_CFPB_key_Census_Surnames := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	//----------------------------------Household------------------------------------
	Key_dx_Header__key_did_hhid :=
			JOIN(Clean_Input_Plus_Contacts, dx_Header.key_did_hhid(),//no dates - does not need date selected.
			Common.DoFDCJoin_dx_Header__key_did_hhid =TRUE AND
			LEFT.P_LexID <> 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_dx_Header__key_did_hhid,
					SELF.did := LEFT.P_LexID,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.HouseHoldKeys,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.REL_HHID_Join_LIMIT));

	With_Key_dx_Header__key_did_hhid := DENORMALIZE(With_Key_CFPB__key_Census_Surnames, Key_dx_Header__key_did_hhid,
				LEFT.UIDAppend=RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_dx_Header__key_did_hhid := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	deduped_did_hhid:= DEDUP(SORT(Key_dx_Header__key_did_hhid,UIDAppend,hhid),UIDAppend,hhid);
	//hhid returned is used to search did
	Key_dx_Header__key_hhid_did :=
			JOIN(deduped_did_hhid, dx_Header.key_hhid_did(), //no dates - does not need date selected.
			Common.DoFDCJoin_dx_Header__key_did_hhid =TRUE AND
			LEFT.hhid_relat <> 0 AND
				KEYED(LEFT.hhid_relat =RIGHT.hhid_relat),
				TRANSFORM(Layouts_FDC.Layout_dx_Header__key_hhid_did,
					SELF.hhid_relat := LEFT.hhid_relat,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.HouseHoldKeys,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.REL_HHID_Join_LIMIT));

	With_Key_dx_Header__key_hhid_did := DENORMALIZE(With_Key_dx_Header__key_did_hhid, Key_dx_Header__key_hhid_did,
				LEFT.UIDAppend=RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_dx_Header__key_hhid_did := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	TempGeoInputPrevCurr := dedup(sort(Input_and_Contact_Current_Previous, UIDAppend, AddressGeoLink),UIDAppend, AddressGeoLink);

	Key_BLKGRP := IF( Options.isFCRA, dx_ConsumerFinancialProtectionBureau.Key_BLKGRP(TRUE), dx_ConsumerFinancialProtectionBureau.Key_BLKGRP(False));

	dx_ConsumerFinancialProtectionBureau__Key_BLKGRP :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(TempGeoInputPrevCurr, Key_BLKGRP,
			Common.DoFDCJoin_dx_CFPB__key_BLKGRP =TRUE AND
			LEFT.AddressGeoLink <> '' AND
				KEYED(LEFT.AddressGeoLink =RIGHT.geoid10_blkgrp),
				TRANSFORM(Layouts_FDC.Layout_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.geoid10_blkgrp := LEFT.AddressGeoLink,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.CFBPGeolinks,
					SELF.DPMBitmap := SetDPMBitmap( Source := '', FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);


	With_Key_BLKGRP := DENORMALIZE(With_Key_dx_Header__key_hhid_did, dx_ConsumerFinancialProtectionBureau__Key_BLKGRP,
				LEFT.UIDAppend=RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	key_BLKGRP_attr_over18 := IF( Options.isFCRA, dx_ConsumerFinancialProtectionBureau.key_BLKGRP_attr_over18(TRUE), dx_ConsumerFinancialProtectionBureau.key_BLKGRP_attr_over18(False));

	dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18 :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(TempGeoInputPrevCurr, key_BLKGRP_attr_over18,
			Common.DoFDCJoin_dx_CFPB__key_BLKGRP =TRUE AND
			LEFT.AddressGeoLink <> '' AND
				KEYED(LEFT.AddressGeoLink =RIGHT.geoind),
				TRANSFORM(Layouts_FDC.Layout_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.geoind := LEFT.AddressGeoLink,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.CFBPGeolinks,
					SELF.DPMBitmap := SetDPMBitmap( Source := '', FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_key_BLKGRP_attr_over18 := DENORMALIZE(With_Key_BLKGRP, dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18,
				LEFT.UIDAppend=RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18 := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

//MAS is only using the nonFCRA version of these keys right now, however the FCRA version was left here if that changes in the future.
Key_HuntFish_Did := IF( Options.isFCRA, eMerges.Key_HuntFish_Did(TRUE), eMerges.Key_HuntFish_Did(FALSE) );
	eMerges__Key_HuntFish_Did :=
			JOIN(Input_FDC, Key_HuntFish_Did,
			Common.DoFDCJoin_eMerges__Key_HuntFish_Rid =TRUE AND
			LEFT.P_LexID <> 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_eMerges__Key_HuntFish_Did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

//MAS is only using the nonFCRA version of these keys right now, however the FCRA version was left here if that changes in the future.
Key_HuntFish_Rid := IF( Options.isFCRA, eMerges.Key_HuntFish_Rid(TRUE), eMerges.Key_HuntFish_Rid(FALSE) );//no ccpa as of 5/12/2020
	eMerges__Key_HuntFish_Rid :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(eMerges__Key_HuntFish_Did, Key_HuntFish_Rid,
					Common.DoFDCJoin_eMerges__Key_HuntFish_Rid = TRUE AND
					KEYED(LEFT.rid = RIGHT.rid),
				TRANSFORM(Layouts_FDC.Layout_eMerges__Key_HuntFish_Rid,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.src := PublicRecords_KEL.ECL_Functions.Constants.Hunt_Fish_Source_MAS;//needed for marketing exception list
					self.IsResident := IF(right.resident = 'Y',TRUE, FALSE);
					self.IsHunting := IF(right.hunt = 'Y',TRUE, FALSE);
					self.IsFishing := IF(right.fish = 'Y',TRUE, FALSE);
					self.did := (INTEGER)right.did_out; //lots of leading 0's
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);


	With_eMerges__Key_HuntFish_Rid := DENORMALIZE(With_key_BLKGRP_attr_over18, eMerges__Key_HuntFish_Rid,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_eMerges__Key_HuntFish_Rid := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

//MAS is only using the nonFCRA version of these keys right now, however the FCRA version was left here if that changes in the future.
key_ccw_did := IF( Options.isFCRA, eMerges.key_ccw_did(TRUE), eMerges.key_ccw_did(FALSE) );
	eMerges__key_ccw_did :=
			JOIN(Input_FDC, key_ccw_did,
			Common.DoFDCJoin_eMerges__key_ccw_rid =TRUE AND
			LEFT.P_LexID <> 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did_out6),
				TRANSFORM(Layouts_FDC.Layout_eMerges__key_ccw_did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

//MAS is only using the nonFCRA version of these keys right now, however the FCRA version was left here if that changes in the future.
key_ccw_rid := IF( Options.isFCRA, eMerges.key_ccw_rid(TRUE), eMerges.key_ccw_rid(FALSE) );//no ccpa as of 5/12/2020
	eMerges__key_ccw_rid :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(eMerges__key_ccw_did, key_ccw_rid,
					Common.DoFDCJoin_eMerges__key_ccw_rid = TRUE AND
					KEYED(LEFT.rid = RIGHT.rid),
				TRANSFORM(Layouts_FDC.Layout_eMerges__key_ccw_rid,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.src := PublicRecords_KEL.ECL_Functions.Constants.CCW_Source_MAS;//needed for marketing exception list
					self.did := (INTEGER)right.did_out; //lots of leading 0's
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

	With_eMerges__key_ccw_rid := DENORMALIZE(With_eMerges__Key_HuntFish_Rid, eMerges__key_ccw_rid,
			LEFT.UIDAppend = RIGHT.UIDAppend AND
			LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_eMerges__key_ccw_rid := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

//MAS is only using the FCRA version of these keys right now, however the nonFCRA version was left here if that changes in the future.
Key_SexOffender_DID := IF( Options.isFCRA,SexOffender.Key_SexOffender_DID(TRUE), SexOffender.Key_SexOffender_DID(FALSE) );
	SexOffender__Key_SexOffender_DID :=
			JOIN(Input_FDC, Key_SexOffender_DID,
			Common.DoFDCJoin_Key_SexOffender =TRUE AND
			LEFT.P_LexID <> 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_SexOffender__Key_SexOffender_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

//MAS is only using the FCRA version of these keys right now, however the nonFCRA version was left here if that changes in the future.
Key_SexOffender_SPK := IF( Options.isFCRA, SexOffender.Key_SexOffender_SPK(TRUE), SexOffender.Key_SexOffender_SPK(FALSE) );//no ccpa as of 5/12/2020
	SexOffender__Key_SexOffender_SPK :=
		PublicRecords_KEL.ecl_functions.DateSelector(JOIN(SexOffender__Key_SexOffender_DID, Key_SexOffender_SPK,
					Common.DoFDCJoin_Key_SexOffender = TRUE AND
					KEYED(LEFT.seisint_primary_key = RIGHT.sspk),
				TRANSFORM(Layouts_FDC.Layout_SexOffender__Key_SexOffender_SPK,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_sexoffender;
					SELF.DPMBitmap := SetDPMBitmap( Source := self.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

		WithSuppressionsSexOffender := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																		SexOffender__Key_SexOffender_SPK((string)offender_persistent_id NOT IN SexOffender_correct_record_id),
																		SexOffender__Key_SexOffender_SPK);

		GetOverrideSexOffender := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Key_SexOffender = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideSexOffenders(input_fdc));//consumer only since FCRA only -- no business in FCRA

		WithCorrectionsSexOffender := WithSuppressionsSexOffender+GetOverrideSexOffender;

	With_SexOffender__Key_SexOffender_SPK := DENORMALIZE(With_eMerges__key_ccw_rid, WithCorrectionsSexOffender,
			LEFT.UIDAppend = RIGHT.UIDAppend AND
			LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_SexOffender__Key_SexOffender_SPK := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	key_thrive_did := IF( Options.isFCRA, thrive.keys().Did_fcra.qa, thrive.keys().did.qa );//no ccpa as of 5/12/2020

	thrive__keys__Did_qa := PublicRecords_KEL.ecl_functions.DateSelector(JOIN(input_FDC, key_thrive_did,
					Common.DoFDCJoin_Thrive__Key_did_QA = TRUE AND
					LEFT.P_LexID <> 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Thrive__Key___Did_QA,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.src := right.src,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),FALSE,FALSE);

		WithSuppressionsThrive := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA,
																				thrive__keys__Did_qa(persistent_record_id NOT IN thrive_correct_record_id),
																				thrive__keys__Did_qa);

		GetOverrideThrive := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Thrive__Key_did_QA = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideThrive(input_fdc));//consumer only since FCRA only -- no business in FCRA

		WithCorrectionsThrive := WithSuppressionsThrive+GetOverrideThrive;

	With_thrive__keys__Did_qa := DENORMALIZE(With_SexOffender__Key_SexOffender_SPK, WithCorrectionsThrive,
			LEFT.UIDAppend = RIGHT.UIDAppend AND
			LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Thrive__Key___Did_QA := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	fraudpoint3__Key_DID :=
		JOIN(input_fdc, fraudpoint3.Key_DID,
					Common.DoFDCJoin_fraudpoint3__Key_DID = TRUE AND
					LEFT.P_LexID <> 0 AND
					KEYED(LEFT.P_LexID = RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_fraudpoint3__Key_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.FraudPoint3Source;
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_fraudpoint3__Key_DID := DENORMALIZE(With_thrive__keys__Did_qa, fraudpoint3__Key_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_fraudpoint3__Key_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

//InQuIrIeS FCRA
Key_AccLogs_FCRA_Address :=
		PublicRecords_KEL.ECL_Functions.DateSelector(JOIN(Input_Address_Current, Inquiry_AccLogs.Key_FCRA_Address, //need to search inq by addr with current addr too
				Common.DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA = TRUE AND
				(INTEGER)LEFT.ZIP5 > 0 AND
				KEYED(LEFT.ZIP5 = RIGHT.ZIP AND
				LEFT.PrimaryName = right.prim_name AND
				LEFT.PrimaryRange = right.prim_range and
				left.SecondaryRange = right.Sec_range) AND
							//lets dump the inquiries we don't care about
							((trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.FCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes) and
							trim(right.search_info.transaction_id, left, right) not in left.inquiries_correct_record_id),  // don't include any records from raw data that have been corrected,
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_Address,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.ZIP5 := LEFT.ZIP5,
					SELF.PrimaryName := LEFT.PrimaryName,
					SELF.PrimaryRange := LEFT.PrimaryRange,
					SELF.SecondaryRange := LEFT.SecondaryRange,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

	GetOverrideInquiry := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND
																(Common.DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA = TRUE OR Common.DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA = TRUE OR
																Common.DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA = TRUE OR Common.DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA = TRUE),
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options).GetOverrideInquiry(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	GetOverrideInquiryAddress := Project(GetOverrideInquiry,
																			transform(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_Address,
																			self := left,
																			self := []));

	WithCorrectionsInquiryAddress := Key_AccLogs_FCRA_Address+GetOverrideInquiryAddress;

	With_AccLogs_FCRA_Address_Records := DENORMALIZE(With_fraudpoint3__Key_DID, WithCorrectionsInquiryAddress,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Key_FCRA_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

		Key_AccLogs_FCRA_DID :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Inquiry_AccLogs.Key_FCRA_DID,
				Common.DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.appended_adl) AND
							//lets dump the inquiries we don't care about
							((trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.FCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes) and
							trim(right.search_info.transaction_id, left, right) not in left.inquiries_correct_record_id),  // don't include any records from raw data that have been corrected,,
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs;
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

	WithCorrectionsInquiryDid := Key_AccLogs_FCRA_DID+GetOverrideInquiry;

	With_AccLogs_FCRA_DID_Records := DENORMALIZE(With_AccLogs_FCRA_Address_Records, WithCorrectionsInquiryDid,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Key_FCRA_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

Key_AccLogs_FCRA_SSN :=
		PublicRecords_KEL.ECL_Functions.DateSelector(JOIN(Input_Best_SSN_FCRA, Inquiry_AccLogs.Key_FCRA_SSN, //input and best ssn searching
				Common.DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA = TRUE AND
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN = RIGHT.ssn) AND
							//lets dump the inquiries we don't care about
							((trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.FCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes) and
							trim(right.search_info.transaction_id, left, right) not in left.inquiries_correct_record_id),  // don't include any records from raw data that have been corrected,,
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_SSN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_InpClnSSN := LEFT.P_InpClnSSN,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

	GetOverrideInquirySSN := Project(GetOverrideInquiry,
																			transform(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_SSN,
																			self := left,
																			self := []));

	WithCorrectionsInquirySSN := Key_AccLogs_FCRA_SSN+GetOverrideInquirySSN;

	With_AccLogs_FCRA_SSN_Records := DENORMALIZE(With_AccLogs_FCRA_DID_Records, WithCorrectionsInquirySSN,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Key_FCRA_SSN := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Key_AccLogs_FCRA_Phone :=
		PublicRecords_KEL.ECL_Functions.DateSelector(JOIN(Input_Phone_All, Inquiry_AccLogs.Key_FCRA_Phone,
				Common.DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA = TRUE AND
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone = RIGHT.Phone10) AND
							//lets dump the inquiries we don't care about
							((trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.FCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes)) and
							trim(right.search_info.transaction_id, left, right) not in left.inquiries_correct_record_id,  // don't include any records from raw data that have been corrected,,
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Phone := LEFT.Phone,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

	GetOverrideInquiryPhone := Project(GetOverrideInquiry,
																			transform(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_Phone,
																			self := left,
																			self := []));

	WithCorrectionsInquiryPhone := Key_AccLogs_FCRA_Phone+GetOverrideInquiryPhone;


	With_AccLogs_FCRA_Phone_Records := DENORMALIZE(With_AccLogs_FCRA_SSN_Records, WithCorrectionsInquiryPhone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Key_FCRA_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	//deltabase results
	//we only search deltabase by inputs, not by best information
	//to see the delta base results you MUST turn on 	IncludeInquiry AND IncludeInquiryDeltaBase AND pass in a gateway
	GetInquiryDeltaBase := IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_DeltaBase = TRUE,(PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).GetDeltaBaseRec(Input)));

	//deltabase is only used for consumer and current runs
	//we are not currently running busienss reps through the delta base since it was not needed at this point
	//we can turn this on by passing in the gateway into the busienss bwr if needed at a later date
	//these are normalized below with full & updates
	deltabase_address_unsuppressed :=  IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address = TRUE,PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).Inquiry_Address(GetInquiryDeltaBase));
	deltaBase_did_unsuppressed :=  IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID = TRUE,PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).Inquiry_Did(GetInquiryDeltaBase));
	deltaBase_email_unsuppressed :=  IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_EMAIL = TRUE,PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).Inquiry_Email(GetInquiryDeltaBase));
	deltaBase_phone_unsuppressed :=  IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone = TRUE,PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).Inquiry_Phone(GetInquiryDeltaBase));
	deltaBase_ssn_unsuppressed :=  IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN = TRUE,PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).Inquiry_SSN(GetInquiryDeltaBase));


//Inquiries nonFCRA Address
	Key_AccLogs_Inquiry_Table_Address_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Address_Current, Inquiry_AccLogs.Key_Inquiry_Address,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address = TRUE AND
				(INTEGER)LEFT.ZIP5 > 0 AND
				KEYED(LEFT.ZIP5 = RIGHT.ZIP AND
				LEFT.PrimaryName = right.prim_name AND
				LEFT.PrimaryRange = right.prim_range and
				left.SecondaryRange = right.Sec_range) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Address,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.ZIP5 := LEFT.ZIP5,
					SELF.PrimaryName := LEFT.PrimaryName,
					SELF.PrimaryRange := LEFT.PrimaryRange,
					SELF.SecondaryRange := LEFT.SecondaryRange,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.IsUpdateRecord := FALSE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

		Key_AccLogs_Inquiry_Table_Update_Address_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Address_Current, Inquiry_AccLogs.Key_Inquiry_Address_Update,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address = TRUE AND
				(INTEGER)LEFT.ZIP5 > 0 AND
				KEYED(LEFT.ZIP5 = RIGHT.ZIP AND
				LEFT.PrimaryName = right.prim_name AND
				LEFT.PrimaryRange = right.prim_range and
				left.SecondaryRange = right.Sec_range) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Address,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.ZIP5 := LEFT.ZIP5,
					SELF.PrimaryName := LEFT.PrimaryName,
					SELF.PrimaryRange := LEFT.PrimaryRange,
					SELF.SecondaryRange := LEFT.SecondaryRange,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.IsUpdateRecord := TRUE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

	Gather_Address_Inquiries := Key_AccLogs_Inquiry_Table_Address_unsuppressed+Key_AccLogs_Inquiry_Table_Update_Address_unsuppressed+deltabase_address_unsuppressed;

	Address_Inquiries_Suppress := Suppress.MAC_SuppressSource(Gather_Address_Inquiries, mod_access, did_field := person_q.appended_adl, gsid_field := ccpa.global_sid, data_env := Environment);

	With_AccLogs_Inquiry_Address_Records := DENORMALIZE(With_AccLogs_FCRA_Phone_Records, Address_Inquiries_Suppress,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Inquiry_Table_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

//Inquiries nonFCRA DID
	Key_AccLogs_Inquiry_Table_DID_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Inquiry_AccLogs.Key_Inquiry_DID,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.IsUpdateRecord := FALSE, //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

		Key_AccLogs_Inquiry_Table_Update_DID_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Inquiry_AccLogs.Key_Inquiry_DID_Update,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did) AND
								//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.IsUpdateRecord := TRUE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

	Gather_DID_Inquiries := Key_AccLogs_Inquiry_Table_DID_unsuppressed+Key_AccLogs_Inquiry_Table_Update_DID_unsuppressed+deltaBase_did_unsuppressed;

	DID_Inquiries_Suppress := Suppress.MAC_SuppressSource(Gather_DID_Inquiries, mod_access, did_field := person_q.appended_adl, gsid_field := ccpa.global_sid, data_env := Environment);

	With_AccLogs_Inquiry_DID_Records := DENORMALIZE(With_AccLogs_Inquiry_Address_Records, DID_Inquiries_Suppress,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Inquiry_Table_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

//Inquiries nonFCRA Email
	Key_AccLogs_Inquiry_Table_Email_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Inquiry_AccLogs.Key_Inquiry_Email,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Email = TRUE AND
				LEFT.P_InpClnEmail <> '' AND
				KEYED(LEFT.P_InpClnEmail = RIGHT.email_address) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Email,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_InpClnEmail := LEFT.P_InpClnEmail,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.IsUpdateRecord := FALSE, //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

		Key_AccLogs_Inquiry_Table_Update_Email_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Inquiry_AccLogs.Key_Inquiry_Email_Update,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Email = TRUE AND
				LEFT.P_InpClnEmail <> '' AND
				KEYED(LEFT.P_InpClnEmail = RIGHT.email_address) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Email,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_InpClnEmail := LEFT.P_InpClnEmail,
					SELF.IsUpdateRecord := TRUE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

	Gather_Email_Inquiries := Key_AccLogs_Inquiry_Table_Email_unsuppressed+Key_AccLogs_Inquiry_Table_Update_Email_unsuppressed+deltaBase_email_unsuppressed;

	Email_Inquiries_Suppress := Suppress.MAC_SuppressSource(Gather_Email_Inquiries, mod_access, did_field := person_q.appended_adl, gsid_field := ccpa.global_sid, data_env := Environment);

	With_AccLogs_Inquiry_Email_Records := DENORMALIZE(With_AccLogs_Inquiry_DID_Records, Email_Inquiries_Suppress,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Inquiry_Table_Email := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

//Inquiries nonFCRA Fein
	Key_AccLogs_Inquiry_Table_FEIN_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Inquiry_AccLogs.Key_Inquiry_FEIN,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN = TRUE AND
				LEFT.B_InpClnTIN <> '' AND
				KEYED(LEFT.B_InpClnTIN = RIGHT.appended_ein) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_FEIN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.B_InpClnTIN := LEFT.B_InpClnTIN,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.IsUpdateRecord := FALSE, //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,//no fein deltabase
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

		Key_AccLogs_Inquiry_Table_Update_FEIN_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_FDC, Inquiry_AccLogs.Key_Inquiry_FEIN_Update,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN = TRUE AND
				LEFT.B_InpClnTIN <> '' AND
				KEYED(LEFT.B_InpClnTIN = RIGHT.appended_ein) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_FEIN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.B_InpClnTIN := LEFT.B_InpClnTIN,
					SELF.IsUpdateRecord := TRUE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,//no fein deltabase
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

	Gather_FEIN_Inquiries := Key_AccLogs_Inquiry_Table_FEIN_unsuppressed+Key_AccLogs_Inquiry_Table_Update_FEIN_unsuppressed;

	FEIN_Inquiries_Suppress := Suppress.MAC_SuppressSource(Gather_FEIN_Inquiries, mod_access, did_field := bususer_q.appended_adl, gsid_field := ccpa.global_sid, data_env := Environment);

	With_AccLogs_Inquiry_FEIN_Records := DENORMALIZE(With_AccLogs_Inquiry_Email_Records, FEIN_Inquiries_Suppress,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

//Inquiries nonFCRA Bipids

	Inquiry_AccLogs__Key_Inquiry_LinkIds_Table := IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs = TRUE,
																							PublicRecords_KEL.ecl_functions.DateSelector(Inquiry_AccLogs.Key_Inquiry_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Lookup_And_Input_LinkIDs),
																							 mod_access,
																							PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries_Kfetch, //old bus shell we keep 5k of these but 1k of everything else, will try 5k to start but might need to be lowered
																							BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));



	Inquiry_AccLogs__Key_Inquiry_LinkIds_Update := IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs = TRUE,
																							PublicRecords_KEL.ecl_functions.DateSelector(Inquiry_AccLogs.Key_Inquiry_LinkIds_Update.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Lookup_And_Input_LinkIDs),
																							mod_access,
																							PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries_Kfetch,//old bus shell we keep 5k of these but 1k of everything else, will try 5k to start but might need to be lowered
																							BIPV2.IDconstants.JoinTypes.LimitTransformJoin),FALSE,TRUE));

	//since we cannot filter a kfetch like a keyed join we will drop unneeded inq records here too
	Inquiry_LinkIds_Table := Project(Inquiry_AccLogs__Key_Inquiry_LinkIds_Table(#EXPAND(PublicRecords_KEL.ECL_Functions.AccLogs_Constants.inquiry_is_ok_nonFCRA)),
																								transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_LinkIds,
																									SELF.IsUpdateRecord := FALSE,
																									SELF.IsDeltaBaseRecord := False,//no bip deltabase
																									self := left,
																									self := []));  //to help with debugging and data questions
	Inquiry_LinkIds_Update := Project(Inquiry_AccLogs__Key_Inquiry_LinkIds_Update(#EXPAND(PublicRecords_KEL.ECL_Functions.AccLogs_Constants.inquiry_is_ok_nonFCRA)),
																								transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_LinkIds,
																								SELF.IsUpdateRecord := TRUE,
																								SELF.IsDeltaBaseRecord := False,//no bip deltabase
																								self := left,
																								self := []));  //to help with debugging and data questions

	Gather_LinkIds_Inquiries := Inquiry_LinkIds_Table+Inquiry_LinkIds_Update;

	With_AccLogs_Inquiry_LinkIds_Records := DENORMALIZE(With_AccLogs_Inquiry_FEIN_Records, Gather_LinkIds_Inquiries,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND
			LEFT.B_LexIDUlt = RIGHT.ULTID AND
			LEFT.B_LexIDOrg = RIGHT.ORGID AND
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_LinkIds,
																										SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																										SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
																										SELF.DateOfInquiry := LEFT.Search_Info.DateTime[1..8];
																										self := left,
																										self := []));
					SELF := LEFT,
					SELF := []));

//Inquiries nonFCRA Phone
	Key_AccLogs_Inquiry_Table_Phone_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Phone_All, Inquiry_AccLogs.Key_Inquiry_Phone,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone = TRUE AND
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone = RIGHT.Phone10) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Phone := LEFT.Phone,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.IsUpdateRecord := FALSE, //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

		Key_AccLogs_Inquiry_Table_Update_Phone_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Phone_All, Inquiry_AccLogs.Key_Inquiry_Phone_Update,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone = TRUE AND
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone = RIGHT.Phone10) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Phone := LEFT.Phone,
					SELF.IsUpdateRecord := TRUE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

	Gather_Phone_Inquiries := Key_AccLogs_Inquiry_Table_Phone_unsuppressed+Key_AccLogs_Inquiry_Table_Update_Phone_unsuppressed+deltaBase_phone_unsuppressed;

	Phone_Inquiries_Suppress := Suppress.MAC_SuppressSource(Gather_Phone_Inquiries, mod_access, did_field := person_q.appended_adl, gsid_field := ccpa.global_sid, data_env := Environment);

	With_AccLogs_Inquiry_Phone_Records := DENORMALIZE(With_AccLogs_Inquiry_LinkIds_Records, Phone_Inquiries_Suppress,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Inquiry_Table_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

//Inquiries nonFCRA SSN
	Key_AccLogs_Inquiry_Table_SSN_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Best_SSN_nonFCRA, Inquiry_AccLogs.Key_Inquiry_SSN,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN = TRUE AND
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN = RIGHT.ssn) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_SSN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_InpClnSSN := LEFT.P_InpClnSSN,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.IsUpdateRecord := FALSE, //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

		Key_AccLogs_Inquiry_Table_Update_SSN_unsuppressed :=
			PublicRecords_KEL.ecl_functions.DateSelector(JOIN(Input_Best_SSN_nonFCRA, Inquiry_AccLogs.Key_Inquiry_SSN_Update,
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN = TRUE AND
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN = RIGHT.ssn) AND
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_SSN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_InpClnSSN := LEFT.P_InpClnSSN,
					SELF.IsUpdateRecord := TRUE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries)),FALSE,FALSE);

	Gather_SSN_Inquiries := Key_AccLogs_Inquiry_Table_SSN_unsuppressed+Key_AccLogs_Inquiry_Table_Update_SSN_unsuppressed+deltaBase_ssn_unsuppressed;

	SSN_Inquiries_Suppress := Suppress.MAC_SuppressSource(Gather_SSN_Inquiries, mod_access, did_field := person_q.appended_adl, gsid_field := ccpa.global_sid, data_env := Environment);

	With_AccLogs_Inquiry_SSN_Records := DENORMALIZE(With_AccLogs_Inquiry_Phone_Records, SSN_Inquiries_Suppress,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Inquiry_Table_SSN := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

    RiskTable__Key_Name_Dob_Summary :=
   		JOIN(input_fdc, Risk_Indicators.Correlation_Risk.key_name_dob_summary,
            Common.DoFDCJoin_RiskTable__Key_Name_Dob_Summary = TRUE AND
            LEFT.P_InpClnNameLast <> '' AND
            KEYED(LEFT.P_InpClnNameLast = RIGHT.lname) AND
            KEYED(LEFT.P_InpClnNameFirst = RIGHT.fname) AND
            KEYED(LEFT.P_InpClnDOB = (STRING)RIGHT.dob),
            TRANSFORM(Layouts_FDC.Layout_name_dob_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []),
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));

     RiskTable__Key_Name_Dob_Summary_Norm_Records :=
        PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(RiskTable__Key_Name_Dob_Summary, left.summary,
          TRANSFORM(Layouts_FDC.Layout_name_dob_summary_key_norm_records,
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                SELF := RIGHT,
                SELF := LEFT,
                SELF := [])), FALSE, FALSE);

   	With_RiskTable_Key_Name_Dob_Summary_Records := DENORMALIZE(With_AccLogs_Inquiry_SSN_Records, RiskTable__Key_Name_Dob_Summary_Norm_Records,
        LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Name_Dob_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

        RiskTable__Key_Phone_Addr_Header :=
   		JOIN(Input_Phone_Address_Combined_Recs, Risk_Indicators.Correlation_Risk.key_phone_addr_header_summary,
            Common.DoFDCJoin_RiskTable__Key_Phone_Summary = TRUE AND
            LEFT.Phone <> '' AND LEFT.PrimaryName <> '' AND LEFT.ZIP5 <> '' AND
            KEYED(LEFT.Phone = RIGHT.phone10) AND
            KEYED(LEFT.PrimaryName = RIGHT.prim_name) AND
            KEYED(LEFT.PrimaryRange = RIGHT.prim_range) AND
            KEYED(LEFT.ZIP5 = RIGHT.zip),
            TRANSFORM(Layouts_FDC.Layout_phone_addr_header_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF.HeaderHitFlag := TRUE;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []),
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));

     RiskTable__Key_Phone_Addr_Header_Summary_Norm_Records :=
        PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(RiskTable__Key_Phone_Addr_Header, left.summary,
          TRANSFORM(Layouts_FDC.Layout_phone_addr_header_summary_key_norm_records,
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                SELF := RIGHT,
                SELF := LEFT,
                SELF := [])), FALSE, FALSE);

   	With_RiskTable__Key_Phone_Addr_Header_Summary_Norm_Records := DENORMALIZE(With_RiskTable_Key_Name_Dob_Summary_Records, RiskTable__Key_Phone_Addr_Header_Summary_Norm_Records,
        LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Phone_Addr_Header_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

     RiskTable__Key_Phone_Addr :=
   		JOIN(Input_Phone_Address_Combined_Recs, Risk_Indicators.Correlation_Risk.key_phone_addr_summary,
            Common.DoFDCJoin_RiskTable__Key_Phone_Summary = TRUE AND
            LEFT.Phone <> '' AND LEFT.PrimaryName <> '' AND LEFT.ZIP5 <> '' AND
            KEYED(LEFT.Phone = RIGHT.phone10) AND
            KEYED(LEFT.PrimaryName = RIGHT.prim_name) AND
            KEYED(LEFT.PrimaryRange = RIGHT.prim_range) AND
            KEYED(LEFT.ZIP5 = RIGHT.zip),
            TRANSFORM(Layouts_FDC.Layout_phone_addr_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF.HeaderHitFlag := FALSE;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []),
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));

     RiskTable__Key_Phone_Addr_Summary_Norm_Records :=
        PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(RiskTable__Key_Phone_Addr , left.summary,
          TRANSFORM(Layouts_FDC.Layout_phone_addr_summary_key_norm_records,
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                SELF := RIGHT,
                SELF := LEFT,
                SELF := [])), FALSE, FALSE);

   	With_RiskTable__Key_Phone_Addr_Summary_Norm_Records := DENORMALIZE(With_RiskTable__Key_Phone_Addr_Header_Summary_Norm_Records, RiskTable__Key_Phone_Addr_Summary_Norm_Records,
        LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Phone_Addr_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

     RiskTable__Key_Phone_Lname :=
   		JOIN(Input_Phone_Address_Combined_Recs, Risk_Indicators.Correlation_Risk.key_phone_lname_summary,
            Common.DoFDCJoin_RiskTable__Key_Phone_Summary = TRUE AND
            LEFT.Phone <> '' AND LEFT.P_InpClnNameLast <> '' AND
            KEYED(LEFT.Phone = RIGHT.phone10) AND
            KEYED(LEFT.P_InpClnNameLast = RIGHT.lname),
            TRANSFORM(Layouts_FDC.Layout_phone_lname_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF.HeaderHitFlag := FALSE;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []),
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));

     RiskTable__Key_Phone_Lname_Summary_Norm_Records :=
        PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(RiskTable__Key_Phone_Lname , left.summary,
          TRANSFORM(Layouts_FDC.Layout_phone_lname_summary_key_norm_records,
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                SELF := RIGHT,
                SELF := LEFT,
                SELF := [])), FALSE, FALSE);

   	With_RiskTable__Key_Phone_Lname_Summary_Norm_Records := DENORMALIZE(With_RiskTable__Key_Phone_Addr_Summary_Norm_Records, RiskTable__Key_Phone_Lname_Summary_Norm_Records,
        LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Phone_Lname_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

         RiskTable__Key_Phone_Lname_Header :=
   		JOIN(Input_Phone_Address_Combined_Recs, Risk_Indicators.Correlation_Risk.key_phone_lname_header_summary,
            Common.DoFDCJoin_RiskTable__Key_Phone_Summary = TRUE AND
            LEFT.Phone <> '' AND LEFT.P_InpClnNameLast <> '' AND
            KEYED(LEFT.Phone = RIGHT.phone10) AND
            KEYED(LEFT.P_InpClnNameLast = RIGHT.lname),
            TRANSFORM(Layouts_FDC.Layout_phone_lname_header_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF.HeaderHitFlag := TRUE;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []),
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));

     RiskTable__Key_Phone_Lname_Header_Summary_Norm_Records :=
        PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(RiskTable__Key_Phone_Lname_Header , left.summary,
          TRANSFORM(Layouts_FDC.Layout_phone_lname_header_summary_key_norm_records,
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                SELF := RIGHT,
                SELF := LEFT,
                SELF := [])), FALSE, FALSE);

   	With_RiskTable__Key_Phone_Lname_Header_Summary_Norm_Records := DENORMALIZE(With_RiskTable__Key_Phone_Lname_Summary_Norm_Records, RiskTable__Key_Phone_Lname_Header_Summary_Norm_Records,
        LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Phone_Lname_Header_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

     RiskTable__Key_Phone_Dob_Summary :=
   		JOIN(Input_Phone_Address_Combined_Recs, Risk_Indicators.Correlation_Risk.key_phone_dob_summary,
            Common.DoFDCJoin_RiskTable__Key_Phone_Summary = TRUE AND
            LEFT.Phone <> '' AND LEFT.P_InpClnDOB <> '' AND
            KEYED(LEFT.Phone = RIGHT.phone) AND
            KEYED(LEFT.P_InpClnDOB = (STRING)RIGHT.dob),
            TRANSFORM(Layouts_FDC.Layout_phone_dob_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF.HeaderHitFlag := FALSE;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []),
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT_SLIM));

     RiskTable__Key_Phone_Dob_Summary_Norm_Records :=
        PublicRecords_KEL.ecl_functions.DateSelector(NORMALIZE(RiskTable__Key_Phone_Dob_Summary , left.summary,
          TRANSFORM(Layouts_FDC.Layout_phone_dob_summary_key_norm_records,
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                SELF := RIGHT,
                SELF := LEFT,
                SELF := [])), FALSE, FALSE);

   	With_RiskTable__Key_Phone_Dob_Summary_Norm_Records := DENORMALIZE(With_RiskTable__Key_Phone_Lname_Header_Summary_Norm_Records, RiskTable__Key_Phone_Dob_Summary_Norm_Records,
        LEFT.G_ProcUID = RIGHT.G_ProcUID, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Phone_Dob_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

	RETURN (With_RiskTable__Key_Phone_Dob_Summary_Norm_Records+With_Header_Addr_Hist_Records_6threp);

	END;
