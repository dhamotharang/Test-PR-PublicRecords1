IMPORT Business_Risk_BIP, Gateway, Risk_Indicators, doxie;

	// The following function appends the LexID to each of the Authorized Reps.
	EXPORT getAuthRepLexIDs( DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
	                        Business_Risk_BIP.LIB_Business_Shell_LIBIN Options) :=
		FUNCTION

			mod_access := PROJECT(Options, doxie.IDataAccess);

			Risk_Indicators.Layout_Input prepForDIDAppend(Business_Risk_BIP.Layouts.Shell le, INTEGER whichAuthRep) := TRANSFORM
				SELF.Seq              := le.Seq * 10 + CHOOSE( whichAuthRep, 1, 2, 3, 4, 5, 6, 0); // Preserve the original Seq value by shifting it over one position to the left; add the Nth AuthRep in the Ones position.
				SELF.HistoryDate      := 999999;
				SELF.Title            := CHOOSE( whichAuthRep, le.Clean_Input.Rep_NameTitle     , le.Clean_Input.Rep2_NameTitle     ,le.Clean_Input.Rep3_NameTitle     ,le.Clean_Input.Rep4_NameTitle     ,le.Clean_Input.Rep5_NameTitle     ,''                           ,'' );
				SELF.FName            := CHOOSE( whichAuthRep, le.Clean_Input.Rep_FirstName     , le.Clean_Input.Rep2_FirstName     ,le.Clean_Input.Rep3_FirstName     ,le.Clean_Input.Rep4_FirstName     ,le.Clean_Input.Rep5_FirstName     ,''                           ,'' );
				SELF.MName            := CHOOSE( whichAuthRep, le.Clean_Input.Rep_MiddleName    , le.Clean_Input.Rep2_MiddleName    ,le.Clean_Input.Rep3_MiddleName    ,le.Clean_Input.Rep4_MiddleName    ,le.Clean_Input.Rep5_MiddleName    ,''                           ,'' );
				SELF.LName            := CHOOSE( whichAuthRep, le.Clean_Input.Rep_LastName      , le.Clean_Input.Rep2_LastName      ,le.Clean_Input.Rep3_LastName      ,le.Clean_Input.Rep4_LastName      ,le.Clean_Input.Rep5_LastName      ,''                           ,'' );
				SELF.Suffix           := CHOOSE( whichAuthRep, le.Clean_Input.Rep_NameSuffix    , le.Clean_Input.Rep2_NameSuffix    ,le.Clean_Input.Rep3_NameSuffix    ,le.Clean_Input.Rep4_NameSuffix    ,le.Clean_Input.Rep5_NameSuffix    ,''                           ,'' );
				SELF.In_StreetAddress := CHOOSE( whichAuthRep, le.Clean_Input.Rep_StreetAddress1, le.Clean_Input.Rep2_StreetAddress1,le.Clean_Input.Rep3_StreetAddress1,le.Clean_Input.Rep4_StreetAddress1,le.Clean_Input.Rep5_StreetAddress1,le.Clean_Input.StreetAddress1,'' );
				SELF.In_City          := CHOOSE( whichAuthRep, le.Clean_Input.Rep_City          , le.Clean_Input.Rep2_City          ,le.Clean_Input.Rep3_City          ,le.Clean_Input.Rep4_City          ,le.Clean_Input.Rep5_City          ,le.Clean_Input.City          ,'' );
				SELF.In_State         := CHOOSE( whichAuthRep, le.Clean_Input.Rep_State         , le.Clean_Input.Rep2_State         ,le.Clean_Input.Rep3_State         ,le.Clean_Input.Rep4_State         ,le.Clean_Input.Rep5_State         ,le.Clean_Input.State         ,'' );
				SELF.In_ZipCode       := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Zip           , le.Clean_Input.Rep2_Zip           ,le.Clean_Input.Rep3_Zip           ,le.Clean_Input.Rep4_Zip           ,le.Clean_Input.Rep5_Zip           ,le.Clean_Input.Zip5          ,'' );
				SELF.Prim_Range       := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Prim_Range    , le.Clean_Input.Rep2_Prim_Range    ,le.Clean_Input.Rep3_Prim_Range    ,le.Clean_Input.Rep4_Prim_Range    ,le.Clean_Input.Rep5_Prim_Range    ,le.Clean_Input.Prim_Range    ,'' );
				SELF.Predir           := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Predir        , le.Clean_Input.Rep2_Predir        ,le.Clean_Input.Rep3_Predir        ,le.Clean_Input.Rep4_Predir        ,le.Clean_Input.Rep5_Predir        ,le.Clean_Input.Predir        ,'' );
				SELF.Prim_Name        := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Prim_Name     , le.Clean_Input.Rep2_Prim_Name     ,le.Clean_Input.Rep3_Prim_Name     ,le.Clean_Input.Rep4_Prim_Name     ,le.Clean_Input.Rep5_Prim_Name     ,le.Clean_Input.Prim_Name     ,'' );
				SELF.Addr_Suffix      := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Addr_Suffix   , le.Clean_Input.Rep2_Addr_Suffix   ,le.Clean_Input.Rep3_Addr_Suffix   ,le.Clean_Input.Rep4_Addr_Suffix   ,le.Clean_Input.Rep5_Addr_Suffix   ,le.Clean_Input.Addr_Suffix   ,'' );
				SELF.Postdir          := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Postdir       , le.Clean_Input.Rep2_Postdir       ,le.Clean_Input.Rep3_Postdir       ,le.Clean_Input.Rep4_Postdir       ,le.Clean_Input.Rep5_Postdir       ,le.Clean_Input.Postdir       ,'' );
				SELF.Unit_Desig       := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Unit_Desig    , le.Clean_Input.Rep2_Unit_Desig    ,le.Clean_Input.Rep3_Unit_Desig    ,le.Clean_Input.Rep4_Unit_Desig    ,le.Clean_Input.Rep5_Unit_Desig    ,le.Clean_Input.Unit_Desig    ,'' );
				SELF.Sec_Range        := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Sec_Range     , le.Clean_Input.Rep2_Sec_Range     ,le.Clean_Input.Rep3_Sec_Range     ,le.Clean_Input.Rep4_Sec_Range     ,le.Clean_Input.Rep5_Sec_Range     ,le.Clean_Input.Sec_Range     ,'' );
				SELF.P_City_Name      := CHOOSE( whichAuthRep, le.Clean_Input.Rep_City          , le.Clean_Input.Rep2_City          ,le.Clean_Input.Rep3_City          ,le.Clean_Input.Rep4_City          ,le.Clean_Input.Rep5_City          ,le.Clean_Input.City          ,'' );
				SELF.St               := CHOOSE( whichAuthRep, le.Clean_Input.Rep_State         , le.Clean_Input.Rep2_State         ,le.Clean_Input.Rep3_State         ,le.Clean_Input.Rep4_State         ,le.Clean_Input.Rep5_State         ,le.Clean_Input.State         ,'' );
				SELF.Z5               := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Zip5          , le.Clean_Input.Rep2_Zip5          ,le.Clean_Input.Rep3_Zip5          ,le.Clean_Input.Rep4_Zip5          ,le.Clean_Input.Rep5_Zip5          ,le.Clean_Input.Zip5          ,'' );
				SELF.Zip4             := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Zip4          , le.Clean_Input.Rep2_Zip4          ,le.Clean_Input.Rep3_Zip4          ,le.Clean_Input.Rep4_Zip4          ,le.Clean_Input.Rep5_Zip4          ,le.Clean_Input.Zip4          ,'' );
				SELF.Lat              := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Lat           , le.Clean_Input.Rep2_Lat           ,le.Clean_Input.Rep3_Lat           ,le.Clean_Input.Rep4_Lat           ,le.Clean_Input.Rep5_Lat           ,le.Clean_Input.Lat           ,'' );
				SELF.Long             := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Long          , le.Clean_Input.Rep2_Long          ,le.Clean_Input.Rep3_Long          ,le.Clean_Input.Rep4_Long          ,le.Clean_Input.Rep5_Long          ,le.Clean_Input.Long          ,'' );
				SELF.County           := CHOOSE( whichAuthRep, le.Clean_Input.Rep_County        , le.Clean_Input.Rep2_County        ,le.Clean_Input.Rep3_County        ,le.Clean_Input.Rep4_County        ,le.Clean_Input.Rep5_County        ,le.Clean_Input.County        ,'' );
				SELF.Geo_Blk          := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Geo_Block     , le.Clean_Input.Rep2_Geo_Block     ,le.Clean_Input.Rep3_Geo_Block     ,le.Clean_Input.Rep4_Geo_Block     ,le.Clean_Input.Rep5_Geo_Block     ,le.Clean_Input.Geo_Block     ,'' );
				SELF.Addr_Type        := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Addr_Type     , le.Clean_Input.Rep2_Addr_Type     ,le.Clean_Input.Rep3_Addr_Type     ,le.Clean_Input.Rep4_Addr_Type     ,le.Clean_Input.Rep5_Addr_Type     ,le.Clean_Input.Addr_Type     ,'' );
				SELF.Addr_Status      := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Addr_Status   , le.Clean_Input.Rep2_Addr_Status   ,le.Clean_Input.Rep3_Addr_Status   ,le.Clean_Input.Rep4_Addr_Status   ,le.Clean_Input.Rep5_Addr_Status   ,le.Clean_Input.Addr_Status   ,'' );
				SELF.SSN              := CHOOSE( whichAuthRep, le.Clean_Input.Rep_SSN           , le.Clean_Input.Rep2_SSN           ,le.Clean_Input.Rep3_SSN           ,le.Clean_Input.Rep4_SSN           ,le.Clean_Input.Rep5_SSN           ,le.Clean_Input.FEIN          ,'' );
				SELF.DOB              := CHOOSE( whichAuthRep, le.Clean_Input.Rep_DateOfBirth   , le.Clean_Input.Rep2_DateOfBirth   ,le.Clean_Input.Rep3_DateOfBirth   ,le.Clean_Input.Rep4_DateOfBirth   ,le.Clean_Input.Rep5_DateOfBirth   ,''                           ,'' );
				SELF.Age              := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Age           , le.Clean_Input.Rep2_Age           ,le.Clean_Input.Rep3_Age           ,le.Clean_Input.Rep4_Age           ,le.Clean_Input.Rep5_Age           ,''                           ,'' );
				SELF.DL_Number        := CHOOSE( whichAuthRep, le.Clean_Input.Rep_DLNumber      , le.Clean_Input.Rep2_DLNumber      ,le.Clean_Input.Rep3_DLNumber      ,le.Clean_Input.Rep4_DLNumber      ,le.Clean_Input.Rep5_DLNumber      ,''                           ,'' );
				SELF.DL_State         := CHOOSE( whichAuthRep, le.Clean_Input.Rep_DLState       , le.Clean_Input.Rep2_DLState       ,le.Clean_Input.Rep3_DLState       ,le.Clean_Input.Rep4_DLState       ,le.Clean_Input.Rep5_DLState       ,''                           ,'' );
				SELF.Email_Address    := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Email         , le.Clean_Input.Rep2_Email         ,le.Clean_Input.Rep3_Email         ,le.Clean_Input.Rep4_Email         ,le.Clean_Input.Rep5_Email         ,''                           ,'' );
				SELF.Phone10          := CHOOSE( whichAuthRep, le.Clean_Input.Rep_Phone10       , le.Clean_Input.Rep2_Phone10       ,le.Clean_Input.Rep3_Phone10       ,le.Clean_Input.Rep4_Phone10       ,le.Clean_Input.Rep5_Phone10       ,le.Clean_Input.Phone10       ,'' );
				SELF := [];
			END;

			prepDIDAppend := NORMALIZE( Shell, 6, prepForDIDAppend(LEFT,COUNTER) );

			prepDIDAppend_valid := prepDIDAppend(trim(Phone10) <> '' or trim(DOB) <>'' or trim(ssn) <>'' or trim(Z5)<>'');  // try putting this filter in place so we don't send 30 records into DIDappend

			DIDAppend := Risk_Indicators.iid_getDID_prepOutput(prepDIDAppend_valid,
																												mod_access.dppa,
																												mod_access.glb,
																												FALSE, // isFCRA
																												50,    // BSVersion
																												mod_access.DataRestrictionMask,
																												0,     // Append_Best
																												DATASET([], Gateway.Layouts.Config), // Gateways
																												0,      // BSOptions
																											mod_access := mod_access);

   // OUTPUT( DIDAppend, NAMED('_DIDAppend') );

			// Pick the DID with the highest score, in the event that multiple have the same score, choose the lowest value DID to make this deterministic
			DIDKept := ROLLUP(SORT(UNGROUP(DIDAppend), Seq, -Score, DID), LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT));

   // OUTPUT( DIDKept, NAMED('_DIDKept') );

			// Add LexIDs to the Shell. Decode the Seq value using a modulus to arrive at the correct DID.
   layout_DIDKept_slim := RECORD
     UNSIGNED4 orig_seq;
     UNSIGNED4 whichAuthRep;
     UNSIGNED6 did;
     unsigned1 did_score;
   END;

   DIDKept_slim :=
    PROJECT(
      DIDKept,
      TRANSFORM( layout_DIDKept_slim,
        SELF.orig_seq     := LEFT.Seq DIV 10,
        SELF.whichAuthRep := LEFT.Seq % 10,
        SELF.did          := LEFT.did,
        self.did_score    := left.score
      )
    );

		// Use COMBINE( ) function to transform from normalized records to denormalized, repeating
		// fields in a single record.

  // Define left Group.
		layout_seq := {UNSIGNED4 orig_seq};

		ds_seq      := PROJECT(DIDKept_slim, layout_seq);
		ds_seq_grpd := GROUP(DEDUP(SORT(ds_seq, orig_seq), orig_seq), orig_seq);

  // Define right Group.
  DIDKept_slim_grpd := GROUP( SORT(DIDKept_slim, orig_seq, whichAuthRep), orig_seq );

  // Combine:
  layout_authRepLexIDs_temp := RECORD
    UNSIGNED4 seq;
    STRING15 BusExecLinkAuthRepLexID;
    STRING15 BusExecLinkAuthRep2LexID;
    STRING15 BusExecLinkAuthRep3LexID;
    STRING15 BusExecLinkAuthRep4LexID;
    STRING15 BusExecLinkAuthRep5LexID;
    STRING15 BusPersonLexIDOverlap;
    unsigned1 LexID_score;
    unsigned1 LexID2_score;
    unsigned1 LexID3_score;
    unsigned1 LexID4_score;
    unsigned1 LexID5_score;
  END;

		layout_authRepLexIDs_temp xfm_ToCombineAuthRepLexIDs( layout_seq le, DATASET(RECORDOF(DIDKept_slim_grpd)) allRows ) :=
			TRANSFORM
				SELF.seq := le.orig_seq;
				SELF.BusExecLinkAuthRepLexID  := (STRING)(allRows(whichAuthRep = 1)[1].did);
				SELF.BusExecLinkAuthRep2LexID := (STRING)(allRows(whichAuthRep = 2)[1].did);
				SELF.BusExecLinkAuthRep3LexID := (STRING)(allRows(whichAuthRep = 3)[1].did);
				SELF.BusExecLinkAuthRep4LexID := (STRING)(allRows(whichAuthRep = 4)[1].did);
				SELF.BusExecLinkAuthRep5LexID := (STRING)(allRows(whichAuthRep = 5)[1].did);
        SELF.BusPersonLexIDOverlap    := (STRING)(allRows(whichAuthRep = 6)[1].did);

        SELF.LexID_score  := (allRows(whichAuthRep = 1)[1].did_score);
				SELF.LexID2_score := (allRows(whichAuthRep = 2)[1].did_score);
				SELF.LexID3_score := (allRows(whichAuthRep = 3)[1].did_score);
				SELF.LexID4_score := (allRows(whichAuthRep = 4)[1].did_score);
				SELF.LexID5_score := (allRows(whichAuthRep = 5)[1].did_score);
			END;

		withLexIDs_combined :=
			COMBINE(
				ds_seq_grpd, DIDKept_slim_grpd,
				GROUP,
				xfm_ToCombineAuthRepLexIDs(LEFT,ROWS(RIGHT))
			);

			Shell_withLexIDs :=
				JOIN(
					Shell, withLexIDs_combined,
					LEFT.Seq = RIGHT.Seq,
					TRANSFORM( Business_Risk_BIP.Layouts.Shell,
						SELF.Seq := LEFT.Seq,
			SELF.Clean_Input.Rep_LexID := (UNSIGNED)RIGHT.BusExecLinkAuthRepLexID;
			SELF.Clean_Input.Rep2_LexID := (UNSIGNED)RIGHT.BusExecLinkAuthRep2LexID;
			SELF.Clean_Input.Rep3_LexID := (UNSIGNED)RIGHT.BusExecLinkAuthRep3LexID;
			SELF.Clean_Input.Rep4_LexID := (UNSIGNED)RIGHT.BusExecLinkAuthRep4LexID;
			SELF.Clean_Input.Rep5_LexID := (UNSIGNED)RIGHT.BusExecLinkAuthRep5LexID;

			SELF.Clean_Input.Rep_LexIDscore := right.LexID_score;
			SELF.Clean_Input.Rep2_LexIDscore := right.LexID2_score;
			SELF.Clean_Input.Rep3_LexIDscore := right.LexID3_score;
			SELF.Clean_Input.Rep4_LexIDscore := right.LexID4_score;
			SELF.Clean_Input.Rep5_LexIDscore := right.LexID5_score;

      SELF.Business_To_Executive_Link.BusExecLinkAuthRepLexID  := IF( RIGHT.BusExecLinkAuthRepLexID  != '0', RIGHT.BusExecLinkAuthRepLexID, '' ),
      SELF.Business_To_Executive_Link.BusExecLinkAuthRep2LexID := IF( RIGHT.BusExecLinkAuthRep2LexID != '0', RIGHT.BusExecLinkAuthRep2LexID, '' ),
      SELF.Business_To_Executive_Link.BusExecLinkAuthRep3LexID := IF( RIGHT.BusExecLinkAuthRep3LexID != '0', RIGHT.BusExecLinkAuthRep3LexID, '' ),
      SELF.Business_To_Executive_Link.BusExecLinkAuthRep4LexID := IF( RIGHT.BusExecLinkAuthRep4LexID != '0', RIGHT.BusExecLinkAuthRep4LexID, '' ),
      SELF.Business_To_Executive_Link.BusExecLinkAuthRep5LexID := IF( RIGHT.BusExecLinkAuthRep5LexID != '0', RIGHT.BusExecLinkAuthRep5LexID, '' ),
      SELF.Business_To_Person_Link.BusPersonLexIDOverlap       := IF(RIGHT.BusPersonLexIDOverlap     != '0', RIGHT.BusPersonLexIDOverlap, '' );

      BusinessInputsPopulated := TRIM(LEFT.Clean_Input.FEIN) != '' OR TRIM(LEFT.Clean_Input.Phone10) != '' OR (TRIM(LEFT.Clean_Input.Prim_Name)!= '' AND TRIM(LEFT.Clean_Input.Zip5) != '');
      SELF.Business_To_Person_Link.BusPersonOverlap := MAP((INTEGER)RIGHT.BusPersonLexIDOverlap > 0                              => '1',   // Business Inputs resolved to a LexID
                                                            BusinessInputsPopulated AND (INTEGER)RIGHT.BusPersonLexIDOverlap = 0 => '0',   // Business Inputs not resolved to a LexID
                                                                                                                                    '-1'); // Business Inputs not provided
      SELF := LEFT,

					),
					LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

   // DEBUGs:
//   OUTPUT( DIDKept_slim_grpd, NAMED('_DIDKept_slim_grpd') );

			RETURN Shell_withLexIDs;

		END;
