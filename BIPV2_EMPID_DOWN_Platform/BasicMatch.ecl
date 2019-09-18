IMPORT SALT32,ut;
EXPORT BasicMatch(DATASET(layout_EmpID) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := Specificities(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00( 
      0 + IF( orgid  IN SET(s.nulls_orgid,orgid) OR orgid = (TYPEOF(orgid))'', 0, 26 ) + IF( fname  IN SET(s.nulls_fname,fname) OR fname = (TYPEOF(fname))'', 0, 8 ) + IF( mname  IN SET(s.nulls_mname,mname) OR mname = (TYPEOF(mname))'', 0, 9 ) + IF( lname  IN SET(s.nulls_lname,lname) OR lname = (TYPEOF(lname))'', 0, 10 ) + IF( name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR name_suffix = (TYPEOF(name_suffix))'', 0, 8 ) + IF( contact_did  IN SET(s.nulls_contact_did,contact_did) OR contact_did = (TYPEOF(contact_did))'', 0, 26 ) + IF( contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR contact_ssn = (TYPEOF(contact_ssn))'', 0, 27 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.EmpID=RIGHT.EmpID,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT32.UIDType EmpID1;
    SALT32.UIDType EmpID2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,SALT_Partition,orgid,fname,mname,lname,name_suffix,contact_did,contact_ssn,EmpID);
  h02 := DEDUP(h01,SALT_Partition,orgid,fname,mname,lname,name_suffix,contact_did,contact_ssn,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.orgid = RIGHT.orgid AND LEFT.fname = RIGHT.fname AND LEFT.mname = RIGHT.mname AND LEFT.lname = RIGHT.lname AND LEFT.name_suffix = RIGHT.name_suffix
       AND LEFT.contact_did = RIGHT.contact_did AND LEFT.contact_ssn = RIGHT.contact_ssn AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition ) AND LEFT.EmpID < RIGHT.EmpID,TRANSFORM(Rec,SELF.EmpID2 := LEFT.EmpID,SELF.EmpID1 := RIGHT.EmpID), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(EmpID1) ), EmpID1, EmpID2, LOCAL), EmpID1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,EmpID,PickOne,EmpID1,EmpID2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,EmpID,ALL))-COUNT(DEDUP(input_file,EmpID,ALL)); // Should equal basic_match_count
END;
