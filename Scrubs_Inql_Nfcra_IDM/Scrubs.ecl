IMPORT SALT39,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 59;
  EXPORT NumRulesFromFieldType := 59;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 20;
  EXPORT NumFieldsWithPossibleEdits := 20;
  EXPORT NumRulesWithPossibleEdits := 59;
  EXPORT Expanded_Layout := RECORD(Layout_FILE)
    UNSIGNED1 orig_transaction_id_Invalid;
    BOOLEAN orig_transaction_id_wouldClean;
    UNSIGNED1 orig_dateadded_Invalid;
    BOOLEAN orig_dateadded_wouldClean;
    UNSIGNED1 orig_billingid_Invalid;
    BOOLEAN orig_billingid_wouldClean;
    UNSIGNED1 orig_function_name_Invalid;
    BOOLEAN orig_function_name_wouldClean;
    UNSIGNED1 orig_adl_Invalid;
    BOOLEAN orig_adl_wouldClean;
    UNSIGNED1 orig_fname_Invalid;
    BOOLEAN orig_fname_wouldClean;
    UNSIGNED1 orig_lname_Invalid;
    BOOLEAN orig_lname_wouldClean;
    UNSIGNED1 orig_mname_Invalid;
    BOOLEAN orig_mname_wouldClean;
    UNSIGNED1 orig_ssn_Invalid;
    BOOLEAN orig_ssn_wouldClean;
    UNSIGNED1 orig_address_Invalid;
    BOOLEAN orig_address_wouldClean;
    UNSIGNED1 orig_city_Invalid;
    BOOLEAN orig_city_wouldClean;
    UNSIGNED1 orig_state_Invalid;
    BOOLEAN orig_state_wouldClean;
    UNSIGNED1 orig_zip_Invalid;
    BOOLEAN orig_zip_wouldClean;
    UNSIGNED1 orig_phone_Invalid;
    BOOLEAN orig_phone_wouldClean;
    UNSIGNED1 orig_dob_Invalid;
    BOOLEAN orig_dob_wouldClean;
    UNSIGNED1 orig_dln_Invalid;
    BOOLEAN orig_dln_wouldClean;
    UNSIGNED1 orig_dln_st_Invalid;
    BOOLEAN orig_dln_st_wouldClean;
    UNSIGNED1 orig_glb_Invalid;
    BOOLEAN orig_glb_wouldClean;
    UNSIGNED1 orig_dppa_Invalid;
    BOOLEAN orig_dppa_wouldClean;
    UNSIGNED1 orig_fcra_Invalid;
    BOOLEAN orig_fcra_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_FILE)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_FILE) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.orig_transaction_id_Invalid := Fields.InValid_orig_transaction_id((SALT39.StrType)le.orig_transaction_id);
    clean_orig_transaction_id := (TYPEOF(le.orig_transaction_id))Fields.Make_orig_transaction_id((SALT39.StrType)le.orig_transaction_id);
    clean_orig_transaction_id_Invalid := Fields.InValid_orig_transaction_id((SALT39.StrType)clean_orig_transaction_id);
    SELF.orig_transaction_id := IF(withOnfail, clean_orig_transaction_id, le.orig_transaction_id); // ONFAIL(CLEAN)
    SELF.orig_transaction_id_wouldClean := TRIM((SALT39.StrType)le.orig_transaction_id) <> TRIM((SALT39.StrType)clean_orig_transaction_id);
    SELF.orig_dateadded_Invalid := Fields.InValid_orig_dateadded((SALT39.StrType)le.orig_dateadded);
    clean_orig_dateadded := (TYPEOF(le.orig_dateadded))Fields.Make_orig_dateadded((SALT39.StrType)le.orig_dateadded);
    clean_orig_dateadded_Invalid := Fields.InValid_orig_dateadded((SALT39.StrType)clean_orig_dateadded);
    SELF.orig_dateadded := IF(withOnfail, clean_orig_dateadded, le.orig_dateadded); // ONFAIL(CLEAN)
    SELF.orig_dateadded_wouldClean := TRIM((SALT39.StrType)le.orig_dateadded) <> TRIM((SALT39.StrType)clean_orig_dateadded);
    SELF.orig_billingid_Invalid := Fields.InValid_orig_billingid((SALT39.StrType)le.orig_billingid);
    clean_orig_billingid := (TYPEOF(le.orig_billingid))Fields.Make_orig_billingid((SALT39.StrType)le.orig_billingid);
    clean_orig_billingid_Invalid := Fields.InValid_orig_billingid((SALT39.StrType)clean_orig_billingid);
    SELF.orig_billingid := IF(withOnfail, clean_orig_billingid, le.orig_billingid); // ONFAIL(CLEAN)
    SELF.orig_billingid_wouldClean := TRIM((SALT39.StrType)le.orig_billingid) <> TRIM((SALT39.StrType)clean_orig_billingid);
    SELF.orig_function_name_Invalid := Fields.InValid_orig_function_name((SALT39.StrType)le.orig_function_name);
    clean_orig_function_name := (TYPEOF(le.orig_function_name))Fields.Make_orig_function_name((SALT39.StrType)le.orig_function_name);
    clean_orig_function_name_Invalid := Fields.InValid_orig_function_name((SALT39.StrType)clean_orig_function_name);
    SELF.orig_function_name := IF(withOnfail, clean_orig_function_name, le.orig_function_name); // ONFAIL(CLEAN)
    SELF.orig_function_name_wouldClean := TRIM((SALT39.StrType)le.orig_function_name) <> TRIM((SALT39.StrType)clean_orig_function_name);
    SELF.orig_adl_Invalid := Fields.InValid_orig_adl((SALT39.StrType)le.orig_adl);
    clean_orig_adl := (TYPEOF(le.orig_adl))Fields.Make_orig_adl((SALT39.StrType)le.orig_adl);
    clean_orig_adl_Invalid := Fields.InValid_orig_adl((SALT39.StrType)clean_orig_adl);
    SELF.orig_adl := IF(withOnfail, clean_orig_adl, le.orig_adl); // ONFAIL(CLEAN)
    SELF.orig_adl_wouldClean := TRIM((SALT39.StrType)le.orig_adl) <> TRIM((SALT39.StrType)clean_orig_adl);
    SELF.orig_fname_Invalid := Fields.InValid_orig_fname((SALT39.StrType)le.orig_fname);
    clean_orig_fname := (TYPEOF(le.orig_fname))Fields.Make_orig_fname((SALT39.StrType)le.orig_fname);
    clean_orig_fname_Invalid := Fields.InValid_orig_fname((SALT39.StrType)clean_orig_fname);
    SELF.orig_fname := IF(withOnfail, clean_orig_fname, le.orig_fname); // ONFAIL(CLEAN)
    SELF.orig_fname_wouldClean := TRIM((SALT39.StrType)le.orig_fname) <> TRIM((SALT39.StrType)clean_orig_fname);
    SELF.orig_lname_Invalid := Fields.InValid_orig_lname((SALT39.StrType)le.orig_lname);
    clean_orig_lname := (TYPEOF(le.orig_lname))Fields.Make_orig_lname((SALT39.StrType)le.orig_lname);
    clean_orig_lname_Invalid := Fields.InValid_orig_lname((SALT39.StrType)clean_orig_lname);
    SELF.orig_lname := IF(withOnfail, clean_orig_lname, le.orig_lname); // ONFAIL(CLEAN)
    SELF.orig_lname_wouldClean := TRIM((SALT39.StrType)le.orig_lname) <> TRIM((SALT39.StrType)clean_orig_lname);
    SELF.orig_mname_Invalid := Fields.InValid_orig_mname((SALT39.StrType)le.orig_mname);
    clean_orig_mname := (TYPEOF(le.orig_mname))Fields.Make_orig_mname((SALT39.StrType)le.orig_mname);
    clean_orig_mname_Invalid := Fields.InValid_orig_mname((SALT39.StrType)clean_orig_mname);
    SELF.orig_mname := IF(withOnfail, clean_orig_mname, le.orig_mname); // ONFAIL(CLEAN)
    SELF.orig_mname_wouldClean := TRIM((SALT39.StrType)le.orig_mname) <> TRIM((SALT39.StrType)clean_orig_mname);
    SELF.orig_ssn_Invalid := Fields.InValid_orig_ssn((SALT39.StrType)le.orig_ssn);
    clean_orig_ssn := (TYPEOF(le.orig_ssn))Fields.Make_orig_ssn((SALT39.StrType)le.orig_ssn);
    clean_orig_ssn_Invalid := Fields.InValid_orig_ssn((SALT39.StrType)clean_orig_ssn);
    SELF.orig_ssn := IF(withOnfail, clean_orig_ssn, le.orig_ssn); // ONFAIL(CLEAN)
    SELF.orig_ssn_wouldClean := TRIM((SALT39.StrType)le.orig_ssn) <> TRIM((SALT39.StrType)clean_orig_ssn);
    SELF.orig_address_Invalid := Fields.InValid_orig_address((SALT39.StrType)le.orig_address);
    clean_orig_address := (TYPEOF(le.orig_address))Fields.Make_orig_address((SALT39.StrType)le.orig_address);
    clean_orig_address_Invalid := Fields.InValid_orig_address((SALT39.StrType)clean_orig_address);
    SELF.orig_address := IF(withOnfail, clean_orig_address, le.orig_address); // ONFAIL(CLEAN)
    SELF.orig_address_wouldClean := TRIM((SALT39.StrType)le.orig_address) <> TRIM((SALT39.StrType)clean_orig_address);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT39.StrType)le.orig_city);
    clean_orig_city := (TYPEOF(le.orig_city))Fields.Make_orig_city((SALT39.StrType)le.orig_city);
    clean_orig_city_Invalid := Fields.InValid_orig_city((SALT39.StrType)clean_orig_city);
    SELF.orig_city := IF(withOnfail, clean_orig_city, le.orig_city); // ONFAIL(CLEAN)
    SELF.orig_city_wouldClean := TRIM((SALT39.StrType)le.orig_city) <> TRIM((SALT39.StrType)clean_orig_city);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT39.StrType)le.orig_state);
    clean_orig_state := (TYPEOF(le.orig_state))Fields.Make_orig_state((SALT39.StrType)le.orig_state);
    clean_orig_state_Invalid := Fields.InValid_orig_state((SALT39.StrType)clean_orig_state);
    SELF.orig_state := IF(withOnfail, clean_orig_state, le.orig_state); // ONFAIL(CLEAN)
    SELF.orig_state_wouldClean := TRIM((SALT39.StrType)le.orig_state) <> TRIM((SALT39.StrType)clean_orig_state);
    SELF.orig_zip_Invalid := Fields.InValid_orig_zip((SALT39.StrType)le.orig_zip);
    clean_orig_zip := (TYPEOF(le.orig_zip))Fields.Make_orig_zip((SALT39.StrType)le.orig_zip);
    clean_orig_zip_Invalid := Fields.InValid_orig_zip((SALT39.StrType)clean_orig_zip);
    SELF.orig_zip := IF(withOnfail, clean_orig_zip, le.orig_zip); // ONFAIL(CLEAN)
    SELF.orig_zip_wouldClean := TRIM((SALT39.StrType)le.orig_zip) <> TRIM((SALT39.StrType)clean_orig_zip);
    SELF.orig_phone_Invalid := Fields.InValid_orig_phone((SALT39.StrType)le.orig_phone);
    clean_orig_phone := (TYPEOF(le.orig_phone))Fields.Make_orig_phone((SALT39.StrType)le.orig_phone);
    clean_orig_phone_Invalid := Fields.InValid_orig_phone((SALT39.StrType)clean_orig_phone);
    SELF.orig_phone := IF(withOnfail, clean_orig_phone, le.orig_phone); // ONFAIL(CLEAN)
    SELF.orig_phone_wouldClean := TRIM((SALT39.StrType)le.orig_phone) <> TRIM((SALT39.StrType)clean_orig_phone);
    SELF.orig_dob_Invalid := Fields.InValid_orig_dob((SALT39.StrType)le.orig_dob);
    clean_orig_dob := (TYPEOF(le.orig_dob))Fields.Make_orig_dob((SALT39.StrType)le.orig_dob);
    clean_orig_dob_Invalid := Fields.InValid_orig_dob((SALT39.StrType)clean_orig_dob);
    SELF.orig_dob := IF(withOnfail, clean_orig_dob, le.orig_dob); // ONFAIL(CLEAN)
    SELF.orig_dob_wouldClean := TRIM((SALT39.StrType)le.orig_dob) <> TRIM((SALT39.StrType)clean_orig_dob);
    SELF.orig_dln_Invalid := Fields.InValid_orig_dln((SALT39.StrType)le.orig_dln);
    clean_orig_dln := (TYPEOF(le.orig_dln))Fields.Make_orig_dln((SALT39.StrType)le.orig_dln);
    clean_orig_dln_Invalid := Fields.InValid_orig_dln((SALT39.StrType)clean_orig_dln);
    SELF.orig_dln := IF(withOnfail, clean_orig_dln, le.orig_dln); // ONFAIL(CLEAN)
    SELF.orig_dln_wouldClean := TRIM((SALT39.StrType)le.orig_dln) <> TRIM((SALT39.StrType)clean_orig_dln);
    SELF.orig_dln_st_Invalid := Fields.InValid_orig_dln_st((SALT39.StrType)le.orig_dln_st);
    clean_orig_dln_st := (TYPEOF(le.orig_dln_st))Fields.Make_orig_dln_st((SALT39.StrType)le.orig_dln_st);
    clean_orig_dln_st_Invalid := Fields.InValid_orig_dln_st((SALT39.StrType)clean_orig_dln_st);
    SELF.orig_dln_st := IF(withOnfail, clean_orig_dln_st, le.orig_dln_st); // ONFAIL(CLEAN)
    SELF.orig_dln_st_wouldClean := TRIM((SALT39.StrType)le.orig_dln_st) <> TRIM((SALT39.StrType)clean_orig_dln_st);
    SELF.orig_glb_Invalid := Fields.InValid_orig_glb((SALT39.StrType)le.orig_glb);
    clean_orig_glb := (TYPEOF(le.orig_glb))Fields.Make_orig_glb((SALT39.StrType)le.orig_glb);
    clean_orig_glb_Invalid := Fields.InValid_orig_glb((SALT39.StrType)clean_orig_glb);
    SELF.orig_glb := IF(withOnfail, clean_orig_glb, le.orig_glb); // ONFAIL(CLEAN)
    SELF.orig_glb_wouldClean := TRIM((SALT39.StrType)le.orig_glb) <> TRIM((SALT39.StrType)clean_orig_glb);
    SELF.orig_dppa_Invalid := Fields.InValid_orig_dppa((SALT39.StrType)le.orig_dppa);
    clean_orig_dppa := (TYPEOF(le.orig_dppa))Fields.Make_orig_dppa((SALT39.StrType)le.orig_dppa);
    clean_orig_dppa_Invalid := Fields.InValid_orig_dppa((SALT39.StrType)clean_orig_dppa);
    SELF.orig_dppa := IF(withOnfail, clean_orig_dppa, le.orig_dppa); // ONFAIL(CLEAN)
    SELF.orig_dppa_wouldClean := TRIM((SALT39.StrType)le.orig_dppa) <> TRIM((SALT39.StrType)clean_orig_dppa);
    SELF.orig_fcra_Invalid := Fields.InValid_orig_fcra((SALT39.StrType)le.orig_fcra);
    clean_orig_fcra := (TYPEOF(le.orig_fcra))Fields.Make_orig_fcra((SALT39.StrType)le.orig_fcra);
    clean_orig_fcra_Invalid := Fields.InValid_orig_fcra((SALT39.StrType)clean_orig_fcra);
    SELF.orig_fcra := IF(withOnfail, clean_orig_fcra, le.orig_fcra); // ONFAIL(CLEAN)
    SELF.orig_fcra_wouldClean := TRIM((SALT39.StrType)le.orig_fcra) <> TRIM((SALT39.StrType)clean_orig_fcra);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_FILE);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_transaction_id_Invalid << 0 ) + ( le.orig_dateadded_Invalid << 2 ) + ( le.orig_billingid_Invalid << 5 ) + ( le.orig_function_name_Invalid << 8 ) + ( le.orig_adl_Invalid << 11 ) + ( le.orig_fname_Invalid << 14 ) + ( le.orig_lname_Invalid << 16 ) + ( le.orig_mname_Invalid << 18 ) + ( le.orig_ssn_Invalid << 20 ) + ( le.orig_address_Invalid << 22 ) + ( le.orig_city_Invalid << 23 ) + ( le.orig_state_Invalid << 25 ) + ( le.orig_zip_Invalid << 27 ) + ( le.orig_phone_Invalid << 29 ) + ( le.orig_dob_Invalid << 32 ) + ( le.orig_dln_Invalid << 34 ) + ( le.orig_dln_st_Invalid << 36 ) + ( le.orig_glb_Invalid << 39 ) + ( le.orig_dppa_Invalid << 42 ) + ( le.orig_fcra_Invalid << 45 );
    SELF.ScrubsCleanBits1 := ( IF(le.orig_transaction_id_wouldClean, 1, 0) << 0 ) + ( IF(le.orig_dateadded_wouldClean, 1, 0) << 1 ) + ( IF(le.orig_billingid_wouldClean, 1, 0) << 2 ) + ( IF(le.orig_function_name_wouldClean, 1, 0) << 3 ) + ( IF(le.orig_adl_wouldClean, 1, 0) << 4 ) + ( IF(le.orig_fname_wouldClean, 1, 0) << 5 ) + ( IF(le.orig_lname_wouldClean, 1, 0) << 6 ) + ( IF(le.orig_mname_wouldClean, 1, 0) << 7 ) + ( IF(le.orig_ssn_wouldClean, 1, 0) << 8 ) + ( IF(le.orig_address_wouldClean, 1, 0) << 9 ) + ( IF(le.orig_city_wouldClean, 1, 0) << 10 ) + ( IF(le.orig_state_wouldClean, 1, 0) << 11 ) + ( IF(le.orig_zip_wouldClean, 1, 0) << 12 ) + ( IF(le.orig_phone_wouldClean, 1, 0) << 13 ) + ( IF(le.orig_dob_wouldClean, 1, 0) << 14 ) + ( IF(le.orig_dln_wouldClean, 1, 0) << 15 ) + ( IF(le.orig_dln_st_wouldClean, 1, 0) << 16 ) + ( IF(le.orig_glb_wouldClean, 1, 0) << 17 ) + ( IF(le.orig_dppa_wouldClean, 1, 0) << 18 ) + ( IF(le.orig_fcra_wouldClean, 1, 0) << 19 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_FILE);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_transaction_id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.orig_dateadded_Invalid := (le.ScrubsBits1 >> 2) & 7;
    SELF.orig_billingid_Invalid := (le.ScrubsBits1 >> 5) & 7;
    SELF.orig_function_name_Invalid := (le.ScrubsBits1 >> 8) & 7;
    SELF.orig_adl_Invalid := (le.ScrubsBits1 >> 11) & 7;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.orig_ssn_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.orig_address_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.orig_phone_Invalid := (le.ScrubsBits1 >> 29) & 7;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.orig_dln_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.orig_dln_st_Invalid := (le.ScrubsBits1 >> 36) & 7;
    SELF.orig_glb_Invalid := (le.ScrubsBits1 >> 39) & 7;
    SELF.orig_dppa_Invalid := (le.ScrubsBits1 >> 42) & 7;
    SELF.orig_fcra_Invalid := (le.ScrubsBits1 >> 45) & 7;
    SELF.orig_transaction_id_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.orig_dateadded_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.orig_billingid_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.orig_function_name_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.orig_adl_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.orig_fname_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.orig_lname_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.orig_mname_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.orig_ssn_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.orig_address_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.orig_city_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.orig_state_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.orig_zip_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.orig_phone_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.orig_dob_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.orig_dln_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.orig_dln_st_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.orig_glb_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.orig_dppa_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.orig_fcra_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid=1);
    orig_transaction_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_transaction_id_Invalid=1 AND h.orig_transaction_id_wouldClean);
    orig_transaction_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid=2);
    orig_transaction_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_transaction_id_Invalid=2 AND h.orig_transaction_id_wouldClean);
    orig_transaction_id_Total_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid>0);
    orig_dateadded_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dateadded_Invalid=1);
    orig_dateadded_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dateadded_Invalid=1 AND h.orig_dateadded_wouldClean);
    orig_dateadded_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dateadded_Invalid=2);
    orig_dateadded_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dateadded_Invalid=2 AND h.orig_dateadded_wouldClean);
    orig_dateadded_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dateadded_Invalid=3);
    orig_dateadded_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dateadded_Invalid=3 AND h.orig_dateadded_wouldClean);
    orig_dateadded_WORDS_ErrorCount := COUNT(GROUP,h.orig_dateadded_Invalid=4);
    orig_dateadded_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dateadded_Invalid=4 AND h.orig_dateadded_wouldClean);
    orig_dateadded_Total_ErrorCount := COUNT(GROUP,h.orig_dateadded_Invalid>0);
    orig_billingid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_billingid_Invalid=1);
    orig_billingid_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_billingid_Invalid=1 AND h.orig_billingid_wouldClean);
    orig_billingid_ALLOW_ErrorCount := COUNT(GROUP,h.orig_billingid_Invalid=2);
    orig_billingid_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_billingid_Invalid=2 AND h.orig_billingid_wouldClean);
    orig_billingid_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_billingid_Invalid=3);
    orig_billingid_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_billingid_Invalid=3 AND h.orig_billingid_wouldClean);
    orig_billingid_WORDS_ErrorCount := COUNT(GROUP,h.orig_billingid_Invalid=4);
    orig_billingid_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_billingid_Invalid=4 AND h.orig_billingid_wouldClean);
    orig_billingid_Total_ErrorCount := COUNT(GROUP,h.orig_billingid_Invalid>0);
    orig_function_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=1);
    orig_function_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=1 AND h.orig_function_name_wouldClean);
    orig_function_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=2);
    orig_function_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=2 AND h.orig_function_name_wouldClean);
    orig_function_name_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=3);
    orig_function_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=3 AND h.orig_function_name_wouldClean);
    orig_function_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=4);
    orig_function_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=4 AND h.orig_function_name_wouldClean);
    orig_function_name_Total_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid>0);
    orig_adl_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_adl_Invalid=1);
    orig_adl_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_adl_Invalid=1 AND h.orig_adl_wouldClean);
    orig_adl_ALLOW_ErrorCount := COUNT(GROUP,h.orig_adl_Invalid=2);
    orig_adl_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_adl_Invalid=2 AND h.orig_adl_wouldClean);
    orig_adl_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_adl_Invalid=3);
    orig_adl_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_adl_Invalid=3 AND h.orig_adl_wouldClean);
    orig_adl_WORDS_ErrorCount := COUNT(GROUP,h.orig_adl_Invalid=4);
    orig_adl_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_adl_Invalid=4 AND h.orig_adl_wouldClean);
    orig_adl_Total_ErrorCount := COUNT(GROUP,h.orig_adl_Invalid>0);
    orig_fname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_fname_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_fname_Invalid=1 AND h.orig_fname_wouldClean);
    orig_fname_WORDS_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=2);
    orig_fname_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_fname_Invalid=2 AND h.orig_fname_wouldClean);
    orig_fname_Total_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid>0);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_lname_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_lname_Invalid=1 AND h.orig_lname_wouldClean);
    orig_lname_WORDS_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=2);
    orig_lname_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_lname_Invalid=2 AND h.orig_lname_wouldClean);
    orig_lname_Total_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid>0);
    orig_mname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_mname_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_mname_Invalid=1 AND h.orig_mname_wouldClean);
    orig_mname_WORDS_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=2);
    orig_mname_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_mname_Invalid=2 AND h.orig_mname_wouldClean);
    orig_mname_Total_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid>0);
    orig_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=1);
    orig_ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=1 AND h.orig_ssn_wouldClean);
    orig_ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=2);
    orig_ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=2 AND h.orig_ssn_wouldClean);
    orig_ssn_WORDS_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=3);
    orig_ssn_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=3 AND h.orig_ssn_wouldClean);
    orig_ssn_Total_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid>0);
    orig_address_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address_Invalid=1);
    orig_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address_Invalid=1 AND h.orig_address_wouldClean);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=1 AND h.orig_city_wouldClean);
    orig_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=2 AND h.orig_city_wouldClean);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=1 AND h.orig_state_wouldClean);
    orig_state_WORDS_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=2);
    orig_state_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=2 AND h.orig_state_wouldClean);
    orig_state_Total_ErrorCount := COUNT(GROUP,h.orig_state_Invalid>0);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_zip_Invalid=1 AND h.orig_zip_wouldClean);
    orig_zip_WORDS_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=2);
    orig_zip_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_zip_Invalid=2 AND h.orig_zip_wouldClean);
    orig_zip_Total_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid>0);
    orig_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=1);
    orig_phone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=1 AND h.orig_phone_wouldClean);
    orig_phone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=2);
    orig_phone_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=2 AND h.orig_phone_wouldClean);
    orig_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=3);
    orig_phone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=3 AND h.orig_phone_wouldClean);
    orig_phone_WORDS_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=4);
    orig_phone_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=4 AND h.orig_phone_wouldClean);
    orig_phone_Total_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid>0);
    orig_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_dob_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=1 AND h.orig_dob_wouldClean);
    orig_dob_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=2);
    orig_dob_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=2 AND h.orig_dob_wouldClean);
    orig_dob_WORDS_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=3);
    orig_dob_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=3 AND h.orig_dob_wouldClean);
    orig_dob_Total_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid>0);
    orig_dln_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dln_Invalid=1);
    orig_dln_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dln_Invalid=1 AND h.orig_dln_wouldClean);
    orig_dln_WORDS_ErrorCount := COUNT(GROUP,h.orig_dln_Invalid=2);
    orig_dln_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dln_Invalid=2 AND h.orig_dln_wouldClean);
    orig_dln_Total_ErrorCount := COUNT(GROUP,h.orig_dln_Invalid>0);
    orig_dln_st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dln_st_Invalid=1);
    orig_dln_st_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dln_st_Invalid=1 AND h.orig_dln_st_wouldClean);
    orig_dln_st_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dln_st_Invalid=2);
    orig_dln_st_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dln_st_Invalid=2 AND h.orig_dln_st_wouldClean);
    orig_dln_st_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dln_st_Invalid=3);
    orig_dln_st_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dln_st_Invalid=3 AND h.orig_dln_st_wouldClean);
    orig_dln_st_WORDS_ErrorCount := COUNT(GROUP,h.orig_dln_st_Invalid=4);
    orig_dln_st_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dln_st_Invalid=4 AND h.orig_dln_st_wouldClean);
    orig_dln_st_Total_ErrorCount := COUNT(GROUP,h.orig_dln_st_Invalid>0);
    orig_glb_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_glb_Invalid=1);
    orig_glb_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_glb_Invalid=1 AND h.orig_glb_wouldClean);
    orig_glb_ALLOW_ErrorCount := COUNT(GROUP,h.orig_glb_Invalid=2);
    orig_glb_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_glb_Invalid=2 AND h.orig_glb_wouldClean);
    orig_glb_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_glb_Invalid=3);
    orig_glb_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_glb_Invalid=3 AND h.orig_glb_wouldClean);
    orig_glb_WORDS_ErrorCount := COUNT(GROUP,h.orig_glb_Invalid=4);
    orig_glb_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_glb_Invalid=4 AND h.orig_glb_wouldClean);
    orig_glb_Total_ErrorCount := COUNT(GROUP,h.orig_glb_Invalid>0);
    orig_dppa_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dppa_Invalid=1);
    orig_dppa_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dppa_Invalid=1 AND h.orig_dppa_wouldClean);
    orig_dppa_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dppa_Invalid=2);
    orig_dppa_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dppa_Invalid=2 AND h.orig_dppa_wouldClean);
    orig_dppa_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dppa_Invalid=3);
    orig_dppa_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dppa_Invalid=3 AND h.orig_dppa_wouldClean);
    orig_dppa_WORDS_ErrorCount := COUNT(GROUP,h.orig_dppa_Invalid=4);
    orig_dppa_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dppa_Invalid=4 AND h.orig_dppa_wouldClean);
    orig_dppa_Total_ErrorCount := COUNT(GROUP,h.orig_dppa_Invalid>0);
    orig_fcra_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_fcra_Invalid=1);
    orig_fcra_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_fcra_Invalid=1 AND h.orig_fcra_wouldClean);
    orig_fcra_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fcra_Invalid=2);
    orig_fcra_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_fcra_Invalid=2 AND h.orig_fcra_wouldClean);
    orig_fcra_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_fcra_Invalid=3);
    orig_fcra_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_fcra_Invalid=3 AND h.orig_fcra_wouldClean);
    orig_fcra_WORDS_ErrorCount := COUNT(GROUP,h.orig_fcra_Invalid=4);
    orig_fcra_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_fcra_Invalid=4 AND h.orig_fcra_wouldClean);
    orig_fcra_Total_ErrorCount := COUNT(GROUP,h.orig_fcra_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.orig_transaction_id_Invalid > 0 OR h.orig_dateadded_Invalid > 0 OR h.orig_billingid_Invalid > 0 OR h.orig_function_name_Invalid > 0 OR h.orig_adl_Invalid > 0 OR h.orig_fname_Invalid > 0 OR h.orig_lname_Invalid > 0 OR h.orig_mname_Invalid > 0 OR h.orig_ssn_Invalid > 0 OR h.orig_address_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip_Invalid > 0 OR h.orig_phone_Invalid > 0 OR h.orig_dob_Invalid > 0 OR h.orig_dln_Invalid > 0 OR h.orig_dln_st_Invalid > 0 OR h.orig_glb_Invalid > 0 OR h.orig_dppa_Invalid > 0 OR h.orig_fcra_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.orig_transaction_id_wouldClean OR h.orig_dateadded_wouldClean OR h.orig_billingid_wouldClean OR h.orig_function_name_wouldClean OR h.orig_adl_wouldClean OR h.orig_fname_wouldClean OR h.orig_lname_wouldClean OR h.orig_mname_wouldClean OR h.orig_ssn_wouldClean OR h.orig_address_wouldClean OR h.orig_city_wouldClean OR h.orig_state_wouldClean OR h.orig_zip_wouldClean OR h.orig_phone_wouldClean OR h.orig_dob_wouldClean OR h.orig_dln_wouldClean OR h.orig_dln_st_wouldClean OR h.orig_glb_wouldClean OR h.orig_dppa_wouldClean OR h.orig_fcra_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.orig_transaction_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dateadded_Total_ErrorCount > 0, 1, 0) + IF(le.orig_billingid_Total_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_adl_Total_ErrorCount > 0, 1, 0) + IF(le.orig_fname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_lname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_mname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_state_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zip_Total_ErrorCount > 0, 1, 0) + IF(le.orig_phone_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dob_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dln_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dln_st_Total_ErrorCount > 0, 1, 0) + IF(le.orig_glb_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dppa_Total_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.orig_transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dateadded_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dateadded_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dateadded_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dateadded_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_billingid_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_billingid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_billingid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_billingid_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_adl_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_adl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_adl_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_adl_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_phone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_phone_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dln_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dln_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dln_st_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dln_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dln_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dln_st_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_glb_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_glb_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_glb_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_glb_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dppa_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dppa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dppa_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dppa_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_WORDS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.orig_transaction_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dateadded_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dateadded_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dateadded_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dateadded_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_billingid_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_billingid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_billingid_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_billingid_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_adl_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_adl_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_adl_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_adl_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dln_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dln_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dln_st_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dln_st_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dln_st_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dln_st_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dppa_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dppa_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dppa_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dppa_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_WORDS_WouldModifyCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_transaction_id_Invalid,le.orig_dateadded_Invalid,le.orig_billingid_Invalid,le.orig_function_name_Invalid,le.orig_adl_Invalid,le.orig_fname_Invalid,le.orig_lname_Invalid,le.orig_mname_Invalid,le.orig_ssn_Invalid,le.orig_address_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_Invalid,le.orig_phone_Invalid,le.orig_dob_Invalid,le.orig_dln_Invalid,le.orig_dln_st_Invalid,le.orig_glb_Invalid,le.orig_dppa_Invalid,le.orig_fcra_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_orig_transaction_id(le.orig_transaction_id_Invalid),Fields.InvalidMessage_orig_dateadded(le.orig_dateadded_Invalid),Fields.InvalidMessage_orig_billingid(le.orig_billingid_Invalid),Fields.InvalidMessage_orig_function_name(le.orig_function_name_Invalid),Fields.InvalidMessage_orig_adl(le.orig_adl_Invalid),Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),Fields.InvalidMessage_orig_ssn(le.orig_ssn_Invalid),Fields.InvalidMessage_orig_address(le.orig_address_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Fields.InvalidMessage_orig_phone(le.orig_phone_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_dln(le.orig_dln_Invalid),Fields.InvalidMessage_orig_dln_st(le.orig_dln_st_Invalid),Fields.InvalidMessage_orig_glb(le.orig_glb_Invalid),Fields.InvalidMessage_orig_dppa(le.orig_dppa_Invalid),Fields.InvalidMessage_orig_fcra(le.orig_fcra_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_transaction_id_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dateadded_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_billingid_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_function_name_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_adl_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_ssn_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_phone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dln_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dln_st_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_glb_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dppa_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_fcra_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_transaction_id','orig_dateadded','orig_billingid','orig_function_name','orig_adl','orig_fname','orig_lname','orig_mname','orig_ssn','orig_address','orig_city','orig_state','orig_zip','orig_phone','orig_dob','orig_dln','orig_dln_st','orig_glb','orig_dppa','orig_fcra','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'orig_transaction_id','orig_dateadded','orig_billingid','orig_function_name','orig_adl','orig_fname','orig_lname','orig_mname','orig_ssn','orig_address','orig_city','orig_state','orig_zip','orig_phone','orig_dob','orig_dln','orig_dln_st','orig_glb','orig_dppa','orig_fcra','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.orig_transaction_id,(SALT39.StrType)le.orig_dateadded,(SALT39.StrType)le.orig_billingid,(SALT39.StrType)le.orig_function_name,(SALT39.StrType)le.orig_adl,(SALT39.StrType)le.orig_fname,(SALT39.StrType)le.orig_lname,(SALT39.StrType)le.orig_mname,(SALT39.StrType)le.orig_ssn,(SALT39.StrType)le.orig_address,(SALT39.StrType)le.orig_city,(SALT39.StrType)le.orig_state,(SALT39.StrType)le.orig_zip,(SALT39.StrType)le.orig_phone,(SALT39.StrType)le.orig_dob,(SALT39.StrType)le.orig_dln,(SALT39.StrType)le.orig_dln_st,(SALT39.StrType)le.orig_glb,(SALT39.StrType)le.orig_dppa,(SALT39.StrType)le.orig_fcra,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,20,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_FILE) prevDS = DATASET([], Layout_FILE), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'orig_transaction_id:orig_transaction_id:ALLOW','orig_transaction_id:orig_transaction_id:WORDS'
          ,'orig_dateadded:orig_dateadded:LEFTTRIM','orig_dateadded:orig_dateadded:ALLOW','orig_dateadded:orig_dateadded:LENGTHS','orig_dateadded:orig_dateadded:WORDS'
          ,'orig_billingid:orig_billingid:LEFTTRIM','orig_billingid:orig_billingid:ALLOW','orig_billingid:orig_billingid:LENGTHS','orig_billingid:orig_billingid:WORDS'
          ,'orig_function_name:orig_function_name:LEFTTRIM','orig_function_name:orig_function_name:ALLOW','orig_function_name:orig_function_name:LENGTHS','orig_function_name:orig_function_name:WORDS'
          ,'orig_adl:orig_adl:LEFTTRIM','orig_adl:orig_adl:ALLOW','orig_adl:orig_adl:LENGTHS','orig_adl:orig_adl:WORDS'
          ,'orig_fname:orig_fname:ALLOW','orig_fname:orig_fname:WORDS'
          ,'orig_lname:orig_lname:ALLOW','orig_lname:orig_lname:WORDS'
          ,'orig_mname:orig_mname:ALLOW','orig_mname:orig_mname:WORDS'
          ,'orig_ssn:orig_ssn:ALLOW','orig_ssn:orig_ssn:LENGTHS','orig_ssn:orig_ssn:WORDS'
          ,'orig_address:orig_address:ALLOW'
          ,'orig_city:orig_city:ALLOW','orig_city:orig_city:WORDS'
          ,'orig_state:orig_state:ALLOW','orig_state:orig_state:WORDS'
          ,'orig_zip:orig_zip:ALLOW','orig_zip:orig_zip:WORDS'
          ,'orig_phone:orig_phone:LEFTTRIM','orig_phone:orig_phone:ALLOW','orig_phone:orig_phone:LENGTHS','orig_phone:orig_phone:WORDS'
          ,'orig_dob:orig_dob:LEFTTRIM','orig_dob:orig_dob:LENGTHS','orig_dob:orig_dob:WORDS'
          ,'orig_dln:orig_dln:ALLOW','orig_dln:orig_dln:WORDS'
          ,'orig_dln_st:orig_dln_st:LEFTTRIM','orig_dln_st:orig_dln_st:ALLOW','orig_dln_st:orig_dln_st:LENGTHS','orig_dln_st:orig_dln_st:WORDS'
          ,'orig_glb:orig_glb:LEFTTRIM','orig_glb:orig_glb:ALLOW','orig_glb:orig_glb:LENGTHS','orig_glb:orig_glb:WORDS'
          ,'orig_dppa:orig_dppa:LEFTTRIM','orig_dppa:orig_dppa:ALLOW','orig_dppa:orig_dppa:LENGTHS','orig_dppa:orig_dppa:WORDS'
          ,'orig_fcra:orig_fcra:LEFTTRIM','orig_fcra:orig_fcra:ALLOW','orig_fcra:orig_fcra:LENGTHS','orig_fcra:orig_fcra:WORDS'
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
          ,Fields.InvalidMessage_orig_transaction_id(1),Fields.InvalidMessage_orig_transaction_id(2)
          ,Fields.InvalidMessage_orig_dateadded(1),Fields.InvalidMessage_orig_dateadded(2),Fields.InvalidMessage_orig_dateadded(3),Fields.InvalidMessage_orig_dateadded(4)
          ,Fields.InvalidMessage_orig_billingid(1),Fields.InvalidMessage_orig_billingid(2),Fields.InvalidMessage_orig_billingid(3),Fields.InvalidMessage_orig_billingid(4)
          ,Fields.InvalidMessage_orig_function_name(1),Fields.InvalidMessage_orig_function_name(2),Fields.InvalidMessage_orig_function_name(3),Fields.InvalidMessage_orig_function_name(4)
          ,Fields.InvalidMessage_orig_adl(1),Fields.InvalidMessage_orig_adl(2),Fields.InvalidMessage_orig_adl(3),Fields.InvalidMessage_orig_adl(4)
          ,Fields.InvalidMessage_orig_fname(1),Fields.InvalidMessage_orig_fname(2)
          ,Fields.InvalidMessage_orig_lname(1),Fields.InvalidMessage_orig_lname(2)
          ,Fields.InvalidMessage_orig_mname(1),Fields.InvalidMessage_orig_mname(2)
          ,Fields.InvalidMessage_orig_ssn(1),Fields.InvalidMessage_orig_ssn(2),Fields.InvalidMessage_orig_ssn(3)
          ,Fields.InvalidMessage_orig_address(1)
          ,Fields.InvalidMessage_orig_city(1),Fields.InvalidMessage_orig_city(2)
          ,Fields.InvalidMessage_orig_state(1),Fields.InvalidMessage_orig_state(2)
          ,Fields.InvalidMessage_orig_zip(1),Fields.InvalidMessage_orig_zip(2)
          ,Fields.InvalidMessage_orig_phone(1),Fields.InvalidMessage_orig_phone(2),Fields.InvalidMessage_orig_phone(3),Fields.InvalidMessage_orig_phone(4)
          ,Fields.InvalidMessage_orig_dob(1),Fields.InvalidMessage_orig_dob(2),Fields.InvalidMessage_orig_dob(3)
          ,Fields.InvalidMessage_orig_dln(1),Fields.InvalidMessage_orig_dln(2)
          ,Fields.InvalidMessage_orig_dln_st(1),Fields.InvalidMessage_orig_dln_st(2),Fields.InvalidMessage_orig_dln_st(3),Fields.InvalidMessage_orig_dln_st(4)
          ,Fields.InvalidMessage_orig_glb(1),Fields.InvalidMessage_orig_glb(2),Fields.InvalidMessage_orig_glb(3),Fields.InvalidMessage_orig_glb(4)
          ,Fields.InvalidMessage_orig_dppa(1),Fields.InvalidMessage_orig_dppa(2),Fields.InvalidMessage_orig_dppa(3),Fields.InvalidMessage_orig_dppa(4)
          ,Fields.InvalidMessage_orig_fcra(1),Fields.InvalidMessage_orig_fcra(2),Fields.InvalidMessage_orig_fcra(3),Fields.InvalidMessage_orig_fcra(4)
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
          ,le.orig_transaction_id_ALLOW_ErrorCount,le.orig_transaction_id_WORDS_ErrorCount
          ,le.orig_dateadded_LEFTTRIM_ErrorCount,le.orig_dateadded_ALLOW_ErrorCount,le.orig_dateadded_LENGTHS_ErrorCount,le.orig_dateadded_WORDS_ErrorCount
          ,le.orig_billingid_LEFTTRIM_ErrorCount,le.orig_billingid_ALLOW_ErrorCount,le.orig_billingid_LENGTHS_ErrorCount,le.orig_billingid_WORDS_ErrorCount
          ,le.orig_function_name_LEFTTRIM_ErrorCount,le.orig_function_name_ALLOW_ErrorCount,le.orig_function_name_LENGTHS_ErrorCount,le.orig_function_name_WORDS_ErrorCount
          ,le.orig_adl_LEFTTRIM_ErrorCount,le.orig_adl_ALLOW_ErrorCount,le.orig_adl_LENGTHS_ErrorCount,le.orig_adl_WORDS_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_WORDS_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_WORDS_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_WORDS_ErrorCount
          ,le.orig_ssn_ALLOW_ErrorCount,le.orig_ssn_LENGTHS_ErrorCount,le.orig_ssn_WORDS_ErrorCount
          ,le.orig_address_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount,le.orig_state_WORDS_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_WORDS_ErrorCount
          ,le.orig_phone_LEFTTRIM_ErrorCount,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTHS_ErrorCount,le.orig_phone_WORDS_ErrorCount
          ,le.orig_dob_LEFTTRIM_ErrorCount,le.orig_dob_LENGTHS_ErrorCount,le.orig_dob_WORDS_ErrorCount
          ,le.orig_dln_ALLOW_ErrorCount,le.orig_dln_WORDS_ErrorCount
          ,le.orig_dln_st_LEFTTRIM_ErrorCount,le.orig_dln_st_ALLOW_ErrorCount,le.orig_dln_st_LENGTHS_ErrorCount,le.orig_dln_st_WORDS_ErrorCount
          ,le.orig_glb_LEFTTRIM_ErrorCount,le.orig_glb_ALLOW_ErrorCount,le.orig_glb_LENGTHS_ErrorCount,le.orig_glb_WORDS_ErrorCount
          ,le.orig_dppa_LEFTTRIM_ErrorCount,le.orig_dppa_ALLOW_ErrorCount,le.orig_dppa_LENGTHS_ErrorCount,le.orig_dppa_WORDS_ErrorCount
          ,le.orig_fcra_LEFTTRIM_ErrorCount,le.orig_fcra_ALLOW_ErrorCount,le.orig_fcra_LENGTHS_ErrorCount,le.orig_fcra_WORDS_ErrorCount
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
          ,le.orig_transaction_id_ALLOW_ErrorCount,le.orig_transaction_id_WORDS_ErrorCount
          ,le.orig_dateadded_LEFTTRIM_ErrorCount,le.orig_dateadded_ALLOW_ErrorCount,le.orig_dateadded_LENGTHS_ErrorCount,le.orig_dateadded_WORDS_ErrorCount
          ,le.orig_billingid_LEFTTRIM_ErrorCount,le.orig_billingid_ALLOW_ErrorCount,le.orig_billingid_LENGTHS_ErrorCount,le.orig_billingid_WORDS_ErrorCount
          ,le.orig_function_name_LEFTTRIM_ErrorCount,le.orig_function_name_ALLOW_ErrorCount,le.orig_function_name_LENGTHS_ErrorCount,le.orig_function_name_WORDS_ErrorCount
          ,le.orig_adl_LEFTTRIM_ErrorCount,le.orig_adl_ALLOW_ErrorCount,le.orig_adl_LENGTHS_ErrorCount,le.orig_adl_WORDS_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_WORDS_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_WORDS_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_WORDS_ErrorCount
          ,le.orig_ssn_ALLOW_ErrorCount,le.orig_ssn_LENGTHS_ErrorCount,le.orig_ssn_WORDS_ErrorCount
          ,le.orig_address_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount,le.orig_state_WORDS_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_WORDS_ErrorCount
          ,le.orig_phone_LEFTTRIM_ErrorCount,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTHS_ErrorCount,le.orig_phone_WORDS_ErrorCount
          ,le.orig_dob_LEFTTRIM_ErrorCount,le.orig_dob_LENGTHS_ErrorCount,le.orig_dob_WORDS_ErrorCount
          ,le.orig_dln_ALLOW_ErrorCount,le.orig_dln_WORDS_ErrorCount
          ,le.orig_dln_st_LEFTTRIM_ErrorCount,le.orig_dln_st_ALLOW_ErrorCount,le.orig_dln_st_LENGTHS_ErrorCount,le.orig_dln_st_WORDS_ErrorCount
          ,le.orig_glb_LEFTTRIM_ErrorCount,le.orig_glb_ALLOW_ErrorCount,le.orig_glb_LENGTHS_ErrorCount,le.orig_glb_WORDS_ErrorCount
          ,le.orig_dppa_LEFTTRIM_ErrorCount,le.orig_dppa_ALLOW_ErrorCount,le.orig_dppa_LENGTHS_ErrorCount,le.orig_dppa_WORDS_ErrorCount
          ,le.orig_fcra_LEFTTRIM_ErrorCount,le.orig_fcra_ALLOW_ErrorCount,le.orig_fcra_LENGTHS_ErrorCount,le.orig_fcra_WORDS_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_FILE));
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
          ,'orig_transaction_id:' + getFieldTypeText(h.orig_transaction_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dateadded:' + getFieldTypeText(h.orig_dateadded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_billingid:' + getFieldTypeText(h.orig_billingid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_function_name:' + getFieldTypeText(h.orig_function_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_adl:' + getFieldTypeText(h.orig_adl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mname:' + getFieldTypeText(h.orig_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ssn:' + getFieldTypeText(h.orig_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address:' + getFieldTypeText(h.orig_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_phone:' + getFieldTypeText(h.orig_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob:' + getFieldTypeText(h.orig_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dln:' + getFieldTypeText(h.orig_dln) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dln_st:' + getFieldTypeText(h.orig_dln_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_glb:' + getFieldTypeText(h.orig_glb) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dppa:' + getFieldTypeText(h.orig_dppa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fcra:' + getFieldTypeText(h.orig_fcra) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_orig_transaction_id_cnt
          ,le.populated_orig_dateadded_cnt
          ,le.populated_orig_billingid_cnt
          ,le.populated_orig_function_name_cnt
          ,le.populated_orig_adl_cnt
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_orig_mname_cnt
          ,le.populated_orig_ssn_cnt
          ,le.populated_orig_address_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_orig_phone_cnt
          ,le.populated_orig_dob_cnt
          ,le.populated_orig_dln_cnt
          ,le.populated_orig_dln_st_cnt
          ,le.populated_orig_glb_cnt
          ,le.populated_orig_dppa_cnt
          ,le.populated_orig_fcra_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_orig_transaction_id_pcnt
          ,le.populated_orig_dateadded_pcnt
          ,le.populated_orig_billingid_pcnt
          ,le.populated_orig_function_name_pcnt
          ,le.populated_orig_adl_pcnt
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_orig_mname_pcnt
          ,le.populated_orig_ssn_pcnt
          ,le.populated_orig_address_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_orig_phone_pcnt
          ,le.populated_orig_dob_pcnt
          ,le.populated_orig_dln_pcnt
          ,le.populated_orig_dln_st_pcnt
          ,le.populated_orig_glb_pcnt
          ,le.populated_orig_dppa_pcnt
          ,le.populated_orig_fcra_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,20,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_FILE));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),20,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_FILE) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Inql_Nfcra_IDM, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
