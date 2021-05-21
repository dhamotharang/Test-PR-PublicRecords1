IMPORT AID_Build, ADVO, AlloyMedia_student_list,  American_student_list, AutoKey, AVM_V2, BankruptcyV3, BBB2, BIPV2, BIPV2_Best, BIPV2_Build, Business_Risk_BIP, BusReg, CalBus, CellPhone, Certegy, Corp2, 
		Cortera_Tradeline, Data_Services, DCAV2, Death_Master,  Doxie, Doxie_Files, DriversV2, DMA, dx_BestRecords, dx_ConsumerFinancialProtectionBureau, dx_Cortera, dx_DataBridge, DX_Email, 
		dx_Cortera_Tradeline, dx_Equifax_Business_Data, dx_Gong, dx_Header, dx_Infutor_NARB, dx_PhonesInfo, dx_PhonesPlus,dx_property, dx_Relatives_v3, EBR, Email_Data, emerges, Experian_CRDB, fcra, FAA, FBNv2, FLAccidents_Ecrash, Fraudpoint3, Gong, 
		GovData, Header, Header_Quick, InfoUSA, IRS5500, InfutorCID, Inquiry_AccLogs, LiensV2, LN_PropertyV2, MDR, OSHAIR, Phonesplus_v2, dx_prof_license_mari, 
		Prof_LicenseV2, Relationship, Risk_Indicators, RiskView, RiskWise, SAM, SexOffender, STD, Suppress, Targus, thrive, USPIS_HotList, Utilfile, ut,
		VehicleV2, Watercraft, Watchdog, UCCV2, YellowPages, dx_OSHAIR, drivers;

	//These settings are in MAS_get deltabase_inquiry and FCRA_Overrides. You need to go there as well
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
									PublicRecords_KEL.Join_Interface_Options JoinFlags,
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

	

	
	
	Layouts_FDC  := PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options);
	Common       := PublicRecords_KEL.ECL_Functions.Common(Options, JoinFlags);
	CFG_File     := PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile;
	Regulated    := PublicRecords_KEL.ECL_Functions.Constants.Regulated;
	NotRegulated := PublicRecords_KEL.ECL_Functions.Constants.NotRegulated;
	BlankString  := PublicRecords_KEL.ECL_Functions.Constants.BlankString;
	SetDPMBitmap := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue;
	Environment := IF(Options.IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA); // for CCPA Suppression calls

	// IsMiniFDC := COUNT(FDCDataset_Mini) = 0; // If there weren't any records in the mini-fdc input, then this must be the mini fdc run.
	
	restrictedStates := fcra.compliance.watercrafts.restricted_states;	// need consumer permission

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
	
	// FDCMiniPop := IF(COUNT(FDCDataset_Mini) = 0, TRUE, FALSE);//Do we need to go get this data?

	Input_pre_override := Input_all((INTEGER)p_inpclnarchdt > 0); //inputs without contacts

	//if we have a mini fdc popualted here lets get this ready to use
	overridemini := project(FDCDataset_Mini, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII_Overrides,self := left; self := []));


	//check to see if we need this or if we got this from the mini FDC.  we only should be calling to this once
	//FCRA overrides are NOT archivable 
	// Input_getoverides:= IF(FDCMiniPop, PublicRecords_KEL.MAS_get.FCRA_Overrides(Options).GetOverrideFlags(Input_pre_override, FDCMiniPop), overridemini);		

	Input_pre := overridemini(RepNumber <> 6);

	input :=	IF(options.BestPIIAppend, 
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
							SELF.P_InpClnSurname1 := right.P_InpClnSurname1,
							SELF.P_InpClnSurname2 := right.P_InpClnSurname2,
							SELF.P_InpClnNameMid := right.P_InpClnNameMid,
							SELF.P_InpClnNameFirst := right.P_InpClnNameFirst,
							SELF.P_InpClnDOB := right.P_InpClnDOB,
							SELF := left,
							SELF := [])), Input_pre);

							

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
				SELF.AddressGeoLink  := (trim(LEFT.previousAddrStateCode, left, right) + trim(left.previousAddrCnty, left, right) + trim(left.previousAddrGeo, left, right)),
				self.isinput := if((INTEGER)left.p_inpclnarchdt > 0, true, false);
				SELF := LEFT,
				SELF := []
			)
		);	
		
Previous_Address_Consumer_recs := Previous_Address_Consumer_recs_pre(isinput = true);
Previous_Address_Consumer_recs_Contacts_pre := Previous_Address_Consumer_recs_pre(isinput = false);
		
Previous_Address_Consumer_recs_Contacts := join(Previous_Address_Consumer_recs, Previous_Address_Consumer_recs_Contacts_pre,
							left.UIDAppend = right.UIDAppend,
					TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
							self.uidappend := left.uidappend;
							self.p_inpclnarchdt := left.p_inpclnarchdt;
							self := right));
		
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
				SELF.AddressGeoLink  := (trim(LEFT.currentAddrstateCode, left, right) + trim(left.currentAddrCnty, left, right) + trim(left.currentAddrGeo, left, right)),
				self.isinput := if((INTEGER)left.p_inpclnarchdt > 0, true, false);
				SELF := LEFT,
				SELF := []
			)
		);	
		
Current_Address_Consumer_recs := Current_Address_Consumer_recs_pre(isinput = true);
Current_Address_Consumer_recs_Contacts_pre := Current_Address_Consumer_recs_pre(isinput = false);		
	
Current_Address_Consumer_recs_Contacts := join(Current_Address_Consumer_recs, Current_Address_Consumer_recs_Contacts_pre,
							left.UIDAppend = right.UIDAppend,
					TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
							self.uidappend := left.uidappend;
							self.p_inpclnarchdt := left.p_inpclnarchdt;
							self := right));	
	
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
				// self.isinput := if((INTEGER)p_inpclnarchdt > 0, true, false);
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
																			
	Input_Address_Emerging_Current_Pre := (Current_Address_Consumer_recs + Input_Address_All+Emerging_Address_Consumer_recs)( PrimaryName != '' AND ZIP5 != '');
	Input_Address_Emerging_Current := dedup(sort(Input_Address_Emerging_Current_Pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
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
	
	GeoInputPrevCurrContactCFPB := dedup(sort(Input_and_Contact_Current_Previous, UIDAppend, AddressGeoLink),UIDAppend, AddressGeoLink);					
			
		AVMGeoInputPrevCurrPre :=
		NORMALIZE( Input_Address_Current_Previous, 3, 
			TRANSFORM( recordof(Input_Address_Current_Previous),
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.AddressGeoLink := CHOOSE( COUNTER, LEFT.AddressGeoLink[1..5], LEFT.AddressGeoLink[1..11], LEFT.AddressGeoLink[1..12]);
				SELF := LEFT,
				SELF := []));

		AVMGeoInputPrevCurr := dedup(sort(AVMGeoInputPrevCurrPre(AddressGeoLink <> ''), UIDAppend, AddressGeoLink),UIDAppend, AddressGeoLink);					


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
				self.p_inpclnarchdt := left.b_inpclnarchdt;
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
	InputLexidsTrans := project(Input_FDC(p_lexid >0), transform({unsigned6 did;}, self.did := left.P_LexID, self := []));
	InputLexids := SET((InputLexidsTrans), DID);	




/*************************************************************************************************************/	
		
	Layouts_FDC.Layout_FDC Normalize_Contacts(RecordOF(Layouts_FDC.Layout_FDC.Dataset_BIPV2_Build__kfetch_contact_linkids) ri, Layouts_FDC.Layout_FDC le) := TRANSFORM
		self.P_LexID := ri.contact_did,
		self.UIDAppend := le.UIDAppend,
		self.g_procuid := le.UIDAppend,
		self.P_InpClnArchDt := le.P_InpClnArchDt,
		self.P_InpClnSurname1 := ri.contact_name.lname,
		self.Contact_date := if(ri.dt_last_seen_contact>(integer)le.P_InpClnArchDt[1..8],(integer)le.P_InpClnArchDt[1..8],ri.dt_last_seen_contact),
		SELF := ri; 
		self := [];
	END;
	
		
	FDCDataset_Mini_norm := normalize(FDCDataset_Mini, left.Dataset_BIPV2_Build__kfetch_contact_linkids, Normalize_Contacts(RIGHT,LEFT));	

	//only keep contacts within the past 3 years for 'extra' searching from the mini, keep 3 years for build date padding
	Temp_FDCDataset_mini_contacts := FDCDataset_Mini_norm((P_LexID > 0) and (ut.daysapart((string)Contact_date, P_InpClnArchDt[1..8]) < ut.DaysInNYears(3)));

	// Only keep 100 contacts per business for LexID searching to improve performance
	Business_Contact_LexIDs_Temp := DEDUP(SORT(Temp_FDCDataset_mini_contacts, UIDAppend, P_LexID), WHOLE RECORD);
	Business_Contact_LexIDs := DEDUP(DEDUP(SORT(Business_Contact_LexIDs_Temp, UIDAppend, P_LexID), UIDAppend, P_LexID), UIDAppend, KEEP(100));	

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
		IF(Common.DoFDCJoin_BIPV2_Build__kfetch_contact_linkids_slim = TRUE AND COUNT(Unique_Raw_Lexid_Matches_Filtered) < 200, PublicRecords_KEL.mas_get.Contact_Linkids(Unique_Raw_Lexid_Matches_Filtered, PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.PowID, linkingOptions, mod_access, PublicRecords_KEL.ECL_Functions.Constants.BUSINESS_CONTACT_PROPERTY_LIMIT));

	Business_Contacts_slim := PROJECT(BIPV2_Build__kfetch_contact_linkids_with_seq, TRANSFORM(Layouts_FDC.Layout_BIPV2_Build__kfetch_contact_linkids_slim,
															SELF.UIDAppend := LEFT.UniqueID,
															SELF := LEFT,
															SELF := []));
															
	Business_Contacts_rolled := DEDUP(SORT(Business_Contacts_slim, UIDAppend, UltID, OrgID, SeleID, ProxID, contact_did, Source, dt_first_seen_contact, dt_last_seen_contact), UIDAppend, UltID, OrgID, SeleID, ProxID, contact_did, Source, dt_first_seen_contact, dt_last_seen_contact);


	isMiniFDCEmpty := COUNT(FDCDataset_Mini) = 0;					

	main_dataset := IF(isMiniFDCEmpty, Input_FDC, FDCDataset_Mini);//not all products need to call the mini FDC, if they did not go through the miniFDC we denorm with the input dataset, otherwise we keep adding to the mini

	//adding all reasults back together
	With_BIPV2_Build_contact_linkids_slim := DENORMALIZE(main_dataset, Business_Contacts_rolled,
			IF(ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <> '',ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) ,ArchiveDate((string)right.dt_first_seen_contact)) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2_Build__kfetch_contact_linkids_slim := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BIPV2_Build__kfetch_contact_linkids_slim,  
																						self.src := LEFT.Source, //many sources in business header
																						SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, Is_Business_Header := TRUE, Marketing_state := left.company_address.st, KELPermissions := CFG_File),																				
																						self.Archive_Date :=  IF(ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported) <> '',ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported) ,ArchiveDate((string)left.dt_first_seen_contact));
																						self.dt_first_seen :=  (integer)archivedate((string)left.dt_first_seen);																								
																						self := left, 
																						self := []));
					SELF := LEFT,
					SELF := []));		
	
/*************************************************************************************************************/
//all of this data below is used again for searching which is why we are re normalizing the data here

	//transform business contact into input layout and dedup
	Input_Plus_Contacts := (Input_FDC + Business_Contact_LexIDs)(P_LexID > 0);

	//for searching
	Input_FDC_Business_Contact_LexIDs := DEDUP(SORT(Input_Plus_Contacts, UIDAppend, P_LexID), UIDAppend, P_LexID);		//we use this later
	//for now contacts only use surname1, this will be changed later
	temp_contacts_surnames := project(Business_Contact_LexIDs, transform(Layouts_FDC.Layout_FDC, self.P_InpClnSurname1 := left.P_InpClnSurname1, self.UIDAppend := left.UIDAppend, self.g_procuid := left.UIDAppend, self := left, self := []));		
	Input_surnames := (Input_FDC + temp_contacts_surnames)(P_InpClnSurname1<>'' and P_InpClnSurname1<>'-99998'and P_InpClnSurname1<>'-99999'and P_InpClnSurname1<>'-99997');							

	cfpbsurname_input_contacts_pre :=
		NORMALIZE( Input_surnames, 2, 
			TRANSFORM( recordof(Input_Address_Current_Previous),
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.P_InpClnNameLast := CHOOSE( COUNTER, LEFT.P_InpClnSurname1, LEFT.P_InpClnSurname2);
				SELF.P_InpClnSurname1 := LEFT.P_InpClnSurname1;
				SELF.P_InpClnSurname2 := LEFT.P_InpClnSurname2;
				SELF := LEFT,
				SELF := []));

	cfpbsurname_input_contacts := dedup(sort(cfpbsurname_input_contacts_pre, UIDAppend, P_InpClnNameLast),UIDAppend, P_InpClnNameLast);	

  Lookup_And_Input_LinkIDs := DEDUP(SORT(Lookup_And_Input_LinkIDs_Combined, UIDAppend, B_LexIDUlt, B_LexIDOrg, B_LexIDLegal), UIDAppend, B_LexIDUlt, B_LexIDOrg, B_LexIDLegal);

	norm_dx_Header__key_did_hhid := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_dx_Header__key_did_hhid, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));
	deduped_HHIDS:= DEDUP(SORT(norm_dx_Header__key_did_hhid,UIDAppend,hhid),UIDAppend,hhid);

	norm_dx_Header__key_hhid_did := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_dx_Header__key_hhid_did, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));	
	norm_Key_Relatives_V3 := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Relatives__Key_Relatives_V3, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));	

	All_Relatives := norm_Key_Relatives_V3(did2 >0);//both marketing and non marketing relatives with new interface.
	
	Seperate_relatives := All_Relatives(did1 IN InputLexids);//we only want input lexid relatives NOT contact relatives

	RelativesLexids := project(Seperate_relatives, TRANSFORM(Layouts_FDC.Layout_FDC, self.P_lexid := LEFT.did2, SELF.UIDAppend := LEFT.UIDAppend, SELF := LEFT, SELF := []));//take the relatives of inputs and assign them to plexid
 	
	Seperate_HouseHold_Lexids := norm_dx_Header__key_hhid_did(P_LexID IN InputLexids);//we only want input lexid hhids NOT contact hhids

  HHIDLexids_preadl := PROJECT(Seperate_HouseHold_Lexids(did >0), TRANSFORM(Layouts_FDC.Layout_FDC, SELF.P_LexID := LEFT.did; SELF := LEFT; SELF := []));
				
	norm_Header__key_ADL_segmentation := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Header__key_ADL_segmentation, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));

	HHIDs_ADL_Lexids := norm_Header__key_ADL_segmentation(did  NOT IN InputLexids);	
	HHIDs_ADLs_Good_Lexids := HHIDs_ADL_Lexids(ind1 = PublicRecords_KEL.ECL_Functions.Constants.HouseHoldCORE OR ind1 = PublicRecords_KEL.ECL_Functions.Constants.HouseHoldCOREVNOSSN);//we only want to keep lexids from households with core or corevnossn
	
	Input_ADL_Lexids := norm_Header__key_ADL_segmentation(did IN InputLexids);//we do not want to filter input lexeds on the above adl catigories like HHID	

  HHIDLexids := PROJECT(HHIDs_ADLs_Good_Lexids, TRANSFORM(Layouts_FDC.Layout_FDC, SELF.P_LexID := LEFT.did; SELF := LEFT; SELF := []));

  Input_HHIDLexids := DEDUP(SORT((Input_FDC + HHIDLexids)(P_LexID > 0), UIDAppend, P_LexID), UIDAppend, P_LexID);
	Input_FDC_RelativesLexids_HHIDLexids_LexIDs := DEDUP(SORT((RelativesLexids + Input_HHIDLexids )(P_LexID > 0), UIDAppend, P_LexID), UIDAppend, P_LexID);

	Input_FDC_RelativesLexids_HHIDLexids_Business_Contact_LexIDs := DEDUP(SORT((Input_FDC_RelativesLexids_HHIDLexids_LexIDs + Business_Contact_LexIDs)(P_LexID > 0), UIDAppend, P_LexID), UIDAppend, P_LexID);

	//special search for avm
	//need to use did from fid key instead of plexid in case input address is valid but not tied to P_lexid				
	InputRelativesHHIDTrans := project(Input_FDC + RelativesLexids + HHIDLexids, transform({unsigned6 did;}, self.did := left.P_LexID, self := []));
	Input_RelativesWithHHIDLexids := SET(InputRelativesHHIDTrans(did > 0), DID);

	norm_nonFCRA_watchdog := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Best_Person__Key_Watchdog, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, self.P_InpClnArchDt := left.P_InpClnArchDt,SELF := RIGHT));	
	norm_FCRA_watchdognonEN := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, self.P_InpClnArchDt := left.P_InpClnArchDt, SELF := RIGHT));
	norm_FCRA_watchdognonEQ := NORMALIZE(FDCDataset_Mini, LEFT.Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, self.P_InpClnArchDt := left.P_InpClnArchDt, SELF := RIGHT));

	//DRM bit is checked in Common to ensure we only use the correct FCRA SSN here
	Best_SSN_FCRA := Project((norm_FCRA_watchdognonEN+norm_FCRA_watchdognonEQ), transform(Layouts_FDC.Layout_FDC, 
																				self.P_InpClnSSN := Left.SSN , 
																				self.UIDAppend := left.UIDAppend, 
																				self.g_procuid := left.g_procuid, 
																				self := left, 
																				self := []));
	
																														
	Best_SSN_NonFCRA := Project(norm_nonFCRA_watchdog(rec.did IN InputLexids), transform(Layouts_FDC.Layout_FDC, //we pass contacts into here, we only want to keep input best ssn
																				self.P_InpClnSSN := Left.rec.SSN, 
																				self.UIDAppend := left.UIDAppend, 
																				self.g_procuid := left.g_procuid, 
																				self := left, 
																				self := []));	
																				
	Best_Phone_NonFCRA := Project(norm_nonFCRA_watchdog(rec.did IN InputLexids), transform(Layouts_FDC.LayoutPhoneGeneric_inputs, //we pass contacts into here, we only want to keep input best ssn
																				self.phone := Left.rec.phone, 
																				self.UIDAppend := left.UIDAppend, 
																				self.g_procuid := left.g_procuid, 
																				self := left, 
																				self := []));

//for searching																		
	Input_Best_SSN_nonFCRA := Dedup(Sort((Best_SSN_NonFCRA+Input_FDC)((integer)P_InpClnSSN>0), UIDAppend, P_InpClnSSN),UIDAppend, P_InpClnSSN);
	Input_Best_Phone_nonFCRA := Dedup(Sort(Best_Phone_NonFCRA(phone <> '')+Input_Phone_All, UIDAppend, phone),UIDAppend, phone);
	Input_Best_SSN_FCRA := Dedup(Sort((Best_SSN_FCRA+Input_FDC)((integer)P_InpClnSSN>0), UIDAppend, P_InpClnSSN),UIDAppend, P_InpClnSSN);
/*************************************************************************************************************/

	
	
BIPV2.IDAppendLayouts.AppendInput PrepBIPInputsele(Layouts_FDC.Layout_FDC le) := TRANSFORM
		SELF.request_id := le.UIDAppend;
		SELF.seleid := le.B_LexIDLegal;
		SELF := [];
	END;
	
BIPV2.IDAppendLayouts.AppendInput PrepBIPInputprox(Layouts_FDC.Layout_FDC le) := TRANSFORM
		SELF.request_id := le.UIDAppend;
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


	BIP_Best_Records := JOIN(Input_FDC, BIP_Best_Records_Raw, 
		LEFT.UIDAppend = RIGHT.Request_ID,
		TRANSFORM(Layouts_FDC.Layout_BIPV2_Best__Key_LinkIds,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcBusUID := LEFT.G_ProcBusUID,
				SELF.B_LexIDUlt := LEFT.B_LexIDUlt,
				SELF.B_LexIDOrg := LEFT.B_LexIDOrg,
				SELF.B_LexIDLegal := LEFT.B_LexIDLegal,		
				self.p_inpclnarchdt := left.p_inpclnarchdt,
				SELF.Company_SIC_Code1 := CleanSIC(RIGHT.Company_SIC_Code1),
				SELF.Company_NAICS_Code1 := CleanNAIC(RIGHT.Company_NAICS_Code1),
				SELF.Src := MDR.sourceTools.src_Best_Business,
				SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, BIPBitMask := CFG_File.Permit_NonFCRA),
				self.Archive_Date :=  '';//not archivable 
				SELF := RIGHT,
				SELF := []));
				
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
																SELF.UIDAppend       := LEFT.UIDAppend,
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

/*************************************************************************************************************/
//for searching
	Input_and_Best_Address := sort(Dedup((Input_Address_All + Best_Sele_Address_Clean)(PrimaryName != '' AND ZIP5 != ''), 
																				PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, UIDAppend),
																						PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, UIDAppend);
	
	// Input consumer + businses address, best business Sele address, previous and current address for input person
	Input_Address_BusBest_Current_Previous_Pre := (Input_Address_All + Best_Sele_Address_Clean + Previous_Address_Consumer_recs + Current_Address_Consumer_recs)( PrimaryName != '' AND ZIP5 != '');
	Input_Address_BusBest_Current_Previous := dedup(sort(Input_Address_BusBest_Current_Previous_Pre, UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode); 
																			
	Input_Address_BusBest_Current_Previous_Emerging_dedup	:=	dedup(sort((Emerging_Address_Consumer_recs+Input_Address_BusBest_Current_Previous)(PrimaryName != '' AND ZIP5 != ''), UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode),
																			UIDAppend, PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, CityCode); 																
																			
	Input_Address_BusBest_Current_Previous_Emerging := Project(Input_Address_BusBest_Current_Previous_Emerging_dedup, transform({recordof(left), unsigned AddrHighRiskUID}, self.AddrHighRiskUID := counter, self := left));													
/*************************************************************************************************************/

	// Property 
/* If we grab a LOT of propertyevent fields to output, expect long run times*/

	PropertyV2__Key_Property_Did_Records :=	// dates not kept, does not need DateSelector
				JOIN(Input_FDC_RelativesLexids_HHIDLexids_Business_Contact_LexIDs, LN_PropertyV2.key_Property_did(Options.isFCRA),
				Common.DoFDCJoin_PropertyV2__Key_Property_Did = TRUE AND 
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.s_did AND
         RIGHT.source_code_2 = 'P'),
				TRANSFORM(Layouts_FDC.Layout_PropertyV2_Data_Temp,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.p_inpclnarchdt := left.p_inpclnarchdt,
					self.IsAddress := false,
					SELF.source_code_2 := right.source_code_2,
					SELF.source_code_1 := right.source_code[1],
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_DID_JOIN_LIMIT));

	
	PropertyV2__Key_Property_Linkids_kFetch2_Records := IF(Common.DoFDCJoin_PropertyV2__Key_Linkids_Key = TRUE, // dates not kept, does not need DateSelector
																											LN_PropertyV2.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																											PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																											0, /*ScoreThreshold --> 0 = Give me everything*/
																											linkingOptions,
																											PublicRecords_KEL.ECL_Functions.Constants.BUSINESS_CONTACT_PROPERTY_LIMIT,
																											BIPV2.IDconstants.JoinTypes.LimitTransformJoin));
	
	
	getbiprecords := join(input_FDC, PropertyV2__Key_Property_Linkids_kFetch2_Records,
				LEFT.UIDAppend = RIGHT.UniqueID and
				LEFT.B_LexIDUlt = right.UltID and
				LEFT.B_LexIDOrg = right.OrgID and
				LEFT.B_LexIDLegal = right.SeleID,
					transform(Layouts_FDC.Layout_PropertyV2_Data_Temp,
						self.UIDAppend := right.UniqueID,
						self.g_procuid := right.UniqueID,
						self.p_inpclnarchdt := left.p_inpclnarchdt,
						SELF.B_LexIDUlt := right.UltID,
						SELF.B_LexIDOrg := right.OrgID,
						SELF.B_LexIDLegal := right.SeleID,
						SELF.source_code_2 := right.source_code[2],
						SELF.source_code_1 := right.source_code[1],
						self.IsAddress := false,
						self := right,
						self := left,
						self := []));
	
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
					self.p_inpclnarchdt := left.p_inpclnarchdt,
					SELF.source_code_2 := right.source_code_2,
					SELF.source_code_1 := right.source_code_1,
					self.IsAddress := TRUE,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_ADDRESS_JOIN_LIMIT));


	Property_lookup_search_records_pre  := PropertyV2__Key_Property_Did_Records + getbiprecords + PropertyV2__Key_Addr_Fid_Records;


	Property_lookup_search_records := DEDUP(SORT(Property_lookup_search_records_pre, ln_fares_id, UIDAppend),ln_fares_id, UIDAppend);

/* Consumer and Business */	

	PropertyV2__Key_Assessor_Fid_Records :=	
			JOIN(Property_lookup_search_records(ln_fares_id[2] = 'A'), LN_PropertyV2.key_assessor_fid(Options.isFCRA),
				Common.DoFDCJoin_PropertyV2__Key_Assessor_Fid = TRUE AND
				KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id) and
				 MAP(	ArchiveDate(RIGHT.tax_year, RIGHT.assessed_value_year) <> ''  => ArchiveDate(RIGHT.tax_year, RIGHT.assessed_value_year),
							ArchiveDate(RIGHT.market_value_year, RIGHT.certification_date) <> ''  => ArchiveDate(RIGHT.market_value_year, RIGHT.certification_date),
							ArchiveDate(RIGHT.tape_cut_date, RIGHT.recording_date) <> ''  => ArchiveDate(RIGHT.tape_cut_date, RIGHT.recording_date),
							ArchiveDate(RIGHT.prior_recording_date, RIGHT.sale_date)) <= LEFT.P_InpClnArchDt[1..8] and
						//marketing
							IF(Options.isMarketing,(LN_PropertyV2_Src(RIGHT.ln_fares_id) IN PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES OR PublicRecords_KEL.ECL_Functions.Common_Functions.IsMarketingAllowedKey(LN_PropertyV2_Src(RIGHT.ln_fares_id), Right.State_Code)), TRUE)	AND
						//DRM check fares
						(LN_PropertyV2_Src(RIGHT.ln_fares_id) not IN if(options.Data_Restriction_Mask[Risk_Indicators.iid_constants.posFaresRestriction]=Risk_Indicators.iid_constants.sTrue, [MDR.sourceTools.src_Fares_Deeds_from_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Deeds], [])),
				TRANSFORM(Layouts_FDC.Layout_PropertyV2_Key_Assessor_Fid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.p_inpclnarchdt := left.p_inpclnarchdt,
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
					SELF.date_first_seen := (unsigned) MAP(	ArchiveDate(RIGHT.tax_year, RIGHT.assessed_value_year) <> ''  => ArchiveDate(RIGHT.tax_year, RIGHT.assessed_value_year),
																							ArchiveDate(RIGHT.market_value_year, RIGHT.certification_date) <> ''  => ArchiveDate(RIGHT.market_value_year, RIGHT.certification_date),
																							ArchiveDate(RIGHT.tape_cut_date, RIGHT.recording_date) <> ''  => ArchiveDate(RIGHT.tape_cut_date, RIGHT.recording_date),
																							ArchiveDate(RIGHT.prior_recording_date, RIGHT.sale_date));
																			
					self.Archive_Date :=  IF((INTEGER)SELF.date_first_seen=0,'',(STRING)SELF.date_first_seen);
					SELF.DPMBitmap := SetDPMBitmap( Source := LN_PropertyV2_Src(RIGHT.ln_fares_id), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Marketing_State := Right.State_Code),
					SELF := RIGHT,
					self.prop_correct_ffid := left.prop_correct_ffid;
					self.prop_correct_lnfare := left.prop_correct_lnfare;
					SELF := []), 
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_JOIN_LIMIT));				
			
	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsPropAssess := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												PropertyV2__Key_Assessor_Fid_Records(trim(ln_fares_id) not in prop_correct_lnfare), 
												PropertyV2__Key_Assessor_Fid_Records);

	//if there are corrections lets go find them
	GetOverridePropAssess := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_PropertyV2__Key_Assessor_Fid = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverridePropAssess(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsPropAssess := WithSuppressionsPropAssess+GetOverridePropAssess;				

	With_PropertyV2__Key_Assessor_Fid_Records := DENORMALIZE(With_BIP_Best_Records, WithCorrectionsPropAssess,	
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_PropertyV2__Key_Assessor_Fid := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		
	
	PropertyV2__Key_Deed_Fid_Records :=	
			JOIN(Property_lookup_search_records(ln_fares_id[2] IN ['D','M']), LN_PropertyV2.key_deed_fid(Options.isFCRA),
				Common.DoFDCJoin_PropertyV2__Key_Deed_Fid = TRUE AND
				KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id) and
				ArchiveDate((string)RIGHT.contract_date, (string)RIGHT.recording_date) <= LEFT.P_InpClnArchDt[1..8] and
				//marketing
					IF(Options.isMarketing,(LN_PropertyV2_Src(RIGHT.ln_fares_id) IN PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES OR PublicRecords_KEL.ECL_Functions.Common_Functions.IsMarketingAllowedKey(LN_PropertyV2_Src(RIGHT.ln_fares_id), Right.State)), TRUE)	AND
				//DRM check fares
						(LN_PropertyV2_Src(RIGHT.ln_fares_id) not IN if(options.Data_Restriction_Mask[Risk_Indicators.iid_constants.posFaresRestriction]=Risk_Indicators.iid_constants.sTrue, [MDR.sourceTools.src_Fares_Deeds_from_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Deeds], [])),
				TRANSFORM(Layouts_FDC.Layout_PropertyV2_Key_Deed_Fid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.p_inpclnarchdt := left.p_inpclnarchdt,
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
					SELF.Date_First_Seen :=  (INTEGER)ArchiveDate((string)RIGHT.contract_date,(string)RIGHT.recording_date),
					SELF.Src := LN_PropertyV2_Src(RIGHT.ln_fares_id),
					SELF.DPMBitmap := SetDPMBitmap( Source := LN_PropertyV2_Src(RIGHT.ln_fares_id), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Marketing_State := Right.State),
					self.Archive_Date :=  IF((INTEGER)SELF.date_first_seen=0,'',(STRING)SELF.date_first_seen);
					SELF := RIGHT,
					self.prop_correct_ffid := left.prop_correct_ffid;
					self.prop_correct_lnfare := left.prop_correct_lnfare;
					SELF := []), 
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_JOIN_LIMIT));				
	
	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsPropDeed := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												PropertyV2__Key_Deed_Fid_Records(trim(ln_fares_id) not in prop_correct_lnfare), 
												PropertyV2__Key_Deed_Fid_Records);

	//if there are corrections lets go find them
	GetOverridePropDeed := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_PropertyV2__Key_Deed_Fid = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverridePropDeed(Input_FDC));//consumer only since FCRA only -- no business in FCRA

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
				KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id) and
				right.source_code_2 = 'P' and
				//marketing
					IF(Options.isMarketing,(LN_PropertyV2_Src(RIGHT.ln_fares_id) IN PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES OR PublicRecords_KEL.ECL_Functions.Common_Functions.IsMarketingAllowedKey(LN_PropertyV2_Src(RIGHT.ln_fares_id), Right.ST)), TRUE)	AND
				//DRM check fares
					(LN_PropertyV2_Src(RIGHT.ln_fares_id) not IN if(options.Data_Restriction_Mask[Risk_Indicators.iid_constants.posFaresRestriction]=Risk_Indicators.iid_constants.sTrue, [MDR.sourceTools.src_Fares_Deeds_from_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Deeds], [])),
				TRANSFORM(Layouts_FDC.Layout_PropertyV2_Key_Search_Fid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					self.p_inpclnarchdt := left.p_inpclnarchdt,
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
					SELF.PartyIsBorrower := RIGHT.source_code[1] = 'B',//not used in attributes
					SELF.PartyIsSeller := RIGHT.source_code[1] = 'S',
					SELF.PartyIsCareOf := RIGHT.source_code[1] = 'C',//not used in attributes
					SELF.OwnerAddress := RIGHT.source_code[2] = 'O',//not used in attributes
					SELF.SellerAddress := RIGHT.source_code[2] = 'S',//not used in attributes
					SELF.PropertyAddress := RIGHT.source_code[2] = 'P',
					SELF.BorrowerAddress := RIGHT.source_code[2] = 'B',//not used in attributes
					SELF.DPMBitmap := SetDPMBitmap( Source := LN_PropertyV2_Src(RIGHT.ln_fares_id), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Marketing_State := Right.ST),
					SELF := RIGHT,
					self.prop_correct_ffid := left.prop_correct_ffid;
					self.prop_correct_lnfare := left.prop_correct_lnfare;
					SELF := []), 
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.PROPERTY_SEARCH_FID_JOIN_LIMIT));				
	
	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsPropSearch := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												PropertyV2__Key_Search_Fid_Records(trim((STRING)persistent_record_id) not in prop_correct_lnfare), 
												PropertyV2__Key_Search_Fid_Records);

	//if there are corrections lets go find them
	GetOverridePropSearch := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_PropertyV2__Key_Search_Fid = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverridePropSearch(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsPropSearch := WithSuppressionsPropSearch+GetOverridePropSearch;			

	With_PropertyV2__Key_Search_Fid_Records := DENORMALIZE(With_PropertyV2__Key_Deed_Fid_Records, WithCorrectionsPropSearch,	
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_PropertyV2__Key_Search_Fid := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));
					
/*************************************************************************************************************/	
//for searching
	addresses_for_AVM_pre := WithCorrectionsPropSearch(DID IN Input_RelativesWithHHIDLexids);
	
	addresses_for_AVM :=
		PROJECT( addresses_for_AVM_pre(prim_name <> ''AND zip != ''), //cleaning up garbage
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric_inputs,
				SELF.UIDAppend       := LEFT.UIDAppend,
				SELF.PrimaryRange    := LEFT.prim_range,
				SELF.PrimaryName     := LEFT.prim_name,
				SELF.State           := LEFT.st,
				SELF.ZIP5            := LEFT.zip,
				SELF.SecondaryRange  := LEFT.sec_range,	
				self := LEFT,
				Self := [];));

	addresses_for_AVM_slim := dedup(sort((addresses_for_AVM+Input_Address_Current_Previous)(PrimaryName != '' AND ZIP5 != ''), PrimaryRange, PrimaryName, SecondaryRange, State, ZIP5, UIDAppend ),PrimaryRange, PrimaryName, SecondaryRange, State, ZIP5, UIDAppend );//dedup by avm keyed fields
/*************************************************************************************************************/




	AVM_V2__Key_AVM_Address_Records :=	
			JOIN(addresses_for_AVM_slim, IF( Options.isFCRA, AVM_V2.Key_AVM_Address_FCRA, AVM_V2.Key_AVM_Address) ,
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
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.AVM, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF.avm_correct_ffid := LEFT.avm_correct_ffid,
					SELF.avm_correct_RECORD_ID := LEFT.avm_correct_RECORD_ID,					
					SELF := RIGHT,
					SELF := []), 
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_100));

	WithSuppressionsAVM := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												AVM_V2__Key_AVM_Address_Records((trim(prim_range) + trim(prim_name) + trim(sec_range) not in avm_correct_RECORD_ID)), 
												AVM_V2__Key_AVM_Address_Records);
												
	GetOverrideAVMAddress := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND	Common.DoFDCJoin_AVM_V2__Key_AVM_Address = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideAVM(Input_Address_Consumer_recs));//consumer only since FCRA only -- no business in FCRA


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
			ArchiveDate((string)right.history_date) <= left.P_InpClnArchDt[1..8] and //the shell today does not look at avm dates in the join
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_AVM_V2__Key_AVM_Address := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_AVM_V2_Key_AVM_Address_Norm_Records,  
																						self.Archive_Date :=  ArchiveDate((string)left.history_date);
																						self.history_date :=  archivedate(left.history_date);
																						self := left, 
																						self := []));
						SELF := LEFT,
						SELF := []));	



	AVM_V2__Key_AVM_Medians :=	
			JOIN(AVMGeoInputPrevCurr, IF( Options.isFCRA, avm_v2.Key_AVM_Medians_fcra, avm_v2.Key_AVM_Medians) ,
				Common.DoFDCJoin_AVM_V2__Key_AVM_Medians = TRUE AND 
				KEYED(LEFT.AddressGeoLink = RIGHT.fips_geo_12),		
				TRANSFORM(Layouts_FDC.Layout_AVM_V2_Key_AVM_Medians_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.AVM,
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.AVM, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),			
					SELF.avm_medians_correct_ffid := LEFT.avm_medians_correct_ffid,
					SELF.avm_medians_correct_RECORD_ID := LEFT.avm_medians_correct_RECORD_ID,				
					SELF := RIGHT,
					SELF := []), 
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));// boca shell is 1k will adjust later


	WithSuppressionsAVMMedians := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												AVM_V2__Key_AVM_Medians((trim(fips_geo_12) not in avm_medians_correct_record_id)), 
												AVM_V2__Key_AVM_Medians);
												
	GetOverrideAVMMedians := IF((unsigned)input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND	Common.DoFDCJoin_AVM_V2__Key_AVM_Medians = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideAVMMedians(Input_Address_Consumer_recs));//consumer only since FCRA only -- no business in FCRA



	AVM_V2__Key_AVM_Medians_Norm_Records := PROJECT(WithSuppressionsAVMMedians, TRANSFORM(Layouts_FDC.Layout_AVM_V2_Key_AVM_Medians_Norm_Records, 
				SELF.IsCurrent := TRUE, 
				SELF := LEFT, 
				SELF := [])) +
			NORMALIZE(WithSuppressionsAVMMedians, left.history, TRANSFORM(Layouts_FDC.Layout_AVM_V2_Key_AVM_Medians_Norm_Records, 
				SELF.IsCurrent := FALSE, 
				SELF := RIGHT, 
				SELF := LEFT, 
				SELF := []));

	WithOverrideAVMMedians := GetOverrideAVMMedians + AVM_V2__Key_AVM_Medians_Norm_Records;	

	With_Key_AVM_Medians_Records := DENORMALIZE(With_AVM_V2_Key_AVM_Records, WithOverrideAVMMedians,
			ArchiveDate(right.history_date) <= left.P_InpClnArchDt[1..8] and //the shell today does not look at avm dates in the join
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_AVM_V2__Key_AVM_Medians := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_AVM_V2_Key_AVM_Medians_Norm_Records,  
																						self.Archive_Date :=  ArchiveDate(left.history_date);
																						self.history_date :=  ArchiveDate(left.history_date);
																						self := left, 
																						self := []));
						SELF := LEFT,
						SELF := []));

		
	BIP_Linked_Businesses := PublicRecords_KEL.MAS_Get.BIP_Linked_Businesses(Options, BusinessInput);

	BIP_Filters := IF(Common.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids_extra = TRUE, BIP_Linked_Businesses.BIP_Filters);//turn off for brm marketing
	Linked_BIPIDs := IF(Common.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids_extra = TRUE, BIP_Linked_Businesses.Linked_BIPIDs);//turn off for brm marketing
	
	Business_Header_Key_Linking_with_filters := IF(Common.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids_extra = TRUE, //turn off for brm marketing
																							BIPV2.Key_BH_Linking_Ids.kfetch2(Linked_BIPIDs,
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.PowID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									linkingOptions,
																									PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_100,//we dropped down for memory limit errors was at 10k now at 5k, no attributes for these at this point.
																									FALSE, /* dnbFullRemove */
																									TRUE, /* bypassContactSuppression */
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin,
																									mod_access := mod_access,
																									dFilter := BIP_Filters));
																									
	With_Business_Header_Key_Linking_with_filters := DENORMALIZE(With_Key_AVM_Medians_Records, Business_Header_Key_Linking_with_filters,	
			ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2__Key_BH_Linking_kfetch2 := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BIPV2__Key_BH_Linking_kfetch2, 
																											SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(Left.Source, 0, Left.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(Left.source), Is_Business_Header := TRUE, Marketing_state := left.st, KELPermissions := CFG_File),
																											self.Archive_Date :=  ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);			
																											self.dt_first_seen :=  (INTEGER)archivedate((string)left.dt_first_seen);			
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
		
		
	Business_Header_Key_Linking := IF(Common.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids = TRUE, 
																							BIPV2.Key_BH_Linking_Ids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Lookup_And_Input_LinkIDs),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									linkingOptions,
																									PublicRecords_KEL.ECL_Functions.Constants.Business_Header_LIMIT,
																									FALSE, /* dnbFullRemove */
																									TRUE, /* bypassContactSuppression */
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin,
																									mod_access := mod_access));
		
	With_Business_Header_Key_Linking := DENORMALIZE(With_Business_Header_Key_Linking_with_filters, Business_Header_Key_Linking,	
			ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2__Key_BH_Linking_kfetch2 := LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2 +
														project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BIPV2__Key_BH_Linking_kfetch2,
																											SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(Left.Source, 0, Left.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(Left.source), Is_Business_Header := TRUE, Marketing_state := left.st, KELPermissions := CFG_File),
																											self.Archive_Date :=  ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);
																											self.dt_first_seen :=   (INTEGER)archivedate((string)left.dt_first_seen);
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
	
		Business_Address := join(input_FDC, Business_Header_Key_Linking,
						LEFT.UIDAppend = RIGHT.UniqueID and
						LEFT.B_LexIDUlt = right.UltID and
						LEFT.B_LexIDOrg = right.OrgID and
						LEFT.B_LexIDLegal = right.SeleID,
							transform(Layouts_FDC.Layout_BIPV2__Key_BH_Linking_kfetch2,
								self.UIDAppend := right.UniqueID,
								self.g_procuid := right.UniqueID,
								self.p_inpclnarchdt := left.p_inpclnarchdt,
								SELF.B_LexIDUlt := right.UltID,
								SELF.B_LexIDOrg := right.OrgID,
								SELF.B_LexIDLegal := right.SeleID,
								self := right,
								self := left,
								self := []));	
	
	Associated_Business_Address := PROJECT(Business_Address, TRANSFORM(Layouts_FDC.LayoutAddressGeneric_inputs,
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
																					self.p_inpclnarchdt := left.p_inpclnarchdt,
																					SELF := LEFT,
																					SELF := []));
																					
/*************************************************************************************************************/	
//for searching
	//Include associated business address by Seleid to get additional address info
	Input_Best_and_Business_Address := DEDUP(SORT((Input_and_Best_Address + Associated_Business_Address)(PrimaryName != '' AND ZIP5 != ''), 
																				PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, UIDAppend),
																						PrimaryRange, Predirectional, PrimaryName, AddrSuffix, Postdirectional, City, State, ZIP5, SecondaryRange, UIDAppend);			
		
/*************************************************************************************************************/
/*************************************************************************************************************/		
//for searching	
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
	addr_hist_addresses_for_advo_pre := NORMALIZE(FDCDataset_Mini(RepNumber <> 6), LEFT.Dataset_Header__Key_Addr_Hist, TRANSFORM(RECORDOF(RIGHT), SELF.P_LexID := LEFT.P_LexID, SELF := RIGHT));
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
				
	addresses_for_Advo_slim := dedup(sort((property_addresses_for_Advo + addr_hist_addresses_for_advo + Input_Best_and_Business_Address)(PrimaryName != '' AND ZIP5 != ''), PrimaryRange, PrimaryName, AddrSuffix, SecondaryRange, Predirectional, Postdirectional, SecondaryRange, ZIP5, UIDAppend )
																								,PrimaryRange, PrimaryName, AddrSuffix, SecondaryRange, Predirectional, Postdirectional, SecondaryRange, ZIP5, UIDAppend  );//dedup by advo keyed fields
/*************************************************************************************************************/


	// ADVO: business and consumer
	ADVO__Key_Addr1_History := IF(Options.IsFCRA, ADVO.Key_Addr1_FCRA_History, ADVO.Key_Addr1_History);
	Key_Advo_Addr1_History_Records := 
		JOIN(addresses_for_Advo_slim, ADVO__Key_Addr1_History,
				Common.DoFDCJoin_ADVO__Key_Addr1_History = TRUE AND NOT Options.IsPrescreen AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.AddrSuffix = RIGHT.addr_suffix AND
					LEFT.Predirectional = RIGHT.predir AND
					LEFT.Postdirectional = RIGHT.postdir AND
					LEFT.SecondaryRange = RIGHT.sec_range) and
					ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_ADVO__Key_Addr1_History,
					SELF.Src := MDR.sourceTools.src_advo_valassis,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_advo_valassis, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);
					self.date_first_seen :=  archivedate((string)right.date_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
	
	WithSuppressionsAdvoHist := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												Key_Advo_Addr1_History_Records((trim(zip) + trim(prim_range) + trim(prim_name) + trim(sec_range) not in ADVO_correct_record_id)), 
												Key_Advo_Addr1_History_Records);	
	
	GetOverrideAdvoAddress := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND	Common.DoFDCJoin_ADVO__Key_Addr1_History = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideAdvo(Input_Address_Consumer_recs));//consumer only since FCRA only -- no business in FCRA	
	
	WithOverrideAdvoHist := GetOverrideAdvoAddress + WithSuppressionsAdvoHist;		

	With_ADVO_History_Records := DENORMALIZE(With_Business_Header_Key_Linking, Key_Advo_Addr1_History_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_ADVO__Key_Addr1_History := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	
//end of section with 'extra' searchable datasets	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						
	// Doxie_Files.Key_Offenders(isFCRA) --	FCRA and NonFCRA	
Doxie_Files__Key_Offenders_Records_Regular :=
	JOIN(Input_FDC_Business_Contact_LexIDs, Doxie_Files.Key_Offenders(Options.isFCRA),
		Common.DoFDCJoin_Doxie_Files__Key_Offenders = TRUE AND
		LEFT.P_LexID > 0 AND
		KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.sdid) and
		ArchiveDate((string)right.fcra_date) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenders,
					_src := Doxie_Files__Key_Offenders_Src(RIGHT.data_type);
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.data_type := IF( Options.isFCRA = TRUE, RIGHT.data_type, '' ), // populate only if using the FCRA key
					SELF.src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.fcra_date);
					self.fcra_date :=   archivedate(right.fcra_date);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob);
					SELF.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					DOB_AliasCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob_alias);
					SELF.dob_alias := (STRING)DOB_AliasCleaned.dob;
					SELF.DOB_AliasPadded := DOB_AliasCleaned.DOBPadded;
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), KEEP(100));
				
				
Doxie_Files__Key_Offenders_Records_Inferred :=
	JOIN(Input_FDC, Doxie_Files.Key_Offenders(Options.isFCRA),
		Common.DoFDCJoin_Doxie_Files__Key_Offenders = TRUE AND
		LEFT.P_LexID > 0 AND
		KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.sdid) and                         
		ArchiveDate((string)right.fcra_date) <= (STRING)STD.Date.AdjustDate((INTEGER)LEFT.P_InpClnArchDt[1..8],2,0,0) AND
		ArchiveDate((string)right.fcra_date) >= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenders,
					_src := Doxie_Files__Key_Offenders_Src(RIGHT.data_type);
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.data_type := IF( Options.isFCRA = TRUE, RIGHT.data_type, '' ), // populate only if using the FCRA key
					SELF.src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.fcra_date);
					self.fcra_date :=   archivedate(right.fcra_date);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob);
					SELF.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					DOB_AliasCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob_alias);
					SELF.dob_alias := (STRING)DOB_AliasCleaned.dob;
					SELF.DOB_AliasPadded := DOB_AliasCleaned.DOBPadded;
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), KEEP(100));
				
			Doxie_Files__Key_Offenders_Records	:= Doxie_Files__Key_Offenders_Records_Regular + IF(Options.IncludeInferredPerformance and options.isFCRA,Doxie_Files__Key_Offenders_Records_Inferred,DATASET([],Layouts_FDC.Layout_Doxie_Files__Key_Offenders));
				
				
		WithSuppressionsCrimOffenders := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																				Doxie_Files__Key_Offenders_Records(offender_key NOT IN crim_correct_ofk), 
																				Doxie_Files__Key_Offenders_Records);		
		
		GetOverrideCrimOffenders := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Doxie_Files__Key_Offenders = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideCrimOffenders(input_fdc));//consumer only since FCRA only -- no business in FCRA
	
		WithCorrectionsCrimOffenders := WithSuppressionsCrimOffenders+GetOverrideCrimOffenders;
		WithCorrectionsCrimOffenders_filter := dedup(sort(WithSuppressionsCrimOffenders+GetOverrideCrimOffenders,offender_key, UIDAppend),offender_key, UIDAppend);

		
	With_Doxie_Files__Key_Offenders := DENORMALIZE(With_ADVO_History_Records, WithCorrectionsCrimOffenders,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenders := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
						
	// Doxie_files.Key_Court_Offenses -- FCRA only (even though nonFCRA version of key exists)
	// Doxie_files.Key_Court_Offenses does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_FCRA_Records so we can join by offender key
	Doxie_files__Key_Court_Offenses_Records_Regular := 
			JOIN(WithCorrectionsCrimOffenders_filter, Doxie_files.Key_Court_Offenses(isFCRA := Options.isFCRA),
				Common.DoFDCJoin_Doxie_files__Key_Court_Offenses = TRUE AND
				KEYED(LEFT.offender_key = RIGHT.ofk) and
				ArchiveDate((string)right.fcra_date) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Doxie_files__Key_Court_Offenses,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Accurint_Crim_Court,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_Crim_Court, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)right.fcra_date);
					self.fcra_date := archivedate( right.fcra_date);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_100));

Doxie_files__Key_Court_Offenses_Records_Inferred := 
			JOIN(WithCorrectionsCrimOffenders_filter, Doxie_files.Key_Court_Offenses(isFCRA := Options.isFCRA),
				Common.DoFDCJoin_Doxie_files__Key_Court_Offenses = TRUE AND
				KEYED(LEFT.offender_key = RIGHT.ofk) and
				ArchiveDate((string)right.fcra_date) <= (STRING)STD.Date.AdjustDate((INTEGER)LEFT.P_InpClnArchDt[1..8],2,0,0) AND
				ArchiveDate((string)right.fcra_date) >= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Doxie_files__Key_Court_Offenses,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Accurint_Crim_Court,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_Crim_Court, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)right.fcra_date);
					self.fcra_date := archivedate( right.fcra_date);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_100));
				
Doxie_files__Key_Court_Offenses_Records	:= Doxie_files__Key_Court_Offenses_Records_Regular + IF(Options.IncludeInferredPerformance and options.isFCRA,Doxie_files__Key_Court_Offenses_Records_Inferred,DATASET([],Layouts_FDC.Layout_Doxie_files__Key_Court_Offenses));			
			
		WithSuppressionsCrimCourt := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																		Doxie_files__Key_Court_Offenses_Records(offender_key NOT IN crim_correct_ofk), 
																		Doxie_files__Key_Court_Offenses_Records);		
		
		GetOverrideCrimCourt := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Doxie_files__Key_Court_Offenses = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideCrimCourt(input_fdc));//consumer only since FCRA only -- no business in FCRA
	
		WithCorrectionsCrimCourt := WithSuppressionsCrimCourt+GetOverrideCrimCourt;	

			
	With_Doxie_files__Key_Court_Offenses := DENORMALIZE(With_Doxie_Files__Key_Offenders, WithCorrectionsCrimCourt,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_files__Key_Court_Offenses := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
						
	// Doxie_Files.Key_Offenses -- FCRA only (even though nonFCRA version of key exists)
	// Doxie_files.Key_Offenses does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_Records so we can join by offender key
	Doxie_Files__Key_Offenses_Records_Regular := 
			JOIN(WithCorrectionsCrimOffenders_filter, Doxie_Files.Key_Offenses(isFCRA := Options.isFCRA),
				Common.DoFDCJoin_Doxie_Files__Key_Offenses = TRUE and				
				KEYED(LEFT.offender_key = RIGHT.ok) and 
				ArchiveDate((string)right.fcra_date) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenses,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)right.fcra_date);
					self.fcra_date :=  archivedate(right.fcra_date);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_100));
				
	Doxie_Files__Key_Offenses_Records_Inferred := 
			JOIN(WithCorrectionsCrimOffenders_filter, Doxie_Files.Key_Offenses(isFCRA := Options.isFCRA),
				Common.DoFDCJoin_Doxie_Files__Key_Offenses = TRUE and				
				KEYED(LEFT.offender_key = RIGHT.ok) and 
				ArchiveDate((string)right.fcra_date) <= (STRING)STD.Date.AdjustDate((INTEGER)LEFT.P_InpClnArchDt[1..8],2,0,0) AND
				ArchiveDate((string)right.fcra_date) >= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenses,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)right.fcra_date);
					self.fcra_date :=  archivedate(right.fcra_date);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_100));
					
Doxie_Files__Key_Offenses_Records	:= Doxie_Files__Key_Offenses_Records_Regular + IF(Options.IncludeInferredPerformance and options.isFCRA,Doxie_Files__Key_Offenses_Records_Inferred,DATASET([],Layouts_FDC.Layout_Doxie_Files__Key_Offenses));

		WithSuppressionsCrimOffenses := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																		Doxie_Files__Key_Offenses_Records(offender_key NOT IN crim_correct_ofk), 
																		Doxie_Files__Key_Offenses_Records);
		
		GetOverrideCrimOffenses := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Doxie_Files__Key_Offenses = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideCrimOffenses(input_fdc));//consumer only since FCRA only -- no business in FCRA
	
		WithCorrectionsCrimOffenses := WithSuppressionsCrimOffenses+GetOverrideCrimOffenses;
					
	With_Doxie_Files__Key_Offenses := DENORMALIZE(With_Doxie_files__Key_Court_Offenses, WithCorrectionsCrimOffenses,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenses := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// Doxie_Files.Key_Offenders_Risk -- NonFCRA only
	Doxie_Files__Key_Offenders_Risk_Records := 
			JOIN(Input_FDC_Business_Contact_LexIDs, Doxie_Files.Key_Offenders_Risk,
				Common.DoFDCJoin_Doxie_Files__Key_Offenders_Risk = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.sdid) and 
				ArchiveDate((string)(string)right.earliest_offense_date) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenders_Risk,
					_src := Doxie_Files__Key_Offenders_Src(RIGHT.data_type);
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.earliest_offense_date);
					self.earliest_offense_date :=  archivedate(right.earliest_offense_date);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(1000));

	With_Doxie_Files__Key_Offenders_Risk := DENORMALIZE(With_Doxie_Files__Key_Offenses, Doxie_Files__Key_Offenders_Risk_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenders_Risk := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		

	// Doxie_Files.Key_Punishment -- NonFCRA only (even though FCRA version of key exists)
	// Doxie_Files.Key_Punishment does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_Records so we can join by offender key
	Doxie_Files__Key_Punishment_Records := 
			JOIN(WithCorrectionsCrimOffenders_filter, Doxie_Files.Key_Punishment(isFCRA := Options.isFCRA),
				Common.DoFDCJoin_Doxie_Files__Key_Punishment = TRUE AND
				KEYED(LEFT.offender_key = RIGHT.ok) and
				ArchiveDate((string)(string)right.event_dt) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Punishment,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)(string)right.event_dt) ;
					self.event_dt :=  archivedate((string)right.event_dt) ;
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
				
	With_Doxie_Files__Key_Punishment := DENORMALIZE(With_Doxie_Files__Key_Offenders_Risk, Doxie_Files__Key_Punishment_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Punishment := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		
    	//----------------------------------Household------------------------------------

    
	// --------------------[ Bankruptcy records ]--------------------
	
	// BankruptcyV3.key_bankruptcyV3_did has a parameter to say if FCRA or nonFCRA - same file layout
	Bankruptcy_Files__Key_bankruptcy_did_Records :=	
			 JOIN(Input_FDC_RelativesLexids_HHIDLexids_Business_Contact_LexIDs, BankruptcyV3.key_bankruptcyV3_did(Options.isFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	// BankruptcyV3.key_bankruptcyv3_search_full_bip has a parameter to say if FCRA or nonFCRA - same file layout		
	Bankruptcy_Files__Key_Search_Records_pre_Regular := 
		JOIN(Bankruptcy_Files__Key_bankruptcy_did_Records, BankruptcyV3.key_bankruptcyv3_search_full_bip(Options.isFCRA),
				Common.DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did = TRUE AND
				KEYED(LEFT.TmsID != '' AND 
				LEFT.TmsID = RIGHT.TmsID) AND
				LEFT.court_code = RIGHT.court_code AND
				LEFT.case_number = RIGHT.case_number and
				(integer)LEFT.did = (integer)RIGHT.did and
				ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Bankruptcy,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Bankruptcy, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);
					self.date_first_seen :=  archivedate((string)right.date_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));
				
	Bankruptcy_Files__Key_Search_Records_pre_Inferred := 
		JOIN(Bankruptcy_Files__Key_bankruptcy_did_Records, BankruptcyV3.key_bankruptcyv3_search_full_bip(Options.isFCRA),
				Common.DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did = TRUE AND
				KEYED(LEFT.TmsID != '' AND 
				LEFT.TmsID = RIGHT.TmsID) AND
				LEFT.court_code = RIGHT.court_code AND
				LEFT.case_number = RIGHT.case_number and
				(integer)LEFT.did = (integer)RIGHT.did and
				ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= (STRING)STD.Date.AdjustDate((INTEGER)LEFT.P_InpClnArchDt[1..8],2,0,0) AND
				ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) >= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Bankruptcy,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Bankruptcy, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);
					self.date_first_seen :=  archivedate((string)right.date_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));
				
Bankruptcy_Files__Key_Search_Records_pre	:= Bankruptcy_Files__Key_Search_Records_pre_Regular + IF(Options.IncludeInferredPerformance and options.isFCRA,Bankruptcy_Files__Key_Search_Records_pre_Inferred,DATASET([],Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search));

	// Left Only join to the Bankruptcy Withdrawn key to remove all Withdrawn records.
	Bankruptcy_Files__Key_Search_Records := 
		JOIN(Bankruptcy_Files__Key_Search_Records_pre, BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,Options.IsFCRA),
				Common.DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_WithdrawnStatus = TRUE AND
				KEYED(LEFT.TmsID = RIGHT.TmsID),
				TRANSFORM(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := LEFT, 
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),
				LEFT ONLY);
		
	WithSuppressionsBankruptcySEARCH := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												Bankruptcy_Files__Key_Search_Records(TRIM(tmsid) + TRIM(name_type)+ did NOT IN bankrupt_correct_cccn), 
												Bankruptcy_Files__Key_Search_Records);		
		
	GetBankoRemoveRecsOverrides := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
															WithSuppressionsBankruptcySEARCH((TRIM(court_code) + TRIM(case_number) NOT IN bankrupt_correct_RECORD_ID)),
															WithSuppressionsBankruptcySEARCH);//pull out corrected records since this requires different searching
																//checked in the override key and the search key, all of the date_filed fields are identical so it appears records with identical court code/case number do not get updated
			
	GetOverrideBankruptcy := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideBanko(Input_FDC));//consumer only since FCRA only -- no business in FCRA	
		

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
										PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
										BIPV2.IDconstants.JoinTypes.LimitTransformJoin));
		
	Bankruptcy_Files__Key_Linkid_Records := 
		JOIN(Bankruptcy_Files__Linkids_Key_Search, BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,Options.IsFCRA),
				Common.DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_WithdrawnStatus = TRUE AND
				KEYED(LEFT.TmsID = RIGHT.TmsID),
				TRANSFORM(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyV3_linkids_Key,
					SELF.UIDAppend := LEFT.UniqueID,
					SELF.ULTID := LEFT.ULTID,
					SELF.ORGID := LEFT.ORGID,	
					SELF.SELEID := LEFT.SELEID,
					SELF := LEFT, 
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),
				LEFT ONLY);		
		
		With_Business_Bankruptcy := 
		DENORMALIZE(With_Bankruptcy,Bankruptcy_Files__Key_Linkid_Records,
		ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Bankruptcy_Files__Linkids_Key_Search := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyV3_linkids_Key, 
															SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Bankruptcy, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
															self.Archive_Date :=  ArchiveDate((string)left.date_first_seen, (string)left.date_vendor_first_reported);
															self.date_first_seen :=  archivedate((string)right.date_first_seen);
															SELF.Src := MDR.sourceTools.src_Bankruptcy,
															SELF := LEFT, 
															SELF := []));
						SELF := LEFT,
						SELF := []));	
						
	// --------------------[ Aircraft records ]--------------------

	// FAA.key_aircraft_did has a parameter to say if FCRA or nonFCRA - same file layout
	Key_Aircraft_did_Records := //	Not in Uses, no dates being mapped does not need DateSelector
			JOIN(Input_FDC, FAA.key_aircraft_did(Options.isFCRA),
				Common.DoFDCJoin_Aircraft_Files__FAA__Aircraft = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_FAA__key_aircraft_did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));


	// FAA.key_aircraft_id has a parameter to say if FCRA or nonFCRA - same file layout		
	Key_Aircraft_ID_Records := 
		JOIN(Key_Aircraft_did_Records, FAA.key_aircraft_id(Options.isFCRA),
				Common.DoFDCJoin_Aircraft_Files__FAA__Aircraft = TRUE AND
				KEYED(LEFT.aircraft_id != 0 AND 
				LEFT.aircraft_id = RIGHT.aircraft_id) and 
				ArchiveDate((string)right.date_first_seen) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_FAA__key_aircraft_id,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Aircrafts,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Aircrafts, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen);
					self.date_first_seen :=  archivedate((string)right.date_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
				
	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsAircraft := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																	Key_Aircraft_ID_Records((string)persistent_record_id not in air_correct_record_id ), 
																	Key_Aircraft_ID_Records);

	//if there are corrections lets go find them
	GetOverrideAircraft := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Aircraft_Files__FAA__Aircraft = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideAircraft(Input_FDC));//consumer only since FCRA only -- no business in FCRA

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
				Common.DoFDCJoin_Watercraft_Files__Watercraft = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.l_did) and
				((Options.IsPrescreen AND right.state_origin not in restrictedStates) or ~Options.IsPrescreen),
				TRANSFORM(Layouts_FDC.Layout_Watercraft__key_watercraft_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	// Watercraft.key_watercraft_sid has a parameter to say if FCRA or nonFCRA - same file layout		
	//
	// See WatercraftV2_Services.get_owner_records for other possible Join restrictions/criteria.
	//

	Key_Watercraft_sid_Records_unsuppressed := 
		JOIN(Key_Watercraft_did_Records, Watercraft.key_watercraft_sid(Options.isFCRA),
					Common.DoFDCJoin_Watercraft_Files__Watercraft = TRUE AND
					KEYED(LEFT.watercraft_key = RIGHT.watercraft_key) AND
					KEYED(LEFT.sequence_key = '' OR LEFT.sequence_key = RIGHT.sequence_key) AND
					KEYED(LEFT.state_origin = '' OR LEFT.state_origin = RIGHT.state_origin) and
					((Options.IsPrescreen AND right.state_origin not in restrictedStates) or ~Options.IsPrescreen) and
					ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Watercraft__Key_Watercraft_SID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.fWatercraft(right.source_Code, right.state_origin);
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := DPPARegulatedWaterCraftRecord(RIGHT.dppa_flag), DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);
					self.date_first_seen :=  archivedate((string)right.date_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	Key_Watercraft_sid_Records := Suppress.MAC_SuppressSource(Key_Watercraft_sid_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);
	
	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsWatercraft := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												Key_Watercraft_sid_Records((string)persistent_record_id not in water_correct_RECORD_ID), 
												Key_Watercraft_sid_Records);

	//if there are corrections lets go find them
	GetOverrideWatercraft := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Watercraft_Files__Watercraft = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideWatercraft(Input_FDC));//consumer only since FCRA only -- no business in FCRA

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
		JOIN(Input_FDC_RelativesLexids_HHIDLexids_LexIDs, Prof_LicenseV2.Key_Proflic_Did(Options.IsFCRA),
				Common.DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did) and
				ArchiveDate((string)right.date_first_seen) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Prof_LicenseV2__Key_Proflic_Did,
					SELF.UIDAppend := LEFT.UIDAppend,				
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Professional_License;
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen);
					self.date_first_seen :=  archivedate((string)right.date_first_seen);
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Generic_Restriction := right.vendor = RiskView.Constants.directToConsumerPL_sources),					
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	Prof_LicenseV2__Key_Proflic_Did_Records := Suppress.MAC_SuppressSource(Prof_LicenseV2__Key_Proflic_Did_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsProfLic := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																Prof_LicenseV2__Key_Proflic_Did_Records(trim((string)prolic_key) not in proflic_correct_RECORD_ID), 
																Prof_LicenseV2__Key_Proflic_Did_Records);

	//if there are corrections lets go find them
	GetOverrideProfLic := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideProfLic(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsProfLic := WithSuppressionsProfLic+GetOverrideProfLic;

	// Append Occupation and Category data to Proflic DID key Records by joining to Prof_LicenseV2.Key_LicenseType_lookup.
	// Prof_LicenseV2.Key_LicenseType_lookup has a parameter to say if FCRA or nonFCRA - same file layout		
	Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records := 
		JOIN(WithCorrectionsProfLic, Prof_LicenseV2.Key_LicenseType_lookup(Options.IsFCRA),
					Common.DoFDCJoin_Prof_LicenseV2__Key_LicenseType_lookup = TRUE AND
					KEYED(LEFT.License_Type = RIGHT.License_Type) AND
					TRIM(RIGHT.License_Type) <> '',
				TRANSFORM(Layouts_FDC.Layout_Prof_LicenseV2__Key_Proflic_Did,
					SELF.Occupation := RIGHT.Occupation,
					SELF.Category := RIGHT.Category,
					SELF.Cleaned_License_Number := PublicRecords_KEL.ECL_Functions.Fn_Strip_Leading_Zeros(left.license_number);
					SELF := LEFT,
					SELF := []),
				LEFT OUTER, ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), KEEP(1));
			
	With_Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records := DENORMALIZE(With_Watercraft_Records, Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records,
      LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
      TRANSFORM(Layouts_FDC.Layout_FDC,
          SELF.Dataset_Prof_LicenseV2__Key_Proflic_Did := ROWS(RIGHT),
          SELF := LEFT,
          SELF := []));	

	// dx_prof_license_mari.Key_Did has a parameter to say if FCRA or nonFCRA - same file layout		
	Prof_License_Mari__Key_Did_Records_unsuppressed := 
		JOIN(Input_FDC_RelativesLexids_HHIDLexids_LexIDs, dx_prof_license_mari.Key_Did(iType),
				Common.DoFDCJoin_Prof_License_Mari__Key_Did = TRUE AND NOT Options.IsPrescreen AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did) and
				ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Prof_License_Mari__Key_Did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Mari_Prof_Lic;
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Generic_Restriction := right.std_source_upd IN Risk_Indicators.iid_constants.restricted_Mari_vendor_set),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);
					self.date_first_seen :=  archivedate((string)right.date_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	Prof_License_Mari__Key_Did_Records := Suppress.MAC_SuppressSource(Prof_License_Mari__Key_Did_Records_unsuppressed, mod_access, did_field := s_did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsMari := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																Prof_License_Mari__Key_Did_Records(trim((string)persistent_record_id) not in proflic_correct_RECORD_ID), 
																Prof_License_Mari__Key_Did_Records);

	//if there are corrections lets go find them
	GetOverrideMari := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Prof_License_Mari__Key_Did = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideMari(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsMari := WithSuppressionsMari+GetOverrideMari;

	// Append Occupation and Category data to Proflic Mari DID records by joining to Prof_LicenseV2.Key_LicenseType_lookup.
	// Prof_LicenseV2.Key_LicenseType_lookup has a parameter to say if FCRA or nonFCRA - same file layout		
	Prof_License_Mari__Key_Did_LicenseType_Lookup_Records := 
		JOIN(WithCorrectionsMari, Prof_LicenseV2.Key_LicenseType_lookup(Options.IsFCRA),
					Common.DoFDCJoin_Prof_LicenseV2__Key_LicenseType_lookup = TRUE AND NOT Options.IsPrescreen AND
					KEYED(LEFT.std_license_desc = RIGHT.License_Type) AND
					TRIM(RIGHT.License_Type) <> '',
				TRANSFORM(Layouts_FDC.Layout_Prof_License_Mari__Key_Did,
					SELF.Occupation := RIGHT.Occupation,
					SELF.Category := RIGHT.Category,
					SELF.type_cd := CASE(left.type_cd,
						'GR' => 'Y',
						'MD' => 'N',
						'');
					SELF.Cleaned_License_Number := PublicRecords_KEL.ECL_Functions.Fn_Strip_Leading_Zeros(left.license_nbr);
					SELF := LEFT,
					SELF := []),
				LEFT OUTER, ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), KEEP(1));
			
	With_Prof_License_Mari__Key_Did_LicenseType_Lookup_Records := DENORMALIZE(With_Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records, Prof_License_Mari__Key_Did_LicenseType_Lookup_Records,
      LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
      TRANSFORM(Layouts_FDC.Layout_FDC,
          SELF.Dataset_Prof_License_Mari__Key_Did := ROWS(RIGHT),
          SELF := LEFT,
          SELF := []));	
					
	// --------------------[ Emails ]--------------------
	
	Key_Email_Data__Key_DID := 
		JOIN(Input_FDC_Business_Contact_LexIDs, dx_Email.Key_Did(Options.isFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(1000));
			
	Key_Email_Data__Key_Email_Address := 
		JOIN(Input_FDC, dx_Email.Key_Email_Address(),
					Common.DoFDCJoin_Email_Data__Key_Email_Address = TRUE AND
					LEFT.P_InpClnEmail <> '' AND	
					KEYED(LEFT.P_InpClnEmail = RIGHT.clean_email) ,
				TRANSFORM(Layouts_FDC.Email_Data__Key_Email_Temp,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(1000));
				
	Key_DX_Email__Key_Email_Payload_Full := Key_Email_Data__Key_DID + Key_Email_Data__Key_Email_Address;
	
	Key_DX_Email__Key_Email_Payload_DID_unsuppressed := 
		JOIN(Key_DX_Email__Key_Email_Payload_Full, DX_Email.Key_Email_Payload(Options.isFCRA),
					Common.DoFDCJoin_Email_Data__Key_Email_Payload = TRUE AND 
					KEYED(LEFT.email_rec_key = RIGHT.email_rec_key) and
					ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_DX_Email__Key_Email_Payload,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Email_SRC,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Email_SRC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);
					self.date_first_seen :=  archivedate( (string)right.date_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(1000));	

	Key_DX_Email__Key_Email_Payload_DID := Suppress.MAC_SuppressSource(Key_DX_Email__Key_Email_Payload_DID_unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Email_Payload_Records := DENORMALIZE(With_Prof_License_Mari__Key_Did_LicenseType_Lookup_Records, Key_DX_Email__Key_Email_Payload_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DX_Email__Key_Email_Payload := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	Key_Email_Data__Key_Did_FCRA := 
		JOIN(Input_FDC, Email_Data.Key_Did_FCRA,
					Common.DoFDCJoin_Email_Data__Key_Did_FCRA = TRUE AND
					LEFT.P_LexID > 0 AND
					KEYED(LEFT.P_LexID = RIGHT.did) and
					ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Email_Data__Key_Did_FCRA,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Email_SRC,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);
					self.date_first_seen := archivedate(  (string)right.date_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(1000));
				
	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsEmail := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																Key_Email_Data__Key_Did_FCRA((string100)email_rec_key not in email_data_correct_record_id), 
																Key_Email_Data__Key_Did_FCRA);					

	//if there are corrections lets go find them
	GetOverrideEmail := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Email_Data__Key_Did_FCRA = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideEmail(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsEmail := WithSuppressionsEmail+GetOverrideEmail;

	With_Email_Data__Key_Did_FCRA_Records := DENORMALIZE(With_Email_Payload_Records, WithCorrectionsEmail,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Email_Data__Key_Did_FCRA := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));					

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
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.DoNotMail, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_100),KEEP(1));

	With_DNM_Name_Address_Records := DENORMALIZE(With_Email_Data__Key_Did_FCRA_Records, Key_DNM_Name_Address_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DMA__Key_DNM_Name_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	// FP: consumer address only; use consumer address data	
	Key_Fraudpoint3_Address_Records := //	Key has no dates does not need DateSelector
		JOIN(Input_Address_All, Fraudpoint3.Key_Address,
				Common.DoFDCJoin_Fraudpoint3__Key_Address = TRUE and //turn off for BRM marketing
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	With_Fraudpoint3_SSN_Records := DENORMALIZE(With_Fraudpoint3_Address_Records, Key_Fraudpoint3_SSN_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Fraudpoint3__Key_SSN := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
					
	Key_FraudPoint3__Key_Phone := JOIN(Input_Phone_All, FraudPoint3.key_phone, 
				Common.DoFDCJoin_Fraudpoint3__Key_Phone = TRUE AND
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone  = RIGHT.Phone_Number),
				TRANSFORM(Layouts_FDC.Layout_FraudPoint3_Key_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.FraudPoint3Source;
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	With_Key_FraudPoint3__Key_Phone := 
		DENORMALIZE(With_Fraudpoint3_SSN_Records, Key_FraudPoint3__Key_Phone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_FraudPoint3__Key_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));
	
	// USPIS_HotList: business and consumer agnostic--no name or companyname info provided
	Key_USPIS_HotList_addr_search_zip := 
			JOIN(Input_Address_All, USPIS_HotList.key_addr_search_zip, 
				Common.DoFDCJoin_USPIS_HotList__key_addr_search_zip = TRUE AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.AddrSuffix = RIGHT.addr_suffix AND
					LEFT.Predirectional = RIGHT.predir AND
					LEFT.Postdirectional = RIGHT.postdir AND
					LEFT.SecondaryRange = RIGHT.sec_range) and
					ArchiveDate((string)right.dt_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_USPIS_HotList__key_addr_search_zip,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.Hotlist,
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.Hotlist, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)right.dt_first_reported) ;
					self.dt_first_reported := archivedate((string)right.dt_first_reported) ;
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), keep(1));

	With_USPIS_HotList_Records := DENORMALIZE(With_Key_FraudPoint3__Key_Phone, Key_USPIS_HotList_addr_search_zip,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_USPIS_HotList__key_addr_search_zip := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	Key_UtilFile_Address := 
			JOIN(Input_Address_Current, UtilFile.Key_Address, 				
			Common.DoFDCJoin_UtilFile__Key_Address = TRUE AND
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.State = RIGHT.st AND
					LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.SecondaryRange = RIGHT.sec_range) and
					ArchiveDate((string)right.date_first_seen) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_UtilFile__Key_Address,
					SELF.Src := MDR.sourceTools.src_Utilities,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Utilities, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)right.date_first_seen);
					self.date_first_seen := archivedate( (string)right.date_first_seen);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	With_UtilFile_Address_Records := DENORMALIZE(With_USPIS_HotList_Records, Key_UtilFile_Address,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UtilFile__Key_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	
	Key_UtilFile_DID := 
			JOIN(Input_FDC, UtilFile.Key_DID, 
				Common.DoFDCJoin_UtilFile__Key_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did) and
				ArchiveDate((string)right.date_first_seen) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_UtilFile__Key_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Utilities,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Utilities, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen);
					self.date_first_seen :=  archivedate((string)right.date_first_seen);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000));

	With_UtilFile_DID_Records := DENORMALIZE(With_UtilFile_Address_Records, Key_UtilFile_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UtilFile__Key_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Input_Address_BusBest_Current_Previous_zip := DEDUP(SORT(Input_Address_BusBest_Current_Previous(PrimaryName != '' AND ZIP5 != ''), UIDAppend, Zip5), UIDAppend, Zip5);
		
	Key_RiskWise_CityStZip:=
			JOIN(Input_Address_BusBest_Current_Previous_zip, RiskWise.Key_CityStZip, 
				Common.DoFDCJoin_RiskWise__Key_CityStZip = TRUE AND
				LEFT.ZIP5 <> '' AND
				KEYED(LEFT.ZIP5 = RIGHT.Zip5), //no dates	
				TRANSFORM(Layouts_FDC.Layout_RiskWise__key_CityStZip,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.CityStateZip,
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.CityStateZip, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  '';//doesnt have any dates
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
				
	With_RiskWise_CityStZip_Records:= DENORMALIZE(With_UtilFile_DID_Records, Key_RiskWise_CityStZip,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_RiskWise__key_CityStZip := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));			
					
	
	// ----------[ Person ]----------
	
	Death_did := IF(Options.isFCRA, Doxie.key_death_masterV2_ssa_DID_fcra, Doxie.Key_Death_MasterV2_SSA_DID);
	
	Key_Doxie__Death_MasterV2_SSA_DID_unsuppressed := 
			JOIN(Input_FDC, Death_did, 
				Common.DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.l_did) and
				ArchiveDate((string)right.dod8) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Death_MasterV2_SSA_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.src,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := GLBARegulatedDeathMasterRecord(RIGHT.glb_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.dod8);
					DOB8Cleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob8);
					SELF.dob8 := (STRING)DOB8Cleaned.dob;
					SELF.DOB8Padded := DOB8Cleaned.DOBPadded;
					self.dod8 :=  archivedate((string)right.dod8);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	Key_Doxie__Death_MasterV2_SSA_DID := Suppress.MAC_SuppressSource(Key_Doxie__Death_MasterV2_SSA_DID_unsuppressed, mod_access, did_field := l_did, gsid_field := global_sid, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsDeath := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												Key_Doxie__Death_MasterV2_SSA_DID((trim((string)state_death_id)) not in Death_correct_record_id AND (trim((string)did) + trim((string)state_death_id)) not in Death_correct_record_id), 
												Key_Doxie__Death_MasterV2_SSA_DID);			
	//if there are corrections lets go find them
	GetOverrideDeath := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND 
																	(Common.DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID = TRUE OR Common.DoFDCJoin_DeathMaster__Key_SSN_SSA = TRUE),
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideDeath(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsDeath := WithSuppressionsDeath+GetOverrideDeath;	

	With_Death_MasterV2_SSA_DID_Records := 
		DENORMALIZE(With_RiskWise_CityStZip_Records, WithCorrectionsDeath,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Doxie__Key_Death_MasterV2_SSA_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	Key_DriversV2__DL_DID := 
			JOIN(Input_FDC, DriversV2.Key_DL_DID, 
				Common.DoFDCJoin_DriversV2__Key_DL_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did) and
				ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_DriversV2__Key_DL_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Source_Code,
					SELF.dl_number := IF(STD.Str.FilterOut(RIGHT.dl_number, '1') = '', '', RIGHT.dl_number); // Filter any repeating 1's to be blank, bad data
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source_Code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.st, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported);
					DOBCleaned := CleanDateOfBirth(RIGHT.dob);
					SELF.dob := DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					self.dt_first_seen :=  (integer)archivedate((string)right.dt_first_seen);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),keep(100));

	With_DriversV2__DL_DID_Records := 
		DENORMALIZE(With_Death_MasterV2_SSA_DID_Records, Key_DriversV2__DL_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DriversV2__Key_DL_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	Key_DriversV2__DL_Number_Records :=  
			JOIN(Input_FDC, DriversV2.Key_DL_Number, 
				Common.DoFDCJoin_DriversV2__Key_DL_Number = TRUE AND
				LEFT.P_InpClnDL != '' AND
				KEYED(LEFT.P_InpClnDL = RIGHT.s_dl) and
				ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_DriversV2__Key_DL_Number,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Source_Code,
					SELF.dl_number := IF(STD.Str.FilterOut(RIGHT.dl_number, '1') = '', '', RIGHT.dl_number); // Filter any repeating 1's to be blank, bad data
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source_Code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.st, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported);
					DOBCleaned := CleanDateOfBirth(RIGHT.dob);
					SELF.dob := DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					self.dt_first_seen := (integer) archivedate( (string)right.dt_first_seen);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),keep(100));

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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),keep(100));

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
			JOIN(Input_Address_Emerging_Current, dx_header.key_header_address(iType), 
				Common.DoFDCJoin_Doxie__Key_Header_Address = TRUE and
				LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(
					LEFT.PrimaryName = RIGHT.prim_name AND 
					LEFT.ZIP5 = RIGHT.zip AND 
					LEFT.PrimaryRange = RIGHT.prim_range AND 
					LEFT.SecondaryRange = RIGHT.sec_range) and
					 ArchiveDate((string)right.dt_first_seen )<= LEFT.P_InpClnArchDt[1..8] and
				IF(Options.isMarketing,(right.src IN PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES OR PublicRecords_KEL.ECL_Functions.Common_Functions.IsMarketingAllowedKey(right.src, right.st)), TRUE) and
				IF(Options.isFCRA ,(right.src IN SET(PublicRecords_KEL.ECL_Functions.Constants.Allowed_Consumer_Header_SRC(Options.isFCRA), Src)),right.src IN SET(PublicRecords_KEL.ECL_Functions.Constants.Allowed_Consumer_Header_SRC, Src) ) and
				(Header.isPreGLB_LIB(0, right.dt_first_seen, right.src, options.Data_Restriction_Mask) or glb_ok) and				
				(~mdr.Source_is_DPPA(RIGHT.src) OR(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src), Options.DPPAPurpose , RIGHT.src)) or Options.isFCRA) AND 		
				 right.src not in PublicRecords_KEL.ECL_Functions.Constants.masked_header_sources(options.Data_Restriction_Mask, Options.isFCRA),
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Header_Address,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Src,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(RIGHT.Src, 0, RIGHT.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(RIGHT.src), Marketing_State := right.St, KELPermissions := CFG_File, Is_Consumer_Header := TRUE),
					self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen);
					self.dt_first_seen :=  (integer)archivedate((string)right.dt_first_seen);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000),KEEP(2000));

	Key_Doxie__Header_Address_Records := Suppress.MAC_SuppressSource(Key_Doxie__Header_Address_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);	

	With_Doxie__Header_Address_Records := 
		DENORMALIZE(With_Certegy__Key_Certegy_DID_Records, Key_Doxie__Header_Address_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Doxie__Key_Header_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	// ----------[ Phone ]----------

	Gong__Key_History_DID := dx_Gong.key_history_DID(iType);
	Gong__Key_History_DID_Records_Unsuppressed := 
		JOIN( Input_FDC, Gong__Key_History_DID, 
			Common.DoFDCJoin_Gong__Key_History_DID AND
			LEFT.P_LexID > 0 AND
			KEYED(LEFT.P_LexID = RIGHT.l_did) and
			ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8],
			TRANSFORM(Layouts_FDC.Layout_Gong__Key_History_DID,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := RIGHT.Src,
				SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				SELF.Listing_Type := TRIM(RIGHT.Listing_Type_Bus + RIGHT.Listing_Type_Res + RIGHT.Listing_Type_Gov, ALL),
				self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen);
				self.dt_first_seen :=  archivedate((string)right.dt_first_seen);
				SELF := RIGHT, 
				SELF := LEFT,
				SELF := []), 
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));

	Gong__Key_History_DID_Records := Suppress.MAC_SuppressSource(Gong__Key_History_DID_Records_Unsuppressed, mod_access, did_field := l_did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	DropOverrideGongDID := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												Gong__Key_History_DID_Records((trim((string12)did+(string10)phone10+(string8)dt_first_seen) not in	gong_correct_record_id) AND // old way - prior to 11/13/2012
														((string)persistent_record_id not in gong_correct_record_id)),  // new way - using persistent_record_id
												Gong__Key_History_DID_Records);

	//if there are corrections lets go find them
	GetOverrideGongDID := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND 
																(Common.DoFDCJoin_Gong__Key_History_DID = TRUE OR Common.DoFDCJoin_Gong__Key_History_Address = TRUE OR Common.DoFDCJoin_Gong__Key_History_Phone = TRUE),
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideGong(Input_FDC));//consumer only since FCRA only -- no business in FCRA

					
	WithCorrectionsGongDID := DropOverrideGongDID+GetOverrideGongDID;

	With_Gong_History_DID_Records := 
		DENORMALIZE(With_Doxie__Header_Address_Records, WithCorrectionsGongDID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Gong__Key_History_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		


	Gong__Key_History_Address := dx_Gong.key_history_address(iType);
	Gong__Key_History_Address_Records_Unsuppressed := 
		JOIN( Input_and_Best_Address, Gong__Key_History_Address, 
			Common.DoFDCJoin_Gong__Key_History_Address AND
			LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
			KEYED(
				LEFT.PrimaryName = RIGHT.prim_name AND 
				LEFT.State = RIGHT.st AND
				LEFT.ZIP5 = RIGHT.z5 AND 
				LEFT.PrimaryRange = RIGHT.prim_range AND 
				LEFT.SecondaryRange = RIGHT.sec_range) and
				ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8],
			TRANSFORM(Layouts_FDC.Layout_Gong__Key_History_Address,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := RIGHT.Src,
				SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				SELF.Listing_Type := TRIM(RIGHT.Listing_Type_Bus + RIGHT.Listing_Type_Res + RIGHT.Listing_Type_Gov, ALL),
				self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen);
				self.dt_first_seen :=  archivedate((string)right.dt_first_seen);
				SELF := RIGHT, 
				SELF := LEFT,
				SELF := []), 
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000));//might be able to lower this later

	Gong__Key_History_Address_Records := Suppress.MAC_SuppressSource(Gong__Key_History_Address_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	DropOverrideGongAddr := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
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
		JOIN( Input_Phone_All, Gong__Key_History_Phone, 
			Common.DoFDCJoin_Gong__Key_History_Phone AND
			(INTEGER)LEFT.Phone > 0 AND
			KEYED(
				LEFT.Phone[4..10] = RIGHT.p7 AND 
				LEFT.Phone[1..3] = RIGHT.p3) and
				ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8],
			TRANSFORM(Layouts_FDC.Layout_Gong__Key_History_Phone,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := RIGHT.Src,
				SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				SELF.Listing_Type := TRIM(RIGHT.Listing_Type_Bus + RIGHT.Listing_Type_Res + RIGHT.Listing_Type_Gov, ALL),
				self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen);	
				self.dt_first_seen :=  archivedate((string)right.dt_first_seen);	
				SELF := RIGHT, 
				SELF := LEFT,
				SELF := []), 
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000));//might be able to lower this later

	Gong__Key_History_Phone_Records := Suppress.MAC_SuppressSource(Gong__Key_History_Phone_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	DropOverrideGongPhone := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
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
		JOIN( Input_Phone_All, Targus__Key_History_Phone, 
			Common.DoFDCJoin_Targus__Key_Targus_Phone AND
			(INTEGER)LEFT.Phone > 0 AND
			KEYED(
				LEFT.Phone[4..10] = RIGHT.p7 AND 
				LEFT.Phone[1..3] = RIGHT.p3) and
				archivedate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] ,
			TRANSFORM(Layouts_FDC.Layout_Targus__Key_Targus_Phone,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := MDR.sourceTools.src_Targus_White_pages,
				SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Targus_White_pages, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				self.Archive_Date :=  archivedate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported);	
				self.dt_first_seen := (integer)archivedate((string)right.dt_first_seen);	
				SELF := RIGHT, 
				SELF := LEFT,
				SELF := []), 
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));

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
		JOIN( Input_Phone_All, InfutorCID__Key_Phone, 
			Common.DoFDCJoin_InfutorCID__Key_Infutor_Phone AND
			(INTEGER)LEFT.Phone > 0 AND
			KEYED( LEFT.Phone = RIGHT.phone ) and
			ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8],
			TRANSFORM(Layouts_FDC.Layout_InfutorCID__Key_Infutor_Phone,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := MDR.sourceTools.src_InfutorCID,
				SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InfutorCID, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				self.Archive_Date := ArchiveDate((string)right.dt_first_seen);
				self.dt_first_seen := (integer)archivedate((string)right.dt_first_seen);
				SELF := RIGHT, 
				SELF := LEFT,
				SELF := []), 
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));

	InfutorCID__Key_Phone_Records := Suppress.MAC_SuppressSource(InfutorCID__Key_Phone_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsInfutor := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												InfutorCID__Key_Phone_Records(trim((string)did)+trim(phone)+trim((string)dt_first_seen) not in infutor_correct_record_id and  // old way, using concatenated keys
																											trim(persistent_record_id) not in	infutor_correct_record_id),  // new way - using persistent_record_id
												InfutorCID__Key_Phone_Records);	
				
	//if there are corrections lets go find them
	GetOverrideInfutor := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_InfutorCID__Key_Infutor_Phone = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideInfutor(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsInfutorPhone := WithSuppressionsInfutor+GetOverrideInfutor;				
				
	With_InfutorCID_Phone_Records := 
		DENORMALIZE(With_Targus_History_Phone_Records, WithCorrectionsInfutorPhone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_InfutorCID__Key_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		
		
	Key_PhonesPlus_v2__Keys_Source_Level_Phone := JOIN(Input_Phone_All, dx_PhonesPlus.Key_Source_Level_Phone(iType), 
				Common.DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_phone = TRUE AND
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone  = RIGHT.cellphone),
				TRANSFORM(Layouts_FDC.Layout_PhonesPlus_v2_Key_Source_Level_Temp,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	Key_PhonesPlus_v2__Keys_Source_Level_DID := JOIN(Input_Phone_All, dx_PhonesPlus.Key_Source_Level_DID(iType), 
				Common.DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_did = TRUE AND 
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID  = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_PhonesPlus_v2_Key_Source_Level_Temp,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	Key_PhonesPlus_v2__Keys_Source_Level_Payload_Full := dedup(sort(Key_PhonesPlus_v2__Keys_Source_Level_DID + Key_PhonesPlus_v2__Keys_Source_Level_Phone,UIDAppend, record_sid), UIDAppend, record_sid) ;

	Key_PhonesPlus_v2__Keys_Source_Level_Payload_Unsuppressed := JOIN(Key_PhonesPlus_v2__Keys_Source_Level_Payload_Full, dx_PhonesPlus.Key_Source_Level_Payload(iType), 
				Common.DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload = TRUE AND 
				LEFT.record_sid > 0 AND
				KEYED(LEFT.record_sid  = RIGHT.record_sid) AND
				ArchiveDate((string)right.datefirstseen, (string)right.datevendorfirstreported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_PhonesPlus_v2_Key_Source_Level_Payload,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := GLBARegulatedPhonesPlusRecord(RIGHT.glb_dppa_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.state, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.datefirstseen, (string)right.datevendorfirstreported);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob);
					SELF.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					self.datefirstseen :=  (integer)ArchiveDate((string)right.datefirstseen);
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));
	
	Key_PhonesPlus_v2__Keys_Source_Level_Payload := Suppress.MAC_SuppressSource(Key_PhonesPlus_v2__Keys_Source_Level_Payload_Unsuppressed, mod_access, did_field := did, data_env := Environment);
		
	With_Key_PhonesPlus_v2__Keys_Source_Level_Payload := 
		DENORMALIZE(With_InfutorCID_Phone_Records, Key_PhonesPlus_v2__Keys_Source_Level_Payload,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_PhonesPlus_v2__Key_Source_Level_Payload := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	Key_dx_PhonesInfo__Key_Phones_Type := JOIN(Input_Phone_All, dx_PhonesInfo.Key_Phones_Type, 
				Common.DoFDCJoin_PhoneInfo__Key_Phone_Type = TRUE AND
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone  = RIGHT.Phone) and
				ArchiveDate((string)right.vendor_first_reported_dt) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_dx_PhonesInfo_Key_Phones_Type,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := RIGHT.Source,
					SELF.Archive_Date := ArchiveDate((string)right.vendor_first_reported_dt);
					SELF.vendor_first_reported_dt := (INTEGER)ArchiveDate((string)right.vendor_first_reported_dt);
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source, FCRA_Restricted := Options.isFCRA, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	With_Key_dx_PhonesInfo__Key_Phones_Type := 
		DENORMALIZE(With_Key_PhonesPlus_v2__Keys_Source_Level_Payload, Key_dx_PhonesInfo__Key_Phones_Type,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_dx_PhonesInfo__Key_Phones_Type := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));
					
	Key_dx_PhonesInfo__Key_Phones_Transaction := JOIN(Input_Phone_All, dx_PhonesInfo.Key_Phones_Transaction, 
				Common.DoFDCJoin_PhoneInfo__Key_Phone_Transaction = TRUE AND
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone  = RIGHT.Phone) and
				ArchiveDate((string)right.vendor_first_reported_dt) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_dx_PhonesInfo_Key_Phones_Transaction,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := RIGHT.Source,
					SELF.Archive_Date := ArchiveDate((string)right.vendor_first_reported_dt);
					SELF.vendor_first_reported_dt := (INTEGER)ArchiveDate((string)right.vendor_first_reported_dt);
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source, FCRA_Restricted := Options.isFCRA, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	With_Key_dx_PhonesInfo__Key_Phones_Transaction := 
		DENORMALIZE(With_Key_dx_PhonesInfo__Key_Phones_Type, Key_dx_PhonesInfo__Key_Phones_Transaction,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_dx_PhonesInfo__Key_Phones_Transaction := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

/* I Verification Records - By Phone*/			

	Key_Iverification__Keys_Iverification_phone_Unsuppressed := 
			JOIN(Input_Phone_All, Phonesplus_v2.Keys_Iverification().phone.qa, 
				Common.DoFDCJoin_PhonePlus_V2__Iverification_Phone = TRUE AND
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone = RIGHT.phone) and
				ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Key_Iverification__Keys_Iverification_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Phone_Iver := right.phone,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)right.dt_first_seen);
					self.dt_first_seen := (integer)archivedate( (string)right.dt_first_seen);
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));

	Key_Iverification__Keys_Iverification_phone := Suppress.MAC_SuppressSource(Key_Iverification__Keys_Iverification_phone_Unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Key_Iverfication_phone_Records := 
		DENORMALIZE(With_Key_dx_PhonesInfo__Key_Phones_Transaction, Key_Iverification__Keys_Iverification_Phone, 
					LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,	
					TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Key_Iverification__Keys_Iverification_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

/* I Verification Records - By Lexid and Phone*/			

	Key_Iverification__Keys_Iverification_Did_Phone_Unsuppressed := 
			JOIN(Input_Phone_All, Phonesplus_v2.Keys_Iverification().did_phone.qa, 
				Common.DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone = TRUE AND
				LEFT.P_LexID > 0 AND (INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did AND 
							LEFT.Phone = RIGHT.phone) and
							ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8],
					TRANSFORM(Layouts_FDC.Layout_Key_Iverification__Keys_Iverification_Did_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Phone_Iver := right.phone,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)right.dt_first_seen);
					self.dt_first_seen :=(integer) archivedate((string)right.dt_first_seen);
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));

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
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone = RIGHT.cellphone),
					TRANSFORM(Layouts_FDC.Layout_Key_CellPhone__Key_Neustar_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(1));

	With_Key_CellPhone__Key_Neustar_Phone_Records := 
		DENORMALIZE(With_Key_Iverfication_Did_Phone_Records, Key_CellPhone__Key_Neustar_Phone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Key_CellPhone__Key_Neustar_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	/*----------------------------------EDUCATION------------------------------------*/
										
	American_student_list__key_DID := IF( Options.isFCRA,  American_student_list.key_DID_FCRA, American_student_list.key_DID );
	Key_American_student_list__key_DID_Records_unsupressed :=
			JOIN(Input_FDC_RelativesLexids_HHIDLexids_Business_Contact_LexIDs, American_student_list__key_DID,
			Common.DoFDCJoin_American_student_list__key_DID = True AND
			LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.L_did) and
				ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_American_student_list__key_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);
					self.date_first_seen :=  archivedate((string)right.date_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_100));

	American_student_list__key_DID_Records := Suppress.MAC_SuppressSource(Key_American_student_list__key_DID_Records_unsupressed, mod_access, did_field := L_did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsAmericanStudent := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												American_student_list__key_DID_Records((string)key not in student_correct_record_id), 
												American_student_list__key_DID_Records);

	//if there are corrections lets go find them
	GetOverrideAmericanStudent := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_American_student_list__key_DID = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideAmericanStudent(Input_FDC));//consumer only since FCRA only -- no business in FCRA

					
	WithCorrectionsAmericanStudent := WithSuppressionsAmericanStudent+GetOverrideAmericanStudent;	
	

	With_American_student_list__key_DID := DENORMALIZE(With_Key_CellPhone__Key_Neustar_Phone_Records, WithCorrectionsAmericanStudent,
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_American_student_list__key_DID := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
	
	AlloyMedia_student_list__key_DID := IF( Options.isFCRA,  AlloyMedia_student_list.key_DID_FCRA, AlloyMedia_student_list.key_DID );
	Key_AlloyMedia_student_list__key_DID_Records_unsupressed :=
			JOIN(Input_FDC_RelativesLexids_HHIDLexids_Business_Contact_LexIDs, AlloyMedia_student_list__key_DID,
			Common.DoFDCJoin_AlloyMedia_student_list__key_DID =True AND
			LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.did) and
				ArchiveDate((string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_AlloyMedia_student_list__key_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_vendor_first_reported);
					self.date_vendor_first_reported :=  archivedate((string)right.date_vendor_first_reported);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_100));

	AlloyMedia_student_list__key_DID_Records := Suppress.MAC_SuppressSource(Key_AlloyMedia_student_list__key_DID_Records_unsupressed, mod_access, did_field := did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsAlloyStudent := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												AlloyMedia_student_list__key_DID_Records((trim(sequence_number) + trim(key_code) + (string)rawaid) not in student_correct_record_id), 
												AlloyMedia_student_list__key_DID_Records);

	//if there are corrections lets go find them
	GetOverrideAlloyStudent := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_AlloyMedia_student_list__key_DID = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideAlloyStudent(Input_FDC));//consumer only since FCRA only -- no business in FCRA

					
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
//datasets like these we wont be able to filter for permissions in the joins (same way the boca shell does).
//we will limit the number of records in the denorm stange instead	
	
Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Denorm := 
			JOIN(Input_FDC, Risk_Indicators.Correlation_Risk.key_addr_dob_summary,
				Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_dob_summary = TRUE AND
				LEFT.P_InpClnAddrPrimName != '' AND LEFT.P_InpClnAddrZip5 != '' AND (INTEGER)LEFT.P_InpClnDOB > 0 AND
				KEYED(LEFT.P_InpClnAddrPrimName = RIGHT.prim_name) AND
				KEYED(LEFT.P_InpClnAddrPrimRng = RIGHT.prim_range) AND
				KEYED(LEFT.P_InpClnAddrZip5 = RIGHT.zip) AND
				KEYED((INTEGER)LEFT.P_InpClnDOB = RIGHT.dob),
				TRANSFORM(Layouts_FDC.Layout_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Denorm,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					DOBCleaned := CleanDateOfBirth(RIGHT.dob);
					SELF.dob := DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));

				
	//Risk_Indicators.Correlation_Risk.key_addr_dob_summary contains a child dataset so we need to add an extra step and NORMALIZE it before adding to the FDC bundle.
	Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Norm := NORMALIZE(Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Denorm , LEFT.summary, 
			TRANSFORM(Layouts_FDC.Layout_Risk_Indicators__Correlation_Risk__key_addr_dob_summary,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),	
					self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen);
					self.dt_first_seen :=  (integer)archivedate((string)right.dt_first_seen);
					SELF := LEFT,
					SELF := RIGHT));
					
	With_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Norm := DENORMALIZE(With_AlloyMedia_student_list__key_DID, Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Norm, 
				ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and //we already have archive_date set from the previous norm, lets not call it again since its not really needed
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));


	Risk_Indicators__Correlation_Risk__key_addr_name_summary_Denorm := 
			JOIN(Input_FDC, Risk_Indicators.Correlation_Risk.key_addr_name_summary,
				Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_name_summary = TRUE AND
				LEFT.P_InpClnAddrPrimName != '' AND LEFT.P_InpClnAddrZip5 != '' AND LEFT.P_InpClnNameLast != '' AND LEFT.P_InpClnNameFirst <> '' AND
				KEYED(LEFT.P_InpClnAddrPrimName = RIGHT.prim_name) AND
				KEYED(LEFT.P_InpClnAddrPrimRng = RIGHT.prim_range) AND
				KEYED(LEFT.P_InpClnAddrZip5 = RIGHT.zip) AND
				KEYED(LEFT.P_InpClnNameLast = RIGHT.lname) AND
				KEYED(LEFT.P_InpClnNameFirst = RIGHT.fname),
				TRANSFORM(Layouts_FDC.Layout_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Denorm,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));

				

	Risk_Indicators__Correlation_Risk__key_addr_name_summary_Norm := NORMALIZE(Risk_Indicators__Correlation_Risk__key_addr_name_summary_Denorm , LEFT.summary, 
			TRANSFORM(Layouts_FDC.Layout_Risk_Indicators__Correlation_Risk__key_addr_name_summary,
								SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
								self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen);
								self.dt_first_seen :=  (integer)archivedate((string)right.dt_first_seen);
								SELF := LEFT,
								SELF := RIGHT));
					
	With_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Norm := DENORMALIZE(With_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Norm, Risk_Indicators__Correlation_Risk__key_addr_name_summary_Norm, 
				ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and 
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

// SSN Summary
   Risk_Indicators__Key_SSN_Addr_Summary := 
   		JOIN(Input_FDC, Risk_Indicators.Correlation_Risk.key_ssn_addr_summary,
            Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_addr_summary = TRUE AND
            LEFT.P_InpClnSSN <> '' AND LEFT.P_InpClnAddrPrimName != '' AND LEFT.P_InpClnAddrZip5 != '' AND
            KEYED(LEFT.P_InpClnSSN = RIGHT.SSN) AND
						KEYED(LEFT.P_InpClnAddrPrimName = RIGHT.prim_name) AND
            KEYED(LEFT.P_InpClnAddrPrimRng = RIGHT.prim_range) AND
            KEYED(LEFT.P_InpClnAddrZip5 = RIGHT.zip),
            TRANSFORM(Layouts_FDC.Layout_ssn_addr_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []), 
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));
	
     Risk_Indicators__Key_SSN_Addr_Summary_Norm_Records := 
        NORMALIZE(Risk_Indicators__Key_SSN_Addr_Summary , left.summary, 
          TRANSFORM(Layouts_FDC.Layout_ssn_addr_summary_records, 
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen);
                self.dt_first_seen :=  (integer)archivedate((string)right.dt_first_seen);
								SELF := RIGHT, 
                SELF := LEFT, 
                SELF := []));
	
   	With_SSN_Addr_Summary_Records := DENORMALIZE(With_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Norm, Risk_Indicators__Key_SSN_Addr_Summary_Norm_Records,
       ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and  
			 LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_Risk_Indicators__Key_SSN_Addr_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));
	
	Risk_Indicators__Key_SSN_dob_Summary := 
   		JOIN(Input_FDC, Risk_Indicators.Correlation_Risk.key_ssn_dob_summary,
            Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_dob_summary = TRUE AND
            LEFT.P_InpClnSSN <> '' AND (INTEGER)LEFT.P_InpClnDOB > 0 AND
            KEYED(LEFT.P_InpClnSSN = RIGHT.SSN) AND
            KEYED(LEFT.P_InpClnDOB = (STRING)RIGHT.dob),
            TRANSFORM(Layouts_FDC.Layout_ssn_dob_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
				DOBCleaned := CleanDateOfBirth(RIGHT.dob);
				SELF.dob := DOBCleaned.dob;
				SELF.DOBPadded := DOBCleaned.DOBPadded;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []), 
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));
	
     Risk_Indicators__Key_SSN_dob_Summary_Norm_Records := 
        NORMALIZE(Risk_Indicators__Key_SSN_dob_Summary , left.summary, 
          TRANSFORM(Layouts_FDC.Layout_ssn_dob_summary_records, 
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen);
                self.dt_first_seen :=  (integer)archivedate( (string)right.dt_first_seen);
				SELF := RIGHT, 
                SELF := LEFT, 
                SELF := []));
	
   	With_SSN_DOB_Summary_Records := DENORMALIZE(With_SSN_Addr_Summary_Records, Risk_Indicators__Key_SSN_dob_Summary_Norm_Records,
				ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and  
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_Risk_Indicators__Key_SSN_dob_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));
								
	 Risk_Indicators__Key_SSN_Name_Summary := 
   		JOIN(Input_FDC, Risk_Indicators.Correlation_Risk.key_ssn_name_summary,
            Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_name_summary = TRUE AND
            LEFT.P_InpClnSSN <> '' AND LEFT.P_InpClnNameFirst <> '' AND LEFT.P_InpClnNameLast <> '' AND
            KEYED(LEFT.P_InpClnSSN = RIGHT.SSN) AND
            KEYED(LEFT.P_InpClnNameFirst = RIGHT.fname) AND
            KEYED(LEFT.P_InpClnNameLast = RIGHT.lname),
            TRANSFORM(Layouts_FDC.Layout_ssn_name_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []), 
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));
	
     Risk_Indicators__Key_SSN_Name_Summary_Norm_Records := 
        NORMALIZE(Risk_Indicators__Key_SSN_Name_Summary , left.summary, 
          TRANSFORM(Layouts_FDC.Layout_ssn_name_summary_records, 
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                self.Archive_Date := ArchiveDate((string)right.dt_first_seen);
                self.dt_first_seen := (integer)archivedate( (string)right.dt_first_seen);
								SELF := RIGHT, 
                SELF := LEFT, 
                SELF := []));
	
   	With_SSN_Name_Summary_Records := DENORMALIZE(With_SSN_DOB_Summary_Records, Risk_Indicators__Key_SSN_Name_Summary_Norm_Records,
				ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and 
        LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_Risk_Indicators__Key_SSN_Name_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));
	 
	 Risk_Indicators__Key_SSN_phone_Summary := 
   		JOIN(Input_FDC, Risk_Indicators.Correlation_Risk.key_ssn_phone_summary,
            Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_phone_summary = TRUE AND
            LEFT.P_InpClnSSN <> '' AND LEFT.P_InpClnPhoneHome <> '' AND
            KEYED(LEFT.P_InpClnSSN = RIGHT.SSN) AND
            KEYED(LEFT.P_InpClnPhoneHome = RIGHT.Phone),
            TRANSFORM(Layouts_FDC.Layout_ssn_phone_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []), 
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));
	
     Risk_Indicators__Key_SSN_Phone_Summary_Norm_Records := 
        NORMALIZE(Risk_Indicators__Key_SSN_phone_Summary , left.summary, 
          TRANSFORM(Layouts_FDC.Layout_ssn_phone_summary_records, 
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                self.Archive_Date := ArchiveDate((string)right.dt_first_seen);																								
                self.dt_first_seen := (integer)archivedate( (string)right.dt_first_seen);																								
								SELF := RIGHT, 
                SELF := LEFT, 
                SELF := []));
	
   	With_SSN_Phone_Summary_Records := DENORMALIZE(With_SSN_Name_Summary_Records, Risk_Indicators__Key_SSN_Phone_Summary_Norm_Records,
			ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and  
        LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_Risk_Indicators__Key_SSN_Phone_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));

////////////////
    RiskTable__Key_Name_Dob_Summary := 
   		JOIN(input_fdc, Risk_Indicators.Correlation_Risk.key_name_dob_summary,
            Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_name_dob_summary = TRUE AND
            LEFT.P_InpClnNameLast <> '' AND left.P_InpClnNameFirst<>'' and (INTEGER)left.P_InpClnDOB>0 AND
            KEYED(LEFT.P_InpClnNameLast = RIGHT.lname) AND
            KEYED(LEFT.P_InpClnNameFirst = RIGHT.fname) AND
            KEYED(LEFT.P_InpClnDOB = (STRING)RIGHT.dob),
            TRANSFORM(Layouts_FDC.Layout_name_dob_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
				DOBCleaned := CleanDateOfBirth(RIGHT.dob);
				SELF.dob := DOBCleaned.dob;
				SELF.DOBPadded := DOBCleaned.DOBPadded;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []), 
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));
	
     RiskTable__Key_Name_Dob_Summary_Norm_Records := 
        NORMALIZE(RiskTable__Key_Name_Dob_Summary, left.summary, 
          TRANSFORM(Layouts_FDC.Layout_name_dob_summary_key_norm_records, 
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                self.Archive_Date := ArchiveDate((string)right.dt_first_seen);
                self.dt_first_seen := (integer)archivedate( (string)right.dt_first_seen);
								SELF := RIGHT, 
                SELF := LEFT, 
                SELF := []));
	
   	With_RiskTable_Key_Name_Dob_Summary_Records := DENORMALIZE(With_SSN_Phone_Summary_Records, RiskTable__Key_Name_Dob_Summary_Norm_Records,
			ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
        LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Name_Dob_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));
                            
        RiskTable__Key_Phone_Addr_Header := 
   		JOIN(Input_FDC, Risk_Indicators.Correlation_Risk.key_phone_addr_header_summary,
            Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary = TRUE AND
            LEFT.P_InpClnPhoneHome <> '' AND LEFT.P_InpClnAddrPrimName <> '' AND LEFT.P_InpClnAddrZip5 <> '' AND
            KEYED(LEFT.P_InpClnPhoneHome = RIGHT.phone10) AND
            KEYED(LEFT.P_InpClnAddrPrimName = RIGHT.prim_name) AND
            KEYED(LEFT.P_InpClnAddrPrimRng = RIGHT.prim_range) AND
            KEYED(LEFT.P_InpClnAddrZip5 = RIGHT.zip),
            TRANSFORM(Layouts_FDC.Layout_phone_addr_header_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []), 
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));
	
     RiskTable__Key_Phone_Addr_Header_Summary_Norm_Records := 
        NORMALIZE(RiskTable__Key_Phone_Addr_Header, left.summary, 
          TRANSFORM(Layouts_FDC.Layout_phone_addr_header_summary_key_norm_records, 
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen);
                self.dt_first_seen := (integer) archivedate( (string)right.dt_first_seen);
								SELF := RIGHT, 
                SELF := LEFT, 
                SELF := []));
	
   	With_RiskTable__Key_Phone_Addr_Header_Summary_Norm_Records := DENORMALIZE(With_RiskTable_Key_Name_Dob_Summary_Records, RiskTable__Key_Phone_Addr_Header_Summary_Norm_Records,
        ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Phone_Addr_Header_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));
                
     RiskTable__Key_Phone_Addr := 
   		JOIN(Input_Phone_Address_Combined_Recs, Risk_Indicators.Correlation_Risk.key_phone_addr_summary,
            Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_summary = TRUE AND
            LEFT.P_InpClnPhoneHome <> '' AND LEFT.P_InpClnAddrPrimName <> '' AND LEFT.P_InpClnAddrZip5 <> '' AND
            KEYED(LEFT.P_InpClnPhoneHome = RIGHT.phone10) AND
            KEYED(LEFT.P_InpClnAddrPrimName = RIGHT.prim_name) AND
            KEYED(LEFT.P_InpClnAddrPrimRng = RIGHT.prim_range) AND
            KEYED(LEFT.P_InpClnAddrZip5 = RIGHT.zip),
            TRANSFORM(Layouts_FDC.Layout_phone_addr_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []), 
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));
	
     RiskTable__Key_Phone_Addr_Summary_Norm_Records := 
        NORMALIZE(RiskTable__Key_Phone_Addr , left.summary, 
          TRANSFORM(Layouts_FDC.Layout_phone_addr_summary_key_norm_records, 
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                self.Archive_Date :=ArchiveDate((string)right.dt_first_seen);
                self.dt_first_seen := (integer)archivedate( (string)right.dt_first_seen);
								SELF := RIGHT, 
                SELF := LEFT, 
                SELF := []));
	
   	With_RiskTable__Key_Phone_Addr_Summary_Norm_Records := DENORMALIZE(With_RiskTable__Key_Phone_Addr_Header_Summary_Norm_Records, RiskTable__Key_Phone_Addr_Summary_Norm_Records,
        ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Phone_Addr_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));
    
     RiskTable__Key_Phone_Lname := 
   		JOIN(Input_FDC, Risk_Indicators.Correlation_Risk.key_phone_lname_summary,
            Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_summary = TRUE AND
            LEFT.P_InpClnPhoneHome <> '' AND LEFT.P_InpClnNameLast <> '' AND
            KEYED(LEFT.P_InpClnPhoneHome = RIGHT.phone10) AND
            KEYED(LEFT.P_InpClnNameLast = RIGHT.lname),
            TRANSFORM(Layouts_FDC.Layout_phone_lname_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []), 
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));
	
     RiskTable__Key_Phone_Lname_Summary_Norm_Records := 
        NORMALIZE(RiskTable__Key_Phone_Lname , left.summary, 
          TRANSFORM(Layouts_FDC.Layout_phone_lname_summary_key_norm_records, 
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                self.Archive_Date := ArchiveDate((string)right.dt_first_seen);
                self.dt_first_seen := (integer)archivedate( (string)right.dt_first_seen);
								SELF := RIGHT, 
                SELF := LEFT, 
                SELF := []));
	
   	With_RiskTable__Key_Phone_Lname_Summary_Norm_Records := DENORMALIZE(With_RiskTable__Key_Phone_Addr_Summary_Norm_Records, RiskTable__Key_Phone_Lname_Summary_Norm_Records,
       ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Phone_Lname_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));
                
         RiskTable__Key_Phone_Lname_Header := 
   		JOIN(Input_FDC, Risk_Indicators.Correlation_Risk.key_phone_lname_header_summary,
            Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary = TRUE AND
            LEFT.P_InpClnPhoneHome <> '' AND LEFT.P_InpClnNameLast <> '' AND
            KEYED(LEFT.P_InpClnPhoneHome = RIGHT.phone10) AND
            KEYED(LEFT.P_InpClnNameLast = RIGHT.lname),
            TRANSFORM(Layouts_FDC.Layout_phone_lname_header_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []), 
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));
	
     RiskTable__Key_Phone_Lname_Header_Summary_Norm_Records := 
        NORMALIZE(RiskTable__Key_Phone_Lname_Header , left.summary, 
          TRANSFORM(Layouts_FDC.Layout_phone_lname_header_summary_key_norm_records, 
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                self.Archive_Date := ArchiveDate((string)right.dt_first_seen);
                self.dt_first_seen := (integer)archivedate( (string)right.dt_first_seen);
								SELF := RIGHT, 
                SELF := LEFT, 
                SELF := []));
	
   	With_RiskTable__Key_Phone_Lname_Header_Summary_Norm_Records := DENORMALIZE(With_RiskTable__Key_Phone_Lname_Summary_Norm_Records, RiskTable__Key_Phone_Lname_Header_Summary_Norm_Records,
        ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Phone_Lname_Header_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));
    
     RiskTable__Key_Phone_Dob_Summary := 
   		JOIN(Input_FDC, Risk_Indicators.Correlation_Risk.key_phone_dob_summary,
            Common.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_dob_summary = TRUE AND
            LEFT.P_InpClnPhoneHome <> '' AND (INTEGER)LEFT.P_InpClnDOB > 0 AND
            KEYED(LEFT.P_InpClnPhoneHome = RIGHT.phone) AND
            KEYED(LEFT.P_InpClnDOB = (STRING)RIGHT.dob),
            TRANSFORM(Layouts_FDC.Layout_phone_dob_summary_key_records,
                SELF.UIDAppend := LEFT.UIDAppend,
                SELF.G_ProcUID := LEFT.G_ProcUID,
				DOBCleaned := CleanDateOfBirth(RIGHT.dob);
				SELF.dob := DOBCleaned.dob;
				SELF.DOBPadded := DOBCleaned.DOBPadded;
                SELF := RIGHT,
                SELF := LEFT,
                SELF := []), 
            ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000), keep(1));
	
     RiskTable__Key_Phone_Dob_Summary_Norm_Records := 
        NORMALIZE(RiskTable__Key_Phone_Dob_Summary , left.summary, 
          TRANSFORM(Layouts_FDC.Layout_phone_dob_summary_key_norm_records, 
                SELF.DPMBitmap := SetDPMBitmap(Source := RIGHT.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);
                self.Archive_Date := ArchiveDate((string)right.dt_first_seen);
                self.dt_first_seen := (integer)archivedate( (string)right.dt_first_seen);
								SELF := RIGHT, 
                SELF := LEFT, 
                SELF := []));
	
   	With_RiskTable__Key_Phone_Dob_Summary_Norm_Records := DENORMALIZE(With_RiskTable__Key_Phone_Lname_Header_Summary_Norm_Records, RiskTable__Key_Phone_Dob_Summary_Norm_Records,
        ArchiveDate((string)right.dt_first_seen)<= LEFT.P_InpClnArchDt[1..8] and
				LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
   			TRANSFORM(Layouts_FDC.Layout_FDC,
                SELF.Dataset_RiskTable__Key_Phone_Dob_Summary := ROWS(RIGHT),
                SELF := LEFT,
                SELF := []));	

	/* **************************************************************************
			
	                             BUSINESS SECTION

	************************************************************************** */


	// --------------------[ Tradeline records ]--------------------
	
	Tradeline_Key_LinkIds := IF(Common.DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds = TRUE,
															dx_Cortera_Tradeline.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
															PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
															0, /*ScoreThreshold --> 0 = Give me everything*/
															PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_10000,
															BIPV2.IDconstants.JoinTypes.LimitTransformJoin));
		
		
		
	With_Tradeline_Key_LinkIds := DENORMALIZE(With_RiskTable__Key_Phone_Dob_Summary_Norm_Records, Tradeline_Key_LinkIds,
			ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Cortera_Tradeline__Key_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Cortera_Tradeline__Key_LinkIds, 
									SELF.DPMBitmap := SetDPMBitmap( Source := left.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
									self.Archive_Date := ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);																								
									self.dt_first_seen := (integer)archivedate(  (string)left.dt_first_seen);																								
									SELF := LEFT, 
									SELF := []));	
					SELF := LEFT,
					SELF := []));

	// --------------------[ Address (business) ]--------------------

	Corp2_Kfetch_LinkIds_Corp := IF(Common.DoFDCJoin_Corp2__Key_LinkIDs_Corp = TRUE, 
																							Corp2.Key_LinkIDs.Corp.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Lookup_And_Input_LinkIDs),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	


	With_Corp2_Key_LinkIds_Corp := DENORMALIZE(With_Tradeline_Key_LinkIds, Corp2_Kfetch_LinkIds_Corp,
			ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
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
																				self.Archive_Date :=  ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);
																				self.dt_first_seen := (integer)archivedate(  (string)left.dt_first_seen);	
																				self := left, 
																				self := []));
					SELF := LEFT,
					SELF := []));


	UtilFile_Kfetch2_LinkIds := IF(Common.DoFDCJoin_UtilFile__Key_LinkIds = TRUE, 
																							UtilFile.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin));						

	With_UtilFile_Key_LinkIds := DENORMALIZE(With_Corp2_Key_LinkIds_Corp, UtilFile_Kfetch2_LinkIds,
		ArchiveDate((string)right.date_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UtilFile__Kfetch2_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_UtilFile__Kfetch2_LinkIds, 
																						self.src := MDR.sourceTools.src_Utilities, 
																						SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																						self.Archive_Date := ArchiveDate((string)left.date_first_seen);
																						self.date_first_seen := archivedate(  (string)left.date_first_seen);	
																						self := left, 
																						self := []));
					SELF := LEFT,
					SELF := []));
		//make sure to filter out '' addresses before you call this function. blank prim_name and zip can cause issues in function
		highriskaddrin := project(Input_Address_BusBest_Current_Previous_Emerging, transform(BIPV2_Build.key_high_risk_industries.AddrSearchLayout, 
																													self.prim_range := left.PrimaryRange,
																													self.predir := left.Predirectional,
																													self.prim_name := left.PrimaryName,
																													self.postdir := left.Postdirectional,
																													self.addr_suffix := left.AddrSuffix,
																													self.sec_range := left.SecondaryRange,
																													self.v_city_name := left.City,
																													self.st := left.State,
																													self.zip5 := left.ZIP5,
																													self.UniqueId := left.AddrHighRiskUID)); 

		highriskphonein := project(Input_Best_Phone_nonFCRA, transform(BIPV2_Build.key_high_risk_industries.PhoneSearchLayout, 
																													self.company_phone := left.Phone,
																													self.UniqueId := left.UIDAppend));

		high_risk_industries_addr_search := IF(Common.DoFDCJoin_HighRiskAddress = TRUE,BIPV2_Build.key_high_risk_industries.Address_Search_Roxie(highriskaddrin));
		high_risk_industries_Phone_search := IF(Common.DoFDCJoin_HighRiskPhone = TRUE,BIPV2_Build.key_high_risk_industries.Phone_Search(highriskphonein));

		high_risk_industries_addr := join(Input_Address_BusBest_Current_Previous_Emerging, high_risk_industries_addr_search,  
																			left.AddrHighRiskUID = right.UniqueId,
																		transform(Layouts_FDC.Layout_BIPV2_Build__key_high_risk_industries_addr, 
																									self.UIDAppend := left.UIDAppend;
																									self.SIC_Code := if(right.code_type = 'SIC', right.code, ''), 
																									self.NAICS_Code := if(right.code_type = 'NAICS', right.code, ''), 
																									SELF.Archive_Date := ArchiveDate((string)right.dt_first_seen);
																									SELF.dt_first_seen := (integer)ArchiveDate((string)right.dt_first_seen);
																									SELF.SRC := PublicRecords_KEL.ECL_Functions.Constants.HighRiskIndustries;
																									SELF.DPMBitmap := SetDPMBitmap( Source := SELF.SRC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																									self.prim_range := left.PrimaryRange,
																									self.predir := left.Predirectional,
																									self.prim_name := left.PrimaryName,
																									self.postdir := left.Postdirectional,
																									self.addr_suffix := left.AddrSuffix,
																									self.sec_range := left.SecondaryRange,
																									self.v_city_name := left.City,
																									self.st := left.State,
																									self.zip5 := left.ZIP5,																									
																									self := left,
																									self := right,
																									self := [])); 

		With_BIPV2_Build_HighRiskaddr := DENORMALIZE(With_UtilFile_Key_LinkIds, high_risk_industries_addr,
					ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
					LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
					TRANSFORM(Layouts_FDC.Layout_FDC,
							SELF.Dataset_BIPV2_Build__key_high_risk_industries_addr := ROWS(RIGHT),	
							self := left, 
							self := []));
		
		With_BIPV2_Build_HighRiskphone := DENORMALIZE(With_BIPV2_Build_HighRiskaddr, high_risk_industries_Phone_search,
					ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
					LEFT.UIDAppend = RIGHT.UniqueId, GROUP,
					TRANSFORM(Layouts_FDC.Layout_FDC,
							SELF.Dataset_BIPV2_Build__key_high_risk_industries_phone :=project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BIPV2_Build__key_high_risk_industries_phone,
																									self.UIDAppend := left.UniqueId;
																									self.SIC_Code := if(left.code_type = 'SIC', left.code, ''), 
																									self.NAICS_Code := if(left.code_type = 'NAICS', left.code, ''), 
																									SELF.Archive_Date := ArchiveDate((string)left.dt_first_seen);
																									SELF.dt_first_seen := (integer)ArchiveDate((string)left.dt_first_seen);
																									SELF.SRC := PublicRecords_KEL.ECL_Functions.Constants.HighRiskIndustries;
																									SELF.DPMBitmap := SetDPMBitmap( Source := SELF.SRC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																									self := left,
																									self := []));
							
							self := left, 
							self := []));

						

		Key_Aircraft_linkids_Records :=	IF(Common.DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids = TRUE,
																			FAA.key_aircraft_linkids.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																			PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																			0, /*ScoreThreshold --> 0 = Give me everything*/
																			PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																			BIPV2.IDconstants.JoinTypes.LimitTransformJoin));

		With_Aircraft_linkids_Records := DENORMALIZE(With_BIPV2_Build_HighRiskphone, Key_Aircraft_linkids_Records,
				ArchiveDate((string)right.date_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
				LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
				LEFT.B_LexIDUlt = RIGHT.ULTID AND 
				LEFT.B_LexIDOrg = RIGHT.ORGID AND 
				LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_FAA__key_aircraft_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_FAA__key_aircraft_linkids, 
									SELF.Src := MDR.sourceTools.src_Aircrafts,
									SELF.DPMBitmap := SetDPMBitmap( Source := Self.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
									self.Archive_Date := ArchiveDate((string)left.date_first_seen);
									self.date_first_seen := archivedate(  (string)left.date_first_seen);
									SELF := LEFT, 
									SELF := []));	
						SELF := LEFT,
						SELF := []));	
					
		Key_Watercraft_LinkId_Records_unsuppressed := IF(Common.DoFDCJoin_Watercraft_Files__Watercraft_LinkId = TRUE,
																										Watercraft.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																										PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																										0, /*ScoreThreshold --> 0 = Give me everything*/
																										linkingOptions,
																										PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																										BIPV2.IDconstants.JoinTypes.LimitTransformJoin));

	Key_Watercraft_LinkId_Records := Suppress.MAC_SuppressSource(Key_Watercraft_LinkId_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Watercraft_LinkId_Records := DENORMALIZE(With_Aircraft_linkids_Records, Key_Watercraft_LinkId_Records,
			ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Watercraft__Watercraft__Key_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Watercraft__Key_LinkIds, 
									SELF.src := MDR.sourceTools.fWatercraft(left.Source_Code, left.State_Origin),
									SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := DPPARegulatedWaterCraftRecord(left.dppa_flag), DPPA_State := left.state_origin, KELPermissions := CFG_File),
									self.Archive_Date :=  ArchiveDate((string)left.date_first_seen, (string)left.date_vendor_first_reported);
									self.date_first_seen := archivedate(  (string)left.date_first_seen);
									SELF := LEFT, 
									SELF := []));	
					SELF := LEFT,
					SELF := []));	


	Key_Vehicle_linkids_Records_unsuppressed := IF(Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID = TRUE, 
																								VehicleV2.Key_Vehicle_linkids.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								mod_access,
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								linkingOptions,
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));

	Temp_vehicle_linkid_records := Suppress.MAC_SuppressSource(Key_Vehicle_linkids_Records_unsuppressed, mod_access, did_field := append_did, data_env := Environment);

	// PublicRecords_KEL.ECL_Functions.Common_Functions.AppendSeq(Key_Vehicle_linkids_Records, Input_FDC,Temp_vehicle_linkid_records,PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID);

	With_Vehicle_linkids_Records := DENORMALIZE(With_Watercraft_LinkId_Records, Temp_vehicle_linkid_records,
			ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.uniqueId AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_VehicleV2__Key_Vehicle_LinkID_Key := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_LinkID_Key, 
									SELF.Src := left.source_code,
									SELF.DPMBitmap := SetDPMBitmap( Source := left.source_code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := left.orig_state, KELPermissions := CFG_File),	
									self.Archive_Date := ArchiveDate((string)left.date_first_seen, (string)left.date_vendor_first_reported);
									self.date_first_seen := (integer)archivedate(  (string)left.date_first_seen);
									SELF := LEFT, 
									SELF := []));	
					SELF := LEFT,
					SELF := []));	
	/* **************************************************************************
			
																Business and Consumer 

	************************************************************************** */
	// --------------------[ Vehicle records ]--------------------

	Key_Vehicle_did_Records :=	//	Key not in uses, no dates used does not need dateselector
			JOIN(Input_FDC_RelativesLexids_HHIDLexids_LexIDs, VehicleV2.Key_Vehicle_DID,
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.VEHICLE_JOIN_LIMIT),KEEP(300));//ave of hits after keep 100 was 300 recs per did  

	Temp_Vehicle_linkids := join(input_FDC, Temp_vehicle_linkid_records,
				LEFT.UIDAppend = RIGHT.uniqueId,
					transform(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_DID,
						self.UIDAppend := right.uniqueId,
						self.g_procuid := right.uniqueId,
						self.p_inpclnarchdt := left.p_inpclnarchdt,
						SELF.B_LexIDUlt := left.B_LexIDUlt,
						SELF.B_LexIDOrg := left.B_LexIDOrg,
						SELF.B_LexIDLegal := left.B_LexIDLegal,
						self := right,
						self := []));
						
	Vehicle_all := dedup(sort(Temp_Vehicle_linkids+Key_Vehicle_did_Records, vehicle_key, iteration_key,sequence_key ,P_LexID, B_LexIDUlt,B_LexIDOrg,B_LexIDLegal,UIDappend),vehicle_key, iteration_key,sequence_key,P_LexID, B_LexIDUlt,B_LexIDOrg,B_LexIDLegal,UIDappend);			
	
	Key_Vehicle_Party_Records_unsuppressed :=  
		JOIN(Vehicle_all, VehicleV2.Key_Vehicle_Party_Key,
		Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Main_Party = TRUE AND
				KEYED(LEFT.vehicle_key = RIGHT.vehicle_key AND 
					LEFT.iteration_key = RIGHT.iteration_key AND
					LEFT.sequence_key = RIGHT.sequence_key) and
					((left.P_LexID = right.append_did) OR (left.B_LexIDUlt = right.ultid and left.B_LexIDOrg = right.orgid and left.B_LexIDLegal = right.seleid)) and
					ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Party_Key,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.source_code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := RIGHT.orig_state, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);			
					self.date_first_seen := (integer)archivedate(  (string)right.date_first_seen);
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
				
	Key_Vehicle_Party_Records := Suppress.MAC_SuppressSource(Key_Vehicle_Party_Records_unsuppressed, mod_access, did_field := append_did, data_env := Environment);

	Key_Vehicle_Main_Records_unsuppressed :=  
		JOIN(Key_Vehicle_Party_Records, VehicleV2.Key_Vehicle_Main_Key,
		Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Main_Party = TRUE AND
				KEYED(LEFT.vehicle_key = RIGHT.vehicle_key AND 
					LEFT.iteration_key = RIGHT.iteration_key),
				TRANSFORM({Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Main_Key, RECORDOF(LEFT)}, // including RECORDOF(LEFT) in this layout so that we can retain the DID for CCPA file suppressions
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.cleaned_brand_date_1 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_1)[1].ValidPortion_01;
					SELF.cleaned_brand_date_2 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_2)[1].ValidPortion_01;
					SELF.cleaned_brand_date_3 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_3)[1].ValidPortion_01;
					SELF.cleaned_brand_date_4 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_4)[1].ValidPortion_01;
					SELF.cleaned_brand_date_5 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_5)[1].ValidPortion_01;
					SELF.Src := RIGHT.source_code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := RIGHT.state_origin, KELPermissions := CFG_File),
					self.Archive_Date :=  '';//no dates
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	Key_Vehicle_Main_Records := PROJECT(Suppress.MAC_SuppressSource(Key_Vehicle_Main_Records_unsuppressed, mod_access, did_field := append_did, data_env := Environment),
		TRANSFORM(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Main_Key, SELF := LEFT)); // Suppressing records, then transforming back to original key layout since we no longer need the append_did field from the vehicle did key.
	
	With_Vehicle_Party_Records := DENORMALIZE(With_Vehicle_linkids_Records, Key_Vehicle_Party_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_VehicleV2__Key_Vehicle_Party_Key := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []), ALL);	
					
	With_Vehicle_Main_Records := DENORMALIZE(With_Vehicle_Party_Records, Key_Vehicle_Main_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_VehicleV2__Key_Vehicle_Main_Key := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []), ALL);	
						
	// UCC Key Linkids  
   
		UCC_LinkIds_Records := IF(Common.DoFDCJoin_UCC_Files__Key_Linkids = TRUE,
														UCCV2.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Lookup_And_Input_LinkIDs),
														PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
														0, /*ScoreThreshold --> 0 = Give me everything*/
														PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000,
														BIPV2.IDconstants.JoinTypes.LimitTransformJoin));
				
		With_UCC_Linkid_records := DENORMALIZE(With_Vehicle_Main_Records, UCC_LinkIds_Records,
			ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
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
									self.Archive_Date :=  ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);
									self.dt_first_seen := (integer)archivedate(  (string)left.dt_first_seen);
									SELF := LEFT, 
									SELF := []))(TMSID != '');
					SELF := LEFT,
					SELF := []));


  UCC_LinkIds_Records_Deduped := DEDUP(SORT(UCC_LinkIds_Records, UniqueID, TMSID), UniqueID, TMSID);
	
 // UCC Party RMSID
  
	UCC_Party_RMSID_Records := 
		Join(UCC_LinkIds_Records_Deduped, UCCV2.Key_Rmsid_Party(),
			Common.DoFDCJoin_UCC_Files__Key_Linkids = TRUE AND
				KEYED(LEFT.tmsid = RIGHT.tmsid),
				TRANSFORM(Layouts_FDC.Layout_UCC__Key_RMSID_Party,
					SELF.G_ProcBusUID := LEFT.UniqueID,
					SELF.B_LexIDUlt := LEFT.ULTID,
					SELF.B_LexIDOrg := LEFT.ORGID,
					SELF.B_LexIDLegal := LEFT.SELEID,
					self.Archive_Date := archivedate( (string)right.dt_first_seen, (string)right.dt_vendor_first_reported);
					self.dt_first_seen :=(integer) archivedate(  (string)right.dt_first_seen);
					SELF := RIGHT,
					SELF := []), 	
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
		
	With_UCC_RMSID_Party := DENORMALIZE(With_UCC_Linkid_records, UCC_Party_RMSID_Records,
			 ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and //we already have archive date defined lets not call this again
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
		Join(UCC_LinkIds_Records_Deduped, UCCV2.Key_rmsid_main(),
			Common.DoFDCJoin_UCC_Files__Key_Linkids = TRUE AND
				KEYED(LEFT.tmsid = RIGHT.tmsid),
				TRANSFORM(Layouts_FDC.Layout_UCC__Key_RMSID_Main,
					SELF.G_ProcBusUID := LEFT.UniqueID,
					SELF.B_LexIDUlt := LEFT.ULTID,
					SELF.B_LexIDOrg := LEFT.ORGID,
					SELF.B_LexIDLegal := LEFT.SELEID,
					SELF := RIGHT,
					SELF := []), 	
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
		
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
							self.archive_date := '';
							SELF := LEFT, 
							SELF := []))(TMSID != '');					
					SELF := LEFT,
					SELF := []));

	BBB2_kfetch_BBB_LinkIds := IF(Common.DoFDCJoin_BBB2__kfetch_BBB_LinkIds = TRUE, 
																							BBB2.Key_BBB_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_BBB2_Key_BBB_LinkIds := DENORMALIZE(With_UCC_RMSID_Main, BBB2_kfetch_BBB_LinkIds,
			ArchiveDate((string)right.date_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BBB2__kfetch_BBB_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BBB2__kfetch_BBB_LinkIds, 
																						self.src := MDR.sourceTools.src_BBB_Member, 
																						SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																						self.Archive_Date := ArchiveDate((string)left.date_first_seen, (string)left.dt_vendor_first_reported);
																						self.date_first_seen := (integer)archivedate(  (string)left.date_first_seen);
																						self := left, 
																						self := []));
					SELF := LEFT,
					SELF := []));

	BBB2_kfetch_BBB_Non_Member_LinkIds := IF(Common.DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds = TRUE, 
																							BBB2.Key_BBB_Non_Member_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_BBB2_Key_BBB_Non_Member_LinkIds := DENORMALIZE(With_BBB2_Key_BBB_LinkIds, BBB2_kfetch_BBB_Non_Member_LinkIds,
			ArchiveDate((string)right.date_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BBB2__kfetch_BBB_Non_Member_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BBB2__kfetch_BBB_Non_Member_LinkIds, 
																						self.src := MDR.sourceTools.src_BBB_Non_Member, 
																						SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																						self.Archive_Date :=  ArchiveDate((string)left.date_first_seen, (string)left.dt_vendor_first_reported);
																						self.date_first_seen := (integer)archivedate(  (string)left.date_first_seen);
																						self := left, 
																						self := []));
					SELF := LEFT,
					SELF := []));
	
	BusReg__kfetch_busreg_company_linkids := IF(Common.DoFDCJoin_BusReg__kfetch_busreg_company_linkids = TRUE, 
																						BusReg.key_busreg_company_linkids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_BusReg_key_busreg_company_linkids := DENORMALIZE(With_BBB2_Key_BBB_Non_Member_LinkIds, BusReg__kfetch_busreg_company_linkids,
			ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
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
																	self.Archive_Date := ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);
																	self.dt_first_seen :=(integer) archivedate(  (string)left.dt_first_seen);
																	self := left, 
																	self := []));
					SELF := LEFT,
					SELF := []));

	CalBus__kfetch_Calbus_LinkIDS := IF(Common.DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS = TRUE, 
																						CalBus.Key_Calbus_LinkIDS.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_CalBus_key_Calbus_LinkIDS := DENORMALIZE(With_BusReg_key_busreg_company_linkids, CalBus__kfetch_Calbus_LinkIDS,
			ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_CalBus__kfetch_Calbus_LinkIDS := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_CalBus__kfetch_Calbus_LinkIDS, 
																		self.src := MDR.sourceTools.src_CalBus, 
																		SELF.naics_code := CleanNAIC(LEFT.naics_code),
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																		self.Archive_Date :=  ArchiveDate((string)left.dt_first_seen);
																		self.dt_first_seen := archivedate(  (string)left.dt_first_seen);
																		self := left,
																		self := []));
					SELF := LEFT,
					SELF := []));
					


	Cortera__kfetch_LinkID_temp := IF(Common.DoFDCJoin_Cortera__kfetch_LinkID = TRUE, 
																						dx_Cortera.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

		
	
	With_Cortera_Key_LinkIDs := DENORMALIZE(With_CalBus_key_Calbus_LinkIDS, Cortera__kfetch_LinkID_temp,
			ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
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
																		self.Archive_Date := ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);
																		self.dt_first_seen := (integer)archivedate(  (string)left.dt_first_seen);
																		self := left, 
																		self := []));
					SELF := LEFT,
					SELF := []));				
					
	DCAV2__kfetch_LinkIds := IF(Common.DoFDCJoin_DCAV2__kfetch_LinkIds = TRUE, 
																						DCAV2.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								mod_access,
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_DCAV2_Key_LinkIds := DENORMALIZE(With_Cortera_Key_LinkIDs, DCAV2__kfetch_LinkIds,
			ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DCAV2__kfetch_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_DCAV2__kfetch_LinkIds, 
																		self.src := MDR.sourceTools.src_DCA, 
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																		self.Archive_Date :=  ArchiveDate((string)left.date_first_seen, (string)left.date_vendor_first_reported);
																		self.date_first_seen := (integer)archivedate(  (string)left.date_first_seen);
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
																						EBR.Key_5600_Demographic_Data_linkids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								mod_access,
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								linkingOptions,
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_EBR_Key_5600_Demographic_Data_linkids := DENORMALIZE(With_DCAV2_Key_LinkIds, EBR_kfetch_5600_Demographic_Data_linkids,
			ArchiveDate((string)right.date_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_EBR_kfetch_5600_Demographic_Data_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_EBR_kfetch_5600_Demographic_Data_linkids, 
																	self.src := MDR.sourceTools.src_EBR, 
																	SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																					
																	self.Archive_Date :=  ArchiveDate((string)left.date_first_seen);	
																	self.date_first_seen := archivedate(  (string)left.date_first_seen);
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
																						 	FBNv2.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								mod_access,
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_FBNv2__Key_LinkIds := DENORMALIZE(With_EBR_Key_5600_Demographic_Data_linkids, FBNv2__kfetch_LinkIds,
			ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_FBNv2__kfetch_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_FBNv2__kfetch_LinkIds, 
															  SELF.SIC_Code := CleanSIC(LEFT.SIC_Code),
																self.src := MDR.sourceTools.src_FBNV2_BusReg, 
																SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																self.Archive_Date :=  ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);	
																self.dt_first_seen := (integer)archivedate(  (string)left.dt_first_seen);
																self := left, 
																self := []));
					SELF := LEFT,
					SELF := []));			
					
	GovData__kfetch_IRS_NonProfit_linkIDs := IF(Common.DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs = TRUE, 
																						 	GovData.key_IRS_NonProfit_linkIDs.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_GovData_key_IRS_NonProfit_linkIDs := DENORMALIZE(With_FBNv2__Key_LinkIds, GovData__kfetch_IRS_NonProfit_linkIDs,
			ArchiveDate((string)right.process_date) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_GovData__kfetch_IRS_NonProfit_linkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_GovData__kfetch_IRS_NonProfit_linkIDs, 
																self.src := MDR.sourceTools.src_IRS_Non_Profit, 
																SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																self.Archive_Date :=  ArchiveDate((string)left.process_date);
																self.process_date :=  archivedate((string)left.process_date);
																SELF.Reported_Earnings := (INTEGER)TRIM((STD.Str.Filter(LEFT.Negative_Rev_Amount, '-') + (STRING)LEFT.Form_990_Revenue_Amount), ALL);
																self := left, 
																self := []));
					SELF := LEFT,
					SELF := []));								

	IRS5500__kfetch_LinkID := IF(Common.DoFDCJoin_IRS5500__kfetch_LinkIDs = TRUE, 
																						 IRS5500.Key_LinkIDs.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_IRS5500_Key_LinkIDs := DENORMALIZE(With_GovData_key_IRS_NonProfit_linkIDs, IRS5500__kfetch_LinkID,
			ArchiveDate((string)right.form_plan_year_begin_date) <= LEFT.P_InpClnArchDt[1..8] and 
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_IRS5500__kfetch_LinkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_IRS5500__kfetch_LinkIDs, 
																self.src := MDR.sourceTools.src_IRS_5500, 
																SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																self.Archive_Date := ArchiveDate((string)left.form_plan_year_begin_date);
																self.form_plan_year_begin_date := archivedate((string)left.form_plan_year_begin_date);
																self := left, 
																self := []));
					SELF := LEFT,
					SELF := []));								

	OSHAIR__kfetch_OSHAIR_LinkIds := IF(Common.DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds = TRUE, 
																						 dx_OSHAIR.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_OSHAIR_Key_OSHAIR_LinkIds := DENORMALIZE(With_IRS5500_Key_LinkIDs, OSHAIR__kfetch_OSHAIR_LinkIds,
			ArchiveDate((string)right.inspection_opening_date) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_OSHAIR__kfetch_OSHAIR_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_OSHAIR__kfetch_OSHAIR_LinkIds, 
																		self.src := MDR.sourceTools.src_OSHAIR, 
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																		self.Archive_Date :=  ArchiveDate((string)left.inspection_opening_date);
																		self.inspection_opening_date := (INTEGER) archivedate((string)left.inspection_opening_date);
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
																						 SAM.key_linkID.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_SAM_key_linkID := DENORMALIZE(With_OSHAIR_Key_OSHAIR_LinkIds, SAM__kfetch_linkID,
			ArchiveDate((string)right.ActiveDate) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_SAM__kfetch_linkID := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_SAM__kfetch_linkID, 
																	self.src := MDR.sourceTools.src_SAM_Gov_Debarred, 
																	SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																	self.Archive_Date := ArchiveDate((string)left.ActiveDate);
																	self.ActiveDate := archivedate( (string)left.ActiveDate);
																	self := left, 
																	self := []));
					SELF := LEFT,
					SELF := []));				
	
	YellowPages__kfetch_yellowpages_linkids := IF(Common.DoFDCJoin_YellowPages__kfetch_yellowpages_linkids = TRUE, 
																						YellowPages.key_yellowpages_linkids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_YellowPages_key_yellowpages_linkids := DENORMALIZE(With_SAM_key_linkID, YellowPages__kfetch_yellowpages_linkids,
			ArchiveDate((string)right.pub_date) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_YellowPages__kfetch_yellowpages_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_YellowPages__kfetch_yellowpages_linkids, 
																					self.src := MDR.sourceTools.src_Yellow_Pages, 
																					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																					self.Archive_Date :=  ArchiveDate((string)left.pub_date);
																					self.pub_date :=  archivedate((string)left.pub_date);
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
																						dx_Infutor_NARB.Key_Linkids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0,
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin)); /*ScoreThreshold --> 0 = Give me everything*/	
	
	Temp_infutor_narb := Suppress.MAC_SuppressSource(Infutor__NARB_kfetch_LinkIds_Unsuppressed, mod_access, did_field := did, data_env := Environment);	
		
	With_Infutor_NARB_Key_LinkIds := DENORMALIZE(With_YellowPages_key_yellowpages_linkids, Temp_infutor_narb,
			ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Layout_Infutor_NARB__kfetch_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Infutor_NARB__kfetch_LinkIds, 
																						self.src := LEFT.Source, //not set to mdr source tools on vault
																						SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																						self.Archive_Date :=  ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);
																						self.dt_first_seen :=  (integer)archivedate((string)left.dt_first_seen);
																						SELF.sic1 := CleanSIC(LEFT.sic1);
																						SELF.sic2 := CleanSIC(LEFT.sic2);
																						SELF.sic3 := CleanSIC(LEFT.sic3);
																						SELF.sic4 := CleanSIC(LEFT.sic4);
																						SELF.sic5 := CleanSIC(LEFT.sic5);
																						self := left, self := []));
					SELF := LEFT,
					SELF := []));		

	Equifax__Business_Data_kfetch_LinkIDs := IF(Common.DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs = TRUE, 
																						dx_Equifax_Business_Data.Key_LinkIDs.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin)); 	
																							
	With_Equifax_Business_Data_Key_LinkIDs := DENORMALIZE(With_Infutor_NARB_Key_LinkIds, Equifax__Business_Data_kfetch_LinkIDs,
			ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Equifax_Business__Data_kfetch_LinkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Equifax_Business__Data_kfetch_LinkIDs,
																						self.src := MDR.sourceTools.src_Equifax_Business_Data, 
																						SELF.DPMBitmap := SetDPMBitmap( Source := Self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																						self.Archive_Date :=  ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);
																						self.dt_first_seen :=  (integer)archivedate((string)left.dt_first_seen);
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
																		EBR.Key_0010_Header_linkids.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC), 
																							mod_access,
																							PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																							0, // ScoreThreshold --&gt; 0 = Give me everything
																							linkingOptions,
																							PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																							BIPV2.IDconstants.JoinTypes.LimitTransformJoin));


		With_EBR_Header_linkids := DENORMALIZE(With_Equifax_Business_Data_Key_LinkIDs, EBR__Key_0010_Header_linkids,
			ArchiveDate((string)right.date_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID  AND 
			LEFT.UIDAppend = RIGHT.UniqueID  AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_EBR__Key_0010_Header_linkids := PROJECT( ROWS(RIGHT), TRANSFORM(Layouts_FDC.Layout_EBR__Key_0010_Header_linkids, 
																								SELF.src := MDR.SourceTools.Src_EBR,
																								self.Archive_Date := ArchiveDate((string)left.date_first_seen);
																								self.date_first_seen := archivedate( (string)left.date_first_seen);
																								SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																								SELF := LEFT, 
																								SELF := [])),
				SELF := LEFT,
				SELF := []));
	
	GetFileNumbers := Dedup(sort(EBR__Key_0010_Header_linkids,file_number, uniqueid),file_number, uniqueid);
	
	ebr__Key_2015_Trade_Payment_Totals_FILE_NUMBER :=
		JOIN(GetFileNumbers, ebr.Key_2015_Trade_Payment_Totals_FILE_NUMBER,
		Common.DoFDCJoin_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER = TRUE AND 
			KEYED( LEFT.file_number = RIGHT.file_number ),
			TRANSFORM(Layouts_FDC.Layout_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER,
					SELF.UIDAppend := LEFT.UniqueID,
					SELF.G_ProcUID := LEFT.UniqueID,
					SELF.B_LexIDUlt := LEFT.ULTID,
					SELF.B_LexIDOrg := LEFT.ORGID,
					SELF.B_LexIDLegal := LEFT.SELEID,
					self.src := MDR.SourceTools.Src_EBR,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.date_first_seen);
					self.date_first_seen :=  archivedate((string)right.date_first_seen);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000));
	
	With_ebr_2015_Trade_Payment_Totals_FILE_NUMBER := DENORMALIZE(With_EBR_Header_linkids, ebr__Key_2015_Trade_Payment_Totals_FILE_NUMBER,	
		ArchiveDate((string)right.date_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
		LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
		TRANSFORM(Layouts_FDC.Layout_FDC,
				SELF.Dataset_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER := ROWS(RIGHT),
				SELF := LEFT,
				SELF := []));			

	dx_DataBridge__Key_LinkIds := 
			IF(Common.DoFDCJoin_dx_DataBridge__Key_LinkIds = TRUE, 
				dx_DataBridge.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
                                                        mod_access,
                                                        PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
                                                        0,
																												PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,//higher in prod?
																												BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_dx_DataBridge_LinkIds := DENORMALIZE(With_ebr_2015_Trade_Payment_Totals_FILE_NUMBER, dx_DataBridge__Key_LinkIds,
		ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
		LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
		LEFT.B_LexIDUlt = RIGHT.ULTID AND 
		LEFT.B_LexIDOrg = RIGHT.ORGID AND 
		LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
		TRANSFORM(Layouts_FDC.Layout_FDC,
				SELF.Dataset_dx_DataBridge__Key_LinkIds := PROJECT( ROWS(RIGHT), TRANSFORM(Layouts_FDC.Layout_dx_DataBridge__Key_LinkIds, 
																						SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																						self.Archive_Date := ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);
																						self.dt_first_seen := (integer)archivedate(  (string)left.dt_first_seen);
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
	
	Experian_CRDB__Key_LinkIDs := IF(Common.DoFDCJoin_Experian_CRDB__Key_LinkIDs = TRUE, 
																			Experian_CRDB.Key_LinkIDs.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC), 
																							mod_access,
																							PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																							0,
																							PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,//higher in prod?
																							BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_Experian_CRDB__LinkIDs := DENORMALIZE(With_dx_DataBridge_LinkIds, Experian_CRDB__Key_LinkIDs,
		ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
		LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
		LEFT.B_LexIDUlt = RIGHT.ULTID AND 
		LEFT.B_LexIDOrg = RIGHT.ORGID AND 
		LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
		TRANSFORM(Layouts_FDC.Layout_FDC,
				SELF.Dataset_Experian_CRDB__Key_LinkIDs := PROJECT( ROWS(RIGHT), TRANSFORM(Layouts_FDC.Layout_Experian_CRDB__Key_LinkIDs, 
																			SELF.src := MDR.SourceTools.src_Experian_CRDB,
																			SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),				
																			self.Archive_Date :=  ArchiveDate((string)left.dt_first_seen, (string)left.dt_vendor_first_reported);
																			self.dt_first_seen :=  (integer)archivedate((string)left.dt_first_seen);
																			SELF := LEFT, 
																			SELF := [])),
				SELF := LEFT,
				SELF := []));		
					
	Key_Gong_History_LinkID_Records := IF(Common.DoFDCJoin_Gong__Key_History_LinkIds = TRUE, 
																						dx_Gong.key_history_LinkIds.kfetch2(
																												PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																												mod_access, // CCPA suppression
																												PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																												0, /*ScoreThreshold --> 0 = Give me everything*/
																												PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
																												BIPV2.IDconstants.JoinTypes.LimitTransformJoin ));

	With_Gong_History_LinkID_Records := DENORMALIZE(With_Experian_CRDB__LinkIDs, Key_Gong_History_LinkID_Records,	
			ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID  AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Gong__Key_History_LinkIds := PROJECT( ROWS(RIGHT), TRANSFORM(Layouts_FDC.Layout_Gong__Key_History_LinkIds, 
																												SELF.src := MDR.sourceTools.src_Gong_History, //many sources in business header
																												SELF.DPMBitmap := SetDPMBitmap( Source := SELF.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																												self.Archive_Date := ArchiveDate((string)left.dt_first_seen);
																												self.dt_first_seen := archivedate( (string)left.dt_first_seen);
																												SELF.Listing_Type := TRIM(left.Listing_Type_Bus + left.Listing_Type_Res + left.Listing_Type_Gov, ALL);
																												SELF := LEFT, 
																												SELF := [])),
					SELF := LEFT,
					SELF := []));
	
//accident 
		FLAccidents_Ecrash__Key_EcrashV2_did :=	
			JOIN(Input_FDC, FLAccidents_Ecrash.Key_EcrashV2_did,
				Common.DoFDCJoinfn_FLAccidents_Ecrash__Key_EcrashV2_did = TRUE AND 
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.l_did),
				TRANSFORM(Layouts_FDC.Layout_FLAccidents_Ecrash__Key_EcrashV2_did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));
	
		FLAccidents_Ecrash__key_EcrashV2_accnbr :=	
			JOIN(FLAccidents_Ecrash__Key_EcrashV2_did, FLAccidents_Ecrash.key_EcrashV2_accnbr,
				Common.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash_accnbr = TRUE AND 
				KEYED(LEFT.accident_nbr = RIGHT.l_accnbr) and 
				LEFT.P_LexID=(UNSIGNED)RIGHT.did AND
				ArchiveDate((string)right.dt_first_seen) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_FLAccidents_Ecrash__key_EcrashV2_accnbr,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.src := MDR.sourceTools.src_Accidents_ECrash,
					SELF.driver_license_nbr := IF(STD.Str.FilterOut(RIGHT.driver_license_nbr, '1') = '', '', RIGHT.driver_license_nbr); // Filter any repeating 1's to be blank, bad data
					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen) ;
					self.dt_first_seen :=  archivedate((string)right.dt_first_seen) ;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));

		With_FLAccidents_Ecrash__key_EcrashV2_accnbr := DENORMALIZE(With_Gong_History_LinkID_Records, FLAccidents_Ecrash__key_EcrashV2_accnbr,	
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		

		FLAccidents_Ecrash__Key_ECrash4 :=	
			JOIN(FLAccidents_Ecrash__Key_EcrashV2_did, FLAccidents_Ecrash.Key_ECrash4,
				Common.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash = TRUE AND 
				KEYED(LEFT.accident_nbr = RIGHT.l_acc_nbr) and
				LEFT.P_LexID=(UNSIGNED)RIGHT.did,
				TRANSFORM(Layouts_FDC.Layout_FLAccidents_Ecrash__Key_ECrash4,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.src := MDR.sourceTools.src_Accidents_ECrash,
					SELF.driver_dl_nbr := IF(STD.Str.FilterOut(RIGHT.driver_dl_nbr, '1') = '', '', RIGHT.driver_dl_nbr); // Filter any repeating 1's to be blank, bad data
					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := '' ;//no dates in key
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));

		With_FLAccidents_Ecrash__Key_ECrash4 := DENORMALIZE(With_FLAccidents_Ecrash__key_EcrashV2_accnbr, FLAccidents_Ecrash__Key_ECrash4,	
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_FLAccidents_Ecrash__Key_ECrash4 := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		

				
	/*----------------------------------LienJudgement------------------------------------*/
	/*DID Keys have a parameter to say if FCRA or nonFCRA - same file layout*/
LienJudgement_DID_Key := IF(Options.IsFCRA, liensv2.key_liens_did_FCRA, liensv2.key_liens_DID);
		
	LienJudgement_DID_Records :=	
			JOIN(Input_FDC_RelativesLexids_HHIDLexids_Business_Contact_LexIDs, LienJudgement_DID_Key,
				Common.DoFDCJoin_LiensV2_key_liens = TRUE AND 
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_LienJudgement_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),KEEP(100));				
		
/* kFetch2 LiensV2.Key_LinkIds.Key.  Used to Populate the SeleLienJudgment ASSOCIATION*/
	LiensV2_Key_party_Linkids_Records := IF(Common.DoFDCJoin_LiensV2_Key_party_Linkids_Records = TRUE,
														LiensV2.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
														PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
														0, /*ScoreThreshold --> 0 = Give me everything*/
														PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000,
														BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

		Temp_LienJudgement_linkids := join(input_FDC, LiensV2_Key_party_Linkids_Records,
				LEFT.UIDAppend = RIGHT.uniqueId,
					transform(Layouts_FDC.Layout_LiensV2_Key_Liens_Party_ID_Records,
						self.UIDAppend := right.uniqueId,
						self.g_procuid := right.uniqueId,
						self.p_inpclnarchdt := left.p_inpclnarchdt,
						SELF.B_LexIDUlt := left.B_LexIDUlt,
						SELF.B_LexIDOrg := left.B_LexIDOrg,
						SELF.B_LexIDLegal := left.B_LexIDLegal,
						self := right,
						self := []));	

	With_LiensV2_Key_LinkIds_Records  := DENORMALIZE(With_FLAccidents_Ecrash__Key_ECrash4, LiensV2_Key_party_Linkids_Records,
			ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_LiensV2__Key_party_Linkids_Records := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Key_party_Linkids_Records, 
																											SELF.Src :=  PublicRecords_KEL.ECL_Functions.Constants.Set_Liens_Sources(LEFT.TMSID), //set marketing sources, else L2
																											SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
																											self.Archive_Date := ArchiveDate((string)left.date_first_seen, (string)left.date_vendor_first_reported);
																											self.date_first_seen := archivedate( (string)left.date_first_seen);
																											self := left, 
																											self := []));
					SELF := LEFT,
					SELF := []));

	/* Key_Liens_Party_ID Keys have a parameter to say if FCRA or nonFCRA - same file layout*/
	LiensV2_Key_Liens_Party_ID_Records_unsuppressed := IF( Options.isFCRA, LiensV2.Key_Liens_Party_ID_FCRA, LiensV2.Key_Liens_Party_ID	 );

	Key_LiensV2_Key_Liens_Party_ID_Records_unsuppressed_Regular :=
			JOIN(LienJudgement_DID_Records,LiensV2_Key_Liens_Party_ID_Records_unsuppressed,
			Common.DoFDCJoin_LiensV2_Key_main_ID_Records =True AND
             KEYED(LEFT.tmsid = RIGHT.tmsid) AND
							KEYED(LEFT.rmsid = RIGHT.rmsid) AND
							left.did=(unsigned)right.did and
							ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],//we only need to keep the records from party with a matching lexid, some are 0's. old shell does this too
								TRANSFORM(Layouts_FDC.Layout_LiensV2_Key_Liens_Party_ID_Records,
                    SELF.UIDAppend := LEFT.UIDAppend,
                    SELF.G_ProcUID := LEFT.G_ProcUID,
                    SELF.P_LexID := LEFT.P_LexID,
                    self.Archive_Date :=  ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);
                    self.date_first_seen :=  archivedate((string)right.date_first_seen);
										SELF.Src :=  PublicRecords_KEL.ECL_Functions.Constants.Set_Liens_Sources(right.TMSID),//set marketing sources, else L2
										SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
										SELF := RIGHT,
                    SELF := LEFT,
                    SELF := []),
                    ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
										
Key_LiensV2_Key_Liens_Party_ID_Records_unsuppressed_Inferred :=
			JOIN(LienJudgement_DID_Records,LiensV2_Key_Liens_Party_ID_Records_unsuppressed,
			Common.DoFDCJoin_LiensV2_Key_main_ID_Records =True AND
							KEYED(LEFT.tmsid = RIGHT.tmsid) AND
							KEYED(LEFT.rmsid = RIGHT.rmsid) AND
							left.did=(unsigned)right.did and
							ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) <= (STRING)STD.Date.AdjustDate((INTEGER)LEFT.P_InpClnArchDt[1..8],2,0,0) AND
							ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported) >= LEFT.P_InpClnArchDt[1..8],
									TRANSFORM(Layouts_FDC.Layout_LiensV2_Key_Liens_Party_ID_Records,
                    SELF.UIDAppend := LEFT.UIDAppend,
                    SELF.G_ProcUID := LEFT.G_ProcUID,
                    SELF.P_LexID := LEFT.P_LexID,
                    self.Archive_Date :=  ArchiveDate((string)right.date_first_seen, (string)right.date_vendor_first_reported);
                    self.date_first_seen :=  archivedate((string)right.date_first_seen);
										SELF.Src :=  PublicRecords_KEL.ECL_Functions.Constants.Set_Liens_Sources(right.TMSID),//set marketing sources, else L2
										SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
										SELF := RIGHT,
                    SELF := LEFT,
                    SELF := []),
                    ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	Key_LiensV2_Key_Liens_Party_ID_Records_unsuppressed	:= Key_LiensV2_Key_Liens_Party_ID_Records_unsuppressed_Regular + IF(Options.IncludeInferredPerformance and options.isFCRA,Key_LiensV2_Key_Liens_Party_ID_Records_unsuppressed_Inferred,DATASET([],Layouts_FDC.Layout_LiensV2_Key_Liens_Party_ID_Records));
	
	LiensV2_Key_Liens_Party_ID_Records:= Suppress.MAC_SuppressSource(Key_LiensV2_Key_Liens_Party_ID_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsLiensParty := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																LiensV2_Key_Liens_Party_ID_Records(trim((string)persistent_record_id) not in lien_correct_tmsid_rmsid AND 
																	(string50)tmsid + (string50)rmsid not in lien_correct_tmsid_rmsid), //this is the old way before 2012 and should never be used but putting it here just because,
																LiensV2_Key_Liens_Party_ID_Records);

	//if there are corrections lets go find them
	GetOverrideLiensParty := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_LiensV2_key_liens = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideLiensParty(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsLiensParty := WithSuppressionsLiensParty+GetOverrideLiensParty;

	With_Liens_Party_Records := DENORMALIZE(With_LiensV2_Key_LinkIds_Records, WithCorrectionsLiensParty,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
                  SELF.Dataset_LiensV2_Key_Liens_Party_ID_Records := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_LiensV2_Key_Liens_Party_ID_Records, 
																									debtor_name := Risk_Indicators.iid_constants.CreateFullName(LEFT.Title, LEFT.FName, LEFT.MName, LEFT.LName, LEFT.Name_Suffix);
																									plaintiff_name := IF(TRIM(LEFT.CName) != '', LEFT.CName, Risk_Indicators.iid_constants.CreateFullName(LEFT.Title, LEFT.FName, LEFT.MName, LEFT.LName, LEFT.Name_Suffix));
																									SELF.DebtorName := debtor_name;
																									SELF.PlaintiffName := plaintiff_name;
																									SELF.SubjectsName := IF(LEFT.name_type = 'D', debtor_name, plaintiff_name);
																									SELF.DID := (STRING)((UNSIGNED8)LEFT.DID); // Drop the leading 0's
																									self := left, 
																									self := []));
					SELF := LEFT,
					SELF := []), ALL);  
			
		
/*key_liens_main_id Keys have a parameter to say if FCRA or nonFCRA - same file layout*/
	LiensV2_key_liens_main_ID_Records := IF( Options.isFCRA, LiensV2.key_liens_main_ID_FCRA, LiensV2.key_liens_main_ID );


LienJudgement_all := dedup(sort(WithCorrectionsLiensParty+Temp_LienJudgement_linkids,tmsid,rmsid,uidappend),tmsid,rmsid,uidappend);

	LiensV2_key_liens_main_ID_Records_unsuppressed :=
			JOIN(LienJudgement_all,LiensV2_key_liens_main_ID_Records,
			Common.DoFDCJoin_LiensV2_Key_main_ID_Records =True AND
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
										self.Archive_Date :=  '';
										SELF.Src :=  PublicRecords_KEL.ECL_Functions.Constants.Set_Liens_Sources(right.TMSID),//set marketing sources, else L2
										SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
										SELF := RIGHT,
										SELF := LEFT,
										SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));//can lower this later

	Key_LiensV2_key_liens_main_ID_Records:= Suppress.MAC_SuppressSource(LiensV2_key_liens_main_ID_Records_unsuppressed, mod_access, did_field := P_LexID , data_env := Environment);	

	//only drop suppression/correction records in FCRA current mode
	
	WithSuppressionsLiensMain := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																Key_LiensV2_key_liens_main_ID_Records(trim((string)persistent_record_id) not in lien_correct_tmsid_rmsid AND 
																		(string50)tmsid + (string50)rmsid not in lien_correct_tmsid_rmsid), //this is the old way before 2012 and should never be used but putting it here just because
																Key_LiensV2_key_liens_main_ID_Records);

	//if there are corrections lets go find them
	GetOverrideLiensMain := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_LiensV2_key_liens = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideLiensMain(Input_FDC));//consumer only since FCRA only -- no business in FCRA

	WithCorrectionsLiensMain := WithSuppressionsLiensMain+GetOverrideLiensMain;
	With_liens_main_Records := DENORMALIZE(With_Liens_Party_Records , WithCorrectionsLiensMain,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
                    SELF.Dataset_LiensV2_key_liens_main_ID_Records := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_LiensV2_key_liens_main_ID_Records, 
                    filingStatus := LEFT.Filing_Status[1];
                    SELF.Filing_Status := filingStatus,
                    SELF.FilingStatusDescription := filingStatus.filing_status_desc,
										self := left, 
										self := []));
					SELF := LEFT,
					SELF := []), ALL);  
		
		
    Death_MasterV2_SSN_SSA_unsuppressed := 
			JOIN(IF(Options.IsFCRA, Input_Best_SSN_FCRA, Input_Best_SSN_nonFCRA), Death_Master.key_ssn_ssa(Options.IsFCRA), 
				Common.DoFDCJoin_DeathMaster__Key_SSN_SSA = TRUE AND
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN = RIGHT.ssn) and
				ArchiveDate((string)right.dod8) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Death_MasterV2__key_ssn_ssa,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.P_InpClnSSN := LEFT.P_InpClnSSN,
					SELF.Src := RIGHT.src,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := GLBARegulatedDeathMasterRecord(RIGHT.glb_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.dod8);
					self.dod8 :=  archivedate((string)right.dod8);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
				
	Key_Death_MasterV2_SSN_SSA := Suppress.MAC_SuppressSource(Death_MasterV2_SSN_SSA_unsuppressed, mod_access, did_field := did, gsid_field := global_sid, data_env := Environment);

	//only drop suppression/correction records in FCRA current mode
	WithSuppressionsDeathSSN := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
												Key_Death_MasterV2_SSN_SSA((trim((string)state_death_id)) not in Death_correct_record_id AND 
																			(trim((string)did) + trim((string)state_death_id)) not in Death_correct_record_id), 
												Key_Death_MasterV2_SSN_SSA);

	GetOverrideDeathSSN := Project(GetOverrideDeath,  
																			transform(Layouts_FDC.Layout_Death_MasterV2__key_ssn_ssa,
																			self := left,
																			self := []));
				
	WithCorrectionsDeathSSN := WithSuppressionsDeathSSN+GetOverrideDeathSSN;	

	With_Death_MasterV2_SSN_SSA := 
		DENORMALIZE(With_liens_main_Records, WithCorrectionsDeathSSN,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Death_MasterV2__key_ssn_ssa := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	//----------------------------------surname------------------------------------

 
dx_CFPB__key_Census_Surnames := IF( Options.isFCRA, dx_ConsumerFinancialProtectionBureau.key_census_surnames(TRUE), dx_ConsumerFinancialProtectionBureau.key_census_surnames(False));		
	Key_CFPB__key_Census_Surnames :=
			JOIN(cfpbsurname_input_contacts, dx_CFPB__key_Census_Surnames,
			Common.DoFDCJoin_dx_CFPB__key_Census_Surnames =TRUE AND
			LEFT.P_InpClnNameLast <> '' AND
				KEYED(LEFT.P_InpClnNameLast =RIGHT.name),
				TRANSFORM(Layouts_FDC.Layout_dx_CFPB_key_Census_Surnames,
					SELF.name := right.name,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.CFBPSurname,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src , FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					self.dt_vendor_first_reported := (integer)archivedate( (string)right.dt_vendor_first_reported);
					self.P_InpClnSurname1 := left.P_InpClnSurname1;
					self.P_InpClnSurname2 := left.P_InpClnSurname2;
					self.P_InpClnNameLast := left.P_InpClnNameLast;
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
	
	With_Key_CFPB__key_Census_Surnames := DENORMALIZE(With_Death_MasterV2_SSN_SSA, Key_CFPB__key_Census_Surnames,
				LEFT.UIDAppend=RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_dx_CFPB_key_Census_Surnames := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));					

																	
	Key_BLKGRP := IF( Options.isFCRA, dx_ConsumerFinancialProtectionBureau.Key_BLKGRP(TRUE), dx_ConsumerFinancialProtectionBureau.Key_BLKGRP(False));		
		
	dx_ConsumerFinancialProtectionBureau__Key_BLKGRP :=
			JOIN(GeoInputPrevCurrContactCFPB, Key_BLKGRP,
			Common.DoFDCJoin_dx_CFPB__key_BLKGRP =TRUE AND
			LEFT.AddressGeoLink <> '' AND
				KEYED(LEFT.AddressGeoLink =RIGHT.geoid10_blkgrp),
				TRANSFORM(Layouts_FDC.Layout_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.geoid10_blkgrp := LEFT.AddressGeoLink,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.CFBPGeolinks,
					SELF.DPMBitmap := SetDPMBitmap( Source := '', FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					self.dt_vendor_first_reported := (integer)archivedate( (string)right.dt_vendor_first_reported);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));		
	

	With_Key_BLKGRP := DENORMALIZE(With_Key_CFPB__key_Census_Surnames, dx_ConsumerFinancialProtectionBureau__Key_BLKGRP,
				LEFT.UIDAppend=RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		
						
	key_BLKGRP_attr_over18 := IF( Options.isFCRA, dx_ConsumerFinancialProtectionBureau.key_BLKGRP_attr_over18(TRUE), dx_ConsumerFinancialProtectionBureau.key_BLKGRP_attr_over18(False));		
		
	dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18 :=
			JOIN(GeoInputPrevCurrContactCFPB, key_BLKGRP_attr_over18,
			Common.DoFDCJoin_dx_CFPB__key_BLKGRP =TRUE AND
			LEFT.AddressGeoLink <> '' AND
				KEYED(LEFT.AddressGeoLink =RIGHT.geoind),
				TRANSFORM(Layouts_FDC.Layout_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.geoind := LEFT.AddressGeoLink,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.CFBPGeolinks,
					SELF.DPMBitmap := SetDPMBitmap( Source := '', FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :='', KELPermissions := CFG_File),
					self.dt_vendor_first_reported := (integer)archivedate( (string)right.dt_vendor_first_reported);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));		
	
	With_key_BLKGRP_attr_over18 := DENORMALIZE(With_Key_BLKGRP, dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18,
				LEFT.UIDAppend=RIGHT.UIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18 := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

//MAS is only using the nonFCRA version of these keys right now, however the FCRA version was left here if that changes in the future.
Key_HuntFish_Did := IF( Options.isFCRA, eMerges.Key_HuntFish_Did(TRUE), eMerges.Key_HuntFish_Did(FALSE) );		
	eMerges__Key_HuntFish_Did :=
			JOIN(Input_FDC_RelativesLexids_HHIDLexids_LexIDs, Key_HuntFish_Did,
			Common.DoFDCJoin_eMerges__Key_HuntFish_Rid =TRUE AND
			LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_eMerges__Key_HuntFish_Did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));		

//MAS is only using the nonFCRA version of these keys right now, however the FCRA version was left here if that changes in the future.	
Key_HuntFish_Rid := IF( Options.isFCRA, eMerges.Key_HuntFish_Rid(TRUE), eMerges.Key_HuntFish_Rid(FALSE) );//no ccpa as of 5/12/2020
	eMerges__Key_HuntFish_Rid := 
		JOIN(eMerges__Key_HuntFish_Did, Key_HuntFish_Rid,
					Common.DoFDCJoin_eMerges__Key_HuntFish_Rid = TRUE AND
					KEYED(LEFT.rid = RIGHT.rid) and
					ArchiveDate((string)right.datelicense) <= LEFT.P_InpClnArchDt[1..8],
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
					self.Archive_Date := ArchiveDate((string)right.datelicense);
					self.datelicense := archivedate( (string)right.datelicense);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
	

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
			Common.DoFDCJoin_eMerges__key_ccw_rid =TRUE and 
			LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did_out6),
				TRANSFORM(Layouts_FDC.Layout_eMerges__key_ccw_did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));		

//MAS is only using the nonFCRA version of these keys right now, however the FCRA version was left here if that changes in the future.
key_ccw_rid := IF( Options.isFCRA, eMerges.key_ccw_rid(TRUE), eMerges.key_ccw_rid(FALSE) );//no ccpa as of 5/12/2020
	eMerges__key_ccw_rid := 
		JOIN(eMerges__key_ccw_did, key_ccw_rid,
					Common.DoFDCJoin_eMerges__key_ccw_rid = TRUE AND
					KEYED(LEFT.rid = RIGHT.rid),
				TRANSFORM(Layouts_FDC.Layout_eMerges__key_ccw_rid,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.src := PublicRecords_KEL.ECL_Functions.Constants.CCW_Source_MAS;//needed for marketing exception list
					self.did := (INTEGER)right.did_out; //lots of leading 0's			
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  '';
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
	
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
			LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_SexOffender__Key_SexOffender_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []),
					ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_100));		
		
//MAS is only using the FCRA version of these keys right now, however the nonFCRA version was left here if that changes in the future.
Key_SexOffender_SPK := IF( Options.isFCRA, SexOffender.Key_SexOffender_SPK(TRUE), SexOffender.Key_SexOffender_SPK(FALSE) );//no ccpa as of 5/12/2020
	SexOffender__Key_SexOffender_SPK := 
		JOIN(SexOffender__Key_SexOffender_DID, Key_SexOffender_SPK,
					Common.DoFDCJoin_Key_SexOffender = TRUE AND
					KEYED(LEFT.seisint_primary_key = RIGHT.sspk) and
					ArchiveDate((string)right.dt_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_SexOffender__Key_SexOffender_SPK,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,	
					SELF.Src := MDR.sourceTools.src_sexoffender;
					SELF.DPMBitmap := SetDPMBitmap( Source := self.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.dt_first_reported) ;
					self.dt_first_reported :=  archivedate((string)right.dt_first_reported) ;
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),kEEP(10));		

		WithSuppressionsSexOffender := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																		SexOffender__Key_SexOffender_SPK((string)offender_persistent_id NOT IN SexOffender_correct_record_id), 
																		SexOffender__Key_SexOffender_SPK);
		
		GetOverrideSexOffender := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Key_SexOffender = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideSexOffenders(input_fdc));//consumer only since FCRA only -- no business in FCRA
	
		WithCorrectionsSexOffender := WithSuppressionsSexOffender+GetOverrideSexOffender;

	With_SexOffender__Key_SexOffender_SPK := DENORMALIZE(With_eMerges__key_ccw_rid, WithCorrectionsSexOffender,
			LEFT.UIDAppend = RIGHT.UIDAppend AND 
			LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_SexOffender__Key_SexOffender_SPK := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	
	key_thrive_did := IF( Options.isFCRA, thrive.keys().Did_fcra.qa, thrive.keys().did.qa );//no ccpa as of 5/12/2020

	thrive__keys__Did_qa_Regular := JOIN(input_FDC, key_thrive_did,
					Common.DoFDCJoin_Thrive__Key_did_QA = TRUE AND
					LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did) and
				ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Thrive__Key___Did_QA,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.src := right.src,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported);
					self.dt_first_seen :=  (integer)archivedate( (string)right.dt_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
	
	thrive__keys__Did_qa_Inferred := JOIN(input_FDC, key_thrive_did,
					Common.DoFDCJoin_Thrive__Key_did_QA = TRUE AND
					LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID =RIGHT.did) and
				ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) <= (STRING)STD.Date.AdjustDate((INTEGER)LEFT.P_InpClnArchDt[1..8],2,0,0) AND
				ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported) >= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_Thrive__Key___Did_QA,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					self.src := right.src,
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)right.dt_first_seen, (string)right.dt_vendor_first_reported);
					self.dt_first_seen :=  (integer)archivedate( (string)right.dt_first_seen);
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
				
		thrive__keys__Did_qa	:= thrive__keys__Did_qa_Regular + IF(Options.IncludeInferredPerformance and options.isFCRA,thrive__keys__Did_qa_Inferred,DATASET([],Layouts_FDC.Layout_Thrive__Key___Did_QA));	
		
		WithSuppressionsThrive := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA, 
																				thrive__keys__Did_qa(persistent_record_id NOT IN thrive_correct_record_id), 
																				thrive__keys__Did_qa);		
		
		GetOverrideThrive := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND Common.DoFDCJoin_Thrive__Key_did_QA = TRUE,
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideThrive(input_fdc));//consumer only since FCRA only -- no business in FCRA
	
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
					LEFT.P_LexID > 0 AND
					KEYED(LEFT.P_LexID = RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_fraudpoint3__Key_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.FraudPoint3Source;
					SELF.DPMBitmap := SetDPMBitmap( Source := SELF.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.dob);
					SELF.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));
	
	With_fraudpoint3__Key_DID := DENORMALIZE(With_thrive__keys__Did_qa, fraudpoint3__Key_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_fraudpoint3__Key_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));							

//InQuIrIeS FCRA
Key_AccLogs_FCRA_Address := 
		JOIN(Input_Address_Current, Inquiry_AccLogs.Key_FCRA_Address, //need to search inq by addr with current addr too
				Common.DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.ZIP5 > 0 AND
				KEYED(LEFT.ZIP5 = RIGHT.ZIP AND
				LEFT.PrimaryName = right.prim_name AND
				LEFT.PrimaryRange = right.prim_range and
				left.SecondaryRange = right.Sec_range) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
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
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string) SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	GetOverrideInquiry := IF((unsigned)input[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND 
																options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
																(Common.DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA = TRUE OR Common.DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA = TRUE OR
																Common.DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA = TRUE OR Common.DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA = TRUE),
															PublicRecords_KEL.MAS_get.FCRA_Overrides(options, JoinFlags).GetOverrideInquiry(Input_FDC));//consumer only since FCRA only -- no business in FCRA
															
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
			
		Key_AccLogs_FCRA_DID_Regular := 
			JOIN(Input_FDC, Inquiry_AccLogs.Key_FCRA_DID, 
				Common.DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.appended_adl) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] AND
							//lets dump the inquiries we don't care about
							((trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.FCRA_Functions)	AND 
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND 
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes) and
							trim(right.search_info.transaction_id, left, right) not in left.inquiries_correct_record_id),  // don't include any records from raw data that have been corrected,,
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs;
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

		Key_AccLogs_FCRA_DID_Inferred :=
			JOIN(Input_FDC, Inquiry_AccLogs.Key_FCRA_DID, 
				Common.DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.appended_adl) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= (STRING)STD.Date.AdjustDate((INTEGER)LEFT.P_InpClnArchDt[1..8],2,0,0) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) >= LEFT.P_InpClnArchDt[1..8] AND
							//lets dump the inquiries we don't care about
							((trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.FCRA_Functions)	AND 
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND 
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes) and
							trim(right.search_info.transaction_id, left, right) not in left.inquiries_correct_record_id),  // don't include any records from raw data that have been corrected,,
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs;
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)SELF.DateOfInquiry);
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

Key_AccLogs_FCRA_DID	:= Key_AccLogs_FCRA_DID_Regular + IF(Options.IncludeInferredPerformance and options.isFCRA,Key_AccLogs_FCRA_DID_Inferred,DATASET([],Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_DID));

	WithCorrectionsInquiryDid := Key_AccLogs_FCRA_DID+GetOverrideInquiry;	

	With_AccLogs_FCRA_DID_Records := DENORMALIZE(With_AccLogs_FCRA_Address_Records, WithCorrectionsInquiryDid,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Key_FCRA_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

Key_AccLogs_FCRA_SSN := 
		JOIN(Input_Best_SSN_FCRA, Inquiry_AccLogs.Key_FCRA_SSN, //input and best ssn searching
				Common.DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN = RIGHT.ssn) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
							//lets dump the inquiries we don't care about
							((trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.FCRA_Functions)	AND 
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND 
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes) and
							trim(right.search_info.transaction_id, left, right) not in left.inquiries_correct_record_id),  // don't include any records from raw data that have been corrected,,
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_SSN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_InpClnSSN := LEFT.P_InpClnSSN,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

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
		JOIN(Input_Phone_All, Inquiry_AccLogs.Key_FCRA_Phone, 
				Common.DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone = RIGHT.Phone10) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
							//lets dump the inquiries we don't care about
							((trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.FCRA_Functions)	AND 
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND 
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes)) and
							trim(right.search_info.transaction_id, left, right) not in left.inquiries_correct_record_id,  // don't include any records from raw data that have been corrected,,
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Phone := LEFT.Phone,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

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
	deltabase_address_unsuppressed :=  IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address = TRUE and options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue ,PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).Inquiry_Address(GetInquiryDeltaBase));
	deltaBase_did_unsuppressed :=  IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID = TRUE and options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue ,PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).Inquiry_Did(GetInquiryDeltaBase));
	deltaBase_email_unsuppressed :=  IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_EMAIL = TRUE and options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue ,PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).Inquiry_Email(GetInquiryDeltaBase));
	deltaBase_phone_unsuppressed :=  IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone = TRUE and options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue ,PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).Inquiry_Phone(GetInquiryDeltaBase));
	deltaBase_ssn_unsuppressed :=  IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN = TRUE and options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue ,PublicRecords_KEL.MAS_get.Deltabase_Inquiry(Options).Inquiry_SSN(GetInquiryDeltaBase));


//Inquiries nonFCRA Address
	Key_AccLogs_Inquiry_Table_Address_unsuppressed := 
			JOIN(Input_Address_Current, Inquiry_AccLogs.Key_Inquiry_Address, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.ZIP5 > 0 AND
				KEYED(LEFT.ZIP5 = RIGHT.ZIP AND
				LEFT.PrimaryName = right.prim_name AND
				LEFT.PrimaryRange = right.prim_range and
				left.SecondaryRange = right.Sec_range) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
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
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.IsUpdateRecord := FALSE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

		Key_AccLogs_Inquiry_Table_Update_Address_unsuppressed := 
			JOIN(Input_Address_Current, Inquiry_AccLogs.Key_Inquiry_Address_Update, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.ZIP5 > 0 AND
				KEYED(LEFT.ZIP5 = RIGHT.ZIP AND
				LEFT.PrimaryName = right.prim_name AND
				LEFT.PrimaryRange = right.prim_range and
				left.SecondaryRange = right.Sec_range) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
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
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.IsUpdateRecord := TRUE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

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
			JOIN(Input_HHIDLexids, Inquiry_AccLogs.Key_Inquiry_DID, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND 
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND 
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.IsUpdateRecord := FALSE, //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

		Key_AccLogs_Inquiry_Table_Update_DID_unsuppressed := 
			JOIN(Input_HHIDLexids, Inquiry_AccLogs.Key_Inquiry_DID_Update, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
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
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

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
			JOIN(Input_FDC, Inquiry_AccLogs.Key_Inquiry_Email, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Email = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				LEFT.P_InpClnEmail <> '' AND
				KEYED(LEFT.P_InpClnEmail = RIGHT.email_address) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND 
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND 
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Email,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_InpClnEmail := LEFT.P_InpClnEmail,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8]+RIGHT.Search_Info.DateTime[10..]+'0';
					SELF.IsUpdateRecord := FALSE, //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  archivedate(SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

		Key_AccLogs_Inquiry_Table_Update_Email_unsuppressed := 
			JOIN(Input_FDC, Inquiry_AccLogs.Key_Inquiry_Email_Update, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Email = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				LEFT.P_InpClnEmail <> '' AND
				KEYED(LEFT.P_InpClnEmail = RIGHT.email_address) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
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
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8]+RIGHT.Search_Info.DateTime[10..]+'0';
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

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
			JOIN(Input_FDC, Inquiry_AccLogs.Key_Inquiry_FEIN, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.B_InpClnTIN > 0 AND
				KEYED(LEFT.B_InpClnTIN = RIGHT.appended_ein) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND 
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND 
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_FEIN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.B_InpClnTIN := LEFT.B_InpClnTIN,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8]+RIGHT.Search_Info.DateTime[10..]+'0';
					SELF.IsUpdateRecord := FALSE, //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,//no fein deltabase
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.bususer_q.dob);
					SELF.bususer_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

		Key_AccLogs_Inquiry_Table_Update_FEIN_unsuppressed := 
			JOIN(Input_FDC, Inquiry_AccLogs.Key_Inquiry_FEIN_Update, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.B_InpClnTIN > 0 AND
				KEYED(LEFT.B_InpClnTIN = RIGHT.appended_ein) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
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
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8]+RIGHT.Search_Info.DateTime[10..]+'0';
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.bususer_q.dob);
					SELF.bususer_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	Gather_FEIN_Inquiries := Key_AccLogs_Inquiry_Table_FEIN_unsuppressed+Key_AccLogs_Inquiry_Table_Update_FEIN_unsuppressed;
	
	FEIN_Inquiries_Suppress := Suppress.MAC_SuppressSource(Gather_FEIN_Inquiries, mod_access, did_field := bususer_q.appended_adl, gsid_field := ccpa.global_sid, data_env := Environment);

	With_AccLogs_Inquiry_FEIN_Records := DENORMALIZE(With_AccLogs_Inquiry_Email_Records, FEIN_Inquiries_Suppress,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

//Inquiries nonFCRA Bipids

	Inquiry_AccLogs__Key_Inquiry_LinkIds_Table := IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs = TRUE and
																							options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue, 	
																							Inquiry_AccLogs.Key_Inquiry_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Lookup_And_Input_LinkIDs),
																							 mod_access,
																							PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries_Kfetch, //old bus shell we keep 5k of these but 1k of everything else, will try 5k to start but might need to be lowered
																							BIPV2.IDconstants.JoinTypes.LimitTransformJoin));

	
	
	Inquiry_AccLogs__Key_Inquiry_LinkIds_Update := IF(Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs = TRUE and
																						options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue,
																							Inquiry_AccLogs.Key_Inquiry_LinkIds_Update.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Lookup_And_Input_LinkIDs),
																							mod_access,
																							PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							PublicRecords_KEL.ECL_Functions.Constants.Limit_Inquiries_Kfetch,//old bus shell we keep 5k of these but 1k of everything else, will try 5k to start but might need to be lowered
																							BIPV2.IDconstants.JoinTypes.LimitTransformJoin));
	
	//since we cannot filter a kfetch like a keyed join we will drop unneeded inq records here too
	Inquiry_LinkIds_Table := Project(Inquiry_AccLogs__Key_Inquiry_LinkIds_Table(#EXPAND(PublicRecords_KEL.ECL_Functions.AccLogs_Constants.inquiry_is_ok_nonFCRA)),
																								transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_LinkIds, 
																									SELF.IsUpdateRecord := FALSE, 
																									SELF.IsDeltaBaseRecord := False,//no bip deltabase
																									DOBCleaned := CleanDateOfBirth((UNSIGNED)LEFT.bususer_q.dob);
																									SELF.bususer_q.dob := (STRING)DOBCleaned.dob;
																									SELF.DOBPadded := DOBCleaned.DOBPadded;
																									self := left, 
																									self := []));  //to help with debugging and data questions
	Inquiry_LinkIds_Update := Project(Inquiry_AccLogs__Key_Inquiry_LinkIds_Update(#EXPAND(PublicRecords_KEL.ECL_Functions.AccLogs_Constants.inquiry_is_ok_nonFCRA)),
																								transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_LinkIds, 
																								SELF.IsUpdateRecord := TRUE, 
																								SELF.IsDeltaBaseRecord := False,//no bip deltabase
																								DOBCleaned := CleanDateOfBirth((UNSIGNED)LEFT.bususer_q.dob);
																								SELF.bususer_q.dob := (STRING)DOBCleaned.dob;
																								SELF.DOBPadded := DOBCleaned.DOBPadded;
																								self := left, 
																								self := []));  //to help with debugging and data questions
	
	Gather_LinkIds_Inquiries := Inquiry_LinkIds_Table+Inquiry_LinkIds_Update;
	
	With_AccLogs_Inquiry_LinkIds_Records := DENORMALIZE(With_AccLogs_Inquiry_FEIN_Records, Gather_LinkIds_Inquiries,	
			ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_LinkIds, 
																										SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																										SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
																										SELF.DateOfInquiry := LEFT.Search_Info.DateTime[1..8]+LEFT.Search_Info.DateTime[10..]+'0';					
																										self.Archive_Date :=  ArchiveDate((string)SELF.DateOfInquiry);
																										self := left, 
																										self := []));
					SELF := LEFT,
					SELF := []));
	
//Inquiries nonFCRA Phone	
	Key_AccLogs_Inquiry_Table_Phone_unsuppressed := 
			JOIN(Input_Phone_All, Inquiry_AccLogs.Key_Inquiry_Phone, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone = RIGHT.Phone10) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND 
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND 
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Phone := LEFT.Phone,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.IsUpdateRecord := FALSE, //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

		Key_AccLogs_Inquiry_Table_Update_Phone_unsuppressed := 
			JOIN(Input_Phone_All, Inquiry_AccLogs.Key_Inquiry_Phone_Update, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.Phone > 0 AND
				KEYED(LEFT.Phone = RIGHT.Phone10) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
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
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

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
			JOIN(Input_Best_SSN_nonFCRA, Inquiry_AccLogs.Key_Inquiry_SSN, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN = RIGHT.ssn) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
							//lets dump the inquiries we don't care about
							(trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.nonFCRA_Functions)	AND 
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND 
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_SSN,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_InpClnSSN := LEFT.P_InpClnSSN,
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.IsUpdateRecord := FALSE, //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := False,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

		Key_AccLogs_Inquiry_Table_Update_SSN_unsuppressed := 
			JOIN(Input_Best_SSN_nonFCRA, Inquiry_AccLogs.Key_Inquiry_SSN_Update, 
				Common.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN = TRUE AND
				options.Data_Restriction_Mask[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue and
				(INTEGER)LEFT.P_InpClnSSN > 0 AND
				KEYED(LEFT.P_InpClnSSN = RIGHT.ssn) AND
				ArchiveDate((string)right.Search_Info.DateTime[1..8]) <= LEFT.P_InpClnArchDt[1..8] and
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
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8] + RIGHT.Search_Info.DateTime[10..] + '0';
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date :=  ArchiveDate((string)SELF.DateOfInquiry);
					DOBCleaned := CleanDateOfBirth((UNSIGNED)RIGHT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000));

	Gather_SSN_Inquiries := Key_AccLogs_Inquiry_Table_SSN_unsuppressed+Key_AccLogs_Inquiry_Table_Update_SSN_unsuppressed+deltaBase_ssn_unsuppressed;
	
	SSN_Inquiries_Suppress := Suppress.MAC_SuppressSource(Gather_SSN_Inquiries, mod_access, did_field := person_q.appended_adl, gsid_field := ccpa.global_sid, data_env := Environment);

	With_AccLogs_Inquiry_SSN_Records := DENORMALIZE(With_AccLogs_Inquiry_Phone_Records, SSN_Inquiries_Suppress,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Inquiry_Table_SSN := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
					

	Property__Key_Foreclosures_DID := 
			JOIN(Input_FDC, dx_property.Key_Foreclosure_DID, 
				Common.DoFDCJoin_Property__Key_Foreclosure_FID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM({RECORDOF(RIGHT),Layouts_FDC.LayoutIDs},
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.p_inpclnarchdt := LEFT.P_InpClnArchDt,
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),keep(50));
				
	Property__Key_Foreclosures_FID_With_Did := 
			JOIN(Property__Key_Foreclosures_DID,dx_property.Key_Foreclosures_FID,
				Common.DoFDCJoin_Property__Key_Foreclosure_FID = TRUE AND
				KEYED(left.fid = RIGHT.fid) AND
				ArchiveDate(RIGHT.recording_date) <= LEFT.P_InpClnArchDt[1..8],
				TRANSFORM(Layouts_FDC.Layout_DX_Property__Key_Foreclosures_FID_With_Did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.did := LEFT.did,
					SELF.src := RIGHT.source;
					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),				
					SELF.Archive_Date := ArchiveDate(RIGHT.recording_date);
					SELF.recording_date := ArchiveDate(RIGHT.recording_date);
					SELF.Zip5 := RIGHT.property_address_zip_code_1[1..5];
					SELF.Zip4 := RIGHT.property_address_zip_code_1[6..9];
					SELF := RIGHT;
					SELF := [];),
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000),keep(50));

		Property__Key_Foreclosures_FID_With_Did_Suppressed := Suppress.MAC_SuppressSource(Property__Key_Foreclosures_FID_With_Did, mod_access, did_field := did, data_env := Environment);		
		With_Property__Key_Foreclosures_FID_With_Did := DENORMALIZE(With_AccLogs_Inquiry_SSN_Records, Property__Key_Foreclosures_FID_With_Did_Suppressed,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DX_Property__Key_Foreclosures_FID_With_Did := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));
					

	RETURN (With_Property__Key_Foreclosures_FID_With_Did);

	
	END;

