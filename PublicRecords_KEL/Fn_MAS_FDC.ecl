IMPORT Doxie, Doxie_Files, Header_Quick;

EXPORT Fn_MAS_FDC(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) Input,
									PublicRecords_KEL.Interface_Options Options,
									DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput = DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII)
									) := FUNCTION

	Layouts_FDC := PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options);
	Common := PublicRecords_KEL.ECL_Functions.Common(Options);
	
	// Data cleaning functions needed to get raw data ready for KEL
	Doxie_Files__Key_Offenders_Src(STRING data_type) := CASE(data_type,
				'1' => 'DC',
				'2' => 'CC',
				'5' => 'AL',
					'');
					
	// Now put together the FDC bundle				
	Input_FDC := PROJECT(Input, TRANSFORM(Layouts_FDC.Layout_FDC,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF := []));
					
	Input_FDC_Filtered := Input_FDC(LexIDAppend > 0);				

	// Doxie.Key_FCRA_Header/Doxie.Key_Header. FCRA/NonFCRA have the same layout.
	Doxie__Key_Header := IF(Options.IsFCRA, Doxie.Key_FCRA_Header, Doxie.Key_Header);
	Doxie__Key_Header_Records := IF(Common.DoFDCJoin_Doxie__Key_Header,
		JOIN(Input_FDC_Filtered, Doxie__Key_Header,
				KEYED(LEFT.LexIDAppend = (UNSIGNED)RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Header,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF := RIGHT,
					SELF := []), 
				LIMIT(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
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
					SELF := RIGHT,
					SELF := []), 
				LIMIT(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Header_Quick__Key_Did));

					
	With_Header_Quick__Key_Did := DENORMALIZE(With_Doxie__Key_Header, Header_Quick__Key_Did_Records,
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Header_Quick__Key_Did := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));
						
	// Doxie_Files.Key_BocaShell_Crim_FCRA -- FCRA only
	Doxie_Files__Key_BocaShell_Crim_FCRA_Records := IF(Common.DoFDCJoin_Doxie_Files__Key_BocaShell_Crim_FCRA, 
		JOIN(Input_FDC_Filtered, Doxie_Files.Key_BocaShell_Crim_FCRA,
				KEYED(LEFT.LexIDAppend = RIGHT.DID),
				TRANSFORM(Layouts_FDC.Layout_Doxie_Files__Key_BocaShell_Crim_FCRA_Denorm,
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF := RIGHT,
					SELF := []), 
				LIMIT(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
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
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF.src := Doxie_Files__Key_Offenders_Src(RIGHT.data_type),
					SELF := RIGHT,
					SELF := []), 
				LIMIT(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
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
					SELF := RIGHT,
					SELF := []), 
				LIMIT(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
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
					SELF := RIGHT, 
					SELF := []), 
				LIMIT(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
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
					SELF.InputUIDAppend := LEFT.InputUIDAppend,
					SELF.LexIDAppend := LEFT.LexIDAppend,
					SELF := RIGHT,
					SELF := []), 
				LIMIT(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
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
					SELF := RIGHT,
					SELF := []), 
				LIMIT(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT)),
		DATASET([], Layouts_FDC.Layout_Doxie_Files__Key_Punishment));
		
	With_Doxie_Files__Key_Punishment := DENORMALIZE(With_Doxie_Files__Key_Offenders_Risk, Doxie_Files__Key_Punishment_Records,
				LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexIDAppend = RIGHT.LexIDAppend, GROUP,
				TRANSFORM(Layouts_FDC.Layout_FDC,
						SELF.Dataset_Doxie_Files__Key_Punishment := ROWS(RIGHT),
						SELF := LEFT,
						SELF := []));		
						
	RETURN With_Doxie_Files__Key_Punishment;

END;