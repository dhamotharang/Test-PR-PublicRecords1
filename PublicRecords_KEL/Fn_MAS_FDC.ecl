IMPORT BankruptcyV3, BIPV2, Cortera_Tradeline, dx_header, Doxie_Files, FAA, Header, Header_Quick, 
		MDR, VehicleV2, Watercraft, data_services;

EXPORT Fn_MAS_FDC(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) Input,
									PublicRecords_KEL.Interface_Options Options,
									DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput = DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII)
									) := FUNCTION
/* 
    The following data sources are represented in the Federated Data Composite (FDC) below:
      -  Consumer Header
      -  Criminal Records
      -  Bankruptcy
      -  Aircraft
      -  Vehicle
      -  Watercraft
      -  Business Header
      -  Tradeline (Cortera)
*/
  unsigned1 iType := IF(Options.IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);
  
	Layouts_FDC     := PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options);
	Common          := PublicRecords_KEL.ECL_Functions.Common(Options);
	CFG_File        := PublicRecords_KEL.CFG_Compile;
	Regulated       := TRUE;
	NotRegulated    := FALSE;
	BlankString     := '';
	SetDPMBitmap    := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue;

	// Records from GLB sources might NOT be GLBA Regulated depending on if they are older than GLBA Laws
	PreGLBRegulatedRecord(STRING Source_Column, UNSIGNED3 Date_Last_Seen_Column, UNSIGNED3 Date_First_Seen_Column) := 
				Source_Column IN MDR.SourceTools.set_GLB AND Header.isPreGLB_LIB(Date_Last_Seen_Column, Date_First_Seen_Column, Source_Column, '00000000000000000000000000000000000000000000000000');

	// Additionally records from certain states are not allowed to be used unless we have a DPPA in a specific set of values
	GetDPPAState(STRING Source_Column) := MDR.SourceTools.DPPAOriginState(Source_Column);

	// Data cleaning functions needed to get raw data ready for KEL
	Doxie_Files__Key_Offenders_Src(STRING data_type) := CASE(data_type,
				'1' => 'DC',
				'2' => 'CC',
				'5' => 'AL',
					'');
					
	// Now put together the FDC bundle				
	Input_FDC := JOIN(Input, BusinessInput, 
						LEFT.BusInputUIDAppend = RIGHT.BusInputUIDAppend, 
						TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.InputUIDAppend := LEFT.InputUIDAppend,
						SELF.LexIDAppend := LEFT.LexIDAppend,
						SELF.BusInputUIDAppend := RIGHT.BusInputUIDAppend,
						SELF.LexIDBusExtendedFamilyAppend := RIGHT.LexIDBusExtendedFamilyAppend,
						SELF.LexIDBusLegalFamilyAppend := RIGHT.LexIDBusLegalFamilyAppend,
						SELF.LexIDBusLegalEntityAppend := RIGHT.LexIDBusLegalEntityAppend,
						SELF := []), FULL OUTER );
	Input_FDC_Filtered := Input_FDC((LexIDBusExtendedFamilyAppend > 0 and LexIDBusLegalFamilyAppend > 0 and LexIDBusLegalEntityAppend > 0) or LexIDAppend > 0);	
		
	/* **************************************************************************
			
																CONSUMER SECTION

	************************************************************************** */

	// FCRA/NonFCRA have the same layout.
	Doxie__Key_Header := dx_header.key_header(iType);
	Doxie__Key_Header_Records := IF(Common.DoFDCJoin_Doxie__Key_Header,
		JOIN(Input_FDC_Filtered, Doxie__Key_Header,
				KEYED(LEFT.LexIDAppend = (UNSIGNED)RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Header,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(RIGHT.Src, RIGHT.dt_nonglb_last_seen, RIGHT.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(RIGHT.src), KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Doxie__Key_Header));

					
	With_Doxie__Key_Header := DENORMALIZE(Input_FDC, Doxie__Key_Header_Records,
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie__Key_Header := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
						
	// Header_Quick.Key_Did_FCRA/Header_Quick.Key_Did. FCRA/NonFCRA have the same layout.
	Header_Quick__Key_Did := IF(Options.IsFCRA, Header_Quick.Key_Did_FCRA, Header_Quick.Key_Did);
	Header_Quick__Key_Did_Records := IF(Common.DoFDCJoin_Header_Quick__Key_Did,
		JOIN(Input_FDC_Filtered, Header_Quick__Key_Did,
				KEYED(LEFT.LexIDAppend = (UNSIGNED)RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Header_Quick__Key_Did,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(RIGHT.Src, RIGHT.dt_nonglb_last_seen, RIGHT.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(RIGHT.Src), KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Header_Quick__Key_Did));

					
	With_Header_Quick__Key_Did := DENORMALIZE(With_Doxie__Key_Header, Header_Quick__Key_Did_Records,
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Header_Quick__Key_Did := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// --------------------[ Criminal records ]--------------------
	
	// Doxie_Files.Key_BocaShell_Crim_FCRA -- FCRA only
	Doxie_Files__Key_BocaShell_Crim_FCRA_Records := IF(Common.DoFDCJoin_Doxie_Files__Key_BocaShell_Crim_FCRA, 
		JOIN(Input_FDC_Filtered, Doxie_Files.Key_BocaShell_Crim_FCRA,
				KEYED(LEFT.LexIDAppend = RIGHT.DID),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_BocaShell_Crim_FCRA_Denorm,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := TRUE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Doxie_Files__Key_BocaShell_Crim_FCRA_Denorm));
		
	// Doxie_Files.Key_BocaShell_Crim_FCRA contains a child dataset so we need to add an extra step and NORMALIZE it before adding to the FDC bundle.
	Doxie_Files__Key_BocaShell_Crim_FCRA_Records_Norm := NORMALIZE(Doxie_Files__Key_BocaShell_Crim_FCRA_Records, LEFT.criminal_count, 
			TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_BocaShell_Crim_FCRA,
								SELF := LEFT,
								SELF := RIGHT));
					
	With_Doxie_Files__Key_BocaShell_Crim_FCRA := DENORMALIZE(With_Header_Quick__Key_Did, Doxie_Files__Key_BocaShell_Crim_FCRA_Records_Norm, 
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
						
	// Doxie_Files.Key_Offenders(isFCRA) --  FCRA and NonFCRA	
	Doxie_Files__Key_Offenders_Records := IF(Common.DoFDCJoin_Doxie_Files__Key_Offenders,
		JOIN(Input_FDC_Filtered, Doxie_Files.Key_Offenders(Options.isFCRA),
				KEYED(LEFT.LexIDAppend = (UNSIGNED)RIGHT.sdid),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenders,
					_src := Doxie_Files__Key_Offenders_Src(RIGHT.data_type);
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.fcra_date := IF( Options.isFCRA = TRUE, RIGHT.fcra_date, '' ), // populate only if using the FCRA key
					SELF.data_type := IF( Options.isFCRA = TRUE, RIGHT.data_type, '' ), // populate only if using the FCRA key
					SELF.src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Doxie_Files__Key_Offenders));

					
	With_Doxie_Files__Key_Offenders := DENORMALIZE(With_Doxie_Files__Key_BocaShell_Crim_FCRA, Doxie_Files__Key_Offenders_Records,
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenders := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
						
	// Doxie_files.Key_Court_Offenses -- FCRA only (even though nonFCRA version of key exists)
	// Doxie_files.Key_Court_Offenses does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_FCRA_Records so we can join by offender key
	Doxie_files__Key_Court_Offenses_Records := IF(Common.DoFDCJoin_Doxie_files__Key_Court_Offenses,
			JOIN(Doxie_Files__Key_Offenders_Records, Doxie_files.Key_Court_Offenses(isFCRA := Options.isFCRA),
				KEYED(LEFT.offender_key = RIGHT.ofk),
				TRANSFORM(Layouts_FDC.Layout_Doxie_files__Key_Court_Offenses,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.Src := MDR.sourceTools.src_Accurint_Crim_Court,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_Crim_Court, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Doxie_files__Key_Court_Offenses));
					
	With_Doxie_files__Key_Court_Offenses := DENORMALIZE(With_Doxie_Files__Key_Offenders, Doxie_files__Key_Court_Offenses_Records,
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_files__Key_Court_Offenses := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
						
	// Doxie_Files.Key_Offenses -- FCRA only (even though nonFCRA version of key exists)
	// Doxie_files.Key_Offenses does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_Records so we can join by offender key
	Doxie_Files__Key_Offenses_Records := IF(Common.DoFDCJoin_Doxie_Files__Key_Offenses,
			JOIN(Doxie_Files__Key_Offenders_Records, Doxie_Files.Key_Offenses(isFCRA := Options.isFCRA),
				KEYED(LEFT.offender_key = RIGHT.ok),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenses,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.Src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Doxie_Files__Key_Offenses));
					
	With_Doxie_Files__Key_Offenses := DENORMALIZE(With_Doxie_files__Key_Court_Offenses, Doxie_Files__Key_Offenses_Records,
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenses := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));

	// Doxie_Files.Key_Offenders_Risk -- NonFCRA only
	Doxie_Files__Key_Offenders_Risk_Records := IF(Common.DoFDCJoin_Doxie_Files__Key_Offenders_Risk,
			JOIN(Input_FDC_Filtered, Doxie_Files.Key_Offenders_Risk,
				KEYED(LEFT.LexIDAppend = RIGHT.sdid),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Offenders_Risk,
					_src := Doxie_Files__Key_Offenders_Src(RIGHT.data_type);
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.src := _src,
					SELF.DPMBitmap := SetDPMBitmap( Source := _src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Doxie_Files__Key_Offenders_Risk));
		
	With_Doxie_Files__Key_Offenders_Risk := DENORMALIZE(With_Doxie_Files__Key_Offenses, Doxie_Files__Key_Offenders_Risk_Records,
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Offenders_Risk := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		

	// Doxie_Files.Key_Punishment -- NonFCRA only (even though FCRA version of key exists)
	// Doxie_Files.Key_Punishment does not contain a DID, so JOIN with Doxie_Files__Key_Offenders_Records so we can join by offender key
	Doxie_Files__Key_Punishment_Records := IF(Common.DoFDCJoin_Doxie_Files__Key_Punishment,
			JOIN(Doxie_Files__Key_Offenders_Records, Doxie_Files.Key_Punishment(isFCRA := Options.isFCRA),
				KEYED(LEFT.offender_key = RIGHT.ok),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_Punishment,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.Src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Doxie_Files__Key_Punishment));
		
	With_Doxie_Files__Key_Punishment := DENORMALIZE(With_Doxie_Files__Key_Offenders_Risk, Doxie_Files__Key_Punishment_Records,
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Punishment := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		
						
	// --------------------[ Bankruptcy records ]--------------------
	
	// BankruptcyV3.key_bankruptcyV3_did has a parameter to say if FCRA or nonFCRA - same file layout
	Bankruptcy_Files__Key_bankruptcy_did_Records := IF( Common.DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did, 
			JOIN(Input_FDC_Filtered, BankruptcyV3.key_bankruptcyV3_did(Options.isFCRA),
				KEYED(LEFT.LexIDAppend = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Bankruptcy__Key_did,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
			DATASET([], Layouts_FDC.Layout_Bankruptcy__Key_did));

	// BankruptcyV3.key_bankruptcyv3_search_full_bip has a parameter to say if FCRA or nonFCRA - same file layout		
	Bankruptcy_Files__Key_Search_Records_pre := IF( Common.DoFDCJoin_Bankruptcy_Files__Bankruptcy__Key_Search,
		JOIN(Bankruptcy_Files__Key_bankruptcy_did_Records, BankruptcyV3.key_bankruptcyv3_search_full_bip(Options.isFCRA),
				KEYED(LEFT.TmsID != '' AND 
				LEFT.TmsID = RIGHT.TmsID) AND
				LEFT.court_code = RIGHT.court_code AND
				LEFT.case_number = RIGHT.case_number,
				TRANSFORM(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.Src := MDR.sourceTools.src_Bankruptcy,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Bankruptcy, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
			DATASET([], Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search));

	// Left Only join to the Bankruptcy Withdrawn key to remove all Withdrawn records.
	Bankruptcy_Files__Key_Search_Records := IF( Common.DoFDCJoin_Bankruptcy_Files__Bankruptcy__Key_Search,
		JOIN(Bankruptcy_Files__Key_Search_Records_pre, BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,Options.IsFCRA),
				KEYED(LEFT.TmsID = RIGHT.TmsID),
				TRANSFORM(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF := LEFT, 
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT),
				LEFT ONLY),
			DATASET([], Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search));
		
	With_Bankruptcy := 
		DENORMALIZE(With_Doxie_Files__Key_Punishment,Bankruptcy_Files__Key_Search_Records,
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Bankruptcy_Files__Key_Search := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));	

	// --------------------[ Aircraft records ]--------------------

	// FAA.key_aircraft_did has a parameter to say if FCRA or nonFCRA - same file layout
	Key_Aircraft_did_Records := IF( Common.DoFDCJoin_Aircraft_Files__FAA__Aircraft_did, 
			JOIN(Input_FDC_Filtered, FAA.key_aircraft_did(Options.isFCRA),
				KEYED(LEFT.LexIDAppend = RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_FAA__key_aircraft_did,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
			DATASET([], Layouts_FDC.Layout_FAA__key_aircraft_did));

	// FAA.key_aircraft_id has a parameter to say if FCRA or nonFCRA - same file layout		
	Key_Aircraft_ID_Records := IF( Common.DoFDCJoin_Aircraft_Files__FAA__Aircraft_ID,
		JOIN(Key_Aircraft_did_Records, FAA.key_aircraft_id(Options.isFCRA),
				KEYED(LEFT.aircraft_id != 0 AND 
				LEFT.aircraft_id = RIGHT.aircraft_id),
				TRANSFORM(Layouts_FDC.Layout_FAA__key_aircraft_id,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.Src := MDR.sourceTools.src_Aircrafts,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Aircrafts, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
			DATASET([], Layouts_FDC.Layout_FAA__key_aircraft_id));

	With_Aircraft_ID_Records := DENORMALIZE(With_Bankruptcy, Key_Aircraft_ID_Records,
      LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
      TRANSFORM(Layouts_FDC.Layout_FDC,
          SELF.Dataset_FAA__Key_Aircraft_IDs := ROWS(RIGHT),
          SELF := LEFT,
          SELF := []));	

	// --------------------[ Vehicle records ]--------------------

	Key_Vehicle_did_Records := IF( Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID, 
			JOIN(Input_FDC_Filtered, VehicleV2.Key_Vehicle_DID,
				KEYED(LEFT.LexIDAppend = RIGHT.append_did),
				TRANSFORM(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_DID,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
			DATASET([], Layouts_FDC.Layout_VehicleV2__Key_Vehicle_DID));

	Key_Vehicle_Party_Records := IF( Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Party,
		JOIN(Key_Vehicle_did_Records, VehicleV2.Key_Vehicle_Party_Key,
        KEYED(LEFT.vehicle_key = RIGHT.vehicle_key AND 
          LEFT.iteration_key = RIGHT.iteration_key AND
          LEFT.sequence_key = RIGHT.sequence_key),
				TRANSFORM(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Party_Key,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.Src := RIGHT.source_code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := RIGHT.orig_state, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
			DATASET([], Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Party_Key));

	Key_Vehicle_Main_Records := IF( Common.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Main,
		JOIN(Key_Vehicle_did_Records, VehicleV2.Key_Vehicle_Main_Key,
        KEYED(LEFT.vehicle_key = RIGHT.vehicle_key AND 
          LEFT.iteration_key = RIGHT.iteration_key) AND
          RIGHT.orig_vin != '',
				TRANSFORM(Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Main_Key,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.cleaned_brand_date_1 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_1)[1].result;
					SELF.cleaned_brand_date_2 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_2)[1].result;
					SELF.cleaned_brand_date_3 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_3)[1].result;
					SELF.cleaned_brand_date_4 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_4)[1].result;
					SELF.cleaned_brand_date_5 := (STRING)PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(RIGHT.brand_date_5)[1].result;
					SELF.Src := RIGHT.source_code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := FALSE, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := Regulated, DPPA_State := RIGHT.state_origin, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
			DATASET([], Layouts_FDC.Layout_VehicleV2__Key_Vehicle_Main_Key));
  
	With_Vehicle_Party_Records := DENORMALIZE(With_Aircraft_ID_Records, Key_Vehicle_Party_Records,
      LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
      TRANSFORM(Layouts_FDC.Layout_FDC,
          SELF.Dataset_VehicleV2__Key_Vehicle_Party_Key := ROWS(RIGHT),
          SELF := LEFT,
          SELF := []));	

	With_Vehicle_Main_Records := DENORMALIZE(With_Vehicle_Party_Records, Key_Vehicle_Main_Records,
      LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
      TRANSFORM(Layouts_FDC.Layout_FDC,
          SELF.Dataset_VehicleV2__Key_Vehicle_Main_Key := ROWS(RIGHT),
          SELF := LEFT,
          SELF := []));	
  
	// --------------------[ Watercraft records ]--------------------

	// Watercraft.key_watercraft_did has a parameter to say if FCRA or nonFCRA - same file layout
	Key_Watercraft_did_Records := IF( Common.DoFDCJoin_Watercraft_Files__Watercraft_DID, 
			JOIN(Input_FDC_Filtered, Watercraft.key_watercraft_did(Options.isFCRA),
				KEYED(LEFT.LexIDAppend = RIGHT.l_did),
				TRANSFORM(Layouts_FDC.Layout_Watercraft__key_watercraft_DID,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF := RIGHT, 
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
			DATASET([], Layouts_FDC.Layout_Watercraft__key_watercraft_DID));

	// Watercraft.key_watercraft_sid has a parameter to say if FCRA or nonFCRA - same file layout		
	//
	// See WatercraftV2_Services.get_owner_records for other possible Join restrictions/criteria.
	//
	Key_Watercraft_sid_Records := IF( Common.DoFDCJoin_Watercraft_Files__Watercraft_SID,
		JOIN(Key_Watercraft_did_Records, Watercraft.key_watercraft_sid(Options.isFCRA),
					KEYED(LEFT.watercraft_key = RIGHT.watercraft_key) AND
					KEYED(LEFT.sequence_key = '' OR LEFT.sequence_key = RIGHT.sequence_key) AND
					KEYED(LEFT.state_origin = '' OR LEFT.state_origin = RIGHT.state_origin),
				TRANSFORM(Layouts_FDC.Layout_Watercraft__Key_Watercraft_SID,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.Src := RIGHT.source_code,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.source_code, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
			DATASET([], Layouts_FDC.Layout_Watercraft__Key_Watercraft_SID));

	With_Watercraft_Records := DENORMALIZE(With_Vehicle_Main_Records, Key_Watercraft_sid_Records,
      LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
      TRANSFORM(Layouts_FDC.Layout_FDC,
          SELF.Dataset_Watercraft__Key_Watercraft_SID := ROWS(RIGHT),
          SELF := LEFT,
          SELF := []));	

	/* **************************************************************************
			
																BUSINESS SECTION

	************************************************************************** */
  
	// --------------------[ Business Header records ]--------------------
  
	Business_Header_Key_Linking := if(Common.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids,
		Join(Input_FDC_Filtered, BIPV2.Key_BH_Linking_Ids.key,
				KEYED(
				LEFT.LexIDBusExtendedFamilyAppend = RIGHT.ultid and 
				LEFT.LexIDBusLegalFamilyAppend = RIGHT.orgid and
				LEFT.LexIDBusLegalEntityAppend = RIGHT.seleid),
				TRANSFORM(Layouts_FDC.Layout_BIPV2__Key_BH_Linking_Ids,
					SELF.BusInputUIDAppend := LEFT.BusInputUIDAppend,
					SELF.LexIDBusExtendedFamilyAppend := LEFT.LexIDBusExtendedFamilyAppend,
					SELF.LexIDBusLegalFamilyAppend := LEFT.LexIDBusLegalFamilyAppend,
					SELF.LexIDBusLegalEntityAppend := LEFT.LexIDBusLegalEntityAppend,
					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := PreGLBRegulatedRecord(RIGHT.Source, 0, RIGHT.dt_first_seen), DPPA_Restricted := NotRegulated, DPPA_State := GetDPPAState(RIGHT.source), KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 	
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Business_Header_LIMIT)),
		DATASET([], Layouts_FDC.Layout_BIPV2__Key_BH_Linking_Ids));
		
	With_Business_Header_Key_Linking := DENORMALIZE(With_Watercraft_Records, Business_Header_Key_Linking,
			LEFT.BusInputUIDAppend = RIGHT.BusInputUIDAppend AND 
			LEFT.LexIDBusExtendedFamilyAppend = RIGHT.LexIDBusExtendedFamilyAppend AND 
			LEFT.LexIDBusLegalFamilyAppend = RIGHT.LexIDBusLegalFamilyAppend AND 
			LEFT.LexIDBusLegalEntityAppend = RIGHT.LexIDBusLegalEntityAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_BIPV2__Key_BH_Linking_Ids := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));

	// --------------------[ Tradeline records ]--------------------
  
	Tradeline_Key_LinkIds := if(Common.DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds,
		Join(Input_FDC_Filtered, Cortera_Tradeline.Key_LinkIds.Key,
				KEYED(
				LEFT.LexIDBusExtendedFamilyAppend = RIGHT.ultid and 
				LEFT.LexIDBusLegalFamilyAppend = RIGHT.orgid and				
				LEFT.LexIDBusLegalEntityAppend = RIGHT.seleid),
				TRANSFORM(Layouts_FDC.Layout_Cortera_Tradeline__Key_LinkIds,
					SELF.BusInputUIDAppend := LEFT.BusInputUIDAppend,
					SELF.LexIDBusExtendedFamilyAppend := LEFT.LexIDBusExtendedFamilyAppend,
					SELF.LexIDBusLegalFamilyAppend := LEFT.LexIDBusLegalFamilyAppend,
					SELF.LexIDBusLegalEntityAppend := LEFT.LexIDBusLegalEntityAppend,
 					SELF.DPMBitmap := SetDPMBitmap( Source := RIGHT.Source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF := RIGHT,
					SELF := []), 	
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.CORTERA_TRADELINE_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Cortera_Tradeline__Key_LinkIds));
		
	With_Tradeline_Key_LinkIds := DENORMALIZE(With_Business_Header_Key_Linking, Tradeline_Key_LinkIds,
			LEFT.BusInputUIDAppend = RIGHT.BusInputUIDAppend AND 
			LEFT.LexIDBusExtendedFamilyAppend = RIGHT.LexIDBusExtendedFamilyAppend AND 
			LEFT.LexIDBusLegalFamilyAppend = RIGHT.LexIDBusLegalFamilyAppend AND 			
			LEFT.LexIDBusLegalEntityAppend = RIGHT.LexIDBusLegalEntityAppend, GROUP,
			TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.Dataset_Cortera_Tradeline__Key_LinkIds := ROWS(RIGHT),
					SELF := LEFT,
					SELF := []));
	
	RETURN With_Tradeline_Key_LinkIds;

END;
