IMPORT SALT39,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 51;
  EXPORT NumRulesFromFieldType := 51;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 22;
  EXPORT NumFieldsWithPossibleEdits := 22;
  EXPORT NumRulesWithPossibleEdits := 51;
  EXPORT Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 src_Invalid;
    BOOLEAN src_wouldClean;
    UNSIGNED1 did_Invalid;
    BOOLEAN did_wouldClean;
    UNSIGNED1 fname_Invalid;
    BOOLEAN fname_wouldClean;
    UNSIGNED1 lname_Invalid;
    BOOLEAN lname_wouldClean;
    UNSIGNED1 prim_range_Invalid;
    BOOLEAN prim_range_wouldClean;
    UNSIGNED1 prim_name_Invalid;
    BOOLEAN prim_name_wouldClean;
    UNSIGNED1 zip_Invalid;
    BOOLEAN zip_wouldClean;
    UNSIGNED1 mname_Invalid;
    BOOLEAN mname_wouldClean;
    UNSIGNED1 sec_range_Invalid;
    BOOLEAN sec_range_wouldClean;
    UNSIGNED1 name_suffix_Invalid;
    BOOLEAN name_suffix_wouldClean;
    UNSIGNED1 ssn_Invalid;
    BOOLEAN ssn_wouldClean;
    UNSIGNED1 dob_Invalid;
    BOOLEAN dob_wouldClean;
    UNSIGNED1 dids_with_this_nm_addr_Invalid;
    BOOLEAN dids_with_this_nm_addr_wouldClean;
    UNSIGNED1 suffix_cnt_with_this_nm_addr_Invalid;
    BOOLEAN suffix_cnt_with_this_nm_addr_wouldClean;
    UNSIGNED1 sec_range_cnt_with_this_nm_addr_Invalid;
    BOOLEAN sec_range_cnt_with_this_nm_addr_wouldClean;
    UNSIGNED1 ssn_cnt_with_this_nm_addr_Invalid;
    BOOLEAN ssn_cnt_with_this_nm_addr_wouldClean;
    UNSIGNED1 dob_cnt_with_this_nm_addr_Invalid;
    BOOLEAN dob_cnt_with_this_nm_addr_wouldClean;
    UNSIGNED1 mname_cnt_with_this_nm_addr_Invalid;
    BOOLEAN mname_cnt_with_this_nm_addr_wouldClean;
    UNSIGNED1 dids_with_this_nm_ssn_Invalid;
    BOOLEAN dids_with_this_nm_ssn_wouldClean;
    UNSIGNED1 dob_cnt_with_this_nm_ssn_Invalid;
    BOOLEAN dob_cnt_with_this_nm_ssn_wouldClean;
    UNSIGNED1 dids_with_this_nm_dob_Invalid;
    BOOLEAN dids_with_this_nm_dob_wouldClean;
    UNSIGNED1 zip_cnt_with_this_nm_dob_Invalid;
    BOOLEAN zip_cnt_with_this_nm_dob_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.src_Invalid := Fields.InValid_src((SALT39.StrType)le.src);
    clean_src := (TYPEOF(le.src))Fields.Make_src((SALT39.StrType)le.src);
    clean_src_Invalid := Fields.InValid_src((SALT39.StrType)clean_src);
    SELF.src := IF(withOnfail, clean_src, le.src); // ONFAIL(CLEAN)
    SELF.src_wouldClean := TRIM((SALT39.StrType)le.src) <> TRIM((SALT39.StrType)clean_src);
    SELF.did_Invalid := Fields.InValid_did((SALT39.StrType)le.did);
    clean_did := (TYPEOF(le.did))Fields.Make_did((SALT39.StrType)le.did);
    clean_did_Invalid := Fields.InValid_did((SALT39.StrType)clean_did);
    SELF.did := IF(withOnfail, clean_did, le.did); // ONFAIL(CLEAN)
    SELF.did_wouldClean := TRIM((SALT39.StrType)le.did) <> TRIM((SALT39.StrType)clean_did);
    SELF.fname_Invalid := Fields.InValid_fname((SALT39.StrType)le.fname);
    clean_fname := (TYPEOF(le.fname))Fields.Make_fname((SALT39.StrType)le.fname);
    clean_fname_Invalid := Fields.InValid_fname((SALT39.StrType)clean_fname);
    SELF.fname := IF(withOnfail, clean_fname, le.fname); // ONFAIL(CLEAN)
    SELF.fname_wouldClean := TRIM((SALT39.StrType)le.fname) <> TRIM((SALT39.StrType)clean_fname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT39.StrType)le.lname);
    clean_lname := (TYPEOF(le.lname))Fields.Make_lname((SALT39.StrType)le.lname);
    clean_lname_Invalid := Fields.InValid_lname((SALT39.StrType)clean_lname);
    SELF.lname := IF(withOnfail, clean_lname, le.lname); // ONFAIL(CLEAN)
    SELF.lname_wouldClean := TRIM((SALT39.StrType)le.lname) <> TRIM((SALT39.StrType)clean_lname);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT39.StrType)le.prim_range);
    clean_prim_range := (TYPEOF(le.prim_range))Fields.Make_prim_range((SALT39.StrType)le.prim_range);
    clean_prim_range_Invalid := Fields.InValid_prim_range((SALT39.StrType)clean_prim_range);
    SELF.prim_range := IF(withOnfail, clean_prim_range, le.prim_range); // ONFAIL(CLEAN)
    SELF.prim_range_wouldClean := TRIM((SALT39.StrType)le.prim_range) <> TRIM((SALT39.StrType)clean_prim_range);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT39.StrType)le.prim_name);
    clean_prim_name := (TYPEOF(le.prim_name))Fields.Make_prim_name((SALT39.StrType)le.prim_name);
    clean_prim_name_Invalid := Fields.InValid_prim_name((SALT39.StrType)clean_prim_name);
    SELF.prim_name := IF(withOnfail, clean_prim_name, le.prim_name); // ONFAIL(CLEAN)
    SELF.prim_name_wouldClean := TRIM((SALT39.StrType)le.prim_name) <> TRIM((SALT39.StrType)clean_prim_name);
    SELF.zip_Invalid := Fields.InValid_zip((SALT39.StrType)le.zip);
    clean_zip := (TYPEOF(le.zip))Fields.Make_zip((SALT39.StrType)le.zip);
    clean_zip_Invalid := Fields.InValid_zip((SALT39.StrType)clean_zip);
    SELF.zip := IF(withOnfail, clean_zip, le.zip); // ONFAIL(CLEAN)
    SELF.zip_wouldClean := TRIM((SALT39.StrType)le.zip) <> TRIM((SALT39.StrType)clean_zip);
    SELF.mname_Invalid := Fields.InValid_mname((SALT39.StrType)le.mname);
    clean_mname := (TYPEOF(le.mname))Fields.Make_mname((SALT39.StrType)le.mname);
    clean_mname_Invalid := Fields.InValid_mname((SALT39.StrType)clean_mname);
    SELF.mname := IF(withOnfail, clean_mname, le.mname); // ONFAIL(CLEAN)
    SELF.mname_wouldClean := TRIM((SALT39.StrType)le.mname) <> TRIM((SALT39.StrType)clean_mname);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT39.StrType)le.sec_range);
    clean_sec_range := (TYPEOF(le.sec_range))Fields.Make_sec_range((SALT39.StrType)le.sec_range);
    clean_sec_range_Invalid := Fields.InValid_sec_range((SALT39.StrType)clean_sec_range);
    SELF.sec_range := IF(withOnfail, clean_sec_range, le.sec_range); // ONFAIL(CLEAN)
    SELF.sec_range_wouldClean := TRIM((SALT39.StrType)le.sec_range) <> TRIM((SALT39.StrType)clean_sec_range);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT39.StrType)le.name_suffix);
    clean_name_suffix := (TYPEOF(le.name_suffix))Fields.Make_name_suffix((SALT39.StrType)le.name_suffix);
    clean_name_suffix_Invalid := Fields.InValid_name_suffix((SALT39.StrType)clean_name_suffix);
    SELF.name_suffix := IF(withOnfail, clean_name_suffix, le.name_suffix); // ONFAIL(CLEAN)
    SELF.name_suffix_wouldClean := TRIM((SALT39.StrType)le.name_suffix) <> TRIM((SALT39.StrType)clean_name_suffix);
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
    SELF.dids_with_this_nm_addr_Invalid := Fields.InValid_dids_with_this_nm_addr((SALT39.StrType)le.dids_with_this_nm_addr);
    clean_dids_with_this_nm_addr := (TYPEOF(le.dids_with_this_nm_addr))Fields.Make_dids_with_this_nm_addr((SALT39.StrType)le.dids_with_this_nm_addr);
    clean_dids_with_this_nm_addr_Invalid := Fields.InValid_dids_with_this_nm_addr((SALT39.StrType)clean_dids_with_this_nm_addr);
    SELF.dids_with_this_nm_addr := IF(withOnfail, clean_dids_with_this_nm_addr, le.dids_with_this_nm_addr); // ONFAIL(CLEAN)
    SELF.dids_with_this_nm_addr_wouldClean := TRIM((SALT39.StrType)le.dids_with_this_nm_addr) <> TRIM((SALT39.StrType)clean_dids_with_this_nm_addr);
    SELF.suffix_cnt_with_this_nm_addr_Invalid := Fields.InValid_suffix_cnt_with_this_nm_addr((SALT39.StrType)le.suffix_cnt_with_this_nm_addr);
    clean_suffix_cnt_with_this_nm_addr := (TYPEOF(le.suffix_cnt_with_this_nm_addr))Fields.Make_suffix_cnt_with_this_nm_addr((SALT39.StrType)le.suffix_cnt_with_this_nm_addr);
    clean_suffix_cnt_with_this_nm_addr_Invalid := Fields.InValid_suffix_cnt_with_this_nm_addr((SALT39.StrType)clean_suffix_cnt_with_this_nm_addr);
    SELF.suffix_cnt_with_this_nm_addr := IF(withOnfail, clean_suffix_cnt_with_this_nm_addr, le.suffix_cnt_with_this_nm_addr); // ONFAIL(CLEAN)
    SELF.suffix_cnt_with_this_nm_addr_wouldClean := TRIM((SALT39.StrType)le.suffix_cnt_with_this_nm_addr) <> TRIM((SALT39.StrType)clean_suffix_cnt_with_this_nm_addr);
    SELF.sec_range_cnt_with_this_nm_addr_Invalid := Fields.InValid_sec_range_cnt_with_this_nm_addr((SALT39.StrType)le.sec_range_cnt_with_this_nm_addr);
    clean_sec_range_cnt_with_this_nm_addr := (TYPEOF(le.sec_range_cnt_with_this_nm_addr))Fields.Make_sec_range_cnt_with_this_nm_addr((SALT39.StrType)le.sec_range_cnt_with_this_nm_addr);
    clean_sec_range_cnt_with_this_nm_addr_Invalid := Fields.InValid_sec_range_cnt_with_this_nm_addr((SALT39.StrType)clean_sec_range_cnt_with_this_nm_addr);
    SELF.sec_range_cnt_with_this_nm_addr := IF(withOnfail, clean_sec_range_cnt_with_this_nm_addr, le.sec_range_cnt_with_this_nm_addr); // ONFAIL(CLEAN)
    SELF.sec_range_cnt_with_this_nm_addr_wouldClean := TRIM((SALT39.StrType)le.sec_range_cnt_with_this_nm_addr) <> TRIM((SALT39.StrType)clean_sec_range_cnt_with_this_nm_addr);
    SELF.ssn_cnt_with_this_nm_addr_Invalid := Fields.InValid_ssn_cnt_with_this_nm_addr((SALT39.StrType)le.ssn_cnt_with_this_nm_addr);
    clean_ssn_cnt_with_this_nm_addr := (TYPEOF(le.ssn_cnt_with_this_nm_addr))Fields.Make_ssn_cnt_with_this_nm_addr((SALT39.StrType)le.ssn_cnt_with_this_nm_addr);
    clean_ssn_cnt_with_this_nm_addr_Invalid := Fields.InValid_ssn_cnt_with_this_nm_addr((SALT39.StrType)clean_ssn_cnt_with_this_nm_addr);
    SELF.ssn_cnt_with_this_nm_addr := IF(withOnfail, clean_ssn_cnt_with_this_nm_addr, le.ssn_cnt_with_this_nm_addr); // ONFAIL(CLEAN)
    SELF.ssn_cnt_with_this_nm_addr_wouldClean := TRIM((SALT39.StrType)le.ssn_cnt_with_this_nm_addr) <> TRIM((SALT39.StrType)clean_ssn_cnt_with_this_nm_addr);
    SELF.dob_cnt_with_this_nm_addr_Invalid := Fields.InValid_dob_cnt_with_this_nm_addr((SALT39.StrType)le.dob_cnt_with_this_nm_addr);
    clean_dob_cnt_with_this_nm_addr := (TYPEOF(le.dob_cnt_with_this_nm_addr))Fields.Make_dob_cnt_with_this_nm_addr((SALT39.StrType)le.dob_cnt_with_this_nm_addr);
    clean_dob_cnt_with_this_nm_addr_Invalid := Fields.InValid_dob_cnt_with_this_nm_addr((SALT39.StrType)clean_dob_cnt_with_this_nm_addr);
    SELF.dob_cnt_with_this_nm_addr := IF(withOnfail, clean_dob_cnt_with_this_nm_addr, le.dob_cnt_with_this_nm_addr); // ONFAIL(CLEAN)
    SELF.dob_cnt_with_this_nm_addr_wouldClean := TRIM((SALT39.StrType)le.dob_cnt_with_this_nm_addr) <> TRIM((SALT39.StrType)clean_dob_cnt_with_this_nm_addr);
    SELF.mname_cnt_with_this_nm_addr_Invalid := Fields.InValid_mname_cnt_with_this_nm_addr((SALT39.StrType)le.mname_cnt_with_this_nm_addr);
    clean_mname_cnt_with_this_nm_addr := (TYPEOF(le.mname_cnt_with_this_nm_addr))Fields.Make_mname_cnt_with_this_nm_addr((SALT39.StrType)le.mname_cnt_with_this_nm_addr);
    clean_mname_cnt_with_this_nm_addr_Invalid := Fields.InValid_mname_cnt_with_this_nm_addr((SALT39.StrType)clean_mname_cnt_with_this_nm_addr);
    SELF.mname_cnt_with_this_nm_addr := IF(withOnfail, clean_mname_cnt_with_this_nm_addr, le.mname_cnt_with_this_nm_addr); // ONFAIL(CLEAN)
    SELF.mname_cnt_with_this_nm_addr_wouldClean := TRIM((SALT39.StrType)le.mname_cnt_with_this_nm_addr) <> TRIM((SALT39.StrType)clean_mname_cnt_with_this_nm_addr);
    SELF.dids_with_this_nm_ssn_Invalid := Fields.InValid_dids_with_this_nm_ssn((SALT39.StrType)le.dids_with_this_nm_ssn);
    clean_dids_with_this_nm_ssn := (TYPEOF(le.dids_with_this_nm_ssn))Fields.Make_dids_with_this_nm_ssn((SALT39.StrType)le.dids_with_this_nm_ssn);
    clean_dids_with_this_nm_ssn_Invalid := Fields.InValid_dids_with_this_nm_ssn((SALT39.StrType)clean_dids_with_this_nm_ssn);
    SELF.dids_with_this_nm_ssn := IF(withOnfail, clean_dids_with_this_nm_ssn, le.dids_with_this_nm_ssn); // ONFAIL(CLEAN)
    SELF.dids_with_this_nm_ssn_wouldClean := TRIM((SALT39.StrType)le.dids_with_this_nm_ssn) <> TRIM((SALT39.StrType)clean_dids_with_this_nm_ssn);
    SELF.dob_cnt_with_this_nm_ssn_Invalid := Fields.InValid_dob_cnt_with_this_nm_ssn((SALT39.StrType)le.dob_cnt_with_this_nm_ssn);
    clean_dob_cnt_with_this_nm_ssn := (TYPEOF(le.dob_cnt_with_this_nm_ssn))Fields.Make_dob_cnt_with_this_nm_ssn((SALT39.StrType)le.dob_cnt_with_this_nm_ssn);
    clean_dob_cnt_with_this_nm_ssn_Invalid := Fields.InValid_dob_cnt_with_this_nm_ssn((SALT39.StrType)clean_dob_cnt_with_this_nm_ssn);
    SELF.dob_cnt_with_this_nm_ssn := IF(withOnfail, clean_dob_cnt_with_this_nm_ssn, le.dob_cnt_with_this_nm_ssn); // ONFAIL(CLEAN)
    SELF.dob_cnt_with_this_nm_ssn_wouldClean := TRIM((SALT39.StrType)le.dob_cnt_with_this_nm_ssn) <> TRIM((SALT39.StrType)clean_dob_cnt_with_this_nm_ssn);
    SELF.dids_with_this_nm_dob_Invalid := Fields.InValid_dids_with_this_nm_dob((SALT39.StrType)le.dids_with_this_nm_dob);
    clean_dids_with_this_nm_dob := (TYPEOF(le.dids_with_this_nm_dob))Fields.Make_dids_with_this_nm_dob((SALT39.StrType)le.dids_with_this_nm_dob);
    clean_dids_with_this_nm_dob_Invalid := Fields.InValid_dids_with_this_nm_dob((SALT39.StrType)clean_dids_with_this_nm_dob);
    SELF.dids_with_this_nm_dob := IF(withOnfail, clean_dids_with_this_nm_dob, le.dids_with_this_nm_dob); // ONFAIL(CLEAN)
    SELF.dids_with_this_nm_dob_wouldClean := TRIM((SALT39.StrType)le.dids_with_this_nm_dob) <> TRIM((SALT39.StrType)clean_dids_with_this_nm_dob);
    SELF.zip_cnt_with_this_nm_dob_Invalid := Fields.InValid_zip_cnt_with_this_nm_dob((SALT39.StrType)le.zip_cnt_with_this_nm_dob);
    clean_zip_cnt_with_this_nm_dob := (TYPEOF(le.zip_cnt_with_this_nm_dob))Fields.Make_zip_cnt_with_this_nm_dob((SALT39.StrType)le.zip_cnt_with_this_nm_dob);
    clean_zip_cnt_with_this_nm_dob_Invalid := Fields.InValid_zip_cnt_with_this_nm_dob((SALT39.StrType)clean_zip_cnt_with_this_nm_dob);
    SELF.zip_cnt_with_this_nm_dob := IF(withOnfail, clean_zip_cnt_with_this_nm_dob, le.zip_cnt_with_this_nm_dob); // ONFAIL(CLEAN)
    SELF.zip_cnt_with_this_nm_dob_wouldClean := TRIM((SALT39.StrType)le.zip_cnt_with_this_nm_dob) <> TRIM((SALT39.StrType)clean_zip_cnt_with_this_nm_dob);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.src_Invalid << 0 ) + ( le.did_Invalid << 2 ) + ( le.fname_Invalid << 4 ) + ( le.lname_Invalid << 5 ) + ( le.prim_range_Invalid << 6 ) + ( le.prim_name_Invalid << 7 ) + ( le.zip_Invalid << 8 ) + ( le.mname_Invalid << 10 ) + ( le.sec_range_Invalid << 11 ) + ( le.name_suffix_Invalid << 13 ) + ( le.ssn_Invalid << 15 ) + ( le.dob_Invalid << 16 ) + ( le.dids_with_this_nm_addr_Invalid << 17 ) + ( le.suffix_cnt_with_this_nm_addr_Invalid << 19 ) + ( le.sec_range_cnt_with_this_nm_addr_Invalid << 21 ) + ( le.ssn_cnt_with_this_nm_addr_Invalid << 23 ) + ( le.dob_cnt_with_this_nm_addr_Invalid << 25 ) + ( le.mname_cnt_with_this_nm_addr_Invalid << 27 ) + ( le.dids_with_this_nm_ssn_Invalid << 29 ) + ( le.dob_cnt_with_this_nm_ssn_Invalid << 31 ) + ( le.dids_with_this_nm_dob_Invalid << 33 ) + ( le.zip_cnt_with_this_nm_dob_Invalid << 35 );
    SELF.ScrubsCleanBits1 := ( IF(le.src_wouldClean, 1, 0) << 0 ) + ( IF(le.did_wouldClean, 1, 0) << 1 ) + ( IF(le.fname_wouldClean, 1, 0) << 2 ) + ( IF(le.lname_wouldClean, 1, 0) << 3 ) + ( IF(le.prim_range_wouldClean, 1, 0) << 4 ) + ( IF(le.prim_name_wouldClean, 1, 0) << 5 ) + ( IF(le.zip_wouldClean, 1, 0) << 6 ) + ( IF(le.mname_wouldClean, 1, 0) << 7 ) + ( IF(le.sec_range_wouldClean, 1, 0) << 8 ) + ( IF(le.name_suffix_wouldClean, 1, 0) << 9 ) + ( IF(le.ssn_wouldClean, 1, 0) << 10 ) + ( IF(le.dob_wouldClean, 1, 0) << 11 ) + ( IF(le.dids_with_this_nm_addr_wouldClean, 1, 0) << 12 ) + ( IF(le.suffix_cnt_with_this_nm_addr_wouldClean, 1, 0) << 13 ) + ( IF(le.sec_range_cnt_with_this_nm_addr_wouldClean, 1, 0) << 14 ) + ( IF(le.ssn_cnt_with_this_nm_addr_wouldClean, 1, 0) << 15 ) + ( IF(le.dob_cnt_with_this_nm_addr_wouldClean, 1, 0) << 16 ) + ( IF(le.mname_cnt_with_this_nm_addr_wouldClean, 1, 0) << 17 ) + ( IF(le.dids_with_this_nm_ssn_wouldClean, 1, 0) << 18 ) + ( IF(le.dob_cnt_with_this_nm_ssn_wouldClean, 1, 0) << 19 ) + ( IF(le.dids_with_this_nm_dob_wouldClean, 1, 0) << 20 ) + ( IF(le.zip_cnt_with_this_nm_dob_wouldClean, 1, 0) << 21 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.src_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.did_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.dids_with_this_nm_addr_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.suffix_cnt_with_this_nm_addr_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.sec_range_cnt_with_this_nm_addr_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.ssn_cnt_with_this_nm_addr_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.dob_cnt_with_this_nm_addr_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.mname_cnt_with_this_nm_addr_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.dids_with_this_nm_ssn_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.dob_cnt_with_this_nm_ssn_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.dids_with_this_nm_dob_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.zip_cnt_with_this_nm_dob_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.src_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.did_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.fname_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.lname_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.prim_range_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.prim_name_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.zip_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.mname_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.sec_range_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.name_suffix_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.ssn_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.dob_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.dids_with_this_nm_addr_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.suffix_cnt_with_this_nm_addr_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.sec_range_cnt_with_this_nm_addr_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.ssn_cnt_with_this_nm_addr_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.dob_cnt_with_this_nm_addr_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.mname_cnt_with_this_nm_addr_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.dids_with_this_nm_ssn_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.dob_cnt_with_this_nm_ssn_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.dids_with_this_nm_dob_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.zip_cnt_with_this_nm_dob_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    src_ALLOW_ErrorCount := COUNT(GROUP,h.src_Invalid=1);
    src_ALLOW_WouldModifyCount := COUNT(GROUP,h.src_Invalid=1 AND h.src_wouldClean);
    src_LENGTHS_ErrorCount := COUNT(GROUP,h.src_Invalid=2);
    src_LENGTHS_WouldModifyCount := COUNT(GROUP,h.src_Invalid=2 AND h.src_wouldClean);
    src_WORDS_ErrorCount := COUNT(GROUP,h.src_Invalid=3);
    src_WORDS_WouldModifyCount := COUNT(GROUP,h.src_Invalid=3 AND h.src_wouldClean);
    src_Total_ErrorCount := COUNT(GROUP,h.src_Invalid>0);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_ALLOW_WouldModifyCount := COUNT(GROUP,h.did_Invalid=1 AND h.did_wouldClean);
    did_WORDS_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_WORDS_WouldModifyCount := COUNT(GROUP,h.did_Invalid=2 AND h.did_wouldClean);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_WouldModifyCount := COUNT(GROUP,h.fname_Invalid=1 AND h.fname_wouldClean);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_WouldModifyCount := COUNT(GROUP,h.lname_Invalid=1 AND h.lname_wouldClean);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_range_Invalid=1 AND h.prim_range_wouldClean);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_name_Invalid=1 AND h.prim_name_wouldClean);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=1 AND h.zip_wouldClean);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_LENGTHS_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=2 AND h.zip_wouldClean);
    zip_WORDS_ErrorCount := COUNT(GROUP,h.zip_Invalid=3);
    zip_WORDS_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=3 AND h.zip_wouldClean);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_WouldModifyCount := COUNT(GROUP,h.mname_Invalid=1 AND h.mname_wouldClean);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.sec_range_Invalid=1 AND h.sec_range_wouldClean);
    sec_range_LENGTHS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_LENGTHS_WouldModifyCount := COUNT(GROUP,h.sec_range_Invalid=2 AND h.sec_range_wouldClean);
    sec_range_WORDS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=3);
    sec_range_WORDS_WouldModifyCount := COUNT(GROUP,h.sec_range_Invalid=3 AND h.sec_range_wouldClean);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=1 AND h.name_suffix_wouldClean);
    name_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_LENGTHS_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=2 AND h.name_suffix_wouldClean);
    name_suffix_WORDS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=3);
    name_suffix_WORDS_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=3 AND h.name_suffix_wouldClean);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=1 AND h.ssn_wouldClean);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_ALLOW_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=1 AND h.dob_wouldClean);
    dids_with_this_nm_addr_ALLOW_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_addr_Invalid=1);
    dids_with_this_nm_addr_ALLOW_WouldModifyCount := COUNT(GROUP,h.dids_with_this_nm_addr_Invalid=1 AND h.dids_with_this_nm_addr_wouldClean);
    dids_with_this_nm_addr_LENGTHS_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_addr_Invalid=2);
    dids_with_this_nm_addr_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dids_with_this_nm_addr_Invalid=2 AND h.dids_with_this_nm_addr_wouldClean);
    dids_with_this_nm_addr_WORDS_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_addr_Invalid=3);
    dids_with_this_nm_addr_WORDS_WouldModifyCount := COUNT(GROUP,h.dids_with_this_nm_addr_Invalid=3 AND h.dids_with_this_nm_addr_wouldClean);
    dids_with_this_nm_addr_Total_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_addr_Invalid>0);
    suffix_cnt_with_this_nm_addr_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_cnt_with_this_nm_addr_Invalid=1);
    suffix_cnt_with_this_nm_addr_ALLOW_WouldModifyCount := COUNT(GROUP,h.suffix_cnt_with_this_nm_addr_Invalid=1 AND h.suffix_cnt_with_this_nm_addr_wouldClean);
    suffix_cnt_with_this_nm_addr_LENGTHS_ErrorCount := COUNT(GROUP,h.suffix_cnt_with_this_nm_addr_Invalid=2);
    suffix_cnt_with_this_nm_addr_LENGTHS_WouldModifyCount := COUNT(GROUP,h.suffix_cnt_with_this_nm_addr_Invalid=2 AND h.suffix_cnt_with_this_nm_addr_wouldClean);
    suffix_cnt_with_this_nm_addr_WORDS_ErrorCount := COUNT(GROUP,h.suffix_cnt_with_this_nm_addr_Invalid=3);
    suffix_cnt_with_this_nm_addr_WORDS_WouldModifyCount := COUNT(GROUP,h.suffix_cnt_with_this_nm_addr_Invalid=3 AND h.suffix_cnt_with_this_nm_addr_wouldClean);
    suffix_cnt_with_this_nm_addr_Total_ErrorCount := COUNT(GROUP,h.suffix_cnt_with_this_nm_addr_Invalid>0);
    sec_range_cnt_with_this_nm_addr_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_cnt_with_this_nm_addr_Invalid=1);
    sec_range_cnt_with_this_nm_addr_ALLOW_WouldModifyCount := COUNT(GROUP,h.sec_range_cnt_with_this_nm_addr_Invalid=1 AND h.sec_range_cnt_with_this_nm_addr_wouldClean);
    sec_range_cnt_with_this_nm_addr_LENGTHS_ErrorCount := COUNT(GROUP,h.sec_range_cnt_with_this_nm_addr_Invalid=2);
    sec_range_cnt_with_this_nm_addr_LENGTHS_WouldModifyCount := COUNT(GROUP,h.sec_range_cnt_with_this_nm_addr_Invalid=2 AND h.sec_range_cnt_with_this_nm_addr_wouldClean);
    sec_range_cnt_with_this_nm_addr_WORDS_ErrorCount := COUNT(GROUP,h.sec_range_cnt_with_this_nm_addr_Invalid=3);
    sec_range_cnt_with_this_nm_addr_WORDS_WouldModifyCount := COUNT(GROUP,h.sec_range_cnt_with_this_nm_addr_Invalid=3 AND h.sec_range_cnt_with_this_nm_addr_wouldClean);
    sec_range_cnt_with_this_nm_addr_Total_ErrorCount := COUNT(GROUP,h.sec_range_cnt_with_this_nm_addr_Invalid>0);
    ssn_cnt_with_this_nm_addr_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_cnt_with_this_nm_addr_Invalid=1);
    ssn_cnt_with_this_nm_addr_ALLOW_WouldModifyCount := COUNT(GROUP,h.ssn_cnt_with_this_nm_addr_Invalid=1 AND h.ssn_cnt_with_this_nm_addr_wouldClean);
    ssn_cnt_with_this_nm_addr_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn_cnt_with_this_nm_addr_Invalid=2);
    ssn_cnt_with_this_nm_addr_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ssn_cnt_with_this_nm_addr_Invalid=2 AND h.ssn_cnt_with_this_nm_addr_wouldClean);
    ssn_cnt_with_this_nm_addr_WORDS_ErrorCount := COUNT(GROUP,h.ssn_cnt_with_this_nm_addr_Invalid=3);
    ssn_cnt_with_this_nm_addr_WORDS_WouldModifyCount := COUNT(GROUP,h.ssn_cnt_with_this_nm_addr_Invalid=3 AND h.ssn_cnt_with_this_nm_addr_wouldClean);
    ssn_cnt_with_this_nm_addr_Total_ErrorCount := COUNT(GROUP,h.ssn_cnt_with_this_nm_addr_Invalid>0);
    dob_cnt_with_this_nm_addr_ALLOW_ErrorCount := COUNT(GROUP,h.dob_cnt_with_this_nm_addr_Invalid=1);
    dob_cnt_with_this_nm_addr_ALLOW_WouldModifyCount := COUNT(GROUP,h.dob_cnt_with_this_nm_addr_Invalid=1 AND h.dob_cnt_with_this_nm_addr_wouldClean);
    dob_cnt_with_this_nm_addr_LENGTHS_ErrorCount := COUNT(GROUP,h.dob_cnt_with_this_nm_addr_Invalid=2);
    dob_cnt_with_this_nm_addr_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dob_cnt_with_this_nm_addr_Invalid=2 AND h.dob_cnt_with_this_nm_addr_wouldClean);
    dob_cnt_with_this_nm_addr_WORDS_ErrorCount := COUNT(GROUP,h.dob_cnt_with_this_nm_addr_Invalid=3);
    dob_cnt_with_this_nm_addr_WORDS_WouldModifyCount := COUNT(GROUP,h.dob_cnt_with_this_nm_addr_Invalid=3 AND h.dob_cnt_with_this_nm_addr_wouldClean);
    dob_cnt_with_this_nm_addr_Total_ErrorCount := COUNT(GROUP,h.dob_cnt_with_this_nm_addr_Invalid>0);
    mname_cnt_with_this_nm_addr_ALLOW_ErrorCount := COUNT(GROUP,h.mname_cnt_with_this_nm_addr_Invalid=1);
    mname_cnt_with_this_nm_addr_ALLOW_WouldModifyCount := COUNT(GROUP,h.mname_cnt_with_this_nm_addr_Invalid=1 AND h.mname_cnt_with_this_nm_addr_wouldClean);
    mname_cnt_with_this_nm_addr_LENGTHS_ErrorCount := COUNT(GROUP,h.mname_cnt_with_this_nm_addr_Invalid=2);
    mname_cnt_with_this_nm_addr_LENGTHS_WouldModifyCount := COUNT(GROUP,h.mname_cnt_with_this_nm_addr_Invalid=2 AND h.mname_cnt_with_this_nm_addr_wouldClean);
    mname_cnt_with_this_nm_addr_WORDS_ErrorCount := COUNT(GROUP,h.mname_cnt_with_this_nm_addr_Invalid=3);
    mname_cnt_with_this_nm_addr_WORDS_WouldModifyCount := COUNT(GROUP,h.mname_cnt_with_this_nm_addr_Invalid=3 AND h.mname_cnt_with_this_nm_addr_wouldClean);
    mname_cnt_with_this_nm_addr_Total_ErrorCount := COUNT(GROUP,h.mname_cnt_with_this_nm_addr_Invalid>0);
    dids_with_this_nm_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_ssn_Invalid=1);
    dids_with_this_nm_ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.dids_with_this_nm_ssn_Invalid=1 AND h.dids_with_this_nm_ssn_wouldClean);
    dids_with_this_nm_ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_ssn_Invalid=2);
    dids_with_this_nm_ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dids_with_this_nm_ssn_Invalid=2 AND h.dids_with_this_nm_ssn_wouldClean);
    dids_with_this_nm_ssn_WORDS_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_ssn_Invalid=3);
    dids_with_this_nm_ssn_WORDS_WouldModifyCount := COUNT(GROUP,h.dids_with_this_nm_ssn_Invalid=3 AND h.dids_with_this_nm_ssn_wouldClean);
    dids_with_this_nm_ssn_Total_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_ssn_Invalid>0);
    dob_cnt_with_this_nm_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.dob_cnt_with_this_nm_ssn_Invalid=1);
    dob_cnt_with_this_nm_ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.dob_cnt_with_this_nm_ssn_Invalid=1 AND h.dob_cnt_with_this_nm_ssn_wouldClean);
    dob_cnt_with_this_nm_ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.dob_cnt_with_this_nm_ssn_Invalid=2);
    dob_cnt_with_this_nm_ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dob_cnt_with_this_nm_ssn_Invalid=2 AND h.dob_cnt_with_this_nm_ssn_wouldClean);
    dob_cnt_with_this_nm_ssn_WORDS_ErrorCount := COUNT(GROUP,h.dob_cnt_with_this_nm_ssn_Invalid=3);
    dob_cnt_with_this_nm_ssn_WORDS_WouldModifyCount := COUNT(GROUP,h.dob_cnt_with_this_nm_ssn_Invalid=3 AND h.dob_cnt_with_this_nm_ssn_wouldClean);
    dob_cnt_with_this_nm_ssn_Total_ErrorCount := COUNT(GROUP,h.dob_cnt_with_this_nm_ssn_Invalid>0);
    dids_with_this_nm_dob_ALLOW_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_dob_Invalid=1);
    dids_with_this_nm_dob_ALLOW_WouldModifyCount := COUNT(GROUP,h.dids_with_this_nm_dob_Invalid=1 AND h.dids_with_this_nm_dob_wouldClean);
    dids_with_this_nm_dob_LENGTHS_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_dob_Invalid=2);
    dids_with_this_nm_dob_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dids_with_this_nm_dob_Invalid=2 AND h.dids_with_this_nm_dob_wouldClean);
    dids_with_this_nm_dob_WORDS_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_dob_Invalid=3);
    dids_with_this_nm_dob_WORDS_WouldModifyCount := COUNT(GROUP,h.dids_with_this_nm_dob_Invalid=3 AND h.dids_with_this_nm_dob_wouldClean);
    dids_with_this_nm_dob_Total_ErrorCount := COUNT(GROUP,h.dids_with_this_nm_dob_Invalid>0);
    zip_cnt_with_this_nm_dob_ALLOW_ErrorCount := COUNT(GROUP,h.zip_cnt_with_this_nm_dob_Invalid=1);
    zip_cnt_with_this_nm_dob_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip_cnt_with_this_nm_dob_Invalid=1 AND h.zip_cnt_with_this_nm_dob_wouldClean);
    zip_cnt_with_this_nm_dob_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_cnt_with_this_nm_dob_Invalid=2);
    zip_cnt_with_this_nm_dob_LENGTHS_WouldModifyCount := COUNT(GROUP,h.zip_cnt_with_this_nm_dob_Invalid=2 AND h.zip_cnt_with_this_nm_dob_wouldClean);
    zip_cnt_with_this_nm_dob_WORDS_ErrorCount := COUNT(GROUP,h.zip_cnt_with_this_nm_dob_Invalid=3);
    zip_cnt_with_this_nm_dob_WORDS_WouldModifyCount := COUNT(GROUP,h.zip_cnt_with_this_nm_dob_Invalid=3 AND h.zip_cnt_with_this_nm_dob_wouldClean);
    zip_cnt_with_this_nm_dob_Total_ErrorCount := COUNT(GROUP,h.zip_cnt_with_this_nm_dob_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.src_Invalid > 0 OR h.did_Invalid > 0 OR h.fname_Invalid > 0 OR h.lname_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.zip_Invalid > 0 OR h.mname_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.ssn_Invalid > 0 OR h.dob_Invalid > 0 OR h.dids_with_this_nm_addr_Invalid > 0 OR h.suffix_cnt_with_this_nm_addr_Invalid > 0 OR h.sec_range_cnt_with_this_nm_addr_Invalid > 0 OR h.ssn_cnt_with_this_nm_addr_Invalid > 0 OR h.dob_cnt_with_this_nm_addr_Invalid > 0 OR h.mname_cnt_with_this_nm_addr_Invalid > 0 OR h.dids_with_this_nm_ssn_Invalid > 0 OR h.dob_cnt_with_this_nm_ssn_Invalid > 0 OR h.dids_with_this_nm_dob_Invalid > 0 OR h.zip_cnt_with_this_nm_dob_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.src_wouldClean OR h.did_wouldClean OR h.fname_wouldClean OR h.lname_wouldClean OR h.prim_range_wouldClean OR h.prim_name_wouldClean OR h.zip_wouldClean OR h.mname_wouldClean OR h.sec_range_wouldClean OR h.name_suffix_wouldClean OR h.ssn_wouldClean OR h.dob_wouldClean OR h.dids_with_this_nm_addr_wouldClean OR h.suffix_cnt_with_this_nm_addr_wouldClean OR h.sec_range_cnt_with_this_nm_addr_wouldClean OR h.ssn_cnt_with_this_nm_addr_wouldClean OR h.dob_cnt_with_this_nm_addr_wouldClean OR h.mname_cnt_with_this_nm_addr_wouldClean OR h.dids_with_this_nm_ssn_wouldClean OR h.dob_cnt_with_this_nm_ssn_wouldClean OR h.dids_with_this_nm_dob_wouldClean OR h.zip_cnt_with_this_nm_dob_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.src_Total_ErrorCount > 0, 1, 0) + IF(le.did_Total_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_Total_ErrorCount > 0, 1, 0) + IF(le.name_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_addr_Total_ErrorCount > 0, 1, 0) + IF(le.suffix_cnt_with_this_nm_addr_Total_ErrorCount > 0, 1, 0) + IF(le.sec_range_cnt_with_this_nm_addr_Total_ErrorCount > 0, 1, 0) + IF(le.ssn_cnt_with_this_nm_addr_Total_ErrorCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_addr_Total_ErrorCount > 0, 1, 0) + IF(le.mname_cnt_with_this_nm_addr_Total_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_dob_Total_ErrorCount > 0, 1, 0) + IF(le.zip_cnt_with_this_nm_dob_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.src_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.src_WORDS_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_WORDS_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_WORDS_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sec_range_WORDS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_addr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_addr_WORDS_ErrorCount > 0, 1, 0) + IF(le.suffix_cnt_with_this_nm_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_cnt_with_this_nm_addr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.suffix_cnt_with_this_nm_addr_WORDS_ErrorCount > 0, 1, 0) + IF(le.sec_range_cnt_with_this_nm_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_cnt_with_this_nm_addr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sec_range_cnt_with_this_nm_addr_WORDS_ErrorCount > 0, 1, 0) + IF(le.ssn_cnt_with_this_nm_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_cnt_with_this_nm_addr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ssn_cnt_with_this_nm_addr_WORDS_ErrorCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_addr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_addr_WORDS_ErrorCount > 0, 1, 0) + IF(le.mname_cnt_with_this_nm_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_cnt_with_this_nm_addr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mname_cnt_with_this_nm_addr_WORDS_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_ssn_WORDS_ErrorCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_ssn_WORDS_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dids_with_this_nm_dob_WORDS_ErrorCount > 0, 1, 0) + IF(le.zip_cnt_with_this_nm_dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_cnt_with_this_nm_dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_cnt_with_this_nm_dob_WORDS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.src_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.src_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.src_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.did_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.did_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.fname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.prim_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.zip_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.mname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dob_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dids_with_this_nm_addr_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dids_with_this_nm_addr_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dids_with_this_nm_addr_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.suffix_cnt_with_this_nm_addr_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.suffix_cnt_with_this_nm_addr_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.suffix_cnt_with_this_nm_addr_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_cnt_with_this_nm_addr_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_cnt_with_this_nm_addr_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_cnt_with_this_nm_addr_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.ssn_cnt_with_this_nm_addr_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ssn_cnt_with_this_nm_addr_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ssn_cnt_with_this_nm_addr_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_addr_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_addr_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_addr_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.mname_cnt_with_this_nm_addr_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mname_cnt_with_this_nm_addr_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.mname_cnt_with_this_nm_addr_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dids_with_this_nm_ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dids_with_this_nm_ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dids_with_this_nm_ssn_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dob_cnt_with_this_nm_ssn_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dids_with_this_nm_dob_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dids_with_this_nm_dob_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dids_with_this_nm_dob_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.zip_cnt_with_this_nm_dob_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_cnt_with_this_nm_dob_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.zip_cnt_with_this_nm_dob_WORDS_WouldModifyCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.src_Invalid,le.did_Invalid,le.fname_Invalid,le.lname_Invalid,le.prim_range_Invalid,le.prim_name_Invalid,le.zip_Invalid,le.mname_Invalid,le.sec_range_Invalid,le.name_suffix_Invalid,le.ssn_Invalid,le.dob_Invalid,le.dids_with_this_nm_addr_Invalid,le.suffix_cnt_with_this_nm_addr_Invalid,le.sec_range_cnt_with_this_nm_addr_Invalid,le.ssn_cnt_with_this_nm_addr_Invalid,le.dob_cnt_with_this_nm_addr_Invalid,le.mname_cnt_with_this_nm_addr_Invalid,le.dids_with_this_nm_ssn_Invalid,le.dob_cnt_with_this_nm_ssn_Invalid,le.dids_with_this_nm_dob_Invalid,le.zip_cnt_with_this_nm_dob_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_src(le.src_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_dids_with_this_nm_addr(le.dids_with_this_nm_addr_Invalid),Fields.InvalidMessage_suffix_cnt_with_this_nm_addr(le.suffix_cnt_with_this_nm_addr_Invalid),Fields.InvalidMessage_sec_range_cnt_with_this_nm_addr(le.sec_range_cnt_with_this_nm_addr_Invalid),Fields.InvalidMessage_ssn_cnt_with_this_nm_addr(le.ssn_cnt_with_this_nm_addr_Invalid),Fields.InvalidMessage_dob_cnt_with_this_nm_addr(le.dob_cnt_with_this_nm_addr_Invalid),Fields.InvalidMessage_mname_cnt_with_this_nm_addr(le.mname_cnt_with_this_nm_addr_Invalid),Fields.InvalidMessage_dids_with_this_nm_ssn(le.dids_with_this_nm_ssn_Invalid),Fields.InvalidMessage_dob_cnt_with_this_nm_ssn(le.dob_cnt_with_this_nm_ssn_Invalid),Fields.InvalidMessage_dids_with_this_nm_dob(le.dids_with_this_nm_dob_Invalid),Fields.InvalidMessage_zip_cnt_with_this_nm_dob(le.zip_cnt_with_this_nm_dob_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.src_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dids_with_this_nm_addr_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.suffix_cnt_with_this_nm_addr_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.sec_range_cnt_with_this_nm_addr_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_cnt_with_this_nm_addr_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dob_cnt_with_this_nm_addr_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.mname_cnt_with_this_nm_addr_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dids_with_this_nm_ssn_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dob_cnt_with_this_nm_ssn_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dids_with_this_nm_dob_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.zip_cnt_with_this_nm_dob_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'src','did','fname','lname','prim_range','prim_name','zip','mname','sec_range','name_suffix','ssn','dob','dids_with_this_nm_addr','suffix_cnt_with_this_nm_addr','sec_range_cnt_with_this_nm_addr','ssn_cnt_with_this_nm_addr','dob_cnt_with_this_nm_addr','mname_cnt_with_this_nm_addr','dids_with_this_nm_ssn','dob_cnt_with_this_nm_ssn','dids_with_this_nm_dob','zip_cnt_with_this_nm_dob','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'src','did','fname','lname','prim_range','prim_name','zip','mname','sec_range','name_suffix','ssn','dob','dids_with_this_nm_addr','suffix_cnt_with_this_nm_addr','sec_range_cnt_with_this_nm_addr','ssn_cnt_with_this_nm_addr','dob_cnt_with_this_nm_addr','mname_cnt_with_this_nm_addr','dids_with_this_nm_ssn','dob_cnt_with_this_nm_ssn','dids_with_this_nm_dob','zip_cnt_with_this_nm_dob','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.src,(SALT39.StrType)le.did,(SALT39.StrType)le.fname,(SALT39.StrType)le.lname,(SALT39.StrType)le.prim_range,(SALT39.StrType)le.prim_name,(SALT39.StrType)le.zip,(SALT39.StrType)le.mname,(SALT39.StrType)le.sec_range,(SALT39.StrType)le.name_suffix,(SALT39.StrType)le.ssn,(SALT39.StrType)le.dob,(SALT39.StrType)le.dids_with_this_nm_addr,(SALT39.StrType)le.suffix_cnt_with_this_nm_addr,(SALT39.StrType)le.sec_range_cnt_with_this_nm_addr,(SALT39.StrType)le.ssn_cnt_with_this_nm_addr,(SALT39.StrType)le.dob_cnt_with_this_nm_addr,(SALT39.StrType)le.mname_cnt_with_this_nm_addr,(SALT39.StrType)le.dids_with_this_nm_ssn,(SALT39.StrType)le.dob_cnt_with_this_nm_ssn,(SALT39.StrType)le.dids_with_this_nm_dob,(SALT39.StrType)le.zip_cnt_with_this_nm_dob,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,22,Into(LEFT,COUNTER));
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
          ,'src:src:ALLOW','src:src:LENGTHS','src:src:WORDS'
          ,'did:did:ALLOW','did:did:WORDS'
          ,'fname:fname:ALLOW'
          ,'lname:lname:ALLOW'
          ,'prim_range:prim_range:ALLOW'
          ,'prim_name:prim_name:ALLOW'
          ,'zip:zip:ALLOW','zip:zip:LENGTHS','zip:zip:WORDS'
          ,'mname:mname:ALLOW'
          ,'sec_range:sec_range:ALLOW','sec_range:sec_range:LENGTHS','sec_range:sec_range:WORDS'
          ,'name_suffix:name_suffix:ALLOW','name_suffix:name_suffix:LENGTHS','name_suffix:name_suffix:WORDS'
          ,'ssn:ssn:ALLOW'
          ,'dob:dob:ALLOW'
          ,'dids_with_this_nm_addr:dids_with_this_nm_addr:ALLOW','dids_with_this_nm_addr:dids_with_this_nm_addr:LENGTHS','dids_with_this_nm_addr:dids_with_this_nm_addr:WORDS'
          ,'suffix_cnt_with_this_nm_addr:suffix_cnt_with_this_nm_addr:ALLOW','suffix_cnt_with_this_nm_addr:suffix_cnt_with_this_nm_addr:LENGTHS','suffix_cnt_with_this_nm_addr:suffix_cnt_with_this_nm_addr:WORDS'
          ,'sec_range_cnt_with_this_nm_addr:sec_range_cnt_with_this_nm_addr:ALLOW','sec_range_cnt_with_this_nm_addr:sec_range_cnt_with_this_nm_addr:LENGTHS','sec_range_cnt_with_this_nm_addr:sec_range_cnt_with_this_nm_addr:WORDS'
          ,'ssn_cnt_with_this_nm_addr:ssn_cnt_with_this_nm_addr:ALLOW','ssn_cnt_with_this_nm_addr:ssn_cnt_with_this_nm_addr:LENGTHS','ssn_cnt_with_this_nm_addr:ssn_cnt_with_this_nm_addr:WORDS'
          ,'dob_cnt_with_this_nm_addr:dob_cnt_with_this_nm_addr:ALLOW','dob_cnt_with_this_nm_addr:dob_cnt_with_this_nm_addr:LENGTHS','dob_cnt_with_this_nm_addr:dob_cnt_with_this_nm_addr:WORDS'
          ,'mname_cnt_with_this_nm_addr:mname_cnt_with_this_nm_addr:ALLOW','mname_cnt_with_this_nm_addr:mname_cnt_with_this_nm_addr:LENGTHS','mname_cnt_with_this_nm_addr:mname_cnt_with_this_nm_addr:WORDS'
          ,'dids_with_this_nm_ssn:dids_with_this_nm_ssn:ALLOW','dids_with_this_nm_ssn:dids_with_this_nm_ssn:LENGTHS','dids_with_this_nm_ssn:dids_with_this_nm_ssn:WORDS'
          ,'dob_cnt_with_this_nm_ssn:dob_cnt_with_this_nm_ssn:ALLOW','dob_cnt_with_this_nm_ssn:dob_cnt_with_this_nm_ssn:LENGTHS','dob_cnt_with_this_nm_ssn:dob_cnt_with_this_nm_ssn:WORDS'
          ,'dids_with_this_nm_dob:dids_with_this_nm_dob:ALLOW','dids_with_this_nm_dob:dids_with_this_nm_dob:LENGTHS','dids_with_this_nm_dob:dids_with_this_nm_dob:WORDS'
          ,'zip_cnt_with_this_nm_dob:zip_cnt_with_this_nm_dob:ALLOW','zip_cnt_with_this_nm_dob:zip_cnt_with_this_nm_dob:LENGTHS','zip_cnt_with_this_nm_dob:zip_cnt_with_this_nm_dob:WORDS'
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
          ,Fields.InvalidMessage_src(1),Fields.InvalidMessage_src(2),Fields.InvalidMessage_src(3)
          ,Fields.InvalidMessage_did(1),Fields.InvalidMessage_did(2)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2),Fields.InvalidMessage_zip(3)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_sec_range(1),Fields.InvalidMessage_sec_range(2),Fields.InvalidMessage_sec_range(3)
          ,Fields.InvalidMessage_name_suffix(1),Fields.InvalidMessage_name_suffix(2),Fields.InvalidMessage_name_suffix(3)
          ,Fields.InvalidMessage_ssn(1)
          ,Fields.InvalidMessage_dob(1)
          ,Fields.InvalidMessage_dids_with_this_nm_addr(1),Fields.InvalidMessage_dids_with_this_nm_addr(2),Fields.InvalidMessage_dids_with_this_nm_addr(3)
          ,Fields.InvalidMessage_suffix_cnt_with_this_nm_addr(1),Fields.InvalidMessage_suffix_cnt_with_this_nm_addr(2),Fields.InvalidMessage_suffix_cnt_with_this_nm_addr(3)
          ,Fields.InvalidMessage_sec_range_cnt_with_this_nm_addr(1),Fields.InvalidMessage_sec_range_cnt_with_this_nm_addr(2),Fields.InvalidMessage_sec_range_cnt_with_this_nm_addr(3)
          ,Fields.InvalidMessage_ssn_cnt_with_this_nm_addr(1),Fields.InvalidMessage_ssn_cnt_with_this_nm_addr(2),Fields.InvalidMessage_ssn_cnt_with_this_nm_addr(3)
          ,Fields.InvalidMessage_dob_cnt_with_this_nm_addr(1),Fields.InvalidMessage_dob_cnt_with_this_nm_addr(2),Fields.InvalidMessage_dob_cnt_with_this_nm_addr(3)
          ,Fields.InvalidMessage_mname_cnt_with_this_nm_addr(1),Fields.InvalidMessage_mname_cnt_with_this_nm_addr(2),Fields.InvalidMessage_mname_cnt_with_this_nm_addr(3)
          ,Fields.InvalidMessage_dids_with_this_nm_ssn(1),Fields.InvalidMessage_dids_with_this_nm_ssn(2),Fields.InvalidMessage_dids_with_this_nm_ssn(3)
          ,Fields.InvalidMessage_dob_cnt_with_this_nm_ssn(1),Fields.InvalidMessage_dob_cnt_with_this_nm_ssn(2),Fields.InvalidMessage_dob_cnt_with_this_nm_ssn(3)
          ,Fields.InvalidMessage_dids_with_this_nm_dob(1),Fields.InvalidMessage_dids_with_this_nm_dob(2),Fields.InvalidMessage_dids_with_this_nm_dob(3)
          ,Fields.InvalidMessage_zip_cnt_with_this_nm_dob(1),Fields.InvalidMessage_zip_cnt_with_this_nm_dob(2),Fields.InvalidMessage_zip_cnt_with_this_nm_dob(3)
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
          ,le.src_ALLOW_ErrorCount,le.src_LENGTHS_ErrorCount,le.src_WORDS_ErrorCount
          ,le.did_ALLOW_ErrorCount,le.did_WORDS_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTHS_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTHS_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.ssn_ALLOW_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.dids_with_this_nm_addr_ALLOW_ErrorCount,le.dids_with_this_nm_addr_LENGTHS_ErrorCount,le.dids_with_this_nm_addr_WORDS_ErrorCount
          ,le.suffix_cnt_with_this_nm_addr_ALLOW_ErrorCount,le.suffix_cnt_with_this_nm_addr_LENGTHS_ErrorCount,le.suffix_cnt_with_this_nm_addr_WORDS_ErrorCount
          ,le.sec_range_cnt_with_this_nm_addr_ALLOW_ErrorCount,le.sec_range_cnt_with_this_nm_addr_LENGTHS_ErrorCount,le.sec_range_cnt_with_this_nm_addr_WORDS_ErrorCount
          ,le.ssn_cnt_with_this_nm_addr_ALLOW_ErrorCount,le.ssn_cnt_with_this_nm_addr_LENGTHS_ErrorCount,le.ssn_cnt_with_this_nm_addr_WORDS_ErrorCount
          ,le.dob_cnt_with_this_nm_addr_ALLOW_ErrorCount,le.dob_cnt_with_this_nm_addr_LENGTHS_ErrorCount,le.dob_cnt_with_this_nm_addr_WORDS_ErrorCount
          ,le.mname_cnt_with_this_nm_addr_ALLOW_ErrorCount,le.mname_cnt_with_this_nm_addr_LENGTHS_ErrorCount,le.mname_cnt_with_this_nm_addr_WORDS_ErrorCount
          ,le.dids_with_this_nm_ssn_ALLOW_ErrorCount,le.dids_with_this_nm_ssn_LENGTHS_ErrorCount,le.dids_with_this_nm_ssn_WORDS_ErrorCount
          ,le.dob_cnt_with_this_nm_ssn_ALLOW_ErrorCount,le.dob_cnt_with_this_nm_ssn_LENGTHS_ErrorCount,le.dob_cnt_with_this_nm_ssn_WORDS_ErrorCount
          ,le.dids_with_this_nm_dob_ALLOW_ErrorCount,le.dids_with_this_nm_dob_LENGTHS_ErrorCount,le.dids_with_this_nm_dob_WORDS_ErrorCount
          ,le.zip_cnt_with_this_nm_dob_ALLOW_ErrorCount,le.zip_cnt_with_this_nm_dob_LENGTHS_ErrorCount,le.zip_cnt_with_this_nm_dob_WORDS_ErrorCount
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
          ,le.src_ALLOW_ErrorCount,le.src_LENGTHS_ErrorCount,le.src_WORDS_ErrorCount
          ,le.did_ALLOW_ErrorCount,le.did_WORDS_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTHS_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTHS_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.ssn_ALLOW_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.dids_with_this_nm_addr_ALLOW_ErrorCount,le.dids_with_this_nm_addr_LENGTHS_ErrorCount,le.dids_with_this_nm_addr_WORDS_ErrorCount
          ,le.suffix_cnt_with_this_nm_addr_ALLOW_ErrorCount,le.suffix_cnt_with_this_nm_addr_LENGTHS_ErrorCount,le.suffix_cnt_with_this_nm_addr_WORDS_ErrorCount
          ,le.sec_range_cnt_with_this_nm_addr_ALLOW_ErrorCount,le.sec_range_cnt_with_this_nm_addr_LENGTHS_ErrorCount,le.sec_range_cnt_with_this_nm_addr_WORDS_ErrorCount
          ,le.ssn_cnt_with_this_nm_addr_ALLOW_ErrorCount,le.ssn_cnt_with_this_nm_addr_LENGTHS_ErrorCount,le.ssn_cnt_with_this_nm_addr_WORDS_ErrorCount
          ,le.dob_cnt_with_this_nm_addr_ALLOW_ErrorCount,le.dob_cnt_with_this_nm_addr_LENGTHS_ErrorCount,le.dob_cnt_with_this_nm_addr_WORDS_ErrorCount
          ,le.mname_cnt_with_this_nm_addr_ALLOW_ErrorCount,le.mname_cnt_with_this_nm_addr_LENGTHS_ErrorCount,le.mname_cnt_with_this_nm_addr_WORDS_ErrorCount
          ,le.dids_with_this_nm_ssn_ALLOW_ErrorCount,le.dids_with_this_nm_ssn_LENGTHS_ErrorCount,le.dids_with_this_nm_ssn_WORDS_ErrorCount
          ,le.dob_cnt_with_this_nm_ssn_ALLOW_ErrorCount,le.dob_cnt_with_this_nm_ssn_LENGTHS_ErrorCount,le.dob_cnt_with_this_nm_ssn_WORDS_ErrorCount
          ,le.dids_with_this_nm_dob_ALLOW_ErrorCount,le.dids_with_this_nm_dob_LENGTHS_ErrorCount,le.dids_with_this_nm_dob_WORDS_ErrorCount
          ,le.zip_cnt_with_this_nm_dob_ALLOW_ErrorCount,le.zip_cnt_with_this_nm_dob_LENGTHS_ErrorCount,le.zip_cnt_with_this_nm_dob_WORDS_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
          ,'src:' + getFieldTypeText(h.src) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dids_with_this_nm_addr:' + getFieldTypeText(h.dids_with_this_nm_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix_cnt_with_this_nm_addr:' + getFieldTypeText(h.suffix_cnt_with_this_nm_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range_cnt_with_this_nm_addr:' + getFieldTypeText(h.sec_range_cnt_with_this_nm_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn_cnt_with_this_nm_addr:' + getFieldTypeText(h.ssn_cnt_with_this_nm_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob_cnt_with_this_nm_addr:' + getFieldTypeText(h.dob_cnt_with_this_nm_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname_cnt_with_this_nm_addr:' + getFieldTypeText(h.mname_cnt_with_this_nm_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dids_with_this_nm_ssn:' + getFieldTypeText(h.dids_with_this_nm_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob_cnt_with_this_nm_ssn:' + getFieldTypeText(h.dob_cnt_with_this_nm_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dids_with_this_nm_dob:' + getFieldTypeText(h.dids_with_this_nm_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_cnt_with_this_nm_dob:' + getFieldTypeText(h.zip_cnt_with_this_nm_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_src_cnt
          ,le.populated_did_cnt
          ,le.populated_fname_cnt
          ,le.populated_lname_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_zip_cnt
          ,le.populated_mname_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_ssn_cnt
          ,le.populated_dob_cnt
          ,le.populated_dids_with_this_nm_addr_cnt
          ,le.populated_suffix_cnt_with_this_nm_addr_cnt
          ,le.populated_sec_range_cnt_with_this_nm_addr_cnt
          ,le.populated_ssn_cnt_with_this_nm_addr_cnt
          ,le.populated_dob_cnt_with_this_nm_addr_cnt
          ,le.populated_mname_cnt_with_this_nm_addr_cnt
          ,le.populated_dids_with_this_nm_ssn_cnt
          ,le.populated_dob_cnt_with_this_nm_ssn_cnt
          ,le.populated_dids_with_this_nm_dob_cnt
          ,le.populated_zip_cnt_with_this_nm_dob_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_src_pcnt
          ,le.populated_did_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_dids_with_this_nm_addr_pcnt
          ,le.populated_suffix_cnt_with_this_nm_addr_pcnt
          ,le.populated_sec_range_cnt_with_this_nm_addr_pcnt
          ,le.populated_ssn_cnt_with_this_nm_addr_pcnt
          ,le.populated_dob_cnt_with_this_nm_addr_pcnt
          ,le.populated_mname_cnt_with_this_nm_addr_pcnt
          ,le.populated_dids_with_this_nm_ssn_pcnt
          ,le.populated_dob_cnt_with_this_nm_ssn_pcnt
          ,le.populated_dids_with_this_nm_dob_pcnt
          ,le.populated_zip_cnt_with_this_nm_dob_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,22,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),22,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
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
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_HeaderSlimSortSrc_Monthly, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
