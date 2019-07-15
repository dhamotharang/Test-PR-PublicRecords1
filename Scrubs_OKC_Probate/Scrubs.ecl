IMPORT SALT38,STD;
EXPORT Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 142;
  EXPORT NumRulesFromFieldType := 142;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 69;
  EXPORT NumFieldsWithPossibleEdits := 2;
  EXPORT NumRulesWithPossibleEdits := 2;
  EXPORT Expanded_Layout := RECORD(Layout_OKC_Probate_Profile)
    UNSIGNED1 name_score_Invalid;
    UNSIGNED1 filedate_Invalid;
    UNSIGNED1 dod_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 masterid_Invalid;
    UNSIGNED1 debtorfirstname_Invalid;
    UNSIGNED1 debtorlastname_Invalid;
    UNSIGNED1 debtoraddress1_Invalid;
    UNSIGNED1 debtoraddress2_Invalid;
    UNSIGNED1 debtoraddresscity_Invalid;
    UNSIGNED1 debtoraddressstate_Invalid;
    UNSIGNED1 debtoraddresszipcode_Invalid;
    UNSIGNED1 dateofdeath_Invalid;
    UNSIGNED1 dateofbirth_Invalid;
    UNSIGNED1 casenumber_Invalid;
    UNSIGNED1 filingdate_Invalid;
    UNSIGNED1 lastdatetofileclaim_Invalid;
    UNSIGNED1 publicationstartdate_Invalid;
    UNSIGNED1 executorfirstname_Invalid;
    UNSIGNED1 executorlastname_Invalid;
    UNSIGNED1 executoraddress1_Invalid;
    UNSIGNED1 executoraddress2_Invalid;
    UNSIGNED1 executoraddresscity_Invalid;
    UNSIGNED1 executoraddressstate_Invalid;
    UNSIGNED1 executoraddresszipcode_Invalid;
    UNSIGNED1 executorphone_Invalid;
    UNSIGNED1 attorneyfirstname_Invalid;
    UNSIGNED1 attorneylastname_Invalid;
    UNSIGNED1 attorneyaddress1_Invalid;
    UNSIGNED1 attorneyaddress2_Invalid;
    UNSIGNED1 attorneyaddresscity_Invalid;
    UNSIGNED1 attorneyaddressstate_Invalid;
    UNSIGNED1 attorneyaddresszipcode_Invalid;
    UNSIGNED1 attorneyphone_Invalid;
    UNSIGNED1 cln_fname_Invalid;
    UNSIGNED1 cln_mname_Invalid;
    UNSIGNED1 cln_lname_Invalid;
    UNSIGNED1 cln_suffix_Invalid;
    UNSIGNED1 cln_fname2_Invalid;
    UNSIGNED1 cln_mname2_Invalid;
    UNSIGNED1 cln_lname2_Invalid;
    UNSIGNED1 cln_suffix2_Invalid;
    UNSIGNED1 cname_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    BOOLEAN postdir_wouldClean;
    UNSIGNED1 unit_desig_Invalid;
    BOOLEAN unit_desig_wouldClean;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dbpc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 rawaid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_OKC_Probate_Profile)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_OKC_Probate_Profile) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.name_score_Invalid := Fields.InValid_name_score((SALT38.StrType)le.name_score);
    SELF.filedate_Invalid := Fields.InValid_filedate((SALT38.StrType)le.filedate);
    SELF.dod_Invalid := Fields.InValid_dod((SALT38.StrType)le.dod);
    SELF.dob_Invalid := Fields.InValid_dob((SALT38.StrType)le.dob);
    SELF.masterid_Invalid := Fields.InValid_masterid((SALT38.StrType)le.masterid);
    SELF.debtorfirstname_Invalid := Fields.InValid_debtorfirstname((SALT38.StrType)le.debtorfirstname);
    SELF.debtorlastname_Invalid := Fields.InValid_debtorlastname((SALT38.StrType)le.debtorlastname);
    SELF.debtoraddress1_Invalid := Fields.InValid_debtoraddress1((SALT38.StrType)le.debtoraddress1);
    SELF.debtoraddress2_Invalid := Fields.InValid_debtoraddress2((SALT38.StrType)le.debtoraddress2);
    SELF.debtoraddresscity_Invalid := Fields.InValid_debtoraddresscity((SALT38.StrType)le.debtoraddresscity);
    SELF.debtoraddressstate_Invalid := Fields.InValid_debtoraddressstate((SALT38.StrType)le.debtoraddressstate);
    SELF.debtoraddresszipcode_Invalid := Fields.InValid_debtoraddresszipcode((SALT38.StrType)le.debtoraddresszipcode);
    SELF.dateofdeath_Invalid := Fields.InValid_dateofdeath((SALT38.StrType)le.dateofdeath);
    SELF.dateofbirth_Invalid := Fields.InValid_dateofbirth((SALT38.StrType)le.dateofbirth);
    SELF.casenumber_Invalid := Fields.InValid_casenumber((SALT38.StrType)le.casenumber);
    SELF.filingdate_Invalid := Fields.InValid_filingdate((SALT38.StrType)le.filingdate);
    SELF.lastdatetofileclaim_Invalid := Fields.InValid_lastdatetofileclaim((SALT38.StrType)le.lastdatetofileclaim);
    SELF.publicationstartdate_Invalid := Fields.InValid_publicationstartdate((SALT38.StrType)le.publicationstartdate);
    SELF.executorfirstname_Invalid := Fields.InValid_executorfirstname((SALT38.StrType)le.executorfirstname);
    SELF.executorlastname_Invalid := Fields.InValid_executorlastname((SALT38.StrType)le.executorlastname);
    SELF.executoraddress1_Invalid := Fields.InValid_executoraddress1((SALT38.StrType)le.executoraddress1);
    SELF.executoraddress2_Invalid := Fields.InValid_executoraddress2((SALT38.StrType)le.executoraddress2);
    SELF.executoraddresscity_Invalid := Fields.InValid_executoraddresscity((SALT38.StrType)le.executoraddresscity);
    SELF.executoraddressstate_Invalid := Fields.InValid_executoraddressstate((SALT38.StrType)le.executoraddressstate);
    SELF.executoraddresszipcode_Invalid := Fields.InValid_executoraddresszipcode((SALT38.StrType)le.executoraddresszipcode);
    SELF.executorphone_Invalid := Fields.InValid_executorphone((SALT38.StrType)le.executorphone);
    SELF.attorneyfirstname_Invalid := Fields.InValid_attorneyfirstname((SALT38.StrType)le.attorneyfirstname);
    SELF.attorneylastname_Invalid := Fields.InValid_attorneylastname((SALT38.StrType)le.attorneylastname);
    SELF.attorneyaddress1_Invalid := Fields.InValid_attorneyaddress1((SALT38.StrType)le.attorneyaddress1);
    SELF.attorneyaddress2_Invalid := Fields.InValid_attorneyaddress2((SALT38.StrType)le.attorneyaddress2);
    SELF.attorneyaddresscity_Invalid := Fields.InValid_attorneyaddresscity((SALT38.StrType)le.attorneyaddresscity);
    SELF.attorneyaddressstate_Invalid := Fields.InValid_attorneyaddressstate((SALT38.StrType)le.attorneyaddressstate);
    SELF.attorneyaddresszipcode_Invalid := Fields.InValid_attorneyaddresszipcode((SALT38.StrType)le.attorneyaddresszipcode);
    SELF.attorneyphone_Invalid := Fields.InValid_attorneyphone((SALT38.StrType)le.attorneyphone);
    SELF.cln_fname_Invalid := Fields.InValid_cln_fname((SALT38.StrType)le.cln_fname);
    SELF.cln_mname_Invalid := Fields.InValid_cln_mname((SALT38.StrType)le.cln_mname);
    SELF.cln_lname_Invalid := Fields.InValid_cln_lname((SALT38.StrType)le.cln_lname);
    SELF.cln_suffix_Invalid := Fields.InValid_cln_suffix((SALT38.StrType)le.cln_suffix);
    SELF.cln_fname2_Invalid := Fields.InValid_cln_fname2((SALT38.StrType)le.cln_fname2);
    SELF.cln_mname2_Invalid := Fields.InValid_cln_mname2((SALT38.StrType)le.cln_mname2);
    SELF.cln_lname2_Invalid := Fields.InValid_cln_lname2((SALT38.StrType)le.cln_lname2);
    SELF.cln_suffix2_Invalid := Fields.InValid_cln_suffix2((SALT38.StrType)le.cln_suffix2);
    SELF.cname_Invalid := Fields.InValid_cname((SALT38.StrType)le.cname);
    SELF.predir_Invalid := Fields.InValid_predir((SALT38.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT38.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT38.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT38.StrType)le.postdir);
    clean_postdir := (TYPEOF(le.postdir))Fields.Make_postdir((SALT38.StrType)le.postdir);
    clean_postdir_Invalid := Fields.InValid_postdir((SALT38.StrType)clean_postdir);
    SELF.postdir := IF(withOnfail, clean_postdir, le.postdir); // ONFAIL(CLEAN)
    SELF.postdir_wouldClean := TRIM((SALT38.StrType)le.postdir) <> TRIM((SALT38.StrType)clean_postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig);
    clean_unit_desig := (TYPEOF(le.unit_desig))Fields.Make_unit_desig((SALT38.StrType)le.unit_desig);
    clean_unit_desig_Invalid := Fields.InValid_unit_desig((SALT38.StrType)clean_unit_desig);
    SELF.unit_desig := IF(withOnfail, clean_unit_desig, le.unit_desig); // ONFAIL(CLEAN)
    SELF.unit_desig_wouldClean := TRIM((SALT38.StrType)le.unit_desig) <> TRIM((SALT38.StrType)clean_unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT38.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT38.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT38.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT38.StrType)le.zip4);
    SELF.cart_Invalid := Fields.InValid_cart((SALT38.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Fields.InValid_lot((SALT38.StrType)le.lot);
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT38.StrType)le.lot_order);
    SELF.dbpc_Invalid := Fields.InValid_dbpc((SALT38.StrType)le.dbpc);
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT38.StrType)le.rec_type);
    SELF.fips_county_Invalid := Fields.InValid_fips_county((SALT38.StrType)le.fips_county);
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT38.StrType)le.geo_long);
    SELF.msa_Invalid := Fields.InValid_msa((SALT38.StrType)le.msa);
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT38.StrType)le.geo_match);
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT38.StrType)le.err_stat);
    SELF.rawaid_Invalid := Fields.InValid_rawaid((SALT38.StrType)le.rawaid);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_OKC_Probate_Profile);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.name_score_Invalid << 0 ) + ( le.filedate_Invalid << 2 ) + ( le.dod_Invalid << 4 ) + ( le.dob_Invalid << 6 ) + ( le.masterid_Invalid << 8 ) + ( le.debtorfirstname_Invalid << 9 ) + ( le.debtorlastname_Invalid << 11 ) + ( le.debtoraddress1_Invalid << 13 ) + ( le.debtoraddress2_Invalid << 15 ) + ( le.debtoraddresscity_Invalid << 17 ) + ( le.debtoraddressstate_Invalid << 19 ) + ( le.debtoraddresszipcode_Invalid << 21 ) + ( le.dateofdeath_Invalid << 23 ) + ( le.dateofbirth_Invalid << 25 ) + ( le.casenumber_Invalid << 27 ) + ( le.filingdate_Invalid << 29 ) + ( le.lastdatetofileclaim_Invalid << 31 ) + ( le.publicationstartdate_Invalid << 33 ) + ( le.executorfirstname_Invalid << 35 ) + ( le.executorlastname_Invalid << 37 ) + ( le.executoraddress1_Invalid << 39 ) + ( le.executoraddress2_Invalid << 41 ) + ( le.executoraddresscity_Invalid << 43 ) + ( le.executoraddressstate_Invalid << 45 ) + ( le.executoraddresszipcode_Invalid << 47 ) + ( le.executorphone_Invalid << 49 ) + ( le.attorneyfirstname_Invalid << 51 ) + ( le.attorneylastname_Invalid << 53 ) + ( le.attorneyaddress1_Invalid << 55 ) + ( le.attorneyaddress2_Invalid << 57 ) + ( le.attorneyaddresscity_Invalid << 59 ) + ( le.attorneyaddressstate_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.attorneyaddresszipcode_Invalid << 0 ) + ( le.attorneyphone_Invalid << 2 ) + ( le.cln_fname_Invalid << 4 ) + ( le.cln_mname_Invalid << 6 ) + ( le.cln_lname_Invalid << 8 ) + ( le.cln_suffix_Invalid << 10 ) + ( le.cln_fname2_Invalid << 12 ) + ( le.cln_mname2_Invalid << 14 ) + ( le.cln_lname2_Invalid << 16 ) + ( le.cln_suffix2_Invalid << 18 ) + ( le.cname_Invalid << 20 ) + ( le.predir_Invalid << 22 ) + ( le.prim_name_Invalid << 24 ) + ( le.addr_suffix_Invalid << 26 ) + ( le.postdir_Invalid << 28 ) + ( le.unit_desig_Invalid << 29 ) + ( le.sec_range_Invalid << 30 ) + ( le.p_city_name_Invalid << 32 ) + ( le.v_city_name_Invalid << 34 ) + ( le.st_Invalid << 36 ) + ( le.zip_Invalid << 38 ) + ( le.zip4_Invalid << 40 ) + ( le.cart_Invalid << 42 ) + ( le.cr_sort_sz_Invalid << 44 ) + ( le.lot_Invalid << 46 ) + ( le.lot_order_Invalid << 48 ) + ( le.dbpc_Invalid << 50 ) + ( le.chk_digit_Invalid << 52 ) + ( le.rec_type_Invalid << 54 ) + ( le.fips_county_Invalid << 56 ) + ( le.geo_lat_Invalid << 58 ) + ( le.geo_long_Invalid << 60 ) + ( le.msa_Invalid << 62 );
    SELF.ScrubsBits3 := ( le.geo_blk_Invalid << 0 ) + ( le.geo_match_Invalid << 2 ) + ( le.err_stat_Invalid << 4 ) + ( le.rawaid_Invalid << 6 );
    SELF.ScrubsCleanBits1 := ( IF(le.postdir_wouldClean, 1, 0) << 0 ) + ( IF(le.unit_desig_wouldClean, 1, 0) << 1 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_OKC_Probate_Profile);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.name_score_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.filedate_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.dod_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.masterid_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.debtorfirstname_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.debtorlastname_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.debtoraddress1_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.debtoraddress2_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.debtoraddresscity_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.debtoraddressstate_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.debtoraddresszipcode_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.dateofdeath_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.dateofbirth_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.casenumber_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.filingdate_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.lastdatetofileclaim_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.publicationstartdate_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.executorfirstname_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.executorlastname_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.executoraddress1_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.executoraddress2_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.executoraddresscity_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.executoraddressstate_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.executoraddresszipcode_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.executorphone_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.attorneyfirstname_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.attorneylastname_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.attorneyaddress1_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.attorneyaddress2_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.attorneyaddresscity_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.attorneyaddressstate_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.attorneyaddresszipcode_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.attorneyphone_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.cln_fname_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.cln_mname_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.cln_lname_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.cln_suffix_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.cln_fname2_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.cln_mname2_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.cln_lname2_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.cln_suffix2_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.cname_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.predir_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.prim_name_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.addr_suffix_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.postdir_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.p_city_name_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.v_city_name_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.st_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.zip_Invalid := (le.ScrubsBits2 >> 38) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.cart_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.lot_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.lot_order_Invalid := (le.ScrubsBits2 >> 48) & 3;
    SELF.dbpc_Invalid := (le.ScrubsBits2 >> 50) & 3;
    SELF.chk_digit_Invalid := (le.ScrubsBits2 >> 52) & 3;
    SELF.rec_type_Invalid := (le.ScrubsBits2 >> 54) & 3;
    SELF.fips_county_Invalid := (le.ScrubsBits2 >> 56) & 3;
    SELF.geo_lat_Invalid := (le.ScrubsBits2 >> 58) & 3;
    SELF.geo_long_Invalid := (le.ScrubsBits2 >> 60) & 3;
    SELF.msa_Invalid := (le.ScrubsBits2 >> 62) & 3;
    SELF.geo_blk_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.geo_match_Invalid := (le.ScrubsBits3 >> 2) & 3;
    SELF.err_stat_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.rawaid_Invalid := (le.ScrubsBits3 >> 6) & 3;
    SELF.postdir_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.unit_desig_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    name_score_ALLOW_ErrorCount := COUNT(GROUP,h.name_score_Invalid=1);
    name_score_LENGTH_ErrorCount := COUNT(GROUP,h.name_score_Invalid=2);
    name_score_Total_ErrorCount := COUNT(GROUP,h.name_score_Invalid>0);
    filedate_ALLOW_ErrorCount := COUNT(GROUP,h.filedate_Invalid=1);
    filedate_LENGTH_ErrorCount := COUNT(GROUP,h.filedate_Invalid=2);
    filedate_Total_ErrorCount := COUNT(GROUP,h.filedate_Invalid>0);
    dod_ALLOW_ErrorCount := COUNT(GROUP,h.dod_Invalid=1);
    dod_LENGTH_ErrorCount := COUNT(GROUP,h.dod_Invalid=2);
    dod_Total_ErrorCount := COUNT(GROUP,h.dod_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTH_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    masterid_ALLOW_ErrorCount := COUNT(GROUP,h.masterid_Invalid=1);
    debtorfirstname_ALLOW_ErrorCount := COUNT(GROUP,h.debtorfirstname_Invalid=1);
    debtorfirstname_LENGTH_ErrorCount := COUNT(GROUP,h.debtorfirstname_Invalid=2);
    debtorfirstname_Total_ErrorCount := COUNT(GROUP,h.debtorfirstname_Invalid>0);
    debtorlastname_ALLOW_ErrorCount := COUNT(GROUP,h.debtorlastname_Invalid=1);
    debtorlastname_LENGTH_ErrorCount := COUNT(GROUP,h.debtorlastname_Invalid=2);
    debtorlastname_Total_ErrorCount := COUNT(GROUP,h.debtorlastname_Invalid>0);
    debtoraddress1_CAPS_ErrorCount := COUNT(GROUP,h.debtoraddress1_Invalid=1);
    debtoraddress1_ALLOW_ErrorCount := COUNT(GROUP,h.debtoraddress1_Invalid=2);
    debtoraddress1_LENGTH_ErrorCount := COUNT(GROUP,h.debtoraddress1_Invalid=3);
    debtoraddress1_Total_ErrorCount := COUNT(GROUP,h.debtoraddress1_Invalid>0);
    debtoraddress2_CAPS_ErrorCount := COUNT(GROUP,h.debtoraddress2_Invalid=1);
    debtoraddress2_ALLOW_ErrorCount := COUNT(GROUP,h.debtoraddress2_Invalid=2);
    debtoraddress2_LENGTH_ErrorCount := COUNT(GROUP,h.debtoraddress2_Invalid=3);
    debtoraddress2_Total_ErrorCount := COUNT(GROUP,h.debtoraddress2_Invalid>0);
    debtoraddresscity_ALLOW_ErrorCount := COUNT(GROUP,h.debtoraddresscity_Invalid=1);
    debtoraddresscity_LENGTH_ErrorCount := COUNT(GROUP,h.debtoraddresscity_Invalid=2);
    debtoraddresscity_Total_ErrorCount := COUNT(GROUP,h.debtoraddresscity_Invalid>0);
    debtoraddressstate_ALLOW_ErrorCount := COUNT(GROUP,h.debtoraddressstate_Invalid=1);
    debtoraddressstate_LENGTH_ErrorCount := COUNT(GROUP,h.debtoraddressstate_Invalid=2);
    debtoraddressstate_Total_ErrorCount := COUNT(GROUP,h.debtoraddressstate_Invalid>0);
    debtoraddresszipcode_ALLOW_ErrorCount := COUNT(GROUP,h.debtoraddresszipcode_Invalid=1);
    debtoraddresszipcode_LENGTH_ErrorCount := COUNT(GROUP,h.debtoraddresszipcode_Invalid=2);
    debtoraddresszipcode_Total_ErrorCount := COUNT(GROUP,h.debtoraddresszipcode_Invalid>0);
    dateofdeath_ALLOW_ErrorCount := COUNT(GROUP,h.dateofdeath_Invalid=1);
    dateofdeath_LENGTH_ErrorCount := COUNT(GROUP,h.dateofdeath_Invalid=2);
    dateofdeath_Total_ErrorCount := COUNT(GROUP,h.dateofdeath_Invalid>0);
    dateofbirth_ALLOW_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid=1);
    dateofbirth_LENGTH_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid=2);
    dateofbirth_Total_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid>0);
    casenumber_ALLOW_ErrorCount := COUNT(GROUP,h.casenumber_Invalid=1);
    casenumber_LENGTH_ErrorCount := COUNT(GROUP,h.casenumber_Invalid=2);
    casenumber_Total_ErrorCount := COUNT(GROUP,h.casenumber_Invalid>0);
    filingdate_ALLOW_ErrorCount := COUNT(GROUP,h.filingdate_Invalid=1);
    filingdate_LENGTH_ErrorCount := COUNT(GROUP,h.filingdate_Invalid=2);
    filingdate_Total_ErrorCount := COUNT(GROUP,h.filingdate_Invalid>0);
    lastdatetofileclaim_ALLOW_ErrorCount := COUNT(GROUP,h.lastdatetofileclaim_Invalid=1);
    lastdatetofileclaim_LENGTH_ErrorCount := COUNT(GROUP,h.lastdatetofileclaim_Invalid=2);
    lastdatetofileclaim_Total_ErrorCount := COUNT(GROUP,h.lastdatetofileclaim_Invalid>0);
    publicationstartdate_ALLOW_ErrorCount := COUNT(GROUP,h.publicationstartdate_Invalid=1);
    publicationstartdate_LENGTH_ErrorCount := COUNT(GROUP,h.publicationstartdate_Invalid=2);
    publicationstartdate_Total_ErrorCount := COUNT(GROUP,h.publicationstartdate_Invalid>0);
    executorfirstname_ALLOW_ErrorCount := COUNT(GROUP,h.executorfirstname_Invalid=1);
    executorfirstname_LENGTH_ErrorCount := COUNT(GROUP,h.executorfirstname_Invalid=2);
    executorfirstname_Total_ErrorCount := COUNT(GROUP,h.executorfirstname_Invalid>0);
    executorlastname_ALLOW_ErrorCount := COUNT(GROUP,h.executorlastname_Invalid=1);
    executorlastname_LENGTH_ErrorCount := COUNT(GROUP,h.executorlastname_Invalid=2);
    executorlastname_Total_ErrorCount := COUNT(GROUP,h.executorlastname_Invalid>0);
    executoraddress1_CAPS_ErrorCount := COUNT(GROUP,h.executoraddress1_Invalid=1);
    executoraddress1_ALLOW_ErrorCount := COUNT(GROUP,h.executoraddress1_Invalid=2);
    executoraddress1_LENGTH_ErrorCount := COUNT(GROUP,h.executoraddress1_Invalid=3);
    executoraddress1_Total_ErrorCount := COUNT(GROUP,h.executoraddress1_Invalid>0);
    executoraddress2_CAPS_ErrorCount := COUNT(GROUP,h.executoraddress2_Invalid=1);
    executoraddress2_ALLOW_ErrorCount := COUNT(GROUP,h.executoraddress2_Invalid=2);
    executoraddress2_LENGTH_ErrorCount := COUNT(GROUP,h.executoraddress2_Invalid=3);
    executoraddress2_Total_ErrorCount := COUNT(GROUP,h.executoraddress2_Invalid>0);
    executoraddresscity_ALLOW_ErrorCount := COUNT(GROUP,h.executoraddresscity_Invalid=1);
    executoraddresscity_LENGTH_ErrorCount := COUNT(GROUP,h.executoraddresscity_Invalid=2);
    executoraddresscity_Total_ErrorCount := COUNT(GROUP,h.executoraddresscity_Invalid>0);
    executoraddressstate_ALLOW_ErrorCount := COUNT(GROUP,h.executoraddressstate_Invalid=1);
    executoraddressstate_LENGTH_ErrorCount := COUNT(GROUP,h.executoraddressstate_Invalid=2);
    executoraddressstate_Total_ErrorCount := COUNT(GROUP,h.executoraddressstate_Invalid>0);
    executoraddresszipcode_ALLOW_ErrorCount := COUNT(GROUP,h.executoraddresszipcode_Invalid=1);
    executoraddresszipcode_LENGTH_ErrorCount := COUNT(GROUP,h.executoraddresszipcode_Invalid=2);
    executoraddresszipcode_Total_ErrorCount := COUNT(GROUP,h.executoraddresszipcode_Invalid>0);
    executorphone_ALLOW_ErrorCount := COUNT(GROUP,h.executorphone_Invalid=1);
    executorphone_LENGTH_ErrorCount := COUNT(GROUP,h.executorphone_Invalid=2);
    executorphone_Total_ErrorCount := COUNT(GROUP,h.executorphone_Invalid>0);
    attorneyfirstname_ALLOW_ErrorCount := COUNT(GROUP,h.attorneyfirstname_Invalid=1);
    attorneyfirstname_LENGTH_ErrorCount := COUNT(GROUP,h.attorneyfirstname_Invalid=2);
    attorneyfirstname_Total_ErrorCount := COUNT(GROUP,h.attorneyfirstname_Invalid>0);
    attorneylastname_ALLOW_ErrorCount := COUNT(GROUP,h.attorneylastname_Invalid=1);
    attorneylastname_LENGTH_ErrorCount := COUNT(GROUP,h.attorneylastname_Invalid=2);
    attorneylastname_Total_ErrorCount := COUNT(GROUP,h.attorneylastname_Invalid>0);
    attorneyaddress1_CAPS_ErrorCount := COUNT(GROUP,h.attorneyaddress1_Invalid=1);
    attorneyaddress1_ALLOW_ErrorCount := COUNT(GROUP,h.attorneyaddress1_Invalid=2);
    attorneyaddress1_LENGTH_ErrorCount := COUNT(GROUP,h.attorneyaddress1_Invalid=3);
    attorneyaddress1_Total_ErrorCount := COUNT(GROUP,h.attorneyaddress1_Invalid>0);
    attorneyaddress2_CAPS_ErrorCount := COUNT(GROUP,h.attorneyaddress2_Invalid=1);
    attorneyaddress2_ALLOW_ErrorCount := COUNT(GROUP,h.attorneyaddress2_Invalid=2);
    attorneyaddress2_LENGTH_ErrorCount := COUNT(GROUP,h.attorneyaddress2_Invalid=3);
    attorneyaddress2_Total_ErrorCount := COUNT(GROUP,h.attorneyaddress2_Invalid>0);
    attorneyaddresscity_ALLOW_ErrorCount := COUNT(GROUP,h.attorneyaddresscity_Invalid=1);
    attorneyaddresscity_LENGTH_ErrorCount := COUNT(GROUP,h.attorneyaddresscity_Invalid=2);
    attorneyaddresscity_Total_ErrorCount := COUNT(GROUP,h.attorneyaddresscity_Invalid>0);
    attorneyaddressstate_ALLOW_ErrorCount := COUNT(GROUP,h.attorneyaddressstate_Invalid=1);
    attorneyaddressstate_LENGTH_ErrorCount := COUNT(GROUP,h.attorneyaddressstate_Invalid=2);
    attorneyaddressstate_Total_ErrorCount := COUNT(GROUP,h.attorneyaddressstate_Invalid>0);
    attorneyaddresszipcode_ALLOW_ErrorCount := COUNT(GROUP,h.attorneyaddresszipcode_Invalid=1);
    attorneyaddresszipcode_LENGTH_ErrorCount := COUNT(GROUP,h.attorneyaddresszipcode_Invalid=2);
    attorneyaddresszipcode_Total_ErrorCount := COUNT(GROUP,h.attorneyaddresszipcode_Invalid>0);
    attorneyphone_ALLOW_ErrorCount := COUNT(GROUP,h.attorneyphone_Invalid=1);
    attorneyphone_LENGTH_ErrorCount := COUNT(GROUP,h.attorneyphone_Invalid=2);
    attorneyphone_Total_ErrorCount := COUNT(GROUP,h.attorneyphone_Invalid>0);
    cln_fname_ALLOW_ErrorCount := COUNT(GROUP,h.cln_fname_Invalid=1);
    cln_fname_LENGTH_ErrorCount := COUNT(GROUP,h.cln_fname_Invalid=2);
    cln_fname_Total_ErrorCount := COUNT(GROUP,h.cln_fname_Invalid>0);
    cln_mname_ALLOW_ErrorCount := COUNT(GROUP,h.cln_mname_Invalid=1);
    cln_mname_LENGTH_ErrorCount := COUNT(GROUP,h.cln_mname_Invalid=2);
    cln_mname_Total_ErrorCount := COUNT(GROUP,h.cln_mname_Invalid>0);
    cln_lname_ALLOW_ErrorCount := COUNT(GROUP,h.cln_lname_Invalid=1);
    cln_lname_LENGTH_ErrorCount := COUNT(GROUP,h.cln_lname_Invalid=2);
    cln_lname_Total_ErrorCount := COUNT(GROUP,h.cln_lname_Invalid>0);
    cln_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.cln_suffix_Invalid=1);
    cln_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.cln_suffix_Invalid=2);
    cln_suffix_Total_ErrorCount := COUNT(GROUP,h.cln_suffix_Invalid>0);
    cln_fname2_ALLOW_ErrorCount := COUNT(GROUP,h.cln_fname2_Invalid=1);
    cln_fname2_LENGTH_ErrorCount := COUNT(GROUP,h.cln_fname2_Invalid=2);
    cln_fname2_Total_ErrorCount := COUNT(GROUP,h.cln_fname2_Invalid>0);
    cln_mname2_ALLOW_ErrorCount := COUNT(GROUP,h.cln_mname2_Invalid=1);
    cln_mname2_LENGTH_ErrorCount := COUNT(GROUP,h.cln_mname2_Invalid=2);
    cln_mname2_Total_ErrorCount := COUNT(GROUP,h.cln_mname2_Invalid>0);
    cln_lname2_ALLOW_ErrorCount := COUNT(GROUP,h.cln_lname2_Invalid=1);
    cln_lname2_LENGTH_ErrorCount := COUNT(GROUP,h.cln_lname2_Invalid=2);
    cln_lname2_Total_ErrorCount := COUNT(GROUP,h.cln_lname2_Invalid>0);
    cln_suffix2_ALLOW_ErrorCount := COUNT(GROUP,h.cln_suffix2_Invalid=1);
    cln_suffix2_LENGTH_ErrorCount := COUNT(GROUP,h.cln_suffix2_Invalid=2);
    cln_suffix2_Total_ErrorCount := COUNT(GROUP,h.cln_suffix2_Invalid>0);
    cname_CAPS_ErrorCount := COUNT(GROUP,h.cname_Invalid=1);
    cname_ALLOW_ErrorCount := COUNT(GROUP,h.cname_Invalid=2);
    cname_LENGTH_ErrorCount := COUNT(GROUP,h.cname_Invalid=3);
    cname_Total_ErrorCount := COUNT(GROUP,h.cname_Invalid>0);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_LENGTH_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    addr_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=2);
    addr_suffix_Total_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid>0);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_ALLOW_WouldModifyCount := COUNT(GROUP,h.postdir_Invalid=1 AND h.postdir_wouldClean);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_ALLOW_WouldModifyCount := COUNT(GROUP,h.unit_desig_Invalid=1 AND h.unit_desig_wouldClean);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_LENGTH_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cart_LENGTH_ErrorCount := COUNT(GROUP,h.cart_Invalid=2);
    cart_Total_ErrorCount := COUNT(GROUP,h.cart_Invalid>0);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    cr_sort_sz_LENGTH_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=2);
    cr_sort_sz_Total_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid>0);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_LENGTH_ErrorCount := COUNT(GROUP,h.lot_Invalid=2);
    lot_Total_ErrorCount := COUNT(GROUP,h.lot_Invalid>0);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=2);
    lot_order_Total_ErrorCount := COUNT(GROUP,h.lot_order_Invalid>0);
    dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    dbpc_LENGTH_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=2);
    dbpc_Total_ErrorCount := COUNT(GROUP,h.dbpc_Invalid>0);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=2);
    chk_digit_Total_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid>0);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    fips_county_LENGTH_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=2);
    fips_county_Total_ErrorCount := COUNT(GROUP,h.fips_county_Invalid>0);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_lat_LENGTH_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=2);
    geo_lat_Total_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid>0);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    geo_long_LENGTH_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=2);
    geo_long_Total_ErrorCount := COUNT(GROUP,h.geo_long_Invalid>0);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    msa_LENGTH_ErrorCount := COUNT(GROUP,h.msa_Invalid=2);
    msa_Total_ErrorCount := COUNT(GROUP,h.msa_Invalid>0);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=2);
    geo_blk_Total_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid>0);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=2);
    geo_match_Total_ErrorCount := COUNT(GROUP,h.geo_match_Invalid>0);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=2);
    err_stat_Total_ErrorCount := COUNT(GROUP,h.err_stat_Invalid>0);
    rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    rawaid_LENGTH_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=2);
    rawaid_Total_ErrorCount := COUNT(GROUP,h.rawaid_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.name_score_Invalid > 0 OR h.filedate_Invalid > 0 OR h.dod_Invalid > 0 OR h.dob_Invalid > 0 OR h.masterid_Invalid > 0 OR h.debtorfirstname_Invalid > 0 OR h.debtorlastname_Invalid > 0 OR h.debtoraddress1_Invalid > 0 OR h.debtoraddress2_Invalid > 0 OR h.debtoraddresscity_Invalid > 0 OR h.debtoraddressstate_Invalid > 0 OR h.debtoraddresszipcode_Invalid > 0 OR h.dateofdeath_Invalid > 0 OR h.dateofbirth_Invalid > 0 OR h.casenumber_Invalid > 0 OR h.filingdate_Invalid > 0 OR h.lastdatetofileclaim_Invalid > 0 OR h.publicationstartdate_Invalid > 0 OR h.executorfirstname_Invalid > 0 OR h.executorlastname_Invalid > 0 OR h.executoraddress1_Invalid > 0 OR h.executoraddress2_Invalid > 0 OR h.executoraddresscity_Invalid > 0 OR h.executoraddressstate_Invalid > 0 OR h.executoraddresszipcode_Invalid > 0 OR h.executorphone_Invalid > 0 OR h.attorneyfirstname_Invalid > 0 OR h.attorneylastname_Invalid > 0 OR h.attorneyaddress1_Invalid > 0 OR h.attorneyaddress2_Invalid > 0 OR h.attorneyaddresscity_Invalid > 0 OR h.attorneyaddressstate_Invalid > 0 OR h.attorneyaddresszipcode_Invalid > 0 OR h.attorneyphone_Invalid > 0 OR h.cln_fname_Invalid > 0 OR h.cln_mname_Invalid > 0 OR h.cln_lname_Invalid > 0 OR h.cln_suffix_Invalid > 0 OR h.cln_fname2_Invalid > 0 OR h.cln_mname2_Invalid > 0 OR h.cln_lname2_Invalid > 0 OR h.cln_suffix2_Invalid > 0 OR h.cname_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dbpc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.rawaid_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.postdir_wouldClean OR h.unit_desig_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.name_score_Total_ErrorCount > 0, 1, 0) + IF(le.filedate_Total_ErrorCount > 0, 1, 0) + IF(le.dod_Total_ErrorCount > 0, 1, 0) + IF(le.dob_Total_ErrorCount > 0, 1, 0) + IF(le.masterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.debtorfirstname_Total_ErrorCount > 0, 1, 0) + IF(le.debtorlastname_Total_ErrorCount > 0, 1, 0) + IF(le.debtoraddress1_Total_ErrorCount > 0, 1, 0) + IF(le.debtoraddress2_Total_ErrorCount > 0, 1, 0) + IF(le.debtoraddresscity_Total_ErrorCount > 0, 1, 0) + IF(le.debtoraddressstate_Total_ErrorCount > 0, 1, 0) + IF(le.debtoraddresszipcode_Total_ErrorCount > 0, 1, 0) + IF(le.dateofdeath_Total_ErrorCount > 0, 1, 0) + IF(le.dateofbirth_Total_ErrorCount > 0, 1, 0) + IF(le.casenumber_Total_ErrorCount > 0, 1, 0) + IF(le.filingdate_Total_ErrorCount > 0, 1, 0) + IF(le.lastdatetofileclaim_Total_ErrorCount > 0, 1, 0) + IF(le.publicationstartdate_Total_ErrorCount > 0, 1, 0) + IF(le.executorfirstname_Total_ErrorCount > 0, 1, 0) + IF(le.executorlastname_Total_ErrorCount > 0, 1, 0) + IF(le.executoraddress1_Total_ErrorCount > 0, 1, 0) + IF(le.executoraddress2_Total_ErrorCount > 0, 1, 0) + IF(le.executoraddresscity_Total_ErrorCount > 0, 1, 0) + IF(le.executoraddressstate_Total_ErrorCount > 0, 1, 0) + IF(le.executoraddresszipcode_Total_ErrorCount > 0, 1, 0) + IF(le.executorphone_Total_ErrorCount > 0, 1, 0) + IF(le.attorneyfirstname_Total_ErrorCount > 0, 1, 0) + IF(le.attorneylastname_Total_ErrorCount > 0, 1, 0) + IF(le.attorneyaddress1_Total_ErrorCount > 0, 1, 0) + IF(le.attorneyaddress2_Total_ErrorCount > 0, 1, 0) + IF(le.attorneyaddresscity_Total_ErrorCount > 0, 1, 0) + IF(le.attorneyaddressstate_Total_ErrorCount > 0, 1, 0) + IF(le.attorneyaddresszipcode_Total_ErrorCount > 0, 1, 0) + IF(le.attorneyphone_Total_ErrorCount > 0, 1, 0) + IF(le.cln_fname_Total_ErrorCount > 0, 1, 0) + IF(le.cln_mname_Total_ErrorCount > 0, 1, 0) + IF(le.cln_lname_Total_ErrorCount > 0, 1, 0) + IF(le.cln_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.cln_fname2_Total_ErrorCount > 0, 1, 0) + IF(le.cln_mname2_Total_ErrorCount > 0, 1, 0) + IF(le.cln_lname2_Total_ErrorCount > 0, 1, 0) + IF(le.cln_suffix2_Total_ErrorCount > 0, 1, 0) + IF(le.cname_Total_ErrorCount > 0, 1, 0) + IF(le.predir_Total_ErrorCount > 0, 1, 0) + IF(le.prim_name_Total_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_Total_ErrorCount > 0, 1, 0) + IF(le.p_city_name_Total_ErrorCount > 0, 1, 0) + IF(le.v_city_name_Total_ErrorCount > 0, 1, 0) + IF(le.st_Total_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_Total_ErrorCount > 0, 1, 0) + IF(le.cart_Total_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_Total_ErrorCount > 0, 1, 0) + IF(le.lot_Total_ErrorCount > 0, 1, 0) + IF(le.lot_order_Total_ErrorCount > 0, 1, 0) + IF(le.dbpc_Total_ErrorCount > 0, 1, 0) + IF(le.chk_digit_Total_ErrorCount > 0, 1, 0) + IF(le.rec_type_Total_ErrorCount > 0, 1, 0) + IF(le.fips_county_Total_ErrorCount > 0, 1, 0) + IF(le.geo_lat_Total_ErrorCount > 0, 1, 0) + IF(le.geo_long_Total_ErrorCount > 0, 1, 0) + IF(le.msa_Total_ErrorCount > 0, 1, 0) + IF(le.geo_blk_Total_ErrorCount > 0, 1, 0) + IF(le.geo_match_Total_ErrorCount > 0, 1, 0) + IF(le.err_stat_Total_ErrorCount > 0, 1, 0) + IF(le.rawaid_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_score_LENGTH_ErrorCount > 0, 1, 0) + IF(le.filedate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filedate_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dod_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dod_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_LENGTH_ErrorCount > 0, 1, 0) + IF(le.masterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.debtorfirstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.debtorfirstname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.debtorlastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.debtorlastname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.debtoraddress1_CAPS_ErrorCount > 0, 1, 0) + IF(le.debtoraddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.debtoraddress1_LENGTH_ErrorCount > 0, 1, 0) + IF(le.debtoraddress2_CAPS_ErrorCount > 0, 1, 0) + IF(le.debtoraddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.debtoraddress2_LENGTH_ErrorCount > 0, 1, 0) + IF(le.debtoraddresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.debtoraddresscity_LENGTH_ErrorCount > 0, 1, 0) + IF(le.debtoraddressstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.debtoraddressstate_LENGTH_ErrorCount > 0, 1, 0) + IF(le.debtoraddresszipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.debtoraddresszipcode_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dateofdeath_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateofdeath_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dateofbirth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateofbirth_LENGTH_ErrorCount > 0, 1, 0) + IF(le.casenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.casenumber_LENGTH_ErrorCount > 0, 1, 0) + IF(le.filingdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filingdate_LENGTH_ErrorCount > 0, 1, 0) + IF(le.lastdatetofileclaim_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdatetofileclaim_LENGTH_ErrorCount > 0, 1, 0) + IF(le.publicationstartdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicationstartdate_LENGTH_ErrorCount > 0, 1, 0) + IF(le.executorfirstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.executorfirstname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.executorlastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.executorlastname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.executoraddress1_CAPS_ErrorCount > 0, 1, 0) + IF(le.executoraddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.executoraddress1_LENGTH_ErrorCount > 0, 1, 0) + IF(le.executoraddress2_CAPS_ErrorCount > 0, 1, 0) + IF(le.executoraddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.executoraddress2_LENGTH_ErrorCount > 0, 1, 0) + IF(le.executoraddresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.executoraddresscity_LENGTH_ErrorCount > 0, 1, 0) + IF(le.executoraddressstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.executoraddressstate_LENGTH_ErrorCount > 0, 1, 0) + IF(le.executoraddresszipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.executoraddresszipcode_LENGTH_ErrorCount > 0, 1, 0) + IF(le.executorphone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.executorphone_LENGTH_ErrorCount > 0, 1, 0) + IF(le.attorneyfirstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.attorneyfirstname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.attorneylastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.attorneylastname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.attorneyaddress1_CAPS_ErrorCount > 0, 1, 0) + IF(le.attorneyaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.attorneyaddress1_LENGTH_ErrorCount > 0, 1, 0) + IF(le.attorneyaddress2_CAPS_ErrorCount > 0, 1, 0) + IF(le.attorneyaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.attorneyaddress2_LENGTH_ErrorCount > 0, 1, 0) + IF(le.attorneyaddresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.attorneyaddresscity_LENGTH_ErrorCount > 0, 1, 0) + IF(le.attorneyaddressstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.attorneyaddressstate_LENGTH_ErrorCount > 0, 1, 0) + IF(le.attorneyaddresszipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.attorneyaddresszipcode_LENGTH_ErrorCount > 0, 1, 0) + IF(le.attorneyphone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.attorneyphone_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cln_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cln_fname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cln_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cln_mname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cln_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cln_lname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cln_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cln_suffix_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cln_fname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cln_fname2_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cln_mname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cln_mname2_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cln_lname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cln_lname2_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cln_suffix2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cln_suffix2_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cname_CAPS_ErrorCount > 0, 1, 0) + IF(le.cname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_LENGTH_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_LENGTH_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_LENGTH_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_LENGTH_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTH_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_LENGTH_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_LENGTH_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbpc_LENGTH_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_LENGTH_ErrorCount > 0, 1, 0) + IF(le.rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_LENGTH_ErrorCount > 0, 1, 0) + IF(le.fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_county_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_LENGTH_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_LENGTH_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_LENGTH_ErrorCount > 0, 1, 0) + IF(le.rawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawaid_LENGTH_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.postdir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.name_score_Invalid,le.filedate_Invalid,le.dod_Invalid,le.dob_Invalid,le.masterid_Invalid,le.debtorfirstname_Invalid,le.debtorlastname_Invalid,le.debtoraddress1_Invalid,le.debtoraddress2_Invalid,le.debtoraddresscity_Invalid,le.debtoraddressstate_Invalid,le.debtoraddresszipcode_Invalid,le.dateofdeath_Invalid,le.dateofbirth_Invalid,le.casenumber_Invalid,le.filingdate_Invalid,le.lastdatetofileclaim_Invalid,le.publicationstartdate_Invalid,le.executorfirstname_Invalid,le.executorlastname_Invalid,le.executoraddress1_Invalid,le.executoraddress2_Invalid,le.executoraddresscity_Invalid,le.executoraddressstate_Invalid,le.executoraddresszipcode_Invalid,le.executorphone_Invalid,le.attorneyfirstname_Invalid,le.attorneylastname_Invalid,le.attorneyaddress1_Invalid,le.attorneyaddress2_Invalid,le.attorneyaddresscity_Invalid,le.attorneyaddressstate_Invalid,le.attorneyaddresszipcode_Invalid,le.attorneyphone_Invalid,le.cln_fname_Invalid,le.cln_mname_Invalid,le.cln_lname_Invalid,le.cln_suffix_Invalid,le.cln_fname2_Invalid,le.cln_mname2_Invalid,le.cln_lname2_Invalid,le.cln_suffix2_Invalid,le.cname_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.rawaid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_name_score(le.name_score_Invalid),Fields.InvalidMessage_filedate(le.filedate_Invalid),Fields.InvalidMessage_dod(le.dod_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_masterid(le.masterid_Invalid),Fields.InvalidMessage_debtorfirstname(le.debtorfirstname_Invalid),Fields.InvalidMessage_debtorlastname(le.debtorlastname_Invalid),Fields.InvalidMessage_debtoraddress1(le.debtoraddress1_Invalid),Fields.InvalidMessage_debtoraddress2(le.debtoraddress2_Invalid),Fields.InvalidMessage_debtoraddresscity(le.debtoraddresscity_Invalid),Fields.InvalidMessage_debtoraddressstate(le.debtoraddressstate_Invalid),Fields.InvalidMessage_debtoraddresszipcode(le.debtoraddresszipcode_Invalid),Fields.InvalidMessage_dateofdeath(le.dateofdeath_Invalid),Fields.InvalidMessage_dateofbirth(le.dateofbirth_Invalid),Fields.InvalidMessage_casenumber(le.casenumber_Invalid),Fields.InvalidMessage_filingdate(le.filingdate_Invalid),Fields.InvalidMessage_lastdatetofileclaim(le.lastdatetofileclaim_Invalid),Fields.InvalidMessage_publicationstartdate(le.publicationstartdate_Invalid),Fields.InvalidMessage_executorfirstname(le.executorfirstname_Invalid),Fields.InvalidMessage_executorlastname(le.executorlastname_Invalid),Fields.InvalidMessage_executoraddress1(le.executoraddress1_Invalid),Fields.InvalidMessage_executoraddress2(le.executoraddress2_Invalid),Fields.InvalidMessage_executoraddresscity(le.executoraddresscity_Invalid),Fields.InvalidMessage_executoraddressstate(le.executoraddressstate_Invalid),Fields.InvalidMessage_executoraddresszipcode(le.executoraddresszipcode_Invalid),Fields.InvalidMessage_executorphone(le.executorphone_Invalid),Fields.InvalidMessage_attorneyfirstname(le.attorneyfirstname_Invalid),Fields.InvalidMessage_attorneylastname(le.attorneylastname_Invalid),Fields.InvalidMessage_attorneyaddress1(le.attorneyaddress1_Invalid),Fields.InvalidMessage_attorneyaddress2(le.attorneyaddress2_Invalid),Fields.InvalidMessage_attorneyaddresscity(le.attorneyaddresscity_Invalid),Fields.InvalidMessage_attorneyaddressstate(le.attorneyaddressstate_Invalid),Fields.InvalidMessage_attorneyaddresszipcode(le.attorneyaddresszipcode_Invalid),Fields.InvalidMessage_attorneyphone(le.attorneyphone_Invalid),Fields.InvalidMessage_cln_fname(le.cln_fname_Invalid),Fields.InvalidMessage_cln_mname(le.cln_mname_Invalid),Fields.InvalidMessage_cln_lname(le.cln_lname_Invalid),Fields.InvalidMessage_cln_suffix(le.cln_suffix_Invalid),Fields.InvalidMessage_cln_fname2(le.cln_fname2_Invalid),Fields.InvalidMessage_cln_mname2(le.cln_mname2_Invalid),Fields.InvalidMessage_cln_lname2(le.cln_lname2_Invalid),Fields.InvalidMessage_cln_suffix2(le.cln_suffix2_Invalid),Fields.InvalidMessage_cname(le.cname_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Fields.InvalidMessage_rawaid(le.rawaid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.name_score_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.filedate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dod_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.masterid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.debtorfirstname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.debtorlastname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.debtoraddress1_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.debtoraddress2_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.debtoraddresscity_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.debtoraddressstate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.debtoraddresszipcode_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dateofdeath_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dateofbirth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.casenumber_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.filingdate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lastdatetofileclaim_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.publicationstartdate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executorfirstname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executorlastname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executoraddress1_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executoraddress2_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executoraddresscity_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executoraddressstate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executoraddresszipcode_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executorphone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.attorneyfirstname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.attorneylastname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.attorneyaddress1_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.attorneyaddress2_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.attorneyaddresscity_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.attorneyaddressstate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.attorneyaddresszipcode_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.attorneyphone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cln_fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cln_mname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cln_lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cln_suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cln_fname2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cln_mname2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cln_lname2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cln_suffix2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cname_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'name_score','filedate','dod','dob','masterid','debtorfirstname','debtorlastname','debtoraddress1','debtoraddress2','debtoraddresscity','debtoraddressstate','debtoraddresszipcode','dateofdeath','dateofbirth','casenumber','filingdate','lastdatetofileclaim','publicationstartdate','executorfirstname','executorlastname','executoraddress1','executoraddress2','executoraddresscity','executoraddressstate','executoraddresszipcode','executorphone','attorneyfirstname','attorneylastname','attorneyaddress1','attorneyaddress2','attorneyaddresscity','attorneyaddressstate','attorneyaddresszipcode','attorneyphone','cln_fname','cln_mname','cln_lname','cln_suffix','cln_fname2','cln_mname2','cln_lname2','cln_suffix2','cname','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_Num','invalid_date','invalid_date','invalid_date','alphasandnums','invalid_name','invalid_name','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip','invalid_date','invalid_date','invalid_casenumber','invalid_date','invalid_date','invalid_date','invalid_name','invalid_name','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip','invalid_phone','invalid_name','invalid_name','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip','invalid_phone','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_company','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.name_score,(SALT38.StrType)le.filedate,(SALT38.StrType)le.dod,(SALT38.StrType)le.dob,(SALT38.StrType)le.masterid,(SALT38.StrType)le.debtorfirstname,(SALT38.StrType)le.debtorlastname,(SALT38.StrType)le.debtoraddress1,(SALT38.StrType)le.debtoraddress2,(SALT38.StrType)le.debtoraddresscity,(SALT38.StrType)le.debtoraddressstate,(SALT38.StrType)le.debtoraddresszipcode,(SALT38.StrType)le.dateofdeath,(SALT38.StrType)le.dateofbirth,(SALT38.StrType)le.casenumber,(SALT38.StrType)le.filingdate,(SALT38.StrType)le.lastdatetofileclaim,(SALT38.StrType)le.publicationstartdate,(SALT38.StrType)le.executorfirstname,(SALT38.StrType)le.executorlastname,(SALT38.StrType)le.executoraddress1,(SALT38.StrType)le.executoraddress2,(SALT38.StrType)le.executoraddresscity,(SALT38.StrType)le.executoraddressstate,(SALT38.StrType)le.executoraddresszipcode,(SALT38.StrType)le.executorphone,(SALT38.StrType)le.attorneyfirstname,(SALT38.StrType)le.attorneylastname,(SALT38.StrType)le.attorneyaddress1,(SALT38.StrType)le.attorneyaddress2,(SALT38.StrType)le.attorneyaddresscity,(SALT38.StrType)le.attorneyaddressstate,(SALT38.StrType)le.attorneyaddresszipcode,(SALT38.StrType)le.attorneyphone,(SALT38.StrType)le.cln_fname,(SALT38.StrType)le.cln_mname,(SALT38.StrType)le.cln_lname,(SALT38.StrType)le.cln_suffix,(SALT38.StrType)le.cln_fname2,(SALT38.StrType)le.cln_mname2,(SALT38.StrType)le.cln_lname2,(SALT38.StrType)le.cln_suffix2,(SALT38.StrType)le.cname,(SALT38.StrType)le.predir,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.addr_suffix,(SALT38.StrType)le.postdir,(SALT38.StrType)le.unit_desig,(SALT38.StrType)le.sec_range,(SALT38.StrType)le.p_city_name,(SALT38.StrType)le.v_city_name,(SALT38.StrType)le.st,(SALT38.StrType)le.zip,(SALT38.StrType)le.zip4,(SALT38.StrType)le.cart,(SALT38.StrType)le.cr_sort_sz,(SALT38.StrType)le.lot,(SALT38.StrType)le.lot_order,(SALT38.StrType)le.dbpc,(SALT38.StrType)le.chk_digit,(SALT38.StrType)le.rec_type,(SALT38.StrType)le.fips_county,(SALT38.StrType)le.geo_lat,(SALT38.StrType)le.geo_long,(SALT38.StrType)le.msa,(SALT38.StrType)le.geo_blk,(SALT38.StrType)le.geo_match,(SALT38.StrType)le.err_stat,(SALT38.StrType)le.rawaid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,69,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_OKC_Probate_Profile) prevDS = DATASET([], Layout_OKC_Probate_Profile), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'name_score:invalid_Num:ALLOW','name_score:invalid_Num:LENGTH'
          ,'filedate:invalid_date:ALLOW','filedate:invalid_date:LENGTH'
          ,'dod:invalid_date:ALLOW','dod:invalid_date:LENGTH'
          ,'dob:invalid_date:ALLOW','dob:invalid_date:LENGTH'
          ,'masterid:alphasandnums:ALLOW'
          ,'debtorfirstname:invalid_name:ALLOW','debtorfirstname:invalid_name:LENGTH'
          ,'debtorlastname:invalid_name:ALLOW','debtorlastname:invalid_name:LENGTH'
          ,'debtoraddress1:invalid_address:CAPS','debtoraddress1:invalid_address:ALLOW','debtoraddress1:invalid_address:LENGTH'
          ,'debtoraddress2:invalid_address:CAPS','debtoraddress2:invalid_address:ALLOW','debtoraddress2:invalid_address:LENGTH'
          ,'debtoraddresscity:invalid_city:ALLOW','debtoraddresscity:invalid_city:LENGTH'
          ,'debtoraddressstate:invalid_state:ALLOW','debtoraddressstate:invalid_state:LENGTH'
          ,'debtoraddresszipcode:invalid_zip:ALLOW','debtoraddresszipcode:invalid_zip:LENGTH'
          ,'dateofdeath:invalid_date:ALLOW','dateofdeath:invalid_date:LENGTH'
          ,'dateofbirth:invalid_date:ALLOW','dateofbirth:invalid_date:LENGTH'
          ,'casenumber:invalid_casenumber:ALLOW','casenumber:invalid_casenumber:LENGTH'
          ,'filingdate:invalid_date:ALLOW','filingdate:invalid_date:LENGTH'
          ,'lastdatetofileclaim:invalid_date:ALLOW','lastdatetofileclaim:invalid_date:LENGTH'
          ,'publicationstartdate:invalid_date:ALLOW','publicationstartdate:invalid_date:LENGTH'
          ,'executorfirstname:invalid_name:ALLOW','executorfirstname:invalid_name:LENGTH'
          ,'executorlastname:invalid_name:ALLOW','executorlastname:invalid_name:LENGTH'
          ,'executoraddress1:invalid_address:CAPS','executoraddress1:invalid_address:ALLOW','executoraddress1:invalid_address:LENGTH'
          ,'executoraddress2:invalid_address:CAPS','executoraddress2:invalid_address:ALLOW','executoraddress2:invalid_address:LENGTH'
          ,'executoraddresscity:invalid_city:ALLOW','executoraddresscity:invalid_city:LENGTH'
          ,'executoraddressstate:invalid_state:ALLOW','executoraddressstate:invalid_state:LENGTH'
          ,'executoraddresszipcode:invalid_zip:ALLOW','executoraddresszipcode:invalid_zip:LENGTH'
          ,'executorphone:invalid_phone:ALLOW','executorphone:invalid_phone:LENGTH'
          ,'attorneyfirstname:invalid_name:ALLOW','attorneyfirstname:invalid_name:LENGTH'
          ,'attorneylastname:invalid_name:ALLOW','attorneylastname:invalid_name:LENGTH'
          ,'attorneyaddress1:invalid_address:CAPS','attorneyaddress1:invalid_address:ALLOW','attorneyaddress1:invalid_address:LENGTH'
          ,'attorneyaddress2:invalid_address:CAPS','attorneyaddress2:invalid_address:ALLOW','attorneyaddress2:invalid_address:LENGTH'
          ,'attorneyaddresscity:invalid_city:ALLOW','attorneyaddresscity:invalid_city:LENGTH'
          ,'attorneyaddressstate:invalid_state:ALLOW','attorneyaddressstate:invalid_state:LENGTH'
          ,'attorneyaddresszipcode:invalid_zip:ALLOW','attorneyaddresszipcode:invalid_zip:LENGTH'
          ,'attorneyphone:invalid_phone:ALLOW','attorneyphone:invalid_phone:LENGTH'
          ,'cln_fname:invalid_name:ALLOW','cln_fname:invalid_name:LENGTH'
          ,'cln_mname:invalid_name:ALLOW','cln_mname:invalid_name:LENGTH'
          ,'cln_lname:invalid_name:ALLOW','cln_lname:invalid_name:LENGTH'
          ,'cln_suffix:invalid_name:ALLOW','cln_suffix:invalid_name:LENGTH'
          ,'cln_fname2:invalid_name:ALLOW','cln_fname2:invalid_name:LENGTH'
          ,'cln_mname2:invalid_name:ALLOW','cln_mname2:invalid_name:LENGTH'
          ,'cln_lname2:invalid_name:ALLOW','cln_lname2:invalid_name:LENGTH'
          ,'cln_suffix2:invalid_name:ALLOW','cln_suffix2:invalid_name:LENGTH'
          ,'cname:invalid_company:CAPS','cname:invalid_company:ALLOW','cname:invalid_company:LENGTH'
          ,'predir:predir:ALLOW','predir:predir:LENGTH'
          ,'prim_name:prim_name:ALLOW','prim_name:prim_name:LENGTH'
          ,'addr_suffix:addr_suffix:ALLOW','addr_suffix:addr_suffix:LENGTH'
          ,'postdir:postdir:ALLOW'
          ,'unit_desig:unit_desig:ALLOW'
          ,'sec_range:sec_range:ALLOW','sec_range:sec_range:LENGTH'
          ,'p_city_name:p_city_name:ALLOW','p_city_name:p_city_name:LENGTH'
          ,'v_city_name:v_city_name:ALLOW','v_city_name:v_city_name:LENGTH'
          ,'st:st:ALLOW','st:st:LENGTH'
          ,'zip:zip:ALLOW','zip:zip:LENGTH'
          ,'zip4:zip4:ALLOW','zip4:zip4:LENGTH'
          ,'cart:cart:ALLOW','cart:cart:LENGTH'
          ,'cr_sort_sz:cr_sort_sz:ALLOW','cr_sort_sz:cr_sort_sz:LENGTH'
          ,'lot:lot:ALLOW','lot:lot:LENGTH'
          ,'lot_order:lot_order:ALLOW','lot_order:lot_order:LENGTH'
          ,'dbpc:dbpc:ALLOW','dbpc:dbpc:LENGTH'
          ,'chk_digit:chk_digit:ALLOW','chk_digit:chk_digit:LENGTH'
          ,'rec_type:rec_type:ALLOW','rec_type:rec_type:LENGTH'
          ,'fips_county:fips_county:ALLOW','fips_county:fips_county:LENGTH'
          ,'geo_lat:geo_lat:ALLOW','geo_lat:geo_lat:LENGTH'
          ,'geo_long:geo_long:ALLOW','geo_long:geo_long:LENGTH'
          ,'msa:msa:ALLOW','msa:msa:LENGTH'
          ,'geo_blk:geo_blk:ALLOW','geo_blk:geo_blk:LENGTH'
          ,'geo_match:geo_match:ALLOW','geo_match:geo_match:LENGTH'
          ,'err_stat:err_stat:ALLOW','err_stat:err_stat:LENGTH'
          ,'rawaid:rawaid:ALLOW','rawaid:rawaid:LENGTH'
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
          ,Fields.InvalidMessage_name_score(1),Fields.InvalidMessage_name_score(2)
          ,Fields.InvalidMessage_filedate(1),Fields.InvalidMessage_filedate(2)
          ,Fields.InvalidMessage_dod(1),Fields.InvalidMessage_dod(2)
          ,Fields.InvalidMessage_dob(1),Fields.InvalidMessage_dob(2)
          ,Fields.InvalidMessage_masterid(1)
          ,Fields.InvalidMessage_debtorfirstname(1),Fields.InvalidMessage_debtorfirstname(2)
          ,Fields.InvalidMessage_debtorlastname(1),Fields.InvalidMessage_debtorlastname(2)
          ,Fields.InvalidMessage_debtoraddress1(1),Fields.InvalidMessage_debtoraddress1(2),Fields.InvalidMessage_debtoraddress1(3)
          ,Fields.InvalidMessage_debtoraddress2(1),Fields.InvalidMessage_debtoraddress2(2),Fields.InvalidMessage_debtoraddress2(3)
          ,Fields.InvalidMessage_debtoraddresscity(1),Fields.InvalidMessage_debtoraddresscity(2)
          ,Fields.InvalidMessage_debtoraddressstate(1),Fields.InvalidMessage_debtoraddressstate(2)
          ,Fields.InvalidMessage_debtoraddresszipcode(1),Fields.InvalidMessage_debtoraddresszipcode(2)
          ,Fields.InvalidMessage_dateofdeath(1),Fields.InvalidMessage_dateofdeath(2)
          ,Fields.InvalidMessage_dateofbirth(1),Fields.InvalidMessage_dateofbirth(2)
          ,Fields.InvalidMessage_casenumber(1),Fields.InvalidMessage_casenumber(2)
          ,Fields.InvalidMessage_filingdate(1),Fields.InvalidMessage_filingdate(2)
          ,Fields.InvalidMessage_lastdatetofileclaim(1),Fields.InvalidMessage_lastdatetofileclaim(2)
          ,Fields.InvalidMessage_publicationstartdate(1),Fields.InvalidMessage_publicationstartdate(2)
          ,Fields.InvalidMessage_executorfirstname(1),Fields.InvalidMessage_executorfirstname(2)
          ,Fields.InvalidMessage_executorlastname(1),Fields.InvalidMessage_executorlastname(2)
          ,Fields.InvalidMessage_executoraddress1(1),Fields.InvalidMessage_executoraddress1(2),Fields.InvalidMessage_executoraddress1(3)
          ,Fields.InvalidMessage_executoraddress2(1),Fields.InvalidMessage_executoraddress2(2),Fields.InvalidMessage_executoraddress2(3)
          ,Fields.InvalidMessage_executoraddresscity(1),Fields.InvalidMessage_executoraddresscity(2)
          ,Fields.InvalidMessage_executoraddressstate(1),Fields.InvalidMessage_executoraddressstate(2)
          ,Fields.InvalidMessage_executoraddresszipcode(1),Fields.InvalidMessage_executoraddresszipcode(2)
          ,Fields.InvalidMessage_executorphone(1),Fields.InvalidMessage_executorphone(2)
          ,Fields.InvalidMessage_attorneyfirstname(1),Fields.InvalidMessage_attorneyfirstname(2)
          ,Fields.InvalidMessage_attorneylastname(1),Fields.InvalidMessage_attorneylastname(2)
          ,Fields.InvalidMessage_attorneyaddress1(1),Fields.InvalidMessage_attorneyaddress1(2),Fields.InvalidMessage_attorneyaddress1(3)
          ,Fields.InvalidMessage_attorneyaddress2(1),Fields.InvalidMessage_attorneyaddress2(2),Fields.InvalidMessage_attorneyaddress2(3)
          ,Fields.InvalidMessage_attorneyaddresscity(1),Fields.InvalidMessage_attorneyaddresscity(2)
          ,Fields.InvalidMessage_attorneyaddressstate(1),Fields.InvalidMessage_attorneyaddressstate(2)
          ,Fields.InvalidMessage_attorneyaddresszipcode(1),Fields.InvalidMessage_attorneyaddresszipcode(2)
          ,Fields.InvalidMessage_attorneyphone(1),Fields.InvalidMessage_attorneyphone(2)
          ,Fields.InvalidMessage_cln_fname(1),Fields.InvalidMessage_cln_fname(2)
          ,Fields.InvalidMessage_cln_mname(1),Fields.InvalidMessage_cln_mname(2)
          ,Fields.InvalidMessage_cln_lname(1),Fields.InvalidMessage_cln_lname(2)
          ,Fields.InvalidMessage_cln_suffix(1),Fields.InvalidMessage_cln_suffix(2)
          ,Fields.InvalidMessage_cln_fname2(1),Fields.InvalidMessage_cln_fname2(2)
          ,Fields.InvalidMessage_cln_mname2(1),Fields.InvalidMessage_cln_mname2(2)
          ,Fields.InvalidMessage_cln_lname2(1),Fields.InvalidMessage_cln_lname2(2)
          ,Fields.InvalidMessage_cln_suffix2(1),Fields.InvalidMessage_cln_suffix2(2)
          ,Fields.InvalidMessage_cname(1),Fields.InvalidMessage_cname(2),Fields.InvalidMessage_cname(3)
          ,Fields.InvalidMessage_predir(1),Fields.InvalidMessage_predir(2)
          ,Fields.InvalidMessage_prim_name(1),Fields.InvalidMessage_prim_name(2)
          ,Fields.InvalidMessage_addr_suffix(1),Fields.InvalidMessage_addr_suffix(2)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_unit_desig(1)
          ,Fields.InvalidMessage_sec_range(1),Fields.InvalidMessage_sec_range(2)
          ,Fields.InvalidMessage_p_city_name(1),Fields.InvalidMessage_p_city_name(2)
          ,Fields.InvalidMessage_v_city_name(1),Fields.InvalidMessage_v_city_name(2)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2)
          ,Fields.InvalidMessage_cart(1),Fields.InvalidMessage_cart(2)
          ,Fields.InvalidMessage_cr_sort_sz(1),Fields.InvalidMessage_cr_sort_sz(2)
          ,Fields.InvalidMessage_lot(1),Fields.InvalidMessage_lot(2)
          ,Fields.InvalidMessage_lot_order(1),Fields.InvalidMessage_lot_order(2)
          ,Fields.InvalidMessage_dbpc(1),Fields.InvalidMessage_dbpc(2)
          ,Fields.InvalidMessage_chk_digit(1),Fields.InvalidMessage_chk_digit(2)
          ,Fields.InvalidMessage_rec_type(1),Fields.InvalidMessage_rec_type(2)
          ,Fields.InvalidMessage_fips_county(1),Fields.InvalidMessage_fips_county(2)
          ,Fields.InvalidMessage_geo_lat(1),Fields.InvalidMessage_geo_lat(2)
          ,Fields.InvalidMessage_geo_long(1),Fields.InvalidMessage_geo_long(2)
          ,Fields.InvalidMessage_msa(1),Fields.InvalidMessage_msa(2)
          ,Fields.InvalidMessage_geo_blk(1),Fields.InvalidMessage_geo_blk(2)
          ,Fields.InvalidMessage_geo_match(1),Fields.InvalidMessage_geo_match(2)
          ,Fields.InvalidMessage_err_stat(1),Fields.InvalidMessage_err_stat(2)
          ,Fields.InvalidMessage_rawaid(1),Fields.InvalidMessage_rawaid(2)
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
          ,le.name_score_ALLOW_ErrorCount,le.name_score_LENGTH_ErrorCount
          ,le.filedate_ALLOW_ErrorCount,le.filedate_LENGTH_ErrorCount
          ,le.dod_ALLOW_ErrorCount,le.dod_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.masterid_ALLOW_ErrorCount
          ,le.debtorfirstname_ALLOW_ErrorCount,le.debtorfirstname_LENGTH_ErrorCount
          ,le.debtorlastname_ALLOW_ErrorCount,le.debtorlastname_LENGTH_ErrorCount
          ,le.debtoraddress1_CAPS_ErrorCount,le.debtoraddress1_ALLOW_ErrorCount,le.debtoraddress1_LENGTH_ErrorCount
          ,le.debtoraddress2_CAPS_ErrorCount,le.debtoraddress2_ALLOW_ErrorCount,le.debtoraddress2_LENGTH_ErrorCount
          ,le.debtoraddresscity_ALLOW_ErrorCount,le.debtoraddresscity_LENGTH_ErrorCount
          ,le.debtoraddressstate_ALLOW_ErrorCount,le.debtoraddressstate_LENGTH_ErrorCount
          ,le.debtoraddresszipcode_ALLOW_ErrorCount,le.debtoraddresszipcode_LENGTH_ErrorCount
          ,le.dateofdeath_ALLOW_ErrorCount,le.dateofdeath_LENGTH_ErrorCount
          ,le.dateofbirth_ALLOW_ErrorCount,le.dateofbirth_LENGTH_ErrorCount
          ,le.casenumber_ALLOW_ErrorCount,le.casenumber_LENGTH_ErrorCount
          ,le.filingdate_ALLOW_ErrorCount,le.filingdate_LENGTH_ErrorCount
          ,le.lastdatetofileclaim_ALLOW_ErrorCount,le.lastdatetofileclaim_LENGTH_ErrorCount
          ,le.publicationstartdate_ALLOW_ErrorCount,le.publicationstartdate_LENGTH_ErrorCount
          ,le.executorfirstname_ALLOW_ErrorCount,le.executorfirstname_LENGTH_ErrorCount
          ,le.executorlastname_ALLOW_ErrorCount,le.executorlastname_LENGTH_ErrorCount
          ,le.executoraddress1_CAPS_ErrorCount,le.executoraddress1_ALLOW_ErrorCount,le.executoraddress1_LENGTH_ErrorCount
          ,le.executoraddress2_CAPS_ErrorCount,le.executoraddress2_ALLOW_ErrorCount,le.executoraddress2_LENGTH_ErrorCount
          ,le.executoraddresscity_ALLOW_ErrorCount,le.executoraddresscity_LENGTH_ErrorCount
          ,le.executoraddressstate_ALLOW_ErrorCount,le.executoraddressstate_LENGTH_ErrorCount
          ,le.executoraddresszipcode_ALLOW_ErrorCount,le.executoraddresszipcode_LENGTH_ErrorCount
          ,le.executorphone_ALLOW_ErrorCount,le.executorphone_LENGTH_ErrorCount
          ,le.attorneyfirstname_ALLOW_ErrorCount,le.attorneyfirstname_LENGTH_ErrorCount
          ,le.attorneylastname_ALLOW_ErrorCount,le.attorneylastname_LENGTH_ErrorCount
          ,le.attorneyaddress1_CAPS_ErrorCount,le.attorneyaddress1_ALLOW_ErrorCount,le.attorneyaddress1_LENGTH_ErrorCount
          ,le.attorneyaddress2_CAPS_ErrorCount,le.attorneyaddress2_ALLOW_ErrorCount,le.attorneyaddress2_LENGTH_ErrorCount
          ,le.attorneyaddresscity_ALLOW_ErrorCount,le.attorneyaddresscity_LENGTH_ErrorCount
          ,le.attorneyaddressstate_ALLOW_ErrorCount,le.attorneyaddressstate_LENGTH_ErrorCount
          ,le.attorneyaddresszipcode_ALLOW_ErrorCount,le.attorneyaddresszipcode_LENGTH_ErrorCount
          ,le.attorneyphone_ALLOW_ErrorCount,le.attorneyphone_LENGTH_ErrorCount
          ,le.cln_fname_ALLOW_ErrorCount,le.cln_fname_LENGTH_ErrorCount
          ,le.cln_mname_ALLOW_ErrorCount,le.cln_mname_LENGTH_ErrorCount
          ,le.cln_lname_ALLOW_ErrorCount,le.cln_lname_LENGTH_ErrorCount
          ,le.cln_suffix_ALLOW_ErrorCount,le.cln_suffix_LENGTH_ErrorCount
          ,le.cln_fname2_ALLOW_ErrorCount,le.cln_fname2_LENGTH_ErrorCount
          ,le.cln_mname2_ALLOW_ErrorCount,le.cln_mname2_LENGTH_ErrorCount
          ,le.cln_lname2_ALLOW_ErrorCount,le.cln_lname2_LENGTH_ErrorCount
          ,le.cln_suffix2_ALLOW_ErrorCount,le.cln_suffix2_LENGTH_ErrorCount
          ,le.cname_CAPS_ErrorCount,le.cname_ALLOW_ErrorCount,le.cname_LENGTH_ErrorCount
          ,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTH_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTH_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount
          ,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount
          ,le.dbpc_ALLOW_ErrorCount,le.dbpc_LENGTH_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount,le.fips_county_LENGTH_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount
          ,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTH_ErrorCount
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
          ,le.name_score_ALLOW_ErrorCount,le.name_score_LENGTH_ErrorCount
          ,le.filedate_ALLOW_ErrorCount,le.filedate_LENGTH_ErrorCount
          ,le.dod_ALLOW_ErrorCount,le.dod_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.masterid_ALLOW_ErrorCount
          ,le.debtorfirstname_ALLOW_ErrorCount,le.debtorfirstname_LENGTH_ErrorCount
          ,le.debtorlastname_ALLOW_ErrorCount,le.debtorlastname_LENGTH_ErrorCount
          ,le.debtoraddress1_CAPS_ErrorCount,le.debtoraddress1_ALLOW_ErrorCount,le.debtoraddress1_LENGTH_ErrorCount
          ,le.debtoraddress2_CAPS_ErrorCount,le.debtoraddress2_ALLOW_ErrorCount,le.debtoraddress2_LENGTH_ErrorCount
          ,le.debtoraddresscity_ALLOW_ErrorCount,le.debtoraddresscity_LENGTH_ErrorCount
          ,le.debtoraddressstate_ALLOW_ErrorCount,le.debtoraddressstate_LENGTH_ErrorCount
          ,le.debtoraddresszipcode_ALLOW_ErrorCount,le.debtoraddresszipcode_LENGTH_ErrorCount
          ,le.dateofdeath_ALLOW_ErrorCount,le.dateofdeath_LENGTH_ErrorCount
          ,le.dateofbirth_ALLOW_ErrorCount,le.dateofbirth_LENGTH_ErrorCount
          ,le.casenumber_ALLOW_ErrorCount,le.casenumber_LENGTH_ErrorCount
          ,le.filingdate_ALLOW_ErrorCount,le.filingdate_LENGTH_ErrorCount
          ,le.lastdatetofileclaim_ALLOW_ErrorCount,le.lastdatetofileclaim_LENGTH_ErrorCount
          ,le.publicationstartdate_ALLOW_ErrorCount,le.publicationstartdate_LENGTH_ErrorCount
          ,le.executorfirstname_ALLOW_ErrorCount,le.executorfirstname_LENGTH_ErrorCount
          ,le.executorlastname_ALLOW_ErrorCount,le.executorlastname_LENGTH_ErrorCount
          ,le.executoraddress1_CAPS_ErrorCount,le.executoraddress1_ALLOW_ErrorCount,le.executoraddress1_LENGTH_ErrorCount
          ,le.executoraddress2_CAPS_ErrorCount,le.executoraddress2_ALLOW_ErrorCount,le.executoraddress2_LENGTH_ErrorCount
          ,le.executoraddresscity_ALLOW_ErrorCount,le.executoraddresscity_LENGTH_ErrorCount
          ,le.executoraddressstate_ALLOW_ErrorCount,le.executoraddressstate_LENGTH_ErrorCount
          ,le.executoraddresszipcode_ALLOW_ErrorCount,le.executoraddresszipcode_LENGTH_ErrorCount
          ,le.executorphone_ALLOW_ErrorCount,le.executorphone_LENGTH_ErrorCount
          ,le.attorneyfirstname_ALLOW_ErrorCount,le.attorneyfirstname_LENGTH_ErrorCount
          ,le.attorneylastname_ALLOW_ErrorCount,le.attorneylastname_LENGTH_ErrorCount
          ,le.attorneyaddress1_CAPS_ErrorCount,le.attorneyaddress1_ALLOW_ErrorCount,le.attorneyaddress1_LENGTH_ErrorCount
          ,le.attorneyaddress2_CAPS_ErrorCount,le.attorneyaddress2_ALLOW_ErrorCount,le.attorneyaddress2_LENGTH_ErrorCount
          ,le.attorneyaddresscity_ALLOW_ErrorCount,le.attorneyaddresscity_LENGTH_ErrorCount
          ,le.attorneyaddressstate_ALLOW_ErrorCount,le.attorneyaddressstate_LENGTH_ErrorCount
          ,le.attorneyaddresszipcode_ALLOW_ErrorCount,le.attorneyaddresszipcode_LENGTH_ErrorCount
          ,le.attorneyphone_ALLOW_ErrorCount,le.attorneyphone_LENGTH_ErrorCount
          ,le.cln_fname_ALLOW_ErrorCount,le.cln_fname_LENGTH_ErrorCount
          ,le.cln_mname_ALLOW_ErrorCount,le.cln_mname_LENGTH_ErrorCount
          ,le.cln_lname_ALLOW_ErrorCount,le.cln_lname_LENGTH_ErrorCount
          ,le.cln_suffix_ALLOW_ErrorCount,le.cln_suffix_LENGTH_ErrorCount
          ,le.cln_fname2_ALLOW_ErrorCount,le.cln_fname2_LENGTH_ErrorCount
          ,le.cln_mname2_ALLOW_ErrorCount,le.cln_mname2_LENGTH_ErrorCount
          ,le.cln_lname2_ALLOW_ErrorCount,le.cln_lname2_LENGTH_ErrorCount
          ,le.cln_suffix2_ALLOW_ErrorCount,le.cln_suffix2_LENGTH_ErrorCount
          ,le.cname_CAPS_ErrorCount,le.cname_ALLOW_ErrorCount,le.cname_LENGTH_ErrorCount
          ,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTH_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTH_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount
          ,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount
          ,le.dbpc_ALLOW_ErrorCount,le.dbpc_LENGTH_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount,le.fips_county_LENGTH_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount
          ,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);

    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_OKC_Probate_Profile));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filedate:' + getFieldTypeText(h.filedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dod:' + getFieldTypeText(h.dod) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'masterid:' + getFieldTypeText(h.masterid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtorfirstname:' + getFieldTypeText(h.debtorfirstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtorlastname:' + getFieldTypeText(h.debtorlastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtoraddress1:' + getFieldTypeText(h.debtoraddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtoraddress2:' + getFieldTypeText(h.debtoraddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtoraddresscity:' + getFieldTypeText(h.debtoraddresscity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtoraddressstate:' + getFieldTypeText(h.debtoraddressstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtoraddresszipcode:' + getFieldTypeText(h.debtoraddresszipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateofdeath:' + getFieldTypeText(h.dateofdeath) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateofbirth:' + getFieldTypeText(h.dateofbirth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'isprobatelocated:' + getFieldTypeText(h.isprobatelocated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casenumber:' + getFieldTypeText(h.casenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filingdate:' + getFieldTypeText(h.filingdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastdatetofileclaim:' + getFieldTypeText(h.lastdatetofileclaim) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'issubjecttocreditorsclaim:' + getFieldTypeText(h.issubjecttocreditorsclaim) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicationstartdate:' + getFieldTypeText(h.publicationstartdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'isestateopen:' + getFieldTypeText(h.isestateopen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executorfirstname:' + getFieldTypeText(h.executorfirstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executorlastname:' + getFieldTypeText(h.executorlastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executoraddress1:' + getFieldTypeText(h.executoraddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executoraddress2:' + getFieldTypeText(h.executoraddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executoraddresscity:' + getFieldTypeText(h.executoraddresscity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executoraddressstate:' + getFieldTypeText(h.executoraddressstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executoraddresszipcode:' + getFieldTypeText(h.executoraddresszipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executorphone:' + getFieldTypeText(h.executorphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneyfirstname:' + getFieldTypeText(h.attorneyfirstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneylastname:' + getFieldTypeText(h.attorneylastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firm:' + getFieldTypeText(h.firm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneyaddress1:' + getFieldTypeText(h.attorneyaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneyaddress2:' + getFieldTypeText(h.attorneyaddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneyaddresscity:' + getFieldTypeText(h.attorneyaddresscity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneyaddressstate:' + getFieldTypeText(h.attorneyaddressstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneyaddresszipcode:' + getFieldTypeText(h.attorneyaddresszipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneyphone:' + getFieldTypeText(h.attorneyphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneyemail:' + getFieldTypeText(h.attorneyemail) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'documenttypes:' + getFieldTypeText(h.documenttypes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corr_dateofdeath:' + getFieldTypeText(h.corr_dateofdeath) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pdid:' + getFieldTypeText(h.pdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pfrd_address_ind:' + getFieldTypeText(h.pfrd_address_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nid:' + getFieldTypeText(h.nid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_title:' + getFieldTypeText(h.cln_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_fname:' + getFieldTypeText(h.cln_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_mname:' + getFieldTypeText(h.cln_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_lname:' + getFieldTypeText(h.cln_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_suffix:' + getFieldTypeText(h.cln_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_title2:' + getFieldTypeText(h.cln_title2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_fname2:' + getFieldTypeText(h.cln_fname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_mname2:' + getFieldTypeText(h.cln_mname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_lname2:' + getFieldTypeText(h.cln_lname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_suffix2:' + getFieldTypeText(h.cln_suffix2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'persistent_record_id:' + getFieldTypeText(h.persistent_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cname:' + getFieldTypeText(h.cname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanaid:' + getFieldTypeText(h.cleanaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresstype:' + getFieldTypeText(h.addresstype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawaid:' + getFieldTypeText(h.rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_name_score_cnt
          ,le.populated_filedate_cnt
          ,le.populated_dod_cnt
          ,le.populated_dob_cnt
          ,le.populated_masterid_cnt
          ,le.populated_debtorfirstname_cnt
          ,le.populated_debtorlastname_cnt
          ,le.populated_debtoraddress1_cnt
          ,le.populated_debtoraddress2_cnt
          ,le.populated_debtoraddresscity_cnt
          ,le.populated_debtoraddressstate_cnt
          ,le.populated_debtoraddresszipcode_cnt
          ,le.populated_dateofdeath_cnt
          ,le.populated_dateofbirth_cnt
          ,le.populated_isprobatelocated_cnt
          ,le.populated_casenumber_cnt
          ,le.populated_filingdate_cnt
          ,le.populated_lastdatetofileclaim_cnt
          ,le.populated_issubjecttocreditorsclaim_cnt
          ,le.populated_publicationstartdate_cnt
          ,le.populated_isestateopen_cnt
          ,le.populated_executorfirstname_cnt
          ,le.populated_executorlastname_cnt
          ,le.populated_executoraddress1_cnt
          ,le.populated_executoraddress2_cnt
          ,le.populated_executoraddresscity_cnt
          ,le.populated_executoraddressstate_cnt
          ,le.populated_executoraddresszipcode_cnt
          ,le.populated_executorphone_cnt
          ,le.populated_attorneyfirstname_cnt
          ,le.populated_attorneylastname_cnt
          ,le.populated_firm_cnt
          ,le.populated_attorneyaddress1_cnt
          ,le.populated_attorneyaddress2_cnt
          ,le.populated_attorneyaddresscity_cnt
          ,le.populated_attorneyaddressstate_cnt
          ,le.populated_attorneyaddresszipcode_cnt
          ,le.populated_attorneyphone_cnt
          ,le.populated_attorneyemail_cnt
          ,le.populated_documenttypes_cnt
          ,le.populated_corr_dateofdeath_cnt
          ,le.populated_pdid_cnt
          ,le.populated_pfrd_address_ind_cnt
          ,le.populated_nid_cnt
          ,le.populated_cln_title_cnt
          ,le.populated_cln_fname_cnt
          ,le.populated_cln_mname_cnt
          ,le.populated_cln_lname_cnt
          ,le.populated_cln_suffix_cnt
          ,le.populated_cln_title2_cnt
          ,le.populated_cln_fname2_cnt
          ,le.populated_cln_mname2_cnt
          ,le.populated_cln_lname2_cnt
          ,le.populated_cln_suffix2_cnt
          ,le.populated_persistent_record_id_cnt
          ,le.populated_cname_cnt
          ,le.populated_cleanaid_cnt
          ,le.populated_addresstype_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_rawaid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_name_score_pcnt
          ,le.populated_filedate_pcnt
          ,le.populated_dod_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_masterid_pcnt
          ,le.populated_debtorfirstname_pcnt
          ,le.populated_debtorlastname_pcnt
          ,le.populated_debtoraddress1_pcnt
          ,le.populated_debtoraddress2_pcnt
          ,le.populated_debtoraddresscity_pcnt
          ,le.populated_debtoraddressstate_pcnt
          ,le.populated_debtoraddresszipcode_pcnt
          ,le.populated_dateofdeath_pcnt
          ,le.populated_dateofbirth_pcnt
          ,le.populated_isprobatelocated_pcnt
          ,le.populated_casenumber_pcnt
          ,le.populated_filingdate_pcnt
          ,le.populated_lastdatetofileclaim_pcnt
          ,le.populated_issubjecttocreditorsclaim_pcnt
          ,le.populated_publicationstartdate_pcnt
          ,le.populated_isestateopen_pcnt
          ,le.populated_executorfirstname_pcnt
          ,le.populated_executorlastname_pcnt
          ,le.populated_executoraddress1_pcnt
          ,le.populated_executoraddress2_pcnt
          ,le.populated_executoraddresscity_pcnt
          ,le.populated_executoraddressstate_pcnt
          ,le.populated_executoraddresszipcode_pcnt
          ,le.populated_executorphone_pcnt
          ,le.populated_attorneyfirstname_pcnt
          ,le.populated_attorneylastname_pcnt
          ,le.populated_firm_pcnt
          ,le.populated_attorneyaddress1_pcnt
          ,le.populated_attorneyaddress2_pcnt
          ,le.populated_attorneyaddresscity_pcnt
          ,le.populated_attorneyaddressstate_pcnt
          ,le.populated_attorneyaddresszipcode_pcnt
          ,le.populated_attorneyphone_pcnt
          ,le.populated_attorneyemail_pcnt
          ,le.populated_documenttypes_pcnt
          ,le.populated_corr_dateofdeath_pcnt
          ,le.populated_pdid_pcnt
          ,le.populated_pfrd_address_ind_pcnt
          ,le.populated_nid_pcnt
          ,le.populated_cln_title_pcnt
          ,le.populated_cln_fname_pcnt
          ,le.populated_cln_mname_pcnt
          ,le.populated_cln_lname_pcnt
          ,le.populated_cln_suffix_pcnt
          ,le.populated_cln_title2_pcnt
          ,le.populated_cln_fname2_pcnt
          ,le.populated_cln_mname2_pcnt
          ,le.populated_cln_lname2_pcnt
          ,le.populated_cln_suffix2_pcnt
          ,le.populated_persistent_record_id_pcnt
          ,le.populated_cname_pcnt
          ,le.populated_cleanaid_pcnt
          ,le.populated_addresstype_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_rawaid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,85,xNormHygieneStats(LEFT,COUNTER,'POP'));

  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));

    mod_Delta := Delta(prevDS, PROJECT(h, Layout_OKC_Probate_Profile));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),85,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(Layout_OKC_Probate_Profile) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_OKC_Probate, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));

  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);

  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));

  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
