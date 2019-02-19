IMPORT SALT39,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 95;
  EXPORT NumRulesFromFieldType := 95;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 42;
  EXPORT NumFieldsWithPossibleEdits := 42;
  EXPORT NumRulesWithPossibleEdits := 95;
  EXPORT Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 did_Invalid;
    BOOLEAN did_wouldClean;
    UNSIGNED1 rid_Invalid;
    BOOLEAN rid_wouldClean;
    UNSIGNED1 pflag1_Invalid;
    BOOLEAN pflag1_wouldClean;
    UNSIGNED1 pflag2_Invalid;
    BOOLEAN pflag2_wouldClean;
    UNSIGNED1 pflag3_Invalid;
    BOOLEAN pflag3_wouldClean;
    UNSIGNED1 src_Invalid;
    BOOLEAN src_wouldClean;
    UNSIGNED1 dt_first_seen_Invalid;
    BOOLEAN dt_first_seen_wouldClean;
    UNSIGNED1 dt_last_seen_Invalid;
    BOOLEAN dt_last_seen_wouldClean;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    BOOLEAN dt_vendor_last_reported_wouldClean;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    BOOLEAN dt_vendor_first_reported_wouldClean;
    UNSIGNED1 dt_nonglb_last_seen_Invalid;
    BOOLEAN dt_nonglb_last_seen_wouldClean;
    UNSIGNED1 rec_type_Invalid;
    BOOLEAN rec_type_wouldClean;
    UNSIGNED1 vendor_id_Invalid;
    BOOLEAN vendor_id_wouldClean;
    UNSIGNED1 phone_Invalid;
    BOOLEAN phone_wouldClean;
    UNSIGNED1 ssn_Invalid;
    BOOLEAN ssn_wouldClean;
    UNSIGNED1 dob_Invalid;
    BOOLEAN dob_wouldClean;
    UNSIGNED1 title_Invalid;
    BOOLEAN title_wouldClean;
    UNSIGNED1 fname_Invalid;
    BOOLEAN fname_wouldClean;
    UNSIGNED1 mname_Invalid;
    BOOLEAN mname_wouldClean;
    UNSIGNED1 lname_Invalid;
    BOOLEAN lname_wouldClean;
    UNSIGNED1 name_suffix_Invalid;
    BOOLEAN name_suffix_wouldClean;
    UNSIGNED1 prim_range_Invalid;
    BOOLEAN prim_range_wouldClean;
    UNSIGNED1 predir_Invalid;
    BOOLEAN predir_wouldClean;
    UNSIGNED1 prim_name_Invalid;
    BOOLEAN prim_name_wouldClean;
    UNSIGNED1 suffix_Invalid;
    BOOLEAN suffix_wouldClean;
    UNSIGNED1 postdir_Invalid;
    BOOLEAN postdir_wouldClean;
    UNSIGNED1 unit_desig_Invalid;
    BOOLEAN unit_desig_wouldClean;
    UNSIGNED1 sec_range_Invalid;
    BOOLEAN sec_range_wouldClean;
    UNSIGNED1 city_name_Invalid;
    BOOLEAN city_name_wouldClean;
    UNSIGNED1 st_Invalid;
    BOOLEAN st_wouldClean;
    UNSIGNED1 zip_Invalid;
    BOOLEAN zip_wouldClean;
    UNSIGNED1 zip4_Invalid;
    BOOLEAN zip4_wouldClean;
    UNSIGNED1 county_Invalid;
    BOOLEAN county_wouldClean;
    UNSIGNED1 geo_blk_Invalid;
    BOOLEAN geo_blk_wouldClean;
    UNSIGNED1 cbsa_Invalid;
    BOOLEAN cbsa_wouldClean;
    UNSIGNED1 tnt_Invalid;
    BOOLEAN tnt_wouldClean;
    UNSIGNED1 valid_ssn_Invalid;
    BOOLEAN valid_ssn_wouldClean;
    UNSIGNED1 jflag1_Invalid;
    BOOLEAN jflag1_wouldClean;
    UNSIGNED1 jflag2_Invalid;
    BOOLEAN jflag2_wouldClean;
    UNSIGNED1 jflag3_Invalid;
    BOOLEAN jflag3_wouldClean;
    UNSIGNED1 rawaid_Invalid;
    BOOLEAN rawaid_wouldClean;
    UNSIGNED1 dodgy_tracking_Invalid;
    BOOLEAN dodgy_tracking_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.did_Invalid := Fields.InValid_did((SALT39.StrType)le.did);
    clean_did := (TYPEOF(le.did))Fields.Make_did((SALT39.StrType)le.did);
    clean_did_Invalid := Fields.InValid_did((SALT39.StrType)clean_did);
    SELF.did := IF(withOnfail, clean_did, le.did); // ONFAIL(CLEAN)
    SELF.did_wouldClean := TRIM((SALT39.StrType)le.did) <> TRIM((SALT39.StrType)clean_did);
    SELF.rid_Invalid := Fields.InValid_rid((SALT39.StrType)le.rid);
    clean_rid := (TYPEOF(le.rid))Fields.Make_rid((SALT39.StrType)le.rid);
    clean_rid_Invalid := Fields.InValid_rid((SALT39.StrType)clean_rid);
    SELF.rid := IF(withOnfail, clean_rid, le.rid); // ONFAIL(CLEAN)
    SELF.rid_wouldClean := TRIM((SALT39.StrType)le.rid) <> TRIM((SALT39.StrType)clean_rid);
    SELF.pflag1_Invalid := Fields.InValid_pflag1((SALT39.StrType)le.pflag1);
    clean_pflag1 := (TYPEOF(le.pflag1))Fields.Make_pflag1((SALT39.StrType)le.pflag1);
    clean_pflag1_Invalid := Fields.InValid_pflag1((SALT39.StrType)clean_pflag1);
    SELF.pflag1 := IF(withOnfail, clean_pflag1, le.pflag1); // ONFAIL(CLEAN)
    SELF.pflag1_wouldClean := TRIM((SALT39.StrType)le.pflag1) <> TRIM((SALT39.StrType)clean_pflag1);
    SELF.pflag2_Invalid := Fields.InValid_pflag2((SALT39.StrType)le.pflag2);
    clean_pflag2 := (TYPEOF(le.pflag2))Fields.Make_pflag2((SALT39.StrType)le.pflag2);
    clean_pflag2_Invalid := Fields.InValid_pflag2((SALT39.StrType)clean_pflag2);
    SELF.pflag2 := IF(withOnfail, clean_pflag2, le.pflag2); // ONFAIL(CLEAN)
    SELF.pflag2_wouldClean := TRIM((SALT39.StrType)le.pflag2) <> TRIM((SALT39.StrType)clean_pflag2);
    SELF.pflag3_Invalid := Fields.InValid_pflag3((SALT39.StrType)le.pflag3);
    clean_pflag3 := (TYPEOF(le.pflag3))Fields.Make_pflag3((SALT39.StrType)le.pflag3);
    clean_pflag3_Invalid := Fields.InValid_pflag3((SALT39.StrType)clean_pflag3);
    SELF.pflag3 := IF(withOnfail, clean_pflag3, le.pflag3); // ONFAIL(CLEAN)
    SELF.pflag3_wouldClean := TRIM((SALT39.StrType)le.pflag3) <> TRIM((SALT39.StrType)clean_pflag3);
    SELF.src_Invalid := Fields.InValid_src((SALT39.StrType)le.src);
    clean_src := (TYPEOF(le.src))Fields.Make_src((SALT39.StrType)le.src);
    clean_src_Invalid := Fields.InValid_src((SALT39.StrType)clean_src);
    SELF.src := IF(withOnfail, clean_src, le.src); // ONFAIL(CLEAN)
    SELF.src_wouldClean := TRIM((SALT39.StrType)le.src) <> TRIM((SALT39.StrType)clean_src);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT39.StrType)le.dt_first_seen);
    clean_dt_first_seen := (TYPEOF(le.dt_first_seen))Fields.Make_dt_first_seen((SALT39.StrType)le.dt_first_seen);
    clean_dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT39.StrType)clean_dt_first_seen);
    SELF.dt_first_seen := IF(withOnfail, clean_dt_first_seen, le.dt_first_seen); // ONFAIL(CLEAN)
    SELF.dt_first_seen_wouldClean := TRIM((SALT39.StrType)le.dt_first_seen) <> TRIM((SALT39.StrType)clean_dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT39.StrType)le.dt_last_seen);
    clean_dt_last_seen := (TYPEOF(le.dt_last_seen))Fields.Make_dt_last_seen((SALT39.StrType)le.dt_last_seen);
    clean_dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT39.StrType)clean_dt_last_seen);
    SELF.dt_last_seen := IF(withOnfail, clean_dt_last_seen, le.dt_last_seen); // ONFAIL(CLEAN)
    SELF.dt_last_seen_wouldClean := TRIM((SALT39.StrType)le.dt_last_seen) <> TRIM((SALT39.StrType)clean_dt_last_seen);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT39.StrType)le.dt_vendor_last_reported);
    clean_dt_vendor_last_reported := (TYPEOF(le.dt_vendor_last_reported))Fields.Make_dt_vendor_last_reported((SALT39.StrType)le.dt_vendor_last_reported);
    clean_dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT39.StrType)clean_dt_vendor_last_reported);
    SELF.dt_vendor_last_reported := IF(withOnfail, clean_dt_vendor_last_reported, le.dt_vendor_last_reported); // ONFAIL(CLEAN)
    SELF.dt_vendor_last_reported_wouldClean := TRIM((SALT39.StrType)le.dt_vendor_last_reported) <> TRIM((SALT39.StrType)clean_dt_vendor_last_reported);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT39.StrType)le.dt_vendor_first_reported);
    clean_dt_vendor_first_reported := (TYPEOF(le.dt_vendor_first_reported))Fields.Make_dt_vendor_first_reported((SALT39.StrType)le.dt_vendor_first_reported);
    clean_dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT39.StrType)clean_dt_vendor_first_reported);
    SELF.dt_vendor_first_reported := IF(withOnfail, clean_dt_vendor_first_reported, le.dt_vendor_first_reported); // ONFAIL(CLEAN)
    SELF.dt_vendor_first_reported_wouldClean := TRIM((SALT39.StrType)le.dt_vendor_first_reported) <> TRIM((SALT39.StrType)clean_dt_vendor_first_reported);
    SELF.dt_nonglb_last_seen_Invalid := Fields.InValid_dt_nonglb_last_seen((SALT39.StrType)le.dt_nonglb_last_seen);
    clean_dt_nonglb_last_seen := (TYPEOF(le.dt_nonglb_last_seen))Fields.Make_dt_nonglb_last_seen((SALT39.StrType)le.dt_nonglb_last_seen);
    clean_dt_nonglb_last_seen_Invalid := Fields.InValid_dt_nonglb_last_seen((SALT39.StrType)clean_dt_nonglb_last_seen);
    SELF.dt_nonglb_last_seen := IF(withOnfail, clean_dt_nonglb_last_seen, le.dt_nonglb_last_seen); // ONFAIL(CLEAN)
    SELF.dt_nonglb_last_seen_wouldClean := TRIM((SALT39.StrType)le.dt_nonglb_last_seen) <> TRIM((SALT39.StrType)clean_dt_nonglb_last_seen);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT39.StrType)le.rec_type);
    clean_rec_type := (TYPEOF(le.rec_type))Fields.Make_rec_type((SALT39.StrType)le.rec_type);
    clean_rec_type_Invalid := Fields.InValid_rec_type((SALT39.StrType)clean_rec_type);
    SELF.rec_type := IF(withOnfail, clean_rec_type, le.rec_type); // ONFAIL(CLEAN)
    SELF.rec_type_wouldClean := TRIM((SALT39.StrType)le.rec_type) <> TRIM((SALT39.StrType)clean_rec_type);
    SELF.vendor_id_Invalid := Fields.InValid_vendor_id((SALT39.StrType)le.vendor_id);
    clean_vendor_id := (TYPEOF(le.vendor_id))Fields.Make_vendor_id((SALT39.StrType)le.vendor_id);
    clean_vendor_id_Invalid := Fields.InValid_vendor_id((SALT39.StrType)clean_vendor_id);
    SELF.vendor_id := IF(withOnfail, clean_vendor_id, le.vendor_id); // ONFAIL(CLEAN)
    SELF.vendor_id_wouldClean := TRIM((SALT39.StrType)le.vendor_id) <> TRIM((SALT39.StrType)clean_vendor_id);
    SELF.phone_Invalid := Fields.InValid_phone((SALT39.StrType)le.phone);
    clean_phone := (TYPEOF(le.phone))Fields.Make_phone((SALT39.StrType)le.phone);
    clean_phone_Invalid := Fields.InValid_phone((SALT39.StrType)clean_phone);
    SELF.phone := IF(withOnfail, clean_phone, le.phone); // ONFAIL(CLEAN)
    SELF.phone_wouldClean := TRIM((SALT39.StrType)le.phone) <> TRIM((SALT39.StrType)clean_phone);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT39.StrType)le.ssn);
    clean_ssn := (TYPEOF(le.ssn))Fields.Make_ssn((SALT39.StrType)le.ssn);
    clean_ssn_Invalid := Fields.InValid_ssn((SALT39.StrType)clean_ssn);
    SELF.ssn := IF(withOnfail, clean_ssn, le.ssn); // ONFAIL(CLEAN)
    SELF.ssn_wouldClean := TRIM((SALT39.StrType)le.ssn) <> TRIM((SALT39.StrType)clean_ssn);
    SELF.dob_Invalid := Fields.InValid_dob((SALT39.StrType)le.dob);
    clean_dob := (TYPEOF(le.dob))Fields.Make_dob((SALT39.StrType)le.dob);
    clean_dob_Invalid := Fields.InValid_dob((SALT39.StrType)clean_dob);
    SELF.dob := IF(withOnfail, clean_dob, le.dob); // ONFAIL(CLEAN)
    SELF.dob_wouldClean := TRIM((SALT39.StrType)le.dob) <> TRIM((SALT39.StrType)clean_dob);
    SELF.title_Invalid := Fields.InValid_title((SALT39.StrType)le.title);
    clean_title := (TYPEOF(le.title))Fields.Make_title((SALT39.StrType)le.title);
    clean_title_Invalid := Fields.InValid_title((SALT39.StrType)clean_title);
    SELF.title := IF(withOnfail, clean_title, le.title); // ONFAIL(CLEAN)
    SELF.title_wouldClean := TRIM((SALT39.StrType)le.title) <> TRIM((SALT39.StrType)clean_title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT39.StrType)le.fname);
    clean_fname := (TYPEOF(le.fname))Fields.Make_fname((SALT39.StrType)le.fname);
    clean_fname_Invalid := Fields.InValid_fname((SALT39.StrType)clean_fname);
    SELF.fname := IF(withOnfail, clean_fname, le.fname); // ONFAIL(CLEAN)
    SELF.fname_wouldClean := TRIM((SALT39.StrType)le.fname) <> TRIM((SALT39.StrType)clean_fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT39.StrType)le.mname);
    clean_mname := (TYPEOF(le.mname))Fields.Make_mname((SALT39.StrType)le.mname);
    clean_mname_Invalid := Fields.InValid_mname((SALT39.StrType)clean_mname);
    SELF.mname := IF(withOnfail, clean_mname, le.mname); // ONFAIL(CLEAN)
    SELF.mname_wouldClean := TRIM((SALT39.StrType)le.mname) <> TRIM((SALT39.StrType)clean_mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT39.StrType)le.lname);
    clean_lname := (TYPEOF(le.lname))Fields.Make_lname((SALT39.StrType)le.lname);
    clean_lname_Invalid := Fields.InValid_lname((SALT39.StrType)clean_lname);
    SELF.lname := IF(withOnfail, clean_lname, le.lname); // ONFAIL(CLEAN)
    SELF.lname_wouldClean := TRIM((SALT39.StrType)le.lname) <> TRIM((SALT39.StrType)clean_lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT39.StrType)le.name_suffix);
    clean_name_suffix := (TYPEOF(le.name_suffix))Fields.Make_name_suffix((SALT39.StrType)le.name_suffix);
    clean_name_suffix_Invalid := Fields.InValid_name_suffix((SALT39.StrType)clean_name_suffix);
    SELF.name_suffix := IF(withOnfail, clean_name_suffix, le.name_suffix); // ONFAIL(CLEAN)
    SELF.name_suffix_wouldClean := TRIM((SALT39.StrType)le.name_suffix) <> TRIM((SALT39.StrType)clean_name_suffix);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT39.StrType)le.prim_range);
    clean_prim_range := (TYPEOF(le.prim_range))Fields.Make_prim_range((SALT39.StrType)le.prim_range);
    clean_prim_range_Invalid := Fields.InValid_prim_range((SALT39.StrType)clean_prim_range);
    SELF.prim_range := IF(withOnfail, clean_prim_range, le.prim_range); // ONFAIL(CLEAN)
    SELF.prim_range_wouldClean := TRIM((SALT39.StrType)le.prim_range) <> TRIM((SALT39.StrType)clean_prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT39.StrType)le.predir);
    clean_predir := (TYPEOF(le.predir))Fields.Make_predir((SALT39.StrType)le.predir);
    clean_predir_Invalid := Fields.InValid_predir((SALT39.StrType)clean_predir);
    SELF.predir := IF(withOnfail, clean_predir, le.predir); // ONFAIL(CLEAN)
    SELF.predir_wouldClean := TRIM((SALT39.StrType)le.predir) <> TRIM((SALT39.StrType)clean_predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT39.StrType)le.prim_name);
    clean_prim_name := (TYPEOF(le.prim_name))Fields.Make_prim_name((SALT39.StrType)le.prim_name);
    clean_prim_name_Invalid := Fields.InValid_prim_name((SALT39.StrType)clean_prim_name);
    SELF.prim_name := IF(withOnfail, clean_prim_name, le.prim_name); // ONFAIL(CLEAN)
    SELF.prim_name_wouldClean := TRIM((SALT39.StrType)le.prim_name) <> TRIM((SALT39.StrType)clean_prim_name);
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT39.StrType)le.suffix);
    clean_suffix := (TYPEOF(le.suffix))Fields.Make_suffix((SALT39.StrType)le.suffix);
    clean_suffix_Invalid := Fields.InValid_suffix((SALT39.StrType)clean_suffix);
    SELF.suffix := IF(withOnfail, clean_suffix, le.suffix); // ONFAIL(CLEAN)
    SELF.suffix_wouldClean := TRIM((SALT39.StrType)le.suffix) <> TRIM((SALT39.StrType)clean_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT39.StrType)le.postdir);
    clean_postdir := (TYPEOF(le.postdir))Fields.Make_postdir((SALT39.StrType)le.postdir);
    clean_postdir_Invalid := Fields.InValid_postdir((SALT39.StrType)clean_postdir);
    SELF.postdir := IF(withOnfail, clean_postdir, le.postdir); // ONFAIL(CLEAN)
    SELF.postdir_wouldClean := TRIM((SALT39.StrType)le.postdir) <> TRIM((SALT39.StrType)clean_postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT39.StrType)le.unit_desig);
    clean_unit_desig := (TYPEOF(le.unit_desig))Fields.Make_unit_desig((SALT39.StrType)le.unit_desig);
    clean_unit_desig_Invalid := Fields.InValid_unit_desig((SALT39.StrType)clean_unit_desig);
    SELF.unit_desig := IF(withOnfail, clean_unit_desig, le.unit_desig); // ONFAIL(CLEAN)
    SELF.unit_desig_wouldClean := TRIM((SALT39.StrType)le.unit_desig) <> TRIM((SALT39.StrType)clean_unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT39.StrType)le.sec_range);
    clean_sec_range := (TYPEOF(le.sec_range))Fields.Make_sec_range((SALT39.StrType)le.sec_range);
    clean_sec_range_Invalid := Fields.InValid_sec_range((SALT39.StrType)clean_sec_range);
    SELF.sec_range := IF(withOnfail, clean_sec_range, le.sec_range); // ONFAIL(CLEAN)
    SELF.sec_range_wouldClean := TRIM((SALT39.StrType)le.sec_range) <> TRIM((SALT39.StrType)clean_sec_range);
    SELF.city_name_Invalid := Fields.InValid_city_name((SALT39.StrType)le.city_name);
    clean_city_name := (TYPEOF(le.city_name))Fields.Make_city_name((SALT39.StrType)le.city_name);
    clean_city_name_Invalid := Fields.InValid_city_name((SALT39.StrType)clean_city_name);
    SELF.city_name := IF(withOnfail, clean_city_name, le.city_name); // ONFAIL(CLEAN)
    SELF.city_name_wouldClean := TRIM((SALT39.StrType)le.city_name) <> TRIM((SALT39.StrType)clean_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT39.StrType)le.st);
    clean_st := (TYPEOF(le.st))Fields.Make_st((SALT39.StrType)le.st);
    clean_st_Invalid := Fields.InValid_st((SALT39.StrType)clean_st);
    SELF.st := IF(withOnfail, clean_st, le.st); // ONFAIL(CLEAN)
    SELF.st_wouldClean := TRIM((SALT39.StrType)le.st) <> TRIM((SALT39.StrType)clean_st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT39.StrType)le.zip);
    clean_zip := (TYPEOF(le.zip))Fields.Make_zip((SALT39.StrType)le.zip);
    clean_zip_Invalid := Fields.InValid_zip((SALT39.StrType)clean_zip);
    SELF.zip := IF(withOnfail, clean_zip, le.zip); // ONFAIL(CLEAN)
    SELF.zip_wouldClean := TRIM((SALT39.StrType)le.zip) <> TRIM((SALT39.StrType)clean_zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT39.StrType)le.zip4);
    clean_zip4 := (TYPEOF(le.zip4))Fields.Make_zip4((SALT39.StrType)le.zip4);
    clean_zip4_Invalid := Fields.InValid_zip4((SALT39.StrType)clean_zip4);
    SELF.zip4 := IF(withOnfail, clean_zip4, le.zip4); // ONFAIL(CLEAN)
    SELF.zip4_wouldClean := TRIM((SALT39.StrType)le.zip4) <> TRIM((SALT39.StrType)clean_zip4);
    SELF.county_Invalid := Fields.InValid_county((SALT39.StrType)le.county);
    clean_county := (TYPEOF(le.county))Fields.Make_county((SALT39.StrType)le.county);
    clean_county_Invalid := Fields.InValid_county((SALT39.StrType)clean_county);
    SELF.county := IF(withOnfail, clean_county, le.county); // ONFAIL(CLEAN)
    SELF.county_wouldClean := TRIM((SALT39.StrType)le.county) <> TRIM((SALT39.StrType)clean_county);
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT39.StrType)le.geo_blk);
    clean_geo_blk := (TYPEOF(le.geo_blk))Fields.Make_geo_blk((SALT39.StrType)le.geo_blk);
    clean_geo_blk_Invalid := Fields.InValid_geo_blk((SALT39.StrType)clean_geo_blk);
    SELF.geo_blk := IF(withOnfail, clean_geo_blk, le.geo_blk); // ONFAIL(CLEAN)
    SELF.geo_blk_wouldClean := TRIM((SALT39.StrType)le.geo_blk) <> TRIM((SALT39.StrType)clean_geo_blk);
    SELF.cbsa_Invalid := Fields.InValid_cbsa((SALT39.StrType)le.cbsa);
    clean_cbsa := (TYPEOF(le.cbsa))Fields.Make_cbsa((SALT39.StrType)le.cbsa);
    clean_cbsa_Invalid := Fields.InValid_cbsa((SALT39.StrType)clean_cbsa);
    SELF.cbsa := IF(withOnfail, clean_cbsa, le.cbsa); // ONFAIL(CLEAN)
    SELF.cbsa_wouldClean := TRIM((SALT39.StrType)le.cbsa) <> TRIM((SALT39.StrType)clean_cbsa);
    SELF.tnt_Invalid := Fields.InValid_tnt((SALT39.StrType)le.tnt);
    clean_tnt := (TYPEOF(le.tnt))Fields.Make_tnt((SALT39.StrType)le.tnt);
    clean_tnt_Invalid := Fields.InValid_tnt((SALT39.StrType)clean_tnt);
    SELF.tnt := IF(withOnfail, clean_tnt, le.tnt); // ONFAIL(CLEAN)
    SELF.tnt_wouldClean := TRIM((SALT39.StrType)le.tnt) <> TRIM((SALT39.StrType)clean_tnt);
    SELF.valid_ssn_Invalid := Fields.InValid_valid_ssn((SALT39.StrType)le.valid_ssn);
    clean_valid_ssn := (TYPEOF(le.valid_ssn))Fields.Make_valid_ssn((SALT39.StrType)le.valid_ssn);
    clean_valid_ssn_Invalid := Fields.InValid_valid_ssn((SALT39.StrType)clean_valid_ssn);
    SELF.valid_ssn := IF(withOnfail, clean_valid_ssn, le.valid_ssn); // ONFAIL(CLEAN)
    SELF.valid_ssn_wouldClean := TRIM((SALT39.StrType)le.valid_ssn) <> TRIM((SALT39.StrType)clean_valid_ssn);
    SELF.jflag1_Invalid := Fields.InValid_jflag1((SALT39.StrType)le.jflag1);
    clean_jflag1 := (TYPEOF(le.jflag1))Fields.Make_jflag1((SALT39.StrType)le.jflag1);
    clean_jflag1_Invalid := Fields.InValid_jflag1((SALT39.StrType)clean_jflag1);
    SELF.jflag1 := IF(withOnfail, clean_jflag1, le.jflag1); // ONFAIL(CLEAN)
    SELF.jflag1_wouldClean := TRIM((SALT39.StrType)le.jflag1) <> TRIM((SALT39.StrType)clean_jflag1);
    SELF.jflag2_Invalid := Fields.InValid_jflag2((SALT39.StrType)le.jflag2);
    clean_jflag2 := (TYPEOF(le.jflag2))Fields.Make_jflag2((SALT39.StrType)le.jflag2);
    clean_jflag2_Invalid := Fields.InValid_jflag2((SALT39.StrType)clean_jflag2);
    SELF.jflag2 := IF(withOnfail, clean_jflag2, le.jflag2); // ONFAIL(CLEAN)
    SELF.jflag2_wouldClean := TRIM((SALT39.StrType)le.jflag2) <> TRIM((SALT39.StrType)clean_jflag2);
    SELF.jflag3_Invalid := Fields.InValid_jflag3((SALT39.StrType)le.jflag3);
    clean_jflag3 := (TYPEOF(le.jflag3))Fields.Make_jflag3((SALT39.StrType)le.jflag3);
    clean_jflag3_Invalid := Fields.InValid_jflag3((SALT39.StrType)clean_jflag3);
    SELF.jflag3 := IF(withOnfail, clean_jflag3, le.jflag3); // ONFAIL(CLEAN)
    SELF.jflag3_wouldClean := TRIM((SALT39.StrType)le.jflag3) <> TRIM((SALT39.StrType)clean_jflag3);
    SELF.rawaid_Invalid := Fields.InValid_rawaid((SALT39.StrType)le.rawaid);
    clean_rawaid := (TYPEOF(le.rawaid))Fields.Make_rawaid((SALT39.StrType)le.rawaid);
    clean_rawaid_Invalid := Fields.InValid_rawaid((SALT39.StrType)clean_rawaid);
    SELF.rawaid := IF(withOnfail, clean_rawaid, le.rawaid); // ONFAIL(CLEAN)
    SELF.rawaid_wouldClean := TRIM((SALT39.StrType)le.rawaid) <> TRIM((SALT39.StrType)clean_rawaid);
    SELF.dodgy_tracking_Invalid := Fields.InValid_dodgy_tracking((SALT39.StrType)le.dodgy_tracking);
    clean_dodgy_tracking := (TYPEOF(le.dodgy_tracking))Fields.Make_dodgy_tracking((SALT39.StrType)le.dodgy_tracking);
    clean_dodgy_tracking_Invalid := Fields.InValid_dodgy_tracking((SALT39.StrType)clean_dodgy_tracking);
    SELF.dodgy_tracking := IF(withOnfail, clean_dodgy_tracking, le.dodgy_tracking); // ONFAIL(CLEAN)
    SELF.dodgy_tracking_wouldClean := TRIM((SALT39.StrType)le.dodgy_tracking) <> TRIM((SALT39.StrType)clean_dodgy_tracking);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.did_Invalid << 0 ) + ( le.rid_Invalid << 2 ) + ( le.pflag1_Invalid << 4 ) + ( le.pflag2_Invalid << 6 ) + ( le.pflag3_Invalid << 8 ) + ( le.src_Invalid << 10 ) + ( le.dt_first_seen_Invalid << 12 ) + ( le.dt_last_seen_Invalid << 14 ) + ( le.dt_vendor_last_reported_Invalid << 16 ) + ( le.dt_vendor_first_reported_Invalid << 18 ) + ( le.dt_nonglb_last_seen_Invalid << 20 ) + ( le.rec_type_Invalid << 22 ) + ( le.vendor_id_Invalid << 24 ) + ( le.phone_Invalid << 26 ) + ( le.ssn_Invalid << 28 ) + ( le.dob_Invalid << 30 ) + ( le.title_Invalid << 32 ) + ( le.fname_Invalid << 34 ) + ( le.mname_Invalid << 35 ) + ( le.lname_Invalid << 36 ) + ( le.name_suffix_Invalid << 37 ) + ( le.prim_range_Invalid << 38 ) + ( le.predir_Invalid << 39 ) + ( le.prim_name_Invalid << 40 ) + ( le.suffix_Invalid << 41 ) + ( le.postdir_Invalid << 42 ) + ( le.unit_desig_Invalid << 43 ) + ( le.sec_range_Invalid << 44 ) + ( le.city_name_Invalid << 45 ) + ( le.st_Invalid << 46 ) + ( le.zip_Invalid << 47 ) + ( le.zip4_Invalid << 49 ) + ( le.county_Invalid << 51 ) + ( le.geo_blk_Invalid << 53 ) + ( le.cbsa_Invalid << 55 ) + ( le.tnt_Invalid << 57 ) + ( le.valid_ssn_Invalid << 59 ) + ( le.jflag1_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.jflag2_Invalid << 0 ) + ( le.jflag3_Invalid << 2 ) + ( le.rawaid_Invalid << 4 ) + ( le.dodgy_tracking_Invalid << 6 );
    SELF.ScrubsCleanBits1 := ( IF(le.did_wouldClean, 1, 0) << 0 ) + ( IF(le.rid_wouldClean, 1, 0) << 1 ) + ( IF(le.pflag1_wouldClean, 1, 0) << 2 ) + ( IF(le.pflag2_wouldClean, 1, 0) << 3 ) + ( IF(le.pflag3_wouldClean, 1, 0) << 4 ) + ( IF(le.src_wouldClean, 1, 0) << 5 ) + ( IF(le.dt_first_seen_wouldClean, 1, 0) << 6 ) + ( IF(le.dt_last_seen_wouldClean, 1, 0) << 7 ) + ( IF(le.dt_vendor_last_reported_wouldClean, 1, 0) << 8 ) + ( IF(le.dt_vendor_first_reported_wouldClean, 1, 0) << 9 ) + ( IF(le.dt_nonglb_last_seen_wouldClean, 1, 0) << 10 ) + ( IF(le.rec_type_wouldClean, 1, 0) << 11 ) + ( IF(le.vendor_id_wouldClean, 1, 0) << 12 ) + ( IF(le.phone_wouldClean, 1, 0) << 13 ) + ( IF(le.ssn_wouldClean, 1, 0) << 14 ) + ( IF(le.dob_wouldClean, 1, 0) << 15 ) + ( IF(le.title_wouldClean, 1, 0) << 16 ) + ( IF(le.fname_wouldClean, 1, 0) << 17 ) + ( IF(le.mname_wouldClean, 1, 0) << 18 ) + ( IF(le.lname_wouldClean, 1, 0) << 19 ) + ( IF(le.name_suffix_wouldClean, 1, 0) << 20 ) + ( IF(le.prim_range_wouldClean, 1, 0) << 21 ) + ( IF(le.predir_wouldClean, 1, 0) << 22 ) + ( IF(le.prim_name_wouldClean, 1, 0) << 23 ) + ( IF(le.suffix_wouldClean, 1, 0) << 24 ) + ( IF(le.postdir_wouldClean, 1, 0) << 25 ) + ( IF(le.unit_desig_wouldClean, 1, 0) << 26 ) + ( IF(le.sec_range_wouldClean, 1, 0) << 27 ) + ( IF(le.city_name_wouldClean, 1, 0) << 28 ) + ( IF(le.st_wouldClean, 1, 0) << 29 ) + ( IF(le.zip_wouldClean, 1, 0) << 30 ) + ( IF(le.zip4_wouldClean, 1, 0) << 31 ) + ( IF(le.county_wouldClean, 1, 0) << 32 ) + ( IF(le.geo_blk_wouldClean, 1, 0) << 33 ) + ( IF(le.cbsa_wouldClean, 1, 0) << 34 ) + ( IF(le.tnt_wouldClean, 1, 0) << 35 ) + ( IF(le.valid_ssn_wouldClean, 1, 0) << 36 ) + ( IF(le.jflag1_wouldClean, 1, 0) << 37 ) + ( IF(le.jflag2_wouldClean, 1, 0) << 38 ) + ( IF(le.jflag3_wouldClean, 1, 0) << 39 ) + ( IF(le.rawaid_wouldClean, 1, 0) << 40 ) + ( IF(le.dodgy_tracking_wouldClean, 1, 0) << 41 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.did_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.rid_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.pflag1_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.pflag2_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.pflag3_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.src_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.dt_nonglb_last_seen_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.vendor_id_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.title_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.city_name_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.county_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.geo_blk_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.cbsa_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.tnt_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.valid_ssn_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.jflag1_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.jflag2_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.jflag3_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.rawaid_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.dodgy_tracking_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.did_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.rid_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.pflag1_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.pflag2_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.pflag3_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.src_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.dt_first_seen_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.dt_last_seen_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.dt_vendor_last_reported_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.dt_vendor_first_reported_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.dt_nonglb_last_seen_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.rec_type_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.vendor_id_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.phone_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.ssn_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.dob_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.title_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.fname_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.mname_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.lname_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.name_suffix_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.prim_range_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF.predir_wouldClean := le.ScrubsCleanBits1 >> 22;
    SELF.prim_name_wouldClean := le.ScrubsCleanBits1 >> 23;
    SELF.suffix_wouldClean := le.ScrubsCleanBits1 >> 24;
    SELF.postdir_wouldClean := le.ScrubsCleanBits1 >> 25;
    SELF.unit_desig_wouldClean := le.ScrubsCleanBits1 >> 26;
    SELF.sec_range_wouldClean := le.ScrubsCleanBits1 >> 27;
    SELF.city_name_wouldClean := le.ScrubsCleanBits1 >> 28;
    SELF.st_wouldClean := le.ScrubsCleanBits1 >> 29;
    SELF.zip_wouldClean := le.ScrubsCleanBits1 >> 30;
    SELF.zip4_wouldClean := le.ScrubsCleanBits1 >> 31;
    SELF.county_wouldClean := le.ScrubsCleanBits1 >> 32;
    SELF.geo_blk_wouldClean := le.ScrubsCleanBits1 >> 33;
    SELF.cbsa_wouldClean := le.ScrubsCleanBits1 >> 34;
    SELF.tnt_wouldClean := le.ScrubsCleanBits1 >> 35;
    SELF.valid_ssn_wouldClean := le.ScrubsCleanBits1 >> 36;
    SELF.jflag1_wouldClean := le.ScrubsCleanBits1 >> 37;
    SELF.jflag2_wouldClean := le.ScrubsCleanBits1 >> 38;
    SELF.jflag3_wouldClean := le.ScrubsCleanBits1 >> 39;
    SELF.rawaid_wouldClean := le.ScrubsCleanBits1 >> 40;
    SELF.dodgy_tracking_wouldClean := le.ScrubsCleanBits1 >> 41;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_ALLOW_WouldModifyCount := COUNT(GROUP,h.did_Invalid=1 AND h.did_wouldClean);
    did_WORDS_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_WORDS_WouldModifyCount := COUNT(GROUP,h.did_Invalid=2 AND h.did_wouldClean);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    rid_ALLOW_ErrorCount := COUNT(GROUP,h.rid_Invalid=1);
    rid_ALLOW_WouldModifyCount := COUNT(GROUP,h.rid_Invalid=1 AND h.rid_wouldClean);
    rid_WORDS_ErrorCount := COUNT(GROUP,h.rid_Invalid=2);
    rid_WORDS_WouldModifyCount := COUNT(GROUP,h.rid_Invalid=2 AND h.rid_wouldClean);
    rid_Total_ErrorCount := COUNT(GROUP,h.rid_Invalid>0);
    pflag1_ALLOW_ErrorCount := COUNT(GROUP,h.pflag1_Invalid=1);
    pflag1_ALLOW_WouldModifyCount := COUNT(GROUP,h.pflag1_Invalid=1 AND h.pflag1_wouldClean);
    pflag1_LENGTHS_ErrorCount := COUNT(GROUP,h.pflag1_Invalid=2);
    pflag1_LENGTHS_WouldModifyCount := COUNT(GROUP,h.pflag1_Invalid=2 AND h.pflag1_wouldClean);
    pflag1_WORDS_ErrorCount := COUNT(GROUP,h.pflag1_Invalid=3);
    pflag1_WORDS_WouldModifyCount := COUNT(GROUP,h.pflag1_Invalid=3 AND h.pflag1_wouldClean);
    pflag1_Total_ErrorCount := COUNT(GROUP,h.pflag1_Invalid>0);
    pflag2_ALLOW_ErrorCount := COUNT(GROUP,h.pflag2_Invalid=1);
    pflag2_ALLOW_WouldModifyCount := COUNT(GROUP,h.pflag2_Invalid=1 AND h.pflag2_wouldClean);
    pflag2_LENGTHS_ErrorCount := COUNT(GROUP,h.pflag2_Invalid=2);
    pflag2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.pflag2_Invalid=2 AND h.pflag2_wouldClean);
    pflag2_WORDS_ErrorCount := COUNT(GROUP,h.pflag2_Invalid=3);
    pflag2_WORDS_WouldModifyCount := COUNT(GROUP,h.pflag2_Invalid=3 AND h.pflag2_wouldClean);
    pflag2_Total_ErrorCount := COUNT(GROUP,h.pflag2_Invalid>0);
    pflag3_ALLOW_ErrorCount := COUNT(GROUP,h.pflag3_Invalid=1);
    pflag3_ALLOW_WouldModifyCount := COUNT(GROUP,h.pflag3_Invalid=1 AND h.pflag3_wouldClean);
    pflag3_LENGTHS_ErrorCount := COUNT(GROUP,h.pflag3_Invalid=2);
    pflag3_LENGTHS_WouldModifyCount := COUNT(GROUP,h.pflag3_Invalid=2 AND h.pflag3_wouldClean);
    pflag3_WORDS_ErrorCount := COUNT(GROUP,h.pflag3_Invalid=3);
    pflag3_WORDS_WouldModifyCount := COUNT(GROUP,h.pflag3_Invalid=3 AND h.pflag3_wouldClean);
    pflag3_Total_ErrorCount := COUNT(GROUP,h.pflag3_Invalid>0);
    src_ALLOW_ErrorCount := COUNT(GROUP,h.src_Invalid=1);
    src_ALLOW_WouldModifyCount := COUNT(GROUP,h.src_Invalid=1 AND h.src_wouldClean);
    src_LENGTHS_ErrorCount := COUNT(GROUP,h.src_Invalid=2);
    src_LENGTHS_WouldModifyCount := COUNT(GROUP,h.src_Invalid=2 AND h.src_wouldClean);
    src_WORDS_ErrorCount := COUNT(GROUP,h.src_Invalid=3);
    src_WORDS_WouldModifyCount := COUNT(GROUP,h.src_Invalid=3 AND h.src_wouldClean);
    src_Total_ErrorCount := COUNT(GROUP,h.src_Invalid>0);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_ALLOW_WouldModifyCount := COUNT(GROUP,h.dt_first_seen_Invalid=1 AND h.dt_first_seen_wouldClean);
    dt_first_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dt_first_seen_Invalid=2 AND h.dt_first_seen_wouldClean);
    dt_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_WORDS_WouldModifyCount := COUNT(GROUP,h.dt_first_seen_Invalid=3 AND h.dt_first_seen_wouldClean);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_ALLOW_WouldModifyCount := COUNT(GROUP,h.dt_last_seen_Invalid=1 AND h.dt_last_seen_wouldClean);
    dt_last_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dt_last_seen_Invalid=2 AND h.dt_last_seen_wouldClean);
    dt_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_WORDS_WouldModifyCount := COUNT(GROUP,h.dt_last_seen_Invalid=3 AND h.dt_last_seen_wouldClean);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_ALLOW_WouldModifyCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1 AND h.dt_vendor_last_reported_wouldClean);
    dt_vendor_last_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2 AND h.dt_vendor_last_reported_wouldClean);
    dt_vendor_last_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_WORDS_WouldModifyCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3 AND h.dt_vendor_last_reported_wouldClean);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_ALLOW_WouldModifyCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1 AND h.dt_vendor_first_reported_wouldClean);
    dt_vendor_first_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2 AND h.dt_vendor_first_reported_wouldClean);
    dt_vendor_first_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_WORDS_WouldModifyCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3 AND h.dt_vendor_first_reported_wouldClean);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_nonglb_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_nonglb_last_seen_Invalid=1);
    dt_nonglb_last_seen_ALLOW_WouldModifyCount := COUNT(GROUP,h.dt_nonglb_last_seen_Invalid=1 AND h.dt_nonglb_last_seen_wouldClean);
    dt_nonglb_last_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_nonglb_last_seen_Invalid=2);
    dt_nonglb_last_seen_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dt_nonglb_last_seen_Invalid=2 AND h.dt_nonglb_last_seen_wouldClean);
    dt_nonglb_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_nonglb_last_seen_Invalid=3);
    dt_nonglb_last_seen_WORDS_WouldModifyCount := COUNT(GROUP,h.dt_nonglb_last_seen_Invalid=3 AND h.dt_nonglb_last_seen_wouldClean);
    dt_nonglb_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_nonglb_last_seen_Invalid>0);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    rec_type_ALLOW_WouldModifyCount := COUNT(GROUP,h.rec_type_Invalid=1 AND h.rec_type_wouldClean);
    rec_type_LENGTHS_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_LENGTHS_WouldModifyCount := COUNT(GROUP,h.rec_type_Invalid=2 AND h.rec_type_wouldClean);
    rec_type_WORDS_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=3);
    rec_type_WORDS_WouldModifyCount := COUNT(GROUP,h.rec_type_Invalid=3 AND h.rec_type_wouldClean);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
    vendor_id_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_id_Invalid=1);
    vendor_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.vendor_id_Invalid=1 AND h.vendor_id_wouldClean);
    vendor_id_WORDS_ErrorCount := COUNT(GROUP,h.vendor_id_Invalid=2);
    vendor_id_WORDS_WouldModifyCount := COUNT(GROUP,h.vendor_id_Invalid=2 AND h.vendor_id_wouldClean);
    vendor_id_Total_ErrorCount := COUNT(GROUP,h.vendor_id_Invalid>0);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_ALLOW_WouldModifyCount := COUNT(GROUP,h.phone_Invalid=1 AND h.phone_wouldClean);
    phone_WORDS_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_WORDS_WouldModifyCount := COUNT(GROUP,h.phone_Invalid=2 AND h.phone_wouldClean);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=1 AND h.ssn_wouldClean);
    ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=2 AND h.ssn_wouldClean);
    ssn_WORDS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=3);
    ssn_WORDS_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=3 AND h.ssn_wouldClean);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_ALLOW_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=1 AND h.dob_wouldClean);
    dob_LENGTHS_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=2 AND h.dob_wouldClean);
    dob_WORDS_ErrorCount := COUNT(GROUP,h.dob_Invalid=3);
    dob_WORDS_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=3 AND h.dob_wouldClean);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_ALLOW_WouldModifyCount := COUNT(GROUP,h.title_Invalid=1 AND h.title_wouldClean);
    title_LENGTHS_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_LENGTHS_WouldModifyCount := COUNT(GROUP,h.title_Invalid=2 AND h.title_wouldClean);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_WouldModifyCount := COUNT(GROUP,h.fname_Invalid=1 AND h.fname_wouldClean);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_WouldModifyCount := COUNT(GROUP,h.mname_Invalid=1 AND h.mname_wouldClean);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_WouldModifyCount := COUNT(GROUP,h.lname_Invalid=1 AND h.lname_wouldClean);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=1 AND h.name_suffix_wouldClean);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_range_Invalid=1 AND h.prim_range_wouldClean);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_ALLOW_WouldModifyCount := COUNT(GROUP,h.predir_Invalid=1 AND h.predir_wouldClean);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_name_Invalid=1 AND h.prim_name_wouldClean);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.suffix_Invalid=1 AND h.suffix_wouldClean);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_ALLOW_WouldModifyCount := COUNT(GROUP,h.postdir_Invalid=1 AND h.postdir_wouldClean);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_ALLOW_WouldModifyCount := COUNT(GROUP,h.unit_desig_Invalid=1 AND h.unit_desig_wouldClean);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.sec_range_Invalid=1 AND h.sec_range_wouldClean);
    city_name_ALLOW_ErrorCount := COUNT(GROUP,h.city_name_Invalid=1);
    city_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.city_name_Invalid=1 AND h.city_name_wouldClean);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_WouldModifyCount := COUNT(GROUP,h.st_Invalid=1 AND h.st_wouldClean);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=1 AND h.zip_wouldClean);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_LENGTHS_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=2 AND h.zip_wouldClean);
    zip_WORDS_ErrorCount := COUNT(GROUP,h.zip_Invalid=3);
    zip_WORDS_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=3 AND h.zip_wouldClean);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip4_Invalid=1 AND h.zip4_wouldClean);
    zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_LENGTHS_WouldModifyCount := COUNT(GROUP,h.zip4_Invalid=2 AND h.zip4_wouldClean);
    zip4_WORDS_ErrorCount := COUNT(GROUP,h.zip4_Invalid=3);
    zip4_WORDS_WouldModifyCount := COUNT(GROUP,h.zip4_Invalid=3 AND h.zip4_wouldClean);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    county_ALLOW_WouldModifyCount := COUNT(GROUP,h.county_Invalid=1 AND h.county_wouldClean);
    county_LENGTHS_ErrorCount := COUNT(GROUP,h.county_Invalid=2);
    county_LENGTHS_WouldModifyCount := COUNT(GROUP,h.county_Invalid=2 AND h.county_wouldClean);
    county_WORDS_ErrorCount := COUNT(GROUP,h.county_Invalid=3);
    county_WORDS_WouldModifyCount := COUNT(GROUP,h.county_Invalid=3 AND h.county_wouldClean);
    county_Total_ErrorCount := COUNT(GROUP,h.county_Invalid>0);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_blk_ALLOW_WouldModifyCount := COUNT(GROUP,h.geo_blk_Invalid=1 AND h.geo_blk_wouldClean);
    geo_blk_LENGTHS_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=2);
    geo_blk_LENGTHS_WouldModifyCount := COUNT(GROUP,h.geo_blk_Invalid=2 AND h.geo_blk_wouldClean);
    geo_blk_WORDS_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=3);
    geo_blk_WORDS_WouldModifyCount := COUNT(GROUP,h.geo_blk_Invalid=3 AND h.geo_blk_wouldClean);
    geo_blk_Total_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid>0);
    cbsa_ALLOW_ErrorCount := COUNT(GROUP,h.cbsa_Invalid=1);
    cbsa_ALLOW_WouldModifyCount := COUNT(GROUP,h.cbsa_Invalid=1 AND h.cbsa_wouldClean);
    cbsa_LENGTHS_ErrorCount := COUNT(GROUP,h.cbsa_Invalid=2);
    cbsa_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cbsa_Invalid=2 AND h.cbsa_wouldClean);
    cbsa_WORDS_ErrorCount := COUNT(GROUP,h.cbsa_Invalid=3);
    cbsa_WORDS_WouldModifyCount := COUNT(GROUP,h.cbsa_Invalid=3 AND h.cbsa_wouldClean);
    cbsa_Total_ErrorCount := COUNT(GROUP,h.cbsa_Invalid>0);
    tnt_ALLOW_ErrorCount := COUNT(GROUP,h.tnt_Invalid=1);
    tnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.tnt_Invalid=1 AND h.tnt_wouldClean);
    tnt_LENGTHS_ErrorCount := COUNT(GROUP,h.tnt_Invalid=2);
    tnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.tnt_Invalid=2 AND h.tnt_wouldClean);
    tnt_WORDS_ErrorCount := COUNT(GROUP,h.tnt_Invalid=3);
    tnt_WORDS_WouldModifyCount := COUNT(GROUP,h.tnt_Invalid=3 AND h.tnt_wouldClean);
    tnt_Total_ErrorCount := COUNT(GROUP,h.tnt_Invalid>0);
    valid_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.valid_ssn_Invalid=1);
    valid_ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.valid_ssn_Invalid=1 AND h.valid_ssn_wouldClean);
    valid_ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.valid_ssn_Invalid=2);
    valid_ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.valid_ssn_Invalid=2 AND h.valid_ssn_wouldClean);
    valid_ssn_WORDS_ErrorCount := COUNT(GROUP,h.valid_ssn_Invalid=3);
    valid_ssn_WORDS_WouldModifyCount := COUNT(GROUP,h.valid_ssn_Invalid=3 AND h.valid_ssn_wouldClean);
    valid_ssn_Total_ErrorCount := COUNT(GROUP,h.valid_ssn_Invalid>0);
    jflag1_ALLOW_ErrorCount := COUNT(GROUP,h.jflag1_Invalid=1);
    jflag1_ALLOW_WouldModifyCount := COUNT(GROUP,h.jflag1_Invalid=1 AND h.jflag1_wouldClean);
    jflag1_LENGTHS_ErrorCount := COUNT(GROUP,h.jflag1_Invalid=2);
    jflag1_LENGTHS_WouldModifyCount := COUNT(GROUP,h.jflag1_Invalid=2 AND h.jflag1_wouldClean);
    jflag1_WORDS_ErrorCount := COUNT(GROUP,h.jflag1_Invalid=3);
    jflag1_WORDS_WouldModifyCount := COUNT(GROUP,h.jflag1_Invalid=3 AND h.jflag1_wouldClean);
    jflag1_Total_ErrorCount := COUNT(GROUP,h.jflag1_Invalid>0);
    jflag2_ALLOW_ErrorCount := COUNT(GROUP,h.jflag2_Invalid=1);
    jflag2_ALLOW_WouldModifyCount := COUNT(GROUP,h.jflag2_Invalid=1 AND h.jflag2_wouldClean);
    jflag2_LENGTHS_ErrorCount := COUNT(GROUP,h.jflag2_Invalid=2);
    jflag2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.jflag2_Invalid=2 AND h.jflag2_wouldClean);
    jflag2_WORDS_ErrorCount := COUNT(GROUP,h.jflag2_Invalid=3);
    jflag2_WORDS_WouldModifyCount := COUNT(GROUP,h.jflag2_Invalid=3 AND h.jflag2_wouldClean);
    jflag2_Total_ErrorCount := COUNT(GROUP,h.jflag2_Invalid>0);
    jflag3_ALLOW_ErrorCount := COUNT(GROUP,h.jflag3_Invalid=1);
    jflag3_ALLOW_WouldModifyCount := COUNT(GROUP,h.jflag3_Invalid=1 AND h.jflag3_wouldClean);
    jflag3_LENGTHS_ErrorCount := COUNT(GROUP,h.jflag3_Invalid=2);
    jflag3_LENGTHS_WouldModifyCount := COUNT(GROUP,h.jflag3_Invalid=2 AND h.jflag3_wouldClean);
    jflag3_WORDS_ErrorCount := COUNT(GROUP,h.jflag3_Invalid=3);
    jflag3_WORDS_WouldModifyCount := COUNT(GROUP,h.jflag3_Invalid=3 AND h.jflag3_wouldClean);
    jflag3_Total_ErrorCount := COUNT(GROUP,h.jflag3_Invalid>0);
    rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    rawaid_ALLOW_WouldModifyCount := COUNT(GROUP,h.rawaid_Invalid=1 AND h.rawaid_wouldClean);
    rawaid_LENGTHS_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=2);
    rawaid_LENGTHS_WouldModifyCount := COUNT(GROUP,h.rawaid_Invalid=2 AND h.rawaid_wouldClean);
    rawaid_WORDS_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=3);
    rawaid_WORDS_WouldModifyCount := COUNT(GROUP,h.rawaid_Invalid=3 AND h.rawaid_wouldClean);
    rawaid_Total_ErrorCount := COUNT(GROUP,h.rawaid_Invalid>0);
    dodgy_tracking_ALLOW_ErrorCount := COUNT(GROUP,h.dodgy_tracking_Invalid=1);
    dodgy_tracking_ALLOW_WouldModifyCount := COUNT(GROUP,h.dodgy_tracking_Invalid=1 AND h.dodgy_tracking_wouldClean);
    dodgy_tracking_LENGTHS_ErrorCount := COUNT(GROUP,h.dodgy_tracking_Invalid=2);
    dodgy_tracking_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dodgy_tracking_Invalid=2 AND h.dodgy_tracking_wouldClean);
    dodgy_tracking_WORDS_ErrorCount := COUNT(GROUP,h.dodgy_tracking_Invalid=3);
    dodgy_tracking_WORDS_WouldModifyCount := COUNT(GROUP,h.dodgy_tracking_Invalid=3 AND h.dodgy_tracking_wouldClean);
    dodgy_tracking_Total_ErrorCount := COUNT(GROUP,h.dodgy_tracking_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.did_Invalid > 0 OR h.rid_Invalid > 0 OR h.pflag1_Invalid > 0 OR h.pflag2_Invalid > 0 OR h.pflag3_Invalid > 0 OR h.src_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_nonglb_last_seen_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.vendor_id_Invalid > 0 OR h.phone_Invalid > 0 OR h.ssn_Invalid > 0 OR h.dob_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.county_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.cbsa_Invalid > 0 OR h.tnt_Invalid > 0 OR h.valid_ssn_Invalid > 0 OR h.jflag1_Invalid > 0 OR h.jflag2_Invalid > 0 OR h.jflag3_Invalid > 0 OR h.rawaid_Invalid > 0 OR h.dodgy_tracking_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.did_wouldClean OR h.rid_wouldClean OR h.pflag1_wouldClean OR h.pflag2_wouldClean OR h.pflag3_wouldClean OR h.src_wouldClean OR h.dt_first_seen_wouldClean OR h.dt_last_seen_wouldClean OR h.dt_vendor_last_reported_wouldClean OR h.dt_vendor_first_reported_wouldClean OR h.dt_nonglb_last_seen_wouldClean OR h.rec_type_wouldClean OR h.vendor_id_wouldClean OR h.phone_wouldClean OR h.ssn_wouldClean OR h.dob_wouldClean OR h.title_wouldClean OR h.fname_wouldClean OR h.mname_wouldClean OR h.lname_wouldClean OR h.name_suffix_wouldClean OR h.prim_range_wouldClean OR h.predir_wouldClean OR h.prim_name_wouldClean OR h.suffix_wouldClean OR h.postdir_wouldClean OR h.unit_desig_wouldClean OR h.sec_range_wouldClean OR h.city_name_wouldClean OR h.st_wouldClean OR h.zip_wouldClean OR h.zip4_wouldClean OR h.county_wouldClean OR h.geo_blk_wouldClean OR h.cbsa_wouldClean OR h.tnt_wouldClean OR h.valid_ssn_wouldClean OR h.jflag1_wouldClean OR h.jflag2_wouldClean OR h.jflag3_wouldClean OR h.rawaid_wouldClean OR h.dodgy_tracking_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.did_Total_ErrorCount > 0, 1, 0) + IF(le.rid_Total_ErrorCount > 0, 1, 0) + IF(le.pflag1_Total_ErrorCount > 0, 1, 0) + IF(le.pflag2_Total_ErrorCount > 0, 1, 0) + IF(le.pflag3_Total_ErrorCount > 0, 1, 0) + IF(le.src_Total_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dt_nonglb_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.rec_type_Total_ErrorCount > 0, 1, 0) + IF(le.vendor_id_Total_ErrorCount > 0, 1, 0) + IF(le.phone_Total_ErrorCount > 0, 1, 0) + IF(le.ssn_Total_ErrorCount > 0, 1, 0) + IF(le.dob_Total_ErrorCount > 0, 1, 0) + IF(le.title_Total_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_Total_ErrorCount > 0, 1, 0) + IF(le.county_Total_ErrorCount > 0, 1, 0) + IF(le.geo_blk_Total_ErrorCount > 0, 1, 0) + IF(le.cbsa_Total_ErrorCount > 0, 1, 0) + IF(le.tnt_Total_ErrorCount > 0, 1, 0) + IF(le.valid_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.jflag1_Total_ErrorCount > 0, 1, 0) + IF(le.jflag2_Total_ErrorCount > 0, 1, 0) + IF(le.jflag3_Total_ErrorCount > 0, 1, 0) + IF(le.rawaid_Total_ErrorCount > 0, 1, 0) + IF(le.dodgy_tracking_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_WORDS_ErrorCount > 0, 1, 0) + IF(le.rid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rid_WORDS_ErrorCount > 0, 1, 0) + IF(le.pflag1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pflag1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.pflag1_WORDS_ErrorCount > 0, 1, 0) + IF(le.pflag2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pflag2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.pflag2_WORDS_ErrorCount > 0, 1, 0) + IF(le.pflag3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pflag3_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.pflag3_WORDS_ErrorCount > 0, 1, 0) + IF(le.src_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.src_WORDS_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_WORDS_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_WORDS_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_WORDS_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_WORDS_ErrorCount > 0, 1, 0) + IF(le.dt_nonglb_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_nonglb_last_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_nonglb_last_seen_WORDS_ErrorCount > 0, 1, 0) + IF(le.rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_type_WORDS_ErrorCount > 0, 1, 0) + IF(le.vendor_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_WORDS_ErrorCount > 0, 1, 0) + IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ssn_WORDS_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_WORDS_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_WORDS_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_WORDS_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.county_WORDS_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.geo_blk_WORDS_ErrorCount > 0, 1, 0) + IF(le.cbsa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cbsa_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cbsa_WORDS_ErrorCount > 0, 1, 0) + IF(le.tnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.valid_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.valid_ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.valid_ssn_WORDS_ErrorCount > 0, 1, 0) + IF(le.jflag1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.jflag1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.jflag1_WORDS_ErrorCount > 0, 1, 0) + IF(le.jflag2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.jflag2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.jflag2_WORDS_ErrorCount > 0, 1, 0) + IF(le.jflag3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.jflag3_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.jflag3_WORDS_ErrorCount > 0, 1, 0) + IF(le.rawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawaid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rawaid_WORDS_ErrorCount > 0, 1, 0) + IF(le.dodgy_tracking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dodgy_tracking_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dodgy_tracking_WORDS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.did_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.did_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.rid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.rid_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.pflag1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.pflag1_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.pflag1_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.pflag2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.pflag2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.pflag2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.pflag3_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.pflag3_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.pflag3_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.src_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.src_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.src_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dt_first_seen_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dt_first_seen_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dt_first_seen_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dt_last_seen_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dt_last_seen_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dt_last_seen_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dt_nonglb_last_seen_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dt_nonglb_last_seen_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dt_nonglb_last_seen_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.rec_type_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.rec_type_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.rec_type_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.vendor_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.vendor_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.phone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.phone_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ssn_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dob_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dob_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dob_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.title_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.title_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.fname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.prim_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.predir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.postdir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.city_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.st_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.zip_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.zip4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip4_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.zip4_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.county_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.county_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.county_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.geo_blk_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.geo_blk_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cbsa_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cbsa_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cbsa_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.tnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.tnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.tnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.valid_ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.valid_ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.valid_ssn_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.jflag1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.jflag1_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.jflag1_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.jflag2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.jflag2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.jflag2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.jflag3_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.jflag3_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.jflag3_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.rawaid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.rawaid_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.rawaid_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dodgy_tracking_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dodgy_tracking_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dodgy_tracking_WORDS_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.did_Invalid,le.rid_Invalid,le.pflag1_Invalid,le.pflag2_Invalid,le.pflag3_Invalid,le.src_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_nonglb_last_seen_Invalid,le.rec_type_Invalid,le.vendor_id_Invalid,le.phone_Invalid,le.ssn_Invalid,le.dob_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.county_Invalid,le.geo_blk_Invalid,le.cbsa_Invalid,le.tnt_Invalid,le.valid_ssn_Invalid,le.jflag1_Invalid,le.jflag2_Invalid,le.jflag3_Invalid,le.rawaid_Invalid,le.dodgy_tracking_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_rid(le.rid_Invalid),Fields.InvalidMessage_pflag1(le.pflag1_Invalid),Fields.InvalidMessage_pflag2(le.pflag2_Invalid),Fields.InvalidMessage_pflag3(le.pflag3_Invalid),Fields.InvalidMessage_src(le.src_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_nonglb_last_seen(le.dt_nonglb_last_seen_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_vendor_id(le.vendor_id_Invalid),Fields.InvalidMessage_phone(le.phone_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_city_name(le.city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_cbsa(le.cbsa_Invalid),Fields.InvalidMessage_tnt(le.tnt_Invalid),Fields.InvalidMessage_valid_ssn(le.valid_ssn_Invalid),Fields.InvalidMessage_jflag1(le.jflag1_Invalid),Fields.InvalidMessage_jflag2(le.jflag2_Invalid),Fields.InvalidMessage_jflag3(le.jflag3_Invalid),Fields.InvalidMessage_rawaid(le.rawaid_Invalid),Fields.InvalidMessage_dodgy_tracking(le.dodgy_tracking_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.did_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.rid_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.pflag1_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.pflag2_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.pflag3_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.src_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_nonglb_last_seen_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.vendor_id_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cbsa_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.tnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.valid_ssn_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.jflag1_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.jflag2_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.jflag3_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dodgy_tracking_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'did','rid','pflag1','pflag2','pflag3','src','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','dt_nonglb_last_seen','rec_type','vendor_id','phone','ssn','dob','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','county','geo_blk','cbsa','tnt','valid_ssn','jflag1','jflag2','jflag3','rawaid','dodgy_tracking','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'did','rid','pflag1','pflag2','pflag3','src','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','dt_nonglb_last_seen','rec_type','vendor_id','phone','ssn','dob','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','county','geo_blk','cbsa','tnt','valid_ssn','jflag1','jflag2','jflag3','rawaid','dodgy_tracking','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.did,(SALT39.StrType)le.rid,(SALT39.StrType)le.pflag1,(SALT39.StrType)le.pflag2,(SALT39.StrType)le.pflag3,(SALT39.StrType)le.src,(SALT39.StrType)le.dt_first_seen,(SALT39.StrType)le.dt_last_seen,(SALT39.StrType)le.dt_vendor_last_reported,(SALT39.StrType)le.dt_vendor_first_reported,(SALT39.StrType)le.dt_nonglb_last_seen,(SALT39.StrType)le.rec_type,(SALT39.StrType)le.vendor_id,(SALT39.StrType)le.phone,(SALT39.StrType)le.ssn,(SALT39.StrType)le.dob,(SALT39.StrType)le.title,(SALT39.StrType)le.fname,(SALT39.StrType)le.mname,(SALT39.StrType)le.lname,(SALT39.StrType)le.name_suffix,(SALT39.StrType)le.prim_range,(SALT39.StrType)le.predir,(SALT39.StrType)le.prim_name,(SALT39.StrType)le.suffix,(SALT39.StrType)le.postdir,(SALT39.StrType)le.unit_desig,(SALT39.StrType)le.sec_range,(SALT39.StrType)le.city_name,(SALT39.StrType)le.st,(SALT39.StrType)le.zip,(SALT39.StrType)le.zip4,(SALT39.StrType)le.county,(SALT39.StrType)le.geo_blk,(SALT39.StrType)le.cbsa,(SALT39.StrType)le.tnt,(SALT39.StrType)le.valid_ssn,(SALT39.StrType)le.jflag1,(SALT39.StrType)le.jflag2,(SALT39.StrType)le.jflag3,(SALT39.StrType)le.rawaid,(SALT39.StrType)le.dodgy_tracking,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,42,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_File) prevDS = DATASET([], Layout_File), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'did:did:ALLOW','did:did:WORDS'
          ,'rid:rid:ALLOW','rid:rid:WORDS'
          ,'pflag1:pflag1:ALLOW','pflag1:pflag1:LENGTHS','pflag1:pflag1:WORDS'
          ,'pflag2:pflag2:ALLOW','pflag2:pflag2:LENGTHS','pflag2:pflag2:WORDS'
          ,'pflag3:pflag3:ALLOW','pflag3:pflag3:LENGTHS','pflag3:pflag3:WORDS'
          ,'src:src:ALLOW','src:src:LENGTHS','src:src:WORDS'
          ,'dt_first_seen:dt_first_seen:ALLOW','dt_first_seen:dt_first_seen:LENGTHS','dt_first_seen:dt_first_seen:WORDS'
          ,'dt_last_seen:dt_last_seen:ALLOW','dt_last_seen:dt_last_seen:LENGTHS','dt_last_seen:dt_last_seen:WORDS'
          ,'dt_vendor_last_reported:dt_vendor_last_reported:ALLOW','dt_vendor_last_reported:dt_vendor_last_reported:LENGTHS','dt_vendor_last_reported:dt_vendor_last_reported:WORDS'
          ,'dt_vendor_first_reported:dt_vendor_first_reported:ALLOW','dt_vendor_first_reported:dt_vendor_first_reported:LENGTHS','dt_vendor_first_reported:dt_vendor_first_reported:WORDS'
          ,'dt_nonglb_last_seen:dt_nonglb_last_seen:ALLOW','dt_nonglb_last_seen:dt_nonglb_last_seen:LENGTHS','dt_nonglb_last_seen:dt_nonglb_last_seen:WORDS'
          ,'rec_type:rec_type:ALLOW','rec_type:rec_type:LENGTHS','rec_type:rec_type:WORDS'
          ,'vendor_id:vendor_id:ALLOW','vendor_id:vendor_id:WORDS'
          ,'phone:phone:ALLOW','phone:phone:WORDS'
          ,'ssn:ssn:ALLOW','ssn:ssn:LENGTHS','ssn:ssn:WORDS'
          ,'dob:dob:ALLOW','dob:dob:LENGTHS','dob:dob:WORDS'
          ,'title:title:ALLOW','title:title:LENGTHS'
          ,'fname:fname:ALLOW'
          ,'mname:mname:ALLOW'
          ,'lname:lname:ALLOW'
          ,'name_suffix:name_suffix:ALLOW'
          ,'prim_range:prim_range:ALLOW'
          ,'predir:predir:ALLOW'
          ,'prim_name:prim_name:ALLOW'
          ,'suffix:suffix:ALLOW'
          ,'postdir:postdir:ALLOW'
          ,'unit_desig:unit_desig:ALLOW'
          ,'sec_range:sec_range:ALLOW'
          ,'city_name:city_name:ALLOW'
          ,'st:st:ALLOW'
          ,'zip:zip:ALLOW','zip:zip:LENGTHS','zip:zip:WORDS'
          ,'zip4:zip4:ALLOW','zip4:zip4:LENGTHS','zip4:zip4:WORDS'
          ,'county:county:ALLOW','county:county:LENGTHS','county:county:WORDS'
          ,'geo_blk:geo_blk:ALLOW','geo_blk:geo_blk:LENGTHS','geo_blk:geo_blk:WORDS'
          ,'cbsa:cbsa:ALLOW','cbsa:cbsa:LENGTHS','cbsa:cbsa:WORDS'
          ,'tnt:tnt:ALLOW','tnt:tnt:LENGTHS','tnt:tnt:WORDS'
          ,'valid_ssn:valid_ssn:ALLOW','valid_ssn:valid_ssn:LENGTHS','valid_ssn:valid_ssn:WORDS'
          ,'jflag1:jflag1:ALLOW','jflag1:jflag1:LENGTHS','jflag1:jflag1:WORDS'
          ,'jflag2:jflag2:ALLOW','jflag2:jflag2:LENGTHS','jflag2:jflag2:WORDS'
          ,'jflag3:jflag3:ALLOW','jflag3:jflag3:LENGTHS','jflag3:jflag3:WORDS'
          ,'rawaid:rawaid:ALLOW','rawaid:rawaid:LENGTHS','rawaid:rawaid:WORDS'
          ,'dodgy_tracking:dodgy_tracking:ALLOW','dodgy_tracking:dodgy_tracking:LENGTHS','dodgy_tracking:dodgy_tracking:WORDS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_did(1),Fields.InvalidMessage_did(2)
          ,Fields.InvalidMessage_rid(1),Fields.InvalidMessage_rid(2)
          ,Fields.InvalidMessage_pflag1(1),Fields.InvalidMessage_pflag1(2),Fields.InvalidMessage_pflag1(3)
          ,Fields.InvalidMessage_pflag2(1),Fields.InvalidMessage_pflag2(2),Fields.InvalidMessage_pflag2(3)
          ,Fields.InvalidMessage_pflag3(1),Fields.InvalidMessage_pflag3(2),Fields.InvalidMessage_pflag3(3)
          ,Fields.InvalidMessage_src(1),Fields.InvalidMessage_src(2),Fields.InvalidMessage_src(3)
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2),Fields.InvalidMessage_dt_first_seen(3)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2),Fields.InvalidMessage_dt_last_seen(3)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2),Fields.InvalidMessage_dt_vendor_last_reported(3)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2),Fields.InvalidMessage_dt_vendor_first_reported(3)
          ,Fields.InvalidMessage_dt_nonglb_last_seen(1),Fields.InvalidMessage_dt_nonglb_last_seen(2),Fields.InvalidMessage_dt_nonglb_last_seen(3)
          ,Fields.InvalidMessage_rec_type(1),Fields.InvalidMessage_rec_type(2),Fields.InvalidMessage_rec_type(3)
          ,Fields.InvalidMessage_vendor_id(1),Fields.InvalidMessage_vendor_id(2)
          ,Fields.InvalidMessage_phone(1),Fields.InvalidMessage_phone(2)
          ,Fields.InvalidMessage_ssn(1),Fields.InvalidMessage_ssn(2),Fields.InvalidMessage_ssn(3)
          ,Fields.InvalidMessage_dob(1),Fields.InvalidMessage_dob(2),Fields.InvalidMessage_dob(3)
          ,Fields.InvalidMessage_title(1),Fields.InvalidMessage_title(2)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_name_suffix(1)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_suffix(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_unit_desig(1)
          ,Fields.InvalidMessage_sec_range(1)
          ,Fields.InvalidMessage_city_name(1)
          ,Fields.InvalidMessage_st(1)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2),Fields.InvalidMessage_zip(3)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2),Fields.InvalidMessage_zip4(3)
          ,Fields.InvalidMessage_county(1),Fields.InvalidMessage_county(2),Fields.InvalidMessage_county(3)
          ,Fields.InvalidMessage_geo_blk(1),Fields.InvalidMessage_geo_blk(2),Fields.InvalidMessage_geo_blk(3)
          ,Fields.InvalidMessage_cbsa(1),Fields.InvalidMessage_cbsa(2),Fields.InvalidMessage_cbsa(3)
          ,Fields.InvalidMessage_tnt(1),Fields.InvalidMessage_tnt(2),Fields.InvalidMessage_tnt(3)
          ,Fields.InvalidMessage_valid_ssn(1),Fields.InvalidMessage_valid_ssn(2),Fields.InvalidMessage_valid_ssn(3)
          ,Fields.InvalidMessage_jflag1(1),Fields.InvalidMessage_jflag1(2),Fields.InvalidMessage_jflag1(3)
          ,Fields.InvalidMessage_jflag2(1),Fields.InvalidMessage_jflag2(2),Fields.InvalidMessage_jflag2(3)
          ,Fields.InvalidMessage_jflag3(1),Fields.InvalidMessage_jflag3(2),Fields.InvalidMessage_jflag3(3)
          ,Fields.InvalidMessage_rawaid(1),Fields.InvalidMessage_rawaid(2),Fields.InvalidMessage_rawaid(3)
          ,Fields.InvalidMessage_dodgy_tracking(1),Fields.InvalidMessage_dodgy_tracking(2),Fields.InvalidMessage_dodgy_tracking(3)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.did_ALLOW_ErrorCount,le.did_WORDS_ErrorCount
          ,le.rid_ALLOW_ErrorCount,le.rid_WORDS_ErrorCount
          ,le.pflag1_ALLOW_ErrorCount,le.pflag1_LENGTHS_ErrorCount,le.pflag1_WORDS_ErrorCount
          ,le.pflag2_ALLOW_ErrorCount,le.pflag2_LENGTHS_ErrorCount,le.pflag2_WORDS_ErrorCount
          ,le.pflag3_ALLOW_ErrorCount,le.pflag3_LENGTHS_ErrorCount,le.pflag3_WORDS_ErrorCount
          ,le.src_ALLOW_ErrorCount,le.src_LENGTHS_ErrorCount,le.src_WORDS_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTHS_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTHS_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTHS_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTHS_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_nonglb_last_seen_ALLOW_ErrorCount,le.dt_nonglb_last_seen_LENGTHS_ErrorCount,le.dt_nonglb_last_seen_WORDS_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTHS_ErrorCount,le.rec_type_WORDS_ErrorCount
          ,le.vendor_id_ALLOW_ErrorCount,le.vendor_id_WORDS_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_WORDS_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount,le.ssn_WORDS_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTHS_ErrorCount,le.dob_WORDS_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTHS_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTHS_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.county_ALLOW_ErrorCount,le.county_LENGTHS_ErrorCount,le.county_WORDS_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTHS_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.cbsa_ALLOW_ErrorCount,le.cbsa_LENGTHS_ErrorCount,le.cbsa_WORDS_ErrorCount
          ,le.tnt_ALLOW_ErrorCount,le.tnt_LENGTHS_ErrorCount,le.tnt_WORDS_ErrorCount
          ,le.valid_ssn_ALLOW_ErrorCount,le.valid_ssn_LENGTHS_ErrorCount,le.valid_ssn_WORDS_ErrorCount
          ,le.jflag1_ALLOW_ErrorCount,le.jflag1_LENGTHS_ErrorCount,le.jflag1_WORDS_ErrorCount
          ,le.jflag2_ALLOW_ErrorCount,le.jflag2_LENGTHS_ErrorCount,le.jflag2_WORDS_ErrorCount
          ,le.jflag3_ALLOW_ErrorCount,le.jflag3_LENGTHS_ErrorCount,le.jflag3_WORDS_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTHS_ErrorCount,le.rawaid_WORDS_ErrorCount
          ,le.dodgy_tracking_ALLOW_ErrorCount,le.dodgy_tracking_LENGTHS_ErrorCount,le.dodgy_tracking_WORDS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.did_ALLOW_ErrorCount,le.did_WORDS_ErrorCount
          ,le.rid_ALLOW_ErrorCount,le.rid_WORDS_ErrorCount
          ,le.pflag1_ALLOW_ErrorCount,le.pflag1_LENGTHS_ErrorCount,le.pflag1_WORDS_ErrorCount
          ,le.pflag2_ALLOW_ErrorCount,le.pflag2_LENGTHS_ErrorCount,le.pflag2_WORDS_ErrorCount
          ,le.pflag3_ALLOW_ErrorCount,le.pflag3_LENGTHS_ErrorCount,le.pflag3_WORDS_ErrorCount
          ,le.src_ALLOW_ErrorCount,le.src_LENGTHS_ErrorCount,le.src_WORDS_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTHS_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTHS_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTHS_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTHS_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_nonglb_last_seen_ALLOW_ErrorCount,le.dt_nonglb_last_seen_LENGTHS_ErrorCount,le.dt_nonglb_last_seen_WORDS_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTHS_ErrorCount,le.rec_type_WORDS_ErrorCount
          ,le.vendor_id_ALLOW_ErrorCount,le.vendor_id_WORDS_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_WORDS_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount,le.ssn_WORDS_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTHS_ErrorCount,le.dob_WORDS_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTHS_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTHS_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.county_ALLOW_ErrorCount,le.county_LENGTHS_ErrorCount,le.county_WORDS_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTHS_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.cbsa_ALLOW_ErrorCount,le.cbsa_LENGTHS_ErrorCount,le.cbsa_WORDS_ErrorCount
          ,le.tnt_ALLOW_ErrorCount,le.tnt_LENGTHS_ErrorCount,le.tnt_WORDS_ErrorCount
          ,le.valid_ssn_ALLOW_ErrorCount,le.valid_ssn_LENGTHS_ErrorCount,le.valid_ssn_WORDS_ErrorCount
          ,le.jflag1_ALLOW_ErrorCount,le.jflag1_LENGTHS_ErrorCount,le.jflag1_WORDS_ErrorCount
          ,le.jflag2_ALLOW_ErrorCount,le.jflag2_LENGTHS_ErrorCount,le.jflag2_WORDS_ErrorCount
          ,le.jflag3_ALLOW_ErrorCount,le.jflag3_LENGTHS_ErrorCount,le.jflag3_WORDS_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTHS_ErrorCount,le.rawaid_WORDS_ErrorCount
          ,le.dodgy_tracking_ALLOW_ErrorCount,le.dodgy_tracking_LENGTHS_ErrorCount,le.dodgy_tracking_WORDS_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_File));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rid:' + getFieldTypeText(h.rid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pflag1:' + getFieldTypeText(h.pflag1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pflag2:' + getFieldTypeText(h.pflag2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pflag3:' + getFieldTypeText(h.pflag3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src:' + getFieldTypeText(h.src) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_nonglb_last_seen:' + getFieldTypeText(h.dt_nonglb_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_id:' + getFieldTypeText(h.vendor_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_name:' + getFieldTypeText(h.city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cbsa:' + getFieldTypeText(h.cbsa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tnt:' + getFieldTypeText(h.tnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'valid_ssn:' + getFieldTypeText(h.valid_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jflag1:' + getFieldTypeText(h.jflag1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jflag2:' + getFieldTypeText(h.jflag2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jflag3:' + getFieldTypeText(h.jflag3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawaid:' + getFieldTypeText(h.rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dodgy_tracking:' + getFieldTypeText(h.dodgy_tracking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nid:' + getFieldTypeText(h.nid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_ind:' + getFieldTypeText(h.address_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_ind:' + getFieldTypeText(h.name_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'persistent_record_id:' + getFieldTypeText(h.persistent_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_did_cnt
          ,le.populated_rid_cnt
          ,le.populated_pflag1_cnt
          ,le.populated_pflag2_cnt
          ,le.populated_pflag3_cnt
          ,le.populated_src_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_nonglb_last_seen_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_vendor_id_cnt
          ,le.populated_phone_cnt
          ,le.populated_ssn_cnt
          ,le.populated_dob_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_cbsa_cnt
          ,le.populated_tnt_cnt
          ,le.populated_valid_ssn_cnt
          ,le.populated_jflag1_cnt
          ,le.populated_jflag2_cnt
          ,le.populated_jflag3_cnt
          ,le.populated_rawaid_cnt
          ,le.populated_dodgy_tracking_cnt
          ,le.populated_nid_cnt
          ,le.populated_address_ind_cnt
          ,le.populated_name_ind_cnt
          ,le.populated_persistent_record_id_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_did_pcnt
          ,le.populated_rid_pcnt
          ,le.populated_pflag1_pcnt
          ,le.populated_pflag2_pcnt
          ,le.populated_pflag3_pcnt
          ,le.populated_src_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_nonglb_last_seen_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_vendor_id_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_cbsa_pcnt
          ,le.populated_tnt_pcnt
          ,le.populated_valid_ssn_pcnt
          ,le.populated_jflag1_pcnt
          ,le.populated_jflag2_pcnt
          ,le.populated_jflag3_pcnt
          ,le.populated_rawaid_pcnt
          ,le.populated_dodgy_tracking_pcnt
          ,le.populated_nid_pcnt
          ,le.populated_address_ind_pcnt
          ,le.populated_name_ind_pcnt
          ,le.populated_persistent_record_id_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,46,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_File));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),46,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_File) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Headers_Monthly, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
