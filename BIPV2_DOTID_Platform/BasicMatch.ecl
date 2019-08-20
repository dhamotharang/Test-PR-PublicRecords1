IMPORT SALT32,ut;
EXPORT BasicMatch(DATASET(layout_DOT) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := Specificities(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00( 
      0 + IF( cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR cnp_name = (TYPEOF(cnp_name))'', 0, 25 ) + IF( corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name) OR corp_legal_name = (TYPEOF(corp_legal_name))'', 0, 25 ) + IF( cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR cnp_number = (TYPEOF(cnp_number))'', 0, 14 ) + IF( cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR cnp_btype = (TYPEOF(cnp_btype))'', 0, 3 ) + IF( company_fein  IN SET(s.nulls_company_fein,company_fein) OR company_fein = (TYPEOF(company_fein))'', 0, 27 ) + IF( active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR active_duns_number = (TYPEOF(active_duns_number))'', 0, 24 ) + IF( active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR active_enterprise_number = (TYPEOF(active_enterprise_number))'', 0, 27 ) + IF( active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR active_domestic_corp_key = (TYPEOF(active_domestic_corp_key))'', 0, 27 ) + IF( prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))'', 0, 13 ) + IF( prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))'', 0, 15 ) + IF( sec_range  IN SET(s.nulls_sec_range,sec_range) OR sec_range = (TYPEOF(sec_range))'', 0, 12 ) + IF( st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))'', 0, 5 ) + IF( v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR v_city_name = (TYPEOF(v_city_name))'', 0, 11 ) + IF( zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))'', 0, 14 ) + IF( isContact  IN SET(s.nulls_isContact,isContact) OR isContact = (TYPEOF(isContact))'', 0, 1 ) + IF( fname  IN SET(s.nulls_fname,fname) OR fname = (TYPEOF(fname))'', 0, 9 ) + IF( mname  IN SET(s.nulls_mname,mname) OR mname = (TYPEOF(mname))'', 0, 10 ) + IF( lname  IN SET(s.nulls_lname,lname) OR lname = (TYPEOF(lname))'', 0, 11 ) + IF( name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR name_suffix = (TYPEOF(name_suffix))'', 0, 9 ) + IF( contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR contact_ssn = (TYPEOF(contact_ssn))'', 0, 28 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.DOTid=RIGHT.DOTid,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT32.UIDType DOTid1;
    SALT32.UIDType DOTid2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,SALT_Partition,cnp_name,corp_legal_name,cnp_number,cnp_btype,company_fein,active_duns_number,active_enterprise_number,active_domestic_corp_key,prim_range,prim_name,sec_range,st,v_city_name,zip,isContact,fname,mname,lname,name_suffix,contact_ssn,DOTid);
  h02 := DEDUP(h01,SALT_Partition,cnp_name,corp_legal_name,cnp_number,cnp_btype,company_fein,active_duns_number,active_enterprise_number,active_domestic_corp_key,prim_range,prim_name,sec_range,st,v_city_name,zip,isContact,fname,mname,lname,name_suffix,contact_ssn,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.cnp_name = RIGHT.cnp_name AND LEFT.corp_legal_name = RIGHT.corp_legal_name AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.cnp_btype = RIGHT.cnp_btype AND LEFT.company_fein = RIGHT.company_fein
       AND LEFT.active_duns_number = RIGHT.active_duns_number AND LEFT.active_enterprise_number = RIGHT.active_enterprise_number AND LEFT.active_domestic_corp_key = RIGHT.active_domestic_corp_key AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name
       AND LEFT.sec_range = RIGHT.sec_range AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.zip = RIGHT.zip AND LEFT.isContact = RIGHT.isContact
       AND LEFT.fname = RIGHT.fname AND LEFT.mname = RIGHT.mname AND LEFT.lname = RIGHT.lname AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.contact_ssn = RIGHT.contact_ssn AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition ) AND LEFT.DOTid < RIGHT.DOTid,TRANSFORM(Rec,SELF.DOTid2 := LEFT.DOTid,SELF.DOTid1 := RIGHT.DOTid), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(DOTid1) ), DOTid1, DOTid2, LOCAL), DOTid1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,DOTid,PickOne,DOTid1,DOTid2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,DOTid,ALL))-COUNT(DEDUP(input_file,DOTid,ALL)); // Should equal basic_match_count
END;
