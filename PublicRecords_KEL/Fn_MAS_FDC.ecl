IMPORT ADVO, AutoKey, BankruptcyV3, BBB2, BIPV2, BIPV2_Best, BIPV2_Build, Business_Risk_BIP, BusReg, CalBus, CellPhone, Corp2, 
		Cortera, Cortera_Tradeline, Data_Services, DCAV2, DMA, Doxie, Doxie_Files, DriversV2, DX_Email, 
		dx_Equifax_Business_Data, dx_Header, dx_Infutor_NARB, EBR, Email_Data, FAA, FBNv2, Fraudpoint3, Gong, 
		GovData, Header, Header_Quick, InfoUSA, IRS5500, InfutorCID, Inquiry_AccLogs, MDR, OSHAIR, Phonesplus_v2, Prof_License_Mari, 
		Prof_LicenseV2, Relationship, Risk_Indicators, RiskView, SAM, STD, Suppress, Targus, USPIS_HotList, UtilFile, 
		VehicleV2, Watercraft, UCCV2, YellowPages , dx_header;
		
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
		
EXPORT Fn_MAS_FDC(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) Input,
									PublicRecords_KEL.Interface_Options Options,
									DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput = DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII)
									) := FUNCTION
/* 
		The following data sources are represented in the Federated Data Composite (FDC) below:
			-	Consumer Header
			-	Criminal Records
			-	Bankruptcy
			-	Aircraft
			-	Vehicle
			-	Watercraft
			-	Email
			-	Address (Consumer)
			-	Person
			-	Business Header
			-	Tradeline / Cortera
			-	Address (Business)
*/	
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
		EXPORT UNSIGNED1 lexid_source_optout := Options.LexIdSourceOptout;
		EXPORT STRING transaction_id := Options.TransactionID; // esp transaction id or batch uid
		EXPORT UNSIGNED6 global_company_id := Options.GlobalCompanyId; // mbs gcid
	END;

  unsigned1 iType := IF(Options.IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);

		
	Layouts_FDC  := PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options);
	Common       := PublicRecords_KEL.ECL_Functions.Common(Options);
	CFG_File     := PublicRecords_KEL.CFG_Compile;
	Regulated    := TRUE;
	NotRegulated := FALSE;
	BlankString  := '';
	SetDPMBitmap := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue;
	Environment := IF(Options.IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA); // for CCPA Suppression calls

	// Records from GLB sources might NOT be GLBA Regulated depending on if they are older than GLBA Laws
	PreGLBRegulatedRecord(STRING Source_Column, UNSIGNED3 Date_Last_Seen_Column, UNSIGNED3 Date_First_Seen_Column) := 
				Source_Column IN MDR.SourceTools.set_GLB AND Header.isPreGLB_LIB(Date_Last_Seen_Column, Date_First_Seen_Column, Source_Column, '00000000000000000000000000000000000000000000000000');

	// Death Master records are GLB regulated if glb_flag = 'Y'
	GLBARegulatedDeathMasterRecord(STRING glb_flag) := glb_flag = 'Y';

	// Additionally records from certain states are not allowed to be used unless we have a DPPA in a specific set of values
	GetDPPAState(STRING Source_Column) := MDR.SourceTools.DPPAOriginState(Source_Column);

	// Phones Plus Scoring Keys are GLB regulated dppa_glb_flag is 'G' or 'B'
	GLBARegulatedPhonesPlusRecord(STRING dppa_glb_flag) := IF(TRIM(dppa_glb_flag,LEFT,RIGHT) IN ['G','B'], TRUE, FALSE);
	
	DPPARegulatedWaterCraftRecord(STRING dppa_flag) := IF(TRIM(dppa_flag, LEFT, RIGHT) = 'Y', TRUE, FALSE);	

	// Data cleaning functions needed to get raw data ready for KEL
	Doxie_Files__Key_Offenders_Src(STRING data_type) := CASE(data_type,
				'1' => 'DC',
				'2' => 'CC',
				'5' => 'AL',
					'');
		
	CleanSIC(STRING SICCode) := STD.Str.Filter(SICCode, '0123456789')[1..4];
	CleanNAIC(STRING NAICCode) := STD.Str.Filter(NAICCode, '0123456789')[1..6];		
	Set_Large_Cortera_SeleIDs := [1173819,1651059];
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
							SELF.B_LexIDLegal := RIGHT.B_LexIDLegal, // SeleIDID
							SELF.B_LexIDSite := RIGHT.B_LexIDSite, // ProxID
							SELF.B_LexIDLoc := RIGHT.B_LexIDLoc, // PowID
							SELF.P_InpClnEmail := LEFT.P_InpClnEmail,
							SELF.P_InpClnDL := LEFT.P_InpClnDL,									
							SELF := []), FULL OUTER );
		
	Input_Address_Consumer_recs :=
		PROJECT( Input,
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric,
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
				SELF.CityCode        := Doxie.Make_CityCode(LEFT.P_InpClnAddrCity), // doxie.Make_CityCodes(LEFT.InputCityClean).rox) ???
				SELF := LEFT,
				SELF := []
			)
		);
	
	Input_Address_Business_recs :=
		PROJECT( BusinessInput,
			TRANSFORM( Layouts_FDC.LayoutAddressGeneric,
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
				SELF := LEFT,
				SELF := []
			)
		);

	Input_Address_All := (Input_Address_Consumer_recs + Input_Address_Business_recs)(PrimaryRange != '' AND PrimaryName != '' AND ZIP5 != '');

	Input_Phone_Consumer_recs :=
		NORMALIZE( Input, 2, // Consumer input can contain a homephone and a workphone
			TRANSFORM( Layouts_FDC.LayoutPhoneGeneric,
				SELF.UIDAppend := LEFT.G_ProcUID,
				SELF.Phone := CHOOSE( COUNTER, LEFT.P_InpClnPhoneHome, LEFT.P_InpClnPhoneWork),
				SELF := []
			)
		);
	
	Input_Phone_Business_recs :=
		PROJECT( BusinessInput,
			TRANSFORM( Layouts_FDC.LayoutPhoneGeneric,
				SELF.UIDAppend := LEFT.G_ProcBusUID,
				SELF.Phone := LEFT.B_InpClnPhone,
				SELF := []
			)
		);

	Input_Phone_All := (DEDUP(Input_Phone_Consumer_recs, Phone) + Input_Phone_Business_recs)(Phone != '');
	
	/* **************************************************************************
			
	                             CONSUMER SECTION

	************************************************************************** */

	// Doxie.Key_FCRA_Header/Doxie.Key_Header. FCRA/NonFCRA have the same layout.
	// Doxie__Key_Header := IF(Options.IsFCRA, Doxie.Key_FCRA_Header, Doxie.Key_Header);
  
	// FCRA/NonFCRA have the same layout.
	Doxie__Key_Header := dx_header.key_header(iType);
  
  
  
	Doxie__Key_Header_Records_Unsuppressed := 
		JOIN(Input_FDC, Doxie__Key_Header,
				Common.DoFDCJoin_Doxie__Key_Header = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Header,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(RIGHT.Src, RIGHT.dt_nonglb_last_seen, RIGHT.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(RIGHT.src), KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Doxie__Key_Header_Records := Suppress.MAC_SuppressSource(Doxie__Key_Header_Records_Unsuppressed, mod_access, did_field := s_did, data_env := Environment);
						
	With_Doxie__Key_Header := DENORMALIZE(Input_FDC, Doxie__Key_Header_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie__Key_Header := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
	
	// Header_Quick.Key_Did_FCRA/Header_Quick.Key_Did. FCRA/NonFCRA have the same layout.
	Header_Quick__Key_Did := IF(Options.IsFCRA, Header_Quick.Key_Did_FCRA, Header_Quick.Key_Did);
	Header_Quick__Key_Did_Records_Unsuppressed := 
		JOIN(Input_FDC, Header_Quick__Key_Did,
				Common.DoFDCJoin_Header_Quick__Key_Did = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Header_Quick__Key_Did,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(RIGHT.Src, RIGHT.dt_nonglb_last_seen, RIGHT.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(RIGHT.Src), KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Header_Quick__Key_Did_Records := Suppress.MAC_SuppressSource(Header_Quick__Key_Did_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);
					
	With_Header_Quick__Key_Did := DENORMALIZE(With_Doxie__Key_Header, Header_Quick__Key_Did_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Header_Quick__Key_Did := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
	
	// --------------------[ Criminal records ]--------------------
	
	// Doxie_Files.Key_BocaShell_Crim_FCRA -- FCRA only
	Doxie_Files__Key_BocaShell_Crim_FCRA_Records :=	
		JOIN(Input_FDC, Doxie_Files.Key_BocaShell_Crim_FCRA,
				Common.DoFDCJoin_Doxie_Files__Key_BocaShell_Crim_FCRA = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.DID),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_BocaShell_Crim_FCRA_Denorm,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := TRUE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
		
	// Doxie_Files.Key_BocaShell_Crim_FCRA contains a child dataset so we need to add an extra step and NORMALIZE it before adding to the FDC bundle.
	Doxie_Files__Key_BocaShell_Crim_FCRA_Records_Norm := NORMALIZE(Doxie_Files__Key_BocaShell_Crim_FCRA_Records, LEFT.criminal_count, 
			TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_BocaShell_Crim_FCRA,
								SELF := LEFT,
								SELF := RIGHT));
					
	With_Doxie_Files__Key_BocaShell_Crim_FCRA := DENORMALIZE(With_Header_Quick__Key_Did, Doxie_Files__Key_BocaShell_Crim_FCRA_Records_Norm, 
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
						
	// Doxie_Files.Key_Offenders(isFCRA) --	FCRA and NonFCRA	
	Doxie_Files__Key_Offenders_Records := 
		JOIN(Input_FDC, Doxie_Files.Key_Offenders(Options.isFCRA),
				Common.DoFDCJoin_Doxie_Files__Key_Offenders = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.sdid),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenders,
					_src := Doxie_Files__Key_Offenders_Src(RIGHT.data_type);
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.fcra_date := IF( Options.isFCRA = TRUE, RIGHT.fcra_date, '' ), // populate only if using the FCRA key
					SELF.data_type := IF( Options.isFCRA = TRUE, RIGHT.data_type, '' ), // populate only if using the FCRA key
					SELF.src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
					
	With_Doxie_Files__Key_Offenders := DENORMALIZE(With_Doxie_Files__Key_BocaShell_Crim_FCRA, Doxie_Files__Key_Offenders_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenders := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
						
	// Doxie_files.Key_Court_Offenses -- FCRA only (even though nonFCRA version of key exists)
	// Doxie_files.Key_Court_Offenses does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_FCRA_Records so we can join by offender key
	Doxie_files__Key_Court_Offenses_Records := 
			JOIN(Doxie_Files__Key_Offenders_Records, Doxie_files.Key_Court_Offenses(isFCRA := Options.isFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
					
	With_Doxie_files__Key_Court_Offenses := DENORMALIZE(With_Doxie_Files__Key_Offenders, Doxie_files__Key_Court_Offenses_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_files__Key_Court_Offenses := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
						
	// Doxie_Files.Key_Offenses -- FCRA only (even though nonFCRA version of key exists)
	// Doxie_files.Key_Offenses does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_Records so we can join by offender key
	Doxie_Files__Key_Offenses_Records := 
			JOIN(Doxie_Files__Key_Offenders_Records, Doxie_Files.Key_Offenses(isFCRA := Options.isFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
					
	With_Doxie_Files__Key_Offenses := DENORMALIZE(With_Doxie_files__Key_Court_Offenses, Doxie_Files__Key_Offenses_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenses := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// Doxie_Files.Key_Offenders_Risk -- NonFCRA only
	Doxie_Files__Key_Offenders_Risk_Records := 
			JOIN(Input_FDC, Doxie_Files.Key_Offenders_Risk,
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
		
	With_Doxie_Files__Key_Offenders_Risk := DENORMALIZE(With_Doxie_Files__Key_Offenses, Doxie_Files__Key_Offenders_Risk_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenders_Risk := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		

	// Doxie_Files.Key_Punishment -- NonFCRA only (even though FCRA version of key exists)
	// Doxie_Files.Key_Punishment does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_Records so we can join by offender key
	Doxie_Files__Key_Punishment_Records := 
			JOIN(Doxie_Files__Key_Offenders_Records, Doxie_Files.Key_Punishment(isFCRA := Options.isFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
		
	With_Doxie_Files__Key_Punishment := DENORMALIZE(With_Doxie_Files__Key_Offenders_Risk, Doxie_Files__Key_Punishment_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Punishment := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		
						
	// --------------------[ Bankruptcy records ]--------------------
	
	// BankruptcyV3.key_bankruptcyV3_did has a parameter to say if FCRA or nonFCRA - same file layout
	Bankruptcy_Files__Key_bankruptcy_did_Records :=	
			JOIN(Input_FDC, BankruptcyV3.key_bankruptcyV3_did(Options.isFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	// BankruptcyV3.key_bankruptcyv3_search_full_bip has a parameter to say if FCRA or nonFCRA - same file layout		
	Bankruptcy_Files__Key_Search_Records_pre := 
		JOIN(Bankruptcy_Files__Key_bankruptcy_did_Records, BankruptcyV3.key_bankruptcyv3_search_full_bip(Options.isFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	// Left Only join to the Bankruptcy Withdrawn key to remove all Withdrawn records.
	Bankruptcy_Files__Key_Search_Records := 
		JOIN(Bankruptcy_Files__Key_Search_Records_pre, BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,Options.IsFCRA),
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
				LEFT ONLY);
		
	With_Bankruptcy := 
		DENORMALIZE(With_Doxie_Files__Key_Punishment,Bankruptcy_Files__Key_Search_Records,
				LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
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
		
		With_Business_Bankruptcy := 
		DENORMALIZE(With_Bankruptcy,Bankruptcy_Files__Linkids_Key_Search,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Bankruptcy_Files__Linkids_Key_Search := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyV3_linkids_Key, 
															SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Bankruptcy, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
															SELF.Src := MDR.sourceTools.src_Bankruptcy,
															SELF := LEFT, 
															SELF := []));
						SELF := LEFT,
						SELF := []));	
						
	// --------------------[ Aircraft records ]--------------------

	// FAA.key_aircraft_did has a parameter to say if FCRA or nonFCRA - same file layout
	Key_Aircraft_did_Records := 
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
		JOIN(Key_Aircraft_did_Records, FAA.key_aircraft_id(Options.isFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_Aircraft_ID_Records := DENORMALIZE(With_Business_Bankruptcy, Key_Aircraft_ID_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_FAA__Key_Aircraft_IDs := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	// --------------------[ Vehicle records ]--------------------

	Key_Vehicle_did_Records :=	
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	
	// --------------------[ Watercraft records ]--------------------

	// Watercraft.key_watercraft_did has a parameter to say if FCRA or nonFCRA - same file layout
	Key_Watercraft_did_Records := 
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
		JOIN(Key_Watercraft_did_Records, Watercraft.key_watercraft_sid(Options.isFCRA),
					Common.DoFDCJoin_Watercraft_Files__Watercraft_SID = TRUE AND
					KEYED(LEFT.watercraft_key = RIGHT.watercraft_key) AND
					KEYED(LEFT.sequence_key = '' OR LEFT.sequence_key = RIGHT.sequence_key) AND
					KEYED(LEFT.state_origin = '' OR LEFT.state_origin = RIGHT.state_origin),
				TRANSFORM(Layouts_FDC.Layout_Watercraft__Key_Watercraft_SID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.source_code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := DPPARegulatedWaterCraftRecord(RIGHT.dppa_flag), DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Key_Watercraft_sid_Records := Suppress.MAC_SuppressSource(Key_Watercraft_sid_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);
	
	With_Watercraft_Records := DENORMALIZE(With_Aircraft_ID_Records, Key_Watercraft_sid_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Watercraft__Key_Watercraft_SID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	// --------------------[ ProfessionalLicense records ]--------------------
	// Prof_LicenseV2.Key_Proflic_Did has a parameter to say if FCRA or nonFCRA - same file layout		
	Prof_LicenseV2__Key_Proflic_Did_Records_unsuppressed :=
		JOIN(Input_FDC, Prof_LicenseV2.Key_Proflic_Did(Options.IsFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Prof_LicenseV2__Key_Proflic_Did_Records := Suppress.MAC_SuppressSource(Prof_LicenseV2__Key_Proflic_Did_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);

	// Append Occupation and Category data to Proflic DID key Records by joining to Prof_LicenseV2.Key_LicenseType_lookup.
	// Prof_LicenseV2.Key_LicenseType_lookup has a parameter to say if FCRA or nonFCRA - same file layout		
	Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records := 
		JOIN(Prof_LicenseV2__Key_Proflic_Did_Records, Prof_LicenseV2.Key_LicenseType_lookup(Options.IsFCRA),
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
				LEFT OUTER, ATMOST(100), KEEP(1));
			
	With_Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records := DENORMALIZE(With_Watercraft_Records, Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records,
      LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
      TRANSFORM(Layouts_FDC.Layout_FDC,
          SELF.Dataset_Prof_LicenseV2__Key_Proflic_Did := ROWS(RIGHT),
          SELF := LEFT,
          SELF := []));	

	// Prof_License_Mari.Key_Did has a parameter to say if FCRA or nonFCRA - same file layout		
	Prof_License_Mari__Key_Did_Records_unsuppressed := 
		JOIN(Input_FDC, Prof_License_Mari.Key_Did(Options.IsFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Prof_License_Mari__Key_Did_Records := Suppress.MAC_SuppressSource(Prof_License_Mari__Key_Did_Records_unsuppressed, mod_access, did_field := s_did, data_env := Environment);

	// Append Occupation and Category data to Proflic Mari DID records by joining to Prof_LicenseV2.Key_LicenseType_lookup.
	// Prof_LicenseV2.Key_LicenseType_lookup has a parameter to say if FCRA or nonFCRA - same file layout		
	Prof_License_Mari__Key_Did_LicenseType_Lookup_Records := 
		JOIN(Prof_License_Mari__Key_Did_Records, Prof_LicenseV2.Key_LicenseType_lookup(Options.IsFCRA),
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
				LEFT OUTER, ATMOST(100), KEEP(1));
			
	With_Prof_License_Mari__Key_Did_LicenseType_Lookup_Records := DENORMALIZE(With_Prof_LicenseV2__Key_Proflic_Did_LicenseType_Lookup_Records, Prof_License_Mari__Key_Did_LicenseType_Lookup_Records,
      LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
      TRANSFORM(Layouts_FDC.Layout_FDC,
          SELF.Dataset_Prof_License_Mari__Key_Did := ROWS(RIGHT),
          SELF := LEFT,
          SELF := []));	
					
	// --------------------[ Emails ]--------------------
	
	Key_Email_Data__Key_DID := 
		JOIN(Input_FDC, dx_Email.Key_Did(Options.isFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
			
	Key_Email_Data__Key_Email_Address := 
		JOIN(Input_FDC, dx_Email.Key_Email_Address(),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
				
	Key_DX_Email__Key_Email_Payload_Full := Key_Email_Data__Key_DID + Key_Email_Data__Key_Email_Address;
	
	Key_DX_Email__Key_Email_Payload_DID_unsuppressed := 
		JOIN(Key_DX_Email__Key_Email_Payload_Full, DX_Email.Key_Email_Payload(Options.isFCRA),
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));			

	Key_DX_Email__Key_Email_Payload_DID := Suppress.MAC_SuppressSource(Key_DX_Email__Key_Email_Payload_DID_unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Email_Payload_Records := DENORMALIZE(With_Prof_License_Mari__Key_Did_LicenseType_Lookup_Records, Key_DX_Email__Key_Email_Payload_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DX_Email__Key_Email_Payload := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
					
	// ----------[ Address (LexID match: consumer; Address match: consumer or business) ]----------
	
	// ADVO: business and consumer
	ADVO__Key_Addr1 := IF(Options.IsFCRA, ADVO.Key_Addr1_FCRA, ADVO.Key_Addr1);
	Key_Advo_Addr1_Records := 
		JOIN(Input_Address_All, ADVO__Key_Addr1,
				Common.DoFDCJoin_ADVO__Key_Addr1 = TRUE AND
				LEFT.PrimaryRange != '' AND LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.AddrSuffix = RIGHT.addr_suffix AND
					LEFT.Predirectional = RIGHT.predir AND
					LEFT.Postdirectional = RIGHT.postdir AND
					LEFT.SecondaryRange = RIGHT.sec_range),
				TRANSFORM(Layouts_FDC.Layout_ADVO__Key_Addr1,
					SELF.Src := RIGHT.src,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
	
	With_ADVO_Records := DENORMALIZE(With_Email_Payload_Records, Key_Advo_Addr1_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_ADVO__Key_Addr1 := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	
	// ADVO: business and consumer
	ADVO__Key_Addr1_History := IF(Options.IsFCRA, ADVO.Key_Addr1_FCRA_History, ADVO.Key_Addr1_History);
	Key_Advo_Addr1_History_Records := 
		JOIN(Input_Address_All, ADVO__Key_Addr1_History,
				Common.DoFDCJoin_ADVO__Key_Addr1_History = TRUE AND
				LEFT.PrimaryRange != '' AND LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
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
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
	
	With_ADVO_History_Records := DENORMALIZE(With_ADVO_Records, Key_Advo_Addr1_History_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_ADVO__Key_Addr1_History := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	
	// DNM: consumer address only; use consumer address data
	Key_DNM_Name_Address_Records := 
		JOIN(Input_Address_All, DMA.Key_DNM_Name_Address,
				Common.DoFDCJoin_DMA__Key_DNM_Name_Address = TRUE AND
				LEFT.PrimaryRange != '' AND LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(LEFT.PrimaryName = RIGHT.l_prim_name AND
					LEFT.PrimaryRange = RIGHT.l_prim_range AND
					LEFT.State = RIGHT.l_st AND
					LEFT.CityCode = RIGHT.l_city_code AND
					LEFT.ZIP5 = RIGHT.l_zip AND
					LEFT.SecondaryRange = RIGHT.l_sec_range),
				TRANSFORM(Layouts_FDC.Layout_DMA__Key_DNM_Name_Address,
					SELF.Src := BlankString,
					SELF.DPMBitmap := SetDPMBitmap( Source := BlankString, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_DNM_Name_Address_Records := DENORMALIZE(With_ADVO_History_Records, Key_DNM_Name_Address_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DMA__Key_DNM_Name_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	// FP: consumer address only; use consumer address data	
	Key_Fraudpoint3_Address_Records :=
		JOIN(Input_Address_All, Fraudpoint3.Key_Address,
				Common.DoFDCJoin_Fraudpoint3__Key_Address = TRUE AND
				LEFT.PrimaryRange != '' AND LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.SecondaryRange = RIGHT.sec_range),
				TRANSFORM(Layouts_FDC.Layout_Fraudpoint3__Key_Address,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.FraudPoint3Source,
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.FraudPoint3Source, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
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
	
	// Header: consumer only
	Key_Header_Addr_Hist := 
			JOIN(Input_FDC, dx_Header.key_addr_hist((INTEGER)Options.isFCRA), 
				Common.DoFDCJoin_Header__Key_Addr_Hist = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_Header__Key_Addr_Hist,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := BlankString,
					SELF.DPMBitmap := SetDPMBitmap( Source := BlankString, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_Header_Addr_Hist_Records := DENORMALIZE(With_Fraudpoint3_Address_Records, Key_Header_Addr_Hist,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Header__Key_Addr_Hist := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	
	// AccLogs: consumer only
	Key_AccLogs_FCRA_DID_unsuppressed := 
			JOIN(Input_FDC, Inquiry_AccLogs.Key_FCRA_DID, 
				Common.DoFDCJoin_Inquiry_AccLogs__Key_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.appended_adl),
				TRANSFORM(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DateOfInquiry := RIGHT.Search_Info.DateTime[1..8];
					SELF.TimeOfInquiry := RIGHT.Search_Info.DateTime[10..17];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := TRUE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Key_AccLogs_FCRA_DID := Suppress.MAC_SuppressSource(Key_AccLogs_FCRA_DID_unsuppressed, mod_access, did_field := appended_adl, gsid_field := ccpa.global_sid, data_env := Environment);

	With_AccLogs_FCRA_DID_Records := DENORMALIZE(With_Header_Addr_Hist_Records, Key_AccLogs_FCRA_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Inquiry_AccLogs__Key_FCRA_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	
	// USPIS_HotList: business and consumer agnostic--no name or companyname info provided
	Key_USPIS_HotList_addr_search_zip := 
			JOIN(Input_Address_All, USPIS_HotList.key_addr_search_zip, 
				Common.DoFDCJoin_USPIS_HotList__key_addr_search_zip = TRUE AND
				LEFT.PrimaryRange != '' AND LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.AddrSuffix = RIGHT.addr_suffix AND
					LEFT.Predirectional = RIGHT.predir AND
					LEFT.Postdirectional = RIGHT.postdir AND
					LEFT.SecondaryRange = RIGHT.sec_range),
				TRANSFORM(Layouts_FDC.Layout_USPIS_HotList__key_addr_search_zip,
					SELF.Src := BlankString,
					SELF.DPMBitmap := SetDPMBitmap( Source := BlankString, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_USPIS_HotList_Records := DENORMALIZE(With_AccLogs_FCRA_DID_Records, Key_USPIS_HotList_addr_search_zip,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_USPIS_HotList__key_addr_search_zip := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	
	Key_UtilFile_Address := 
			JOIN(Input_Address_All, UtilFile.Key_Address, 
				Common.DoFDCJoin_UtilFile__Key_Address = TRUE AND
				LEFT.PrimaryRange != '' AND LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.State = RIGHT.st AND
					LEFT.ZIP5 = RIGHT.zip AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.SecondaryRange = RIGHT.sec_range),
				TRANSFORM(Layouts_FDC.Layout_UtilFile__Key_Address,
					SELF.Src := MDR.sourceTools.src_Utilities,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Utilities, FCRA_Restricted := FALSE, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

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
				KEYED(LEFT.P_LexID = RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_UtilFile__Key_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Utilities,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Utilities, FCRA_Restricted := FALSE, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_UtilFile_DID_Records := DENORMALIZE(With_UtilFile_Address_Records, Key_UtilFile_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UtilFile__Key_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
	
	// ----------[ Person ]----------
	
	Key_Doxie__Death_MasterV2_SSA_DID_unsuppressed := 
			JOIN(Input_FDC, Doxie.Key_Death_MasterV2_SSA_DID, 
				Common.DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.l_did),
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Death_MasterV2_SSA_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.src,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := FALSE, GLBA_Restricted := GLBARegulatedDeathMasterRecord(RIGHT.glb_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Key_Doxie__Death_MasterV2_SSA_DID := Suppress.MAC_SuppressSource(Key_Doxie__Death_MasterV2_SSA_DID_unsuppressed, mod_access, did_field := l_did, gsid_field := global_sid, data_env := Environment);

	With_Death_MasterV2_SSA_DID_Records := 
		DENORMALIZE(With_UtilFile_DID_Records, Key_Doxie__Death_MasterV2_SSA_DID,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Doxie__Key_Death_MasterV2_SSA_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	Key_DriversV2__DL_DID := 
			JOIN(Input_FDC, DriversV2.Key_DL_DID, 
				Common.DoFDCJoin_DriversV2__Key_DL_DID = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_DriversV2__Key_DL_DID,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Source_Code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source_Code, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.st, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

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
				KEYED(LEFT.P_InpClnDL = RIGHT.s_dl),
				TRANSFORM(Layouts_FDC.Layout_DriversV2__Key_DL_Number,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Source_Code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source_Code, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.st, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_DriversV2__DL_Number_Records := 
		DENORMALIZE(With_DriversV2__DL_DID_Records, Key_DriversV2__DL_Number_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DriversV2__Key_DL_Number := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	Key_Doxie__Header_Address_Records :=  
			JOIN(Input_Address_All, dx_header.key_header_address((INTEGER)Options.isFCRA), 
				Common.DoFDCJoin_Doxie__Key_Header_Address = TRUE AND
				LEFT.PrimaryRange != '' AND LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(
					LEFT.PrimaryName = RIGHT.prim_name AND 
					LEFT.ZIP5 = RIGHT.zip AND 
					LEFT.PrimaryRange = RIGHT.prim_range AND 
					LEFT.SecondaryRange = RIGHT.sec_range
				) AND
				LEFT.P_LexID = RIGHT.did,
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Header_Address,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.Src,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(RIGHT.Src, RIGHT.dt_last_seen, RIGHT.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.src, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_Doxie__Header_Address_Records := 
		DENORMALIZE(With_DriversV2__DL_Number_Records, Key_Doxie__Header_Address_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Doxie__Key_Header_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	Key_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered := // "Filtered" = FCRA
			JOIN(Input_FDC, Risk_Indicators.Key_FCRA_ADL_Risk_Table_v4_Filtered, 
				Common.DoFDCJoin_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Key_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Combo := 
			PROJECT( 
				Key_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered,
				TRANSFORM( Layouts_FDC.Layout_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Expanded,
					_src := MDR.sourceTools.src_Experian_Credit_Header + ',' + MDR.sourceTools.src_TU_CreditHeader + ',' + MDR.sourceTools.src_Equifax;
					SELF.Src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := TRUE, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := LEFT.combo,
					SELF := LEFT
				));

	Key_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Experian := 
			PROJECT( 
				Key_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered,
				TRANSFORM( Layouts_FDC.Layout_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Expanded,
					_src := MDR.sourceTools.src_Experian_Credit_Header;
					SELF.Src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := TRUE, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := LEFT.en,
					SELF := LEFT
				));

	Key_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Equifax := 
			PROJECT( 
				Key_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered,
				TRANSFORM( Layouts_FDC.Layout_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Expanded,
					_src := MDR.sourceTools.src_Equifax;
					SELF.Src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := TRUE, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := LEFT.eq,
					SELF := LEFT
				));

	With_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Combo := 
		DENORMALIZE(With_Doxie__Header_Address_Records, Key_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Combo,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Combo := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	With_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Experian := 
		DENORMALIZE(With_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Combo, Key_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Experian,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Experian := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	With_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Equifax := 
		DENORMALIZE(With_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Experian, Key_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Equifax,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Equifax := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
					
	Key_Risk_Indicators__ADL_Risk_Table_v4 := // not "Filtered" = NonFCRA
			JOIN(Input_FDC, Risk_Indicators.Key_ADL_Risk_Table_v4, 
				Common.DoFDCJoin_Risk_Indicators__Key_ADL_Risk_Table_v4 = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Risk_Indicators__Key_ADL_Risk_Table_v4,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Key_Risk_Indicators__ADL_Risk_Table_v4_Combo := 
			PROJECT( 
				Key_Risk_Indicators__ADL_Risk_Table_v4,
				TRANSFORM( Layouts_FDC.Layout_Risk_Indicators__Key_ADL_Risk_Table_v4_Expanded,
					_src := MDR.sourceTools.src_Experian_Credit_Header + ',' + MDR.sourceTools.src_TU_CreditHeader + ',' + MDR.sourceTools.src_Equifax;
					SELF.Src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := FALSE, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := LEFT.combo,
					SELF := LEFT
				));

	Key_Risk_Indicators__ADL_Risk_Table_v4_Experian := 
			PROJECT( 
				Key_Risk_Indicators__ADL_Risk_Table_v4,
				TRANSFORM( Layouts_FDC.Layout_Risk_Indicators__Key_ADL_Risk_Table_v4_Expanded,
					_src := MDR.sourceTools.src_Experian_Credit_Header;
					SELF.Src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := FALSE, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := LEFT.en,
					SELF := LEFT
				));

	Key_Risk_Indicators__ADL_Risk_Table_v4_Equifax := 
			PROJECT( 
				Key_Risk_Indicators__ADL_Risk_Table_v4,
				TRANSFORM( Layouts_FDC.Layout_Risk_Indicators__Key_ADL_Risk_Table_v4_Expanded,
					_src := MDR.sourceTools.src_Equifax;
					SELF.Src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := FALSE, GLBA_Restricted := Regulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := LEFT.eq,
					SELF := LEFT
				));

	Key_Risk_Indicators__ADL_Risk_Table_v4_TransUnion := 
			PROJECT( 
				Key_Risk_Indicators__ADL_Risk_Table_v4,
				TRANSFORM( Layouts_FDC.Layout_Risk_Indicators__Key_ADL_Risk_Table_v4_Expanded,
					_src := MDR.sourceTools.src_TU_CreditHeader;
					SELF.Src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := LEFT.tn,
					SELF := LEFT
				));

	With_Risk_Indicators__ADL_Risk_Table_v4_Combo := 
		DENORMALIZE(With_Risk_Indicators__FCRA_ADL_Risk_Table_v4_Filtered_Equifax, Key_Risk_Indicators__ADL_Risk_Table_v4_Combo,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Risk_Indicators__Key_ADL_Risk_Table_v4_Combo := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	With_Risk_Indicators__ADL_Risk_Table_v4_Experian := 
		DENORMALIZE(With_Risk_Indicators__ADL_Risk_Table_v4_Combo, Key_Risk_Indicators__ADL_Risk_Table_v4_Experian,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Risk_Indicators__Key_ADL_Risk_Table_v4_Experian := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	With_Risk_Indicators__ADL_Risk_Table_v4_Equifax := 
		DENORMALIZE(With_Risk_Indicators__ADL_Risk_Table_v4_Experian, Key_Risk_Indicators__ADL_Risk_Table_v4_Equifax,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Risk_Indicators__Key_ADL_Risk_Table_v4_Equifax := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	With_Risk_Indicators__ADL_Risk_Table_v4_TransUnion := 
		DENORMALIZE(With_Risk_Indicators__ADL_Risk_Table_v4_Equifax, Key_Risk_Indicators__ADL_Risk_Table_v4_TransUnion,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Risk_Indicators__Key_ADL_Risk_Table_v4_TransUnion := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

// Person - Relatives					
	Key_Relatives__Key_Relatives_V3 := 
			JOIN(Input_FDC, Relationship.key_relatives_v3, 
				Common.DoFDCJoin_Relatives__Key_Relatives_v3 = TRUE AND
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = RIGHT.did1),
				TRANSFORM(Layouts_FDC.Layout_Relatives__Key_Relatives_V3,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.DPMBitmap := SetDPMBitmap( BlankString, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
																						
	With_Key_Relatives_V3_Records := 
		DENORMALIZE(With_Risk_Indicators__ADL_Risk_Table_v4_TransUnion, Key_Relatives__Key_Relatives_V3,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Relatives__Key_Relatives_V3 := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

	// ----------[ Phone ]----------

	// Gong__Key_History_DID := IF( Options.isFCRA, Gong.Key_History_DID, Gong.Key_FCRA_History_DID );
	Gong__Key_History_DID := IF( Options.isFCRA, Gong.Key_FCRA_History_DID, Gong.Key_History_DID );
	Gong__Key_History_DID_Records_Unsuppressed := 
		JOIN( Input_FDC, Gong__Key_History_DID, 
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
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Gong__Key_History_DID_Records := 
		Suppress.MAC_SuppressSource(Gong__Key_History_DID_Records_Unsuppressed, mod_access, did_field := l_did, data_env := Environment);
					
	With_Gong_History_DID_Records := 
		DENORMALIZE(With_Key_Relatives_V3_Records, Gong__Key_History_DID_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend AND LEFT.P_LexID = RIGHT.P_LexID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Gong__Key_History_DID := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		


	// Gong__Key_History_Address := IF( Options.isFCRA, Gong.Key_History_Address, Gong.Key_FCRA_History_Address );
	Gong__Key_History_Address := IF( Options.isFCRA, Gong.Key_FCRA_History_Address, Gong.Key_History_Address );
	Gong__Key_History_Address_Records_Unsuppressed := 
		JOIN( Input_Address_All, Gong__Key_History_Address, 
			Common.DoFDCJoin_Gong__Key_History_Address AND
			LEFT.PrimaryRange != '' AND LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
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
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Gong__Key_History_Address_Records := 
		Suppress.MAC_SuppressSource(Gong__Key_History_Address_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);
					
	With_Gong_History_Address_Records := 
		DENORMALIZE(With_Gong_History_DID_Records, Gong__Key_History_Address_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Gong__Key_History_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		


	// Gong__Key_History_Phone := IF( Options.isFCRA, Gong.Key_History_Phone, Gong.Key_FCRA_History_Phone );
	Gong__Key_History_Phone := IF( Options.isFCRA, Gong.Key_FCRA_History_Phone, Gong.Key_History_Phone );
	Gong__Key_History_Phone_Records_Unsuppressed := 
		JOIN( Input_Phone_All, Gong__Key_History_Phone, 
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
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Gong__Key_History_Phone_Records := 
		Suppress.MAC_SuppressSource(Gong__Key_History_Phone_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);
					
	With_Gong_History_Phone_Records := 
		DENORMALIZE(With_Gong_History_Address_Records, Gong__Key_History_Phone_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Gong__Key_History_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		


	// Targus__Key_History_Address := IF( Options.isFCRA, Targus.Key_Targus_Address, Targus.Key_Targus_FCRA_Address );
	Targus__Key_History_Address := IF( Options.isFCRA, Targus.Key_Targus_FCRA_Address, Targus.Key_Targus_Address );
	Targus__Key_History_Address_Records_Unsuppressed := 
		JOIN( Input_Address_All, Targus__Key_History_Address, 
			Common.DoFDCJoin_Targus__Key_Targus_Address AND
			LEFT.PrimaryRange != '' AND LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
			KEYED(
				LEFT.PrimaryName = RIGHT.prim_name AND 
				LEFT.ZIP5 = RIGHT.zip AND 
				LEFT.PrimaryRange = RIGHT.prim_range AND 
				LEFT.SecondaryRange = RIGHT.sec_range AND
				LEFT.Predirectional = RIGHT.predir AND
				LEFT.AddrSuffix = RIGHT.suffix
			),
			TRANSFORM(Layouts_FDC.Layout_Targus__Key_Targus_Address,
				SELF.UIDAppend := LEFT.UIDAppend,
				SELF.G_ProcUID := LEFT.G_ProcUID,
				SELF.P_LexID := LEFT.P_LexID,
				SELF.Src := MDR.sourceTools.src_Targus_White_pages,
				SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Targus_White_pages, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				SELF := RIGHT, 
				SELF := LEFT,
				SELF := []), 
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Targus__Key_History_Address_Records := 
		Suppress.MAC_SuppressSource(Targus__Key_History_Address_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);
					
	With_Targus_History_Address_Records := 
		DENORMALIZE(With_Gong_History_Phone_Records, Targus__Key_History_Address_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Targus__Key_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		


	// Targus__Key_History_Phone := IF( Options.isFCRA, Targus.Key_Targus_Phone, Targus.Key_Targus_FCRA_Phone );
	Targus__Key_History_Phone := IF( Options.isFCRA, Targus.Key_Targus_FCRA_Phone, Targus.Key_Targus_Phone );
	Targus__Key_History_Phone_Records_Unsuppressed := 
		JOIN( Input_Phone_All, Targus__Key_History_Phone, 
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
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Targus__Key_History_Phone_Records := 
		Suppress.MAC_SuppressSource(Targus__Key_History_Phone_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);
					
	With_Targus_History_Phone_Records := 
		DENORMALIZE(With_Targus_History_Address_Records, Targus__Key_History_Phone_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Targus__Key_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		


	// InfutorCID__Key_Phone := IF( Options.isFCRA, InfutorCID.Key_Infutor_Phone, InfutorCID.Key_Infutor_Phone_FCRA );
	InfutorCID__Key_Phone := IF( Options.isFCRA, InfutorCID.Key_Infutor_Phone_FCRA, InfutorCID.Key_Infutor_Phone );
	InfutorCID__Key_Phone_Records_Unsuppressed := 
		JOIN( Input_Phone_All, InfutorCID__Key_Phone, 
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
			ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	InfutorCID__Key_Phone_Records := 
		Suppress.MAC_SuppressSource(InfutorCID__Key_Phone_Records_Unsuppressed, mod_access, did_field := did, data_env := Environment);
					
	With_InfutorCID_Phone_Records := 
		DENORMALIZE(With_Targus_History_Phone_Records, InfutorCID__Key_Phone_Records,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_InfutorCID__Key_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));		

/* Phone Records - By phone number*/			
	Key_PhonesPlus_v2__Keys_ScoringPhone := 
			JOIN(Input_Phone_All, Phonesplus_v2.Keys_Scoring().phone.qa, 
				Common.DoFDCJoin_PhonePlus_V2__ScoringPhone = TRUE AND
				LEFT.Phone <> '' AND
				KEYED(LEFT.Phone  = RIGHT.cellphone),
				TRANSFORM(Layouts_FDC.Layout_Phone__PhonesPlus_v2_Keys_Scoring_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := FALSE, GLBA_Restricted := GLBARegulatedPhonesPlusRecord(RIGHT.glb_dppa_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.state, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_PhonePlus_V2_ScoringPhone_Records := 
		DENORMALIZE(With_InfutorCID_Phone_Records, Key_PhonesPlus_v2__Keys_ScoringPhone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

/* Phone Records - By Address*/			

	Key_PhonesPlus_v2__Keys_ScoringAddress := 
			JOIN(Input_Address_All, Phonesplus_v2.Keys_Scoring().address.qa, 
				Common.DoFDCJoin_PhonePlus_V2__ScoringAddress = TRUE AND
				LEFT.PrimaryRange != '' AND LEFT.PrimaryName != '' AND LEFT.ZIP5 != '' AND 
				KEYED(LEFT.PrimaryName = RIGHT.prim_name AND
					LEFT.ZIP5 = RIGHT.zip5 AND
					LEFT.PrimaryRange = RIGHT.prim_range AND
					LEFT.SecondaryRange = RIGHT.sec_range AND
					LEFT.Predirectional = RIGHT.predir AND
					LEFT.AddrSuffix = RIGHT.addr_suffix),
				TRANSFORM(Layouts_FDC.Layout_Phone__PhonesPlus_v2_Keys_Scoring_Address,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := FALSE, GLBA_Restricted := GLBARegulatedPhonesPlusRecord(RIGHT.glb_dppa_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.state, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_PhonePlus_V2_ScoringAddress_Records := 
		DENORMALIZE(With_PhonePlus_V2_ScoringPhone_Records, Key_PhonesPlus_v2__Keys_ScoringAddress,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	
					
/* I Verification Records - By Phone*/			

	Key_Iverification__Keys_Iverification_phone := 
			JOIN(Input_Phone_All, Phonesplus_v2.Keys_Iverification().phone.qa, 
				Common.DoFDCJoin_PhonePlus_V2__Iverification_Phone = TRUE AND
				LEFT.Phone <> '' AND
				KEYED(LEFT.Phone = RIGHT.phone),
				TRANSFORM(Layouts_FDC.Layout_Key_Iverification__Keys_Iverification_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_Key_Iverfication_phone_Records := 
		DENORMALIZE(With_PhonePlus_V2_ScoringAddress_Records, Key_Iverification__Keys_Iverification_Phone, 
					LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,	
					TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Key_Iverification__Keys_Iverification_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));	

/* I Verification Records - By Lexid and Phone*/			

	Key_Iverification__Keys_Iverification_Did_Phone := 
			JOIN(Input_Phone_All, Phonesplus_v2.Keys_Iverification().did_phone.qa, 
				Common.DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone = TRUE AND
				LEFT.P_LexID != 0 AND LEFT.Phone <> '' AND
				KEYED(LEFT.P_LexID = RIGHT.did AND 
							LEFT.Phone = RIGHT.phone),
					TRANSFORM(Layouts_FDC.Layout_Key_Iverification__Keys_Iverification_Did_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_Key_Iverfication_Did_Phone_Records := 
		DENORMALIZE(With_Key_Iverfication_phone_Records, Key_Iverification__Keys_Iverification_Did_Phone,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Key_Iverification__Keys_Iverification_Did_Phone := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));
	
	/* Cellphone - Neustar Phone Records */			

	Key_CellPhone__Key_Neustar_Phone := 
			JOIN(Input_Phone_All, CellPhone.key_neustar_phone, 
				Common.DoFDCJoin_CellPhone__Key_Nustar_Phone = TRUE AND
				LEFT.Phone <> '' AND
				KEYED(LEFT.Phone = RIGHT.cellphone),
					TRANSFORM(Layouts_FDC.Layout_Key_CellPhone__Key_Neustar_Phone,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Src := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Phones_Plus, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
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
			JOIN(Input_Phone_All, AutoKey.Key_Phone(Data_Services.Data_Location.Prefix('phonesPlus') + 'thor_data400::key::phonesplusv2_'), 
				(INTEGER)LEFT.Phone > 0 AND 
				KEYED(RIGHT.p7 = LEFT.Phone[4..10]) AND 
				KEYED(RIGHT.p3 = LEFT.Phone[1..3]),
					TRANSFORM(Layouts_FDC.LayoutPhoneAutoKeys,
					SELF.Fdid := RIGHT.did,
					SELF := LEFT), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
				
	Key_PhonesPlus_v2__Key_PhonesPlus_Fdid := 
			JOIN(Key_PhonesPlus_v2__Key_PhonesPlus_did_records, Phonesplus_v2.Key_Phonesplus_Fdid, 
				Common.DoFDCJoin_PhonePlus_V2__Key_Phoneplus_FDid = TRUE AND
				LEFT.Fdid != 0 AND LEFT.Phone <> '' AND
				KEYED(LEFT.Fdid = RIGHT.fdid) AND 
				LEFT.Phone = RIGHT.cellphone,
					TRANSFORM(Layouts_FDC.Layout_PhonesPlus_v2_Key_PhonePlus_Fdid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.Source := MDR.sourceTools.src_Phones_Plus,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := FALSE, GLBA_Restricted := GLBARegulatedPhonesPlusRecord(RIGHT.glb_dppa_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := RIGHT.origstate, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	With_PhonesPlus_v2__Key_PhonePlus_Fdid_Records := 
		DENORMALIZE(With_Key_CellPhone__Key_Neustar_Phone_Records, Key_PhonesPlus_v2__Key_PhonesPlus_Fdid,
			LEFT.UIDAppend = RIGHT.UIDAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));
					
	/* **************************************************************************
			
	                             BUSINESS SECTION

	************************************************************************** */

	// --------------------[ Business Header records ]--------------------
	
	Business_Header_Key_Linking_unsuppressed := IF(Common.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids = TRUE, 
																							BIPV2.Key_BH_Linking_Ids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									linkingOptions,
																									PublicRecords_KEL.ECL_Functions.Constants.Business_Header_LIMIT,
																									FALSE, /* dnbFullRemove */
																									TRUE, /* bypassContactSuppression */
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin));
																									
	Business_Header_Key_Linking := Suppress.MAC_SuppressSource(Business_Header_Key_Linking_unsuppressed, mod_access, did_field := contact_did, data_env := Environment);		
	
	With_Business_Header_Key_Linking := DENORMALIZE(With_PhonesPlus_v2__Key_PhonePlus_Fdid_Records, Business_Header_Key_Linking,	
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2__Key_BH_Linking_kfetch2 := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BIPV2__Key_BH_Linking_kfetch2, 
																											SELF.DPMBitmap := SetDPMBitmap( Source := Left.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(Left.Source, 0, Left.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(Left.source), KELPermissions := CFG_File),
																											self.src := Left.source, //many sources in business header
																											self := left, 
																											self := []));
					SELF := LEFT,
					SELF := []));
					

	// --------------------[ Tradeline records ]--------------------
	
	Tradeline_Key_LinkIds := IF(Common.DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds = TRUE,
															Cortera_Tradeline.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
															PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
															0, /*ScoreThreshold --> 0 = Give me everything*/
															PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
															BIPV2.IDconstants.JoinTypes.LimitTransformJoin));
		
	With_Tradeline_Key_LinkIds := DENORMALIZE(With_Business_Header_Key_Linking, Tradeline_Key_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Cortera_Tradeline__Key_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Cortera_Tradeline__Key_LinkIds, 
									SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
									SELF := LEFT, 
									SELF := []));	
					SELF := LEFT,
					SELF := []));

	// --------------------[ Address (business) ]--------------------

	Corp2_Kfetch_LinkIds_Corp := IF(Common.DoFDCJoin_Corp2__Key_LinkIDs_Corp = TRUE, 
																							Corp2.Key_LinkIDs.Corp.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_Corp2_Key_LinkIds_Corp := DENORMALIZE(With_Tradeline_Key_LinkIds, Corp2_Kfetch_LinkIds_Corp,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Corp2__Kfetch_LinkIDs_Corp := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Corp2__Kfetch_LinkIDs_Corp, 
																				self.src := MDR.sourceTools.fCorpV2( Left.corp_key, Left.corp_state_origin), 
																				SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
																				self := left, 
																				self := []));
					SELF := LEFT,
					SELF := []));

	InfoUSA_Key_LinkIds_DEADCO := IF(Common.DoFDCJoin_InfoUSA__Key_DEADCO_LinkIds = TRUE,
																	InfoUSA.Key_DEADCO_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																	PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																	0, /*ScoreThreshold --> 0 = Give me everything*/
																	PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																	BIPV2.IDconstants.JoinTypes.LimitTransformJoin));

	With_InfoUSA_Key_LinkIds_DEADCO := DENORMALIZE(With_Corp2_Key_LinkIds_Corp, InfoUSA_Key_LinkIds_DEADCO,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_InfoUSA__Key_DEADCO_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_InfoUSA__Key_DEADCO_LinkIds, 
									SELF.src := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,
									SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
									SELF := LEFT, 
									SELF := []));	
					SELF := LEFT,
					SELF := []));
					
	UtilFile_Kfetch2_LinkIds := IF(Common.DoFDCJoin_UtilFile__Key_LinkIds = TRUE, 
																							UtilFile.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin));						

	With_UtilFile_Key_LinkIds := DENORMALIZE(With_InfoUSA_Key_LinkIds_DEADCO, UtilFile_Kfetch2_LinkIds,
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
																			FAA.key_aircraft_linkids.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																			PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																			0, /*ScoreThreshold --> 0 = Give me everything*/
																			PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																			BIPV2.IDconstants.JoinTypes.LimitTransformJoin));

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
																										Watercraft.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																										PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																										0, /*ScoreThreshold --> 0 = Give me everything*/
																										linkingOptions,
																										PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																										BIPV2.IDconstants.JoinTypes.LimitTransformJoin));

	Key_Watercraft_LinkId_Records := Suppress.MAC_SuppressSource(Key_Watercraft_LinkId_Records_unsuppressed, mod_access, did_field := did, data_env := Environment);

	With_Watercraft_LinkId_Records := DENORMALIZE(With_Aircraft_linkids_Records, Key_Watercraft_LinkId_Records,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Watercraft__Watercraft__Key_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Watercraft__Key_LinkIds, 
									SELF.src := MDR.sourceTools.fWatercraft(RIGHT.Source_Code, RIGHT.State_Origin),
									SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := DPPARegulatedWaterCraftRecord(RIGHT.dppa_flag), DPPA_State := RIGHT.state_origin, KELPermissions := CFG_File),
									SELF := LEFT, 
									SELF := []));	
					SELF := LEFT,
					SELF := []));	

	Key_Vehicle_linkids_Records_unsuppressed := IF(Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID = TRUE, 
																								VehicleV2.Key_Vehicle_linkids.kFetch(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								mod_access,
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								linkingOptions,
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

	Key_Vehicle_linkids_Records := Suppress.MAC_SuppressSource(Key_Vehicle_linkids_Records_unsuppressed, mod_access, did_field := append_did, data_env := Environment);

	PublicRecords_KEL.ECL_Functions.Common_Functions.AppendSeq(Key_Vehicle_linkids_Records, Input_FDC,Temp_vehicle_linkid_records,PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID);

	With_Vehicle_linkids_Records := DENORMALIZE(With_Watercraft_LinkId_Records, Temp_vehicle_linkid_records,
			LEFT.G_ProcBusUID = RIGHT.uniqueId AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_VehicleV2__Key_Vehicle_LinkID_Key := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_LinkID_Key, 
									SELF.Src := RIGHT.source_code,
									SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := RIGHT.orig_state, KELPermissions := CFG_File),	
									SELF := LEFT, 
									SELF := []));	
					SELF := LEFT,
					SELF := []));	
	/* **************************************************************************
			
																Business and Consumer 

	************************************************************************** */
	Temp_Vehicle_linkids := project(Key_Vehicle_linkids_Records, transform(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_DID,
					SELF := LEFT,
					SELF := []));
							
	Vehicle_all := Temp_Vehicle_linkids+Key_Vehicle_did_Records;			
			
	Key_Vehicle_Party_Records_unsuppressed :=  
		JOIN(Vehicle_all, VehicleV2.Key_Vehicle_Party_Key,
		Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Party = TRUE AND
				KEYED(LEFT.vehicle_key = RIGHT.vehicle_key AND 
					LEFT.iteration_key = RIGHT.iteration_key AND
					LEFT.sequence_key = RIGHT.sequence_key),
				TRANSFORM(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Party_Key,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := RIGHT.source_code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := RIGHT.orig_state, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
				
	Key_Vehicle_Party_Records := Suppress.MAC_SuppressSource(Key_Vehicle_Party_Records_unsuppressed, mod_access, did_field := append_did, data_env := Environment);

	Key_Vehicle_Main_Records_unsuppressed :=  
		JOIN(Vehicle_all, VehicleV2.Key_Vehicle_Main_Key,
		Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Main = TRUE AND
				KEYED(LEFT.vehicle_key = RIGHT.vehicle_key AND 
					LEFT.iteration_key = RIGHT.iteration_key), 
				TRANSFORM({Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Main_Key, RECORDOF(LEFT)}, // including RECORDOF(LEFT) in this layout so that we can retain the DID for CCPA file suppressions
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.cleaned_brand_date_1 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_1)[1].result;
					SELF.cleaned_brand_date_2 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_2)[1].result;
					SELF.cleaned_brand_date_3 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_3)[1].result;
					SELF.cleaned_brand_date_4 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_4)[1].result;
					SELF.cleaned_brand_date_5 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_5)[1].result;
					SELF.Src := RIGHT.source_code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := RIGHT.state_origin, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

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
					SELF := []));	
					
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
														UCCV2.Key_LinkIds.kFetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
														PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
														0, /*ScoreThreshold --> 0 = Give me everything*/
														PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
														BIPV2.IDconstants.JoinTypes.LimitTransformJoin));
				
		With_UCC_Linkid_records := DENORMALIZE(With_Vehicle_Main_Records, UCC_LinkIds_Records,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UCC__Key_LinkIds_key := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_UCC__Key_LinkIds_key, 
									temp := If(LEFT.TMSID <> '', LEFT.TMSID,LEFT.RMSID);
									SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_UCCV2, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File,
																					Generic_Restriction := temp[1..3] IN PublicRecords_KEL.ECL_Functions.Constants.Marketing_Allowed3 OR temp[1..2] IN PublicRecords_KEL.ECL_Functions.Constants.Marketing_Allowed2),
									SELF := LEFT, 
									SELF := []));
					SELF := LEFT,
					SELF := []));

 // UCC Party RMSID
  
	UCC_Party_RMSID_Records := 
		Join(UCC_LinkIds_Records, UCCV2.Key_Rmsid_Party(),
			Common.DoFDCJoin_UCC_Files__Party_RMSID = TRUE AND
				KEYED(LEFT.tmsid = RIGHT.tmsid),
				TRANSFORM(Layouts_FDC.Layout_UCC__Key_RMSID_Party,
					SELF.G_ProcBusUID := LEFT.UniqueID,
					SELF.B_LexIDUlt := LEFT.ULTID,
					SELF.B_LexIDOrg := LEFT.ORGID,
					SELF.B_LexIDLegal := LEFT.SELEID,
					temp := If(RIGHT.TMSID <> '', RIGHT.TMSID,RIGHT.RMSID);
 					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_UCCV2, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, 
																					Generic_Restriction := temp[1..3] IN PublicRecords_KEL.ECL_Functions.Constants.Marketing_Allowed3 OR temp[1..2] IN PublicRecords_KEL.ECL_Functions.Constants.Marketing_Allowed2),
					SELF := RIGHT,
					SELF := []), 	
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
		
	With_UCC_RMSID_Party := DENORMALIZE(With_UCC_Linkid_records, UCC_Party_RMSID_Records,
			LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID AND 
			LEFT.B_LexIDUlt = RIGHT.B_LexIDUlt AND 
			LEFT.B_LexIDOrg = RIGHT.B_LexIDOrg AND 			
			LEFT.B_LexIDLegal = RIGHT.B_LexIDLegal, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UCC__Key_RMSID_Party := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

// UCC Main RMSID Data 
  
	UCC_RMSID_Main_Records := 
		Join(UCC_LinkIds_Records, UCCV2.Key_rmsid_main(),
			Common.DoFDCJoin_UCC_Files__Main_RMSID = TRUE AND
				KEYED(LEFT.tmsid = RIGHT.tmsid),
				TRANSFORM(Layouts_FDC.Layout_UCC__Key_RMSID_Main,
					SELF.G_ProcBusUID := LEFT.UniqueID,
					SELF.B_LexIDUlt := LEFT.ULTID,
					SELF.B_LexIDOrg := LEFT.ORGID,
					SELF.B_LexIDLegal := LEFT.SELEID,
 					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_UCCV2, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File,
																					Generic_Restriction := RIGHT.filing_jurisdiction IN PublicRecords_KEL.ECL_Functions.Constants.Marketing_Allowed_UCC),
					SELF := RIGHT,
					SELF := []), 	
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));
		
	With_UCC_RMSID_Main := DENORMALIZE(With_UCC_RMSID_Party, UCC_RMSID_Main_Records,
			LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID AND 
			LEFT.B_LexIDUlt = RIGHT.B_LexIDUlt AND 
			LEFT.B_LexIDOrg = RIGHT.B_LexIDOrg AND 			
			LEFT.B_LexIDLegal = RIGHT.B_LexIDLegal, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_UCC__Key_RMSID_Main := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	BBB2_kfetch_BBB_LinkIds := IF(Common.DoFDCJoin_BBB2__kfetch_BBB_LinkIds = TRUE, 
																							BBB2.Key_BBB_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_BBB2_Key_BBB_LinkIds := DENORMALIZE(With_UCC_RMSID_Main, BBB2_kfetch_BBB_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BBB2__kfetch_BBB_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BBB2__kfetch_BBB_LinkIds, 
																						self.src := MDR.sourceTools.src_BBB_Member, 
																						SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																						self := left, 
																						self := []));
					SELF := LEFT,
					SELF := []));

	BBB2_kfetch_BBB_Non_Member_LinkIds := IF(Common.DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds = TRUE, 
																							BBB2.Key_BBB_Non_Member_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																									PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																									0, /*ScoreThreshold --> 0 = Give me everything*/
																									PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																									BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_BBB2_Key_BBB_Non_Member_LinkIds := DENORMALIZE(With_BBB2_Key_BBB_LinkIds, BBB2_kfetch_BBB_Non_Member_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BBB2__kfetch_BBB_Non_Member_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BBB2__kfetch_BBB_Non_Member_LinkIds, 
																						self.src := MDR.sourceTools.src_BBB_Non_Member, 
																						SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																						self := left, 
																						self := []));
					SELF := LEFT,
					SELF := []));
	
	BusReg__kfetch_busreg_company_linkids := IF(Common.DoFDCJoin_BusReg__kfetch_busreg_company_linkids = TRUE, 
																						BusReg.key_busreg_company_linkids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

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
																	SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																	self := left, 
																	self := []));
					SELF := LEFT,
					SELF := []));

	CalBus__kfetch_Calbus_LinkIDS := IF(Common.DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS = TRUE, 
																						CalBus.Key_Calbus_LinkIDS.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_CalBus_key_Calbus_LinkIDS := DENORMALIZE(With_BusReg_key_busreg_company_linkids, CalBus__kfetch_Calbus_LinkIDS,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_CalBus__kfetch_Calbus_LinkIDS := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_CalBus__kfetch_Calbus_LinkIDS, 
																		self.src := MDR.sourceTools.src_CalBus, 
																		SELF.naics_code := CleanNAIC(LEFT.naics_code),
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																		self := left,
																		self := []));
					SELF := LEFT,
					SELF := []));
					


		Cortera__kfetch_LinkID_temp := IF(Common.DoFDCJoin_Cortera__kfetch_LinkID = TRUE, 
																						Cortera.Key_LinkIDs.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

		
	Cortera__kfetch_LinkID := Cortera__kfetch_LinkID_temp(SeleID NOT IN Set_Large_Cortera_SeleIDs);
	
	With_Cortera_Key_LinkIDs := DENORMALIZE(With_CalBus_key_Calbus_LinkIDS, Cortera__kfetch_LinkID,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Cortera__kfetch_LinkID := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Cortera__kfetch_LinkID, 
																		self.src := MDR.sourceTools.src_Cortera, 
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																		self := left, 
																		self := []));
					SELF := LEFT,
					SELF := []));				
					
	DCAV2__kfetch_LinkIds := IF(Common.DoFDCJoin_DCAV2__kfetch_LinkIds = TRUE, 
																						DCAV2.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_DCAV2_Key_LinkIds := DENORMALIZE(With_Cortera_Key_LinkIDs, DCAV2__kfetch_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_DCAV2__kfetch_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_DCAV2__kfetch_LinkIds, 
																		self.src := MDR.sourceTools.src_DCA, 
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
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
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	

	With_EBR_Key_5600_Demographic_Data_linkids := DENORMALIZE(With_DCAV2_Key_LinkIds, EBR_kfetch_5600_Demographic_Data_linkids,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_EBR_kfetch_5600_Demographic_Data_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_EBR_kfetch_5600_Demographic_Data_linkids, 
																	self.src := MDR.sourceTools.src_EBR, 
																	SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																					
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
																						 	FBNv2.Key_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),mod_access,
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_FBNv2__Key_LinkIds := DENORMALIZE(With_EBR_Key_5600_Demographic_Data_linkids, FBNv2__kfetch_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_FBNv2__kfetch_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_FBNv2__kfetch_LinkIds, 
															  SELF.SIC_Code := CleanSIC(LEFT.SIC_Code),
																self.src := MDR.sourceTools.src_FBNV2_BusReg, 
																SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																self := left, 
																self := []));
					SELF := LEFT,
					SELF := []));			
					
	GovData__kfetch_IRS_NonProfit_linkIDs := IF(Common.DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs = TRUE, 
																						 	GovData.key_IRS_NonProfit_linkIDs.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_GovData_key_IRS_NonProfit_linkIDs := DENORMALIZE(With_FBNv2__Key_LinkIds, GovData__kfetch_IRS_NonProfit_linkIDs,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_GovData__kfetch_IRS_NonProfit_linkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_GovData__kfetch_IRS_NonProfit_linkIDs, 
																self.src := MDR.sourceTools.src_IRS_Non_Profit, 
																SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																SELF.Reported_Earnings := (INTEGER)TRIM((STD.Str.Filter(LEFT.Negative_Rev_Amount, '-') + (STRING)LEFT.Form_990_Revenue_Amount), ALL);
																self := left, 
																self := []));
					SELF := LEFT,
					SELF := []));								

	IRS5500__kfetch_LinkID := IF(Common.DoFDCJoin_IRS5500__kfetch_LinkIDs = TRUE, 
																						 IRS5500.Key_LinkIDs.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_IRS5500_Key_LinkIDs := DENORMALIZE(With_GovData_key_IRS_NonProfit_linkIDs, IRS5500__kfetch_LinkID,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_IRS5500__kfetch_LinkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_IRS5500__kfetch_LinkIDs, 
																self.src := MDR.sourceTools.src_IRS_5500, 
																SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																self := left, 
																self := []));
					SELF := LEFT,
					SELF := []));								

	OSHAIR__kfetch_OSHAIR_LinkIds := IF(Common.DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds = TRUE, 
																						 OSHAIR.Key_OSHAIR_LinkIds.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_OSHAIR_Key_OSHAIR_LinkIds := DENORMALIZE(With_IRS5500_Key_LinkIDs, OSHAIR__kfetch_OSHAIR_LinkIds,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_OSHAIR__kfetch_OSHAIR_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_OSHAIR__kfetch_OSHAIR_LinkIds, 
																		self.src := MDR.sourceTools.src_OSHAIR, 
																		SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
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
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_SAM_key_linkID := DENORMALIZE(With_OSHAIR_Key_OSHAIR_LinkIds, SAM__kfetch_linkID,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_SAM__kfetch_linkID := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_SAM__kfetch_linkID, 
																	self.src := MDR.sourceTools.src_SAM_Gov_Debarred, 
																	SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																	self := left, 
																	self := []));
					SELF := LEFT,
					SELF := []));				
	
	YellowPages__kfetch_yellowpages_linkids := IF(Common.DoFDCJoin_YellowPages__kfetch_yellowpages_linkids = TRUE, 
																						YellowPages.key_yellowpages_linkids.kfetch2(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT,
																								BIPV2.IDconstants.JoinTypes.LimitTransformJoin));	
																								
	With_YellowPages_key_yellowpages_linkids := DENORMALIZE(With_SAM_key_linkID, YellowPages__kfetch_yellowpages_linkids,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_YellowPages__kfetch_yellowpages_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_YellowPages__kfetch_yellowpages_linkids, 
																					self.src := MDR.sourceTools.src_Yellow_Pages, 
																					SELF.DPMBitmap := SetDPMBitmap( Source := self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																					SELF.SIC_Code := CleanSIC(LEFT.SIC_Code);
																					SELF.sic2 := CleanSIC(LEFT.sic2);
																					SELF.sic3 := CleanSIC(LEFT.sic3);
																					SELF.sic4 := CleanSIC(LEFT.sic4);
																					SELF.NAICs_Code := CleanNAIC(LEFT.NAICs_Code);
																					self := left, 
																					self := []));
					SELF := LEFT,
					SELF := []));				
		
	Infutor__NARB_kfetch_LinkIds := IF(Common.DoFDCJoin_Infutor__NARB_kfetch_LinkIds = TRUE, 
																						dx_Infutor_NARB.Key_Linkids.kfetch(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0)); /*ScoreThreshold --> 0 = Give me everything*/	
		
	
	PublicRecords_KEL.ECL_Functions.Common_Functions.AppendSeq(Infutor__NARB_kfetch_LinkIds, Input_FDC,Temp_infutor_narb,PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID);
	
	With_Infutor_NARB_Key_LinkIds := DENORMALIZE(With_YellowPages_key_yellowpages_linkids, Temp_infutor_narb,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Layout_Infutor_NARB__kfetch_LinkIds := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Infutor_NARB__kfetch_LinkIds, 
																						self.src := LEFT.Source, //not set to mdr source tools on vault
																						SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																						SELF.sic1 := CleanSIC(LEFT.sic1);
																						SELF.sic2 := CleanSIC(LEFT.sic2);
																						SELF.sic3 := CleanSIC(LEFT.sic3);
																						SELF.sic4 := CleanSIC(LEFT.sic4);
																						SELF.sic5 := CleanSIC(LEFT.sic5);
																						self := left, self := []));
					SELF := LEFT,
					SELF := []));		

	Equifax__Business_Data_kfetch_LinkIDs := IF(Common.DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs = TRUE, 
																						dx_Equifax_Business_Data.Key_LinkIDs.kfetch(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
																								0)); /*ScoreThreshold --> 0 = Give me everything*/	
		
	PublicRecords_KEL.ECL_Functions.Common_Functions.AppendSeq(Equifax__Business_Data_kfetch_LinkIDs, Input_FDC,Temp_Equifax,PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID);
																					
	With_Equifax_Business_Data_Key_LinkIDs := DENORMALIZE(With_Infutor_NARB_Key_LinkIds, Temp_Equifax,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Equifax_Business__Data_kfetch_LinkIDs := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_Equifax_Business__Data_kfetch_LinkIDs,
																						self.src := MDR.sourceTools.src_Equifax_Business_Data, 
																						SELF.DPMBitmap := SetDPMBitmap( Source := Self.src, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
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
	
	BIPV2_Build__kfetch_contact_linkids := IF(Common.DoFDCJoin_BIPV2_Build__kfetch_contact_linkids = TRUE, 
																						BIPV2_Build.key_contact_linkids.kfetch(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.ProxID),
																								0,
																								linkingOptions,
																								PublicRecords_KEL.ECL_Functions.Constants.Business_Header_LIMIT,					
																								false)); /*ScoreThreshold --> 0 = Give me everything*/	
																								
	PublicRecords_KEL.ECL_Functions.Common_Functions.AppendSeq(BIPV2_Build__kfetch_contact_linkids, Input_FDC, Temp_Bus_contact, PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.ProxID);
	
	With_BIPV2_Build_contact_linkids := DENORMALIZE(With_Equifax_Business_Data_Key_LinkIDs, Temp_Bus_contact,
			LEFT.G_ProcBusUID = RIGHT.UniqueID AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 			
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2_Build__kfetch_contact_linkids := project(ROWS(RIGHT),transform(Layouts_FDC.Layout_BIPV2_Build__kfetch_contact_linkids,  
																						self.src := LEFT.Source, //many sources in business header
																						SELF.DPMBitmap := SetDPMBitmap( Source := LEFT.Source, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),																				
																						SELF.JobTitle := IF(TRIM(LEFT.contact_job_title_derived) != '', TRIM(LEFT.contact_job_title_derived), TRIM(LEFT.contact_job_title_raw)),//use derived if its populated else use raw
																						SELF.Status := IF(TRIM(LEFT.contact_status_derived) != '', TRIM(LEFT.contact_status_derived), TRIM(LEFT.contact_status_raw)),//use derived if its populated else use raw
																						self := left, 
																						self := []));
					SELF := LEFT,
					SELF := []));		
						
	BIPV2.IDAppendLayouts.AppendInput PrepBIPInput(Layouts_FDC.Layout_FDC le) := TRANSFORM
    SELF.request_id := le.G_ProcBusUID;
    SELF.proxid := le.B_LexIDSite;
    SELF.seleid := le.B_LexIDLegal;
		SELF := []
	END;
	
	BIPBestInput := PROJECT(Input_FDC(B_LexIDSite > 0 OR B_LexIDLegal > 0), PrepBIPInput(LEFT));

	BIP_Best_Records_Raw := IF(Common.DoFDCJoin_BIPV2_Best__Key_LinkIds,
										BIPV2.IdAppendRoxie(BIPBestInput, ReAppend := FALSE).WithBest(
												fetchLevel := BIPV2.IdConstants.fetch_level_seleid, 
												allBest := TRUE,
												isMarketing := Options.isMarketing));

	BIP_Best_Records := JOIN(Input_FDC, BIP_Best_Records_Raw, 
		LEFT.G_ProcBusUID = RIGHT.Request_ID,
		TRANSFORM(Layouts_FDC.Layout_BIPV2_Best__Key_LinkIds,
				SELF.G_ProcBusUID := LEFT.G_ProcBusUID,
				SELF.B_LexIDUlt := LEFT.B_LexIDUlt,
				SELF.B_LexIDOrg := LEFT.B_LexIDOrg,
				SELF.B_LexIDLegal := LEFT.B_LexIDLegal,		
				SELF.Company_SIC_Code1 := CleanSIC(RIGHT.Company_SIC_Code1),
				SELF.Company_NAICS_Code1 := CleanNAIC(RIGHT.Company_NAICS_Code1),
				SELF.Src := MDR.sourceTools.src_Best_Business,
				SELF.DPMBitmap := SetDPMBitmap( Source := '', FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, BIPBitMask := CFG_File.Permit_NonFCRA),
				SELF := RIGHT,
				SELF := []));
				
	With_BIP_Best_Records := DENORMALIZE(With_BIPV2_Build_contact_linkids, BIP_Best_Records,
			LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID AND 
			LEFT.B_LexIDUlt = RIGHT.B_LexIDUlt AND 
			LEFT.B_LexIDOrg = RIGHT.B_LexIDOrg AND 			
			LEFT.B_LexIDLegal = RIGHT.B_LexIDLegal, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2_Best__Key_LinkIds := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));
					
	Key_Gong_History_LinkID_Records := 
			IF(Common.DoFDCJoin_Gong__Key_History_LinkIds = TRUE, 
				Gong.Key_History_LinkIds.kfetch2(
						PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(Input_FDC),
						mod_access, // CCPA suppression
						PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(PublicRecords_KEL.ECL_Functions.Constants.LinkSearch.SeleID),
						0, /*ScoreThreshold --> 0 = Give me everything*/
						PublicRecords_KEL.ECL_Functions.Constants.Business_Header_LIMIT,
						BIPV2.IDconstants.JoinTypes.LimitTransformJoin ) );

	With_Gong_History_LinkID_Records := DENORMALIZE(With_BIP_Best_Records, Key_Gong_History_LinkID_Records,	
			LEFT.G_ProcBusUID = RIGHT.UniqueID  AND 
			LEFT.B_LexIDUlt = RIGHT.ULTID AND 
			LEFT.B_LexIDOrg = RIGHT.ORGID AND 
			LEFT.B_LexIDLegal = RIGHT.SELEID, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Gong__Key_History_LinkIds := 
							PROJECT( ROWS(RIGHT), TRANSFORM(Layouts_FDC.Layout_Gong__Key_History_LinkIds, 
								SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Gong_History, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
								SELF.src := MDR.sourceTools.src_Gong_History, //many sources in business header
								SELF.Listing_Type := TRIM(RIGHT.Listing_Type_Bus + RIGHT.Listing_Type_Res + RIGHT.Listing_Type_Gov, ALL);
								SELF := LEFT, 
								SELF := [])),
					SELF := LEFT,
					SELF := []));
	
					
	RETURN With_Gong_History_LinkID_Records;

END;

