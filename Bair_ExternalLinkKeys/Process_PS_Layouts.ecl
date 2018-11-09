EXPORT Process_PS_Layouts := MODULE
 
IMPORT SALT33;
SHARED h := File_Classify_PS;//The input file
 
EXPORT KeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+Config.KeyInfix+'::EID_HASH::meow';
 
EXPORT KeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+KeySuperfile+'::EID_HASH::meow';
 
EXPORT Key := INDEX(h,{EID_HASH},{h},KeyName_sf);
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
EXPORT id_stream_layout := RECORD
    SALT33.UIDType UniqueId;
    INTEGER2 Weight;
    UNSIGNED4 KeysUsed := 0;
    UNSIGNED4 KeysFailed := 0;
    SALT33.UIDType EID_HASH;
  END;
EXPORT InputLayout := RECORD
  SALT33.UIDType UniqueId; // This had better be unique or it will all break horribly
  UNSIGNED2 MaxIDs := 50; // Maximum number of candidate IDs
  UNSIGNED2 LeadThreshold := 0; // Maximum distance from best to worst (0 => no pruning)
  h.NAME_SUFFIX;
  h.FNAME;
  h.MNAME;
  h.LNAME;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.P_CITY_NAME;
  h.ST;
  h.ZIP;
  h.DOB;
  h.PHONE;
  h.DL_ST;
  h.DL;
  h.LEXID;
  h.POSSIBLE_SSN;
  h.CRIME;
  h.NAME_TYPE;
  h.CLEAN_GENDER;
  h.CLASS_CODE;
  h.DT_FIRST_SEEN;
  h.DT_LAST_SEEN;
  h.DATA_PROVIDER_ORI;
  h.VIN;
  h.PLATE;
  h.LATITUDE;
  h.LONGITUDE;
  h.SEARCH_ADDR1;
  h.SEARCH_ADDR2;
  h.CLEAN_COMPANY_NAME;
  SALT33.StrType MAINNAME;//Wordbag field for concept
  SALT33.StrType FULLNAME;//Wordbag field for concept
// Below only used in header search (data returning) case
  BOOLEAN MatchRecords := false; // Only show records which match
  BOOLEAN FullMatch := false; // Only show EID_HASH if it has a record which fully matches
  SALT33.UIDType Entered_EID_HASH := 0; // Allow user to enter EID_HASH to pull data
END;
// A function to turn data in the input layout function into 'baby' match candidates form
EXPORT InputToMC(DATASET(InputLayout) Inp) := FUNCTION
  r := RECORD
    inp.NAME_SUFFIX;
    inp.FNAME;
    STRING20 FNAME_PreferredName := fn_PreferredName(inp.FNAME);
    inp.MNAME;
    inp.LNAME;
    inp.PRIM_RANGE;
    inp.PRIM_NAME;
    inp.SEC_RANGE;
    inp.P_CITY_NAME;
    inp.ST;
    inp.ZIP;
    UNSIGNED2 DOB_year := ((UNSIGNED)inp.DOB) DIV 10000;
    UNSIGNED1 DOB_month := (((UNSIGNED)inp.DOB) DIV 100 ) % 100;
    UNSIGNED1 DOB_day := ((UNSIGNED)inp.DOB) % 100;
    inp.PHONE;
    inp.DL_ST;
    inp.DL;
    inp.LEXID;
    inp.POSSIBLE_SSN;
    inp.CRIME;
    inp.NAME_TYPE;
    inp.CLEAN_GENDER;
    inp.CLASS_CODE;
    inp.DT_FIRST_SEEN;
    inp.DT_LAST_SEEN;
    inp.DATA_PROVIDER_ORI;
    inp.VIN;
    inp.PLATE;
    inp.LATITUDE;
    inp.LONGITUDE;
    inp.SEARCH_ADDR1;
    inp.SEARCH_ADDR2;
    inp.CLEAN_COMPANY_NAME;
    EID_HASH := inp.Entered_EID_HASH;
  END;
  RETURN TABLE(inp,r);
END;
 
EXPORT HardKeyMatch(InputLayout le) := le.FNAME <> (typeof(le.FNAME))'' AND le.LNAME <> (typeof(le.LNAME))'' AND le.ST <> (typeof(le.ST))'' OR le.PRIM_RANGE <> (typeof(le.PRIM_RANGE))'' AND le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.ZIP <> (typeof(le.ZIP))'' OR le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.P_CITY_NAME <> (typeof(le.P_CITY_NAME))'' AND le.ST <> (typeof(le.ST))'' OR le.DOB <> (typeof(le.DOB))'' AND le.LNAME <> (typeof(le.LNAME))'' OR le.ZIP <> (typeof(le.ZIP))'' AND le.PRIM_RANGE <> (typeof(le.PRIM_RANGE))'' OR le.DL <> (typeof(le.DL))'' AND le.DL_ST <> (typeof(le.DL_ST))'' OR le.PHONE <> (typeof(le.PHONE))'' OR le.LNAME <> (typeof(le.LNAME))'' AND le.FNAME <> (typeof(le.FNAME))'' OR le.VIN <> (typeof(le.VIN))'' OR le.LEXID <> (typeof(le.LEXID))'' OR le.POSSIBLE_SSN <> (typeof(le.POSSIBLE_SSN))'' OR le.LATITUDE <> (typeof(le.LATITUDE))'' AND le.LONGITUDE <> (typeof(le.LONGITUDE))'' OR le.PLATE <> (typeof(le.PLATE))'' OR le.CLEAN_COMPANY_NAME <> (typeof(le.CLEAN_COMPANY_NAME))'';
EXPORT LayoutScoredFetch := RECORD // Nulls required for linkpaths that do not have field
  h.EID_HASH;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT33.UIDType Reference := 0;//Presently for batch
  BOOLEAN ForceFailed := FALSE;
  TYPEOF(h.NAME_SUFFIX) NAME_SUFFIX := (TYPEOF(h.NAME_SUFFIX))'';
  INTEGER2 NAME_SUFFIXWeight := 0;
  INTEGER1 NAME_SUFFIX_match_code := 0;
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  INTEGER2 FNAMEWeight := 0;
  INTEGER1 FNAME_match_code := 0;
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  INTEGER2 MNAMEWeight := 0;
  INTEGER1 MNAME_match_code := 0;
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  INTEGER2 LNAMEWeight := 0;
  INTEGER1 LNAME_match_code := 0;
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  INTEGER2 PRIM_RANGEWeight := 0;
  INTEGER1 PRIM_RANGE_match_code := 0;
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  INTEGER2 PRIM_NAMEWeight := 0;
  INTEGER1 PRIM_NAME_match_code := 0;
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  INTEGER2 SEC_RANGEWeight := 0;
  INTEGER1 SEC_RANGE_match_code := 0;
  TYPEOF(h.P_CITY_NAME) P_CITY_NAME := (TYPEOF(h.P_CITY_NAME))'';
  INTEGER2 P_CITY_NAMEWeight := 0;
  INTEGER1 P_CITY_NAME_match_code := 0;
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  INTEGER2 STWeight := 0;
  INTEGER1 ST_match_code := 0;
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  INTEGER2 ZIPWeight := 0;
  INTEGER1 ZIP_match_code := 0;
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
  TYPEOF(h.PHONE) PHONE := (TYPEOF(h.PHONE))'';
  INTEGER2 PHONEWeight := 0;
  INTEGER1 PHONE_match_code := 0;
  TYPEOF(h.DL_ST) DL_ST := (TYPEOF(h.DL_ST))'';
  INTEGER2 DL_STWeight := 0;
  INTEGER1 DL_ST_match_code := 0;
  TYPEOF(h.DL) DL := (TYPEOF(h.DL))'';
  INTEGER2 DLWeight := 0;
  INTEGER1 DL_match_code := 0;
  TYPEOF(h.LEXID) LEXID := (TYPEOF(h.LEXID))'';
  INTEGER2 LEXIDWeight := 0;
  INTEGER1 LEXID_match_code := 0;
  TYPEOF(h.POSSIBLE_SSN) POSSIBLE_SSN := (TYPEOF(h.POSSIBLE_SSN))'';
  INTEGER2 POSSIBLE_SSNWeight := 0;
  INTEGER1 POSSIBLE_SSN_match_code := 0;
  TYPEOF(h.CRIME) CRIME := (TYPEOF(h.CRIME))'';
  INTEGER2 CRIMEWeight := 0;
  INTEGER1 CRIME_match_code := 0;
  TYPEOF(h.NAME_TYPE) NAME_TYPE := (TYPEOF(h.NAME_TYPE))'';
  INTEGER2 NAME_TYPEWeight := 0;
  INTEGER1 NAME_TYPE_match_code := 0;
  TYPEOF(h.CLEAN_GENDER) CLEAN_GENDER := (TYPEOF(h.CLEAN_GENDER))'';
  INTEGER2 CLEAN_GENDERWeight := 0;
  INTEGER1 CLEAN_GENDER_match_code := 0;
  TYPEOF(h.CLASS_CODE) CLASS_CODE := (TYPEOF(h.CLASS_CODE))'';
  INTEGER2 CLASS_CODEWeight := 0;
  INTEGER1 CLASS_CODE_match_code := 0;
  TYPEOF(h.DT_FIRST_SEEN) DT_FIRST_SEEN := (TYPEOF(h.DT_FIRST_SEEN))'';
  INTEGER2 DT_FIRST_SEENWeight := 0;
  INTEGER1 DT_FIRST_SEEN_match_code := 0;
  TYPEOF(h.DT_LAST_SEEN) DT_LAST_SEEN := (TYPEOF(h.DT_LAST_SEEN))'';
  INTEGER2 DT_LAST_SEENWeight := 0;
  INTEGER1 DT_LAST_SEEN_match_code := 0;
  TYPEOF(h.DATA_PROVIDER_ORI) DATA_PROVIDER_ORI := (TYPEOF(h.DATA_PROVIDER_ORI))'';
  INTEGER2 DATA_PROVIDER_ORIWeight := 0;
  INTEGER1 DATA_PROVIDER_ORI_match_code := 0;
  TYPEOF(h.VIN) VIN := (TYPEOF(h.VIN))'';
  INTEGER2 VINWeight := 0;
  INTEGER1 VIN_match_code := 0;
  TYPEOF(h.PLATE) PLATE := (TYPEOF(h.PLATE))'';
  INTEGER2 PLATEWeight := 0;
  INTEGER1 PLATE_match_code := 0;
  TYPEOF(h.LATITUDE) LATITUDE := (TYPEOF(h.LATITUDE))'';
  INTEGER2 LATITUDEWeight := 0;
  INTEGER1 LATITUDE_match_code := 0;
  TYPEOF(h.LONGITUDE) LONGITUDE := (TYPEOF(h.LONGITUDE))'';
  INTEGER2 LONGITUDEWeight := 0;
  INTEGER1 LONGITUDE_match_code := 0;
  TYPEOF(h.SEARCH_ADDR1) SEARCH_ADDR1 := (TYPEOF(h.SEARCH_ADDR1))'';
  INTEGER2 SEARCH_ADDR1Weight := 0;
  INTEGER1 SEARCH_ADDR1_match_code := 0;
  TYPEOF(h.SEARCH_ADDR2) SEARCH_ADDR2 := (TYPEOF(h.SEARCH_ADDR2))'';
  INTEGER2 SEARCH_ADDR2Weight := 0;
  INTEGER1 SEARCH_ADDR2_match_code := 0;
  TYPEOF(h.CLEAN_COMPANY_NAME) CLEAN_COMPANY_NAME := (TYPEOF(h.CLEAN_COMPANY_NAME))'';
  INTEGER2 CLEAN_COMPANY_NAMEWeight := 0;
  INTEGER1 CLEAN_COMPANY_NAME_match_code := 0;
  SALT33.StrType MAINNAME := ''; // Concepts always a wordbag
  INTEGER2 MAINNAMEWeight := 0;
  INTEGER1 MAINNAME_match_code := 0;
  SALT33.StrType FULLNAME := ''; // Concepts always a wordbag
  INTEGER2 FULLNAMEWeight := 0;
  INTEGER1 FULLNAME_match_code := 0;
  UNSIGNED4 keys_used; // A bitmap of the keys used
  UNSIGNED4 keys_failed; // A bitmap of the keys that failed the fetch
END;
 
EXPORT LayoutScoredFetch update_forcefailed(LayoutScoredFetch le) := TRANSFORM
  SELF.ForceFailed := ((le.DOBWeight_year<>0 OR le.DOBWeight_month<>0 OR le.DOBWeight_day<>0) AND le.DOBWeight_year + le.DOBWeight_month + le.DOBWeight_day < Config.DOB_Force);
  SELF := le;
END;
 
EXPORT isLeftWinner(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT33.MatchCode.NoMatch, INTEGER1 r_mc=SALT33.MatchCode.NoMatch) :=
  MAP(l_mc=r_mc => l_weight>=r_weight, // matchcodes the same; so irrelevant
      l_mc=SALT33.MatchCode.ExactMatch => TRUE, // Left (only) is exact
      r_mc=SALT33.MatchCode.ExactMatch => FALSE, // Right (only) is exact
      l_weight>=r_weight); // weight only
 
EXPORT isWeightForcedDown(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT33.MatchCode.NoMatch, INTEGER1 r_mc=SALT33.MatchCode.NoMatch) :=
  IF((isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight < r_weight)) OR  (NOT isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight > r_weight)),true,false);
 
EXPORT LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri) := TRANSFORM
  BOOLEAN NAME_SUFFIXWeightForcedDown := IF ( isWeightForcedDown(le.NAME_SUFFIXWeight,ri.NAME_SUFFIXWeight,le.NAME_SUFFIX_match_code,ri.NAME_SUFFIX_match_code),TRUE,FALSE );
  SELF.NAME_SUFFIXWeight := IF ( isLeftWinner(le.NAME_SUFFIXWeight,ri.NAME_SUFFIXWeight,le.NAME_SUFFIX_match_code,ri.NAME_SUFFIX_match_code ), le.NAME_SUFFIXWeight, ri.NAME_SUFFIXWeight );
  SELF.NAME_SUFFIX := IF ( isLeftWinner(le.NAME_SUFFIXWeight,ri.NAME_SUFFIXWeight,le.NAME_SUFFIX_match_code,ri.NAME_SUFFIX_match_code ), le.NAME_SUFFIX, ri.NAME_SUFFIX );
  SELF.NAME_SUFFIX_match_code := IF ( isLeftWinner(le.NAME_SUFFIXWeight,ri.NAME_SUFFIXWeight,le.NAME_SUFFIX_match_code,ri.NAME_SUFFIX_match_code ), le.NAME_SUFFIX_match_code, ri.NAME_SUFFIX_match_code );
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
  BOOLEAN P_CITY_NAMEWeightForcedDown := IF ( isWeightForcedDown(le.P_CITY_NAMEWeight,ri.P_CITY_NAMEWeight,le.P_CITY_NAME_match_code,ri.P_CITY_NAME_match_code),TRUE,FALSE );
  SELF.P_CITY_NAMEWeight := IF ( isLeftWinner(le.P_CITY_NAMEWeight,ri.P_CITY_NAMEWeight,le.P_CITY_NAME_match_code,ri.P_CITY_NAME_match_code ), le.P_CITY_NAMEWeight, ri.P_CITY_NAMEWeight );
  SELF.P_CITY_NAME := IF ( isLeftWinner(le.P_CITY_NAMEWeight,ri.P_CITY_NAMEWeight,le.P_CITY_NAME_match_code,ri.P_CITY_NAME_match_code ), le.P_CITY_NAME, ri.P_CITY_NAME );
  SELF.P_CITY_NAME_match_code := IF ( isLeftWinner(le.P_CITY_NAMEWeight,ri.P_CITY_NAMEWeight,le.P_CITY_NAME_match_code,ri.P_CITY_NAME_match_code ), le.P_CITY_NAME_match_code, ri.P_CITY_NAME_match_code );
  BOOLEAN STWeightForcedDown := IF ( isWeightForcedDown(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code),TRUE,FALSE );
  SELF.STWeight := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.STWeight, ri.STWeight );
  SELF.ST := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.ST, ri.ST );
  SELF.ST_match_code := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.ST_match_code, ri.ST_match_code );
  BOOLEAN ZIPWeightForcedDown := IF ( isWeightForcedDown(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code),TRUE,FALSE );
  SELF.ZIPWeight := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIPWeight, ri.ZIPWeight );
  SELF.ZIP := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIP, ri.ZIP );
  SELF.ZIP_match_code := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIP_match_code, ri.ZIP_match_code );
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
  BOOLEAN PHONEWeightForcedDown := IF ( isWeightForcedDown(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code),TRUE,FALSE );
  SELF.PHONEWeight := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code ), le.PHONEWeight, ri.PHONEWeight );
  SELF.PHONE := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code ), le.PHONE, ri.PHONE );
  SELF.PHONE_match_code := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code ), le.PHONE_match_code, ri.PHONE_match_code );
  BOOLEAN DL_STWeightForcedDown := IF ( isWeightForcedDown(le.DL_STWeight,ri.DL_STWeight,le.DL_ST_match_code,ri.DL_ST_match_code),TRUE,FALSE );
  SELF.DL_STWeight := IF ( isLeftWinner(le.DL_STWeight,ri.DL_STWeight,le.DL_ST_match_code,ri.DL_ST_match_code ), le.DL_STWeight, ri.DL_STWeight );
  SELF.DL_ST := IF ( isLeftWinner(le.DL_STWeight,ri.DL_STWeight,le.DL_ST_match_code,ri.DL_ST_match_code ), le.DL_ST, ri.DL_ST );
  SELF.DL_ST_match_code := IF ( isLeftWinner(le.DL_STWeight,ri.DL_STWeight,le.DL_ST_match_code,ri.DL_ST_match_code ), le.DL_ST_match_code, ri.DL_ST_match_code );
  BOOLEAN DLWeightForcedDown := IF ( isWeightForcedDown(le.DLWeight,ri.DLWeight,le.DL_match_code,ri.DL_match_code),TRUE,FALSE );
  SELF.DLWeight := IF ( isLeftWinner(le.DLWeight,ri.DLWeight,le.DL_match_code,ri.DL_match_code ), le.DLWeight, ri.DLWeight );
  SELF.DL := IF ( isLeftWinner(le.DLWeight,ri.DLWeight,le.DL_match_code,ri.DL_match_code ), le.DL, ri.DL );
  SELF.DL_match_code := IF ( isLeftWinner(le.DLWeight,ri.DLWeight,le.DL_match_code,ri.DL_match_code ), le.DL_match_code, ri.DL_match_code );
  BOOLEAN LEXIDWeightForcedDown := IF ( isWeightForcedDown(le.LEXIDWeight,ri.LEXIDWeight,le.LEXID_match_code,ri.LEXID_match_code),TRUE,FALSE );
  SELF.LEXIDWeight := IF ( isLeftWinner(le.LEXIDWeight,ri.LEXIDWeight,le.LEXID_match_code,ri.LEXID_match_code ), le.LEXIDWeight, ri.LEXIDWeight );
  SELF.LEXID := IF ( isLeftWinner(le.LEXIDWeight,ri.LEXIDWeight,le.LEXID_match_code,ri.LEXID_match_code ), le.LEXID, ri.LEXID );
  SELF.LEXID_match_code := IF ( isLeftWinner(le.LEXIDWeight,ri.LEXIDWeight,le.LEXID_match_code,ri.LEXID_match_code ), le.LEXID_match_code, ri.LEXID_match_code );
  BOOLEAN POSSIBLE_SSNWeightForcedDown := IF ( isWeightForcedDown(le.POSSIBLE_SSNWeight,ri.POSSIBLE_SSNWeight,le.POSSIBLE_SSN_match_code,ri.POSSIBLE_SSN_match_code),TRUE,FALSE );
  SELF.POSSIBLE_SSNWeight := IF ( isLeftWinner(le.POSSIBLE_SSNWeight,ri.POSSIBLE_SSNWeight,le.POSSIBLE_SSN_match_code,ri.POSSIBLE_SSN_match_code ), le.POSSIBLE_SSNWeight, ri.POSSIBLE_SSNWeight );
  SELF.POSSIBLE_SSN := IF ( isLeftWinner(le.POSSIBLE_SSNWeight,ri.POSSIBLE_SSNWeight,le.POSSIBLE_SSN_match_code,ri.POSSIBLE_SSN_match_code ), le.POSSIBLE_SSN, ri.POSSIBLE_SSN );
  SELF.POSSIBLE_SSN_match_code := IF ( isLeftWinner(le.POSSIBLE_SSNWeight,ri.POSSIBLE_SSNWeight,le.POSSIBLE_SSN_match_code,ri.POSSIBLE_SSN_match_code ), le.POSSIBLE_SSN_match_code, ri.POSSIBLE_SSN_match_code );
  BOOLEAN CRIMEWeightForcedDown := IF ( isWeightForcedDown(le.CRIMEWeight,ri.CRIMEWeight,le.CRIME_match_code,ri.CRIME_match_code),TRUE,FALSE );
  SELF.CRIMEWeight := IF ( isLeftWinner(le.CRIMEWeight,ri.CRIMEWeight,le.CRIME_match_code,ri.CRIME_match_code ), le.CRIMEWeight, ri.CRIMEWeight );
  SELF.CRIME := IF ( isLeftWinner(le.CRIMEWeight,ri.CRIMEWeight,le.CRIME_match_code,ri.CRIME_match_code ), le.CRIME, ri.CRIME );
  SELF.CRIME_match_code := IF ( isLeftWinner(le.CRIMEWeight,ri.CRIMEWeight,le.CRIME_match_code,ri.CRIME_match_code ), le.CRIME_match_code, ri.CRIME_match_code );
  BOOLEAN NAME_TYPEWeightForcedDown := IF ( isWeightForcedDown(le.NAME_TYPEWeight,ri.NAME_TYPEWeight,le.NAME_TYPE_match_code,ri.NAME_TYPE_match_code),TRUE,FALSE );
  SELF.NAME_TYPEWeight := IF ( isLeftWinner(le.NAME_TYPEWeight,ri.NAME_TYPEWeight,le.NAME_TYPE_match_code,ri.NAME_TYPE_match_code ), le.NAME_TYPEWeight, ri.NAME_TYPEWeight );
  SELF.NAME_TYPE := IF ( isLeftWinner(le.NAME_TYPEWeight,ri.NAME_TYPEWeight,le.NAME_TYPE_match_code,ri.NAME_TYPE_match_code ), le.NAME_TYPE, ri.NAME_TYPE );
  SELF.NAME_TYPE_match_code := IF ( isLeftWinner(le.NAME_TYPEWeight,ri.NAME_TYPEWeight,le.NAME_TYPE_match_code,ri.NAME_TYPE_match_code ), le.NAME_TYPE_match_code, ri.NAME_TYPE_match_code );
  BOOLEAN CLEAN_GENDERWeightForcedDown := IF ( isWeightForcedDown(le.CLEAN_GENDERWeight,ri.CLEAN_GENDERWeight,le.CLEAN_GENDER_match_code,ri.CLEAN_GENDER_match_code),TRUE,FALSE );
  SELF.CLEAN_GENDERWeight := IF ( isLeftWinner(le.CLEAN_GENDERWeight,ri.CLEAN_GENDERWeight,le.CLEAN_GENDER_match_code,ri.CLEAN_GENDER_match_code ), le.CLEAN_GENDERWeight, ri.CLEAN_GENDERWeight );
  SELF.CLEAN_GENDER := IF ( isLeftWinner(le.CLEAN_GENDERWeight,ri.CLEAN_GENDERWeight,le.CLEAN_GENDER_match_code,ri.CLEAN_GENDER_match_code ), le.CLEAN_GENDER, ri.CLEAN_GENDER );
  SELF.CLEAN_GENDER_match_code := IF ( isLeftWinner(le.CLEAN_GENDERWeight,ri.CLEAN_GENDERWeight,le.CLEAN_GENDER_match_code,ri.CLEAN_GENDER_match_code ), le.CLEAN_GENDER_match_code, ri.CLEAN_GENDER_match_code );
  BOOLEAN CLASS_CODEWeightForcedDown := IF ( isWeightForcedDown(le.CLASS_CODEWeight,ri.CLASS_CODEWeight,le.CLASS_CODE_match_code,ri.CLASS_CODE_match_code),TRUE,FALSE );
  SELF.CLASS_CODEWeight := IF ( isLeftWinner(le.CLASS_CODEWeight,ri.CLASS_CODEWeight,le.CLASS_CODE_match_code,ri.CLASS_CODE_match_code ), le.CLASS_CODEWeight, ri.CLASS_CODEWeight );
  SELF.CLASS_CODE := IF ( isLeftWinner(le.CLASS_CODEWeight,ri.CLASS_CODEWeight,le.CLASS_CODE_match_code,ri.CLASS_CODE_match_code ), le.CLASS_CODE, ri.CLASS_CODE );
  SELF.CLASS_CODE_match_code := IF ( isLeftWinner(le.CLASS_CODEWeight,ri.CLASS_CODEWeight,le.CLASS_CODE_match_code,ri.CLASS_CODE_match_code ), le.CLASS_CODE_match_code, ri.CLASS_CODE_match_code );
  BOOLEAN DT_FIRST_SEENWeightForcedDown := IF ( isWeightForcedDown(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code),TRUE,FALSE );
  SELF.DT_FIRST_SEENWeight := IF ( isLeftWinner(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code ), le.DT_FIRST_SEENWeight, ri.DT_FIRST_SEENWeight );
  SELF.DT_FIRST_SEEN := IF ( isLeftWinner(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code ), le.DT_FIRST_SEEN, ri.DT_FIRST_SEEN );
  SELF.DT_FIRST_SEEN_match_code := IF ( isLeftWinner(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code ), le.DT_FIRST_SEEN_match_code, ri.DT_FIRST_SEEN_match_code );
  BOOLEAN DT_LAST_SEENWeightForcedDown := IF ( isWeightForcedDown(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code),TRUE,FALSE );
  SELF.DT_LAST_SEENWeight := IF ( isLeftWinner(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code ), le.DT_LAST_SEENWeight, ri.DT_LAST_SEENWeight );
  SELF.DT_LAST_SEEN := IF ( isLeftWinner(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code ), le.DT_LAST_SEEN, ri.DT_LAST_SEEN );
  SELF.DT_LAST_SEEN_match_code := IF ( isLeftWinner(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code ), le.DT_LAST_SEEN_match_code, ri.DT_LAST_SEEN_match_code );
  BOOLEAN DATA_PROVIDER_ORIWeightForcedDown := IF ( isWeightForcedDown(le.DATA_PROVIDER_ORIWeight,ri.DATA_PROVIDER_ORIWeight,le.DATA_PROVIDER_ORI_match_code,ri.DATA_PROVIDER_ORI_match_code),TRUE,FALSE );
  SELF.DATA_PROVIDER_ORIWeight := IF ( isLeftWinner(le.DATA_PROVIDER_ORIWeight,ri.DATA_PROVIDER_ORIWeight,le.DATA_PROVIDER_ORI_match_code,ri.DATA_PROVIDER_ORI_match_code ), le.DATA_PROVIDER_ORIWeight, ri.DATA_PROVIDER_ORIWeight );
  SELF.DATA_PROVIDER_ORI := IF ( isLeftWinner(le.DATA_PROVIDER_ORIWeight,ri.DATA_PROVIDER_ORIWeight,le.DATA_PROVIDER_ORI_match_code,ri.DATA_PROVIDER_ORI_match_code ), le.DATA_PROVIDER_ORI, ri.DATA_PROVIDER_ORI );
  SELF.DATA_PROVIDER_ORI_match_code := IF ( isLeftWinner(le.DATA_PROVIDER_ORIWeight,ri.DATA_PROVIDER_ORIWeight,le.DATA_PROVIDER_ORI_match_code,ri.DATA_PROVIDER_ORI_match_code ), le.DATA_PROVIDER_ORI_match_code, ri.DATA_PROVIDER_ORI_match_code );
  BOOLEAN VINWeightForcedDown := IF ( isWeightForcedDown(le.VINWeight,ri.VINWeight,le.VIN_match_code,ri.VIN_match_code),TRUE,FALSE );
  SELF.VINWeight := IF ( isLeftWinner(le.VINWeight,ri.VINWeight,le.VIN_match_code,ri.VIN_match_code ), le.VINWeight, ri.VINWeight );
  SELF.VIN := IF ( isLeftWinner(le.VINWeight,ri.VINWeight,le.VIN_match_code,ri.VIN_match_code ), le.VIN, ri.VIN );
  SELF.VIN_match_code := IF ( isLeftWinner(le.VINWeight,ri.VINWeight,le.VIN_match_code,ri.VIN_match_code ), le.VIN_match_code, ri.VIN_match_code );
  BOOLEAN PLATEWeightForcedDown := IF ( isWeightForcedDown(le.PLATEWeight,ri.PLATEWeight,le.PLATE_match_code,ri.PLATE_match_code),TRUE,FALSE );
  SELF.PLATEWeight := IF ( isLeftWinner(le.PLATEWeight,ri.PLATEWeight,le.PLATE_match_code,ri.PLATE_match_code ), le.PLATEWeight, ri.PLATEWeight );
  SELF.PLATE := IF ( isLeftWinner(le.PLATEWeight,ri.PLATEWeight,le.PLATE_match_code,ri.PLATE_match_code ), le.PLATE, ri.PLATE );
  SELF.PLATE_match_code := IF ( isLeftWinner(le.PLATEWeight,ri.PLATEWeight,le.PLATE_match_code,ri.PLATE_match_code ), le.PLATE_match_code, ri.PLATE_match_code );
  BOOLEAN LATITUDEWeightForcedDown := IF ( isWeightForcedDown(le.LATITUDEWeight,ri.LATITUDEWeight,le.LATITUDE_match_code,ri.LATITUDE_match_code),TRUE,FALSE );
  SELF.LATITUDEWeight := IF ( isLeftWinner(le.LATITUDEWeight,ri.LATITUDEWeight,le.LATITUDE_match_code,ri.LATITUDE_match_code ), le.LATITUDEWeight, ri.LATITUDEWeight );
  SELF.LATITUDE := IF ( isLeftWinner(le.LATITUDEWeight,ri.LATITUDEWeight,le.LATITUDE_match_code,ri.LATITUDE_match_code ), le.LATITUDE, ri.LATITUDE );
  SELF.LATITUDE_match_code := IF ( isLeftWinner(le.LATITUDEWeight,ri.LATITUDEWeight,le.LATITUDE_match_code,ri.LATITUDE_match_code ), le.LATITUDE_match_code, ri.LATITUDE_match_code );
  BOOLEAN LONGITUDEWeightForcedDown := IF ( isWeightForcedDown(le.LONGITUDEWeight,ri.LONGITUDEWeight,le.LONGITUDE_match_code,ri.LONGITUDE_match_code),TRUE,FALSE );
  SELF.LONGITUDEWeight := IF ( isLeftWinner(le.LONGITUDEWeight,ri.LONGITUDEWeight,le.LONGITUDE_match_code,ri.LONGITUDE_match_code ), le.LONGITUDEWeight, ri.LONGITUDEWeight );
  SELF.LONGITUDE := IF ( isLeftWinner(le.LONGITUDEWeight,ri.LONGITUDEWeight,le.LONGITUDE_match_code,ri.LONGITUDE_match_code ), le.LONGITUDE, ri.LONGITUDE );
  SELF.LONGITUDE_match_code := IF ( isLeftWinner(le.LONGITUDEWeight,ri.LONGITUDEWeight,le.LONGITUDE_match_code,ri.LONGITUDE_match_code ), le.LONGITUDE_match_code, ri.LONGITUDE_match_code );
  BOOLEAN SEARCH_ADDR1WeightForcedDown := IF ( isWeightForcedDown(le.SEARCH_ADDR1Weight,ri.SEARCH_ADDR1Weight,le.SEARCH_ADDR1_match_code,ri.SEARCH_ADDR1_match_code),TRUE,FALSE );
  SELF.SEARCH_ADDR1Weight := IF ( isLeftWinner(le.SEARCH_ADDR1Weight,ri.SEARCH_ADDR1Weight,le.SEARCH_ADDR1_match_code,ri.SEARCH_ADDR1_match_code ), le.SEARCH_ADDR1Weight, ri.SEARCH_ADDR1Weight );
  SELF.SEARCH_ADDR1 := IF ( isLeftWinner(le.SEARCH_ADDR1Weight,ri.SEARCH_ADDR1Weight,le.SEARCH_ADDR1_match_code,ri.SEARCH_ADDR1_match_code ), le.SEARCH_ADDR1, ri.SEARCH_ADDR1 );
  SELF.SEARCH_ADDR1_match_code := IF ( isLeftWinner(le.SEARCH_ADDR1Weight,ri.SEARCH_ADDR1Weight,le.SEARCH_ADDR1_match_code,ri.SEARCH_ADDR1_match_code ), le.SEARCH_ADDR1_match_code, ri.SEARCH_ADDR1_match_code );
  BOOLEAN SEARCH_ADDR2WeightForcedDown := IF ( isWeightForcedDown(le.SEARCH_ADDR2Weight,ri.SEARCH_ADDR2Weight,le.SEARCH_ADDR2_match_code,ri.SEARCH_ADDR2_match_code),TRUE,FALSE );
  SELF.SEARCH_ADDR2Weight := IF ( isLeftWinner(le.SEARCH_ADDR2Weight,ri.SEARCH_ADDR2Weight,le.SEARCH_ADDR2_match_code,ri.SEARCH_ADDR2_match_code ), le.SEARCH_ADDR2Weight, ri.SEARCH_ADDR2Weight );
  SELF.SEARCH_ADDR2 := IF ( isLeftWinner(le.SEARCH_ADDR2Weight,ri.SEARCH_ADDR2Weight,le.SEARCH_ADDR2_match_code,ri.SEARCH_ADDR2_match_code ), le.SEARCH_ADDR2, ri.SEARCH_ADDR2 );
  SELF.SEARCH_ADDR2_match_code := IF ( isLeftWinner(le.SEARCH_ADDR2Weight,ri.SEARCH_ADDR2Weight,le.SEARCH_ADDR2_match_code,ri.SEARCH_ADDR2_match_code ), le.SEARCH_ADDR2_match_code, ri.SEARCH_ADDR2_match_code );
  BOOLEAN CLEAN_COMPANY_NAMEWeightForcedDown := IF ( isWeightForcedDown(le.CLEAN_COMPANY_NAMEWeight,ri.CLEAN_COMPANY_NAMEWeight,le.CLEAN_COMPANY_NAME_match_code,ri.CLEAN_COMPANY_NAME_match_code),TRUE,FALSE );
  SELF.CLEAN_COMPANY_NAMEWeight := IF ( isLeftWinner(le.CLEAN_COMPANY_NAMEWeight,ri.CLEAN_COMPANY_NAMEWeight,le.CLEAN_COMPANY_NAME_match_code,ri.CLEAN_COMPANY_NAME_match_code ), le.CLEAN_COMPANY_NAMEWeight, ri.CLEAN_COMPANY_NAMEWeight );
  SELF.CLEAN_COMPANY_NAME := IF ( isLeftWinner(le.CLEAN_COMPANY_NAMEWeight,ri.CLEAN_COMPANY_NAMEWeight,le.CLEAN_COMPANY_NAME_match_code,ri.CLEAN_COMPANY_NAME_match_code ), le.CLEAN_COMPANY_NAME, ri.CLEAN_COMPANY_NAME );
  SELF.CLEAN_COMPANY_NAME_match_code := IF ( isLeftWinner(le.CLEAN_COMPANY_NAMEWeight,ri.CLEAN_COMPANY_NAMEWeight,le.CLEAN_COMPANY_NAME_match_code,ri.CLEAN_COMPANY_NAME_match_code ), le.CLEAN_COMPANY_NAME_match_code, ri.CLEAN_COMPANY_NAME_match_code );
  BOOLEAN DirectMAINNAMEWeightForcedDown := IF ( isWeightForcedDown(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code),TRUE,FALSE );
  BOOLEAN MAINNAMEWeightForcedDown := FNAMEWeightForcedDown OR MNAMEWeightForcedDown OR LNAMEWeightForcedDown;
  SELF.MAINNAMEWeight := MAP (
      DirectMAINNAMEWeightForcedDown => IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAMEWeight, ri.MAINNAMEWeight ),
      MAINNAMEWeightForcedDown AND (le.MAINNAME_match_code = ri.MAINNAME_match_code) => MIN(le.MAINNAMEWeight, ri.MAINNAMEWeight),
      IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAMEWeight, ri.MAINNAMEWeight ));
  SELF.MAINNAME_match_code :=  MAP (
      DirectMAINNAMEWeightForcedDown => IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAME_match_code, ri.MAINNAME_match_code ),
      MAINNAMEWeightForcedDown AND (le.MAINNAME_match_code = ri.MAINNAME_match_code) AND MIN(le.MAINNAMEWeight, ri.MAINNAMEWeight)=le.MAINNAMEWeight => le.MAINNAME_match_code,
      MAINNAMEWeightForcedDown AND (le.MAINNAME_match_code = ri.MAINNAME_match_code) AND MIN(le.MAINNAMEWeight, ri.MAINNAMEWeight)=ri.MAINNAMEWeight => ri.MAINNAME_match_code,
      IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAME_match_code, ri.MAINNAME_match_code ));
  BOOLEAN DirectFULLNAMEWeightForcedDown := IF ( isWeightForcedDown(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code),TRUE,FALSE );
  BOOLEAN FULLNAMEWeightForcedDown := MAINNAMEWeightForcedDown OR NAME_SUFFIXWeightForcedDown;
  SELF.FULLNAMEWeight := MAP (
      DirectFULLNAMEWeightForcedDown => IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAMEWeight, ri.FULLNAMEWeight ),
      FULLNAMEWeightForcedDown AND (le.FULLNAME_match_code = ri.FULLNAME_match_code) => MIN(le.FULLNAMEWeight, ri.FULLNAMEWeight),
      IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAMEWeight, ri.FULLNAMEWeight ));
  SELF.FULLNAME_match_code :=  MAP (
      DirectFULLNAMEWeightForcedDown => IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAME_match_code, ri.FULLNAME_match_code ),
      FULLNAMEWeightForcedDown AND (le.FULLNAME_match_code = ri.FULLNAME_match_code) AND MIN(le.FULLNAMEWeight, ri.FULLNAMEWeight)=le.FULLNAMEWeight => le.FULLNAME_match_code,
      FULLNAMEWeightForcedDown AND (le.FULLNAME_match_code = ri.FULLNAME_match_code) AND MIN(le.FULLNAMEWeight, ri.FULLNAMEWeight)=ri.FULLNAMEWeight => ri.FULLNAME_match_code,
      IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAME_match_code, ri.FULLNAME_match_code ));
  SELF.keys_used := le.keys_used | ri.keys_used;
  SELF.keys_failed := le.keys_failed | ri.keys_failed;
  SELF.ForceFailed := ((SELF.DOBWeight_year<>0 OR SELF.DOBWeight_month<>0 OR SELF.DOBWeight_day<>0) AND SELF.DOBWeight_year + SELF.DOBWeight_month + SELF.DOBWeight_day < Config.DOB_Force);
  SELF.Weight := MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.PHONEWeight) + MAX(0,SELF.DL_STWeight) + MAX(0,SELF.DLWeight) + MAX(0,SELF.LEXIDWeight) + MAX(0,SELF.POSSIBLE_SSNWeight) + MAX(0,SELF.CRIMEWeight) + MAX(0,SELF.NAME_TYPEWeight) + MAX(0,SELF.CLEAN_GENDERWeight) + MAX(0,SELF.CLASS_CODEWeight) + MAX(0,SELF.DT_FIRST_SEENWeight) + MAX(0,SELF.DT_LAST_SEENWeight) + MAX(0,SELF.DATA_PROVIDER_ORIWeight) + MAX(0,SELF.VINWeight) + MAX(0,SELF.PLATEWeight) + MAX(0,SELF.LATITUDEWeight) + MAX(0,SELF.LONGITUDEWeight) + MAX(0,SELF.SEARCH_ADDR1Weight) + MAX(0,SELF.SEARCH_ADDR2Weight) + MAX(0,SELF.CLEAN_COMPANY_NAMEWeight) + MAX(self.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.NAME_SUFFIXWeight);
  SELF := le;
END;
 
SHARED OutputLayout_Base := RECORD,MAXLENGTH(32000)
  BOOLEAN Verified := FALSE; // has found possible results
  BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best
  BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best
  BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best
  BOOLEAN Resolved := FALSE; // certain with 3 nines of accuracy
  DATASET(LayoutScoredFetch) Results;
  UNSIGNED4 keys_tried := 0;
END;
EXPORT OutputLayout := RECORD(OutputLayout_Base),MAXLENGTH(32000)
  InputLayout;
END;
EXPORT OutputLayout_Batch := RECORD(OutputLayout_Base),MAXLENGTH(32006)
  SALT33.UIDType Reference;
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
    SALT33.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF.Summary := IF(le.NAME_SUFFIXWeight = 0,'','|'+IF(le.NAME_SUFFIXWeight < 0,'-','')+'NAME_SUFFIX')+IF(le.FNAMEWeight = 0,'','|'+IF(le.FNAMEWeight < 0,'-','')+'FNAME')+IF(le.MNAMEWeight = 0,'','|'+IF(le.MNAMEWeight < 0,'-','')+'MNAME')+IF(le.LNAMEWeight = 0,'','|'+IF(le.LNAMEWeight < 0,'-','')+'LNAME')+IF(le.PRIM_RANGEWeight = 0,'','|'+IF(le.PRIM_RANGEWeight < 0,'-','')+'PRIM_RANGE')+IF(le.PRIM_NAMEWeight = 0,'','|'+IF(le.PRIM_NAMEWeight < 0,'-','')+'PRIM_NAME')+IF(le.SEC_RANGEWeight = 0,'','|'+IF(le.SEC_RANGEWeight < 0,'-','')+'SEC_RANGE')+IF(le.P_CITY_NAMEWeight = 0,'','|'+IF(le.P_CITY_NAMEWeight < 0,'-','')+'P_CITY_NAME')+IF(le.STWeight = 0,'','|'+IF(le.STWeight < 0,'-','')+'ST')+IF(le.ZIPWeight = 0,'','|'+IF(le.ZIPWeight < 0,'-','')+'ZIP')+IF(le.DOBWeight_year+le.DOBWeight_month+le.DOBWeight_day=0,'','|'+IF(le.DOBWeight_year+le.DOBWeight_month+le.DOBWeight_day<0,'-','')+'DOB')+IF(le.PHONEWeight = 0,'','|'+IF(le.PHONEWeight < 0,'-','')+'PHONE')+IF(le.DL_STWeight = 0,'','|'+IF(le.DL_STWeight < 0,'-','')+'DL_ST')+IF(le.DLWeight = 0,'','|'+IF(le.DLWeight < 0,'-','')+'DL')+IF(le.LEXIDWeight = 0,'','|'+IF(le.LEXIDWeight < 0,'-','')+'LEXID')+IF(le.POSSIBLE_SSNWeight = 0,'','|'+IF(le.POSSIBLE_SSNWeight < 0,'-','')+'POSSIBLE_SSN')+IF(le.CRIMEWeight = 0,'','|'+IF(le.CRIMEWeight < 0,'-','')+'CRIME')+IF(le.NAME_TYPEWeight = 0,'','|'+IF(le.NAME_TYPEWeight < 0,'-','')+'NAME_TYPE')+IF(le.CLEAN_GENDERWeight = 0,'','|'+IF(le.CLEAN_GENDERWeight < 0,'-','')+'CLEAN_GENDER')+IF(le.CLASS_CODEWeight = 0,'','|'+IF(le.CLASS_CODEWeight < 0,'-','')+'CLASS_CODE')+IF(le.DT_FIRST_SEENWeight = 0,'','|'+IF(le.DT_FIRST_SEENWeight < 0,'-','')+'DT_FIRST_SEEN')+IF(le.DT_LAST_SEENWeight = 0,'','|'+IF(le.DT_LAST_SEENWeight < 0,'-','')+'DT_LAST_SEEN')+IF(le.DATA_PROVIDER_ORIWeight = 0,'','|'+IF(le.DATA_PROVIDER_ORIWeight < 0,'-','')+'DATA_PROVIDER_ORI')+IF(le.VINWeight = 0,'','|'+IF(le.VINWeight < 0,'-','')+'VIN')+IF(le.PLATEWeight = 0,'','|'+IF(le.PLATEWeight < 0,'-','')+'PLATE')+IF(le.LATITUDEWeight = 0,'','|'+IF(le.LATITUDEWeight < 0,'-','')+'LATITUDE')+IF(le.LONGITUDEWeight = 0,'','|'+IF(le.LONGITUDEWeight < 0,'-','')+'LONGITUDE')+IF(le.SEARCH_ADDR1Weight = 0,'','|'+IF(le.SEARCH_ADDR1Weight < 0,'-','')+'SEARCH_ADDR1')+IF(le.SEARCH_ADDR2Weight = 0,'','|'+IF(le.SEARCH_ADDR2Weight < 0,'-','')+'SEARCH_ADDR2')+IF(le.CLEAN_COMPANY_NAMEWeight = 0,'','|'+IF(le.CLEAN_COMPANY_NAMEWeight < 0,'-','')+'CLEAN_COMPANY_NAME')+IF(le.MAINNAMEWeight = 0,'','|'+IF(le.MAINNAMEWeight < 0,'-','')+'MAINNAME')+IF(le.FULLNAMEWeight = 0,'','|'+IF(le.FULLNAMEWeight < 0,'-','')+'FULLNAME');
  END;
  P := PROJECT(ds,tosummary(LEFT));
  RETURN SORT(TABLE(P,{Summary, Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
EXPORT AdjustScoresForNonExactMatches(DATASET(LayoutScoredFetch) in_data) := FUNCTION
 
aggregateRec := RECORD
  in_data.reference;
  NAME_SUFFIXWeight := MAX(GROUP,IF( in_data.NAME_SUFFIX_match_code=SALT33.MatchCode.ExactMatch, in_data.NAME_SUFFIXWeight,0 ));
  FNAMEWeight := MAX(GROUP,IF( in_data.FNAME_match_code=SALT33.MatchCode.ExactMatch, in_data.FNAMEWeight,0 ));
  MNAMEWeight := MAX(GROUP,IF( in_data.MNAME_match_code=SALT33.MatchCode.ExactMatch, in_data.MNAMEWeight,0 ));
  LNAMEWeight := MAX(GROUP,IF( in_data.LNAME_match_code=SALT33.MatchCode.ExactMatch, in_data.LNAMEWeight,0 ));
  PRIM_RANGEWeight := MAX(GROUP,IF( in_data.PRIM_RANGE_match_code=SALT33.MatchCode.ExactMatch, in_data.PRIM_RANGEWeight,0 ));
  PRIM_NAMEWeight := MAX(GROUP,IF( in_data.PRIM_NAME_match_code=SALT33.MatchCode.ExactMatch, in_data.PRIM_NAMEWeight,0 ));
  SEC_RANGEWeight := MAX(GROUP,IF( in_data.SEC_RANGE_match_code=SALT33.MatchCode.ExactMatch, in_data.SEC_RANGEWeight,0 ));
  P_CITY_NAMEWeight := MAX(GROUP,IF( in_data.P_CITY_NAME_match_code=SALT33.MatchCode.ExactMatch, in_data.P_CITY_NAMEWeight,0 ));
  STWeight := MAX(GROUP,IF( in_data.ST_match_code=SALT33.MatchCode.ExactMatch, in_data.STWeight,0 ));
  ZIPWeight := MAX(GROUP,IF( in_data.ZIP_match_code=SALT33.MatchCode.ExactMatch, in_data.ZIPWeight,0 ));
  DOBWeight := MAX(GROUP,IF( in_data.DOB_year_match_code=SALT33.MatchCode.ExactMatch AND in_data.DOB_month_match_code=SALT33.MatchCode.ExactMatch AND in_data.DOB_day_match_code=SALT33.MatchCode.ExactMatch, in_data.DOBWeight,0 ));
  PHONEWeight := MAX(GROUP,IF( in_data.PHONE_match_code=SALT33.MatchCode.ExactMatch, in_data.PHONEWeight,0 ));
  DL_STWeight := MAX(GROUP,IF( in_data.DL_ST_match_code=SALT33.MatchCode.ExactMatch, in_data.DL_STWeight,0 ));
  DLWeight := MAX(GROUP,IF( in_data.DL_match_code=SALT33.MatchCode.ExactMatch, in_data.DLWeight,0 ));
  LEXIDWeight := MAX(GROUP,IF( in_data.LEXID_match_code=SALT33.MatchCode.ExactMatch, in_data.LEXIDWeight,0 ));
  POSSIBLE_SSNWeight := MAX(GROUP,IF( in_data.POSSIBLE_SSN_match_code=SALT33.MatchCode.ExactMatch, in_data.POSSIBLE_SSNWeight,0 ));
  CRIMEWeight := MAX(GROUP,IF( in_data.CRIME_match_code=SALT33.MatchCode.ExactMatch, in_data.CRIMEWeight,0 ));
  NAME_TYPEWeight := MAX(GROUP,IF( in_data.NAME_TYPE_match_code=SALT33.MatchCode.ExactMatch, in_data.NAME_TYPEWeight,0 ));
  CLEAN_GENDERWeight := MAX(GROUP,IF( in_data.CLEAN_GENDER_match_code=SALT33.MatchCode.ExactMatch, in_data.CLEAN_GENDERWeight,0 ));
  CLASS_CODEWeight := MAX(GROUP,IF( in_data.CLASS_CODE_match_code=SALT33.MatchCode.ExactMatch, in_data.CLASS_CODEWeight,0 ));
  DT_FIRST_SEENWeight := MAX(GROUP,IF( in_data.DT_FIRST_SEEN_match_code=SALT33.MatchCode.ExactMatch, in_data.DT_FIRST_SEENWeight,0 ));
  DT_LAST_SEENWeight := MAX(GROUP,IF( in_data.DT_LAST_SEEN_match_code=SALT33.MatchCode.ExactMatch, in_data.DT_LAST_SEENWeight,0 ));
  DATA_PROVIDER_ORIWeight := MAX(GROUP,IF( in_data.DATA_PROVIDER_ORI_match_code=SALT33.MatchCode.ExactMatch, in_data.DATA_PROVIDER_ORIWeight,0 ));
  VINWeight := MAX(GROUP,IF( in_data.VIN_match_code=SALT33.MatchCode.ExactMatch, in_data.VINWeight,0 ));
  PLATEWeight := MAX(GROUP,IF( in_data.PLATE_match_code=SALT33.MatchCode.ExactMatch, in_data.PLATEWeight,0 ));
  LATITUDEWeight := MAX(GROUP,IF( in_data.LATITUDE_match_code=SALT33.MatchCode.ExactMatch, in_data.LATITUDEWeight,0 ));
  LONGITUDEWeight := MAX(GROUP,IF( in_data.LONGITUDE_match_code=SALT33.MatchCode.ExactMatch, in_data.LONGITUDEWeight,0 ));
  SEARCH_ADDR1Weight := MAX(GROUP,IF( in_data.SEARCH_ADDR1_match_code=SALT33.MatchCode.ExactMatch, in_data.SEARCH_ADDR1Weight,0 ));
  SEARCH_ADDR2Weight := MAX(GROUP,IF( in_data.SEARCH_ADDR2_match_code=SALT33.MatchCode.ExactMatch, in_data.SEARCH_ADDR2Weight,0 ));
  CLEAN_COMPANY_NAMEWeight := MAX(GROUP,IF( in_data.CLEAN_COMPANY_NAME_match_code=SALT33.MatchCode.ExactMatch, in_data.CLEAN_COMPANY_NAMEWeight,0 ));
  MAINNAMEWeight := MAX(GROUP,IF( in_data.MAINNAME_match_code=SALT33.MatchCode.ExactMatch, in_data.MAINNAMEWeight,0 ));
  FULLNAMEWeight := MAX(GROUP,IF( in_data.FULLNAME_match_code=SALT33.MatchCode.ExactMatch, in_data.FULLNAMEWeight,0 ));
END;
  R1 := TABLE(in_data,aggregateRec,Reference);
 
LayoutScoredFetch FixScores(LayoutScoredFetch le, aggregateRec ri) := TRANSFORM
  SELF.NAME_SUFFIXWeight := MAP( ri.NAME_SUFFIXWeight=0 OR le.NAME_SUFFIX_match_code=SALT33.MatchCode.ExactMatch => le.NAME_SUFFIXWeight,MIN(le.NAME_SUFFIXWeight,ri.NAME_SUFFIXWeight-1) );
  SELF.FNAMEWeight := MAP( ri.FNAMEWeight=0 OR le.FNAME_match_code=SALT33.MatchCode.ExactMatch => le.FNAMEWeight,MIN(le.FNAMEWeight,ri.FNAMEWeight-1) );
  SELF.MNAMEWeight := MAP( ri.MNAMEWeight=0 OR le.MNAME_match_code=SALT33.MatchCode.ExactMatch => le.MNAMEWeight,MIN(le.MNAMEWeight,ri.MNAMEWeight-1) );
  SELF.LNAMEWeight := MAP( ri.LNAMEWeight=0 OR le.LNAME_match_code=SALT33.MatchCode.ExactMatch => le.LNAMEWeight,MIN(le.LNAMEWeight,ri.LNAMEWeight-1) );
  SELF.PRIM_RANGEWeight := MAP( ri.PRIM_RANGEWeight=0 OR le.PRIM_RANGE_match_code=SALT33.MatchCode.ExactMatch => le.PRIM_RANGEWeight,MIN(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight-1) );
  SELF.PRIM_NAMEWeight := MAP( ri.PRIM_NAMEWeight=0 OR le.PRIM_NAME_match_code=SALT33.MatchCode.ExactMatch => le.PRIM_NAMEWeight,MIN(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight-1) );
  SELF.SEC_RANGEWeight := MAP( ri.SEC_RANGEWeight=0 OR le.SEC_RANGE_match_code=SALT33.MatchCode.ExactMatch => le.SEC_RANGEWeight,MIN(le.SEC_RANGEWeight,ri.SEC_RANGEWeight-1) );
  SELF.P_CITY_NAMEWeight := MAP( ri.P_CITY_NAMEWeight=0 OR le.P_CITY_NAME_match_code=SALT33.MatchCode.ExactMatch => le.P_CITY_NAMEWeight,MIN(le.P_CITY_NAMEWeight,ri.P_CITY_NAMEWeight-1) );
  SELF.STWeight := MAP( ri.STWeight=0 OR le.ST_match_code=SALT33.MatchCode.ExactMatch => le.STWeight,MIN(le.STWeight,ri.STWeight-1) );
  SELF.ZIPWeight := MAP( ri.ZIPWeight=0 OR le.ZIP_match_code=SALT33.MatchCode.ExactMatch => le.ZIPWeight,MIN(le.ZIPWeight,ri.ZIPWeight-1) );
  SELF.DOBWeight := MAP( ri.DOBWeight=0 OR (le.DOB_year_match_code=SALT33.MatchCode.ExactMatch AND le.DOB_month_match_code=SALT33.MatchCode.ExactMatch AND le.DOB_day_match_code=SALT33.MatchCode.ExactMatch) => le.DOBWeight,MIN(le.DOBWeight,ri.DOBWeight-1) );
  SELF.PHONEWeight := MAP( ri.PHONEWeight=0 OR le.PHONE_match_code=SALT33.MatchCode.ExactMatch => le.PHONEWeight,MIN(le.PHONEWeight,ri.PHONEWeight-1) );
  SELF.DL_STWeight := MAP( ri.DL_STWeight=0 OR le.DL_ST_match_code=SALT33.MatchCode.ExactMatch => le.DL_STWeight,MIN(le.DL_STWeight,ri.DL_STWeight-1) );
  SELF.DLWeight := MAP( ri.DLWeight=0 OR le.DL_match_code=SALT33.MatchCode.ExactMatch => le.DLWeight,MIN(le.DLWeight,ri.DLWeight-1) );
  SELF.LEXIDWeight := MAP( ri.LEXIDWeight=0 OR le.LEXID_match_code=SALT33.MatchCode.ExactMatch => le.LEXIDWeight,MIN(le.LEXIDWeight,ri.LEXIDWeight-1) );
  SELF.POSSIBLE_SSNWeight := MAP( ri.POSSIBLE_SSNWeight=0 OR le.POSSIBLE_SSN_match_code=SALT33.MatchCode.ExactMatch => le.POSSIBLE_SSNWeight,MIN(le.POSSIBLE_SSNWeight,ri.POSSIBLE_SSNWeight-1) );
  SELF.CRIMEWeight := MAP( ri.CRIMEWeight=0 OR le.CRIME_match_code=SALT33.MatchCode.ExactMatch => le.CRIMEWeight,MIN(le.CRIMEWeight,ri.CRIMEWeight-1) );
  SELF.NAME_TYPEWeight := MAP( ri.NAME_TYPEWeight=0 OR le.NAME_TYPE_match_code=SALT33.MatchCode.ExactMatch => le.NAME_TYPEWeight,MIN(le.NAME_TYPEWeight,ri.NAME_TYPEWeight-1) );
  SELF.CLEAN_GENDERWeight := MAP( ri.CLEAN_GENDERWeight=0 OR le.CLEAN_GENDER_match_code=SALT33.MatchCode.ExactMatch => le.CLEAN_GENDERWeight,MIN(le.CLEAN_GENDERWeight,ri.CLEAN_GENDERWeight-1) );
  SELF.CLASS_CODEWeight := MAP( ri.CLASS_CODEWeight=0 OR le.CLASS_CODE_match_code=SALT33.MatchCode.ExactMatch => le.CLASS_CODEWeight,MIN(le.CLASS_CODEWeight,ri.CLASS_CODEWeight-1) );
  SELF.DT_FIRST_SEENWeight := MAP( ri.DT_FIRST_SEENWeight=0 OR le.DT_FIRST_SEEN_match_code=SALT33.MatchCode.ExactMatch => le.DT_FIRST_SEENWeight,MIN(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight-1) );
  SELF.DT_LAST_SEENWeight := MAP( ri.DT_LAST_SEENWeight=0 OR le.DT_LAST_SEEN_match_code=SALT33.MatchCode.ExactMatch => le.DT_LAST_SEENWeight,MIN(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight-1) );
  SELF.DATA_PROVIDER_ORIWeight := MAP( ri.DATA_PROVIDER_ORIWeight=0 OR le.DATA_PROVIDER_ORI_match_code=SALT33.MatchCode.ExactMatch => le.DATA_PROVIDER_ORIWeight,MIN(le.DATA_PROVIDER_ORIWeight,ri.DATA_PROVIDER_ORIWeight-1) );
  SELF.VINWeight := MAP( ri.VINWeight=0 OR le.VIN_match_code=SALT33.MatchCode.ExactMatch => le.VINWeight,MIN(le.VINWeight,ri.VINWeight-1) );
  SELF.PLATEWeight := MAP( ri.PLATEWeight=0 OR le.PLATE_match_code=SALT33.MatchCode.ExactMatch => le.PLATEWeight,MIN(le.PLATEWeight,ri.PLATEWeight-1) );
  SELF.LATITUDEWeight := MAP( ri.LATITUDEWeight=0 OR le.LATITUDE_match_code=SALT33.MatchCode.ExactMatch => le.LATITUDEWeight,MIN(le.LATITUDEWeight,ri.LATITUDEWeight-1) );
  SELF.LONGITUDEWeight := MAP( ri.LONGITUDEWeight=0 OR le.LONGITUDE_match_code=SALT33.MatchCode.ExactMatch => le.LONGITUDEWeight,MIN(le.LONGITUDEWeight,ri.LONGITUDEWeight-1) );
  SELF.SEARCH_ADDR1Weight := MAP( ri.SEARCH_ADDR1Weight=0 OR le.SEARCH_ADDR1_match_code=SALT33.MatchCode.ExactMatch => le.SEARCH_ADDR1Weight,MIN(le.SEARCH_ADDR1Weight,ri.SEARCH_ADDR1Weight-1) );
  SELF.SEARCH_ADDR2Weight := MAP( ri.SEARCH_ADDR2Weight=0 OR le.SEARCH_ADDR2_match_code=SALT33.MatchCode.ExactMatch => le.SEARCH_ADDR2Weight,MIN(le.SEARCH_ADDR2Weight,ri.SEARCH_ADDR2Weight-1) );
  SELF.CLEAN_COMPANY_NAMEWeight := MAP( ri.CLEAN_COMPANY_NAMEWeight=0 OR le.CLEAN_COMPANY_NAME_match_code=SALT33.MatchCode.ExactMatch => le.CLEAN_COMPANY_NAMEWeight,MIN(le.CLEAN_COMPANY_NAMEWeight,ri.CLEAN_COMPANY_NAMEWeight-1) );
  SELF.MAINNAMEWeight := MAP( ri.MAINNAMEWeight=0 OR le.MAINNAME_match_code=SALT33.MatchCode.ExactMatch => le.MAINNAMEWeight,MIN(le.MAINNAMEWeight,ri.MAINNAMEWeight-1) );
  SELF.FULLNAMEWeight := MAP( ri.FULLNAMEWeight=0 OR le.FULLNAME_match_code=SALT33.MatchCode.ExactMatch => le.FULLNAMEWeight,MIN(le.FULLNAMEWeight,ri.FULLNAMEWeight-1) );
  SELF.Weight := MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.PHONEWeight) + MAX(0,SELF.DL_STWeight) + MAX(0,SELF.DLWeight) + MAX(0,SELF.LEXIDWeight) + MAX(0,SELF.POSSIBLE_SSNWeight) + MAX(0,SELF.CRIMEWeight) + MAX(0,SELF.NAME_TYPEWeight) + MAX(0,SELF.CLEAN_GENDERWeight) + MAX(0,SELF.CLASS_CODEWeight) + MAX(0,SELF.DT_FIRST_SEENWeight) + MAX(0,SELF.DT_LAST_SEENWeight) + MAX(0,SELF.DATA_PROVIDER_ORIWeight) + MAX(0,SELF.VINWeight) + MAX(0,SELF.PLATEWeight) + MAX(0,SELF.LATITUDEWeight) + MAX(0,SELF.LONGITUDEWeight) + MAX(0,SELF.SEARCH_ADDR1Weight) + MAX(0,SELF.SEARCH_ADDR2Weight) + MAX(0,SELF.CLEAN_COMPANY_NAMEWeight) + MAX(self.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.NAME_SUFFIXWeight);
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
  r0 := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(reference)),Reference, LOCAL ), Reference, LOCAL),EID_HASH),LEFT.EID_HASH=RIGHT.EID_HASH,Combine_Scores(LEFT,RIGHT))(SALT33.DebugMode OR ~ForceFailed);
  r1 := AdjustScoresForNonExactMatches(UNGROUP(r0));
  R2 := ROLLUP( TOPN(r1,100,-Weight),GROUP, Create_Output(LEFT,ROWS(LEFT)) );
  SALT33.MAC_External_AddPcnt(R2,LayoutScoredFetch,Results,OutputLayout_Batch,28,R3);
  RETURN r3;
END;
EXPORT CombineLinkpathScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
// Note - results are returned distributed by HASH(reference) - this is part of the specification
  rolled := ROLLUP ( SORT( DISTRIBUTE( in_data, HASH(reference) ), Reference, EID_HASH, LOCAL), Combine_Scores(LEFT,RIGHT), Reference, EID_HASH, LOCAL);
  RETURN DEDUP( SORT( rolled, Reference, -weight, LOCAL ), Reference, KEEP(Config.LinkpathCandidateCount),LOCAL);
END;
EXPORT KeysUsedToText(UNSIGNED4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','') + IF(k&(1<<1)<>0,'NAME,','') + IF(k&(1<<2)<>0,'ADDRESS,','') + IF(k&(1<<3)<>0,'ADDRESS1,','') + IF(k&(1<<4)<>0,'DOB,','') + IF(k&(1<<5)<>0,'ZIP_PR,','') + IF(k&(1<<6)<>0,'DLN,','') + IF(k&(1<<7)<>0,'PH,','') + IF(k&(1<<8)<>0,'LFZ,','') + IF(k&(1<<9)<>0,'VIN,','') + IF(k&(1<<10)<>0,'LEXID,','') + IF(k&(1<<11)<>0,'SSN,','') + IF(k&(1<<12)<>0,'LATLONG,','') + IF(k&(1<<13)<>0,'PLATE,','') + IF(k&(1<<14)<>0,'COMPANY,','');
  RETURN list[1..LENGTH(TRIM(list))-1]; // Strim last ,
end;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT33.UIDType EID_HASH;
  DATASET(SALT33.Layout_FieldValueList) PRIM_RANGE_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) PRIM_NAME_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) SEC_RANGE_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) P_CITY_NAME_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) ST_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) ZIP_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) DOB_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) PHONE_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) DL_ST_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) DL_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) LEXID_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) POSSIBLE_SSN_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) CRIME_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) NAME_TYPE_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) CLEAN_GENDER_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) CLASS_CODE_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) DT_FIRST_SEEN_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) DT_LAST_SEEN_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) DATA_PROVIDER_ORI_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) VIN_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) PLATE_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) LATITUDE_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) LONGITUDE_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) SEARCH_ADDR1_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) SEARCH_ADDR2_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) CLEAN_COMPANY_NAME_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) FULLNAME_Values := DATASET([],SALT33.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.EID_HASH := le.EID_HASH;
    SELF.PRIM_RANGE_values := SALT33.fn_combine_fieldvaluelist(le.PRIM_RANGE_values,ri.PRIM_RANGE_values);
    SELF.PRIM_NAME_values := SALT33.fn_combine_fieldvaluelist(le.PRIM_NAME_values,ri.PRIM_NAME_values);
    SELF.SEC_RANGE_values := SALT33.fn_combine_fieldvaluelist(le.SEC_RANGE_values,ri.SEC_RANGE_values);
    SELF.P_CITY_NAME_values := SALT33.fn_combine_fieldvaluelist(le.P_CITY_NAME_values,ri.P_CITY_NAME_values);
    SELF.ST_values := SALT33.fn_combine_fieldvaluelist(le.ST_values,ri.ST_values);
    SELF.ZIP_values := SALT33.fn_combine_fieldvaluelist(le.ZIP_values,ri.ZIP_values);
    SELF.DOB_values := SALT33.fn_combine_fieldvaluelist(le.DOB_values,ri.DOB_values);
    SELF.PHONE_values := SALT33.fn_combine_fieldvaluelist(le.PHONE_values,ri.PHONE_values);
    SELF.DL_ST_values := SALT33.fn_combine_fieldvaluelist(le.DL_ST_values,ri.DL_ST_values);
    SELF.DL_values := SALT33.fn_combine_fieldvaluelist(le.DL_values,ri.DL_values);
    SELF.LEXID_values := SALT33.fn_combine_fieldvaluelist(le.LEXID_values,ri.LEXID_values);
    SELF.POSSIBLE_SSN_values := SALT33.fn_combine_fieldvaluelist(le.POSSIBLE_SSN_values,ri.POSSIBLE_SSN_values);
    SELF.CRIME_values := SALT33.fn_combine_fieldvaluelist(le.CRIME_values,ri.CRIME_values);
    SELF.NAME_TYPE_values := SALT33.fn_combine_fieldvaluelist(le.NAME_TYPE_values,ri.NAME_TYPE_values);
    SELF.CLEAN_GENDER_values := SALT33.fn_combine_fieldvaluelist(le.CLEAN_GENDER_values,ri.CLEAN_GENDER_values);
    SELF.CLASS_CODE_values := SALT33.fn_combine_fieldvaluelist(le.CLASS_CODE_values,ri.CLASS_CODE_values);
    SELF.DT_FIRST_SEEN_values := SALT33.fn_combine_fieldvaluelist(le.DT_FIRST_SEEN_values,ri.DT_FIRST_SEEN_values);
    SELF.DT_LAST_SEEN_values := SALT33.fn_combine_fieldvaluelist(le.DT_LAST_SEEN_values,ri.DT_LAST_SEEN_values);
    SELF.DATA_PROVIDER_ORI_values := SALT33.fn_combine_fieldvaluelist(le.DATA_PROVIDER_ORI_values,ri.DATA_PROVIDER_ORI_values);
    SELF.VIN_values := SALT33.fn_combine_fieldvaluelist(le.VIN_values,ri.VIN_values);
    SELF.PLATE_values := SALT33.fn_combine_fieldvaluelist(le.PLATE_values,ri.PLATE_values);
    SELF.LATITUDE_values := SALT33.fn_combine_fieldvaluelist(le.LATITUDE_values,ri.LATITUDE_values);
    SELF.LONGITUDE_values := SALT33.fn_combine_fieldvaluelist(le.LONGITUDE_values,ri.LONGITUDE_values);
    SELF.SEARCH_ADDR1_values := SALT33.fn_combine_fieldvaluelist(le.SEARCH_ADDR1_values,ri.SEARCH_ADDR1_values);
    SELF.SEARCH_ADDR2_values := SALT33.fn_combine_fieldvaluelist(le.SEARCH_ADDR2_values,ri.SEARCH_ADDR2_values);
    SELF.CLEAN_COMPANY_NAME_values := SALT33.fn_combine_fieldvaluelist(le.CLEAN_COMPANY_NAME_values,ri.CLEAN_COMPANY_NAME_values);
    SELF.FULLNAME_values := SALT33.fn_combine_fieldvaluelist(le.FULLNAME_values,ri.FULLNAME_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(EID_HASH) ), EID_HASH, LOCAL ), LEFT.EID_HASH = RIGHT.EID_HASH, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.EID_HASH := le.EID_HASH;
    SELF.PRIM_RANGE_values := SORT(le.PRIM_RANGE_values, -cnt, val, LOCAL);
    SELF.PRIM_NAME_values := SORT(le.PRIM_NAME_values, -cnt, val, LOCAL);
    SELF.SEC_RANGE_values := SORT(le.SEC_RANGE_values, -cnt, val, LOCAL);
    SELF.P_CITY_NAME_values := SORT(le.P_CITY_NAME_values, -cnt, val, LOCAL);
    SELF.ST_values := SORT(le.ST_values, -cnt, val, LOCAL);
    SELF.ZIP_values := SORT(le.ZIP_values, -cnt, val, LOCAL);
    SELF.DOB_values := SORT(le.DOB_values, -cnt, val, LOCAL);
    SELF.PHONE_values := SORT(le.PHONE_values, -cnt, val, LOCAL);
    SELF.DL_ST_values := SORT(le.DL_ST_values, -cnt, val, LOCAL);
    SELF.DL_values := SORT(le.DL_values, -cnt, val, LOCAL);
    SELF.LEXID_values := SORT(le.LEXID_values, -cnt, val, LOCAL);
    SELF.POSSIBLE_SSN_values := SORT(le.POSSIBLE_SSN_values, -cnt, val, LOCAL);
    SELF.CRIME_values := SORT(le.CRIME_values, -cnt, val, LOCAL);
    SELF.NAME_TYPE_values := SORT(le.NAME_TYPE_values, -cnt, val, LOCAL);
    SELF.CLEAN_GENDER_values := SORT(le.CLEAN_GENDER_values, -cnt, val, LOCAL);
    SELF.CLASS_CODE_values := SORT(le.CLASS_CODE_values, -cnt, val, LOCAL);
    SELF.DT_FIRST_SEEN_values := SORT(le.DT_FIRST_SEEN_values, -cnt, val, LOCAL);
    SELF.DT_LAST_SEEN_values := SORT(le.DT_LAST_SEEN_values, -cnt, val, LOCAL);
    SELF.DATA_PROVIDER_ORI_values := SORT(le.DATA_PROVIDER_ORI_values, -cnt, val, LOCAL);
    SELF.VIN_values := SORT(le.VIN_values, -cnt, val, LOCAL);
    SELF.PLATE_values := SORT(le.PLATE_values, -cnt, val, LOCAL);
    SELF.LATITUDE_values := SORT(le.LATITUDE_values, -cnt, val, LOCAL);
    SELF.LONGITUDE_values := SORT(le.LONGITUDE_values, -cnt, val, LOCAL);
    SELF.SEARCH_ADDR1_values := SORT(le.SEARCH_ADDR1_values, -cnt, val, LOCAL);
    SELF.SEARCH_ADDR2_values := SORT(le.SEARCH_ADDR2_values, -cnt, val, LOCAL);
    SELF.CLEAN_COMPANY_NAME_values := SORT(le.CLEAN_COMPANY_NAME_values, -cnt, val, LOCAL);
    SELF.FULLNAME_values := SORT(le.FULLNAME_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(RECORDOF(Key)) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.EID_HASH := le.EID_HASH;
  SELF.PRIM_RANGE_Values := IF ( (SALT33.StrType)le.PRIM_RANGE = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.PRIM_RANGE)}],SALT33.Layout_FieldValueList));
  SELF.PRIM_NAME_Values := IF ( (SALT33.StrType)le.PRIM_NAME = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.PRIM_NAME)}],SALT33.Layout_FieldValueList));
  SELF.SEC_RANGE_Values := IF ( (SALT33.StrType)le.SEC_RANGE = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.SEC_RANGE)}],SALT33.Layout_FieldValueList));
  SELF.P_CITY_NAME_Values := IF ( (SALT33.StrType)le.P_CITY_NAME = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.P_CITY_NAME)}],SALT33.Layout_FieldValueList));
  SELF.ST_Values := IF ( (SALT33.StrType)le.ST = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.ST)}],SALT33.Layout_FieldValueList));
  SELF.ZIP_Values := IF ( (SALT33.StrType)le.ZIP = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.ZIP)}],SALT33.Layout_FieldValueList));
  self.DOB_Values := IF ( (unsigned)le.DOB = 0,dataset([],SALT33.Layout_FieldValueList),dataset([{(SALT33.StrType)le.DOB}],SALT33.Layout_FieldValueList));
  SELF.PHONE_Values := IF ( (SALT33.StrType)le.PHONE = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.PHONE)}],SALT33.Layout_FieldValueList));
  SELF.DL_ST_Values := IF ( (SALT33.StrType)le.DL_ST = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.DL_ST)}],SALT33.Layout_FieldValueList));
  SELF.DL_Values := IF ( (SALT33.StrType)le.DL = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.DL)}],SALT33.Layout_FieldValueList));
  SELF.LEXID_Values := IF ( (SALT33.StrType)le.LEXID = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.LEXID)}],SALT33.Layout_FieldValueList));
  SELF.POSSIBLE_SSN_Values := IF ( (SALT33.StrType)le.POSSIBLE_SSN = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.POSSIBLE_SSN)}],SALT33.Layout_FieldValueList));
  SELF.CRIME_Values := IF ( (SALT33.StrType)le.CRIME = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.CRIME)}],SALT33.Layout_FieldValueList));
  SELF.NAME_TYPE_Values := IF ( (SALT33.StrType)le.NAME_TYPE = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.NAME_TYPE)}],SALT33.Layout_FieldValueList));
  SELF.CLEAN_GENDER_Values := IF ( (SALT33.StrType)le.CLEAN_GENDER = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.CLEAN_GENDER)}],SALT33.Layout_FieldValueList));
  SELF.CLASS_CODE_Values := IF ( (SALT33.StrType)le.CLASS_CODE = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.CLASS_CODE)}],SALT33.Layout_FieldValueList));
  SELF.DT_FIRST_SEEN_Values := IF ( (SALT33.StrType)le.DT_FIRST_SEEN = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.DT_FIRST_SEEN)}],SALT33.Layout_FieldValueList));
  SELF.DT_LAST_SEEN_Values := IF ( (SALT33.StrType)le.DT_LAST_SEEN = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.DT_LAST_SEEN)}],SALT33.Layout_FieldValueList));
  SELF.DATA_PROVIDER_ORI_Values := IF ( (SALT33.StrType)le.DATA_PROVIDER_ORI = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.DATA_PROVIDER_ORI)}],SALT33.Layout_FieldValueList));
  SELF.VIN_Values := IF ( (SALT33.StrType)le.VIN = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.VIN)}],SALT33.Layout_FieldValueList));
  SELF.PLATE_Values := IF ( (SALT33.StrType)le.PLATE = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.PLATE)}],SALT33.Layout_FieldValueList));
  SELF.LATITUDE_Values := IF ( (SALT33.StrType)le.LATITUDE = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.LATITUDE)}],SALT33.Layout_FieldValueList));
  SELF.LONGITUDE_Values := IF ( (SALT33.StrType)le.LONGITUDE = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.LONGITUDE)}],SALT33.Layout_FieldValueList));
  SELF.SEARCH_ADDR1_Values := IF ( (SALT33.StrType)le.SEARCH_ADDR1 = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.SEARCH_ADDR1)}],SALT33.Layout_FieldValueList));
  SELF.SEARCH_ADDR2_Values := IF ( (SALT33.StrType)le.SEARCH_ADDR2 = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.SEARCH_ADDR2)}],SALT33.Layout_FieldValueList));
  SELF.CLEAN_COMPANY_NAME_Values := IF ( (SALT33.StrType)le.CLEAN_COMPANY_NAME = '',DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.CLEAN_COMPANY_NAME)}],SALT33.Layout_FieldValueList));
  self.FULLNAME_Values := IF ( (SALT33.StrType)le.FNAME = '' AND (SALT33.StrType)le.MNAME = '' AND (SALT33.StrType)le.LNAME = '' AND (SALT33.StrType)le.NAME_SUFFIX = '',dataset([],SALT33.Layout_FieldValueList),dataset([{TRIM((SALT33.StrType)le.FNAME) + ' ' + TRIM((SALT33.StrType)le.MNAME) + ' ' + TRIM((SALT33.StrType)le.LNAME) + ' ' + TRIM((SALT33.StrType)le.NAME_SUFFIX)}],SALT33.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
END;
