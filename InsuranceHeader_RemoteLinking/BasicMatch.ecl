﻿IMPORT SALT37;
EXPORT BasicMatch(DATASET(layout_HEADER) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := InsuranceHeader_RemoteLinking.Specificities(ih).input_file_np;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00( 
      0 + IF( (SSN  IN SET(s.nulls_SSN,SSN) OR SSN = (TYPEOF(SSN))''), 0, 28 ) + IF( DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND DOB_day  IN SET(s.nulls_DOB_day,DOB_day), 0, 15 ) + IF( (DL_NBR  IN SET(s.nulls_DL_NBR,DL_NBR) OR DL_NBR = (TYPEOF(DL_NBR))''), 0, 26 ) + IF( (SNAME  IN SET(s.nulls_SNAME,SNAME) OR SNAME = (TYPEOF(SNAME))''), 0, 2 ) + IF( (FNAME  IN SET(s.nulls_FNAME,FNAME) OR FNAME = (TYPEOF(FNAME))''), 0, 9 ) + IF( (MNAME  IN SET(s.nulls_MNAME,MNAME) OR MNAME = (TYPEOF(MNAME))''), 0, 6 ) + IF( (LNAME  IN SET(s.nulls_LNAME,LNAME) OR LNAME = (TYPEOF(LNAME))''), 0, 11 ) + IF( (GENDER  IN SET(s.nulls_GENDER,GENDER) OR GENDER = (TYPEOF(GENDER))''), 0, 1 ) + IF( (DERIVED_GENDER  IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER) OR DERIVED_GENDER = (TYPEOF(DERIVED_GENDER))''), 0, 1 ) + IF( (PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR PRIM_NAME = (TYPEOF(PRIM_NAME))''), 0, 12 ) + IF( (PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR PRIM_RANGE = (TYPEOF(PRIM_RANGE))''), 0, 11 ) + IF( (SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR SEC_RANGE = (TYPEOF(SEC_RANGE))''), 0, 8 ) + IF( (CITY  IN SET(s.nulls_CITY,CITY) OR CITY = (TYPEOF(CITY))''), 0, 10 ) + IF( (ST  IN SET(s.nulls_ST,ST) OR ST = (TYPEOF(ST))''), 0, 5 ) + IF( (ZIP  IN SET(s.nulls_ZIP,ZIP) OR ZIP = (TYPEOF(ZIP))''), 0, 14 ) + IF( (POLICY_NUMBER  IN SET(s.nulls_POLICY_NUMBER,POLICY_NUMBER) OR POLICY_NUMBER = (TYPEOF(POLICY_NUMBER))''), 0, 28 ) + IF( (CLAIM_NUMBER  IN SET(s.nulls_CLAIM_NUMBER,CLAIM_NUMBER) OR CLAIM_NUMBER = (TYPEOF(CLAIM_NUMBER))''), 0, 28 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.DID=RIGHT.DID,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT37.UIDType DID1;
    SALT37.UIDType DID2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,SSN,DOB_year,DOB_month,DOB_day,DL_NBR,SNAME,FNAME,MNAME,LNAME,GENDER,DERIVED_GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY,ST,ZIP,POLICY_NUMBER,CLAIM_NUMBER,DID);
  h02 := DEDUP(h01,SSN,DOB_year,DOB_month,DOB_day,DL_NBR,SNAME,FNAME,MNAME,LNAME,GENDER,DERIVED_GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY,ST,ZIP,POLICY_NUMBER,CLAIM_NUMBER,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.SSN = RIGHT.SSN AND LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day AND LEFT.DL_NBR = RIGHT.DL_NBR AND LEFT.DL_STATE = RIGHT.DL_STATE AND LEFT.SNAME = RIGHT.SNAME AND LEFT.FNAME = RIGHT.FNAME
       AND LEFT.MNAME = RIGHT.MNAME AND LEFT.LNAME = RIGHT.LNAME AND LEFT.GENDER = RIGHT.GENDER AND LEFT.DERIVED_GENDER = RIGHT.DERIVED_GENDER AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
       AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND LEFT.CITY = RIGHT.CITY AND LEFT.ST = RIGHT.ST AND LEFT.ZIP = RIGHT.ZIP
       AND LEFT.POLICY_NUMBER = RIGHT.POLICY_NUMBER AND LEFT.AMBEST = RIGHT.AMBEST AND LEFT.CLAIM_NUMBER = RIGHT.CLAIM_NUMBER AND LEFT.AMBEST = RIGHT.AMBEST AND LEFT.DID < RIGHT.DID,TRANSFORM(Rec,SELF.DID2 := LEFT.DID,SELF.DID1 := RIGHT.DID), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(DID1) ), DID1, DID2, LOCAL), DID1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  SALT37.utMAC_Patch_Id(h00,DID,PickOne,DID1,DID2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,DID,ALL))-COUNT(DEDUP(input_file,DID,ALL)); // Should equal basic_match_count
END;
