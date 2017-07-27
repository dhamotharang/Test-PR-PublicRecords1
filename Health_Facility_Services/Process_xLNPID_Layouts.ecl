EXPORT Process_xLNPID_Layouts := MODULE
IMPORT SALT29;
SHARED h := File_HealthFacility;//The input file
EXPORT KeyName := Health_Facility_Services.Files.FILE_Header_SF; //'~'+'key::Health_Facility_Services::LNPID::meow';
EXPORT Key := INDEX(h,{LNPID},{h},KeyName);
EXPORT BuildAll := SEQUENTIAL(BUILDINDEX(Key, Health_Facility_Services.Files.FILE_Header,OVERWRITE));
EXPORT id_stream_layout := RECORD
    UNSIGNED4 UniqueId;
    INTEGER2 Weight;
    UNSIGNED4 KeysUsed := 0;
    UNSIGNED4 KeysFailed := 0;
    UNSIGNED8 LNPID;
  END;
EXPORT InputLayout := RECORD
  UNSIGNED4 UniqueId; // This had better be unique or it will all break horribly
  UNSIGNED2 MaxIDs := 50; // Maximum number of candidate IDs
  UNSIGNED2 LeadThreshold := 0; // Maximum distance from best to worst (0 => no pruning)
  h.CNAME;
  h.CNP_NAME;
  h.CNP_NUMBER;
  h.CNP_STORE_NUMBER;
  h.CNP_BTYPE;
  h.CNP_LOWV;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.V_CITY_NAME;
  h.ST;
  h.ZIP;
  h.TAX_ID;
  h.FEIN;
  h.PHONE;
  h.FAX;
  h.LIC_STATE;
  h.C_LIC_NBR;
  h.DEA_NUMBER;
  h.VENDOR_ID;
  h.NPI_NUMBER;
  h.CLIA_NUMBER;
  h.MEDICARE_FACILITY_NUMBER;
  h.MEDICAID_NUMBER;
  h.NCPDP_NUMBER;
  h.TAXONOMY;
  h.TAXONOMY_CODE;
  h.BDID;
  h.SRC;
  h.SOURCE_RID;
  SALT29.StrType FAC_NAME;//Wordbag field for concept
  SALT29.StrType ADDR1;//Wordbag field for concept
  SALT29.StrType LOCALE;//Wordbag field for concept
  SALT29.StrType ADDRES;//Wordbag field for concept
// Below only used in header search (data returning) case
  BOOLEAN MatchRecords := false; // Only show records which match
  BOOLEAN FullMatch := false; // Only show LNPID if it has a record which fully matches
  UNSIGNED8 Entered_LNPID := 0; // Allow user to enter LNPID to pull data
END;
// A function to turn data in the input layout function into 'baby' match candidates form
EXPORT InputToMC(DATASET(InputLayout) Inp) := FUNCTION
  r := RECORD
    inp.CNAME;
    STRING240 CNP_NAME := SALT29.fn_WordBag_AppendSpecs_Fake(inp.CNP_NAME); // Needs to look like a wordbag 
    inp.CNP_NUMBER;
    inp.CNP_STORE_NUMBER;
    inp.CNP_BTYPE;
    inp.CNP_LOWV;
    inp.PRIM_RANGE;
    inp.PRIM_NAME;
    inp.SEC_RANGE;
    inp.V_CITY_NAME;
    inp.ST;
    inp.ZIP;
    inp.TAX_ID;
    inp.FEIN;
    inp.PHONE;
    STRING10 PHONE_CleanPhone := fn_cleanphone(inp.PHONE);
    inp.FAX;
    STRING10 FAX_CleanPhone := fn_cleanphone(inp.FAX);
    inp.LIC_STATE;
    inp.C_LIC_NBR;
    inp.DEA_NUMBER;
    inp.VENDOR_ID;
    inp.NPI_NUMBER;
    inp.CLIA_NUMBER;
    inp.MEDICARE_FACILITY_NUMBER;
    inp.MEDICAID_NUMBER;
    inp.NCPDP_NUMBER;
    inp.TAXONOMY;
    inp.TAXONOMY_CODE;
    inp.BDID;
    inp.SRC;
    inp.SOURCE_RID;
    LNPID := inp.Entered_LNPID;
  END;
  RETURN TABLE(inp,r);
END;
EXPORT HardKeyMatch(InputLayout le) := le.CNP_NAME <> (typeof(le.CNP_NAME))'' AND le.ZIP <> (typeof(le.ZIP))'' OR le.CNP_NAME <> (typeof(le.CNP_NAME))'' OR le.CNP_NAME <> (typeof(le.CNP_NAME))'' AND le.ST <> (typeof(le.ST))'' OR le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.PRIM_RANGE <> (typeof(le.PRIM_RANGE))'' AND le.ZIP <> (typeof(le.ZIP))'' OR le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.ZIP <> (typeof(le.ZIP))'' OR le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.V_CITY_NAME <> (typeof(le.V_CITY_NAME))'' AND le.ST <> (typeof(le.ST))'' OR le.PHONE <> (typeof(le.PHONE))'' OR le.FAX <> (typeof(le.FAX))'' OR le.C_LIC_NBR <> (typeof(le.C_LIC_NBR))'' OR le.VENDOR_ID <> (typeof(le.VENDOR_ID))'' OR le.TAX_ID <> (typeof(le.TAX_ID))'' OR le.FEIN <> (typeof(le.FEIN))'' OR le.DEA_NUMBER <> (typeof(le.DEA_NUMBER))'' OR le.NPI_NUMBER <> (typeof(le.NPI_NUMBER))'' OR le.NPI_NUMBER <> (typeof(le.NPI_NUMBER))'' OR le.CLIA_NUMBER <> (typeof(le.CLIA_NUMBER))'' OR le.MEDICARE_FACILITY_NUMBER <> (typeof(le.MEDICARE_FACILITY_NUMBER))'' OR le.MEDICAID_NUMBER <> (typeof(le.MEDICAID_NUMBER))'' OR le.NCPDP_NUMBER <> (typeof(le.NCPDP_NUMBER))'' OR le.BDID <> (typeof(le.BDID))'';
EXPORT LayoutScoredFetch := RECORD // Nulls required for linkpaths that do not have field
  h.LNPID;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT29.UIDType Reference := 0;//Presently for batch
  BOOLEAN ForceFailed := FALSE;
  TYPEOF(h.CNAME) CNAME := (TYPEOF(h.CNAME))'';
  INTEGER2 CNAMEWeight := 0;
  INTEGER1 CNAME_match_code := 0;
  TYPEOF(h.CNP_NAME) CNP_NAME := (TYPEOF(h.CNP_NAME))'';
  INTEGER2 CNP_NAMEWeight := 0;
  DATASET(SALT29.layout_gss_cases) CNP_NAME_GSS_cases := DATASET([],SALT29.layout_gss_cases);
  INTEGER2 CNP_NAME_GSS_Weight := 0;
  INTEGER1 CNP_NAME_match_code := 0;
  TYPEOF(h.CNP_NUMBER) CNP_NUMBER := (TYPEOF(h.CNP_NUMBER))'';
  INTEGER2 CNP_NUMBERWeight := 0;
  INTEGER1 CNP_NUMBER_match_code := 0;
  TYPEOF(h.CNP_STORE_NUMBER) CNP_STORE_NUMBER := (TYPEOF(h.CNP_STORE_NUMBER))'';
  INTEGER2 CNP_STORE_NUMBERWeight := 0;
  INTEGER1 CNP_STORE_NUMBER_match_code := 0;
  TYPEOF(h.CNP_BTYPE) CNP_BTYPE := (TYPEOF(h.CNP_BTYPE))'';
  INTEGER2 CNP_BTYPEWeight := 0;
  INTEGER1 CNP_BTYPE_match_code := 0;
  TYPEOF(h.CNP_LOWV) CNP_LOWV := (TYPEOF(h.CNP_LOWV))'';
  INTEGER2 CNP_LOWVWeight := 0;
  INTEGER1 CNP_LOWV_match_code := 0;
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
  TYPEOF(h.TAX_ID) TAX_ID := (TYPEOF(h.TAX_ID))'';
  INTEGER2 TAX_IDWeight := 0;
  INTEGER1 TAX_ID_match_code := 0;
  TYPEOF(h.FEIN) FEIN := (TYPEOF(h.FEIN))'';
  INTEGER2 FEINWeight := 0;
  INTEGER1 FEIN_match_code := 0;
  TYPEOF(h.PHONE) PHONE := (TYPEOF(h.PHONE))'';
  INTEGER2 PHONEWeight := 0;
  INTEGER1 PHONE_match_code := 0;
  TYPEOF(h.FAX) FAX := (TYPEOF(h.FAX))'';
  INTEGER2 FAXWeight := 0;
  INTEGER1 FAX_match_code := 0;
  TYPEOF(h.LIC_STATE) LIC_STATE := (TYPEOF(h.LIC_STATE))'';
  INTEGER2 LIC_STATEWeight := 0;
  INTEGER1 LIC_STATE_match_code := 0;
  TYPEOF(h.C_LIC_NBR) C_LIC_NBR := (TYPEOF(h.C_LIC_NBR))'';
  INTEGER2 C_LIC_NBRWeight := 0;
  INTEGER1 C_LIC_NBR_match_code := 0;
  TYPEOF(h.DEA_NUMBER) DEA_NUMBER := (TYPEOF(h.DEA_NUMBER))'';
  INTEGER2 DEA_NUMBERWeight := 0;
  INTEGER1 DEA_NUMBER_match_code := 0;
  TYPEOF(h.VENDOR_ID) VENDOR_ID := (TYPEOF(h.VENDOR_ID))'';
  INTEGER2 VENDOR_IDWeight := 0;
  INTEGER1 VENDOR_ID_match_code := 0;
  TYPEOF(h.NPI_NUMBER) NPI_NUMBER := (TYPEOF(h.NPI_NUMBER))'';
  INTEGER2 NPI_NUMBERWeight := 0;
  INTEGER1 NPI_NUMBER_match_code := 0;
  TYPEOF(h.CLIA_NUMBER) CLIA_NUMBER := (TYPEOF(h.CLIA_NUMBER))'';
  INTEGER2 CLIA_NUMBERWeight := 0;
  INTEGER1 CLIA_NUMBER_match_code := 0;
  TYPEOF(h.MEDICARE_FACILITY_NUMBER) MEDICARE_FACILITY_NUMBER := (TYPEOF(h.MEDICARE_FACILITY_NUMBER))'';
  INTEGER2 MEDICARE_FACILITY_NUMBERWeight := 0;
  INTEGER1 MEDICARE_FACILITY_NUMBER_match_code := 0;
  TYPEOF(h.MEDICAID_NUMBER) MEDICAID_NUMBER := (TYPEOF(h.MEDICAID_NUMBER))'';
  INTEGER2 MEDICAID_NUMBERWeight := 0;
  INTEGER1 MEDICAID_NUMBER_match_code := 0;
  TYPEOF(h.NCPDP_NUMBER) NCPDP_NUMBER := (TYPEOF(h.NCPDP_NUMBER))'';
  INTEGER2 NCPDP_NUMBERWeight := 0;
  INTEGER1 NCPDP_NUMBER_match_code := 0;
  TYPEOF(h.TAXONOMY) TAXONOMY := (TYPEOF(h.TAXONOMY))'';
  INTEGER2 TAXONOMYWeight := 0;
  INTEGER1 TAXONOMY_match_code := 0;
  TYPEOF(h.TAXONOMY_CODE) TAXONOMY_CODE := (TYPEOF(h.TAXONOMY_CODE))'';
  INTEGER2 TAXONOMY_CODEWeight := 0;
  INTEGER1 TAXONOMY_CODE_match_code := 0;
  TYPEOF(h.BDID) BDID := (TYPEOF(h.BDID))'';
  INTEGER2 BDIDWeight := 0;
  INTEGER1 BDID_match_code := 0;
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))'';
  INTEGER2 SRCWeight := 0;
  INTEGER1 SRC_match_code := 0;
  TYPEOF(h.SOURCE_RID) SOURCE_RID := (TYPEOF(h.SOURCE_RID))'';
  INTEGER2 SOURCE_RIDWeight := 0;
  INTEGER1 SOURCE_RID_match_code := 0;
  SALT29.StrType FAC_NAME := ''; // Concepts always a wordbag
  INTEGER2 FAC_NAMEWeight := 0;
  INTEGER1 FAC_NAME_match_code := 0;
  SALT29.StrType ADDR1 := ''; // Concepts always a wordbag
  INTEGER2 ADDR1Weight := 0;
  INTEGER1 ADDR1_match_code := 0;
  SALT29.StrType LOCALE := ''; // Concepts always a wordbag
  INTEGER2 LOCALEWeight := 0;
  INTEGER1 LOCALE_match_code := 0;
  SALT29.StrType ADDRES := ''; // Concepts always a wordbag
  INTEGER2 ADDRESWeight := 0;
  INTEGER1 ADDRES_match_code := 0;
  UNSIGNED4 keys_used; // A bitmap of the keys used
  UNSIGNED4 keys_failed; // A bitmap of the keys that failed the fetch
END;
EXPORT isLeftWinner(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT29.MatchCode.NoMatch, INTEGER1 r_mc=SALT29.MatchCode.NoMatch) :=
  MAP(l_mc=SALT29.MatchCode.ExactMatch AND r_mc=SALT29.MatchCode.ExactMatch AND l_weight>r_weight => true,
      NOT(l_mc=SALT29.MatchCode.ExactMatch OR r_mc=SALT29.MatchCode.ExactMatch) AND l_weight>r_weight => true,
      l_mc=SALT29.MatchCode.ExactMatch => true,false);
EXPORT isWeightForcedDown(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT29.MatchCode.NoMatch, INTEGER1 r_mc=SALT29.MatchCode.NoMatch) :=
  IF((isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight < r_weight)) OR  (NOT isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight > r_weight)),true,false);
EXPORT LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri) := TRANSFORM
  BOOLEAN CNAMEWeightForcedDown := IF ( isWeightForcedDown(le.CNAMEWeight,ri.CNAMEWeight,le.CNAME_match_code,ri.CNAME_match_code),true,false );
	BOOLEAN CNP_NAMEWeightForcedDown := IF ( isWeightForcedDown(le.CNP_NAMEWeight,ri.CNP_NAMEWeight,le.CNP_NAME_match_code,ri.CNP_NAME_match_code),true,false );  SELF.CNAMEWeight := IF ( isLeftWinner(le.CNAMEWeight,ri.CNAMEWeight,le.CNAME_match_code,ri.CNAME_match_code), le.CNAMEWeight, ri.CNAMEWeight );
  // SELF.CNAMEWeight := IF ( isLeftWinner(le.CNAMEWeight,ri.CNAMEWeight,le.CNAME_match_code,ri.CNAME_match_code), le.CNAMEWeight, ri.CNAMEWeight );
  SELF.CNAME := IF ( isLeftWinner(le.CNAMEWeight,ri.CNAMEWeight,le.CNAME_match_code,ri.CNAME_match_code ), le.CNAME, ri.CNAME );
  SELF.CNAME_match_code := IF ( isLeftWinner(le.CNAMEWeight,ri.CNAMEWeight,le.CNAME_match_code,ri.CNAME_match_code), le.CNAME_match_code, ri.CNAME_match_code );
  SELF.CNP_NAME_gss_Weight := IF ( EXISTS(le.CNP_NAME_gss_cases(ri.CNP_NAME_gss_cases[1].gss_hash=gss_hash)), le.CNP_NAME_gss_Weight, le.CNP_NAME_gss_Weight + ri.CNP_NAME_gss_Weight );
  SELF.CNP_NAME_gss_cases := IF ( EXISTS(le.CNP_NAME_gss_cases(ri.CNP_NAME_gss_cases[1].gss_hash=gss_hash)), le.CNP_NAME_gss_cases, le.CNP_NAME_gss_cases + ri.CNP_NAME_gss_cases );
  SELF.CNP_NAMEWeight := MAP ( SELF.CNP_NAME_GSS_Weight > le.CNP_NAMEWeight AND SELF.CNP_NAME_GSS_Weight > ri.CNP_NAMEWeight => SELF.CNP_NAME_GSS_Weight,
                         le.CNP_NAMEWeight>ri.CNP_NAMEWeight => le.CNP_NAMEWeight, ri.CNP_NAMEWeight );
  SELF.CNP_NAME := IF ( le.CNP_NAMEWeight>ri.CNP_NAMEWeight AND le.CNP_NAME <> (TYPEOF(le.CNP_NAME))'', le.CNP_NAME, ri.CNP_NAME );
  SELF.CNP_NAME_match_code := IF ( isLeftWinner(le.CNP_NAMEWeight,ri.CNP_NAMEWeight,le.CNP_NAME_match_code,ri.CNP_NAME_match_code), le.CNP_NAME_match_code, ri.CNP_NAME_match_code );
  BOOLEAN CNP_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.CNP_NUMBERWeight,ri.CNP_NUMBERWeight,le.CNP_NUMBER_match_code,ri.CNP_NUMBER_match_code),true,false );
  SELF.CNP_NUMBERWeight := IF ( isLeftWinner(le.CNP_NUMBERWeight,ri.CNP_NUMBERWeight,le.CNP_NUMBER_match_code,ri.CNP_NUMBER_match_code), le.CNP_NUMBERWeight, ri.CNP_NUMBERWeight );
  SELF.CNP_NUMBER := IF ( isLeftWinner(le.CNP_NUMBERWeight,ri.CNP_NUMBERWeight,le.CNP_NUMBER_match_code,ri.CNP_NUMBER_match_code ), le.CNP_NUMBER, ri.CNP_NUMBER );
  SELF.CNP_NUMBER_match_code := IF ( isLeftWinner(le.CNP_NUMBERWeight,ri.CNP_NUMBERWeight,le.CNP_NUMBER_match_code,ri.CNP_NUMBER_match_code), le.CNP_NUMBER_match_code, ri.CNP_NUMBER_match_code );
  BOOLEAN CNP_STORE_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.CNP_STORE_NUMBERWeight,ri.CNP_STORE_NUMBERWeight,le.CNP_STORE_NUMBER_match_code,ri.CNP_STORE_NUMBER_match_code),true,false );
  SELF.CNP_STORE_NUMBERWeight := IF ( isLeftWinner(le.CNP_STORE_NUMBERWeight,ri.CNP_STORE_NUMBERWeight,le.CNP_STORE_NUMBER_match_code,ri.CNP_STORE_NUMBER_match_code), le.CNP_STORE_NUMBERWeight, ri.CNP_STORE_NUMBERWeight );
  SELF.CNP_STORE_NUMBER := IF ( isLeftWinner(le.CNP_STORE_NUMBERWeight,ri.CNP_STORE_NUMBERWeight,le.CNP_STORE_NUMBER_match_code,ri.CNP_STORE_NUMBER_match_code ), le.CNP_STORE_NUMBER, ri.CNP_STORE_NUMBER );
  SELF.CNP_STORE_NUMBER_match_code := IF ( isLeftWinner(le.CNP_STORE_NUMBERWeight,ri.CNP_STORE_NUMBERWeight,le.CNP_STORE_NUMBER_match_code,ri.CNP_STORE_NUMBER_match_code), le.CNP_STORE_NUMBER_match_code, ri.CNP_STORE_NUMBER_match_code );
  BOOLEAN CNP_BTYPEWeightForcedDown := IF ( isWeightForcedDown(le.CNP_BTYPEWeight,ri.CNP_BTYPEWeight,le.CNP_BTYPE_match_code,ri.CNP_BTYPE_match_code),true,false );
  SELF.CNP_BTYPEWeight := IF ( isLeftWinner(le.CNP_BTYPEWeight,ri.CNP_BTYPEWeight,le.CNP_BTYPE_match_code,ri.CNP_BTYPE_match_code), le.CNP_BTYPEWeight, ri.CNP_BTYPEWeight );
  SELF.CNP_BTYPE := IF ( isLeftWinner(le.CNP_BTYPEWeight,ri.CNP_BTYPEWeight,le.CNP_BTYPE_match_code,ri.CNP_BTYPE_match_code ), le.CNP_BTYPE, ri.CNP_BTYPE );
  SELF.CNP_BTYPE_match_code := IF ( isLeftWinner(le.CNP_BTYPEWeight,ri.CNP_BTYPEWeight,le.CNP_BTYPE_match_code,ri.CNP_BTYPE_match_code), le.CNP_BTYPE_match_code, ri.CNP_BTYPE_match_code );
  BOOLEAN CNP_LOWVWeightForcedDown := IF ( isWeightForcedDown(le.CNP_LOWVWeight,ri.CNP_LOWVWeight,le.CNP_LOWV_match_code,ri.CNP_LOWV_match_code),true,false );
  SELF.CNP_LOWVWeight := IF ( isLeftWinner(le.CNP_LOWVWeight,ri.CNP_LOWVWeight,le.CNP_LOWV_match_code,ri.CNP_LOWV_match_code), le.CNP_LOWVWeight, ri.CNP_LOWVWeight );
  SELF.CNP_LOWV := IF ( isLeftWinner(le.CNP_LOWVWeight,ri.CNP_LOWVWeight,le.CNP_LOWV_match_code,ri.CNP_LOWV_match_code ), le.CNP_LOWV, ri.CNP_LOWV );
  SELF.CNP_LOWV_match_code := IF ( isLeftWinner(le.CNP_LOWVWeight,ri.CNP_LOWVWeight,le.CNP_LOWV_match_code,ri.CNP_LOWV_match_code), le.CNP_LOWV_match_code, ri.CNP_LOWV_match_code );
  BOOLEAN PRIM_RANGEWeightForcedDown := IF ( isWeightForcedDown(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code),true,false );
  SELF.PRIM_RANGEWeight := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code), le.PRIM_RANGEWeight, ri.PRIM_RANGEWeight );
  SELF.PRIM_RANGE := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code ), le.PRIM_RANGE, ri.PRIM_RANGE );
  SELF.PRIM_RANGE_match_code := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code), le.PRIM_RANGE_match_code, ri.PRIM_RANGE_match_code );
  BOOLEAN PRIM_NAMEWeightForcedDown := IF ( isWeightForcedDown(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code),true,false );
  SELF.PRIM_NAMEWeight := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code), le.PRIM_NAMEWeight, ri.PRIM_NAMEWeight );
  SELF.PRIM_NAME := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code ), le.PRIM_NAME, ri.PRIM_NAME );
  SELF.PRIM_NAME_match_code := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code), le.PRIM_NAME_match_code, ri.PRIM_NAME_match_code );
  BOOLEAN SEC_RANGEWeightForcedDown := IF ( isWeightForcedDown(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code),true,false );
  SELF.SEC_RANGEWeight := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code), le.SEC_RANGEWeight, ri.SEC_RANGEWeight );
  SELF.SEC_RANGE := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code ), le.SEC_RANGE, ri.SEC_RANGE );
  SELF.SEC_RANGE_match_code := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code), le.SEC_RANGE_match_code, ri.SEC_RANGE_match_code );
  BOOLEAN V_CITY_NAMEWeightForcedDown := IF ( isWeightForcedDown(le.V_CITY_NAMEWeight,ri.V_CITY_NAMEWeight,le.V_CITY_NAME_match_code,ri.V_CITY_NAME_match_code),true,false );
  SELF.V_CITY_NAMEWeight := IF ( isLeftWinner(le.V_CITY_NAMEWeight,ri.V_CITY_NAMEWeight,le.V_CITY_NAME_match_code,ri.V_CITY_NAME_match_code), le.V_CITY_NAMEWeight, ri.V_CITY_NAMEWeight );
  SELF.V_CITY_NAME := IF ( isLeftWinner(le.V_CITY_NAMEWeight,ri.V_CITY_NAMEWeight,le.V_CITY_NAME_match_code,ri.V_CITY_NAME_match_code ), le.V_CITY_NAME, ri.V_CITY_NAME );
  SELF.V_CITY_NAME_match_code := IF ( isLeftWinner(le.V_CITY_NAMEWeight,ri.V_CITY_NAMEWeight,le.V_CITY_NAME_match_code,ri.V_CITY_NAME_match_code), le.V_CITY_NAME_match_code, ri.V_CITY_NAME_match_code );
  BOOLEAN STWeightForcedDown := IF ( isWeightForcedDown(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code),true,false );
  SELF.STWeight := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code), le.STWeight, ri.STWeight );
  SELF.ST := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.ST, ri.ST );
  SELF.ST_match_code := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code), le.ST_match_code, ri.ST_match_code );
  BOOLEAN ZIPWeightForcedDown := IF ( isWeightForcedDown(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code),true,false );
  SELF.ZIPWeight := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code), le.ZIPWeight, ri.ZIPWeight );
  SELF.ZIP := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIP, ri.ZIP );
  SELF.ZIP_match_code := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code), le.ZIP_match_code, ri.ZIP_match_code );
  BOOLEAN TAX_IDWeightForcedDown := IF ( isWeightForcedDown(le.TAX_IDWeight,ri.TAX_IDWeight,le.TAX_ID_match_code,ri.TAX_ID_match_code),true,false );
  SELF.TAX_IDWeight := IF ( isLeftWinner(le.TAX_IDWeight,ri.TAX_IDWeight,le.TAX_ID_match_code,ri.TAX_ID_match_code), le.TAX_IDWeight, ri.TAX_IDWeight );
  SELF.TAX_ID := IF ( isLeftWinner(le.TAX_IDWeight,ri.TAX_IDWeight,le.TAX_ID_match_code,ri.TAX_ID_match_code ), le.TAX_ID, ri.TAX_ID );
  SELF.TAX_ID_match_code := IF ( isLeftWinner(le.TAX_IDWeight,ri.TAX_IDWeight,le.TAX_ID_match_code,ri.TAX_ID_match_code), le.TAX_ID_match_code, ri.TAX_ID_match_code );
  BOOLEAN FEINWeightForcedDown := IF ( isWeightForcedDown(le.FEINWeight,ri.FEINWeight,le.FEIN_match_code,ri.FEIN_match_code),true,false );
  SELF.FEINWeight := IF ( isLeftWinner(le.FEINWeight,ri.FEINWeight,le.FEIN_match_code,ri.FEIN_match_code), le.FEINWeight, ri.FEINWeight );
  SELF.FEIN := IF ( isLeftWinner(le.FEINWeight,ri.FEINWeight,le.FEIN_match_code,ri.FEIN_match_code ), le.FEIN, ri.FEIN );
  SELF.FEIN_match_code := IF ( isLeftWinner(le.FEINWeight,ri.FEINWeight,le.FEIN_match_code,ri.FEIN_match_code), le.FEIN_match_code, ri.FEIN_match_code );
  BOOLEAN PHONEWeightForcedDown := IF ( isWeightForcedDown(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code),true,false );
  SELF.PHONEWeight := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code), le.PHONEWeight, ri.PHONEWeight );
  SELF.PHONE := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code ), le.PHONE, ri.PHONE );
  SELF.PHONE_match_code := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code), le.PHONE_match_code, ri.PHONE_match_code );
  BOOLEAN FAXWeightForcedDown := IF ( isWeightForcedDown(le.FAXWeight,ri.FAXWeight,le.FAX_match_code,ri.FAX_match_code),true,false );
  SELF.FAXWeight := IF ( isLeftWinner(le.FAXWeight,ri.FAXWeight,le.FAX_match_code,ri.FAX_match_code), le.FAXWeight, ri.FAXWeight );
  SELF.FAX := IF ( isLeftWinner(le.FAXWeight,ri.FAXWeight,le.FAX_match_code,ri.FAX_match_code ), le.FAX, ri.FAX );
  SELF.FAX_match_code := IF ( isLeftWinner(le.FAXWeight,ri.FAXWeight,le.FAX_match_code,ri.FAX_match_code), le.FAX_match_code, ri.FAX_match_code );
  BOOLEAN LIC_STATEWeightForcedDown := IF ( isWeightForcedDown(le.LIC_STATEWeight,ri.LIC_STATEWeight,le.LIC_STATE_match_code,ri.LIC_STATE_match_code),true,false );
  SELF.LIC_STATEWeight := IF ( isLeftWinner(le.LIC_STATEWeight,ri.LIC_STATEWeight,le.LIC_STATE_match_code,ri.LIC_STATE_match_code), le.LIC_STATEWeight, ri.LIC_STATEWeight );
  SELF.LIC_STATE := IF ( isLeftWinner(le.LIC_STATEWeight,ri.LIC_STATEWeight,le.LIC_STATE_match_code,ri.LIC_STATE_match_code ), le.LIC_STATE, ri.LIC_STATE );
  SELF.LIC_STATE_match_code := IF ( isLeftWinner(le.LIC_STATEWeight,ri.LIC_STATEWeight,le.LIC_STATE_match_code,ri.LIC_STATE_match_code), le.LIC_STATE_match_code, ri.LIC_STATE_match_code );
  BOOLEAN C_LIC_NBRWeightForcedDown := IF ( isWeightForcedDown(le.C_LIC_NBRWeight,ri.C_LIC_NBRWeight,le.C_LIC_NBR_match_code,ri.C_LIC_NBR_match_code),true,false );
  SELF.C_LIC_NBRWeight := IF ( isLeftWinner(le.C_LIC_NBRWeight,ri.C_LIC_NBRWeight,le.C_LIC_NBR_match_code,ri.C_LIC_NBR_match_code), le.C_LIC_NBRWeight, ri.C_LIC_NBRWeight );
  SELF.C_LIC_NBR := IF ( isLeftWinner(le.C_LIC_NBRWeight,ri.C_LIC_NBRWeight,le.C_LIC_NBR_match_code,ri.C_LIC_NBR_match_code ), le.C_LIC_NBR, ri.C_LIC_NBR );
  SELF.C_LIC_NBR_match_code := IF ( isLeftWinner(le.C_LIC_NBRWeight,ri.C_LIC_NBRWeight,le.C_LIC_NBR_match_code,ri.C_LIC_NBR_match_code), le.C_LIC_NBR_match_code, ri.C_LIC_NBR_match_code );
  BOOLEAN DEA_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.DEA_NUMBERWeight,ri.DEA_NUMBERWeight,le.DEA_NUMBER_match_code,ri.DEA_NUMBER_match_code),true,false );
  SELF.DEA_NUMBERWeight := IF ( isLeftWinner(le.DEA_NUMBERWeight,ri.DEA_NUMBERWeight,le.DEA_NUMBER_match_code,ri.DEA_NUMBER_match_code), le.DEA_NUMBERWeight, ri.DEA_NUMBERWeight );
  SELF.DEA_NUMBER := IF ( isLeftWinner(le.DEA_NUMBERWeight,ri.DEA_NUMBERWeight,le.DEA_NUMBER_match_code,ri.DEA_NUMBER_match_code ), le.DEA_NUMBER, ri.DEA_NUMBER );
  SELF.DEA_NUMBER_match_code := IF ( isLeftWinner(le.DEA_NUMBERWeight,ri.DEA_NUMBERWeight,le.DEA_NUMBER_match_code,ri.DEA_NUMBER_match_code), le.DEA_NUMBER_match_code, ri.DEA_NUMBER_match_code );
  BOOLEAN VENDOR_IDWeightForcedDown := IF ( isWeightForcedDown(le.VENDOR_IDWeight,ri.VENDOR_IDWeight,le.VENDOR_ID_match_code,ri.VENDOR_ID_match_code),true,false );
  SELF.VENDOR_IDWeight := IF ( isLeftWinner(le.VENDOR_IDWeight,ri.VENDOR_IDWeight,le.VENDOR_ID_match_code,ri.VENDOR_ID_match_code), le.VENDOR_IDWeight, ri.VENDOR_IDWeight );
  SELF.VENDOR_ID := IF ( isLeftWinner(le.VENDOR_IDWeight,ri.VENDOR_IDWeight,le.VENDOR_ID_match_code,ri.VENDOR_ID_match_code ), le.VENDOR_ID, ri.VENDOR_ID );
  SELF.VENDOR_ID_match_code := IF ( isLeftWinner(le.VENDOR_IDWeight,ri.VENDOR_IDWeight,le.VENDOR_ID_match_code,ri.VENDOR_ID_match_code), le.VENDOR_ID_match_code, ri.VENDOR_ID_match_code );
  BOOLEAN NPI_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.NPI_NUMBERWeight,ri.NPI_NUMBERWeight,le.NPI_NUMBER_match_code,ri.NPI_NUMBER_match_code),true,false );
  SELF.NPI_NUMBERWeight := IF ( isLeftWinner(le.NPI_NUMBERWeight,ri.NPI_NUMBERWeight,le.NPI_NUMBER_match_code,ri.NPI_NUMBER_match_code), le.NPI_NUMBERWeight, ri.NPI_NUMBERWeight );
  SELF.NPI_NUMBER := IF ( isLeftWinner(le.NPI_NUMBERWeight,ri.NPI_NUMBERWeight,le.NPI_NUMBER_match_code,ri.NPI_NUMBER_match_code ), le.NPI_NUMBER, ri.NPI_NUMBER );
  SELF.NPI_NUMBER_match_code := IF ( isLeftWinner(le.NPI_NUMBERWeight,ri.NPI_NUMBERWeight,le.NPI_NUMBER_match_code,ri.NPI_NUMBER_match_code), le.NPI_NUMBER_match_code, ri.NPI_NUMBER_match_code );
  BOOLEAN CLIA_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.CLIA_NUMBERWeight,ri.CLIA_NUMBERWeight,le.CLIA_NUMBER_match_code,ri.CLIA_NUMBER_match_code),true,false );
  SELF.CLIA_NUMBERWeight := IF ( isLeftWinner(le.CLIA_NUMBERWeight,ri.CLIA_NUMBERWeight,le.CLIA_NUMBER_match_code,ri.CLIA_NUMBER_match_code), le.CLIA_NUMBERWeight, ri.CLIA_NUMBERWeight );
  SELF.CLIA_NUMBER := IF ( isLeftWinner(le.CLIA_NUMBERWeight,ri.CLIA_NUMBERWeight,le.CLIA_NUMBER_match_code,ri.CLIA_NUMBER_match_code ), le.CLIA_NUMBER, ri.CLIA_NUMBER );
  SELF.CLIA_NUMBER_match_code := IF ( isLeftWinner(le.CLIA_NUMBERWeight,ri.CLIA_NUMBERWeight,le.CLIA_NUMBER_match_code,ri.CLIA_NUMBER_match_code), le.CLIA_NUMBER_match_code, ri.CLIA_NUMBER_match_code );
  BOOLEAN MEDICARE_FACILITY_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.MEDICARE_FACILITY_NUMBERWeight,ri.MEDICARE_FACILITY_NUMBERWeight,le.MEDICARE_FACILITY_NUMBER_match_code,ri.MEDICARE_FACILITY_NUMBER_match_code),true,false );
  SELF.MEDICARE_FACILITY_NUMBERWeight := IF ( isLeftWinner(le.MEDICARE_FACILITY_NUMBERWeight,ri.MEDICARE_FACILITY_NUMBERWeight,le.MEDICARE_FACILITY_NUMBER_match_code,ri.MEDICARE_FACILITY_NUMBER_match_code), le.MEDICARE_FACILITY_NUMBERWeight, ri.MEDICARE_FACILITY_NUMBERWeight );
  SELF.MEDICARE_FACILITY_NUMBER := IF ( isLeftWinner(le.MEDICARE_FACILITY_NUMBERWeight,ri.MEDICARE_FACILITY_NUMBERWeight,le.MEDICARE_FACILITY_NUMBER_match_code,ri.MEDICARE_FACILITY_NUMBER_match_code ), le.MEDICARE_FACILITY_NUMBER, ri.MEDICARE_FACILITY_NUMBER );
  SELF.MEDICARE_FACILITY_NUMBER_match_code := IF ( isLeftWinner(le.MEDICARE_FACILITY_NUMBERWeight,ri.MEDICARE_FACILITY_NUMBERWeight,le.MEDICARE_FACILITY_NUMBER_match_code,ri.MEDICARE_FACILITY_NUMBER_match_code), le.MEDICARE_FACILITY_NUMBER_match_code, ri.MEDICARE_FACILITY_NUMBER_match_code );
  BOOLEAN MEDICAID_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.MEDICAID_NUMBERWeight,ri.MEDICAID_NUMBERWeight,le.MEDICAID_NUMBER_match_code,ri.MEDICAID_NUMBER_match_code),true,false );
  SELF.MEDICAID_NUMBERWeight := IF ( isLeftWinner(le.MEDICAID_NUMBERWeight,ri.MEDICAID_NUMBERWeight,le.MEDICAID_NUMBER_match_code,ri.MEDICAID_NUMBER_match_code), le.MEDICAID_NUMBERWeight, ri.MEDICAID_NUMBERWeight );
  SELF.MEDICAID_NUMBER := IF ( isLeftWinner(le.MEDICAID_NUMBERWeight,ri.MEDICAID_NUMBERWeight,le.MEDICAID_NUMBER_match_code,ri.MEDICAID_NUMBER_match_code ), le.MEDICAID_NUMBER, ri.MEDICAID_NUMBER );
  SELF.MEDICAID_NUMBER_match_code := IF ( isLeftWinner(le.MEDICAID_NUMBERWeight,ri.MEDICAID_NUMBERWeight,le.MEDICAID_NUMBER_match_code,ri.MEDICAID_NUMBER_match_code), le.MEDICAID_NUMBER_match_code, ri.MEDICAID_NUMBER_match_code );
  BOOLEAN NCPDP_NUMBERWeightForcedDown := IF ( isWeightForcedDown(le.NCPDP_NUMBERWeight,ri.NCPDP_NUMBERWeight,le.NCPDP_NUMBER_match_code,ri.NCPDP_NUMBER_match_code),true,false );
  SELF.NCPDP_NUMBERWeight := IF ( isLeftWinner(le.NCPDP_NUMBERWeight,ri.NCPDP_NUMBERWeight,le.NCPDP_NUMBER_match_code,ri.NCPDP_NUMBER_match_code), le.NCPDP_NUMBERWeight, ri.NCPDP_NUMBERWeight );
  SELF.NCPDP_NUMBER := IF ( isLeftWinner(le.NCPDP_NUMBERWeight,ri.NCPDP_NUMBERWeight,le.NCPDP_NUMBER_match_code,ri.NCPDP_NUMBER_match_code ), le.NCPDP_NUMBER, ri.NCPDP_NUMBER );
  SELF.NCPDP_NUMBER_match_code := IF ( isLeftWinner(le.NCPDP_NUMBERWeight,ri.NCPDP_NUMBERWeight,le.NCPDP_NUMBER_match_code,ri.NCPDP_NUMBER_match_code), le.NCPDP_NUMBER_match_code, ri.NCPDP_NUMBER_match_code );
  BOOLEAN TAXONOMYWeightForcedDown := IF ( isWeightForcedDown(le.TAXONOMYWeight,ri.TAXONOMYWeight,le.TAXONOMY_match_code,ri.TAXONOMY_match_code),true,false );
  SELF.TAXONOMYWeight := IF ( isLeftWinner(le.TAXONOMYWeight,ri.TAXONOMYWeight,le.TAXONOMY_match_code,ri.TAXONOMY_match_code), le.TAXONOMYWeight, ri.TAXONOMYWeight );
  SELF.TAXONOMY := IF ( isLeftWinner(le.TAXONOMYWeight,ri.TAXONOMYWeight,le.TAXONOMY_match_code,ri.TAXONOMY_match_code ), le.TAXONOMY, ri.TAXONOMY );
  SELF.TAXONOMY_match_code := IF ( isLeftWinner(le.TAXONOMYWeight,ri.TAXONOMYWeight,le.TAXONOMY_match_code,ri.TAXONOMY_match_code), le.TAXONOMY_match_code, ri.TAXONOMY_match_code );
  BOOLEAN TAXONOMY_CODEWeightForcedDown := IF ( isWeightForcedDown(le.TAXONOMY_CODEWeight,ri.TAXONOMY_CODEWeight,le.TAXONOMY_CODE_match_code,ri.TAXONOMY_CODE_match_code),true,false );
  SELF.TAXONOMY_CODEWeight := IF ( isLeftWinner(le.TAXONOMY_CODEWeight,ri.TAXONOMY_CODEWeight,le.TAXONOMY_CODE_match_code,ri.TAXONOMY_CODE_match_code), le.TAXONOMY_CODEWeight, ri.TAXONOMY_CODEWeight );
  SELF.TAXONOMY_CODE := IF ( isLeftWinner(le.TAXONOMY_CODEWeight,ri.TAXONOMY_CODEWeight,le.TAXONOMY_CODE_match_code,ri.TAXONOMY_CODE_match_code ), le.TAXONOMY_CODE, ri.TAXONOMY_CODE );
  SELF.TAXONOMY_CODE_match_code := IF ( isLeftWinner(le.TAXONOMY_CODEWeight,ri.TAXONOMY_CODEWeight,le.TAXONOMY_CODE_match_code,ri.TAXONOMY_CODE_match_code), le.TAXONOMY_CODE_match_code, ri.TAXONOMY_CODE_match_code );
  BOOLEAN BDIDWeightForcedDown := IF ( isWeightForcedDown(le.BDIDWeight,ri.BDIDWeight,le.BDID_match_code,ri.BDID_match_code),true,false );
  SELF.BDIDWeight := IF ( isLeftWinner(le.BDIDWeight,ri.BDIDWeight,le.BDID_match_code,ri.BDID_match_code), le.BDIDWeight, ri.BDIDWeight );
  SELF.BDID := IF ( isLeftWinner(le.BDIDWeight,ri.BDIDWeight,le.BDID_match_code,ri.BDID_match_code ), le.BDID, ri.BDID );
  SELF.BDID_match_code := IF ( isLeftWinner(le.BDIDWeight,ri.BDIDWeight,le.BDID_match_code,ri.BDID_match_code), le.BDID_match_code, ri.BDID_match_code );
  BOOLEAN SRCWeightForcedDown := IF ( isWeightForcedDown(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code),true,false );
  SELF.SRCWeight := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code), le.SRCWeight, ri.SRCWeight );
  SELF.SRC := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code ), le.SRC, ri.SRC );
  SELF.SRC_match_code := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code), le.SRC_match_code, ri.SRC_match_code );
  BOOLEAN SOURCE_RIDWeightForcedDown := IF ( isWeightForcedDown(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code),true,false );
  SELF.SOURCE_RIDWeight := IF ( isLeftWinner(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code), le.SOURCE_RIDWeight, ri.SOURCE_RIDWeight );
  SELF.SOURCE_RID := IF ( isLeftWinner(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code ), le.SOURCE_RID, ri.SOURCE_RID );
  SELF.SOURCE_RID_match_code := IF ( isLeftWinner(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code), le.SOURCE_RID_match_code, ri.SOURCE_RID_match_code );
  BOOLEAN FAC_NAMEWeightForcedDown := CNP_NAMEWeightForcedDown OR CNP_NUMBERWeightForcedDown OR CNP_STORE_NUMBERWeightForcedDown OR CNP_BTYPEWeightForcedDown OR CNP_LOWVWeightForcedDown;
  SELF.FAC_NAMEWeight := IF ( isLeftWinner(le.FAC_NAMEWeight,ri.FAC_NAMEWeight,le.FAC_NAME_match_code,ri.FAC_NAME_match_code), IF(FAC_NAMEWeightForcedDown,MIN(le.FAC_NAMEWeight, ri.FAC_NAMEWeight),le.FAC_NAMEWeight), IF(FAC_NAMEWeightForcedDown,MIN(le.FAC_NAMEWeight, ri.FAC_NAMEWeight),ri.FAC_NAMEWeight));
  SELF.FAC_NAME_match_code := IF ( isLeftWinner(le.FAC_NAMEWeight,ri.FAC_NAMEWeight,le.FAC_NAME_match_code,ri.FAC_NAME_match_code), le.FAC_NAME_match_code, ri.FAC_NAME_match_code );
  BOOLEAN ADDR1WeightForcedDown := PRIM_RANGEWeightForcedDown OR SEC_RANGEWeightForcedDown OR PRIM_NAMEWeightForcedDown;
  SELF.ADDR1Weight := IF ( isLeftWinner(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code), IF(ADDR1WeightForcedDown,MIN(le.ADDR1Weight, ri.ADDR1Weight),le.ADDR1Weight), IF(ADDR1WeightForcedDown,MIN(le.ADDR1Weight, ri.ADDR1Weight),ri.ADDR1Weight));
  SELF.ADDR1_match_code := IF ( isLeftWinner(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code), le.ADDR1_match_code, ri.ADDR1_match_code );
  BOOLEAN LOCALEWeightForcedDown := V_CITY_NAMEWeightForcedDown OR STWeightForcedDown OR ZIPWeightForcedDown;
  SELF.LOCALEWeight := IF ( isLeftWinner(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code), IF(LOCALEWeightForcedDown,MIN(le.LOCALEWeight, ri.LOCALEWeight),le.LOCALEWeight), IF(LOCALEWeightForcedDown,MIN(le.LOCALEWeight, ri.LOCALEWeight),ri.LOCALEWeight));
  SELF.LOCALE_match_code := IF ( isLeftWinner(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code), le.LOCALE_match_code, ri.LOCALE_match_code );
  BOOLEAN ADDRESWeightForcedDown := ADDR1WeightForcedDown OR LOCALEWeightForcedDown;
  SELF.ADDRESWeight := IF ( isLeftWinner(le.ADDRESWeight,ri.ADDRESWeight,le.ADDRES_match_code,ri.ADDRES_match_code), IF(ADDRESWeightForcedDown,MIN(le.ADDRESWeight, ri.ADDRESWeight),le.ADDRESWeight), IF(ADDRESWeightForcedDown,MIN(le.ADDRESWeight, ri.ADDRESWeight),ri.ADDRESWeight));
  SELF.ADDRES_match_code := IF ( isLeftWinner(le.ADDRESWeight,ri.ADDRESWeight,le.ADDRES_match_code,ri.ADDRES_match_code), le.ADDRES_match_code, ri.ADDRES_match_code );
  SELF.keys_used := le.keys_used | ri.keys_used;
  SELF.keys_failed := le.keys_failed | ri.keys_failed;
  SELF.Weight := MAX(0,SELF.CNAMEWeight) + MAX(0,SELF.TAX_IDWeight) + MAX(0,SELF.FEINWeight) + MAX(0,SELF.PHONEWeight) + MAX(0,SELF.FAXWeight) + MAX(0,SELF.LIC_STATEWeight) + MAX(0,SELF.C_LIC_NBRWeight) + MAX(0,SELF.DEA_NUMBERWeight) + MAX(0,SELF.VENDOR_IDWeight) + MAX(0,SELF.NPI_NUMBERWeight) + MAX(0,SELF.CLIA_NUMBERWeight) + MAX(0,SELF.MEDICARE_FACILITY_NUMBERWeight) + MAX(0,SELF.MEDICAID_NUMBERWeight) + MAX(0,SELF.NCPDP_NUMBERWeight) + MAX(0,SELF.TAXONOMYWeight) + MAX(0,SELF.TAXONOMY_CODEWeight) + MAX(0,SELF.BDIDWeight) + MAX(0,SELF.SRCWeight) + MAX(0,SELF.SOURCE_RIDWeight) + MAX(self.FAC_NAMEWeight,MAX(0,SELF.CNP_NAMEWeight) + MAX(0,SELF.CNP_NUMBERWeight) + MAX(0,SELF.CNP_STORE_NUMBERWeight) + MAX(0,SELF.CNP_BTYPEWeight) + MAX(0,SELF.CNP_LOWVWeight)) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.ZIPWeight);
  SELF := le;
END;
SHARED OutputLayout_Base := RECORD,MAXLENGTH(32000)
  BOOLEAN Verified := FALSE; // has found possible results
  BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best
  BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best
  BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best
  BOOLEAN Resolved := FALSE; // certain with 4 nines of accuracy
  DATASET(LayoutScoredFetch) Results;
  UNSIGNED4 keys_tried := 0;
END;
EXPORT OutputLayout := RECORD(OutputLayout_Base),MAXLENGTH(32000)
  InputLayout;
END;
EXPORT OutputLayout_Batch := RECORD(OutputLayout_Base),MAXLENGTH(32006)
  SALT29.UIDType Reference;
END;
EXPORT MAC_Add_ResolutionFlags() := MACRO
  SELF.Verified := EXISTS(SELF.results);
  SELF.Ambiguous := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) >= 20;
  SELF.ShortList := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) < 20 AND SELF.verified;
  SELF.Handful := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-3)) < 6 AND SELF.verified;
  SELF.Resolved := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-7)) = 1;
ENDMACRO;
EXPORT ScoreSummary(DATASET(OutputLayout_Base) ds0) := FUNCTION
  ds := PROJECT(ds0(EXISTS(Results)),TRANSFORM(LayoutScoredFetch,SELF := LEFT.Results[1]));
  R := RECORD
    SALT29.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF.Summary := IF(le.CNAMEWeight=0,'','|'+IF(le.CNAMEWeight<0,'-','')+'CNAME')+IF(le.CNP_NAMEWeight=0,'','|'+IF(le.CNP_NAMEWeight<0,'-','')+'CNP_NAME')+IF(le.CNP_NUMBERWeight=0,'','|'+IF(le.CNP_NUMBERWeight<0,'-','')+'CNP_NUMBER')+IF(le.CNP_STORE_NUMBERWeight=0,'','|'+IF(le.CNP_STORE_NUMBERWeight<0,'-','')+'CNP_STORE_NUMBER')+IF(le.CNP_BTYPEWeight=0,'','|'+IF(le.CNP_BTYPEWeight<0,'-','')+'CNP_BTYPE')+IF(le.CNP_LOWVWeight=0,'','|'+IF(le.CNP_LOWVWeight<0,'-','')+'CNP_LOWV')+IF(le.PRIM_RANGEWeight=0,'','|'+IF(le.PRIM_RANGEWeight<0,'-','')+'PRIM_RANGE')+IF(le.PRIM_NAMEWeight=0,'','|'+IF(le.PRIM_NAMEWeight<0,'-','')+'PRIM_NAME')+IF(le.SEC_RANGEWeight=0,'','|'+IF(le.SEC_RANGEWeight<0,'-','')+'SEC_RANGE')+IF(le.V_CITY_NAMEWeight=0,'','|'+IF(le.V_CITY_NAMEWeight<0,'-','')+'V_CITY_NAME')+IF(le.STWeight=0,'','|'+IF(le.STWeight<0,'-','')+'ST')+IF(le.ZIPWeight=0,'','|'+IF(le.ZIPWeight<0,'-','')+'ZIP')+IF(le.TAX_IDWeight=0,'','|'+IF(le.TAX_IDWeight<0,'-','')+'TAX_ID')+IF(le.FEINWeight=0,'','|'+IF(le.FEINWeight<0,'-','')+'FEIN')+IF(le.PHONEWeight=0,'','|'+IF(le.PHONEWeight<0,'-','')+'PHONE')+IF(le.FAXWeight=0,'','|'+IF(le.FAXWeight<0,'-','')+'FAX')+IF(le.LIC_STATEWeight=0,'','|'+IF(le.LIC_STATEWeight<0,'-','')+'LIC_STATE')+IF(le.C_LIC_NBRWeight=0,'','|'+IF(le.C_LIC_NBRWeight<0,'-','')+'C_LIC_NBR')+IF(le.DEA_NUMBERWeight=0,'','|'+IF(le.DEA_NUMBERWeight<0,'-','')+'DEA_NUMBER')+IF(le.VENDOR_IDWeight=0,'','|'+IF(le.VENDOR_IDWeight<0,'-','')+'VENDOR_ID')+IF(le.NPI_NUMBERWeight=0,'','|'+IF(le.NPI_NUMBERWeight<0,'-','')+'NPI_NUMBER')+IF(le.CLIA_NUMBERWeight=0,'','|'+IF(le.CLIA_NUMBERWeight<0,'-','')+'CLIA_NUMBER')+IF(le.MEDICARE_FACILITY_NUMBERWeight=0,'','|'+IF(le.MEDICARE_FACILITY_NUMBERWeight<0,'-','')+'MEDICARE_FACILITY_NUMBER')+IF(le.MEDICAID_NUMBERWeight=0,'','|'+IF(le.MEDICAID_NUMBERWeight<0,'-','')+'MEDICAID_NUMBER')+IF(le.NCPDP_NUMBERWeight=0,'','|'+IF(le.NCPDP_NUMBERWeight<0,'-','')+'NCPDP_NUMBER')+IF(le.TAXONOMYWeight=0,'','|'+IF(le.TAXONOMYWeight<0,'-','')+'TAXONOMY')+IF(le.TAXONOMY_CODEWeight=0,'','|'+IF(le.TAXONOMY_CODEWeight<0,'-','')+'TAXONOMY_CODE')+IF(le.BDIDWeight=0,'','|'+IF(le.BDIDWeight<0,'-','')+'BDID')+IF(le.SRCWeight=0,'','|'+IF(le.SRCWeight<0,'-','')+'SRC')+IF(le.SOURCE_RIDWeight=0,'','|'+IF(le.SOURCE_RIDWeight<0,'-','')+'SOURCE_RID')+IF(le.FAC_NAMEWeight=0,'','|'+IF(le.FAC_NAMEWeight<0,'-','')+'FAC_NAME')+IF(le.ADDR1Weight=0,'','|'+IF(le.ADDR1Weight<0,'-','')+'ADDR1')+IF(le.LOCALEWeight=0,'','|'+IF(le.LOCALEWeight<0,'-','')+'LOCALE')+IF(le.ADDRESWeight=0,'','|'+IF(le.ADDRESWeight<0,'-','')+'ADDRES');
  END;
  P := PROJECT(ds,tosummary(LEFT));
  t := TABLE(P,{Summary, Cnt := COUNT(GROUP)},Summary,FEW);
  RETURN SORT(t,-Cnt);
END;
EXPORT AdjustScoresForNonExactMatches(DATASET(LayoutScoredFetch) in_data) := FUNCTION
aggregateRec := RECORD
  in_data.reference;
  CNAMEWeight := MAX(GROUP,IF( in_data.CNAME_match_code=SALT29.MatchCode.ExactMatch, in_data.CNAMEWeight,0 ));
  CNP_NAMEWeight := MAX(GROUP,IF( in_data.CNP_NAME_match_code=SALT29.MatchCode.ExactMatch, in_data.CNP_NAMEWeight,0 ));
  CNP_NUMBERWeight := MAX(GROUP,IF( in_data.CNP_NUMBER_match_code=SALT29.MatchCode.ExactMatch, in_data.CNP_NUMBERWeight,0 ));
  CNP_STORE_NUMBERWeight := MAX(GROUP,IF( in_data.CNP_STORE_NUMBER_match_code=SALT29.MatchCode.ExactMatch, in_data.CNP_STORE_NUMBERWeight,0 ));
  CNP_BTYPEWeight := MAX(GROUP,IF( in_data.CNP_BTYPE_match_code=SALT29.MatchCode.ExactMatch, in_data.CNP_BTYPEWeight,0 ));
  CNP_LOWVWeight := MAX(GROUP,IF( in_data.CNP_LOWV_match_code=SALT29.MatchCode.ExactMatch, in_data.CNP_LOWVWeight,0 ));
  PRIM_RANGEWeight := MAX(GROUP,IF( in_data.PRIM_RANGE_match_code=SALT29.MatchCode.ExactMatch, in_data.PRIM_RANGEWeight,0 ));
  PRIM_NAMEWeight := MAX(GROUP,IF( in_data.PRIM_NAME_match_code=SALT29.MatchCode.ExactMatch, in_data.PRIM_NAMEWeight,0 ));
  SEC_RANGEWeight := MAX(GROUP,IF( in_data.SEC_RANGE_match_code=SALT29.MatchCode.ExactMatch, in_data.SEC_RANGEWeight,0 ));
  V_CITY_NAMEWeight := MAX(GROUP,IF( in_data.V_CITY_NAME_match_code=SALT29.MatchCode.ExactMatch, in_data.V_CITY_NAMEWeight,0 ));
  STWeight := MAX(GROUP,IF( in_data.ST_match_code=SALT29.MatchCode.ExactMatch, in_data.STWeight,0 ));
  ZIPWeight := MAX(GROUP,IF( in_data.ZIP_match_code=SALT29.MatchCode.ExactMatch, in_data.ZIPWeight,0 ));
  TAX_IDWeight := MAX(GROUP,IF( in_data.TAX_ID_match_code=SALT29.MatchCode.ExactMatch, in_data.TAX_IDWeight,0 ));
  FEINWeight := MAX(GROUP,IF( in_data.FEIN_match_code=SALT29.MatchCode.ExactMatch, in_data.FEINWeight,0 ));
  PHONEWeight := MAX(GROUP,IF( in_data.PHONE_match_code=SALT29.MatchCode.ExactMatch, in_data.PHONEWeight,0 ));
  FAXWeight := MAX(GROUP,IF( in_data.FAX_match_code=SALT29.MatchCode.ExactMatch, in_data.FAXWeight,0 ));
  LIC_STATEWeight := MAX(GROUP,IF( in_data.LIC_STATE_match_code=SALT29.MatchCode.ExactMatch, in_data.LIC_STATEWeight,0 ));
  C_LIC_NBRWeight := MAX(GROUP,IF( in_data.C_LIC_NBR_match_code=SALT29.MatchCode.ExactMatch, in_data.C_LIC_NBRWeight,0 ));
  DEA_NUMBERWeight := MAX(GROUP,IF( in_data.DEA_NUMBER_match_code=SALT29.MatchCode.ExactMatch, in_data.DEA_NUMBERWeight,0 ));
  VENDOR_IDWeight := MAX(GROUP,IF( in_data.VENDOR_ID_match_code=SALT29.MatchCode.ExactMatch, in_data.VENDOR_IDWeight,0 ));
  NPI_NUMBERWeight := MAX(GROUP,IF( in_data.NPI_NUMBER_match_code=SALT29.MatchCode.ExactMatch, in_data.NPI_NUMBERWeight,0 ));
  CLIA_NUMBERWeight := MAX(GROUP,IF( in_data.CLIA_NUMBER_match_code=SALT29.MatchCode.ExactMatch, in_data.CLIA_NUMBERWeight,0 ));
  MEDICARE_FACILITY_NUMBERWeight := MAX(GROUP,IF( in_data.MEDICARE_FACILITY_NUMBER_match_code=SALT29.MatchCode.ExactMatch, in_data.MEDICARE_FACILITY_NUMBERWeight,0 ));
  MEDICAID_NUMBERWeight := MAX(GROUP,IF( in_data.MEDICAID_NUMBER_match_code=SALT29.MatchCode.ExactMatch, in_data.MEDICAID_NUMBERWeight,0 ));
  NCPDP_NUMBERWeight := MAX(GROUP,IF( in_data.NCPDP_NUMBER_match_code=SALT29.MatchCode.ExactMatch, in_data.NCPDP_NUMBERWeight,0 ));
  TAXONOMYWeight := MAX(GROUP,IF( in_data.TAXONOMY_match_code=SALT29.MatchCode.ExactMatch, in_data.TAXONOMYWeight,0 ));
  TAXONOMY_CODEWeight := MAX(GROUP,IF( in_data.TAXONOMY_CODE_match_code=SALT29.MatchCode.ExactMatch, in_data.TAXONOMY_CODEWeight,0 ));
  BDIDWeight := MAX(GROUP,IF( in_data.BDID_match_code=SALT29.MatchCode.ExactMatch, in_data.BDIDWeight,0 ));
  SRCWeight := MAX(GROUP,IF( in_data.SRC_match_code=SALT29.MatchCode.ExactMatch, in_data.SRCWeight,0 ));
  SOURCE_RIDWeight := MAX(GROUP,IF( in_data.SOURCE_RID_match_code=SALT29.MatchCode.ExactMatch, in_data.SOURCE_RIDWeight,0 ));
  FAC_NAMEWeight := MAX(GROUP,IF( in_data.FAC_NAME_match_code=SALT29.MatchCode.ExactMatch, in_data.FAC_NAMEWeight,0 ));
  ADDR1Weight := MAX(GROUP,IF( in_data.ADDR1_match_code=SALT29.MatchCode.ExactMatch, in_data.ADDR1Weight,0 ));
  LOCALEWeight := MAX(GROUP,IF( in_data.LOCALE_match_code=SALT29.MatchCode.ExactMatch, in_data.LOCALEWeight,0 ));
  ADDRESWeight := MAX(GROUP,IF( in_data.ADDRES_match_code=SALT29.MatchCode.ExactMatch, in_data.ADDRESWeight,0 ));
END;
  R1 := TABLE(in_data,aggregateRec,Reference);
LayoutScoredFetch FixScores(LayoutScoredFetch le, aggregateRec ri) := TRANSFORM
  SELF.CNAMEWeight := MAP( ri.CNAMEWeight=0 OR le.CNAME_match_code=SALT29.MatchCode.ExactMatch => le.CNAMEWeight,MIN(le.CNAMEWeight,ri.CNAMEWeight-1) );
  SELF.CNP_NAMEWeight := MAP( ri.CNP_NAMEWeight=0 OR le.CNP_NAME_match_code=SALT29.MatchCode.ExactMatch => le.CNP_NAMEWeight,MIN(le.CNP_NAMEWeight,ri.CNP_NAMEWeight-1) );
  SELF.CNP_NUMBERWeight := MAP( ri.CNP_NUMBERWeight=0 OR le.CNP_NUMBER_match_code=SALT29.MatchCode.ExactMatch => le.CNP_NUMBERWeight,MIN(le.CNP_NUMBERWeight,ri.CNP_NUMBERWeight-1) );
  SELF.CNP_STORE_NUMBERWeight := MAP( ri.CNP_STORE_NUMBERWeight=0 OR le.CNP_STORE_NUMBER_match_code=SALT29.MatchCode.ExactMatch => le.CNP_STORE_NUMBERWeight,MIN(le.CNP_STORE_NUMBERWeight,ri.CNP_STORE_NUMBERWeight-1) );
  SELF.CNP_BTYPEWeight := MAP( ri.CNP_BTYPEWeight=0 OR le.CNP_BTYPE_match_code=SALT29.MatchCode.ExactMatch => le.CNP_BTYPEWeight,MIN(le.CNP_BTYPEWeight,ri.CNP_BTYPEWeight-1) );
  SELF.CNP_LOWVWeight := MAP( ri.CNP_LOWVWeight=0 OR le.CNP_LOWV_match_code=SALT29.MatchCode.ExactMatch => le.CNP_LOWVWeight,MIN(le.CNP_LOWVWeight,ri.CNP_LOWVWeight-1) );
  SELF.PRIM_RANGEWeight := MAP( ri.PRIM_RANGEWeight=0 OR le.PRIM_RANGE_match_code=SALT29.MatchCode.ExactMatch => le.PRIM_RANGEWeight,MIN(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight-1) );
  SELF.PRIM_NAMEWeight := MAP( ri.PRIM_NAMEWeight=0 OR le.PRIM_NAME_match_code=SALT29.MatchCode.ExactMatch => le.PRIM_NAMEWeight,MIN(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight-1) );
  SELF.SEC_RANGEWeight := MAP( ri.SEC_RANGEWeight=0 OR le.SEC_RANGE_match_code=SALT29.MatchCode.ExactMatch => le.SEC_RANGEWeight,MIN(le.SEC_RANGEWeight,ri.SEC_RANGEWeight-1) );
  SELF.V_CITY_NAMEWeight := MAP( ri.V_CITY_NAMEWeight=0 OR le.V_CITY_NAME_match_code=SALT29.MatchCode.ExactMatch => le.V_CITY_NAMEWeight,MIN(le.V_CITY_NAMEWeight,ri.V_CITY_NAMEWeight-1) );
  SELF.STWeight := MAP( ri.STWeight=0 OR le.ST_match_code=SALT29.MatchCode.ExactMatch => le.STWeight,MIN(le.STWeight,ri.STWeight-1) );
  SELF.ZIPWeight := MAP( ri.ZIPWeight=0 OR le.ZIP_match_code=SALT29.MatchCode.ExactMatch => le.ZIPWeight,MIN(le.ZIPWeight,ri.ZIPWeight-1) );
  SELF.TAX_IDWeight := MAP( ri.TAX_IDWeight=0 OR le.TAX_ID_match_code=SALT29.MatchCode.ExactMatch => le.TAX_IDWeight,MIN(le.TAX_IDWeight,ri.TAX_IDWeight-1) );
  SELF.FEINWeight := MAP( ri.FEINWeight=0 OR le.FEIN_match_code=SALT29.MatchCode.ExactMatch => le.FEINWeight,MIN(le.FEINWeight,ri.FEINWeight-1) );
  SELF.PHONEWeight := MAP( ri.PHONEWeight=0 OR le.PHONE_match_code=SALT29.MatchCode.ExactMatch => le.PHONEWeight,MIN(le.PHONEWeight,ri.PHONEWeight-1) );
  SELF.FAXWeight := MAP( ri.FAXWeight=0 OR le.FAX_match_code=SALT29.MatchCode.ExactMatch => le.FAXWeight,MIN(le.FAXWeight,ri.FAXWeight-1) );
  SELF.LIC_STATEWeight := MAP( ri.LIC_STATEWeight=0 OR le.LIC_STATE_match_code=SALT29.MatchCode.ExactMatch => le.LIC_STATEWeight,MIN(le.LIC_STATEWeight,ri.LIC_STATEWeight-1) );
  SELF.C_LIC_NBRWeight := MAP( ri.C_LIC_NBRWeight=0 OR le.C_LIC_NBR_match_code=SALT29.MatchCode.ExactMatch => le.C_LIC_NBRWeight,MIN(le.C_LIC_NBRWeight,ri.C_LIC_NBRWeight-1) );
  SELF.DEA_NUMBERWeight := MAP( ri.DEA_NUMBERWeight=0 OR le.DEA_NUMBER_match_code=SALT29.MatchCode.ExactMatch => le.DEA_NUMBERWeight,MIN(le.DEA_NUMBERWeight,ri.DEA_NUMBERWeight-1) );
  SELF.VENDOR_IDWeight := MAP( ri.VENDOR_IDWeight=0 OR le.VENDOR_ID_match_code=SALT29.MatchCode.ExactMatch => le.VENDOR_IDWeight,MIN(le.VENDOR_IDWeight,ri.VENDOR_IDWeight-1) );
  SELF.NPI_NUMBERWeight := MAP( ri.NPI_NUMBERWeight=0 OR le.NPI_NUMBER_match_code=SALT29.MatchCode.ExactMatch => le.NPI_NUMBERWeight,MIN(le.NPI_NUMBERWeight,ri.NPI_NUMBERWeight-1) );
  SELF.CLIA_NUMBERWeight := MAP( ri.CLIA_NUMBERWeight=0 OR le.CLIA_NUMBER_match_code=SALT29.MatchCode.ExactMatch => le.CLIA_NUMBERWeight,MIN(le.CLIA_NUMBERWeight,ri.CLIA_NUMBERWeight-1) );
  SELF.MEDICARE_FACILITY_NUMBERWeight := MAP( ri.MEDICARE_FACILITY_NUMBERWeight=0 OR le.MEDICARE_FACILITY_NUMBER_match_code=SALT29.MatchCode.ExactMatch => le.MEDICARE_FACILITY_NUMBERWeight,MIN(le.MEDICARE_FACILITY_NUMBERWeight,ri.MEDICARE_FACILITY_NUMBERWeight-1) );
  SELF.MEDICAID_NUMBERWeight := MAP( ri.MEDICAID_NUMBERWeight=0 OR le.MEDICAID_NUMBER_match_code=SALT29.MatchCode.ExactMatch => le.MEDICAID_NUMBERWeight,MIN(le.MEDICAID_NUMBERWeight,ri.MEDICAID_NUMBERWeight-1) );
  SELF.NCPDP_NUMBERWeight := MAP( ri.NCPDP_NUMBERWeight=0 OR le.NCPDP_NUMBER_match_code=SALT29.MatchCode.ExactMatch => le.NCPDP_NUMBERWeight,MIN(le.NCPDP_NUMBERWeight,ri.NCPDP_NUMBERWeight-1) );
  SELF.TAXONOMYWeight := MAP( ri.TAXONOMYWeight=0 OR le.TAXONOMY_match_code=SALT29.MatchCode.ExactMatch => le.TAXONOMYWeight,MIN(le.TAXONOMYWeight,ri.TAXONOMYWeight-1) );
  SELF.TAXONOMY_CODEWeight := MAP( ri.TAXONOMY_CODEWeight=0 OR le.TAXONOMY_CODE_match_code=SALT29.MatchCode.ExactMatch => le.TAXONOMY_CODEWeight,MIN(le.TAXONOMY_CODEWeight,ri.TAXONOMY_CODEWeight-1) );
  SELF.BDIDWeight := MAP( ri.BDIDWeight=0 OR le.BDID_match_code=SALT29.MatchCode.ExactMatch => le.BDIDWeight,MIN(le.BDIDWeight,ri.BDIDWeight-1) );
  SELF.SRCWeight := MAP( ri.SRCWeight=0 OR le.SRC_match_code=SALT29.MatchCode.ExactMatch => le.SRCWeight,MIN(le.SRCWeight,ri.SRCWeight-1) );
  SELF.SOURCE_RIDWeight := MAP( ri.SOURCE_RIDWeight=0 OR le.SOURCE_RID_match_code=SALT29.MatchCode.ExactMatch => le.SOURCE_RIDWeight,MIN(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight-1) );
  SELF.FAC_NAMEWeight := MAP( ri.FAC_NAMEWeight=0 OR le.FAC_NAME_match_code=SALT29.MatchCode.ExactMatch => le.FAC_NAMEWeight,MIN(le.FAC_NAMEWeight,ri.FAC_NAMEWeight-1) );
  SELF.ADDR1Weight := MAP( ri.ADDR1Weight=0 OR le.ADDR1_match_code=SALT29.MatchCode.ExactMatch => le.ADDR1Weight,MIN(le.ADDR1Weight,ri.ADDR1Weight-1) );
  SELF.LOCALEWeight := MAP( ri.LOCALEWeight=0 OR le.LOCALE_match_code=SALT29.MatchCode.ExactMatch => le.LOCALEWeight,MIN(le.LOCALEWeight,ri.LOCALEWeight-1) );
  SELF.ADDRESWeight := MAP( ri.ADDRESWeight=0 OR le.ADDRES_match_code=SALT29.MatchCode.ExactMatch => le.ADDRESWeight,MIN(le.ADDRESWeight,ri.ADDRESWeight-1) );
  SELF.Weight := MAX(0,SELF.CNAMEWeight) + MAX(0,SELF.TAX_IDWeight) + MAX(0,SELF.FEINWeight) + MAX(0,SELF.PHONEWeight) + MAX(0,SELF.FAXWeight) + MAX(0,SELF.LIC_STATEWeight) + MAX(0,SELF.C_LIC_NBRWeight) + MAX(0,SELF.DEA_NUMBERWeight) + MAX(0,SELF.VENDOR_IDWeight) + MAX(0,SELF.NPI_NUMBERWeight) + MAX(0,SELF.CLIA_NUMBERWeight) + MAX(0,SELF.MEDICARE_FACILITY_NUMBERWeight) + MAX(0,SELF.MEDICAID_NUMBERWeight) + MAX(0,SELF.NCPDP_NUMBERWeight) + MAX(0,SELF.TAXONOMYWeight) + MAX(0,SELF.TAXONOMY_CODEWeight) + MAX(0,SELF.BDIDWeight) + MAX(0,SELF.SRCWeight) + MAX(0,SELF.SOURCE_RIDWeight) + MAX(self.FAC_NAMEWeight,MAX(0,SELF.CNP_NAMEWeight) + MAX(0,SELF.CNP_NUMBERWeight) + MAX(0,SELF.CNP_STORE_NUMBERWeight) + MAX(0,SELF.CNP_BTYPEWeight) + MAX(0,SELF.CNP_LOWVWeight)) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.ZIPWeight);
  SELF := le;
END;
  R2 := JOIN(in_data,R1,LEFT.reference=RIGHT.reference,FixScores(LEFT,RIGHT));
  RETURN GROUP(R2,Reference,ALL);
END;
EXPORT CombineAllScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
OutputLayout_Batch Create_Output(LayoutScoredFetch le, DATASET(LayoutScoredFetch) ri) := TRANSFORM
  SELF.Results := ri;
  SELF.Reference := le.Reference;
  MAC_Add_ResolutionFlags()
END;
  r0 := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(reference)),Reference, LOCAL ), Reference, LOCAL),LNPID),LEFT.LNPID=RIGHT.LNPID,Combine_Scores(LEFT,RIGHT))(SALT29.DebugMode OR ~ForceFailed);
  r1 := AdjustScoresForNonExactMatches(UNGROUP(r0));
  R2 := ROLLUP( TOPN(r1,100,-Weight),GROUP, Create_Output(LEFT,ROWS(LEFT)) );
  SALT29.MAC_External_AddPcnt(R2,LayoutScoredFetch,Results,OutputLayout_Batch,20,R3);
  RETURN r3;
END;
EXPORT CombineLinkpathScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
// Note - results are returned distributed by HASH(reference) - this is part of the specification
  rolled := ROLLUP ( SORT( DISTRIBUTE( in_data, HASH(reference) ), Reference, LNPID, LOCAL), Combine_Scores(LEFT,RIGHT), Reference, LNPID, LOCAL);
  RETURN DEDUP( SORT( rolled, Reference, -weight, LOCAL ), Reference, KEEP(Config.LinkpathCandidateCount),LOCAL);
END;
EXPORT KeysUsedToText(UNSIGNED4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','') + IF(k&(1<<1)<>0,'ZBNAME,','') + IF(k&(1<<2)<>0,'BNAME,','') + IF(k&(1<<3)<>0,'SBNAME,','') + IF(k&(1<<4)<>0,'ADDRESS,','') + IF(k&(1<<5)<>0,'ZIP_LP,','') + IF(k&(1<<6)<>0,'CITY_LP,','') + IF(k&(1<<7)<>0,'PHONE_LP,','') + IF(k&(1<<8)<>0,'FAX_LP,','') + IF(k&(1<<9)<>0,'LIC,','') + IF(k&(1<<10)<>0,'VEN,','') + IF(k&(1<<11)<>0,'TAX,','') + IF(k&(1<<12)<>0,'FEN,','') + IF(k&(1<<13)<>0,'DEA,','') + IF(k&(1<<14)<>0,'NPI,','') + IF(k&(1<<15)<>0,'ADDR_NPI,','') + IF(k&(1<<16)<>0,'CLIA,','') + IF(k&(1<<17)<>0,'MEDICARE,','') + IF(k&(1<<18)<>0,'MEDICAID,','') + IF(k&(1<<19)<>0,'NCPDP,','') + IF(k&(1<<20)<>0,'BID,','');
  RETURN list[1..LENGTH(TRIM(list))-1]; // Strim last ,
end;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT29.UIDType LNPID;
  DATASET(SALT29.Layout_FieldValueList) CNAME_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) TAX_ID_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) FEIN_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) PHONE_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) FAX_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) LIC_STATE_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) C_LIC_NBR_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) DEA_NUMBER_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) VENDOR_ID_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) NPI_NUMBER_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) CLIA_NUMBER_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) MEDICARE_FACILITY_NUMBER_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) MEDICAID_NUMBER_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) NCPDP_NUMBER_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) TAXONOMY_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) TAXONOMY_CODE_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) BDID_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) SRC_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) SOURCE_RID_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) FAC_NAME_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) ADDRES_Values := DATASET([],SALT29.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.LNPID := le.LNPID;
  SELF.CNAME_values := SALT29.fn_combine_fieldvaluelist(le.CNAME_values,ri.CNAME_values);
  SELF.TAX_ID_values := SALT29.fn_combine_fieldvaluelist(le.TAX_ID_values,ri.TAX_ID_values);
  SELF.FEIN_values := SALT29.fn_combine_fieldvaluelist(le.FEIN_values,ri.FEIN_values);
  SELF.PHONE_values := SALT29.fn_combine_fieldvaluelist(le.PHONE_values,ri.PHONE_values);
  SELF.FAX_values := SALT29.fn_combine_fieldvaluelist(le.FAX_values,ri.FAX_values);
  SELF.LIC_STATE_values := SALT29.fn_combine_fieldvaluelist(le.LIC_STATE_values,ri.LIC_STATE_values);
  SELF.C_LIC_NBR_values := SALT29.fn_combine_fieldvaluelist(le.C_LIC_NBR_values,ri.C_LIC_NBR_values);
  SELF.DEA_NUMBER_values := SALT29.fn_combine_fieldvaluelist(le.DEA_NUMBER_values,ri.DEA_NUMBER_values);
  SELF.VENDOR_ID_values := SALT29.fn_combine_fieldvaluelist(le.VENDOR_ID_values,ri.VENDOR_ID_values);
  SELF.NPI_NUMBER_values := SALT29.fn_combine_fieldvaluelist(le.NPI_NUMBER_values,ri.NPI_NUMBER_values);
  SELF.CLIA_NUMBER_values := SALT29.fn_combine_fieldvaluelist(le.CLIA_NUMBER_values,ri.CLIA_NUMBER_values);
  SELF.MEDICARE_FACILITY_NUMBER_values := SALT29.fn_combine_fieldvaluelist(le.MEDICARE_FACILITY_NUMBER_values,ri.MEDICARE_FACILITY_NUMBER_values);
  SELF.MEDICAID_NUMBER_values := SALT29.fn_combine_fieldvaluelist(le.MEDICAID_NUMBER_values,ri.MEDICAID_NUMBER_values);
  SELF.NCPDP_NUMBER_values := SALT29.fn_combine_fieldvaluelist(le.NCPDP_NUMBER_values,ri.NCPDP_NUMBER_values);
  SELF.TAXONOMY_values := SALT29.fn_combine_fieldvaluelist(le.TAXONOMY_values,ri.TAXONOMY_values);
  SELF.TAXONOMY_CODE_values := SALT29.fn_combine_fieldvaluelist(le.TAXONOMY_CODE_values,ri.TAXONOMY_CODE_values);
  SELF.BDID_values := SALT29.fn_combine_fieldvaluelist(le.BDID_values,ri.BDID_values);
  SELF.SRC_values := SALT29.fn_combine_fieldvaluelist(le.SRC_values,ri.SRC_values);
  SELF.SOURCE_RID_values := SALT29.fn_combine_fieldvaluelist(le.SOURCE_RID_values,ri.SOURCE_RID_values);
  SELF.FAC_NAME_values := SALT29.fn_combine_fieldvaluelist(le.FAC_NAME_values,ri.FAC_NAME_values);
  SELF.ADDRES_values := SALT29.fn_combine_fieldvaluelist(le.ADDRES_values,ri.ADDRES_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(LNPID) ), LNPID, LOCAL ), LEFT.LNPID = RIGHT.LNPID, RollValues(LEFT,RIGHT),LOCAL);
END;
EXPORT RolledEntities(DATASET(RECORDOF(Key)) in_data) := FUNCTION
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.LNPID := le.LNPID;
  SELF.CNAME_Values := DATASET([{TRIM((SALT29.StrType)le.CNAME)}],SALT29.Layout_FieldValueList);
  SELF.TAX_ID_Values := IF ( (SALT29.StrType)le.TAX_ID = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.TAX_ID)}],SALT29.Layout_FieldValueList));
  SELF.FEIN_Values := IF ( (SALT29.StrType)le.FEIN = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.FEIN)}],SALT29.Layout_FieldValueList));
  SELF.PHONE_Values := IF ( (SALT29.StrType)le.PHONE = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.PHONE)}],SALT29.Layout_FieldValueList));
  SELF.FAX_Values := IF ( (SALT29.StrType)le.FAX = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.FAX)}],SALT29.Layout_FieldValueList));
  SELF.LIC_STATE_Values := IF ( (SALT29.StrType)le.LIC_STATE = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.LIC_STATE)}],SALT29.Layout_FieldValueList));
  SELF.C_LIC_NBR_Values := IF ( (SALT29.StrType)le.C_LIC_NBR = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.C_LIC_NBR)}],SALT29.Layout_FieldValueList));
  SELF.DEA_NUMBER_Values := IF ( (SALT29.StrType)le.DEA_NUMBER = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.DEA_NUMBER)}],SALT29.Layout_FieldValueList));
  SELF.VENDOR_ID_Values := IF ( (SALT29.StrType)le.VENDOR_ID = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.VENDOR_ID)}],SALT29.Layout_FieldValueList));
  SELF.NPI_NUMBER_Values := IF ( (SALT29.StrType)le.NPI_NUMBER = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.NPI_NUMBER)}],SALT29.Layout_FieldValueList));
  SELF.CLIA_NUMBER_Values := IF ( (SALT29.StrType)le.CLIA_NUMBER = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.CLIA_NUMBER)}],SALT29.Layout_FieldValueList));
  SELF.MEDICARE_FACILITY_NUMBER_Values := IF ( (SALT29.StrType)le.MEDICARE_FACILITY_NUMBER = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.MEDICARE_FACILITY_NUMBER)}],SALT29.Layout_FieldValueList));
  SELF.MEDICAID_NUMBER_Values := IF ( (SALT29.StrType)le.MEDICAID_NUMBER = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.MEDICAID_NUMBER)}],SALT29.Layout_FieldValueList));
  SELF.NCPDP_NUMBER_Values := IF ( (SALT29.StrType)le.NCPDP_NUMBER = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.NCPDP_NUMBER)}],SALT29.Layout_FieldValueList));
  SELF.TAXONOMY_Values := IF ( (SALT29.StrType)le.TAXONOMY = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.TAXONOMY)}],SALT29.Layout_FieldValueList));
  SELF.TAXONOMY_CODE_Values := IF ( (SALT29.StrType)le.TAXONOMY_CODE = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.TAXONOMY_CODE)}],SALT29.Layout_FieldValueList));
  SELF.BDID_Values := IF ( (SALT29.StrType)le.BDID = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.BDID)}],SALT29.Layout_FieldValueList));
  SELF.SRC_Values := IF ( (SALT29.StrType)le.SRC = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.SRC)}],SALT29.Layout_FieldValueList));
  SELF.SOURCE_RID_Values := IF ( (SALT29.StrType)le.SOURCE_RID = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.SOURCE_RID)}],SALT29.Layout_FieldValueList));
  self.FAC_NAME_Values := IF ( (SALT29.StrType)le.CNP_NAME = '' AND (SALT29.StrType)le.CNP_NUMBER = '' AND (SALT29.StrType)le.CNP_STORE_NUMBER = '' AND (SALT29.StrType)le.CNP_BTYPE = '' AND (SALT29.StrType)le.CNP_LOWV = '',dataset([],SALT29.Layout_FieldValueList),dataset([{TRIM((SALT29.StrType)le.CNP_NAME) + ' ' + TRIM((SALT29.StrType)le.CNP_NUMBER) + ' ' + TRIM((SALT29.StrType)le.CNP_STORE_NUMBER) + ' ' + TRIM((SALT29.StrType)le.CNP_BTYPE) + ' ' + TRIM((SALT29.StrType)le.CNP_LOWV)}],SALT29.Layout_FieldValueList));
  self.ADDRES_Values := IF ( (SALT29.StrType)le.PRIM_RANGE = '' AND (SALT29.StrType)le.SEC_RANGE = '' AND (SALT29.StrType)le.PRIM_NAME = '' AND (SALT29.StrType)le.V_CITY_NAME = '' AND (SALT29.StrType)le.ST = '' AND (SALT29.StrType)le.ZIP = '',dataset([],SALT29.Layout_FieldValueList),dataset([{TRIM((SALT29.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT29.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT29.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT29.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT29.StrType)le.ST) + ' ' + TRIM((SALT29.StrType)le.ZIP)}],SALT29.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
END;
