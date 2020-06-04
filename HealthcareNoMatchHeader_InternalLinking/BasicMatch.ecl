/*HACK-O-MATIC*/IMPORT SALT311,STD;
/*HACK-O-MATIC*/EXPORT BasicMatch(STRING pSrc, STRING pVersion =  (STRING)STD.Date.Today(), DATASET(layout_HEADER) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/Specificities(pSrc,pVersion,ih).input_file;
  SHARED s := /*HACK-O-MATIC*/Specificities(pSrc,pVersion,ih).specificities[1];
  SHARED h00_match := h00( 
      0 + IF( (SSN  IN SET(s.nulls_SSN,SSN) OR SSN = (TYPEOF(SSN))''), 0, 0 ) + IF( DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND DOB_day  IN SET(s.nulls_DOB_day,DOB_day), 0, 0 ) + IF( (LEXID  IN SET(s.nulls_LEXID,LEXID) OR LEXID = (TYPEOF(LEXID))''), 0, 18 ) + IF( (SUFFIX  IN SET(s.nulls_SUFFIX,SUFFIX) OR SUFFIX = (TYPEOF(SUFFIX))''), 0, 10 ) + IF( (FNAME  IN SET(s.nulls_FNAME,FNAME) OR FNAME = (TYPEOF(FNAME))''), 0, 8 ) + IF( (MNAME  IN SET(s.nulls_MNAME,MNAME) OR MNAME = (TYPEOF(MNAME))''), 0, 14 ) + IF( (LNAME  IN SET(s.nulls_LNAME,LNAME) OR LNAME = (TYPEOF(LNAME))''), 0, 10 ) + IF( (GENDER  IN SET(s.nulls_GENDER,GENDER) OR GENDER = (TYPEOF(GENDER))''), 0, 1 ) + IF( (PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR PRIM_NAME = (TYPEOF(PRIM_NAME))''), 0, 10 ) + IF( (PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR PRIM_RANGE = (TYPEOF(PRIM_RANGE))''), 0, 13 ) + IF( (SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR SEC_RANGE = (TYPEOF(SEC_RANGE))''), 0, 8 ) + IF( (CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR CITY_NAME = (TYPEOF(CITY_NAME))''), 0, 6 ) + IF( (ST  IN SET(s.nulls_ST,ST) OR ST = (TYPEOF(ST))''), 0, 0 ) + IF( (ZIP  IN SET(s.nulls_ZIP,ZIP) OR ZIP = (TYPEOF(ZIP))''), 0, 6 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,/*HACK-O-MATIC*/Specificities(pSrc,pVersion,ih).ClusterSizes(InCluster=1),LEFT.nomatch_id=RIGHT.nomatch_id,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT311.UIDType nomatch_id1;
    SALT311.UIDType nomatch_id2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,SSN,DOB_year,DOB_month,DOB_day,LEXID,SUFFIX,FNAME,MNAME,LNAME,GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY_NAME,ST,ZIP,nomatch_id);
  h02 := DEDUP(h01,SSN,DOB_year,DOB_month,DOB_day,LEXID,SUFFIX,FNAME,MNAME,LNAME,GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY_NAME,ST,ZIP,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.SSN = RIGHT.SSN AND LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day AND LEFT.LEXID = RIGHT.LEXID AND LEFT.SUFFIX = RIGHT.SUFFIX AND LEFT.FNAME = RIGHT.FNAME
       AND LEFT.MNAME = RIGHT.MNAME AND LEFT.LNAME = RIGHT.LNAME AND LEFT.GENDER = RIGHT.GENDER AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
       AND LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND LEFT.CITY_NAME = RIGHT.CITY_NAME AND LEFT.ST = RIGHT.ST AND LEFT.ZIP = RIGHT.ZIP AND LEFT.MAINNAME = RIGHT.MAINNAME
       AND LEFT.ADDR1 = RIGHT.ADDR1 AND LEFT.LOCALE = RIGHT.LOCALE AND LEFT.ADDRESS = RIGHT.ADDRESS AND LEFT.FULLNAME = RIGHT.FULLNAME AND LEFT.nomatch_id < RIGHT.nomatch_id,TRANSFORM(Rec,SELF.nomatch_id2 := LEFT.nomatch_id,SELF.nomatch_id1 := RIGHT.nomatch_id), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(nomatch_id1) ), nomatch_id1, nomatch_id2, LOCAL), nomatch_id1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  SALT311.utMAC_Patch_Id(h00,nomatch_id,PickOne,nomatch_id1,nomatch_id2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,nomatch_id,ALL))-COUNT(DEDUP(input_file,nomatch_id,ALL)); // Should equal basic_match_count
END;
