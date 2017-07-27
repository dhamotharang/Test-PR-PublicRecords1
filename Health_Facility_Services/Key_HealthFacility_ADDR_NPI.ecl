EXPORT Key_HealthFacility_ADDR_NPI := MODULE
IMPORT SALT29,ut,std;
//NPI_NUMBER:?:ST:+:ADDR1:ZIP:V_CITY_NAME:FAC_NAME:TAXONOMY:TAXONOMY_CODE
EXPORT KeyName := Health_Facility_Services.Files.FILE_ADDR_NPI_SF; //'~'+'key::Health_Facility_Services::LNPID::Refs::ADDR_NPI';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
layout := RECORD // project out required fields
// Compulsory fields
  h.NPI_NUMBER;
// Optional fields
  h.ST;
  h.LNPID; // The ID field
// Extra credit fields
  h.PRIM_RANGE;
  h.SEC_RANGE;
  h.PRIM_NAME;
  h.ZIP;
  h.V_CITY_NAME;
  h.CNP_NAME;
  h.CNP_NUMBER;
  h.CNP_STORE_NUMBER;
  h.CNP_BTYPE;
  h.CNP_LOWV;
  h.TAXONOMY;
  h.TAXONOMY_CODE;
//Scores for various field components
  h.NPI_NUMBER_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_e1_Weight100;
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  h.PRIM_NAME_e1_Weight100;
  h.ZIP_weight100 ; // Contains 100x the specificity
  h.V_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.V_CITY_NAME_p_Weight100;
  h.V_CITY_NAME_e2_Weight100;
  h.V_CITY_NAME_e2p_Weight100;
  h.CNP_NAME_weight100 ; // Contains 100x the specificity
  h.CNP_NAME_FAC_NAME_weight100 ; // Contains 100x the specificity
  h.CNP_NAME_FAC_NAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.CNP_NUMBER_weight100 ; // Contains 100x the specificity
  h.CNP_NUMBER_FAC_NAME_weight100 ; // Contains 100x the specificity
  h.CNP_NUMBER_FAC_NAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.CNP_STORE_NUMBER_weight100 ; // Contains 100x the specificity
  h.CNP_STORE_NUMBER_FAC_NAME_weight100 ; // Contains 100x the specificity
  h.CNP_STORE_NUMBER_FAC_NAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.CNP_BTYPE_weight100 ; // Contains 100x the specificity
  h.CNP_BTYPE_FAC_NAME_weight100 ; // Contains 100x the specificity
  h.CNP_BTYPE_FAC_NAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.CNP_LOWV_weight100 ; // Contains 100x the specificity
  h.CNP_LOWV_FAC_NAME_weight100 ; // Contains 100x the specificity
  h.CNP_LOWV_FAC_NAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.TAXONOMY_weight100 ; // Contains 100x the specificity
  h.TAXONOMY_CODE_weight100 ; // Contains 100x the specificity
END;
s := Specificities(File_HealthFacility).Specificities[1];
DataForKey0 := DEDUP(SORT(TABLE(h(NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER)),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
EXPORT Key := INDEX(DataForKey0,,KeyName);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LNPID,NPI_NUMBER,ST,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_ADDR1 := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_RANGE,SEC_RANGE,PRIM_NAME), EXCEPT PRIM_RANGE,SEC_RANGE,PRIM_NAME));
  CntRed_ADDR1 := (KeyCnt-COUNT(Rem_ADDR1))/KeyCnt;
  Rem_ZIP := GROUP( DEDUP( SORT( Grpd, EXCEPT ZIP), EXCEPT ZIP));
  CntRed_ZIP := (KeyCnt-COUNT(Rem_ZIP))/KeyCnt;
  Rem_V_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT V_CITY_NAME), EXCEPT V_CITY_NAME));
  CntRed_V_CITY_NAME := (KeyCnt-COUNT(Rem_V_CITY_NAME))/KeyCnt;
  Rem_FAC_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT CNP_NAME,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV), EXCEPT CNP_NAME,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV));
  CntRed_FAC_NAME := (KeyCnt-COUNT(Rem_FAC_NAME))/KeyCnt;
  Rem_TAXONOMY := GROUP( DEDUP( SORT( Grpd, EXCEPT TAXONOMY), EXCEPT TAXONOMY));
  CntRed_TAXONOMY := (KeyCnt-COUNT(Rem_TAXONOMY))/KeyCnt;
  Rem_TAXONOMY_CODE := GROUP( DEDUP( SORT( Grpd, EXCEPT TAXONOMY_CODE), EXCEPT TAXONOMY_CODE));
  CntRed_TAXONOMY_CODE := (KeyCnt-COUNT(Rem_TAXONOMY_CODE))/KeyCnt;
EXPORT Shrinkage := DATASET([{'ADDR_NPI','ADDR1',CntRed_ADDR1*100,CntRed_ADDR1*TSize},{'ADDR_NPI','ZIP',CntRed_ZIP*100,CntRed_ZIP*TSize},{'ADDR_NPI','V_CITY_NAME',CntRed_V_CITY_NAME*100,CntRed_V_CITY_NAME*TSize},{'ADDR_NPI','FAC_NAME',CntRed_FAC_NAME*100,CntRed_FAC_NAME*TSize},{'ADDR_NPI','TAXONOMY',CntRed_TAXONOMY*100,CntRed_TAXONOMY*TSize},{'ADDR_NPI','TAXONOMY_CODE',CntRed_TAXONOMY_CODE*100,CntRed_TAXONOMY_CODE*TSize}],SALT29.ShrinkLayout);
EXPORT CanSearch(Process_xLNPID_Layouts.InputLayout le) := le.NPI_NUMBER <> (typeof(le.NPI_NUMBER))'';
KeyRec := RECORDOF(Key);
EXPORT RawFetch(TYPEOF(h.NPI_NUMBER) param_NPI_NUMBER,TYPEOF(h.ST) param_ST) := 
    STEPPED( LIMIT( Key(
          ( NPI_NUMBER = param_NPI_NUMBER AND param_NPI_NUMBER <> (TYPEOF(NPI_NUMBER))'' )
      AND ( ST = (TYPEOF(ST))'' OR param_ST = (TYPEOF(ST))'' OR ST = param_ST  )),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LNPID);
EXPORT ScoredLNPIDFetch(TYPEOF(h.NPI_NUMBER) param_NPI_NUMBER,TYPEOF(h.ST) param_ST,TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE,TYPEOF(h.SEC_RANGE) param_SEC_RANGE,TYPEOF(h.PRIM_NAME) param_PRIM_NAME,TYPEOF(h.ZIP) param_ZIP,TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME,TYPEOF(h.CNP_NAME) param_CNP_NAME,TYPEOF(h.CNP_NUMBER) param_CNP_NUMBER,TYPEOF(h.CNP_STORE_NUMBER) param_CNP_STORE_NUMBER,TYPEOF(h.CNP_BTYPE) param_CNP_BTYPE,TYPEOF(h.CNP_LOWV) param_CNP_LOWV,TYPEOF(h.TAXONOMY) param_TAXONOMY,TYPEOF(h.TAXONOMY_CODE) param_TAXONOMY_CODE) := FUNCTION
  RawData := RawFetch(param_NPI_NUMBER,param_ST);
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 15; // Set bitmap for key used
    SELF.keys_failed := IF(le.LNPID = 0, 1 << 15, 0); // Set bitmap for key failed
    SELF.NPI_NUMBER_match_code := MAP(
		le.NPI_NUMBER = (TYPEOF(le.NPI_NUMBER))'' OR le.NPI_NUMBER = (TYPEOF(le.NPI_NUMBER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_NPI_NUMBER(le.NPI_NUMBER,param_NPI_NUMBER,TRUE));
    SELF.NPI_NUMBERWeight := (50+MAP ( le.NPI_NUMBER = param_NPI_NUMBER  => le.NPI_NUMBER_weight100,
          le.NPI_NUMBER = (TYPEOF(le.NPI_NUMBER))'' OR param_NPI_NUMBER = (TYPEOF(le.NPI_NUMBER))'' => 0,
           -1.000*le.NPI_NUMBER_weight100))/100; 
    SELF.ST_match_code := MAP(
		le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP ( le.ST = param_ST  => le.ST_weight100,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => 0,
           -0.931*le.ST_weight100))/100; 
    SELF.PRIM_RANGE_match_code := MAP(
		le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_PRIM_RANGE(le.PRIM_RANGE,param_PRIM_RANGE,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP ( le.PRIM_RANGE = param_PRIM_RANGE  => le.PRIM_RANGE_weight100,
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => 0,
           SALT29.WithinEditN(le.PRIM_RANGE,param_PRIM_RANGE,1, 0) => le.PRIM_RANGE_e1_weight100,
           -0.794*le.PRIM_RANGE_weight100))/100; 
    SELF.SEC_RANGE_match_code := MAP(
		le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_SEC_RANGE(le.SEC_RANGE,param_SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = param_SEC_RANGE  => le.SEC_RANGE_weight100,
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => 0,
           SALT29.HyphenMatch(le.SEC_RANGE,param_SEC_RANGE,1)<=2 => le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(param_SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.937*le.SEC_RANGE_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(
		le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_PRIM_NAME(le.PRIM_NAME,param_PRIM_NAME,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = param_PRIM_NAME  => le.PRIM_NAME_weight100,
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' => 0,
           SALT29.WithinEditN(le.PRIM_NAME,param_PRIM_NAME,1, 0) => le.PRIM_NAME_e1_weight100,
           -0.715*le.PRIM_NAME_weight100))/100; 
    SELF.ADDR1_match_code := match_methods(File_HealthFacility).match_ADDR1(HASH32(le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME),HASH32(param_PRIM_RANGE,param_SEC_RANGE,param_PRIM_NAME));
    SELF.ZIP_match_code := MAP(
		le.ZIP = (TYPEOF(le.ZIP))'' OR param_ZIP = (TYPEOF(param_ZIP))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_ZIP(le.ZIP,param_ZIP,FALSE));
    SELF.ZIPWeight := (50+MAP ( le.ZIP = param_ZIP  => le.ZIP_weight100,
           le.ZIP = (TYPEOF(le.ZIP))'' OR param_ZIP = (TYPEOF(param_ZIP))'' => 0,
           -0.764*le.ZIP_weight100))/100; 
    SELF.V_CITY_NAME_match_code := MAP(
		le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR param_V_CITY_NAME = (TYPEOF(param_V_CITY_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_V_CITY_NAME(le.V_CITY_NAME,param_V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP ( le.V_CITY_NAME = param_V_CITY_NAME  => le.V_CITY_NAME_weight100,
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR param_V_CITY_NAME = (TYPEOF(param_V_CITY_NAME))'' => 0,
           SALT29.WithinEditN(le.V_CITY_NAME,param_V_CITY_NAME,2, 0) => IF( metaphonelib.DMetaPhone1(le.V_CITY_NAME)=metaphonelib.DMetaPhone1(param_V_CITY_NAME),le.V_CITY_NAME_e2p_weight100,le.V_CITY_NAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.V_CITY_NAME)=metaphonelib.DMetaPhone1(param_V_CITY_NAME)=>le.V_CITY_NAME_p_weight100,
           -0.813*le.V_CITY_NAME_weight100))/100; 
    SELF.CNP_NAME_match_code := MAP(
		le.CNP_NAME = (TYPEOF(le.CNP_NAME))'' OR param_CNP_NAME = (TYPEOF(param_CNP_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_CNP_NAME(le.CNP_NAME,param_CNP_NAME,FALSE));
    SELF.CNP_NAMEWeight := (50+MAP ( le.CNP_NAME = param_CNP_NAME  => le.CNP_NAME_weight100,
           le.CNP_NAME = (TYPEOF(le.CNP_NAME))'' OR param_CNP_NAME = (TYPEOF(param_CNP_NAME))'' => 0,
           SALT29.MatchBagOfWords(le.CNP_NAME,param_CNP_NAME,3407639,0)))/100; 
    SELF.CNP_NUMBER_match_code := MAP(
		le.CNP_NUMBER = (TYPEOF(le.CNP_NUMBER))'' OR param_CNP_NUMBER = (TYPEOF(param_CNP_NUMBER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_CNP_NUMBER(le.CNP_NUMBER,param_CNP_NUMBER,FALSE));
    SELF.CNP_NUMBERWeight := (50+MAP ( le.CNP_NUMBER = param_CNP_NUMBER  => le.CNP_NUMBER_weight100,
           le.CNP_NUMBER = (TYPEOF(le.CNP_NUMBER))'' OR param_CNP_NUMBER = (TYPEOF(param_CNP_NUMBER))'' => 0,
           -0.963*le.CNP_NUMBER_weight100))/100; 
    SELF.CNP_STORE_NUMBER_match_code := MAP(
		le.CNP_STORE_NUMBER = (TYPEOF(le.CNP_STORE_NUMBER))'' OR param_CNP_STORE_NUMBER = (TYPEOF(param_CNP_STORE_NUMBER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_CNP_STORE_NUMBER(le.CNP_STORE_NUMBER,param_CNP_STORE_NUMBER,FALSE));
    SELF.CNP_STORE_NUMBERWeight := (50+MAP ( le.CNP_STORE_NUMBER = param_CNP_STORE_NUMBER  => le.CNP_STORE_NUMBER_weight100,
           le.CNP_STORE_NUMBER = (TYPEOF(le.CNP_STORE_NUMBER))'' OR param_CNP_STORE_NUMBER = (TYPEOF(param_CNP_STORE_NUMBER))'' => 0,
           -0.956*le.CNP_STORE_NUMBER_weight100))/100; 
    SELF.CNP_BTYPE_match_code := MAP(
		le.CNP_BTYPE = (TYPEOF(le.CNP_BTYPE))'' OR param_CNP_BTYPE = (TYPEOF(param_CNP_BTYPE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_CNP_BTYPE(le.CNP_BTYPE,param_CNP_BTYPE,FALSE));
    SELF.CNP_BTYPEWeight := (50+MAP ( le.CNP_BTYPE = param_CNP_BTYPE  => le.CNP_BTYPE_weight100,
           le.CNP_BTYPE = (TYPEOF(le.CNP_BTYPE))'' OR param_CNP_BTYPE = (TYPEOF(param_CNP_BTYPE))'' => 0,
           -0.979*le.CNP_BTYPE_weight100))/100; 
    SELF.CNP_LOWV_match_code := MAP(
		le.CNP_LOWV = (TYPEOF(le.CNP_LOWV))'' OR param_CNP_LOWV = (TYPEOF(param_CNP_LOWV))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_CNP_LOWV(le.CNP_LOWV,param_CNP_LOWV,FALSE));
    SELF.CNP_LOWVWeight := (50+MAP ( le.CNP_LOWV = param_CNP_LOWV  => le.CNP_LOWV_weight100,
           le.CNP_LOWV = (TYPEOF(le.CNP_LOWV))'' OR param_CNP_LOWV = (TYPEOF(param_CNP_LOWV))'' => 0,
           -0.972*le.CNP_LOWV_weight100))/100; 
    SELF.FAC_NAME_match_code := match_methods(File_HealthFacility).match_FAC_NAME(HASH32(le.CNP_NAME,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV),HASH32(param_CNP_NAME,param_CNP_NUMBER,param_CNP_STORE_NUMBER,param_CNP_BTYPE,param_CNP_LOWV),(SALT29.StrType)le.CNP_NAME,le.CNP_NAME_FAC_NAME_weight100,true,0,true,1,(SALT29.StrType)le.CNP_NUMBER,le.CNP_NUMBER_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_STORE_NUMBER,le.CNP_STORE_NUMBER_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_BTYPE,le.CNP_BTYPE_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_LOWV,le.CNP_LOWV_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)param_CNP_NAME,0,(SALT29.StrType)param_CNP_NUMBER,0,(SALT29.StrType)param_CNP_STORE_NUMBER,0,(SALT29.StrType)param_CNP_BTYPE,0,(SALT29.StrType)param_CNP_LOWV,0);
    SELF.FAC_NAMEWeight := (50+MAP(HASH32(le.CNP_NAME,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV)=HASH32(param_CNP_NAME,param_CNP_NUMBER,param_CNP_STORE_NUMBER,param_CNP_BTYPE,param_CNP_LOWV) => le.CNP_NAME_weight100+le.CNP_NUMBER_weight100+le.CNP_STORE_NUMBER_weight100+le.CNP_BTYPE_weight100+le.CNP_LOWV_weight100,
           SALT29.fn_concept_wordbag_EditN.Match5((SALT29.StrType)le.CNP_NAME,le.CNP_NAME_FAC_NAME_weight100,true,0,true,1,(SALT29.StrType)le.CNP_NUMBER,le.CNP_NUMBER_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_STORE_NUMBER,le.CNP_STORE_NUMBER_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_BTYPE,le.CNP_BTYPE_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_LOWV,le.CNP_LOWV_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)param_CNP_NAME,0,(SALT29.StrType)param_CNP_NUMBER,0,(SALT29.StrType)param_CNP_STORE_NUMBER,0,(SALT29.StrType)param_CNP_BTYPE,0,(SALT29.StrType)param_CNP_LOWV,0)))/100; //Concept could score even if fields do not
    SELF.TAXONOMY_match_code := MAP(
		le.TAXONOMY = (TYPEOF(le.TAXONOMY))'' OR param_TAXONOMY = (TYPEOF(param_TAXONOMY))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_TAXONOMY(le.TAXONOMY,param_TAXONOMY,FALSE));
    SELF.TAXONOMYWeight := (50+MAP ( le.TAXONOMY = param_TAXONOMY  => le.TAXONOMY_weight100,
           le.TAXONOMY = (TYPEOF(le.TAXONOMY))'' OR param_TAXONOMY = (TYPEOF(param_TAXONOMY))'' => 0,
           -0.939*le.TAXONOMY_weight100))/100; 
    SELF.TAXONOMY_CODE_match_code := MAP(
		le.TAXONOMY_CODE = (TYPEOF(le.TAXONOMY_CODE))'' OR param_TAXONOMY_CODE = (TYPEOF(param_TAXONOMY_CODE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_TAXONOMY_CODE(le.TAXONOMY_CODE,param_TAXONOMY_CODE,FALSE));
    SELF.TAXONOMY_CODEWeight := (50+MAP ( le.TAXONOMY_CODE = param_TAXONOMY_CODE  => le.TAXONOMY_CODE_weight100,
           le.TAXONOMY_CODE = (TYPEOF(le.TAXONOMY_CODE))'' OR param_TAXONOMY_CODE = (TYPEOF(param_TAXONOMY_CODE))'' => 0,
           -0.990*le.TAXONOMY_CODE_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.NPI_NUMBERWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(self.FAC_NAMEWeight,MAX(0,SELF.CNP_NAMEWeight) + MAX(0,SELF.CNP_NUMBERWeight) + MAX(0,SELF.CNP_STORE_NUMBERWeight) + MAX(0,SELF.CNP_BTYPEWeight) + MAX(0,SELF.CNP_LOWVWeight)) + MAX(0,SELF.TAXONOMYWeight) + MAX(0,SELF.TAXONOMY_CODEWeight);
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.LNPID = RIGHT.LNPID,Process_xLNPID_Layouts.combine_scores(LEFT,RIGHT));
END;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT29.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.NPI_NUMBER) NPI_NUMBER := (TYPEOF(h.NPI_NUMBER))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  SALT29.StrType ADDR1 := (SALT29.StrType)'';
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  TYPEOF(h.V_CITY_NAME) V_CITY_NAME := (TYPEOF(h.V_CITY_NAME))'';
  SALT29.StrType FAC_NAME := (SALT29.StrType)'';
  TYPEOF(h.CNP_NAME) CNP_NAME := (TYPEOF(h.CNP_NAME))'';
  TYPEOF(h.CNP_NUMBER) CNP_NUMBER := (TYPEOF(h.CNP_NUMBER))'';
  TYPEOF(h.CNP_STORE_NUMBER) CNP_STORE_NUMBER := (TYPEOF(h.CNP_STORE_NUMBER))'';
  TYPEOF(h.CNP_BTYPE) CNP_BTYPE := (TYPEOF(h.CNP_BTYPE))'';
  TYPEOF(h.CNP_LOWV) CNP_LOWV := (TYPEOF(h.CNP_LOWV))'';
  TYPEOF(h.TAXONOMY) TAXONOMY := (TYPEOF(h.TAXONOMY))'';
  TYPEOF(h.TAXONOMY_CODE) TAXONOMY_CODE := (TYPEOF(h.TAXONOMY_CODE))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xLNPID_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 15; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.NPI_NUMBER_match_code := MAP(
		le.NPI_NUMBER = (TYPEOF(le.NPI_NUMBER))'' OR le.NPI_NUMBER = (TYPEOF(le.NPI_NUMBER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_NPI_NUMBER(le.NPI_NUMBER,ri.NPI_NUMBER,TRUE));
    SELF.NPI_NUMBERWeight := (50+MAP ( le.NPI_NUMBER = ri.NPI_NUMBER  => le.NPI_NUMBER_weight100,
          le.NPI_NUMBER = (TYPEOF(le.NPI_NUMBER))'' OR ri.NPI_NUMBER = (TYPEOF(le.NPI_NUMBER))'' => 0,
           -1.000*le.NPI_NUMBER_weight100))/100; 
    SELF.ST_match_code := MAP(
		le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP ( le.ST = ri.ST  => le.ST_weight100,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => 0,
           -0.931*le.ST_weight100))/100; 
    SELF.PRIM_RANGE_match_code := MAP(
		le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP ( le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => 0,
           SALT29.WithinEditN(le.PRIM_RANGE,ri.PRIM_RANGE,1, 0) => le.PRIM_RANGE_e1_weight100,
           -0.794*le.PRIM_RANGE_weight100))/100; 
    SELF.SEC_RANGE_match_code := MAP(
		le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => 0,
           SALT29.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2 => le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(ri.SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.937*le.SEC_RANGE_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(
		le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => 0,
           SALT29.WithinEditN(le.PRIM_NAME,ri.PRIM_NAME,1, 0) => le.PRIM_NAME_e1_weight100,
           -0.715*le.PRIM_NAME_weight100))/100; 
    SELF.ADDR1_match_code := match_methods(File_HealthFacility).match_ADDR1(HASH32(le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME),HASH32(ri.PRIM_RANGE,ri.SEC_RANGE,ri.PRIM_NAME));
    SELF.ZIP_match_code := MAP(
		le.ZIP = (TYPEOF(le.ZIP))'' OR ri.ZIP = (TYPEOF(ri.ZIP))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_ZIP(le.ZIP,ri.ZIP,FALSE));
    SELF.ZIPWeight := (50+MAP ( le.ZIP = ri.ZIP  => le.ZIP_weight100,
           le.ZIP = (TYPEOF(le.ZIP))'' OR ri.ZIP = (TYPEOF(ri.ZIP))'' => 0,
           -0.764*le.ZIP_weight100))/100; 
    SELF.V_CITY_NAME_match_code := MAP(
		le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR ri.V_CITY_NAME = (TYPEOF(ri.V_CITY_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_V_CITY_NAME(le.V_CITY_NAME,ri.V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP ( le.V_CITY_NAME = ri.V_CITY_NAME  => le.V_CITY_NAME_weight100,
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR ri.V_CITY_NAME = (TYPEOF(ri.V_CITY_NAME))'' => 0,
           SALT29.WithinEditN(le.V_CITY_NAME,ri.V_CITY_NAME,2, 0) => IF( metaphonelib.DMetaPhone1(le.V_CITY_NAME)=metaphonelib.DMetaPhone1(ri.V_CITY_NAME),le.V_CITY_NAME_e2p_weight100,le.V_CITY_NAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.V_CITY_NAME)=metaphonelib.DMetaPhone1(ri.V_CITY_NAME)=>le.V_CITY_NAME_p_weight100,
           -0.813*le.V_CITY_NAME_weight100))/100; 
    SELF.CNP_NAME_match_code := MAP(
		le.CNP_NAME = (TYPEOF(le.CNP_NAME))'' OR ri.CNP_NAME = (TYPEOF(ri.CNP_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_CNP_NAME(le.CNP_NAME,ri.CNP_NAME,FALSE));
    SELF.CNP_NAMEWeight := (50+MAP ( le.CNP_NAME = ri.CNP_NAME  => le.CNP_NAME_weight100,
           le.CNP_NAME = (TYPEOF(le.CNP_NAME))'' OR ri.CNP_NAME = (TYPEOF(ri.CNP_NAME))'' => 0,
           SALT29.MatchBagOfWords(le.CNP_NAME,ri.CNP_NAME,3407639,0)))/100; 
    SELF.CNP_NUMBER_match_code := MAP(
		le.CNP_NUMBER = (TYPEOF(le.CNP_NUMBER))'' OR ri.CNP_NUMBER = (TYPEOF(ri.CNP_NUMBER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_CNP_NUMBER(le.CNP_NUMBER,ri.CNP_NUMBER,FALSE));
    SELF.CNP_NUMBERWeight := (50+MAP ( le.CNP_NUMBER = ri.CNP_NUMBER  => le.CNP_NUMBER_weight100,
           le.CNP_NUMBER = (TYPEOF(le.CNP_NUMBER))'' OR ri.CNP_NUMBER = (TYPEOF(ri.CNP_NUMBER))'' => 0,
           -0.963*le.CNP_NUMBER_weight100))/100; 
    SELF.CNP_STORE_NUMBER_match_code := MAP(
		le.CNP_STORE_NUMBER = (TYPEOF(le.CNP_STORE_NUMBER))'' OR ri.CNP_STORE_NUMBER = (TYPEOF(ri.CNP_STORE_NUMBER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_CNP_STORE_NUMBER(le.CNP_STORE_NUMBER,ri.CNP_STORE_NUMBER,FALSE));
    SELF.CNP_STORE_NUMBERWeight := (50+MAP ( le.CNP_STORE_NUMBER = ri.CNP_STORE_NUMBER  => le.CNP_STORE_NUMBER_weight100,
           le.CNP_STORE_NUMBER = (TYPEOF(le.CNP_STORE_NUMBER))'' OR ri.CNP_STORE_NUMBER = (TYPEOF(ri.CNP_STORE_NUMBER))'' => 0,
           -0.956*le.CNP_STORE_NUMBER_weight100))/100; 
    SELF.CNP_BTYPE_match_code := MAP(
		le.CNP_BTYPE = (TYPEOF(le.CNP_BTYPE))'' OR ri.CNP_BTYPE = (TYPEOF(ri.CNP_BTYPE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_CNP_BTYPE(le.CNP_BTYPE,ri.CNP_BTYPE,FALSE));
    SELF.CNP_BTYPEWeight := (50+MAP ( le.CNP_BTYPE = ri.CNP_BTYPE  => le.CNP_BTYPE_weight100,
           le.CNP_BTYPE = (TYPEOF(le.CNP_BTYPE))'' OR ri.CNP_BTYPE = (TYPEOF(ri.CNP_BTYPE))'' => 0,
           -0.979*le.CNP_BTYPE_weight100))/100; 
    SELF.CNP_LOWV_match_code := MAP(
		le.CNP_LOWV = (TYPEOF(le.CNP_LOWV))'' OR ri.CNP_LOWV = (TYPEOF(ri.CNP_LOWV))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_CNP_LOWV(le.CNP_LOWV,ri.CNP_LOWV,FALSE));
    SELF.CNP_LOWVWeight := (50+MAP ( le.CNP_LOWV = ri.CNP_LOWV  => le.CNP_LOWV_weight100,
           le.CNP_LOWV = (TYPEOF(le.CNP_LOWV))'' OR ri.CNP_LOWV = (TYPEOF(ri.CNP_LOWV))'' => 0,
           -0.972*le.CNP_LOWV_weight100))/100; 
    SELF.FAC_NAME_match_code := match_methods(File_HealthFacility).match_FAC_NAME(HASH32(le.CNP_NAME,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV),HASH32(ri.CNP_NAME,ri.CNP_NUMBER,ri.CNP_STORE_NUMBER,ri.CNP_BTYPE,ri.CNP_LOWV),(SALT29.StrType)le.CNP_NAME,le.CNP_NAME_FAC_NAME_weight100,true,0,true,1,(SALT29.StrType)le.CNP_NUMBER,le.CNP_NUMBER_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_STORE_NUMBER,le.CNP_STORE_NUMBER_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_BTYPE,le.CNP_BTYPE_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_LOWV,le.CNP_LOWV_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)ri.CNP_NAME,0,(SALT29.StrType)ri.CNP_NUMBER,0,(SALT29.StrType)ri.CNP_STORE_NUMBER,0,(SALT29.StrType)ri.CNP_BTYPE,0,(SALT29.StrType)ri.CNP_LOWV,0);
    SELF.FAC_NAMEWeight := (50+MAP(HASH32(le.CNP_NAME,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV)=HASH32(ri.CNP_NAME,ri.CNP_NUMBER,ri.CNP_STORE_NUMBER,ri.CNP_BTYPE,ri.CNP_LOWV) => le.CNP_NAME_weight100+le.CNP_NUMBER_weight100+le.CNP_STORE_NUMBER_weight100+le.CNP_BTYPE_weight100+le.CNP_LOWV_weight100,
           SALT29.fn_concept_wordbag_EditN.Match5((SALT29.StrType)le.CNP_NAME,le.CNP_NAME_FAC_NAME_weight100,true,0,true,1,(SALT29.StrType)le.CNP_NUMBER,le.CNP_NUMBER_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_STORE_NUMBER,le.CNP_STORE_NUMBER_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_BTYPE,le.CNP_BTYPE_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)le.CNP_LOWV,le.CNP_LOWV_FAC_NAME_weight100,true,0,false,0,(SALT29.StrType)ri.CNP_NAME,0,(SALT29.StrType)ri.CNP_NUMBER,0,(SALT29.StrType)ri.CNP_STORE_NUMBER,0,(SALT29.StrType)ri.CNP_BTYPE,0,(SALT29.StrType)ri.CNP_LOWV,0)))/100; //Concept could score even if fields do not
    SELF.TAXONOMY_match_code := MAP(
		le.TAXONOMY = (TYPEOF(le.TAXONOMY))'' OR ri.TAXONOMY = (TYPEOF(ri.TAXONOMY))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_TAXONOMY(le.TAXONOMY,ri.TAXONOMY,FALSE));
    SELF.TAXONOMYWeight := (50+MAP ( le.TAXONOMY = ri.TAXONOMY  => le.TAXONOMY_weight100,
           le.TAXONOMY = (TYPEOF(le.TAXONOMY))'' OR ri.TAXONOMY = (TYPEOF(ri.TAXONOMY))'' => 0,
           -0.939*le.TAXONOMY_weight100))/100; 
    SELF.TAXONOMY_CODE_match_code := MAP(
		le.TAXONOMY_CODE = (TYPEOF(le.TAXONOMY_CODE))'' OR ri.TAXONOMY_CODE = (TYPEOF(ri.TAXONOMY_CODE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthFacility).match_TAXONOMY_CODE(le.TAXONOMY_CODE,ri.TAXONOMY_CODE,FALSE));
    SELF.TAXONOMY_CODEWeight := (50+MAP ( le.TAXONOMY_CODE = ri.TAXONOMY_CODE  => le.TAXONOMY_CODE_weight100,
           le.TAXONOMY_CODE = (TYPEOF(le.TAXONOMY_CODE))'' OR ri.TAXONOMY_CODE = (TYPEOF(ri.TAXONOMY_CODE))'' => 0,
           -0.990*le.TAXONOMY_CODE_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.NPI_NUMBERWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(self.FAC_NAMEWeight,MAX(0,SELF.CNP_NAMEWeight) + MAX(0,SELF.CNP_NUMBERWeight) + MAX(0,SELF.CNP_STORE_NUMBERWeight) + MAX(0,SELF.CNP_BTYPEWeight) + MAX(0,SELF.CNP_LOWVWeight)) + MAX(0,SELF.TAXONOMYWeight) + MAX(0,SELF.TAXONOMY_CODEWeight);
    SELF := le;
  END;
  Recs0 := Recs(NPI_NUMBER <> (typeof(NPI_NUMBER))'');
  SALT29.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER
     AND ( LEFT.ST = (TYPEOF(LEFT.ST))'' OR RIGHT.ST = (TYPEOF(RIGHT.ST))'' OR LEFT.ST = RIGHT.ST  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,10000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER
     AND ( LEFT.ST = (TYPEOF(LEFT.ST))'' OR RIGHT.ST = (TYPEOF(RIGHT.ST))'' OR LEFT.ST = RIGHT.ST  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,10000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_xLNPID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT29.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_NPI_NUMBER='',Input_ST='',Input_PRIM_RANGE='',Input_SEC_RANGE='',Input_PRIM_NAME='',Input_ZIP='',Input_V_CITY_NAME='',Input_CNP_NAME='',Input_CNP_NUMBER='',Input_CNP_STORE_NUMBER='',Input_CNP_BTYPE='',Input_CNP_LOWV='',Input_TAXONOMY='',Input_TAXONOMY_CODE='',output_file,AsIndex='true') := MACRO
IMPORT SALT29,Health_Facility_Services;
#IF(#TEXT(Input_NPI_NUMBER)<>'')
  #uniquename(trans)
  Health_Facility_Services.Key_HealthFacility_ADDR_NPI.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.NPI_NUMBER := (TYPEOF(SELF.NPI_NUMBER))le.Input_NPI_NUMBER;
    #IF ( #TEXT(Input_ST) <> '' )
      SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #END
    #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
      SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
    #END
    #IF ( #TEXT(Input_SEC_RANGE) <> '' )
      SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
    #END
    #IF ( #TEXT(Input_PRIM_NAME) <> '' )
      SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
    #END
    #IF ( #TEXT(Input_ZIP) <> '' )
      SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
    #END
    #IF ( #TEXT(Input_V_CITY_NAME) <> '' )
      SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))le.Input_V_CITY_NAME;
    #END
    #IF ( #TEXT(Input_CNP_NAME) <> '' )
      SELF.CNP_NAME := (TYPEOF(SELF.CNP_NAME))le.Input_CNP_NAME;
    #END
    #IF ( #TEXT(Input_CNP_NUMBER) <> '' )
      SELF.CNP_NUMBER := (TYPEOF(SELF.CNP_NUMBER))le.Input_CNP_NUMBER;
    #END
    #IF ( #TEXT(Input_CNP_STORE_NUMBER) <> '' )
      SELF.CNP_STORE_NUMBER := (TYPEOF(SELF.CNP_STORE_NUMBER))le.Input_CNP_STORE_NUMBER;
    #END
    #IF ( #TEXT(Input_CNP_BTYPE) <> '' )
      SELF.CNP_BTYPE := (TYPEOF(SELF.CNP_BTYPE))le.Input_CNP_BTYPE;
    #END
    #IF ( #TEXT(Input_CNP_LOWV) <> '' )
      SELF.CNP_LOWV := (TYPEOF(SELF.CNP_LOWV))le.Input_CNP_LOWV;
    #END
    #IF ( #TEXT(Input_TAXONOMY) <> '' )
      SELF.TAXONOMY := (TYPEOF(SELF.TAXONOMY))le.Input_TAXONOMY;
    #END
    #IF ( #TEXT(Input_TAXONOMY_CODE) <> '' )
      SELF.TAXONOMY_CODE := (TYPEOF(SELF.TAXONOMY_CODE))le.Input_TAXONOMY_CODE;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := Health_Facility_Services.Key_HealthFacility_ADDR_NPI.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],Health_Facility_Services.Process_xLNPID_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
