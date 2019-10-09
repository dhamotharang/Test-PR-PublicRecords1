IMPORT  STD, HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest;
EXPORT Process_XNOMATCH_Layouts(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
  ) := MODULE
 
IMPORT SALT311;
SHARED h := pInfile;//The input file
 
EXPORT KeyName := HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).ExternalKeys.Meow.New;
 
EXPORT Key := INDEX(h,{nomatch_id},{h},KeyName);
// Create key to get from historic versions of higher order keys
 
EXPORT KeyIDHistoryName := HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).ExternalKeys.Sup_RID.New;
  SHARED sIDHist := TABLE(h,{nomatch_id,RID},RID,nomatch_id,MERGE);
 
EXPORT KeyIDHistory := INDEX(sIDHist,{RID},{sIDHist},KeyIDHistoryName);
 
EXPORT BuildAll := PARALLEL(BUILDINDEX(Key, OVERWRITE),BUILDINDEX(KeyIDHistory, OVERWRITE));
EXPORT id_stream_layout := RECORD
    SALT311.UIDType UniqueId;
    INTEGER2 Weight;
    UNSIGNED2 Score;
    Config.KeysBitmapType KeysUsed := 0;
    Config.KeysBitmapType KeysFailed := 0;
    BOOLEAN IsTruncated := FALSE;
    UNSIGNED8 nomatch_id;
    UNSIGNED8 RID := 0; // Unique record ID for external file
END;
// This function produces elements with the full hierarchy filled in - presuming that the minor-most incoming id is historic
EXPORT id_stream_historic(DATASET(id_stream_layout) id) := FUNCTION
  C := id(RID<>0,nomatch_id=0); // Only record ID supplied
  id_stream_layout Load(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J_rec := JOIN(C,KeyIDHistory,LEFT.RID=RIGHT.RID,Load(LEFT,RIGHT),LIMIT(Config.JoinLimit));
  C0 := id(nomatch_id<>0); // nomatch_id is the minormost element
  id_stream_layout Load0(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.RID := 0; // Don't want record id
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J0 := JOIN(C0,KeyIDHistory,LEFT.nomatch_id=RIGHT.RID,Load0(LEFT,RIGHT),LIMIT(Config.JoinLimit));
  RETURN J_rec+J0;
END;
EXPORT Fetch_Stream(DATASET(id_stream_layout) d) := FUNCTION
    k := Key;
    DLayout := RECORD
      id_stream_layout;
      BOOLEAN did_fetch;
      RECORDOF(k) AND NOT id_stream_layout; // No HEADERSEARCH specified 
    END;
    DLayout tr(id_stream_layout le, k ri) := TRANSFORM
      SELF.did_fetch := ri.nomatch_id<>0;
      SELF.nomatch_id := IF ( SELF.did_fetch, ri.nomatch_id, le.nomatch_id ); // Copy from 'real data' if it exists
      SELF.RID := IF ( SELF.did_fetch, ri.RID, le.RID ); // Copy from 'real data' if it exists
      SELF := ri;
      SELF := le;
    END;
    J := JOIN( d,k,(LEFT.nomatch_id = RIGHT.nomatch_id),tr(LEFT,RIGHT), LEFT OUTER, KEEP(Config.JoinLimit)); // Ignore excess records without error
    RETURN J;
END;
 
EXPORT Fetch_Stream_Expanded(DATASET(id_stream_layout) d) := FUNCTION
  rd1 := Fetch_Stream(d);
  old := PROJECT(rd1(~did_fetch),id_stream_layout); // Failed to fetch
  renew_candidates := id_stream_historic(old); // See if more recent version of ID is fetchable
  renewed := Fetch_Stream(renew_candidates);
  RETURN rd1(did_fetch OR KeysFailed<>0)+renewed;
END;
 
EXPORT MAC_Fetch_Batch(infile, In_nomatch_id, In_UniqueID, asIndex = TRUE) := FUNCTIONMACRO
  IMPORT SALT311,HealthcareNoMatchHeader_ExternalLinking;
  payloadKey := HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.Key;
  idHistKey := HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.KeyIDHistory;
  outLayout := RECORD
    infile.In_UniqueID;
    SALT311.UIDType inputnomatch_id;
    RECORDOF(payloadKey);
  END;
  outLayout emptyResult(infile le) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputnomatch_id := le.In_nomatch_id;
    SELF := [];
  END;
 
  outLayout xJoinHist(outLayout le, idHistKey ri) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputnomatch_id := le.inputnomatch_id;
    SELF := ri;
    SELF := [];
  END;
 
  outLayout xJoinPayload(outLayout le, payloadKey ri) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputnomatch_id := le.inputnomatch_id;
    SELF := ri;
  END;
 
  infile_emptyResult := PROJECT(infile, emptyResult(LEFT));
  JEntKeyed := JOIN(infile_emptyResult, payloadKey, LEFT.inputnomatch_id = RIGHT.nomatch_id, xJoinPayload(LEFT,RIGHT), LEFT OUTER);
  JEntPull := JOIN(infile_emptyResult, PULL(payloadKey), LEFT.inputnomatch_id = RIGHT.nomatch_id, xJoinPayload(LEFT,RIGHT), LEFT OUTER, HASH);
 
  resultsEnt := IF(asIndex, JEntKeyed, JEntPull);
  resultsEnt_found := resultsEnt(nomatch_id > 0);
  resultsEnt_notfound := resultsEnt(nomatch_id = 0);
 
  JRecKeyed_1 := JOIN(resultsEnt_notfound, idHistKey, LEFT.inputnomatch_id = RIGHT.RID, xJoinHist(LEFT,RIGHT), LEFT OUTER);
  JRecPull_1 := JOIN(resultsEnt_notfound, PULL(idHistKey), LEFT.inputnomatch_id = RIGHT.RID, xJoinHist(LEFT,RIGHT), LEFT OUTER, HASH);
 
  resultsIDHist := IF(asIndex, JRecKeyed_1, JRecPull_1);
  resultsIDHist_found := resultsIDHist(nomatch_id > 0);
  resultsIDHist_notfound := resultsIDHist(nomatch_id = 0);
 
  JRecKeyed_2 := JOIN(resultsIDHist_found, payloadKey, LEFT.nomatch_id = RIGHT.nomatch_id, xJoinPayload(LEFT,RIGHT), LEFT OUTER);
  JRecPull_2 := JOIN(resultsIDHist_found, PULL(payloadKey), LEFT.nomatch_id = RIGHT.nomatch_id, xJoinPayload(LEFT,RIGHT), LEFT OUTER, HASH);
 
  resultsIDHistAll := IF(asIndex, JRecKeyed_2, JRecPull_2);
  resultsAll := resultsEnt_found & resultsIDHistAll & PROJECT(resultsIDHist_notfound, TRANSFORM(outLayout, SELF.inputnomatch_id := LEFT.inputnomatch_id, SELF.In_UniqueID := LEFT.In_UniqueID,  SELF := []));
 
  RETURN resultsAll;
ENDMACRO;
 
EXPORT InputLayout := RECORD
  SALT311.UIDType UniqueId; // This had better be unique or it will all break horribly
  UNSIGNED2 MaxIDs := 50; // Maximum number of candidate IDs
  UNSIGNED2 LeadThreshold := 0; // Maximum distance from best to worst (0 => no pruning)
  BOOLEAN disableForce := FALSE;
  h.SRC;
  h.SSN;
  h.DOB;
  h.LEXID;
  h.SUFFIX;
  h.FNAME;
  h.MNAME;
  h.LNAME;
  h.GENDER;
  h.PRIM_NAME;
  h.PRIM_RANGE;
  h.SEC_RANGE;
  h.CITY_NAME;
  h.ST;
  h.ZIP;
  h.DT_FIRST_SEEN;
  h.DT_LAST_SEEN;
  SALT311.StrType MAINNAME;//Wordbag field for concept
  SALT311.StrType ADDR1;//Wordbag field for concept
  SALT311.StrType LOCALE;//Wordbag field for concept
  SALT311.StrType ADDRESS;//Wordbag field for concept
  SALT311.StrType FULLNAME;//Wordbag field for concept
// Below only used in header search (data returning) case
  BOOLEAN MatchRecords := false; // Only show records which match
  BOOLEAN FullMatch := false; // Only show nomatch_id if it has a record which fully matches
  SALT311.UIDType Entered_RID := 0; // Allow user to enter RID to pull data
  SALT311.UIDType Entered_nomatch_id := 0; // Allow user to enter nomatch_id to pull data
END;
// Used to clean input to MEOW process that is already in input layout
EXPORT CleanInput(DATASET(InputLayout) inData) := FUNCTION
  InputLayout CleanT(inData le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.SRC := (TYPEOF(SELF.SRC))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_SRC((SALT311.StrType)le.SRC);
    SELF.SSN := (TYPEOF(SELF.SSN))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_SSN((SALT311.StrType)le.SSN);
    SELF.DOB := (TYPEOF(SELF.DOB))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_DOB((SALT311.StrType)le.DOB);
    SELF.LEXID := (TYPEOF(SELF.LEXID))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_LEXID((SALT311.StrType)le.LEXID);
    SELF.SUFFIX := (TYPEOF(SELF.SUFFIX))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_SUFFIX((SALT311.StrType)le.SUFFIX);
    SELF.FNAME := (TYPEOF(SELF.FNAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_FNAME((SALT311.StrType)le.FNAME);
    SELF.MNAME := (TYPEOF(SELF.MNAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_MNAME((SALT311.StrType)le.MNAME);
    SELF.LNAME := (TYPEOF(SELF.LNAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_LNAME((SALT311.StrType)le.LNAME);
    SELF.GENDER := (TYPEOF(SELF.GENDER))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_GENDER((SALT311.StrType)le.GENDER);
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_PRIM_NAME((SALT311.StrType)le.PRIM_NAME);
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE);
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_SEC_RANGE((SALT311.StrType)le.SEC_RANGE);
    SELF.CITY_NAME := (TYPEOF(SELF.CITY_NAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_CITY_NAME((SALT311.StrType)le.CITY_NAME);
    SELF.ST := (TYPEOF(SELF.ST))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_ST((SALT311.StrType)le.ST);
    SELF.ZIP := (TYPEOF(SELF.ZIP))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_ZIP((SALT311.StrType)le.ZIP);
    SELF.DT_FIRST_SEEN := (TYPEOF(SELF.DT_FIRST_SEEN))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_DT_FIRST_SEEN((SALT311.StrType)le.DT_FIRST_SEEN);
    SELF.DT_LAST_SEEN := (TYPEOF(SELF.DT_LAST_SEEN))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_DT_LAST_SEEN((SALT311.StrType)le.DT_LAST_SEEN);
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_MAINNAME((SALT311.StrType)le.MAINNAME);
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_ADDR1((SALT311.StrType)le.ADDR1);
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_LOCALE((SALT311.StrType)le.LOCALE);
    SELF.ADDRESS := (TYPEOF(SELF.ADDRESS))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_ADDRESS((SALT311.StrType)le.ADDRESS);
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_FULLNAME((SALT311.StrType)le.FULLNAME);
    SELF := le;
  END;
  RETURN PROJECT(inData, CleanT(LEFT));
END;
 
EXPORT LayoutScoredFetch := RECORD // Nulls required for linkpaths that do not have field
  h.nomatch_id;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT311.UIDType Reference := 0;//Presently for batch
  SALT311.UIDType RID := 0;
  BOOLEAN ForceFailed := FALSE;
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))'';
  INTEGER2 SRCWeight := 0;
  INTEGER1 SRC_match_code := 0;
  TYPEOF(h.SSN) SSN := (TYPEOF(h.SSN))'';
  INTEGER2 SSNWeight := 0;
  INTEGER1 SSN_match_code := 0;
  UNSIGNED2 DOB_year := 0;
  UNSIGNED1 DOB_month := 0;
  UNSIGNED1 DOB_day := 0;
  INTEGER2 DOBWeight := 0;
  INTEGER1 DOB_match_code := 0;
  INTEGER2 DOBWeight_year := 0;
  INTEGER1 DOB_year_match_code := 0;
  INTEGER2 DOBWeight_month := 0;
  INTEGER1 DOB_month_match_code := 0;
  INTEGER2 DOBWeight_day := 0;
  INTEGER1 DOB_day_match_code := 0;
  TYPEOF(h.LEXID) LEXID := (TYPEOF(h.LEXID))'';
  INTEGER2 LEXIDWeight := 0;
  INTEGER1 LEXID_match_code := 0;
  TYPEOF(h.SUFFIX) SUFFIX := (TYPEOF(h.SUFFIX))'';
  INTEGER2 SUFFIXWeight := 0;
  INTEGER1 SUFFIX_match_code := 0;
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  INTEGER2 FNAMEWeight := 0;
  INTEGER1 FNAME_match_code := 0;
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  INTEGER2 MNAMEWeight := 0;
  INTEGER1 MNAME_match_code := 0;
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  INTEGER2 LNAMEWeight := 0;
  INTEGER1 LNAME_match_code := 0;
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))'';
  INTEGER2 GENDERWeight := 0;
  INTEGER1 GENDER_match_code := 0;
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  INTEGER2 PRIM_NAMEWeight := 0;
  INTEGER1 PRIM_NAME_match_code := 0;
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  INTEGER2 PRIM_RANGEWeight := 0;
  INTEGER1 PRIM_RANGE_match_code := 0;
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  INTEGER2 SEC_RANGEWeight := 0;
  INTEGER1 SEC_RANGE_match_code := 0;
  TYPEOF(h.CITY_NAME) CITY_NAME := (TYPEOF(h.CITY_NAME))'';
  INTEGER2 CITY_NAMEWeight := 0;
  INTEGER1 CITY_NAME_match_code := 0;
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  INTEGER2 STWeight := 0;
  INTEGER1 ST_match_code := 0;
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  INTEGER2 ZIPWeight := 0;
  INTEGER1 ZIP_match_code := 0;
  TYPEOF(h.DT_FIRST_SEEN) DT_FIRST_SEEN := (TYPEOF(h.DT_FIRST_SEEN))'';
  INTEGER2 DT_FIRST_SEENWeight := 0;
  INTEGER1 DT_FIRST_SEEN_match_code := 0;
  TYPEOF(h.DT_LAST_SEEN) DT_LAST_SEEN := (TYPEOF(h.DT_LAST_SEEN))'';
  INTEGER2 DT_LAST_SEENWeight := 0;
  INTEGER1 DT_LAST_SEEN_match_code := 0;
  SALT311.StrType MAINNAME := ''; // Concepts always a wordbag
  INTEGER2 MAINNAMEWeight := 0;
  INTEGER1 MAINNAME_match_code := 0;
  SALT311.StrType ADDR1 := ''; // Concepts always a wordbag
  INTEGER2 ADDR1Weight := 0;
  INTEGER1 ADDR1_match_code := 0;
  SALT311.StrType LOCALE := ''; // Concepts always a wordbag
  INTEGER2 LOCALEWeight := 0;
  INTEGER1 LOCALE_match_code := 0;
  SALT311.StrType ADDRESS := ''; // Concepts always a wordbag
  INTEGER2 ADDRESSWeight := 0;
  INTEGER1 ADDRESS_match_code := 0;
  SALT311.StrType FULLNAME := ''; // Concepts always a wordbag
  INTEGER2 FULLNAMEWeight := 0;
  INTEGER1 FULLNAME_match_code := 0;
  Config.KeysBitmapType keys_used; // A bitmap of the keys used
  Config.KeysBitmapType keys_failed; // A bitmap of the keys that failed the fetch
END;
 
EXPORT LayoutScoredFetch update_forcefailed(LayoutScoredFetch le, BOOLEAN disableForce = FALSE) := TRANSFORM
  SELF.ForceFailed := IF(disableForce, FALSE, (((le.DOB_match_code = SALT311.MatchCode.GenerationNoMatch) OR (le.DOBWeight_year<>0 OR le.DOBWeight_month<>0 OR le.DOBWeight_day<>0) AND (le.DOBWeight < Config.DOB_Force))) OR (le.FNAMEWeight < Config.FNAME_Force));
  SELF := le;
END;
 
EXPORT isLeftWinner(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT311.MatchCode.NoMatch, INTEGER1 r_mc=SALT311.MatchCode.NoMatch) :=
  MAP(l_mc=r_mc => l_weight>=r_weight, // matchcodes the same; so irrelevant
      l_mc=SALT311.MatchCode.ExactMatch => TRUE, // Left (only) is exact
      r_mc=SALT311.MatchCode.ExactMatch => FALSE, // Right (only) is exact
      l_weight>=r_weight); // weight only
 
EXPORT isWeightForcedDown(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT311.MatchCode.NoMatch, INTEGER1 r_mc=SALT311.MatchCode.NoMatch) :=
  IF((isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight < r_weight)) OR  (NOT isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight > r_weight)),true,false);
 
EXPORT LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri, BOOLEAN In_disableForce = FALSE) := TRANSFORM
  BOOLEAN SRCWeightForcedDown := IF ( isWeightForcedDown(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code),TRUE,FALSE );
  SELF.SRCWeight := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code ), le.SRCWeight, ri.SRCWeight );
  SELF.SRC := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code ), le.SRC, ri.SRC );
  SELF.SRC_match_code := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code ), le.SRC_match_code, ri.SRC_match_code );
  BOOLEAN SSNWeightForcedDown := IF ( isWeightForcedDown(le.SSNWeight,ri.SSNWeight,le.SSN_match_code,ri.SSN_match_code),TRUE,FALSE );
  SELF.SSNWeight := IF ( isLeftWinner(le.SSNWeight,ri.SSNWeight,le.SSN_match_code,ri.SSN_match_code ), le.SSNWeight, ri.SSNWeight );
  SELF.SSN := IF ( isLeftWinner(le.SSNWeight,ri.SSNWeight,le.SSN_match_code,ri.SSN_match_code ), le.SSN, ri.SSN );
  SELF.SSN_match_code := IF ( isLeftWinner(le.SSNWeight,ri.SSNWeight,le.SSN_match_code,ri.SSN_match_code ), le.SSN_match_code, ri.SSN_match_code );
  BOOLEAN DOBWeightForcedDown_year := IF ( isWeightForcedDown(le.DOBWeight_year,ri.DOBWeight_year,le.DOB_year_match_code,ri.DOB_year_match_code),true,false );
  SELF.DOBWeight_year := IF ( isLeftWinner( le.DOBWeight_year, ri.DOBWeight_year,le.DOB_year_match_code,ri.DOB_year_match_code), le.DOBWeight_year, ri.DOBWeight_year );
  SELF.DOB_year := IF ( isLeftWinner( le.DOBWeight_year, ri.DOBWeight_year,le.DOB_year_match_code,ri.DOB_year_match_code), le.DOB_year, ri.DOB_year );
  SELF.DOB_year_match_code := IF ( isLeftWinner(le.DOBWeight_year,ri.DOBWeight_year,le.DOB_year_match_code,ri.DOB_year_match_code), le.DOB_year_match_code, ri.DOB_year_match_code );
  BOOLEAN DOBWeightForcedDown_month := IF ( isWeightForcedDown(le.DOBWeight_month,ri.DOBWeight_month,le.DOB_month_match_code,ri.DOB_month_match_code),true,false );
  SELF.DOBWeight_month := IF ( isLeftWinner( le.DOBWeight_month, ri.DOBWeight_month,le.DOB_month_match_code,ri.DOB_month_match_code), le.DOBWeight_month, ri.DOBWeight_month );
  SELF.DOB_month := IF ( isLeftWinner( le.DOBWeight_month, ri.DOBWeight_month,le.DOB_month_match_code,ri.DOB_month_match_code), le.DOB_month, ri.DOB_month );
  SELF.DOB_month_match_code := IF ( isLeftWinner(le.DOBWeight_month,ri.DOBWeight_month,le.DOB_month_match_code,ri.DOB_month_match_code), le.DOB_month_match_code, ri.DOB_month_match_code );
  BOOLEAN DOBWeightForcedDown_day := IF ( isWeightForcedDown(le.DOBWeight_day,ri.DOBWeight_day,le.DOB_day_match_code,ri.DOB_day_match_code),true,false );
  SELF.DOBWeight_day := IF ( isLeftWinner( le.DOBWeight_day, ri.DOBWeight_day,le.DOB_day_match_code,ri.DOB_day_match_code), le.DOBWeight_day, ri.DOBWeight_day );
  SELF.DOB_day := IF ( isLeftWinner( le.DOBWeight_day, ri.DOBWeight_day,le.DOB_day_match_code,ri.DOB_day_match_code), le.DOB_day, ri.DOB_day );
  SELF.DOB_day_match_code := IF ( isLeftWinner(le.DOBWeight_day,ri.DOBWeight_day,le.DOB_day_match_code,ri.DOB_day_match_code), le.DOB_day_match_code, ri.DOB_day_match_code );
  SELF.DOBWeight :=  SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day;
  BOOLEAN DOBWeightForcedDown :=  DOBWeightForcedDown_year OR DOBWeightForcedDown_month OR DOBWeightForcedDown_day;
  SELF.DOB_match_code := IF ( isLeftWinner(le.DOBWeight,ri.DOBWeight,le.DOB_match_code,ri.DOB_match_code), le.DOB_match_code, ri.DOB_match_code );
  BOOLEAN LEXIDWeightForcedDown := IF ( isWeightForcedDown(le.LEXIDWeight,ri.LEXIDWeight,le.LEXID_match_code,ri.LEXID_match_code),TRUE,FALSE );
  SELF.LEXIDWeight := IF ( isLeftWinner(le.LEXIDWeight,ri.LEXIDWeight,le.LEXID_match_code,ri.LEXID_match_code ), le.LEXIDWeight, ri.LEXIDWeight );
  SELF.LEXID := IF ( isLeftWinner(le.LEXIDWeight,ri.LEXIDWeight,le.LEXID_match_code,ri.LEXID_match_code ), le.LEXID, ri.LEXID );
  SELF.LEXID_match_code := IF ( isLeftWinner(le.LEXIDWeight,ri.LEXIDWeight,le.LEXID_match_code,ri.LEXID_match_code ), le.LEXID_match_code, ri.LEXID_match_code );
  BOOLEAN SUFFIXWeightForcedDown := IF ( isWeightForcedDown(le.SUFFIXWeight,ri.SUFFIXWeight,le.SUFFIX_match_code,ri.SUFFIX_match_code),TRUE,FALSE );
  SELF.SUFFIXWeight := IF ( isLeftWinner(le.SUFFIXWeight,ri.SUFFIXWeight,le.SUFFIX_match_code,ri.SUFFIX_match_code ), le.SUFFIXWeight, ri.SUFFIXWeight );
  SELF.SUFFIX := IF ( isLeftWinner(le.SUFFIXWeight,ri.SUFFIXWeight,le.SUFFIX_match_code,ri.SUFFIX_match_code ), le.SUFFIX, ri.SUFFIX );
  SELF.SUFFIX_match_code := IF ( isLeftWinner(le.SUFFIXWeight,ri.SUFFIXWeight,le.SUFFIX_match_code,ri.SUFFIX_match_code ), le.SUFFIX_match_code, ri.SUFFIX_match_code );
  BOOLEAN FNAMEWeightForcedDown := IF ( isWeightForcedDown(le.FNAMEWeight,ri.FNAMEWeight,le.FNAME_match_code,ri.FNAME_match_code),TRUE,FALSE );
  SELF.FNAMEWeight := IF ( isLeftWinner(le.FNAMEWeight,ri.FNAMEWeight,le.FNAME_match_code,ri.FNAME_match_code ), le.FNAMEWeight, ri.FNAMEWeight );
  SELF.FNAME := IF ( isLeftWinner(le.FNAMEWeight,ri.FNAMEWeight,le.FNAME_match_code,ri.FNAME_match_code ), le.FNAME, ri.FNAME );
  SELF.FNAME_match_code := IF ( isLeftWinner(le.FNAMEWeight,ri.FNAMEWeight,le.FNAME_match_code,ri.FNAME_match_code ), le.FNAME_match_code, ri.FNAME_match_code );
  BOOLEAN MNAMEWeightForcedDown := IF ( isWeightForcedDown(le.MNAMEWeight,ri.MNAMEWeight,le.MNAME_match_code,ri.MNAME_match_code),TRUE,FALSE );
  SELF.MNAMEWeight := IF ( isLeftWinner(le.MNAMEWeight,ri.MNAMEWeight,le.MNAME_match_code,ri.MNAME_match_code ), le.MNAMEWeight, ri.MNAMEWeight );
  SELF.MNAME := IF ( isLeftWinner(le.MNAMEWeight,ri.MNAMEWeight,le.MNAME_match_code,ri.MNAME_match_code ), le.MNAME, ri.MNAME );
  SELF.MNAME_match_code := IF ( isLeftWinner(le.MNAMEWeight,ri.MNAMEWeight,le.MNAME_match_code,ri.MNAME_match_code ), le.MNAME_match_code, ri.MNAME_match_code );
  BOOLEAN LNAMEWeightForcedDown := IF ( isWeightForcedDown(le.LNAMEWeight,ri.LNAMEWeight,le.LNAME_match_code,ri.LNAME_match_code),TRUE,FALSE );
  SELF.LNAMEWeight := IF ( isLeftWinner(le.LNAMEWeight,ri.LNAMEWeight,le.LNAME_match_code,ri.LNAME_match_code ), le.LNAMEWeight, ri.LNAMEWeight );
  SELF.LNAME := IF ( isLeftWinner(le.LNAMEWeight,ri.LNAMEWeight,le.LNAME_match_code,ri.LNAME_match_code ), le.LNAME, ri.LNAME );
  SELF.LNAME_match_code := IF ( isLeftWinner(le.LNAMEWeight,ri.LNAMEWeight,le.LNAME_match_code,ri.LNAME_match_code ), le.LNAME_match_code, ri.LNAME_match_code );
  BOOLEAN GENDERWeightForcedDown := IF ( isWeightForcedDown(le.GENDERWeight,ri.GENDERWeight,le.GENDER_match_code,ri.GENDER_match_code),TRUE,FALSE );
  SELF.GENDERWeight := IF ( isLeftWinner(le.GENDERWeight,ri.GENDERWeight,le.GENDER_match_code,ri.GENDER_match_code ), le.GENDERWeight, ri.GENDERWeight );
  SELF.GENDER := IF ( isLeftWinner(le.GENDERWeight,ri.GENDERWeight,le.GENDER_match_code,ri.GENDER_match_code ), le.GENDER, ri.GENDER );
  SELF.GENDER_match_code := IF ( isLeftWinner(le.GENDERWeight,ri.GENDERWeight,le.GENDER_match_code,ri.GENDER_match_code ), le.GENDER_match_code, ri.GENDER_match_code );
  BOOLEAN PRIM_NAMEWeightForcedDown := IF ( isWeightForcedDown(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code),TRUE,FALSE );
  SELF.PRIM_NAMEWeight := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code ), le.PRIM_NAMEWeight, ri.PRIM_NAMEWeight );
  SELF.PRIM_NAME := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code ), le.PRIM_NAME, ri.PRIM_NAME );
  SELF.PRIM_NAME_match_code := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code ), le.PRIM_NAME_match_code, ri.PRIM_NAME_match_code );
  BOOLEAN PRIM_RANGEWeightForcedDown := IF ( isWeightForcedDown(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code),TRUE,FALSE );
  SELF.PRIM_RANGEWeight := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code ), le.PRIM_RANGEWeight, ri.PRIM_RANGEWeight );
  SELF.PRIM_RANGE := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code ), le.PRIM_RANGE, ri.PRIM_RANGE );
  SELF.PRIM_RANGE_match_code := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code ), le.PRIM_RANGE_match_code, ri.PRIM_RANGE_match_code );
  BOOLEAN SEC_RANGEWeightForcedDown := IF ( isWeightForcedDown(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code),TRUE,FALSE );
  SELF.SEC_RANGEWeight := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code ), le.SEC_RANGEWeight, ri.SEC_RANGEWeight );
  SELF.SEC_RANGE := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code ), le.SEC_RANGE, ri.SEC_RANGE );
  SELF.SEC_RANGE_match_code := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code ), le.SEC_RANGE_match_code, ri.SEC_RANGE_match_code );
  BOOLEAN CITY_NAMEWeightForcedDown := IF ( isWeightForcedDown(le.CITY_NAMEWeight,ri.CITY_NAMEWeight,le.CITY_NAME_match_code,ri.CITY_NAME_match_code),TRUE,FALSE );
  SELF.CITY_NAMEWeight := IF ( isLeftWinner(le.CITY_NAMEWeight,ri.CITY_NAMEWeight,le.CITY_NAME_match_code,ri.CITY_NAME_match_code ), le.CITY_NAMEWeight, ri.CITY_NAMEWeight );
  SELF.CITY_NAME := IF ( isLeftWinner(le.CITY_NAMEWeight,ri.CITY_NAMEWeight,le.CITY_NAME_match_code,ri.CITY_NAME_match_code ), le.CITY_NAME, ri.CITY_NAME );
  SELF.CITY_NAME_match_code := IF ( isLeftWinner(le.CITY_NAMEWeight,ri.CITY_NAMEWeight,le.CITY_NAME_match_code,ri.CITY_NAME_match_code ), le.CITY_NAME_match_code, ri.CITY_NAME_match_code );
  BOOLEAN STWeightForcedDown := IF ( isWeightForcedDown(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code),TRUE,FALSE );
  SELF.STWeight := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.STWeight, ri.STWeight );
  SELF.ST := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.ST, ri.ST );
  SELF.ST_match_code := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.ST_match_code, ri.ST_match_code );
  BOOLEAN ZIPWeightForcedDown := IF ( isWeightForcedDown(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code),TRUE,FALSE );
  SELF.ZIPWeight := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIPWeight, ri.ZIPWeight );
  SELF.ZIP := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIP, ri.ZIP );
  SELF.ZIP_match_code := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIP_match_code, ri.ZIP_match_code );
  BOOLEAN DT_FIRST_SEENWeightForcedDown := IF ( isWeightForcedDown(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code),TRUE,FALSE );
  SELF.DT_FIRST_SEENWeight := IF ( isLeftWinner(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code ), le.DT_FIRST_SEENWeight, ri.DT_FIRST_SEENWeight );
  SELF.DT_FIRST_SEEN := IF ( isLeftWinner(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code ), le.DT_FIRST_SEEN, ri.DT_FIRST_SEEN );
  SELF.DT_FIRST_SEEN_match_code := IF ( isLeftWinner(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code ), le.DT_FIRST_SEEN_match_code, ri.DT_FIRST_SEEN_match_code );
  BOOLEAN DT_LAST_SEENWeightForcedDown := IF ( isWeightForcedDown(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code),TRUE,FALSE );
  SELF.DT_LAST_SEENWeight := IF ( isLeftWinner(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code ), le.DT_LAST_SEENWeight, ri.DT_LAST_SEENWeight );
  SELF.DT_LAST_SEEN := IF ( isLeftWinner(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code ), le.DT_LAST_SEEN, ri.DT_LAST_SEEN );
  SELF.DT_LAST_SEEN_match_code := IF ( isLeftWinner(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code ), le.DT_LAST_SEEN_match_code, ri.DT_LAST_SEEN_match_code );
  BOOLEAN DirectMAINNAMEWeightForcedDown := IF ( isWeightForcedDown(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code),TRUE,FALSE );
  SELF.MAINNAMEWeight := MAP (
      DirectMAINNAMEWeightForcedDown => IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAMEWeight, ri.MAINNAMEWeight ),
      IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAMEWeight, ri.MAINNAMEWeight ));
  SELF.MAINNAME_match_code :=  MAP (
      DirectMAINNAMEWeightForcedDown => IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAME_match_code, ri.MAINNAME_match_code ),
      IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAME_match_code, ri.MAINNAME_match_code ));
  BOOLEAN DirectADDR1WeightForcedDown := IF ( isWeightForcedDown(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code),TRUE,FALSE );
  SELF.ADDR1Weight := MAP (
      DirectADDR1WeightForcedDown => IF ( isLeftWinner(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code ), le.ADDR1Weight, ri.ADDR1Weight ),
      IF ( isLeftWinner(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code ), le.ADDR1Weight, ri.ADDR1Weight ));
  SELF.ADDR1_match_code :=  MAP (
      DirectADDR1WeightForcedDown => IF ( isLeftWinner(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code ), le.ADDR1_match_code, ri.ADDR1_match_code ),
      IF ( isLeftWinner(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code ), le.ADDR1_match_code, ri.ADDR1_match_code ));
  BOOLEAN DirectLOCALEWeightForcedDown := IF ( isWeightForcedDown(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code),TRUE,FALSE );
  SELF.LOCALEWeight := MAP (
      DirectLOCALEWeightForcedDown => IF ( isLeftWinner(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code ), le.LOCALEWeight, ri.LOCALEWeight ),
      IF ( isLeftWinner(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code ), le.LOCALEWeight, ri.LOCALEWeight ));
  SELF.LOCALE_match_code :=  MAP (
      DirectLOCALEWeightForcedDown => IF ( isLeftWinner(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code ), le.LOCALE_match_code, ri.LOCALE_match_code ),
      IF ( isLeftWinner(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code ), le.LOCALE_match_code, ri.LOCALE_match_code ));
  BOOLEAN DirectADDRESSWeightForcedDown := IF ( isWeightForcedDown(le.ADDRESSWeight,ri.ADDRESSWeight,le.ADDRESS_match_code,ri.ADDRESS_match_code),TRUE,FALSE );
  SELF.ADDRESSWeight := MAP (
      DirectADDRESSWeightForcedDown => IF ( isLeftWinner(le.ADDRESSWeight,ri.ADDRESSWeight,le.ADDRESS_match_code,ri.ADDRESS_match_code ), le.ADDRESSWeight, ri.ADDRESSWeight ),
      IF ( isLeftWinner(le.ADDRESSWeight,ri.ADDRESSWeight,le.ADDRESS_match_code,ri.ADDRESS_match_code ), le.ADDRESSWeight, ri.ADDRESSWeight ));
  SELF.ADDRESS_match_code :=  MAP (
      DirectADDRESSWeightForcedDown => IF ( isLeftWinner(le.ADDRESSWeight,ri.ADDRESSWeight,le.ADDRESS_match_code,ri.ADDRESS_match_code ), le.ADDRESS_match_code, ri.ADDRESS_match_code ),
      IF ( isLeftWinner(le.ADDRESSWeight,ri.ADDRESSWeight,le.ADDRESS_match_code,ri.ADDRESS_match_code ), le.ADDRESS_match_code, ri.ADDRESS_match_code ));
  BOOLEAN DirectFULLNAMEWeightForcedDown := IF ( isWeightForcedDown(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code),TRUE,FALSE );
  SELF.FULLNAMEWeight := MAP (
      DirectFULLNAMEWeightForcedDown => IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAMEWeight, ri.FULLNAMEWeight ),
      IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAMEWeight, ri.FULLNAMEWeight ));
  SELF.FULLNAME_match_code :=  MAP (
      DirectFULLNAMEWeightForcedDown => IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAME_match_code, ri.FULLNAME_match_code ),
      IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAME_match_code, ri.FULLNAME_match_code ));
  SELF.keys_used := le.keys_used | ri.keys_used;
  SELF.keys_failed := le.keys_failed | ri.keys_failed;
  SELF.ForceFailed := IF(In_disableForce, FALSE, (((SELF.DOB_match_code = SALT311.MatchCode.GenerationNoMatch) OR (SELF.DOBWeight_year<>0 OR SELF.DOBWeight_month<>0 OR SELF.DOBWeight_day<>0) AND (SELF.DOBWeight < Config.DOB_Force))) OR (SELF.FNAMEWeight < Config.FNAME_Force));
  INTEGER2 Weight := MAX(0, SELF.SRCWeight) + MAX(0, SELF.SSNWeight) + MAX(0, SELF.DOBWeight) + MAX(0, SELF.LEXIDWeight) + MAX(0, SELF.GENDERWeight) + ((MAX(0, SELF.PRIM_RANGEWeight) + MAX(0, SELF.SEC_RANGEWeight) + MAX(0, SELF.PRIM_NAMEWeight)) + (MAX(0, SELF.CITY_NAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.ZIPWeight))) + (MAX(SELF.MAINNAMEWeight, (MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.LNAMEWeight))) + MAX(0, SELF.SUFFIXWeight));
  SELF.Weight := IF(Weight>0,Weight,MAX(le.Weight,ri.Weight));
  SELF := le;
END;
 
SHARED OutputLayout_Base := RECORD,MAXLENGTH(32000)
  BOOLEAN Verified := FALSE; // has found possible results
  BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best
  BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best
  BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best
  BOOLEAN IsTruncated := FALSE; // more results available than were returned
  BOOLEAN Resolved := FALSE; // certain with 3 nines of accuracy
  DATASET(LayoutScoredFetch) Results;
  Config.KeysBitmapType keys_tried := 0;
END;
EXPORT OutputLayout := RECORD(OutputLayout_Base),MAXLENGTH(32000)
  InputLayout;
END;
EXPORT OutputLayout_Batch := RECORD(OutputLayout_Base),MAXLENGTH(32006)
  SALT311.UIDType Reference;
END;
EXPORT MAC_Add_ResolutionFlags() := MACRO
  SELF.Verified := EXISTS(SELF.results);
  SELF.Ambiguous := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) >= 20;
  SELF.ShortList := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) < 20 AND SELF.verified;
  SELF.Handful := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-3)) < 6 AND SELF.verified;
  SELF.Resolved := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-5)) = 1;
ENDMACRO;
EXPORT ScoreSummary(DATASET(OutputLayout_Base) ds0) := FUNCTION
  ds := PROJECT(ds0(EXISTS(Results)),TRANSFORM(LayoutScoredFetch,SELF := LEFT.Results[1]));
  R := RECORD
    SALT311.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF.Summary := IF(le.SRCWeight = 0,'','|'+IF(le.SRCWeight < 0,'-','')+'SRC')+IF(le.SSNWeight = 0,'','|'+IF(le.SSNWeight < 0,'-','')+'SSN')+IF(le.DOBWeight_year+le.DOBWeight_month+le.DOBWeight_day=0,'','|'+IF(le.DOBWeight_year+le.DOBWeight_month+le.DOBWeight_day<0,'-','')+'DOB')+IF(le.LEXIDWeight = 0,'','|'+IF(le.LEXIDWeight < 0,'-','')+'LEXID')+IF(le.SUFFIXWeight = 0,'','|'+IF(le.SUFFIXWeight < 0,'-','')+'SUFFIX')+IF(le.FNAMEWeight = 0,'','|'+IF(le.FNAMEWeight < 0,'-','')+'FNAME')+IF(le.MNAMEWeight = 0,'','|'+IF(le.MNAMEWeight < 0,'-','')+'MNAME')+IF(le.LNAMEWeight = 0,'','|'+IF(le.LNAMEWeight < 0,'-','')+'LNAME')+IF(le.GENDERWeight = 0,'','|'+IF(le.GENDERWeight < 0,'-','')+'GENDER')+IF(le.PRIM_NAMEWeight = 0,'','|'+IF(le.PRIM_NAMEWeight < 0,'-','')+'PRIM_NAME')+IF(le.PRIM_RANGEWeight = 0,'','|'+IF(le.PRIM_RANGEWeight < 0,'-','')+'PRIM_RANGE')+IF(le.SEC_RANGEWeight = 0,'','|'+IF(le.SEC_RANGEWeight < 0,'-','')+'SEC_RANGE')+IF(le.CITY_NAMEWeight = 0,'','|'+IF(le.CITY_NAMEWeight < 0,'-','')+'CITY_NAME')+IF(le.STWeight = 0,'','|'+IF(le.STWeight < 0,'-','')+'ST')+IF(le.ZIPWeight = 0,'','|'+IF(le.ZIPWeight < 0,'-','')+'ZIP')+IF(le.DT_FIRST_SEENWeight = 0,'','|'+IF(le.DT_FIRST_SEENWeight < 0,'-','')+'DT_FIRST_SEEN')+IF(le.DT_LAST_SEENWeight = 0,'','|'+IF(le.DT_LAST_SEENWeight < 0,'-','')+'DT_LAST_SEEN')+IF(le.MAINNAMEWeight = 0,'','|'+IF(le.MAINNAMEWeight < 0,'-','')+'MAINNAME')+IF(le.ADDR1Weight = 0,'','|'+IF(le.ADDR1Weight < 0,'-','')+'ADDR1')+IF(le.LOCALEWeight = 0,'','|'+IF(le.LOCALEWeight < 0,'-','')+'LOCALE')+IF(le.ADDRESSWeight = 0,'','|'+IF(le.ADDRESSWeight < 0,'-','')+'ADDRESS')+IF(le.FULLNAMEWeight = 0,'','|'+IF(le.FULLNAMEWeight < 0,'-','')+'FULLNAME');
  END;
  P := PROJECT(ds,tosummary(LEFT));
  RETURN SORT(TABLE(P,{Summary, Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
 
EXPORT KeysBitmapDecode(Config.KeysBitmapType bitmap,STRING prefix='') := FUNCTION
  MapLP(UNSIGNED1 code,STRING prefix='') := CASE(code,1=>IF(prefix<>'',prefix,'UBER'),2=>IF(prefix<>'',prefix+'NOMATCH','NOMATCH'),'');
  REC := {STRING txt};
  ds := DATASET([{''}],REC);
  REC decode(REC le, UNSIGNED1 c) := TRANSFORM
    SELF.txt := le.txt+IF((bitmap&(1<<c-1))>0,MapLP(c,prefix),'');
  END;
  N0 := NORMALIZE(ds,1,decode(LEFT,COUNTER));
  REC aggregateCodes(REC le, REC ri) := TRANSFORM
     SELF.txt := ri.txt + IF(le.txt<>'','|'+le.txt+'|','');
  END;
  agg := AGGREGATE(N0,REC,AggregateCodes(LEFT,RIGHT),FEW);
  RETURN agg[1].txt;
END;
 
EXPORT AdjustKeysUsedAndFailed(DATASET(LayoutScoredFetch) in_data) := FUNCTION
  LayoutScoredFetch AdjustFlags(LayoutScoredFetch le, Config.KeysBitmapType flagFail) := TRANSFORM
    SELF.keys_used := le.keys_used | flagFail;
    SELF.keys_failed := le.keys_failed | flagFail;
    SELF := le;
  END;
  outR := { Config.KeysBitmapType keys_failed; };
  outR AggregateFlags(LayoutScoredFetch le, outR ri) := TRANSFORM
    SELF.keys_failed := ri.keys_failed | le.keys_failed;
  END;
  agg := AGGREGATE(in_data(nomatch_id=0,RID=0),outR,AggregateFlags(LEFT,RIGHT),FEW);
  flgFail := agg[1].keys_failed;
  RETURN IF(COUNT(in_data(nomatch_id = 0,RID = 0)) > 0, IF(COUNT(in_data(nomatch_id <> 0 OR RID <> 0)) > 0, PROJECT(in_data(nomatch_id <> 0 OR RID <> 0), AdjustFlags(LEFT, flgFail)), PROJECT(in_data(nomatch_id = 0,RID = 0)[1..1], AdjustFlags(LEFT, flgFail))), in_data);
END;
EXPORT AdjustScoresForNonExactMatches(DATASET(LayoutScoredFetch) in_data) := FUNCTION
 
aggregateRec := RECORD
  in_data.reference;
  SRCWeight := MAX(GROUP,IF( in_data.SRC_match_code=SALT311.MatchCode.ExactMatch, in_data.SRCWeight,0 ));
  SSNWeight := MAX(GROUP,IF( in_data.SSN_match_code=SALT311.MatchCode.ExactMatch, in_data.SSNWeight,0 ));
  DOBWeight := MAX(GROUP,IF( in_data.DOB_year_match_code=SALT311.MatchCode.ExactMatch AND in_data.DOB_month_match_code=SALT311.MatchCode.ExactMatch AND in_data.DOB_day_match_code=SALT311.MatchCode.ExactMatch, in_data.DOBWeight,0 ));
  LEXIDWeight := MAX(GROUP,IF( in_data.LEXID_match_code=SALT311.MatchCode.ExactMatch, in_data.LEXIDWeight,0 ));
  SUFFIXWeight := MAX(GROUP,IF( in_data.SUFFIX_match_code=SALT311.MatchCode.ExactMatch, in_data.SUFFIXWeight,0 ));
  FNAMEWeight := MAX(GROUP,IF( in_data.FNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.FNAMEWeight,0 ));
  MNAMEWeight := MAX(GROUP,IF( in_data.MNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.MNAMEWeight,0 ));
  LNAMEWeight := MAX(GROUP,IF( in_data.LNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.LNAMEWeight,0 ));
  GENDERWeight := MAX(GROUP,IF( in_data.GENDER_match_code=SALT311.MatchCode.ExactMatch, in_data.GENDERWeight,0 ));
  PRIM_NAMEWeight := MAX(GROUP,IF( in_data.PRIM_NAME_match_code=SALT311.MatchCode.ExactMatch, in_data.PRIM_NAMEWeight,0 ));
  PRIM_RANGEWeight := MAX(GROUP,IF( in_data.PRIM_RANGE_match_code=SALT311.MatchCode.ExactMatch, in_data.PRIM_RANGEWeight,0 ));
  SEC_RANGEWeight := MAX(GROUP,IF( in_data.SEC_RANGE_match_code=SALT311.MatchCode.ExactMatch, in_data.SEC_RANGEWeight,0 ));
  CITY_NAMEWeight := MAX(GROUP,IF( in_data.CITY_NAME_match_code=SALT311.MatchCode.ExactMatch, in_data.CITY_NAMEWeight,0 ));
  STWeight := MAX(GROUP,IF( in_data.ST_match_code=SALT311.MatchCode.ExactMatch, in_data.STWeight,0 ));
  ZIPWeight := MAX(GROUP,IF( in_data.ZIP_match_code=SALT311.MatchCode.ExactMatch, in_data.ZIPWeight,0 ));
  DT_FIRST_SEENWeight := MAX(GROUP,IF( in_data.DT_FIRST_SEEN_match_code=SALT311.MatchCode.ExactMatch, in_data.DT_FIRST_SEENWeight,0 ));
  DT_LAST_SEENWeight := MAX(GROUP,IF( in_data.DT_LAST_SEEN_match_code=SALT311.MatchCode.ExactMatch, in_data.DT_LAST_SEENWeight,0 ));
  MAINNAMEWeight := MAX(GROUP,IF( in_data.MAINNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.MAINNAMEWeight,0 ));
  ADDR1Weight := MAX(GROUP,IF( in_data.ADDR1_match_code=SALT311.MatchCode.ExactMatch, in_data.ADDR1Weight,0 ));
  LOCALEWeight := MAX(GROUP,IF( in_data.LOCALE_match_code=SALT311.MatchCode.ExactMatch, in_data.LOCALEWeight,0 ));
  ADDRESSWeight := MAX(GROUP,IF( in_data.ADDRESS_match_code=SALT311.MatchCode.ExactMatch, in_data.ADDRESSWeight,0 ));
  FULLNAMEWeight := MAX(GROUP,IF( in_data.FULLNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.FULLNAMEWeight,0 ));
END;
  R1 := TABLE(in_data,aggregateRec,Reference);
 
LayoutScoredFetch FixScores(LayoutScoredFetch le, aggregateRec ri) := TRANSFORM
  SELF.SRCWeight := MAP( ri.SRCWeight=0 OR le.SRC_match_code=SALT311.MatchCode.ExactMatch => le.SRCWeight,MIN(le.SRCWeight,ri.SRCWeight-1) );
  SELF.SSNWeight := MAP( ri.SSNWeight=0 OR le.SSN_match_code=SALT311.MatchCode.ExactMatch => le.SSNWeight,MIN(le.SSNWeight,ri.SSNWeight-1) );
  SELF.DOBWeight := MAP( ri.DOBWeight=0 OR (le.DOB_year_match_code=SALT311.MatchCode.ExactMatch AND le.DOB_month_match_code=SALT311.MatchCode.ExactMatch AND le.DOB_day_match_code=SALT311.MatchCode.ExactMatch) => le.DOBWeight,MIN(le.DOBWeight,ri.DOBWeight-1) );
  SELF.LEXIDWeight := MAP( ri.LEXIDWeight=0 OR le.LEXID_match_code=SALT311.MatchCode.ExactMatch => le.LEXIDWeight,MIN(le.LEXIDWeight,ri.LEXIDWeight-1) );
  SELF.SUFFIXWeight := MAP( ri.SUFFIXWeight=0 OR le.SUFFIX_match_code=SALT311.MatchCode.ExactMatch => le.SUFFIXWeight,MIN(le.SUFFIXWeight,ri.SUFFIXWeight-1) );
  SELF.FNAMEWeight := MAP( ri.FNAMEWeight=0 OR le.FNAME_match_code=SALT311.MatchCode.ExactMatch => le.FNAMEWeight,MIN(le.FNAMEWeight,ri.FNAMEWeight-1) );
  SELF.MNAMEWeight := MAP( ri.MNAMEWeight=0 OR le.MNAME_match_code=SALT311.MatchCode.ExactMatch => le.MNAMEWeight,MIN(le.MNAMEWeight,ri.MNAMEWeight-1) );
  SELF.LNAMEWeight := MAP( ri.LNAMEWeight=0 OR le.LNAME_match_code=SALT311.MatchCode.ExactMatch => le.LNAMEWeight,MIN(le.LNAMEWeight,ri.LNAMEWeight-1) );
  SELF.GENDERWeight := MAP( ri.GENDERWeight=0 OR le.GENDER_match_code=SALT311.MatchCode.ExactMatch => le.GENDERWeight,MIN(le.GENDERWeight,ri.GENDERWeight-1) );
  SELF.PRIM_NAMEWeight := MAP( ri.PRIM_NAMEWeight=0 OR le.PRIM_NAME_match_code=SALT311.MatchCode.ExactMatch => le.PRIM_NAMEWeight,MIN(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight-1) );
  SELF.PRIM_RANGEWeight := MAP( ri.PRIM_RANGEWeight=0 OR le.PRIM_RANGE_match_code=SALT311.MatchCode.ExactMatch => le.PRIM_RANGEWeight,MIN(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight-1) );
  SELF.SEC_RANGEWeight := MAP( ri.SEC_RANGEWeight=0 OR le.SEC_RANGE_match_code=SALT311.MatchCode.ExactMatch => le.SEC_RANGEWeight,MIN(le.SEC_RANGEWeight,ri.SEC_RANGEWeight-1) );
  SELF.CITY_NAMEWeight := MAP( ri.CITY_NAMEWeight=0 OR le.CITY_NAME_match_code=SALT311.MatchCode.ExactMatch => le.CITY_NAMEWeight,MIN(le.CITY_NAMEWeight,ri.CITY_NAMEWeight-1) );
  SELF.STWeight := MAP( ri.STWeight=0 OR le.ST_match_code=SALT311.MatchCode.ExactMatch => le.STWeight,MIN(le.STWeight,ri.STWeight-1) );
  SELF.ZIPWeight := MAP( ri.ZIPWeight=0 OR le.ZIP_match_code=SALT311.MatchCode.ExactMatch => le.ZIPWeight,MIN(le.ZIPWeight,ri.ZIPWeight-1) );
  SELF.DT_FIRST_SEENWeight := MAP( ri.DT_FIRST_SEENWeight=0 OR le.DT_FIRST_SEEN_match_code=SALT311.MatchCode.ExactMatch => le.DT_FIRST_SEENWeight,MIN(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight-1) );
  SELF.DT_LAST_SEENWeight := MAP( ri.DT_LAST_SEENWeight=0 OR le.DT_LAST_SEEN_match_code=SALT311.MatchCode.ExactMatch => le.DT_LAST_SEENWeight,MIN(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight-1) );
  SELF.MAINNAMEWeight := MAP( ri.MAINNAMEWeight=0 OR le.MAINNAME_match_code=SALT311.MatchCode.ExactMatch => le.MAINNAMEWeight,MIN(le.MAINNAMEWeight,ri.MAINNAMEWeight-1) );
  SELF.ADDR1Weight := MAP( ri.ADDR1Weight=0 OR le.ADDR1_match_code=SALT311.MatchCode.ExactMatch => le.ADDR1Weight,MIN(le.ADDR1Weight,ri.ADDR1Weight-1) );
  SELF.LOCALEWeight := MAP( ri.LOCALEWeight=0 OR le.LOCALE_match_code=SALT311.MatchCode.ExactMatch => le.LOCALEWeight,MIN(le.LOCALEWeight,ri.LOCALEWeight-1) );
  SELF.ADDRESSWeight := MAP( ri.ADDRESSWeight=0 OR le.ADDRESS_match_code=SALT311.MatchCode.ExactMatch => le.ADDRESSWeight,MIN(le.ADDRESSWeight,ri.ADDRESSWeight-1) );
  SELF.FULLNAMEWeight := MAP( ri.FULLNAMEWeight=0 OR le.FULLNAME_match_code=SALT311.MatchCode.ExactMatch => le.FULLNAMEWeight,MIN(le.FULLNAMEWeight,ri.FULLNAMEWeight-1) );
  INTEGER2 Weight := MAX(0, SELF.SRCWeight) + MAX(0, SELF.SSNWeight) + MAX(0, SELF.DOBWeight) + MAX(0, SELF.LEXIDWeight) + MAX(0, SELF.GENDERWeight) + ((MAX(0, SELF.PRIM_RANGEWeight) + MAX(0, SELF.SEC_RANGEWeight) + MAX(0, SELF.PRIM_NAMEWeight)) + (MAX(0, SELF.CITY_NAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.ZIPWeight))) + (MAX(SELF.MAINNAMEWeight, (MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.LNAMEWeight))) + MAX(0, SELF.SUFFIXWeight));
  SELF.Weight := IF(Weight>0,Weight,MAX(0,le.Weight));
  SELF := le;
END;
 
  R2 := JOIN(in_data,R1,LEFT.reference=RIGHT.reference,FixScores(LEFT,RIGHT));
  RETURN SORT(GROUP(R2,Reference,ALL),-weight,nomatch_id);
END;
EXPORT CombineAllScores(DATASET(LayoutScoredFetch) in_data, BOOLEAN In_disableForce = FALSE) := FUNCTION
  OutputLayout_Batch Create_Output(LayoutScoredFetch le, DATASET(LayoutScoredFetch) ri) := TRANSFORM
    SELF.Results := ri;
    SELF.Reference := le.Reference;
    MAC_Add_ResolutionFlags()
  END;
  r0 := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(Reference)),Reference, LOCAL ), Reference, LOCAL),nomatch_id),LEFT.nomatch_id=RIGHT.nomatch_id,Combine_Scores(LEFT,RIGHT,In_disableForce))(SALT311.DebugMode OR ~ForceFailed);
  r1 := AdjustScoresForNonExactMatches(UNGROUP(r0));
  R2 := ROLLUP( TOPN(r1,100,-Weight),GROUP, Create_Output(LEFT,ROWS(LEFT)) );
  SALT311.MAC_External_AddPcnt(R2,LayoutScoredFetch,Results,OutputLayout_Batch,18,R3);
  RETURN r3;
END;
EXPORT CombineLinkpathScores(DATASET(LayoutScoredFetch) in_data, BOOLEAN In_disableForce = TRUE) := FUNCTION
// Note - results are returned distributed by HASH(reference) - this is part of the specification
  rolled := ROLLUP ( SORT( DISTRIBUTE( in_data, HASH(reference) ), Reference, nomatch_id, LOCAL), Combine_Scores(LEFT,RIGHT, In_disableForce), Reference, nomatch_id, LOCAL);
  RETURN DEDUP( SORT( rolled, Reference, -weight, LOCAL ), Reference, KEEP(Config.LinkpathCandidateCount),LOCAL);
END;
EXPORT KeysUsedToText(UNSIGNED4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','') + IF(k&(1<<1)<>0,'NOMATCH,','');
  RETURN list[1..LENGTH(TRIM(list))-1]; // Strim last ,
end;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT311.UIDType nomatch_id;
  DATASET(SALT311.Layout_FieldValueList) SRC_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) SSN_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) DOB_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) LEXID_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) GENDER_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) DT_FIRST_SEEN_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) DT_LAST_SEEN_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) ADDRESS_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) FULLNAME_Values := DATASET([],SALT311.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.nomatch_id := le.nomatch_id;
    SELF.SRC_values := SALT311.fn_combine_fieldvaluelist(le.SRC_values,ri.SRC_values);
    SELF.SSN_values := SALT311.fn_combine_fieldvaluelist(le.SSN_values,ri.SSN_values);
    SELF.DOB_values := SALT311.fn_combine_fieldvaluelist(le.DOB_values,ri.DOB_values);
    SELF.LEXID_values := SALT311.fn_combine_fieldvaluelist(le.LEXID_values,ri.LEXID_values);
    SELF.GENDER_values := SALT311.fn_combine_fieldvaluelist(le.GENDER_values,ri.GENDER_values);
    SELF.DT_FIRST_SEEN_values := SALT311.fn_combine_fieldvaluelist(le.DT_FIRST_SEEN_values,ri.DT_FIRST_SEEN_values);
    SELF.DT_LAST_SEEN_values := SALT311.fn_combine_fieldvaluelist(le.DT_LAST_SEEN_values,ri.DT_LAST_SEEN_values);
    SELF.ADDRESS_values := SALT311.fn_combine_fieldvaluelist(le.ADDRESS_values,ri.ADDRESS_values);
    SELF.FULLNAME_values := SALT311.fn_combine_fieldvaluelist(le.FULLNAME_values,ri.FULLNAME_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(nomatch_id) ), nomatch_id, LOCAL ), LEFT.nomatch_id = RIGHT.nomatch_id, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.nomatch_id := le.nomatch_id;
    SELF.SRC_values := SORT(le.SRC_values, -cnt, val, LOCAL);
    SELF.SSN_values := SORT(le.SSN_values, -cnt, val, LOCAL);
    SELF.DOB_values := SORT(le.DOB_values, -cnt, val, LOCAL);
    SELF.LEXID_values := SORT(le.LEXID_values, -cnt, val, LOCAL);
    SELF.GENDER_values := SORT(le.GENDER_values, -cnt, val, LOCAL);
    SELF.DT_FIRST_SEEN_values := SORT(le.DT_FIRST_SEEN_values, -cnt, val, LOCAL);
    SELF.DT_LAST_SEEN_values := SORT(le.DT_LAST_SEEN_values, -cnt, val, LOCAL);
    SELF.ADDRESS_values := SORT(le.ADDRESS_values, -cnt, val, LOCAL);
    SELF.FULLNAME_values := SORT(le.FULLNAME_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(RECORDOF(Key)) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.nomatch_id := le.nomatch_id;
  SELF.SRC_Values := DATASET([{TRIM((SALT311.StrType)le.SRC)}],SALT311.Layout_FieldValueList);
  SELF.SSN_Values := IF ( (SALT311.StrType)le.SSN = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.SSN)}],SALT311.Layout_FieldValueList));
  self.DOB_Values := IF ( (unsigned)le.DOB = 0,dataset([],SALT311.Layout_FieldValueList),dataset([{(SALT311.StrType)le.DOB}],SALT311.Layout_FieldValueList));
  SELF.LEXID_Values := IF ( (SALT311.StrType)le.LEXID = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.LEXID)}],SALT311.Layout_FieldValueList));
  SELF.GENDER_Values := IF ( (SALT311.StrType)le.GENDER = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.GENDER)}],SALT311.Layout_FieldValueList));
  SELF.DT_FIRST_SEEN_Values := DATASET([{TRIM((SALT311.StrType)le.DT_FIRST_SEEN)}],SALT311.Layout_FieldValueList);
  SELF.DT_LAST_SEEN_Values := DATASET([{TRIM((SALT311.StrType)le.DT_LAST_SEEN)}],SALT311.Layout_FieldValueList);
  SELF.ADDRESS_Values := IF ( (SALT311.StrType)le.PRIM_RANGE = '' AND (SALT311.StrType)le.SEC_RANGE = '' AND (SALT311.StrType)le.PRIM_NAME = '' AND (SALT311.StrType)le.CITY_NAME = '' AND (SALT311.StrType)le.ST = '' AND (SALT311.StrType)le.ZIP = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT311.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT311.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT311.StrType)le.CITY_NAME) + ' ' + TRIM((SALT311.StrType)le.ST) + ' ' + TRIM((SALT311.StrType)le.ZIP)}],SALT311.Layout_FieldValueList));
  SELF.FULLNAME_Values := IF ( (SALT311.StrType)le.FNAME = '' AND (SALT311.StrType)le.MNAME = '' AND (SALT311.StrType)le.LNAME = '' AND (SALT311.StrType)le.SUFFIX = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.FNAME) + ' ' + TRIM((SALT311.StrType)le.MNAME) + ' ' + TRIM((SALT311.StrType)le.LNAME) + ' ' + TRIM((SALT311.StrType)le.SUFFIX)}],SALT311.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
// Records which already had the nomatch_id on them may not be up to date. Update those IDs
EXPORT UpdateIDs(DATASET(InputLayout) in) := FUNCTION
  id_stream_layout init(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.nomatch_id := le.Entered_nomatch_id;
    SELF.RID := le.Entered_RID;
    SELF.Weight := Config.MatchThreshold; // Assume at least 'threshold' met
    SELF.Score := 100;
  END;
  idupdate_candidates := PROJECT(in,init(LEFT));
  ids_updated0 := id_stream_historic(idupdate_candidates);
  ids_updated := PROJECT(ids_updated0,TRANSFORM(LayoutScoredFetch,SELF.Reference:=LEFT.UniqueId,SELF.keys_used:=0,SELF.keys_failed:=0,SELF:=LEFT));
  RETURN CombineLinkpathScores(ids_updated);
END;
END;
