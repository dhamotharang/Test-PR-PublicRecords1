IMPORT SALT28,ut;
EXPORT BasicMatch(DATASET(layout_BizHead) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
SHARED  h00 := Specificities(ih).input_file;
  MatchCands := JOIN(h00,Specificities(ih).ClusterSizes(InCluster=1),LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT28.UIDType proxid1;
    SALT28.UIDType proxid2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00,rcid,rcid2,empid,powid,source,source_record_id,company_name,company_name_prefix,cnp_name,cnp_number,cnp_btype,cnp_lowv,company_phone_3,company_phone_3_ex,company_phone_7,company_fein,company_sic_code1,prim_range,prim_name,sec_range,city,city_clean,st,zip,company_url,isContact,title,fname,fname_preferred,mname,lname,name_suffix,contact_ssn,contact_email,sele_flag,org_flag,ult_flag,proxid);
  h02 := DEDUP(h01,rcid,rcid2,empid,powid,source,source_record_id,company_name,company_name_prefix,cnp_name,cnp_number,cnp_btype,cnp_lowv,company_phone_3,company_phone_3_ex,company_phone_7,company_fein,company_sic_code1,prim_range,prim_name,sec_range,city,city_clean,st,zip,company_url,isContact,title,fname,fname_preferred,mname,lname,name_suffix,contact_ssn,contact_email,sele_flag,org_flag,ult_flag,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.rcid = RIGHT.rcid AND LEFT.rcid2 = RIGHT.rcid2 AND LEFT.empid = RIGHT.empid AND LEFT.powid = RIGHT.powid AND LEFT.source = RIGHT.source
       AND LEFT.source_record_id = RIGHT.source_record_id AND LEFT.company_name = RIGHT.company_name AND LEFT.company_name_prefix = RIGHT.company_name_prefix AND LEFT.cnp_name = RIGHT.cnp_name AND LEFT.cnp_number = RIGHT.cnp_number
       AND LEFT.cnp_btype = RIGHT.cnp_btype AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.company_phone_7 = RIGHT.company_phone_7
       AND LEFT.company_fein = RIGHT.company_fein AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range
       AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.city_clean = RIGHT.city_clean AND LEFT.st = RIGHT.st AND LEFT.zip = RIGHT.zip AND LEFT.company_url = RIGHT.company_url
       AND LEFT.isContact = RIGHT.isContact AND LEFT.title = RIGHT.title AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.mname = RIGHT.mname
       AND LEFT.lname = RIGHT.lname AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.contact_ssn = RIGHT.contact_ssn AND LEFT.contact_email = RIGHT.contact_email AND LEFT.sele_flag = RIGHT.sele_flag
       AND LEFT.org_flag = RIGHT.org_flag AND LEFT.ult_flag = RIGHT.ult_flag AND LEFT.proxid < RIGHT.proxid,TRANSFORM(Rec,SELF.proxid2 := LEFT.proxid,SELF.proxid1 := RIGHT.proxid));
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(proxid1) ), proxid1, proxid2, LOCAL), proxid1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,proxid,PickOne,proxid1,proxid2,o1); // Patch the input file
EXPORT input_file := o1;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,proxid,ALL))-COUNT(DEDUP(input_file,proxid,ALL)); // Should equal basic_match_count
END;

