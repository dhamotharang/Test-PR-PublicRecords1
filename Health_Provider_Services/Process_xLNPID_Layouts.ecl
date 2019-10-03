EXPORT Process_xLNPID_Layouts := MODULE
 
IMPORT SALT311;
SHARED h := File_HealthProvider;//The input file
 
EXPORT KeyName := Health_Provider_Services.Files.FILE_Header_SF; //'~'+'key::Health_Provider_Services::LNPID::meow';
 
EXPORT Key := INDEX(h,{LNPID},{h},KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, Health_Provider_Services.Files.FILE_Header, OVERWRITE);
EXPORT id_stream_layout := RECORD
    SALT311.UIDType UniqueId;
    INTEGER2 Weight;
    UNSIGNED2 Score;
    Config.KeysBitmapType KeysUsed := 0;
    Config.KeysBitmapType KeysFailed := 0;
    BOOLEAN IsTruncated := FALSE;
    UNSIGNED8 LNPID;
END;
EXPORT Fetch_Stream(DATASET(id_stream_layout) d) := FUNCTION
    k := Key;
    DLayout := RECORD
      id_stream_layout;
      BOOLEAN did_fetch;
      RECORDOF(k) AND NOT id_stream_layout; // No HEADERSEARCH specified 
    END;
    DLayout tr(id_stream_layout le, k ri) := TRANSFORM
      SELF.did_fetch := ri.LNPID<>0;
      SELF.LNPID := IF ( SELF.did_fetch, ri.LNPID, le.LNPID ); // Copy from 'real data' if it exists
      SELF := ri;
      SELF := le;
    END;
    J := JOIN( d,k,(LEFT.LNPID = RIGHT.LNPID),tr(LEFT,RIGHT), LEFT OUTER, KEEP(Config.JoinLimit)); // Ignore excess records without error
    RETURN J;
END;
 
EXPORT Fetch_Stream_Expanded(DATASET(id_stream_layout) d) := FUNCTION
  rd1 := Fetch_Stream(d);
  RETURN rd1(did_fetch OR KeysFailed<>0);
END;
 
EXPORT MAC_Fetch_Batch(infile, In_LNPID, In_UniqueID, asIndex = TRUE) := FUNCTIONMACRO
  IMPORT SALT311,Health_Provider_Services;
  payloadKey := Health_Provider_Services.Process_xLNPID_Layouts.Key;
  idHistKey := Health_Provider_Services.Process_xLNPID_Layouts.KeyIDHistory;
  outLayout := RECORD
    infile.In_UniqueID;
    SALT311.UIDType inputLNPID;
    RECORDOF(payloadKey);
  END;
  outLayout emptyResult(infile le) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputLNPID := le.In_LNPID;
    SELF := [];
  END;
 
  outLayout xJoinHist(outLayout le, idHistKey ri) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputLNPID := le.inputLNPID;
    SELF := ri;
    SELF := [];
  END;
 
  outLayout xJoinPayload(outLayout le, payloadKey ri) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputLNPID := le.inputLNPID;
    SELF := ri;
  END;
 
  infile_emptyResult := PROJECT(infile, emptyResult(LEFT));
  JEntKeyed := JOIN(infile_emptyResult, payloadKey, LEFT.inputLNPID = RIGHT.LNPID, xJoinPayload(LEFT,RIGHT), LEFT OUTER);
  JEntPull := JOIN(infile_emptyResult, PULL(payloadKey), LEFT.inputLNPID = RIGHT.LNPID, xJoinPayload(LEFT,RIGHT), LEFT OUTER, HASH);
 
  resultsEnt := IF(asIndex, JEntKeyed, JEntPull);
  resultsEnt_found := resultsEnt(LNPID > 0);
  resultsEnt_notfound := resultsEnt(LNPID = 0);
 
  JRecKeyed_1 := JOIN(resultsEnt_notfound, idHistKey, LEFT.inputLNPID = RIGHT., xJoinHist(LEFT,RIGHT), LEFT OUTER);
  JRecPull_1 := JOIN(resultsEnt_notfound, PULL(idHistKey), LEFT.inputLNPID = RIGHT., xJoinHist(LEFT,RIGHT), LEFT OUTER, HASH);
 
  resultsIDHist := IF(asIndex, JRecKeyed_1, JRecPull_1);
  resultsIDHist_found := resultsIDHist(LNPID > 0);
  resultsIDHist_notfound := resultsIDHist(LNPID = 0);
 
  JRecKeyed_2 := JOIN(resultsIDHist_found, payloadKey, LEFT.LNPID = RIGHT.LNPID, xJoinPayload(LEFT,RIGHT), LEFT OUTER);
  JRecPull_2 := JOIN(resultsIDHist_found, PULL(payloadKey), LEFT.LNPID = RIGHT.LNPID, xJoinPayload(LEFT,RIGHT), LEFT OUTER, HASH);
 
  resultsIDHistAll := IF(asIndex, JRecKeyed_2, JRecPull_2);
  resultsAll := resultsEnt_found & resultsIDHistAll & PROJECT(resultsIDHist_notfound, TRANSFORM(outLayout, SELF.inputLNPID := LEFT.inputLNPID, SELF.In_UniqueID := LEFT.In_UniqueID,  SELF := []));
 
  RETURN resultsAll;
ENDMACRO;
 
EXPORT InputLayout := RECORD
  SALT311.UIDType UniqueId; // This had better be unique or it will all break horribly
  UNSIGNED2 MaxIDs := 50; // Maximum number of candidate IDs
  UNSIGNED2 LeadThreshold := 0; // Maximum distance from best to worst (0 => no pruning)
  h.FNAME;
  h.MNAME;
  h.LNAME;
  h.SNAME;
  h.GENDER;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.V_CITY_NAME;
  h.ST;
  h.ZIP;
  h.SSN;
  h.CNSMR_SSN;
  h.DOB;
  h.CNSMR_DOB;
  h.PHONE;
  h.LIC_STATE;
  h.C_LIC_NBR;
  h.TAX_ID;
  h.BILLING_TAX_ID;
  h.DEA_NUMBER;
  h.VENDOR_ID;
  h.NPI_NUMBER;
  h.BILLING_NPI_NUMBER;
  h.UPIN;
  h.DID;
  h.BDID;
  h.SRC;
  h.SOURCE_RID;
  h.RID;
  SALT311.StrType MAINNAME;//Wordbag field for concept
  SALT311.StrType FULLNAME;//Wordbag field for concept
  SALT311.StrType ADDR1;//Wordbag field for concept
  SALT311.StrType LOCALE;//Wordbag field for concept
  SALT311.StrType ADDRESS;//Wordbag field for concept
// Below only used in header search (data returning) case
  BOOLEAN MatchRecords := false; // Only show records which match
  BOOLEAN FullMatch := false; // Only show LNPID if it has a record which fully matches
  SALT311.UIDType Entered_LNPID := 0; // Allow user to enter LNPID to pull data
END;
// Used to clean input to MEOW process that is already in input layout
EXPORT CleanInput(DATASET(InputLayout) inData) := FUNCTION
  InputLayout CleanT(inData le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.FNAME := (TYPEOF(SELF.FNAME))Health_Provider_Services.Fields.Make_FNAME((SALT311.StrType)le.FNAME);
    SELF.MNAME := (TYPEOF(SELF.MNAME))Health_Provider_Services.Fields.Make_MNAME((SALT311.StrType)le.MNAME);
    SELF.LNAME := (TYPEOF(SELF.LNAME))Health_Provider_Services.Fields.Make_LNAME((SALT311.StrType)le.LNAME);
    SELF.SNAME := (TYPEOF(SELF.SNAME))Health_Provider_Services.Fields.Make_SNAME((SALT311.StrType)le.SNAME);
    SELF.GENDER := (TYPEOF(SELF.GENDER))Health_Provider_Services.Fields.Make_GENDER((SALT311.StrType)le.GENDER);
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))Health_Provider_Services.Fields.Make_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE);
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))Health_Provider_Services.Fields.Make_PRIM_NAME((SALT311.StrType)le.PRIM_NAME);
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))Health_Provider_Services.Fields.Make_SEC_RANGE((SALT311.StrType)le.SEC_RANGE);
    SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))Health_Provider_Services.Fields.Make_V_CITY_NAME((SALT311.StrType)le.V_CITY_NAME);
    SELF.ST := (TYPEOF(SELF.ST))Health_Provider_Services.Fields.Make_ST((SALT311.StrType)le.ST);
    SELF.ZIP := (TYPEOF(SELF.ZIP))Health_Provider_Services.Fields.Make_ZIP((SALT311.StrType)le.ZIP);
    SELF.SSN := (TYPEOF(SELF.SSN))Health_Provider_Services.Fields.Make_SSN((SALT311.StrType)le.SSN);
    SELF.CNSMR_SSN := (TYPEOF(SELF.CNSMR_SSN))Health_Provider_Services.Fields.Make_CNSMR_SSN((SALT311.StrType)le.CNSMR_SSN);
    SELF.DOB := (TYPEOF(SELF.DOB))Health_Provider_Services.Fields.Make_DOB((SALT311.StrType)le.DOB);
    SELF.CNSMR_DOB := (TYPEOF(SELF.CNSMR_DOB))Health_Provider_Services.Fields.Make_CNSMR_DOB((SALT311.StrType)le.CNSMR_DOB);
    SELF.PHONE := (TYPEOF(SELF.PHONE))Health_Provider_Services.Fields.Make_PHONE((SALT311.StrType)le.PHONE);
    SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))Health_Provider_Services.Fields.Make_LIC_STATE((SALT311.StrType)le.LIC_STATE);
    SELF.C_LIC_NBR := (TYPEOF(SELF.C_LIC_NBR))Health_Provider_Services.Fields.Make_C_LIC_NBR((SALT311.StrType)le.C_LIC_NBR);
    SELF.TAX_ID := (TYPEOF(SELF.TAX_ID))Health_Provider_Services.Fields.Make_TAX_ID((SALT311.StrType)le.TAX_ID);
    SELF.BILLING_TAX_ID := (TYPEOF(SELF.BILLING_TAX_ID))Health_Provider_Services.Fields.Make_BILLING_TAX_ID((SALT311.StrType)le.BILLING_TAX_ID);
    SELF.DEA_NUMBER := (TYPEOF(SELF.DEA_NUMBER))Health_Provider_Services.Fields.Make_DEA_NUMBER((SALT311.StrType)le.DEA_NUMBER);
    SELF.VENDOR_ID := (TYPEOF(SELF.VENDOR_ID))Health_Provider_Services.Fields.Make_VENDOR_ID((SALT311.StrType)le.VENDOR_ID);
    SELF.NPI_NUMBER := (TYPEOF(SELF.NPI_NUMBER))Health_Provider_Services.Fields.Make_NPI_NUMBER((SALT311.StrType)le.NPI_NUMBER);
    SELF.BILLING_NPI_NUMBER := (TYPEOF(SELF.BILLING_NPI_NUMBER))Health_Provider_Services.Fields.Make_BILLING_NPI_NUMBER((SALT311.StrType)le.BILLING_NPI_NUMBER);
    SELF.UPIN := (TYPEOF(SELF.UPIN))Health_Provider_Services.Fields.Make_UPIN((SALT311.StrType)le.UPIN);
    SELF.DID := (TYPEOF(SELF.DID))Health_Provider_Services.Fields.Make_DID((SALT311.StrType)le.DID);
    SELF.BDID := (TYPEOF(SELF.BDID))Health_Provider_Services.Fields.Make_BDID((SALT311.StrType)le.BDID);
    SELF.SRC := (TYPEOF(SELF.SRC))Health_Provider_Services.Fields.Make_SRC((SALT311.StrType)le.SRC);
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))Health_Provider_Services.Fields.Make_SOURCE_RID((SALT311.StrType)le.SOURCE_RID);
    SELF.RID := (TYPEOF(SELF.RID))Health_Provider_Services.Fields.Make_RID((SALT311.StrType)le.RID);
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))Health_Provider_Services.Fields.Make_MAINNAME((SALT311.StrType)le.MAINNAME);
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))Health_Provider_Services.Fields.Make_FULLNAME((SALT311.StrType)le.FULLNAME);
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))Health_Provider_Services.Fields.Make_ADDR1((SALT311.StrType)le.ADDR1);
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))Health_Provider_Services.Fields.Make_LOCALE((SALT311.StrType)le.LOCALE);
    SELF.ADDRESS := (TYPEOF(SELF.ADDRESS))Health_Provider_Services.Fields.Make_ADDRESS((SALT311.StrType)le.ADDRESS);
  END;
  RETURN PROJECT(inData, CleanT(LEFT));
END;
 
EXPORT LayoutScoredFetch := RECORD // Nulls required for linkpaths that do not have field
  h.LNPID;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT311.UIDType Reference := 0;//Presently for batch
  BOOLEAN ForceFailed := FALSE;
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  INTEGER2 FNAMEWeight := 0;
  INTEGER1 FNAME_match_code := 0;
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  INTEGER2 MNAMEWeight := 0;
  INTEGER1 MNAME_match_code := 0;
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  INTEGER2 LNAMEWeight := 0;
  INTEGER1 LNAME_match_code := 0;
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  INTEGER2 SNAMEWeight := 0;
  INTEGER1 SNAME_match_code := 0;
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))'';
  INTEGER2 GENDERWeight := 0;
  INTEGER1 GENDER_match_code := 0;
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  INTEGER2 PRIM_RANGEWeight := 0;
  INTEGER1 PRIM_RANGE_match_code := 0;
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  INTEGER2 PRIM_NAMEWeight := 0;
  INTEGER1 PRIM_NAME_match_code := 0;
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  INTEGER2 SEC_RANGEWeight := 0;
  INTEGER1 SEC_RANGE_match_code := 0;
  TYPEOF(h.V_CITY_NAME) V_CITY_NAME := (TYPEOF(h.V_CITY_NAME))'';
  INTEGER2 V_CITY_NAMEWeight := 0;
  INTEGER1 V_CITY_NAME_match_code := 0;
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  INTEGER2 STWeight := 0;
  INTEGER1 ST_match_code := 0;
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  INTEGER2 ZIPWeight := 0;
  INTEGER1 ZIP_match_code := 0;
  TYPEOF(h.SSN) SSN := (TYPEOF(h.SSN))'';
  INTEGER2 SSNWeight := 0;
  INTEGER1 SSN_match_code := 0;
  TYPEOF(h.CNSMR_SSN) CNSMR_SSN := (TYPEOF(h.CNSMR_SSN))'';
  INTEGER2 CNSMR_SSNWeight := 0;
  INTEGER1 CNSMR_SSN_match_code := 0;
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
  UNSIGNED2 CNSMR_DOB_year := 0;
  UNSIGNED1 CNSMR_DOB_month := 0;
  UNSIGNED1 CNSMR_DOB_day := 0;
  INTEGER2 CNSMR_DOBWeight := 0;
  INTEGER1 CNSMR_DOB_match_code := 0;
  INTEGER2 CNSMR_DOBWeight_year := 0;
  INTEGER1 CNSMR_DOB_year_match_code := 0;
  INTEGER2 CNSMR_DOBWeight_month := 0;
  INTEGER1 CNSMR_DOB_month_match_code := 0;
  INTEGER2 CNSMR_DOBWeight_day := 0;
  INTEGER1 CNSMR_DOB_day_match_code := 0;
  TYPEOF(h.PHONE) PHONE := (TYPEOF(h.PHONE))'';
  INTEGER2 PHONEWeight := 0;
  INTEGER1 PHONE_match_code := 0;
  TYPEOF(h.LIC_STATE) LIC_STATE := (TYPEOF(h.LIC_STATE))'';
  INTEGER2 LIC_STATEWeight := 0;
  INTEGER1 LIC_STATE_match_code := 0;
  TYPEOF(h.C_LIC_NBR) C_LIC_NBR := (TYPEOF(h.C_LIC_NBR))'';
  INTEGER2 C_LIC_NBRWeight := 0;
  INTEGER1 C_LIC_NBR_match_code := 0;
  TYPEOF(h.TAX_ID) TAX_ID := (TYPEOF(h.TAX_ID))'';
  INTEGER2 TAX_IDWeight := 0;
  INTEGER1 TAX_ID_match_code := 0;
  TYPEOF(h.BILLING_TAX_ID) BILLING_TAX_ID := (TYPEOF(h.BILLING_TAX_ID))'';
  INTEGER2 BILLING_TAX_IDWeight := 0;
  INTEGER1 BILLING_TAX_ID_match_code := 0;
  TYPEOF(h.DEA_NUMBER) DEA_NUMBER := (TYPEOF(h.DEA_NUMBER))'';
  INTEGER2 DEA_NUMBERWeight := 0;
  INTEGER1 DEA_NUMBER_match_code := 0;
  TYPEOF(h.VENDOR_ID) VENDOR_ID := (TYPEOF(h.VENDOR_ID))'';
  INTEGER2 VENDOR_IDWeight := 0;
  INTEGER1 VENDOR_ID_match_code := 0;
  TYPEOF(h.NPI_NUMBER) NPI_NUMBER := (TYPEOF(h.NPI_NUMBER))'';
  INTEGER2 NPI_NUMBERWeight := 0;
  INTEGER1 NPI_NUMBER_match_code := 0;
  TYPEOF(h.BILLING_NPI_NUMBER) BILLING_NPI_NUMBER := (TYPEOF(h.BILLING_NPI_NUMBER))'';
  INTEGER2 BILLING_NPI_NUMBERWeight := 0;
  INTEGER1 BILLING_NPI_NUMBER_match_code := 0;
  TYPEOF(h.UPIN) UPIN := (TYPEOF(h.UPIN))'';
  INTEGER2 UPINWeight := 0;
  INTEGER1 UPIN_match_code := 0;
  TYPEOF(h.DID) DID := (TYPEOF(h.DID))'';
  INTEGER2 DIDWeight := 0;
  INTEGER1 DID_match_code := 0;
  TYPEOF(h.BDID) BDID := (TYPEOF(h.BDID))'';
  INTEGER2 BDIDWeight := 0;
  INTEGER1 BDID_match_code := 0;
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))'';
  INTEGER2 SRCWeight := 0;
  INTEGER1 SRC_match_code := 0;
  TYPEOF(h.SOURCE_RID) SOURCE_RID := (TYPEOF(h.SOURCE_RID))'';
  INTEGER2 SOURCE_RIDWeight := 0;
  INTEGER1 SOURCE_RID_match_code := 0;
  TYPEOF(h.RID) RID := (TYPEOF(h.RID))'';
  INTEGER2 RIDWeight := 0;
  INTEGER1 RID_match_code := 0;
  SALT311.StrType MAINNAME := ''; // Concepts always a wordbag
  INTEGER2 MAINNAMEWeight := 0;
  INTEGER1 MAINNAME_match_code := 0;
  SALT311.StrType FULLNAME := ''; // Concepts always a wordbag
  INTEGER2 FULLNAMEWeight := 0;
  INTEGER1 FULLNAME_match_code := 0;
  SALT311.StrType ADDR1 := ''; // Concepts always a wordbag
  INTEGER2 ADDR1Weight := 0;
  INTEGER1 ADDR1_match_code := 0;
  SALT311.StrType LOCALE := ''; // Concepts always a wordbag
  INTEGER2 LOCALEWeight := 0;
  INTEGER1 LOCALE_match_code := 0;
  SALT311.StrType ADDRESS := ''; // Concepts always a wordbag
  INTEGER2 ADDRESSWeight := 0;
  INTEGER1 ADDRESS_match_code := 0;
  Config.KeysBitmapType keys_used; // A bitmap of the keys used
  Config.KeysBitmapType keys_failed; // A bitmap of the keys that failed the fetch
END;
 
EXPORT isLeftWinner(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT311.MatchCode.NoMatch, INTEGER1 r_mc=SALT311.MatchCode.NoMatch) :=
  MAP(l_mc=r_mc => l_weight>=r_weight, // matchcodes the same; so irrelevant
      l_mc=SALT311.MatchCode.ExactMatch => TRUE, // Left (only) is exact
      r_mc=SALT311.MatchCode.ExactMatch => FALSE, // Right (only) is exact
      l_weight>=r_weight); // weight only
 
EXPORT isWeightForcedDown(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT311.MatchCode.NoMatch, INTEGER1 r_mc=SALT311.MatchCode.NoMatch) :=
  IF((isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight < r_weight)) OR  (NOT isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight > r_weight)),true,false);
 
EXPORT LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri) := TRANSFORM
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
  BOOLEAN SNAMEWeightForcedDown := IF ( isWeightForcedDown(le.SNAMEWeight,ri.SNAMEWeight,le.SNAME_match_code,ri.SNAME_match_code),TRUE,FALSE );
  SELF.SNAMEWeight := IF ( isLeftWinner(le.SNAMEWeight,ri.SNAMEWeight,le.SNAME_match_code,ri.SNAME_match_code ), le.SNAMEWeight, ri.SNAMEWeight );
  SELF.SNAME := IF ( isLeftWinner(le.SNAMEWeight,ri.SNAMEWeight,le.SNAME_match_code,ri.SNAME_match_code ), le.SNAME, ri.SNAME );
  SELF.SNAME_match_code := IF ( isLeftWinner(le.SNAMEWeight,ri.SNAMEWeight,le.SNAME_match_code,ri.SNAME_match_code ), le.SNAME_match_code, ri.SNAME_match_code );
  BOOLEAN GENDERWeightForcedDown := IF ( isWeightForcedDown(le.GENDERWeight,ri.GENDERWeight,le.GENDER_match_code,ri.GENDER_match_code),TRUE,FALSE );
  SELF.GENDERWeight := IF ( isLeftWinner(le.GENDERWeight,ri.GENDERWeight,le.GENDER_match_code,ri.GENDER_match_code ), le.GENDERWeight, ri.GENDERWeight );
  SELF.GENDER := IF ( isLeftWinner(le.GENDERWeight,ri.GENDERWeight,le.GENDER_match_code,ri.GENDER_match_code ), le.GENDER, ri.GENDER );
  SELF.GENDER_match_code := IF ( isLeftWinner(le.GENDERWeight,ri.GENDERWeight,le.GENDER_match_code,ri.GENDER_match_code ), le.GENDER_match_code, ri.GENDER_match_code );
  BOOLEAN PRIM_RANGEWeightForcedDown := IF ( isWeightForcedDown(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code),TRUE,FALSE );
  SELF.PRIM_RANGEWeight := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code ), le.PRIM_RANGEWeight, ri.PRIM_RANGEWeight );
  SELF.PRIM_RANGE := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code ), le.PRIM_RANGE, ri.PRIM_RANGE );
  SELF.PRIM_RANGE_match_code := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code ), le.PRIM_RANGE_match_code, ri.PRIM_RANGE_match_code );
  BOOLEAN PRIM_NAMEWeightForcedDown := IF ( isWeightForcedDown(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code),TRUE,FALSE );
  SELF.PRIM_NAMEWeight := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code ), le.PRIM_NAMEWeight, ri.PRIM_NAMEWeight );
  SELF.PRIM_NAME := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code ), le.PRIM_NAME, ri.PRIM_NAME );
  SELF.PRIM_NAME_match_code := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code ), le.PRIM_NAME_match_code, ri.PRIM_NAME_match_code );
  BOOLEAN SEC_RANGEWeightForcedDown := IF ( isWeightForcedDown(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code),TRUE,FALSE );
  SELF.SEC_RANGEWeight := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code ), le.SEC_RANGEWeight, ri.SEC_RANGEWeight );
  SELF.SEC_RANGE := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code ), le.SEC_RANGE, ri.SEC_RANGE );
  SELF.SEC_RANGE_match_code := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code ), le.SEC_RANGE_match_code, ri.SEC_RANGE_match_code );
  BOOLEAN V_CITY_NAMEWeightForcedDown := IF ( isWeightForcedDown(le.V_CITY_NAMEWeight,ri.V_CITY_NAMEWeight,le.V_CITY_NAME_match_code,ri.V_CITY_NAME_match_code),TRUE,FALSE );
  SELF.V_CITY_NAMEWeight := IF ( isLeftWinner(le.V_CITY_NAMEWeight,ri.V_CITY_NAMEWeight,le.V_CITY_NAME_match_code,ri.V_CITY_NAME_match_code ), le.V_CITY_NAMEWeight, ri.V_CITY_NAMEWeight );
  SELF.V_CITY_NAME := IF ( isLeftWinner(le.V_CITY_NAMEWeight,ri.V_CITY_NAMEWeight,le.V_CITY_NAME_match_code,ri.V_CITY_NAME_match_code ), le.V_CITY_NAME, ri.V_CITY_NAME );
  SELF.V_CITY_NAME_match_code := IF ( isLeftWinner(le.V_CITY_NAMEWeight,ri.V_CITY_NAMEWeight,le.V_CITY_NAME_match_code,ri.V_CITY_NAME_match_code ), le.V_CITY_NAME_match_code, ri.V_CITY_NAME_match_code );
  BOOLEAN STWeightForcedDown := IF ( isWeightForcedDown(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code),TRUE,FALSE );
  SELF.STWeight := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.STWeight, ri.STWeight );
  SELF.ST := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.ST, ri.ST );
  SELF.ST_match_code := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.ST_match_code, ri.ST_match_code );
  BOOLEAN ZIPWeightForcedDown := IF ( isWeightForcedDown(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code),TRUE,FALSE );
  SELF.ZIPWeight := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIPWeight, ri.ZIPWeight );
  SELF.ZIP := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIP, ri.ZIP );
  SELF.ZIP_match_code := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIP_match_code, ri.ZIP_match_code );
  BOOLEAN SSNWeightForcedDown := IF ( isWeightForcedDown(le.SSNWeight,ri.SSNWeight,le.SSN_match_code,ri.SSN_match_code),TRUE,FALSE );
  SELF.SSNWeight := IF ( isLeftWinner(le.SSNWeight,ri.SSNWeight,le.SSN_match_code,ri.SSN_match_code ), le.SSNWeight, ri.SSNWeight );
  SELF.SSN := IF ( isLeftWinner(le.SSNWeight,ri.SSNWeight,le.SSN_match_code,ri.SSN_match_code ), le.SSN, ri.SSN );
  SELF.SSN_match_code := IF ( isLeftWinner(le.SSNWeight,ri.SSNWeight,le.SSN_match_code,ri.SSN_match_code ), le.SSN_match_code, ri.SSN_match_code );
  BOOLEAN CNSMR_SSNWeightForcedDown := IF ( isWeightForcedDown(le.CNSMR_SSNWeight,ri.CNSMR_SSNWeight,le.CNSMR_SSN_match_code,ri.CNSMR_SSN_match_code),TRUE,FALSE );
  SELF.CNSMR_SSNWeight := IF ( isLeftWinner(le.CNSMR_SSNWeight,ri.CNSMR_SSNWeight,le.CNSMR_SSN_match_code,ri.CNSMR_SSN_match_code ), le.CNSMR_SSNWeight, ri.CNSMR_SSNWeight );
  SELF.CNSMR_SSN := IF ( isLeftWinner(le.CNSMR_SSNWeight,ri.CNSMR_SSNWeight,le.CNSMR_SSN_match_code,ri.CNSMR_SSN_match_code ), le.CNSMR_SSN, ri.CNSMR_SSN );
  SELF.CNSMR_SSN_match_code := IF ( isLeftWinner(le.CNSMR_SSNWeight,ri.CNSMR_SSNWeight,le.CNSMR_SSN_match_code,ri.CNSMR_SSN_match_code ), le.CNSMR_SSN_match_code, ri.CNSMR_SSN_match_code );
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
  BOOLEAN CNSMR_DOBWeightForcedDown_year := IF ( isWeightForcedDown(le.CNSMR_DOBWeight_year,ri.CNSMR_DOBWeight_year,le.CNSMR_DOB_year_match_code,ri.CNSMR_DOB_year_match_code),true,false );
  SELF.CNSMR_DOBWeight_year := IF ( isLeftWinner( le.CNSMR_DOBWeight_year, ri.CNSMR_DOBWeight_year,le.CNSMR_DOB_year_match_code,ri.CNSMR_DOB_year_match_code), le.CNSMR_DOBWeight_year, ri.CNSMR_DOBWeight_year );
  SELF.CNSMR_DOB_year := IF ( isLeftWinner( le.CNSMR_DOBWeight_year, ri.CNSMR_DOBWeight_year,le.CNSMR_DOB_year_match_code,ri.CNSMR_DOB_year_match_code), le.CNSMR_DOB_year, ri.CNSMR_DOB_year );
  SELF.CNSMR_DOB_year_match_code := IF ( isLeftWinner(le.CNSMR_DOBWeight_year,ri.CNSMR_DOBWeight_year,le.CNSMR_DOB_year_match_code,ri.CNSMR_DOB_year_match_code), le.CNSMR_DOB_year_match_code, ri.CNSMR_DOB_year_match_code );
  BOOLEAN CNSMR_DOBWeightForcedDown_month := IF ( isWeightForcedDown(le.CNSMR_DOBWeight_month,ri.CNSMR_DOBWeight_month,le.CNSMR_DOB_month_match_code,ri.CNSMR_DOB_month_match_code),true,false );
  SELF.CNSMR_DOBWeight_month := IF ( isLeftWinner( le.CNSMR_DOBWeight_month, ri.CNSMR_DOBWeight_month,le.CNSMR_DOB_month_match_code,ri.CNSMR_DOB_month_match_code), le.CNSMR_DOBWeight_month, ri.CNSMR_DOBWeight_month );
  SELF.CNSMR_DOB_month := IF ( isLeftWinner( le.CNSMR_DOBWeight_month, ri.CNSMR_DOBWeight_month,le.CNSMR_DOB_month_match_code,ri.CNSMR_DOB_month_match_code), le.CNSMR_DOB_month, ri.CNSMR_DOB_month );
  SELF.CNSMR_DOB_month_match_code := IF ( isLeftWinner(le.CNSMR_DOBWeight_month,ri.CNSMR_DOBWeight_month,le.CNSMR_DOB_month_match_code,ri.CNSMR_DOB_month_match_code), le.CNSMR_DOB_month_match_code, ri.CNSMR_DOB_month_match_code );
  BOOLEAN CNSMR_DOBWeightForcedDown_day := IF ( isWeightForcedDown(le.CNSMR_DOBWeight_day,ri.CNSMR_DOBWeight_day,le.CNSMR_DOB_day_match_code,ri.CNSMR_DOB_day_match_code),true,false );
  SELF.CNSMR_DOBWeight_day := IF ( isLeftWinner( le.CNSMR_DOBWeight_day, ri.CNSMR_DOBWeight_day,le.CNSMR_DOB_day_match_code,ri.CNSMR_DOB_day_match_code), le.CNSMR_DOBWeight_day, ri.CNSMR_DOBWeight_day );
  SELF.CNSMR_DOB_day := IF ( isLeftWinner( le.CNSMR_DOBWeight_day, ri.CNSMR_DOBWeight_day,le.CNSMR_DOB_day_match_code,ri.CNSMR_DOB_day_match_code), le.CNSMR_DOB_day, ri.CNSMR_DOB_day );
  SELF.CNSMR_DOB_day_match_code := IF ( isLeftWinner(le.CNSMR_DOBWeight_day,ri.CNSMR_DOBWeight_day,le.CNSMR_DOB_day_match_code,ri.CNSMR_DOB_day_match_code), le.CNSMR_DOB_day_match_code, ri.CNSMR_DOB_day_match_code );
  SELF.CNSMR_DOBWeight :=  SELF.CNSMR_DOBWeight_year+SELF.CNSMR_DOBWeight_month+SELF.CNSMR_DOBWeight_day;
  BOOLEAN CNSMR_DOBWeightForcedDown :=  CNSMR_DOBWeightForcedDown_year OR CNSMR_DOBWeightForcedDown_month OR CNSMR_DOBWeightForcedDown_day;
  SELF.CNSMR_DOB_match_code := IF ( isLeftWinner(le.CNSMR_DOBWeight,ri.CNSMR_DOBWeight,le.CNSMR_DOB_match_code,ri.CNSMR_DOB_match_code), le.CNSMR_DOB_match_code, ri.CNSMR_DOB_match_code );
  BOOLEAN PHONEWeightForcedDown := IF ( isWeightForcedDown(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code),TRUE,FALSE );
  SELF.PHONEWeight := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code ), le.PHONEWeight, ri.PHONEWeight );
  SELF.PHONE := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code ), le.PHONE, ri.PHONE );
  SELF.PHONE_match_code := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code ), le.PHONE_match_code, ri.PHONE_match_code );
  BOOLEAN LIC_STATEWeightForcedDown := IF ( isWeightForcedDown(le.LIC_STATEWeight,ri.LIC_STATEWeight,le.LIC_STATE_match_code,ri.LIC_STATE_match_code),TRUE,FALSE );
  SELF.LIC_STATEWeight := IF ( isLeftWinner(le.LIC_STATEWeight,ri.LIC_STATEWeight,le.LIC_STATE_match_code,ri.LIC_STATE_match_code ), le.LIC_STATEWeight, ri.LIC_STATEWeight );
  SELF.LIC_STATE := IF ( isLeftWinner(le.LIC_STATEWeight,ri.LIC_STATEWeight,le.LIC_STATE_match_code,ri.LIC_STATE_match_code ), le.LIC_STATE, ri.LIC_STATE );
  SELF.LIC_STATE_match_code := IF ( isLeftWinner(le.LIC_STATEWeight,ri.LIC_STATEWeight,le.LIC_STATE_match_code,ri.LIC_STATE_match_code ), le.LIC_STATE_match_code, ri.LIC_STATE_match_code );
  BOOLEAN C_LIC_NBRWeightForcedDown := IF ( isWeightForcedDown(le.C_LIC_NBRWeight,ri.C_LIC_NBRWeight,le.C_LIC_NBR_match_code,ri.C_LIC_NBR_match_code),TRUE,FALSE );
  SELF.C_LIC_NBRWeight := IF ( isLeftWinner(le.C_LIC_NBRWeight,ri.C_LIC_NBRWeight,le.C_LIC_NBR_match_code,ri.C_LIC_NBR_match_code ), le.C_LIC_NBRWeight, ri.C_LIC_NBRWeight );
  SELF.C_LIC_NBR := IF ( isLeftWinner(le.C_LIC_NBRWeight,ri.C_LIC_NBRWeight,le.C_LIC_NBR_match_code,ri.C_LIC_NBR_match_code ), le.C_LIC_NBR, ri.C_LIC_NBR );
  SELF.C_LIC_NBR_match_code := IF ( isLeftWinner(le.C_LIC_NBRWeight,ri.C_LIC_NBRWeight,le.C_LIC_NBR_match_code,ri.C_LIC_NBR_match_code ), le.C_LIC_NBR_match_code, ri.C_LIC_NBR_match_code );
  BOOLEAN TAX_IDWeightForcedDown := IF ( isWeightForcedDown(le.TAX_IDWeight,ri.TAX_IDWeight,le.TAX_ID_match_code,ri.TAX_ID_match_code),TRUE,FALSE );
  SELF.TAX_IDWeight := IF ( isLeftWinner(le.TAX_IDWeight,ri.TAX_IDWeight,le.TAX_ID_match_code,ri.TAX_ID_match_code ), le.TAX_IDWeight, ri.TAX_IDWeight );
  SELF.TAX_ID := IF ( isLeftWinner(le.TAX_IDWeight,ri.TAX_IDWeight,le.TAX_ID_match_code,ri.TAX_ID_match_code ), le.TAX_ID, ri.TAX_ID );
  SELF.TAX_ID_match_code := IF ( isLeftWinner(le.TAX_IDWeight,ri.TAX_IDWeight,le.TAX_ID_match_code,ri.TAX_ID_match_code ), le.TAX_ID_match_code, ri.TAX_ID_match_code );
  BOOLEAN BILLING_TAX_IDWeightForcedDown := IF ( isWeightForcedDown(le.BILLING_TAX_IDWeight,ri.BILLING_TAX_IDWeight,le.BILLING_TAX_ID_match_code,ri.BILLING_TAX_ID_match_code),TRUE,FALSE );
  SELF.BILLING_TAX_IDWeight := IF ( isLeftWinner(le.BILLING_TAX_IDWeight,ri.BILLING_TAX_IDWeight,le.BILLING_TAX_ID_match_code,ri.BILLING_TAX_ID_match_code ), le.BILLING_TAX_IDWeight, ri.BILLING_TAX_IDWeight );
  SELF.BILLING_TAX_ID := IF ( isLeftWinner(le.BILLING_TAX_IDWeight,ri.BILLING_TAX_IDWeight,le.BILLING_TAX_ID_match_code,ri.BILLING_TAX_ID_match_code ), le.BILLING_TAX_ID, ri.BILLING_TAX_ID );
  SELF.BILLING_TAX_ID_match_code := IF ( isLeftWinner(le.BILLING_TAX_IDWeight,ri.BILLING_TAX_IDWeight,le.BILLING_TAX_ID_match_code,ri.BILLING_TAX_ID_match_code ), le.BILLING_TAX_ID_match_code, ri.BILLING_TAX_ID_match_code );
  BOOLEAN DEA_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.DEA_NUMBERWeight,ri.DEA_NUMBERWeight,le.DEA_NUMBER_match_code,ri.DEA_NUMBER_match_code),TRUE,FALSE );
  SELF.DEA_NUMBERWeight := IF ( isLeftWinner(le.DEA_NUMBERWeight,ri.DEA_NUMBERWeight,le.DEA_NUMBER_match_code,ri.DEA_NUMBER_match_code ), le.DEA_NUMBERWeight, ri.DEA_NUMBERWeight );
  SELF.DEA_NUMBER := IF ( isLeftWinner(le.DEA_NUMBERWeight,ri.DEA_NUMBERWeight,le.DEA_NUMBER_match_code,ri.DEA_NUMBER_match_code ), le.DEA_NUMBER, ri.DEA_NUMBER );
  SELF.DEA_NUMBER_match_code := IF ( isLeftWinner(le.DEA_NUMBERWeight,ri.DEA_NUMBERWeight,le.DEA_NUMBER_match_code,ri.DEA_NUMBER_match_code ), le.DEA_NUMBER_match_code, ri.DEA_NUMBER_match_code );
  BOOLEAN VENDOR_IDWeightForcedDown := IF ( isWeightForcedDown(le.VENDOR_IDWeight,ri.VENDOR_IDWeight,le.VENDOR_ID_match_code,ri.VENDOR_ID_match_code),TRUE,FALSE );
  SELF.VENDOR_IDWeight := IF ( isLeftWinner(le.VENDOR_IDWeight,ri.VENDOR_IDWeight,le.VENDOR_ID_match_code,ri.VENDOR_ID_match_code ), le.VENDOR_IDWeight, ri.VENDOR_IDWeight );
  SELF.VENDOR_ID := IF ( isLeftWinner(le.VENDOR_IDWeight,ri.VENDOR_IDWeight,le.VENDOR_ID_match_code,ri.VENDOR_ID_match_code ), le.VENDOR_ID, ri.VENDOR_ID );
  SELF.VENDOR_ID_match_code := IF ( isLeftWinner(le.VENDOR_IDWeight,ri.VENDOR_IDWeight,le.VENDOR_ID_match_code,ri.VENDOR_ID_match_code ), le.VENDOR_ID_match_code, ri.VENDOR_ID_match_code );
  BOOLEAN NPI_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.NPI_NUMBERWeight,ri.NPI_NUMBERWeight,le.NPI_NUMBER_match_code,ri.NPI_NUMBER_match_code),TRUE,FALSE );
  SELF.NPI_NUMBERWeight := IF ( isLeftWinner(le.NPI_NUMBERWeight,ri.NPI_NUMBERWeight,le.NPI_NUMBER_match_code,ri.NPI_NUMBER_match_code ), le.NPI_NUMBERWeight, ri.NPI_NUMBERWeight );
  SELF.NPI_NUMBER := IF ( isLeftWinner(le.NPI_NUMBERWeight,ri.NPI_NUMBERWeight,le.NPI_NUMBER_match_code,ri.NPI_NUMBER_match_code ), le.NPI_NUMBER, ri.NPI_NUMBER );
  SELF.NPI_NUMBER_match_code := IF ( isLeftWinner(le.NPI_NUMBERWeight,ri.NPI_NUMBERWeight,le.NPI_NUMBER_match_code,ri.NPI_NUMBER_match_code ), le.NPI_NUMBER_match_code, ri.NPI_NUMBER_match_code );
  BOOLEAN BILLING_NPI_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.BILLING_NPI_NUMBERWeight,ri.BILLING_NPI_NUMBERWeight,le.BILLING_NPI_NUMBER_match_code,ri.BILLING_NPI_NUMBER_match_code),TRUE,FALSE );
  SELF.BILLING_NPI_NUMBERWeight := IF ( isLeftWinner(le.BILLING_NPI_NUMBERWeight,ri.BILLING_NPI_NUMBERWeight,le.BILLING_NPI_NUMBER_match_code,ri.BILLING_NPI_NUMBER_match_code ), le.BILLING_NPI_NUMBERWeight, ri.BILLING_NPI_NUMBERWeight );
  SELF.BILLING_NPI_NUMBER := IF ( isLeftWinner(le.BILLING_NPI_NUMBERWeight,ri.BILLING_NPI_NUMBERWeight,le.BILLING_NPI_NUMBER_match_code,ri.BILLING_NPI_NUMBER_match_code ), le.BILLING_NPI_NUMBER, ri.BILLING_NPI_NUMBER );
  SELF.BILLING_NPI_NUMBER_match_code := IF ( isLeftWinner(le.BILLING_NPI_NUMBERWeight,ri.BILLING_NPI_NUMBERWeight,le.BILLING_NPI_NUMBER_match_code,ri.BILLING_NPI_NUMBER_match_code ), le.BILLING_NPI_NUMBER_match_code, ri.BILLING_NPI_NUMBER_match_code );
  BOOLEAN UPINWeightForcedDown := IF ( isWeightForcedDown(le.UPINWeight,ri.UPINWeight,le.UPIN_match_code,ri.UPIN_match_code),TRUE,FALSE );
  SELF.UPINWeight := IF ( isLeftWinner(le.UPINWeight,ri.UPINWeight,le.UPIN_match_code,ri.UPIN_match_code ), le.UPINWeight, ri.UPINWeight );
  SELF.UPIN := IF ( isLeftWinner(le.UPINWeight,ri.UPINWeight,le.UPIN_match_code,ri.UPIN_match_code ), le.UPIN, ri.UPIN );
  SELF.UPIN_match_code := IF ( isLeftWinner(le.UPINWeight,ri.UPINWeight,le.UPIN_match_code,ri.UPIN_match_code ), le.UPIN_match_code, ri.UPIN_match_code );
  BOOLEAN DIDWeightForcedDown := IF ( isWeightForcedDown(le.DIDWeight,ri.DIDWeight,le.DID_match_code,ri.DID_match_code),TRUE,FALSE );
  SELF.DIDWeight := IF ( isLeftWinner(le.DIDWeight,ri.DIDWeight,le.DID_match_code,ri.DID_match_code ), le.DIDWeight, ri.DIDWeight );
  SELF.DID := IF ( isLeftWinner(le.DIDWeight,ri.DIDWeight,le.DID_match_code,ri.DID_match_code ), le.DID, ri.DID );
  SELF.DID_match_code := IF ( isLeftWinner(le.DIDWeight,ri.DIDWeight,le.DID_match_code,ri.DID_match_code ), le.DID_match_code, ri.DID_match_code );
  BOOLEAN BDIDWeightForcedDown := IF ( isWeightForcedDown(le.BDIDWeight,ri.BDIDWeight,le.BDID_match_code,ri.BDID_match_code),TRUE,FALSE );
  SELF.BDIDWeight := IF ( isLeftWinner(le.BDIDWeight,ri.BDIDWeight,le.BDID_match_code,ri.BDID_match_code ), le.BDIDWeight, ri.BDIDWeight );
  SELF.BDID := IF ( isLeftWinner(le.BDIDWeight,ri.BDIDWeight,le.BDID_match_code,ri.BDID_match_code ), le.BDID, ri.BDID );
  SELF.BDID_match_code := IF ( isLeftWinner(le.BDIDWeight,ri.BDIDWeight,le.BDID_match_code,ri.BDID_match_code ), le.BDID_match_code, ri.BDID_match_code );
  BOOLEAN SRCWeightForcedDown := IF ( isWeightForcedDown(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code),TRUE,FALSE );
  SELF.SRCWeight := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code ), le.SRCWeight, ri.SRCWeight );
  SELF.SRC := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code ), le.SRC, ri.SRC );
  SELF.SRC_match_code := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code ), le.SRC_match_code, ri.SRC_match_code );
  BOOLEAN SOURCE_RIDWeightForcedDown := IF ( isWeightForcedDown(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code),TRUE,FALSE );
  SELF.SOURCE_RIDWeight := IF ( isLeftWinner(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code ), le.SOURCE_RIDWeight, ri.SOURCE_RIDWeight );
  SELF.SOURCE_RID := IF ( isLeftWinner(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code ), le.SOURCE_RID, ri.SOURCE_RID );
  SELF.SOURCE_RID_match_code := IF ( isLeftWinner(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code ), le.SOURCE_RID_match_code, ri.SOURCE_RID_match_code );
  BOOLEAN RIDWeightForcedDown := IF ( isWeightForcedDown(le.RIDWeight,ri.RIDWeight,le.RID_match_code,ri.RID_match_code),TRUE,FALSE );
  SELF.RIDWeight := IF ( isLeftWinner(le.RIDWeight,ri.RIDWeight,le.RID_match_code,ri.RID_match_code ), le.RIDWeight, ri.RIDWeight );
  SELF.RID := IF ( isLeftWinner(le.RIDWeight,ri.RIDWeight,le.RID_match_code,ri.RID_match_code ), le.RID, ri.RID );
  SELF.RID_match_code := IF ( isLeftWinner(le.RIDWeight,ri.RIDWeight,le.RID_match_code,ri.RID_match_code ), le.RID_match_code, ri.RID_match_code );
  BOOLEAN DirectMAINNAMEWeightForcedDown := IF ( isWeightForcedDown(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code),TRUE,FALSE );
  SELF.MAINNAMEWeight := MAP (
      DirectMAINNAMEWeightForcedDown => IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAMEWeight, ri.MAINNAMEWeight ),
      IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAMEWeight, ri.MAINNAMEWeight ));
  SELF.MAINNAME_match_code :=  MAP (
      DirectMAINNAMEWeightForcedDown => IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAME_match_code, ri.MAINNAME_match_code ),
      IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAME_match_code, ri.MAINNAME_match_code ));
  BOOLEAN DirectFULLNAMEWeightForcedDown := IF ( isWeightForcedDown(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code),TRUE,FALSE );
  SELF.FULLNAMEWeight := MAP (
      DirectFULLNAMEWeightForcedDown => IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAMEWeight, ri.FULLNAMEWeight ),
      IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAMEWeight, ri.FULLNAMEWeight ));
  SELF.FULLNAME_match_code :=  MAP (
      DirectFULLNAMEWeightForcedDown => IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAME_match_code, ri.FULLNAME_match_code ),
      IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAME_match_code, ri.FULLNAME_match_code ));
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
  SELF.keys_used := le.keys_used | ri.keys_used;
  SELF.keys_failed := le.keys_failed | ri.keys_failed;
  INTEGER2 Weight := MAX(0, SELF.GENDERWeight) + MAX(0, SELF.SSNWeight) + MAX(0, SELF.CNSMR_SSNWeight) + MAX(0, SELF.DOBWeight) + MAX(0, SELF.CNSMR_DOBWeight) + MAX(0, SELF.PHONEWeight) + MAX(0, SELF.LIC_STATEWeight) + MAX(0, SELF.C_LIC_NBRWeight) + MAX(0, SELF.TAX_IDWeight) + MAX(0, SELF.BILLING_TAX_IDWeight) + MAX(0, SELF.DEA_NUMBERWeight) + MAX(0, SELF.VENDOR_IDWeight) + MAX(0, SELF.NPI_NUMBERWeight) + MAX(0, SELF.BILLING_NPI_NUMBERWeight) + MAX(0, SELF.UPINWeight) + MAX(0, SELF.DIDWeight) + MAX(0, SELF.BDIDWeight) + MAX(0, SELF.SRCWeight) + MAX(0, SELF.SOURCE_RIDWeight) + MAX(0, SELF.RIDWeight) + (MAX(SELF.MAINNAMEWeight, (MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.LNAMEWeight))) + MAX(0, SELF.SNAMEWeight)) + ((MAX(0, SELF.PRIM_NAMEWeight) + MAX(0, SELF.PRIM_RANGEWeight) + MAX(0, SELF.SEC_RANGEWeight)) + (MAX(0, SELF.V_CITY_NAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.ZIPWeight)));
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
    SELF.Summary := IF(le.FNAMEWeight = 0,'','|'+IF(le.FNAMEWeight < 0,'-','')+'FNAME')+IF(le.MNAMEWeight = 0,'','|'+IF(le.MNAMEWeight < 0,'-','')+'MNAME')+IF(le.LNAMEWeight = 0,'','|'+IF(le.LNAMEWeight < 0,'-','')+'LNAME')+IF(le.SNAMEWeight = 0,'','|'+IF(le.SNAMEWeight < 0,'-','')+'SNAME')+IF(le.GENDERWeight = 0,'','|'+IF(le.GENDERWeight < 0,'-','')+'GENDER')+IF(le.PRIM_RANGEWeight = 0,'','|'+IF(le.PRIM_RANGEWeight < 0,'-','')+'PRIM_RANGE')+IF(le.PRIM_NAMEWeight = 0,'','|'+IF(le.PRIM_NAMEWeight < 0,'-','')+'PRIM_NAME')+IF(le.SEC_RANGEWeight = 0,'','|'+IF(le.SEC_RANGEWeight < 0,'-','')+'SEC_RANGE')+IF(le.V_CITY_NAMEWeight = 0,'','|'+IF(le.V_CITY_NAMEWeight < 0,'-','')+'V_CITY_NAME')+IF(le.STWeight = 0,'','|'+IF(le.STWeight < 0,'-','')+'ST')+IF(le.ZIPWeight = 0,'','|'+IF(le.ZIPWeight < 0,'-','')+'ZIP')+IF(le.SSNWeight = 0,'','|'+IF(le.SSNWeight < 0,'-','')+'SSN')+IF(le.CNSMR_SSNWeight = 0,'','|'+IF(le.CNSMR_SSNWeight < 0,'-','')+'CNSMR_SSN')+IF(le.DOBWeight_year+le.DOBWeight_month+le.DOBWeight_day=0,'','|'+IF(le.DOBWeight_year+le.DOBWeight_month+le.DOBWeight_day<0,'-','')+'DOB')+IF(le.CNSMR_DOBWeight_year+le.CNSMR_DOBWeight_month+le.CNSMR_DOBWeight_day=0,'','|'+IF(le.CNSMR_DOBWeight_year+le.CNSMR_DOBWeight_month+le.CNSMR_DOBWeight_day<0,'-','')+'CNSMR_DOB')+IF(le.PHONEWeight = 0,'','|'+IF(le.PHONEWeight < 0,'-','')+'PHONE')+IF(le.LIC_STATEWeight = 0,'','|'+IF(le.LIC_STATEWeight < 0,'-','')+'LIC_STATE')+IF(le.C_LIC_NBRWeight = 0,'','|'+IF(le.C_LIC_NBRWeight < 0,'-','')+'C_LIC_NBR')+IF(le.TAX_IDWeight = 0,'','|'+IF(le.TAX_IDWeight < 0,'-','')+'TAX_ID')+IF(le.BILLING_TAX_IDWeight = 0,'','|'+IF(le.BILLING_TAX_IDWeight < 0,'-','')+'BILLING_TAX_ID')+IF(le.DEA_NUMBERWeight = 0,'','|'+IF(le.DEA_NUMBERWeight < 0,'-','')+'DEA_NUMBER')+IF(le.VENDOR_IDWeight = 0,'','|'+IF(le.VENDOR_IDWeight < 0,'-','')+'VENDOR_ID')+IF(le.NPI_NUMBERWeight = 0,'','|'+IF(le.NPI_NUMBERWeight < 0,'-','')+'NPI_NUMBER')+IF(le.BILLING_NPI_NUMBERWeight = 0,'','|'+IF(le.BILLING_NPI_NUMBERWeight < 0,'-','')+'BILLING_NPI_NUMBER')+IF(le.UPINWeight = 0,'','|'+IF(le.UPINWeight < 0,'-','')+'UPIN')+IF(le.DIDWeight = 0,'','|'+IF(le.DIDWeight < 0,'-','')+'DID')+IF(le.BDIDWeight = 0,'','|'+IF(le.BDIDWeight < 0,'-','')+'BDID')+IF(le.SRCWeight = 0,'','|'+IF(le.SRCWeight < 0,'-','')+'SRC')+IF(le.SOURCE_RIDWeight = 0,'','|'+IF(le.SOURCE_RIDWeight < 0,'-','')+'SOURCE_RID')+IF(le.RIDWeight = 0,'','|'+IF(le.RIDWeight < 0,'-','')+'RID')+IF(le.MAINNAMEWeight = 0,'','|'+IF(le.MAINNAMEWeight < 0,'-','')+'MAINNAME')+IF(le.FULLNAMEWeight = 0,'','|'+IF(le.FULLNAMEWeight < 0,'-','')+'FULLNAME')+IF(le.ADDR1Weight = 0,'','|'+IF(le.ADDR1Weight < 0,'-','')+'ADDR1')+IF(le.LOCALEWeight = 0,'','|'+IF(le.LOCALEWeight < 0,'-','')+'LOCALE')+IF(le.ADDRESSWeight = 0,'','|'+IF(le.ADDRESSWeight < 0,'-','')+'ADDRESS');
  END;
  P := PROJECT(ds,tosummary(LEFT));
  RETURN SORT(TABLE(P,{Summary, Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
 
EXPORT KeysBitmapDecode(Config.KeysBitmapType bitmap,STRING prefix='') := FUNCTION
  MapLP(UNSIGNED1 code,STRING prefix='') := CASE(code,1=>IF(prefix<>'',prefix,'UBER'),2=>IF(prefix<>'',prefix+'NAMEL','NAMEL'),3=>IF(prefix<>'',prefix+'FNAME','FNAME'),4=>IF(prefix<>'',prefix+'NAMEC','NAMEC'),5=>IF(prefix<>'',prefix+'LNAME','LNAME'),6=>IF(prefix<>'',prefix+'MNAME','MNAME'),7=>IF(prefix<>'',prefix+'ADDRESS','ADDRESS'),8=>IF(prefix<>'',prefix+'ZIP_PR','ZIP_PR'),9=>IF(prefix<>'',prefix+'SSN_LP','SSN_LP'),10=>IF(prefix<>'',prefix+'CNSMR_SSN_LP','CNSMR_SSN_LP'),11=>IF(prefix<>'',prefix+'DOB_LP','DOB_LP'),12=>IF(prefix<>'',prefix+'CNSMR_DOB_LP','CNSMR_DOB_LP'),13=>IF(prefix<>'',prefix+'PHONE_LP','PHONE_LP'),14=>IF(prefix<>'',prefix+'LIC','LIC'),15=>IF(prefix<>'',prefix+'VEN','VEN'),16=>IF(prefix<>'',prefix+'TAX','TAX'),17=>IF(prefix<>'',prefix+'BILLING_TAX','BILLING_TAX'),18=>IF(prefix<>'',prefix+'DEA','DEA'),19=>IF(prefix<>'',prefix+'NPI','NPI'),20=>IF(prefix<>'',prefix+'BILLING_NPI','BILLING_NPI'),21=>IF(prefix<>'',prefix+'UPN','UPN'),22=>IF(prefix<>'',prefix+'LEXID','LEXID'),23=>IF(prefix<>'',prefix+'BID','BID'),24=>IF(prefix<>'',prefix+'SRC_RID','SRC_RID'),25=>IF(prefix<>'',prefix+'RID','RID'),'');
  REC := {STRING txt};
  ds := DATASET([{''}],REC);
  REC decode(REC le, UNSIGNED1 c) := TRANSFORM
    SELF.txt := le.txt+IF((bitmap&(1<<c-1))>0,MapLP(c,prefix),'');
  END;
  N0 := NORMALIZE(ds,24,decode(LEFT,COUNTER));
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
  agg := AGGREGATE(in_data(LNPID=0),outR,AggregateFlags(LEFT,RIGHT),FEW);
  flgFail := agg[1].keys_failed;
  RETURN IF(COUNT(in_data(LNPID = 0)) > 0, IF(COUNT(in_data(LNPID <> 0)) > 0, PROJECT(in_data(LNPID <> 0), AdjustFlags(LEFT, flgFail)), PROJECT(in_data(LNPID = 0)[1..1], AdjustFlags(LEFT, flgFail))), in_data);
END;
EXPORT AdjustScoresForNonExactMatches(DATASET(LayoutScoredFetch) in_data) := FUNCTION
 
aggregateRec := RECORD
  in_data.reference;
  FNAMEWeight := MAX(GROUP,IF( in_data.FNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.FNAMEWeight,0 ));
  MNAMEWeight := MAX(GROUP,IF( in_data.MNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.MNAMEWeight,0 ));
  LNAMEWeight := MAX(GROUP,IF( in_data.LNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.LNAMEWeight,0 ));
  SNAMEWeight := MAX(GROUP,IF( in_data.SNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.SNAMEWeight,0 ));
  GENDERWeight := MAX(GROUP,IF( in_data.GENDER_match_code=SALT311.MatchCode.ExactMatch, in_data.GENDERWeight,0 ));
  PRIM_RANGEWeight := MAX(GROUP,IF( in_data.PRIM_RANGE_match_code=SALT311.MatchCode.ExactMatch, in_data.PRIM_RANGEWeight,0 ));
  PRIM_NAMEWeight := MAX(GROUP,IF( in_data.PRIM_NAME_match_code=SALT311.MatchCode.ExactMatch, in_data.PRIM_NAMEWeight,0 ));
  SEC_RANGEWeight := MAX(GROUP,IF( in_data.SEC_RANGE_match_code=SALT311.MatchCode.ExactMatch, in_data.SEC_RANGEWeight,0 ));
  V_CITY_NAMEWeight := MAX(GROUP,IF( in_data.V_CITY_NAME_match_code=SALT311.MatchCode.ExactMatch, in_data.V_CITY_NAMEWeight,0 ));
  STWeight := MAX(GROUP,IF( in_data.ST_match_code=SALT311.MatchCode.ExactMatch, in_data.STWeight,0 ));
  ZIPWeight := MAX(GROUP,IF( in_data.ZIP_match_code=SALT311.MatchCode.ExactMatch, in_data.ZIPWeight,0 ));
  SSNWeight := MAX(GROUP,IF( in_data.SSN_match_code=SALT311.MatchCode.ExactMatch, in_data.SSNWeight,0 ));
  CNSMR_SSNWeight := MAX(GROUP,IF( in_data.CNSMR_SSN_match_code=SALT311.MatchCode.ExactMatch, in_data.CNSMR_SSNWeight,0 ));
  DOBWeight := MAX(GROUP,IF( in_data.DOB_year_match_code=SALT311.MatchCode.ExactMatch AND in_data.DOB_month_match_code=SALT311.MatchCode.ExactMatch AND in_data.DOB_day_match_code=SALT311.MatchCode.ExactMatch, in_data.DOBWeight,0 ));
  CNSMR_DOBWeight := MAX(GROUP,IF( in_data.CNSMR_DOB_year_match_code=SALT311.MatchCode.ExactMatch AND in_data.CNSMR_DOB_month_match_code=SALT311.MatchCode.ExactMatch AND in_data.CNSMR_DOB_day_match_code=SALT311.MatchCode.ExactMatch, in_data.CNSMR_DOBWeight,0 ));
  PHONEWeight := MAX(GROUP,IF( in_data.PHONE_match_code=SALT311.MatchCode.ExactMatch, in_data.PHONEWeight,0 ));
  LIC_STATEWeight := MAX(GROUP,IF( in_data.LIC_STATE_match_code=SALT311.MatchCode.ExactMatch, in_data.LIC_STATEWeight,0 ));
  C_LIC_NBRWeight := MAX(GROUP,IF( in_data.C_LIC_NBR_match_code=SALT311.MatchCode.ExactMatch, in_data.C_LIC_NBRWeight,0 ));
  TAX_IDWeight := MAX(GROUP,IF( in_data.TAX_ID_match_code=SALT311.MatchCode.ExactMatch, in_data.TAX_IDWeight,0 ));
  BILLING_TAX_IDWeight := MAX(GROUP,IF( in_data.BILLING_TAX_ID_match_code=SALT311.MatchCode.ExactMatch, in_data.BILLING_TAX_IDWeight,0 ));
  DEA_NUMBERWeight := MAX(GROUP,IF( in_data.DEA_NUMBER_match_code=SALT311.MatchCode.ExactMatch, in_data.DEA_NUMBERWeight,0 ));
  VENDOR_IDWeight := MAX(GROUP,IF( in_data.VENDOR_ID_match_code=SALT311.MatchCode.ExactMatch, in_data.VENDOR_IDWeight,0 ));
  NPI_NUMBERWeight := MAX(GROUP,IF( in_data.NPI_NUMBER_match_code=SALT311.MatchCode.ExactMatch, in_data.NPI_NUMBERWeight,0 ));
  BILLING_NPI_NUMBERWeight := MAX(GROUP,IF( in_data.BILLING_NPI_NUMBER_match_code=SALT311.MatchCode.ExactMatch, in_data.BILLING_NPI_NUMBERWeight,0 ));
  UPINWeight := MAX(GROUP,IF( in_data.UPIN_match_code=SALT311.MatchCode.ExactMatch, in_data.UPINWeight,0 ));
  DIDWeight := MAX(GROUP,IF( in_data.DID_match_code=SALT311.MatchCode.ExactMatch, in_data.DIDWeight,0 ));
  BDIDWeight := MAX(GROUP,IF( in_data.BDID_match_code=SALT311.MatchCode.ExactMatch, in_data.BDIDWeight,0 ));
  SRCWeight := MAX(GROUP,IF( in_data.SRC_match_code=SALT311.MatchCode.ExactMatch, in_data.SRCWeight,0 ));
  SOURCE_RIDWeight := MAX(GROUP,IF( in_data.SOURCE_RID_match_code=SALT311.MatchCode.ExactMatch, in_data.SOURCE_RIDWeight,0 ));
  RIDWeight := MAX(GROUP,IF( in_data.RID_match_code=SALT311.MatchCode.ExactMatch, in_data.RIDWeight,0 ));
  MAINNAMEWeight := MAX(GROUP,IF( in_data.MAINNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.MAINNAMEWeight,0 ));
  FULLNAMEWeight := MAX(GROUP,IF( in_data.FULLNAME_match_code=SALT311.MatchCode.ExactMatch, in_data.FULLNAMEWeight,0 ));
  ADDR1Weight := MAX(GROUP,IF( in_data.ADDR1_match_code=SALT311.MatchCode.ExactMatch, in_data.ADDR1Weight,0 ));
  LOCALEWeight := MAX(GROUP,IF( in_data.LOCALE_match_code=SALT311.MatchCode.ExactMatch, in_data.LOCALEWeight,0 ));
  ADDRESSWeight := MAX(GROUP,IF( in_data.ADDRESS_match_code=SALT311.MatchCode.ExactMatch, in_data.ADDRESSWeight,0 ));
END;
  R1 := TABLE(in_data,aggregateRec,Reference);
 
LayoutScoredFetch FixScores(LayoutScoredFetch le, aggregateRec ri) := TRANSFORM
  SELF.FNAMEWeight := MAP( ri.FNAMEWeight=0 OR le.FNAME_match_code=SALT311.MatchCode.ExactMatch => le.FNAMEWeight,MIN(le.FNAMEWeight,ri.FNAMEWeight-1) );
  SELF.MNAMEWeight := MAP( ri.MNAMEWeight=0 OR le.MNAME_match_code=SALT311.MatchCode.ExactMatch => le.MNAMEWeight,MIN(le.MNAMEWeight,ri.MNAMEWeight-1) );
  SELF.LNAMEWeight := MAP( ri.LNAMEWeight=0 OR le.LNAME_match_code=SALT311.MatchCode.ExactMatch => le.LNAMEWeight,MIN(le.LNAMEWeight,ri.LNAMEWeight-1) );
  SELF.SNAMEWeight := MAP( ri.SNAMEWeight=0 OR le.SNAME_match_code=SALT311.MatchCode.ExactMatch => le.SNAMEWeight,MIN(le.SNAMEWeight,ri.SNAMEWeight-1) );
  SELF.GENDERWeight := MAP( ri.GENDERWeight=0 OR le.GENDER_match_code=SALT311.MatchCode.ExactMatch => le.GENDERWeight,MIN(le.GENDERWeight,ri.GENDERWeight-1) );
  SELF.PRIM_RANGEWeight := MAP( ri.PRIM_RANGEWeight=0 OR le.PRIM_RANGE_match_code=SALT311.MatchCode.ExactMatch => le.PRIM_RANGEWeight,MIN(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight-1) );
  SELF.PRIM_NAMEWeight := MAP( ri.PRIM_NAMEWeight=0 OR le.PRIM_NAME_match_code=SALT311.MatchCode.ExactMatch => le.PRIM_NAMEWeight,MIN(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight-1) );
  SELF.SEC_RANGEWeight := MAP( ri.SEC_RANGEWeight=0 OR le.SEC_RANGE_match_code=SALT311.MatchCode.ExactMatch => le.SEC_RANGEWeight,MIN(le.SEC_RANGEWeight,ri.SEC_RANGEWeight-1) );
  SELF.V_CITY_NAMEWeight := MAP( ri.V_CITY_NAMEWeight=0 OR le.V_CITY_NAME_match_code=SALT311.MatchCode.ExactMatch => le.V_CITY_NAMEWeight,MIN(le.V_CITY_NAMEWeight,ri.V_CITY_NAMEWeight-1) );
  SELF.STWeight := MAP( ri.STWeight=0 OR le.ST_match_code=SALT311.MatchCode.ExactMatch => le.STWeight,MIN(le.STWeight,ri.STWeight-1) );
  SELF.ZIPWeight := MAP( ri.ZIPWeight=0 OR le.ZIP_match_code=SALT311.MatchCode.ExactMatch => le.ZIPWeight,MIN(le.ZIPWeight,ri.ZIPWeight-1) );
  SELF.SSNWeight := MAP( ri.SSNWeight=0 OR le.SSN_match_code=SALT311.MatchCode.ExactMatch => le.SSNWeight,MIN(le.SSNWeight,ri.SSNWeight-1) );
  SELF.CNSMR_SSNWeight := MAP( ri.CNSMR_SSNWeight=0 OR le.CNSMR_SSN_match_code=SALT311.MatchCode.ExactMatch => le.CNSMR_SSNWeight,MIN(le.CNSMR_SSNWeight,ri.CNSMR_SSNWeight-1) );
  SELF.DOBWeight := MAP( ri.DOBWeight=0 OR (le.DOB_year_match_code=SALT311.MatchCode.ExactMatch AND le.DOB_month_match_code=SALT311.MatchCode.ExactMatch AND le.DOB_day_match_code=SALT311.MatchCode.ExactMatch) => le.DOBWeight,MIN(le.DOBWeight,ri.DOBWeight-1) );
  SELF.CNSMR_DOBWeight := MAP( ri.CNSMR_DOBWeight=0 OR (le.CNSMR_DOB_year_match_code=SALT311.MatchCode.ExactMatch AND le.CNSMR_DOB_month_match_code=SALT311.MatchCode.ExactMatch AND le.CNSMR_DOB_day_match_code=SALT311.MatchCode.ExactMatch) => le.CNSMR_DOBWeight,MIN(le.CNSMR_DOBWeight,ri.CNSMR_DOBWeight-1) );
  SELF.PHONEWeight := MAP( ri.PHONEWeight=0 OR le.PHONE_match_code=SALT311.MatchCode.ExactMatch => le.PHONEWeight,MIN(le.PHONEWeight,ri.PHONEWeight-1) );
  SELF.LIC_STATEWeight := MAP( ri.LIC_STATEWeight=0 OR le.LIC_STATE_match_code=SALT311.MatchCode.ExactMatch => le.LIC_STATEWeight,MIN(le.LIC_STATEWeight,ri.LIC_STATEWeight-1) );
  SELF.C_LIC_NBRWeight := MAP( ri.C_LIC_NBRWeight=0 OR le.C_LIC_NBR_match_code=SALT311.MatchCode.ExactMatch => le.C_LIC_NBRWeight,MIN(le.C_LIC_NBRWeight,ri.C_LIC_NBRWeight-1) );
  SELF.TAX_IDWeight := MAP( ri.TAX_IDWeight=0 OR le.TAX_ID_match_code=SALT311.MatchCode.ExactMatch => le.TAX_IDWeight,MIN(le.TAX_IDWeight,ri.TAX_IDWeight-1) );
  SELF.BILLING_TAX_IDWeight := MAP( ri.BILLING_TAX_IDWeight=0 OR le.BILLING_TAX_ID_match_code=SALT311.MatchCode.ExactMatch => le.BILLING_TAX_IDWeight,MIN(le.BILLING_TAX_IDWeight,ri.BILLING_TAX_IDWeight-1) );
  SELF.DEA_NUMBERWeight := MAP( ri.DEA_NUMBERWeight=0 OR le.DEA_NUMBER_match_code=SALT311.MatchCode.ExactMatch => le.DEA_NUMBERWeight,MIN(le.DEA_NUMBERWeight,ri.DEA_NUMBERWeight-1) );
  SELF.VENDOR_IDWeight := MAP( ri.VENDOR_IDWeight=0 OR le.VENDOR_ID_match_code=SALT311.MatchCode.ExactMatch => le.VENDOR_IDWeight,MIN(le.VENDOR_IDWeight,ri.VENDOR_IDWeight-1) );
  SELF.NPI_NUMBERWeight := MAP( ri.NPI_NUMBERWeight=0 OR le.NPI_NUMBER_match_code=SALT311.MatchCode.ExactMatch => le.NPI_NUMBERWeight,MIN(le.NPI_NUMBERWeight,ri.NPI_NUMBERWeight-1) );
  SELF.BILLING_NPI_NUMBERWeight := MAP( ri.BILLING_NPI_NUMBERWeight=0 OR le.BILLING_NPI_NUMBER_match_code=SALT311.MatchCode.ExactMatch => le.BILLING_NPI_NUMBERWeight,MIN(le.BILLING_NPI_NUMBERWeight,ri.BILLING_NPI_NUMBERWeight-1) );
  SELF.UPINWeight := MAP( ri.UPINWeight=0 OR le.UPIN_match_code=SALT311.MatchCode.ExactMatch => le.UPINWeight,MIN(le.UPINWeight,ri.UPINWeight-1) );
  SELF.DIDWeight := MAP( ri.DIDWeight=0 OR le.DID_match_code=SALT311.MatchCode.ExactMatch => le.DIDWeight,MIN(le.DIDWeight,ri.DIDWeight-1) );
  SELF.BDIDWeight := MAP( ri.BDIDWeight=0 OR le.BDID_match_code=SALT311.MatchCode.ExactMatch => le.BDIDWeight,MIN(le.BDIDWeight,ri.BDIDWeight-1) );
  SELF.SRCWeight := MAP( ri.SRCWeight=0 OR le.SRC_match_code=SALT311.MatchCode.ExactMatch => le.SRCWeight,MIN(le.SRCWeight,ri.SRCWeight-1) );
  SELF.SOURCE_RIDWeight := MAP( ri.SOURCE_RIDWeight=0 OR le.SOURCE_RID_match_code=SALT311.MatchCode.ExactMatch => le.SOURCE_RIDWeight,MIN(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight-1) );
  SELF.RIDWeight := MAP( ri.RIDWeight=0 OR le.RID_match_code=SALT311.MatchCode.ExactMatch => le.RIDWeight,MIN(le.RIDWeight,ri.RIDWeight-1) );
  SELF.MAINNAMEWeight := MAP( ri.MAINNAMEWeight=0 OR le.MAINNAME_match_code=SALT311.MatchCode.ExactMatch => le.MAINNAMEWeight,MIN(le.MAINNAMEWeight,ri.MAINNAMEWeight-1) );
  SELF.FULLNAMEWeight := MAP( ri.FULLNAMEWeight=0 OR le.FULLNAME_match_code=SALT311.MatchCode.ExactMatch => le.FULLNAMEWeight,MIN(le.FULLNAMEWeight,ri.FULLNAMEWeight-1) );
  SELF.ADDR1Weight := MAP( ri.ADDR1Weight=0 OR le.ADDR1_match_code=SALT311.MatchCode.ExactMatch => le.ADDR1Weight,MIN(le.ADDR1Weight,ri.ADDR1Weight-1) );
  SELF.LOCALEWeight := MAP( ri.LOCALEWeight=0 OR le.LOCALE_match_code=SALT311.MatchCode.ExactMatch => le.LOCALEWeight,MIN(le.LOCALEWeight,ri.LOCALEWeight-1) );
  SELF.ADDRESSWeight := MAP( ri.ADDRESSWeight=0 OR le.ADDRESS_match_code=SALT311.MatchCode.ExactMatch => le.ADDRESSWeight,MIN(le.ADDRESSWeight,ri.ADDRESSWeight-1) );
  INTEGER2 Weight := MAX(0, SELF.GENDERWeight) + MAX(0, SELF.SSNWeight) + MAX(0, SELF.CNSMR_SSNWeight) + MAX(0, SELF.DOBWeight) + MAX(0, SELF.CNSMR_DOBWeight) + MAX(0, SELF.PHONEWeight) + MAX(0, SELF.LIC_STATEWeight) + MAX(0, SELF.C_LIC_NBRWeight) + MAX(0, SELF.TAX_IDWeight) + MAX(0, SELF.BILLING_TAX_IDWeight) + MAX(0, SELF.DEA_NUMBERWeight) + MAX(0, SELF.VENDOR_IDWeight) + MAX(0, SELF.NPI_NUMBERWeight) + MAX(0, SELF.BILLING_NPI_NUMBERWeight) + MAX(0, SELF.UPINWeight) + MAX(0, SELF.DIDWeight) + MAX(0, SELF.BDIDWeight) + MAX(0, SELF.SRCWeight) + MAX(0, SELF.SOURCE_RIDWeight) + MAX(0, SELF.RIDWeight) + (MAX(SELF.MAINNAMEWeight, (MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.LNAMEWeight))) + MAX(0, SELF.SNAMEWeight)) + ((MAX(0, SELF.PRIM_NAMEWeight) + MAX(0, SELF.PRIM_RANGEWeight) + MAX(0, SELF.SEC_RANGEWeight)) + (MAX(0, SELF.V_CITY_NAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.ZIPWeight)));
  SELF.Weight := IF(Weight>0,Weight,MAX(0,le.Weight));
  SELF := le;
END;
 
  R2 := JOIN(in_data,R1,LEFT.reference=RIGHT.reference,FixScores(LEFT,RIGHT));
  RETURN SORT(GROUP(R2,Reference,ALL),-weight,LNPID);
END;
EXPORT CombineAllScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
  OutputLayout_Batch Create_Output(LayoutScoredFetch le, DATASET(LayoutScoredFetch) ri) := TRANSFORM
    SELF.Results := ri;
    SELF.Reference := le.Reference;
    MAC_Add_ResolutionFlags()
  END;
  r0 := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(Reference)),Reference, LOCAL ), Reference, LOCAL),LNPID),LEFT.LNPID=RIGHT.LNPID,Combine_Scores(LEFT,RIGHT))(SALT311.DebugMode OR ~ForceFailed);
  r1 := AdjustScoresForNonExactMatches(UNGROUP(r0));
  R2 := ROLLUP( TOPN(r1,100,-Weight),GROUP, Create_Output(LEFT,ROWS(LEFT)) );
  SALT311.MAC_External_AddPcnt(R2,LayoutScoredFetch,Results,OutputLayout_Batch,23,R3);
  RETURN r3;
END;
EXPORT CombineLinkpathScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
// Note - results are returned distributed by HASH(reference) - this is part of the specification
  rolled := ROLLUP ( SORT( DISTRIBUTE( in_data, HASH(reference) ), Reference, LNPID, LOCAL), Combine_Scores(LEFT,RIGHT), Reference, LNPID, LOCAL);
  RETURN DEDUP( SORT( rolled, Reference, -weight, LOCAL ), Reference, KEEP(Config.LinkpathCandidateCount),LOCAL);
END;
EXPORT KeysUsedToText(UNSIGNED4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','') + IF(k&(1<<1)<>0,'NAMEL,','') + IF(k&(1<<2)<>0,'FNAME,','') + IF(k&(1<<3)<>0,'NAMEC,','') + IF(k&(1<<4)<>0,'LNAME,','') + IF(k&(1<<5)<>0,'MNAME,','') + IF(k&(1<<6)<>0,'ADDRESS,','') + IF(k&(1<<7)<>0,'ZIP_PR,','') + IF(k&(1<<8)<>0,'SSN_LP,','') + IF(k&(1<<9)<>0,'CNSMR_SSN_LP,','') + IF(k&(1<<10)<>0,'DOB_LP,','') + IF(k&(1<<11)<>0,'CNSMR_DOB_LP,','') + IF(k&(1<<12)<>0,'PHONE_LP,','') + IF(k&(1<<13)<>0,'LIC,','') + IF(k&(1<<14)<>0,'VEN,','') + IF(k&(1<<15)<>0,'TAX,','') + IF(k&(1<<16)<>0,'BILLING_TAX,','') + IF(k&(1<<17)<>0,'DEA,','') + IF(k&(1<<18)<>0,'NPI,','') + IF(k&(1<<19)<>0,'BILLING_NPI,','') + IF(k&(1<<20)<>0,'UPN,','') + IF(k&(1<<21)<>0,'LEXID,','') + IF(k&(1<<22)<>0,'BID,','') + IF(k&(1<<23)<>0,'SRC_RID,','') + IF(k&(1<<24)<>0,'RID,','');
  RETURN list[1..LENGTH(TRIM(list))-1]; // Strim last ,
end;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT311.UIDType LNPID;
  DATASET(SALT311.Layout_FieldValueList) GENDER_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) SSN_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) CNSMR_SSN_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) DOB_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) CNSMR_DOB_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) PHONE_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) LIC_STATE_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) C_LIC_NBR_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) TAX_ID_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) BILLING_TAX_ID_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) DEA_NUMBER_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) VENDOR_ID_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) NPI_NUMBER_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) BILLING_NPI_NUMBER_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) UPIN_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) DID_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) BDID_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) SRC_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) SOURCE_RID_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) RID_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) FULLNAME_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) ADDRESS_Values := DATASET([],SALT311.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.LNPID := le.LNPID;
    SELF.GENDER_values := SALT311.fn_combine_fieldvaluelist(le.GENDER_values,ri.GENDER_values);
    SELF.SSN_values := SALT311.fn_combine_fieldvaluelist(le.SSN_values,ri.SSN_values);
    SELF.CNSMR_SSN_values := SALT311.fn_combine_fieldvaluelist(le.CNSMR_SSN_values,ri.CNSMR_SSN_values);
    SELF.DOB_values := SALT311.fn_combine_fieldvaluelist(le.DOB_values,ri.DOB_values);
    SELF.CNSMR_DOB_values := SALT311.fn_combine_fieldvaluelist(le.CNSMR_DOB_values,ri.CNSMR_DOB_values);
    SELF.PHONE_values := SALT311.fn_combine_fieldvaluelist(le.PHONE_values,ri.PHONE_values);
    SELF.LIC_STATE_values := SALT311.fn_combine_fieldvaluelist(le.LIC_STATE_values,ri.LIC_STATE_values);
    SELF.C_LIC_NBR_values := SALT311.fn_combine_fieldvaluelist(le.C_LIC_NBR_values,ri.C_LIC_NBR_values);
    SELF.TAX_ID_values := SALT311.fn_combine_fieldvaluelist(le.TAX_ID_values,ri.TAX_ID_values);
    SELF.BILLING_TAX_ID_values := SALT311.fn_combine_fieldvaluelist(le.BILLING_TAX_ID_values,ri.BILLING_TAX_ID_values);
    SELF.DEA_NUMBER_values := SALT311.fn_combine_fieldvaluelist(le.DEA_NUMBER_values,ri.DEA_NUMBER_values);
    SELF.VENDOR_ID_values := SALT311.fn_combine_fieldvaluelist(le.VENDOR_ID_values,ri.VENDOR_ID_values);
    SELF.NPI_NUMBER_values := SALT311.fn_combine_fieldvaluelist(le.NPI_NUMBER_values,ri.NPI_NUMBER_values);
    SELF.BILLING_NPI_NUMBER_values := SALT311.fn_combine_fieldvaluelist(le.BILLING_NPI_NUMBER_values,ri.BILLING_NPI_NUMBER_values);
    SELF.UPIN_values := SALT311.fn_combine_fieldvaluelist(le.UPIN_values,ri.UPIN_values);
    SELF.DID_values := SALT311.fn_combine_fieldvaluelist(le.DID_values,ri.DID_values);
    SELF.BDID_values := SALT311.fn_combine_fieldvaluelist(le.BDID_values,ri.BDID_values);
    SELF.SRC_values := SALT311.fn_combine_fieldvaluelist(le.SRC_values,ri.SRC_values);
    SELF.SOURCE_RID_values := SALT311.fn_combine_fieldvaluelist(le.SOURCE_RID_values,ri.SOURCE_RID_values);
    SELF.RID_values := SALT311.fn_combine_fieldvaluelist(le.RID_values,ri.RID_values);
    SELF.FULLNAME_values := SALT311.fn_combine_fieldvaluelist(le.FULLNAME_values,ri.FULLNAME_values);
    SELF.ADDRESS_values := SALT311.fn_combine_fieldvaluelist(le.ADDRESS_values,ri.ADDRESS_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(LNPID) ), LNPID, LOCAL ), LEFT.LNPID = RIGHT.LNPID, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.LNPID := le.LNPID;
    SELF.GENDER_values := SORT(le.GENDER_values, -cnt, val, LOCAL);
    SELF.SSN_values := SORT(le.SSN_values, -cnt, val, LOCAL);
    SELF.CNSMR_SSN_values := SORT(le.CNSMR_SSN_values, -cnt, val, LOCAL);
    SELF.DOB_values := SORT(le.DOB_values, -cnt, val, LOCAL);
    SELF.CNSMR_DOB_values := SORT(le.CNSMR_DOB_values, -cnt, val, LOCAL);
    SELF.PHONE_values := SORT(le.PHONE_values, -cnt, val, LOCAL);
    SELF.LIC_STATE_values := SORT(le.LIC_STATE_values, -cnt, val, LOCAL);
    SELF.C_LIC_NBR_values := SORT(le.C_LIC_NBR_values, -cnt, val, LOCAL);
    SELF.TAX_ID_values := SORT(le.TAX_ID_values, -cnt, val, LOCAL);
    SELF.BILLING_TAX_ID_values := SORT(le.BILLING_TAX_ID_values, -cnt, val, LOCAL);
    SELF.DEA_NUMBER_values := SORT(le.DEA_NUMBER_values, -cnt, val, LOCAL);
    SELF.VENDOR_ID_values := SORT(le.VENDOR_ID_values, -cnt, val, LOCAL);
    SELF.NPI_NUMBER_values := SORT(le.NPI_NUMBER_values, -cnt, val, LOCAL);
    SELF.BILLING_NPI_NUMBER_values := SORT(le.BILLING_NPI_NUMBER_values, -cnt, val, LOCAL);
    SELF.UPIN_values := SORT(le.UPIN_values, -cnt, val, LOCAL);
    SELF.DID_values := SORT(le.DID_values, -cnt, val, LOCAL);
    SELF.BDID_values := SORT(le.BDID_values, -cnt, val, LOCAL);
    SELF.SRC_values := SORT(le.SRC_values, -cnt, val, LOCAL);
    SELF.SOURCE_RID_values := SORT(le.SOURCE_RID_values, -cnt, val, LOCAL);
    SELF.RID_values := SORT(le.RID_values, -cnt, val, LOCAL);
    SELF.FULLNAME_values := SORT(le.FULLNAME_values, -cnt, val, LOCAL);
    SELF.ADDRESS_values := SORT(le.ADDRESS_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(RECORDOF(Key)) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.LNPID := le.LNPID;
  SELF.GENDER_Values := IF ( (SALT311.StrType)le.GENDER = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.GENDER)}],SALT311.Layout_FieldValueList));
  SELF.SSN_Values := IF ( (SALT311.StrType)le.SSN = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.SSN)}],SALT311.Layout_FieldValueList));
  SELF.CNSMR_SSN_Values := IF ( (SALT311.StrType)le.CNSMR_SSN = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.CNSMR_SSN)}],SALT311.Layout_FieldValueList));
  self.DOB_Values := IF ( (unsigned)le.DOB = 0,dataset([],SALT311.Layout_FieldValueList),dataset([{(SALT311.StrType)le.DOB}],SALT311.Layout_FieldValueList));
  self.CNSMR_DOB_Values := IF ( (unsigned)le.CNSMR_DOB = 0,dataset([],SALT311.Layout_FieldValueList),dataset([{(SALT311.StrType)le.CNSMR_DOB}],SALT311.Layout_FieldValueList));
  SELF.PHONE_Values := IF ( (SALT311.StrType)le.PHONE = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.PHONE)}],SALT311.Layout_FieldValueList));
  SELF.LIC_STATE_Values := IF ( (SALT311.StrType)le.LIC_STATE = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.LIC_STATE)}],SALT311.Layout_FieldValueList));
  SELF.C_LIC_NBR_Values := IF ( (SALT311.StrType)le.C_LIC_NBR = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.C_LIC_NBR)}],SALT311.Layout_FieldValueList));
  SELF.TAX_ID_Values := IF ( (SALT311.StrType)le.TAX_ID = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.TAX_ID)}],SALT311.Layout_FieldValueList));
  SELF.BILLING_TAX_ID_Values := IF ( (SALT311.StrType)le.BILLING_TAX_ID = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.BILLING_TAX_ID)}],SALT311.Layout_FieldValueList));
  SELF.DEA_NUMBER_Values := IF ( (SALT311.StrType)le.DEA_NUMBER = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.DEA_NUMBER)}],SALT311.Layout_FieldValueList));
  SELF.VENDOR_ID_Values := IF ( (SALT311.StrType)le.VENDOR_ID = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.VENDOR_ID)}],SALT311.Layout_FieldValueList));
  SELF.NPI_NUMBER_Values := IF ( (SALT311.StrType)le.NPI_NUMBER = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.NPI_NUMBER)}],SALT311.Layout_FieldValueList));
  SELF.BILLING_NPI_NUMBER_Values := IF ( (SALT311.StrType)le.BILLING_NPI_NUMBER = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.BILLING_NPI_NUMBER)}],SALT311.Layout_FieldValueList));
  SELF.UPIN_Values := IF ( (SALT311.StrType)le.UPIN = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.UPIN)}],SALT311.Layout_FieldValueList));
  SELF.DID_Values := IF ( (SALT311.StrType)le.DID = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.DID)}],SALT311.Layout_FieldValueList));
  SELF.BDID_Values := IF ( (SALT311.StrType)le.BDID = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.BDID)}],SALT311.Layout_FieldValueList));
  SELF.SRC_Values := IF ( (SALT311.StrType)le.SRC = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.SRC)}],SALT311.Layout_FieldValueList));
  SELF.SOURCE_RID_Values := IF ( (SALT311.StrType)le.SOURCE_RID = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.SOURCE_RID)}],SALT311.Layout_FieldValueList));
  SELF.RID_Values := IF ( (SALT311.StrType)le.RID = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.RID)}],SALT311.Layout_FieldValueList));
  SELF.FULLNAME_Values := IF ( (SALT311.StrType)le.FNAME = '' AND (SALT311.StrType)le.MNAME = '' AND (SALT311.StrType)le.LNAME = '' AND (SALT311.StrType)le.SNAME = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.FNAME) + ' ' + TRIM((SALT311.StrType)le.MNAME) + ' ' + TRIM((SALT311.StrType)le.LNAME) + ' ' + TRIM((SALT311.StrType)le.SNAME)}],SALT311.Layout_FieldValueList));
  SELF.ADDRESS_Values := IF ( (SALT311.StrType)le.PRIM_NAME = '' AND (SALT311.StrType)le.PRIM_RANGE = '' AND (SALT311.StrType)le.SEC_RANGE = '' AND (SALT311.StrType)le.V_CITY_NAME = '' AND (SALT311.StrType)le.ST = '' AND (SALT311.StrType)le.ZIP = '',DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT311.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT311.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT311.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT311.StrType)le.ST) + ' ' + TRIM((SALT311.StrType)le.ZIP)}],SALT311.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
END;
