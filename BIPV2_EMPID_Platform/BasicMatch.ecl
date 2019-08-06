﻿IMPORT SALT30,ut;
EXPORT BasicMatch(DATASET(layout_EmpID) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := Specificities(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00( 
      0 + IF( cname_devanitize  IN SET(s.nulls_cname_devanitize,cname_devanitize), 0, 20 ) + IF( prim_range  IN SET(s.nulls_prim_range,prim_range), 0, 13 ) + IF( prim_name  IN SET(s.nulls_prim_name,prim_name), 0, 15 ) + IF( zip  IN SET(s.nulls_zip,zip), 0, 14 ) + IF( fname  IN SET(s.nulls_fname,fname), 0, 8 ) + IF( lname  IN SET(s.nulls_lname,lname), 0, 15 ) + IF( contact_phone  IN SET(s.nulls_contact_phone,contact_phone), 0, 24 ) + IF( contact_did  IN SET(s.nulls_contact_did,contact_did), 0, 24 ) + IF( contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn), 0, 4 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.EmpID=RIGHT.EmpID,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT30.UIDType EmpID1;
    SALT30.UIDType EmpID2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,SALT_Partition,cname_devanitize,prim_range,prim_name,zip,fname,lname,contact_phone,contact_did,contact_ssn,EmpID);
  h02 := DEDUP(h01,SALT_Partition,cname_devanitize,prim_range,prim_name,zip,fname,lname,contact_phone,contact_did,contact_ssn,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.cname_devanitize = RIGHT.cname_devanitize AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.zip = RIGHT.zip AND LEFT.fname = RIGHT.fname
       AND LEFT.lname = RIGHT.lname AND LEFT.contact_phone = RIGHT.contact_phone AND LEFT.contact_did = RIGHT.contact_did AND LEFT.contact_ssn = RIGHT.contact_ssn AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition ) AND LEFT.EmpID < RIGHT.EmpID,TRANSFORM(Rec,SELF.EmpID2 := LEFT.EmpID,SELF.EmpID1 := RIGHT.EmpID), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(EmpID1) ), EmpID1, EmpID2, LOCAL), EmpID1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,EmpID,PickOne,EmpID1,EmpID2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,EmpID,ALL))-COUNT(DEDUP(input_file,EmpID,ALL)); // Should equal basic_match_count
END;
