EXPORT MAC_CreateBest(ih, specs='', RoxieService=FALSE) := FUNCTIONMACRO
IMPORT SALT311;
IMPORT Watchdog_Best; // Import modules for FUZZY attribute definitions
IMPORT Watchdog_Best; // Import modules for BESTTYPE attribute definitions
M := MODULE
  SHARED ih_bm := PROJECT(ih,Watchdog_best.layout_Hdr);

#IF (#TEXT(specs) <> '' )
  SHARED s := specs;
#ELSEIF (RoxieService)
  SHARED s := PROJECT(Watchdog_best.Specificities(ih_bm).specificities,Watchdog_best.Layout_Specificities.R)[1];
#ELSE
  SHARED s := Watchdog_best.Specificities(ih).specificities[1];
#END

#IF (RoxieService)
  SHARED h_bm := Watchdog_best.Specificities(ih_bm).input_file_np;
#ELSE
  h00 := Watchdog_best.BasicMatch(ih).input_file;
  SHARED h_bm := h00;
#END


  // Create those fields with BestType: BestTitle
  // First step is to get all of the data slimmed and row-reduced
  EXPORT BestTitle_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,title,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,title,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(BestTitle_tab_((title NOT IN SET(s.nulls_title,title) AND title <> (TYPEOF(title))''),Watchdog_Best.fn_valid_name_title(TRIM((SALT311.StrType)title),src)),{did,src,data_permits,title,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestTitle_tab_title := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( BestTitle_tab_title,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT BestTitle_method_title := cmn;



  // Create those fields with BestType: BestSuffix
  // First step is to get all of the data slimmed and row-reduced
  EXPORT BestSuffix_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,name_suffix,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,name_suffix,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(BestSuffix_tab_((name_suffix NOT IN SET(s.nulls_name_suffix,name_suffix) AND name_suffix <> (TYPEOF(name_suffix))''),Watchdog_Best.fn_valid_name_suffix(TRIM((SALT311.StrType)name_suffix),src)),{did,src,data_permits,name_suffix,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestSuffix_tab_name_suffix := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( BestSuffix_tab_name_suffix,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT BestSuffix_method_name_suffix := cmn;



  // Create those fields with BestType: BestSSN
  // First step is to get all of the data slimmed and row-reduced
  EXPORT BestSSN_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,ssn,valid_ssn,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,ssn,valid_ssn,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(BestSSN_tab_(~((ssn  IN SET(s.nulls_ssn,ssn) OR ssn = (TYPEOF(ssn))'') AND (valid_ssn  IN SET(s.nulls_valid_ssn,valid_ssn) OR valid_ssn = (TYPEOF(valid_ssn))'')),Watchdog_Best.fn_valid_ssn(TRIM((SALT311.StrType)ssn) + '|' + TRIM((SALT311.StrType)valid_ssn),src)),{did,src,data_permits,ssn,valid_ssn,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestSSN_tab_ssnum := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Adjust scores for ssnum using defined fuzzy logic 
  Fuzzy_layout := RECORD
    BestSSN_tab_ssnum.did;
    BestSSN_tab_ssnum.ssn;
    BestSSN_tab_ssnum.valid_ssn;
    UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
    UNSIGNED Row_Cnt;
    UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
  END;
  Fuzzy_layout NoteSupport(BestSSN_tab_ssnum le,BestSSN_tab_ssnum ri) := TRANSFORM
    SELF.Row_Cnt := ri.Row_Cnt;
    SELF.Orig_Row_Cnt := le.Row_Cnt;
    SELF := le;
  END;
  Supports := JOIN(BestSSN_tab_ssnum,BestSSN_tab_ssnum, LEFT.did = RIGHT.did  AND (( (LEFT.ssn = (TYPEOF(LEFT.ssn))'' OR RIGHT.ssn = (TYPEOF(RIGHT.ssn))'' OR LEFT.ssn = RIGHT.ssn ) AND (LEFT.valid_ssn = (TYPEOF(LEFT.valid_ssn))'' OR RIGHT.valid_ssn = (TYPEOF(RIGHT.valid_ssn))'' OR LEFT.valid_ssn = RIGHT.valid_ssn ) )),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestSSN_fuzz_ssnum := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( BestSSN_fuzz_ssnum,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT BestSSN_method_ssnum := cmn;



  // Create those fields with BestType: SecondBestSSN
  // First step is to get all of the data slimmed and row-reduced
  EXPORT SecondBestSSN_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,ssn,valid_ssn,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,ssn,valid_ssn,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(SecondBestSSN_tab_(~((ssn  IN SET(s.nulls_ssn,ssn) OR ssn = (TYPEOF(ssn))'') AND (valid_ssn  IN SET(s.nulls_valid_ssn,valid_ssn) OR valid_ssn = (TYPEOF(valid_ssn))'')),Watchdog_Best.fn_ok_ssn(TRIM((SALT311.StrType)ssn) + '|' + TRIM((SALT311.StrType)valid_ssn),src)),{did,src,data_permits,ssn,valid_ssn,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT SecondBestSSN_tab_ssnum := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Adjust scores for ssnum using defined fuzzy logic 
  Fuzzy_layout := RECORD
    SecondBestSSN_tab_ssnum.did;
    SecondBestSSN_tab_ssnum.ssn;
    SecondBestSSN_tab_ssnum.valid_ssn;
    UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
    UNSIGNED Row_Cnt;
    UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
  END;
  Fuzzy_layout NoteSupport(SecondBestSSN_tab_ssnum le,SecondBestSSN_tab_ssnum ri) := TRANSFORM
    SELF.Row_Cnt := ri.Row_Cnt;
    SELF.Orig_Row_Cnt := le.Row_Cnt;
    SELF := le;
  END;
  Supports := JOIN(SecondBestSSN_tab_ssnum,SecondBestSSN_tab_ssnum, LEFT.did = RIGHT.did  AND (( (LEFT.ssn = (TYPEOF(LEFT.ssn))'' OR RIGHT.ssn = (TYPEOF(RIGHT.ssn))'' OR LEFT.ssn = RIGHT.ssn ) AND (LEFT.valid_ssn = (TYPEOF(LEFT.valid_ssn))'' OR RIGHT.valid_ssn = (TYPEOF(RIGHT.valid_ssn))'' OR LEFT.valid_ssn = RIGHT.valid_ssn ) )),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT SecondBestSSN_fuzz_ssnum := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( SecondBestSSN_fuzz_ssnum,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT SecondBestSSN_method_ssnum := cmn;



  // Create those fields with BestType: BestPhoneCurrentWithNpa
  // First step is to get all of the data slimmed and row-reduced
  EXPORT BestPhoneCurrentWithNpa_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,phone,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,phone,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(BestPhoneCurrentWithNpa_tab_((phone NOT IN SET(s.nulls_phone,phone) AND phone <> (TYPEOF(phone))''),Watchdog_Best.fn_valid_phone(TRIM((SALT311.StrType)phone),src)),{did,src,data_permits,phone,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestPhoneCurrentWithNpa_tab_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL);

  // Adjust scores for phone using defined fuzzy logic 
  Fuzzy_layout := RECORD
    BestPhoneCurrentWithNpa_tab_phone.did;
    BestPhoneCurrentWithNpa_tab_phone.phone;
    UNSIGNED Early_Date;
    UNSIGNED Late_Date;
    UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
    UNSIGNED Row_Cnt;
    UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
  END;
  Fuzzy_layout NoteSupport(BestPhoneCurrentWithNpa_tab_phone le,BestPhoneCurrentWithNpa_tab_phone ri) := TRANSFORM
    SELF.Row_Cnt := ri.Row_Cnt;
    SELF.Orig_Row_Cnt := le.Row_Cnt;
    SELF := le;
  END;
  Supports := JOIN(BestPhoneCurrentWithNpa_tab_phone,BestPhoneCurrentWithNpa_tab_phone, LEFT.did = RIGHT.did  AND ( LEFT.phone = (TYPEOF(LEFT.phone))'' OR RIGHT.phone = (TYPEOF(RIGHT.phone))'' OR LEFT.phone = RIGHT.phone  OR Watchdog_best.Config.WithinEditN(LEFT.phone,0,RIGHT.phone,0,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestPhoneCurrentWithNpa_fuzz_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);

  // Now actually find the best value
  EXPORT BestPhoneCurrentWithNpa_method_phone := DEDUP( SORT( BestPhoneCurrentWithNpa_fuzz_phone(Late_Date>0,Early_Date<99999999),did,-Late_Date,-Early_Date,-Row_Cnt,RECORD,LOCAL),did,LOCAL);



  // Create those fields with BestType: BestDOB
  // First step is to get all of the data slimmed and row-reduced
  EXPORT BestDOB_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,dob,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,dob,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(BestDOB_tab_((dob NOT IN SET(s.nulls_dob,dob) AND dob <> (TYPEOF(dob))''),Watchdog_Best.fn_valid_dob(TRIM((SALT311.StrType)dob),src)),{did,src,data_permits,dob,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestDOB_tab_dob := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( BestDOB_tab_dob,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT BestDOB_method_dob := cmn;



  // Create those fields with BestType: NoDayDOB
  // First step is to get all of the data slimmed and row-reduced
  EXPORT NoDayDOB_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,dob,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,dob,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(NoDayDOB_tab_((dob NOT IN SET(s.nulls_dob,dob) AND dob <> (TYPEOF(dob))''),Watchdog_Best.fn_dob_noday(TRIM((SALT311.StrType)dob),src)),{did,src,data_permits,dob,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT NoDayDOB_tab_dob := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( NoDayDOB_tab_dob,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT NoDayDOB_method_dob := cmn;



  // Create those fields with BestType: NoMonthDOB
  // First step is to get all of the data slimmed and row-reduced
  EXPORT NoMonthDOB_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,dob,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,dob,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(NoMonthDOB_tab_((dob NOT IN SET(s.nulls_dob,dob) AND dob <> (TYPEOF(dob))''),Watchdog_Best.fn_dob_nomonth(TRIM((SALT311.StrType)dob),src)),{did,src,data_permits,dob,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT NoMonthDOB_tab_dob := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( NoMonthDOB_tab_dob,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT NoMonthDOB_method_dob := cmn;



  // Create those fields with BestType: BestAddress
  // First step is to get all of the data slimmed and row-reduced
  EXPORT BestAddress_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(BestAddress_tab_(~((prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))'') AND (predir  IN SET(s.nulls_predir,predir) OR predir = (TYPEOF(predir))'') AND (prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))'') AND (suffix  IN SET(s.nulls_suffix,suffix) OR suffix = (TYPEOF(suffix))'') AND (postdir  IN SET(s.nulls_postdir,postdir) OR postdir = (TYPEOF(postdir))'') AND (unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR unit_desig = (TYPEOF(unit_desig))'') AND (sec_range  IN SET(s.nulls_sec_range,sec_range) OR sec_range = (TYPEOF(sec_range))'') AND (city_name  IN SET(s.nulls_city_name,city_name) OR city_name = (TYPEOF(city_name))'') AND (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))'') AND (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))'') AND (zip4  IN SET(s.nulls_zip4,zip4) OR zip4 = (TYPEOF(zip4))'') AND (tnt  IN SET(s.nulls_tnt,tnt) OR tnt = (TYPEOF(tnt))'') AND (rawaid  IN SET(s.nulls_rawaid,rawaid) OR rawaid = (TYPEOF(rawaid))'') AND (dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR dt_first_seen = (TYPEOF(dt_first_seen))'') AND (dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR dt_last_seen = (TYPEOF(dt_last_seen))'') AND (dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR dt_vendor_first_reported = (TYPEOF(dt_vendor_first_reported))'') AND (dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR dt_vendor_last_reported = (TYPEOF(dt_vendor_last_reported))'')),Watchdog_Best.fn_best_address(TRIM((SALT311.StrType)prim_range) + '|' + TRIM((SALT311.StrType)predir) + '|' + TRIM((SALT311.StrType)prim_name) + '|' + TRIM((SALT311.StrType)suffix) + '|' + TRIM((SALT311.StrType)postdir) + '|' + TRIM((SALT311.StrType)unit_desig) + '|' + TRIM((SALT311.StrType)sec_range) + '|' + TRIM((SALT311.StrType)city_name) + '|' + TRIM((SALT311.StrType)st) + '|' + TRIM((SALT311.StrType)zip) + '|' + TRIM((SALT311.StrType)zip4) + '|' + TRIM((SALT311.StrType)tnt) + '|' + TRIM((SALT311.StrType)rawaid) + '|' + TRIM((SALT311.StrType)dt_first_seen) + '|' + TRIM((SALT311.StrType)dt_last_seen) + '|' + TRIM((SALT311.StrType)dt_vendor_first_reported) + '|' + TRIM((SALT311.StrType)dt_vendor_last_reported),src)),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestAddress_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL);

  // Now actually find the best value
  EXPORT BestAddress_method_address := DEDUP( SORT( BestAddress_tab_address(Late_Date>0,Early_Date<99999999),did,-Late_Date,-Early_Date,-Row_Cnt,RECORD,LOCAL),did,LOCAL);



  // Create those fields with BestType: GongAddressBySeen
  // First step is to get all of the data slimmed and row-reduced
  EXPORT GongAddressBySeen_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(GongAddressBySeen_tab_(~((prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))'') AND (predir  IN SET(s.nulls_predir,predir) OR predir = (TYPEOF(predir))'') AND (prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))'') AND (suffix  IN SET(s.nulls_suffix,suffix) OR suffix = (TYPEOF(suffix))'') AND (postdir  IN SET(s.nulls_postdir,postdir) OR postdir = (TYPEOF(postdir))'') AND (unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR unit_desig = (TYPEOF(unit_desig))'') AND (sec_range  IN SET(s.nulls_sec_range,sec_range) OR sec_range = (TYPEOF(sec_range))'') AND (city_name  IN SET(s.nulls_city_name,city_name) OR city_name = (TYPEOF(city_name))'') AND (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))'') AND (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))'') AND (zip4  IN SET(s.nulls_zip4,zip4) OR zip4 = (TYPEOF(zip4))'') AND (tnt  IN SET(s.nulls_tnt,tnt) OR tnt = (TYPEOF(tnt))'') AND (rawaid  IN SET(s.nulls_rawaid,rawaid) OR rawaid = (TYPEOF(rawaid))'') AND (dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR dt_first_seen = (TYPEOF(dt_first_seen))'') AND (dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR dt_last_seen = (TYPEOF(dt_last_seen))'') AND (dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR dt_vendor_first_reported = (TYPEOF(dt_vendor_first_reported))'') AND (dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR dt_vendor_last_reported = (TYPEOF(dt_vendor_last_reported))'')),Watchdog_Best.fn_gong_address(TRIM((SALT311.StrType)prim_range) + '|' + TRIM((SALT311.StrType)predir) + '|' + TRIM((SALT311.StrType)prim_name) + '|' + TRIM((SALT311.StrType)suffix) + '|' + TRIM((SALT311.StrType)postdir) + '|' + TRIM((SALT311.StrType)unit_desig) + '|' + TRIM((SALT311.StrType)sec_range) + '|' + TRIM((SALT311.StrType)city_name) + '|' + TRIM((SALT311.StrType)st) + '|' + TRIM((SALT311.StrType)zip) + '|' + TRIM((SALT311.StrType)zip4) + '|' + TRIM((SALT311.StrType)tnt) + '|' + TRIM((SALT311.StrType)rawaid) + '|' + TRIM((SALT311.StrType)dt_first_seen) + '|' + TRIM((SALT311.StrType)dt_last_seen) + '|' + TRIM((SALT311.StrType)dt_vendor_first_reported) + '|' + TRIM((SALT311.StrType)dt_vendor_last_reported),src)),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT GongAddressBySeen_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL);

  // Now actually find the best value
  EXPORT GongAddressBySeen_method_address := DEDUP( SORT( GongAddressBySeen_tab_address(Late_Date>0,Early_Date<99999999),did,-Late_Date,-Early_Date,-Row_Cnt,RECORD,LOCAL),did,LOCAL);



  // Create those fields with BestType: BetterAddressBySeen
  // First step is to get all of the data slimmed and row-reduced
  EXPORT BetterAddressBySeen_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(BetterAddressBySeen_tab_(~((prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))'') AND (predir  IN SET(s.nulls_predir,predir) OR predir = (TYPEOF(predir))'') AND (prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))'') AND (suffix  IN SET(s.nulls_suffix,suffix) OR suffix = (TYPEOF(suffix))'') AND (postdir  IN SET(s.nulls_postdir,postdir) OR postdir = (TYPEOF(postdir))'') AND (unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR unit_desig = (TYPEOF(unit_desig))'') AND (sec_range  IN SET(s.nulls_sec_range,sec_range) OR sec_range = (TYPEOF(sec_range))'') AND (city_name  IN SET(s.nulls_city_name,city_name) OR city_name = (TYPEOF(city_name))'') AND (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))'') AND (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))'') AND (zip4  IN SET(s.nulls_zip4,zip4) OR zip4 = (TYPEOF(zip4))'') AND (tnt  IN SET(s.nulls_tnt,tnt) OR tnt = (TYPEOF(tnt))'') AND (rawaid  IN SET(s.nulls_rawaid,rawaid) OR rawaid = (TYPEOF(rawaid))'') AND (dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR dt_first_seen = (TYPEOF(dt_first_seen))'') AND (dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR dt_last_seen = (TYPEOF(dt_last_seen))'') AND (dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR dt_vendor_first_reported = (TYPEOF(dt_vendor_first_reported))'') AND (dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR dt_vendor_last_reported = (TYPEOF(dt_vendor_last_reported))'')),Watchdog_Best.fn_better_address(TRIM((SALT311.StrType)prim_range) + '|' + TRIM((SALT311.StrType)predir) + '|' + TRIM((SALT311.StrType)prim_name) + '|' + TRIM((SALT311.StrType)suffix) + '|' + TRIM((SALT311.StrType)postdir) + '|' + TRIM((SALT311.StrType)unit_desig) + '|' + TRIM((SALT311.StrType)sec_range) + '|' + TRIM((SALT311.StrType)city_name) + '|' + TRIM((SALT311.StrType)st) + '|' + TRIM((SALT311.StrType)zip) + '|' + TRIM((SALT311.StrType)zip4) + '|' + TRIM((SALT311.StrType)tnt) + '|' + TRIM((SALT311.StrType)rawaid) + '|' + TRIM((SALT311.StrType)dt_first_seen) + '|' + TRIM((SALT311.StrType)dt_last_seen) + '|' + TRIM((SALT311.StrType)dt_vendor_first_reported) + '|' + TRIM((SALT311.StrType)dt_vendor_last_reported),src)),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BetterAddressBySeen_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL);

  // Now actually find the best value
  EXPORT BetterAddressBySeen_method_address := DEDUP( SORT( BetterAddressBySeen_tab_address(Late_Date>0,Early_Date<99999999),did,-Late_Date,-Early_Date,-Row_Cnt,RECORD,LOCAL),did,LOCAL);



  // Create those fields with BestType: RecentAddressBySeen
  // First step is to get all of the data slimmed and row-reduced
  EXPORT RecentAddressBySeen_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(RecentAddressBySeen_tab_(~((prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))'') AND (predir  IN SET(s.nulls_predir,predir) OR predir = (TYPEOF(predir))'') AND (prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))'') AND (suffix  IN SET(s.nulls_suffix,suffix) OR suffix = (TYPEOF(suffix))'') AND (postdir  IN SET(s.nulls_postdir,postdir) OR postdir = (TYPEOF(postdir))'') AND (unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR unit_desig = (TYPEOF(unit_desig))'') AND (sec_range  IN SET(s.nulls_sec_range,sec_range) OR sec_range = (TYPEOF(sec_range))'') AND (city_name  IN SET(s.nulls_city_name,city_name) OR city_name = (TYPEOF(city_name))'') AND (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))'') AND (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))'') AND (zip4  IN SET(s.nulls_zip4,zip4) OR zip4 = (TYPEOF(zip4))'') AND (tnt  IN SET(s.nulls_tnt,tnt) OR tnt = (TYPEOF(tnt))'') AND (rawaid  IN SET(s.nulls_rawaid,rawaid) OR rawaid = (TYPEOF(rawaid))'') AND (dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR dt_first_seen = (TYPEOF(dt_first_seen))'') AND (dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR dt_last_seen = (TYPEOF(dt_last_seen))'') AND (dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR dt_vendor_first_reported = (TYPEOF(dt_vendor_first_reported))'') AND (dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR dt_vendor_last_reported = (TYPEOF(dt_vendor_last_reported))'')),Watchdog_Best.fn_valid_address(TRIM((SALT311.StrType)prim_range) + '|' + TRIM((SALT311.StrType)predir) + '|' + TRIM((SALT311.StrType)prim_name) + '|' + TRIM((SALT311.StrType)suffix) + '|' + TRIM((SALT311.StrType)postdir) + '|' + TRIM((SALT311.StrType)unit_desig) + '|' + TRIM((SALT311.StrType)sec_range) + '|' + TRIM((SALT311.StrType)city_name) + '|' + TRIM((SALT311.StrType)st) + '|' + TRIM((SALT311.StrType)zip) + '|' + TRIM((SALT311.StrType)zip4) + '|' + TRIM((SALT311.StrType)tnt) + '|' + TRIM((SALT311.StrType)rawaid) + '|' + TRIM((SALT311.StrType)dt_first_seen) + '|' + TRIM((SALT311.StrType)dt_last_seen) + '|' + TRIM((SALT311.StrType)dt_vendor_first_reported) + '|' + TRIM((SALT311.StrType)dt_vendor_last_reported),src)),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT RecentAddressBySeen_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL);

  // Now actually find the best value
  EXPORT RecentAddressBySeen_method_address := DEDUP( SORT( RecentAddressBySeen_tab_address(Late_Date>0,Early_Date<99999999),did,-Late_Date,-Early_Date,-Row_Cnt,RECORD,LOCAL),did,LOCAL);



  // Create those fields with BestType: BetterAddressByReported
  // First step is to get all of the data slimmed and row-reduced
  EXPORT BetterAddressByReported_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,UNSIGNED Early_Date := MIN(GROUP,IF(dt_vendor_last_reported=0,99999999,dt_vendor_last_reported)),UNSIGNED Late_Date := MAX(GROUP,dt_vendor_last_reported),UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(BetterAddressByReported_tab_(~((prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))'') AND (predir  IN SET(s.nulls_predir,predir) OR predir = (TYPEOF(predir))'') AND (prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))'') AND (suffix  IN SET(s.nulls_suffix,suffix) OR suffix = (TYPEOF(suffix))'') AND (postdir  IN SET(s.nulls_postdir,postdir) OR postdir = (TYPEOF(postdir))'') AND (unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR unit_desig = (TYPEOF(unit_desig))'') AND (sec_range  IN SET(s.nulls_sec_range,sec_range) OR sec_range = (TYPEOF(sec_range))'') AND (city_name  IN SET(s.nulls_city_name,city_name) OR city_name = (TYPEOF(city_name))'') AND (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))'') AND (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))'') AND (zip4  IN SET(s.nulls_zip4,zip4) OR zip4 = (TYPEOF(zip4))'') AND (tnt  IN SET(s.nulls_tnt,tnt) OR tnt = (TYPEOF(tnt))'') AND (rawaid  IN SET(s.nulls_rawaid,rawaid) OR rawaid = (TYPEOF(rawaid))'') AND (dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR dt_first_seen = (TYPEOF(dt_first_seen))'') AND (dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR dt_last_seen = (TYPEOF(dt_last_seen))'') AND (dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR dt_vendor_first_reported = (TYPEOF(dt_vendor_first_reported))'') AND (dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR dt_vendor_last_reported = (TYPEOF(dt_vendor_last_reported))'')),Watchdog_Best.fn_better_address2(TRIM((SALT311.StrType)prim_range) + '|' + TRIM((SALT311.StrType)predir) + '|' + TRIM((SALT311.StrType)prim_name) + '|' + TRIM((SALT311.StrType)suffix) + '|' + TRIM((SALT311.StrType)postdir) + '|' + TRIM((SALT311.StrType)unit_desig) + '|' + TRIM((SALT311.StrType)sec_range) + '|' + TRIM((SALT311.StrType)city_name) + '|' + TRIM((SALT311.StrType)st) + '|' + TRIM((SALT311.StrType)zip) + '|' + TRIM((SALT311.StrType)zip4) + '|' + TRIM((SALT311.StrType)tnt) + '|' + TRIM((SALT311.StrType)rawaid) + '|' + TRIM((SALT311.StrType)dt_first_seen) + '|' + TRIM((SALT311.StrType)dt_last_seen) + '|' + TRIM((SALT311.StrType)dt_vendor_first_reported) + '|' + TRIM((SALT311.StrType)dt_vendor_last_reported),src)),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BetterAddressByReported_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL);

  // Now actually find the best value
  EXPORT BetterAddressByReported_method_address := DEDUP( SORT( BetterAddressByReported_tab_address(Late_Date>0,Early_Date<99999999),did,-Late_Date,-Early_Date,-Row_Cnt,RECORD,LOCAL),did,LOCAL);



  // Create those fields with BestType: RecentAddressByReported
  // First step is to get all of the data slimmed and row-reduced
  EXPORT RecentAddressByReported_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,UNSIGNED Early_Date := MIN(GROUP,IF(dt_vendor_last_reported=0,99999999,dt_vendor_last_reported)),UNSIGNED Late_Date := MAX(GROUP,dt_vendor_last_reported),UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(RecentAddressByReported_tab_(~((prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))'') AND (predir  IN SET(s.nulls_predir,predir) OR predir = (TYPEOF(predir))'') AND (prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))'') AND (suffix  IN SET(s.nulls_suffix,suffix) OR suffix = (TYPEOF(suffix))'') AND (postdir  IN SET(s.nulls_postdir,postdir) OR postdir = (TYPEOF(postdir))'') AND (unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR unit_desig = (TYPEOF(unit_desig))'') AND (sec_range  IN SET(s.nulls_sec_range,sec_range) OR sec_range = (TYPEOF(sec_range))'') AND (city_name  IN SET(s.nulls_city_name,city_name) OR city_name = (TYPEOF(city_name))'') AND (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))'') AND (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))'') AND (zip4  IN SET(s.nulls_zip4,zip4) OR zip4 = (TYPEOF(zip4))'') AND (tnt  IN SET(s.nulls_tnt,tnt) OR tnt = (TYPEOF(tnt))'') AND (rawaid  IN SET(s.nulls_rawaid,rawaid) OR rawaid = (TYPEOF(rawaid))'') AND (dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR dt_first_seen = (TYPEOF(dt_first_seen))'') AND (dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR dt_last_seen = (TYPEOF(dt_last_seen))'') AND (dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR dt_vendor_first_reported = (TYPEOF(dt_vendor_first_reported))'') AND (dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR dt_vendor_last_reported = (TYPEOF(dt_vendor_last_reported))'')),Watchdog_Best.fn_valid_address2(TRIM((SALT311.StrType)prim_range) + '|' + TRIM((SALT311.StrType)predir) + '|' + TRIM((SALT311.StrType)prim_name) + '|' + TRIM((SALT311.StrType)suffix) + '|' + TRIM((SALT311.StrType)postdir) + '|' + TRIM((SALT311.StrType)unit_desig) + '|' + TRIM((SALT311.StrType)sec_range) + '|' + TRIM((SALT311.StrType)city_name) + '|' + TRIM((SALT311.StrType)st) + '|' + TRIM((SALT311.StrType)zip) + '|' + TRIM((SALT311.StrType)zip4) + '|' + TRIM((SALT311.StrType)tnt) + '|' + TRIM((SALT311.StrType)rawaid) + '|' + TRIM((SALT311.StrType)dt_first_seen) + '|' + TRIM((SALT311.StrType)dt_last_seen) + '|' + TRIM((SALT311.StrType)dt_vendor_first_reported) + '|' + TRIM((SALT311.StrType)dt_vendor_last_reported),src)),{did,src,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT RecentAddressByReported_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,Early_Date,Late_Date,LOCAL);

  // Now actually find the best value
  EXPORT RecentAddressByReported_method_address := DEDUP( SORT( RecentAddressByReported_tab_address(Late_Date>0,Early_Date<99999999),did,-Late_Date,-Early_Date,-Row_Cnt,RECORD,LOCAL),did,LOCAL);



  // Create those fields with BestType: CommonestAddress
  // First step is to get all of the data slimmed and row-reduced
  EXPORT CommonestAddress_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,UNSIGNED Row_Cnt := COUNT(GROUP)},did,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(CommonestAddress_tab_(~((prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))'') AND (predir  IN SET(s.nulls_predir,predir) OR predir = (TYPEOF(predir))'') AND (prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))'') AND (suffix  IN SET(s.nulls_suffix,suffix) OR suffix = (TYPEOF(suffix))'') AND (postdir  IN SET(s.nulls_postdir,postdir) OR postdir = (TYPEOF(postdir))'') AND (unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR unit_desig = (TYPEOF(unit_desig))'') AND (sec_range  IN SET(s.nulls_sec_range,sec_range) OR sec_range = (TYPEOF(sec_range))'') AND (city_name  IN SET(s.nulls_city_name,city_name) OR city_name = (TYPEOF(city_name))'') AND (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))'') AND (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))'') AND (zip4  IN SET(s.nulls_zip4,zip4) OR zip4 = (TYPEOF(zip4))'') AND (tnt  IN SET(s.nulls_tnt,tnt) OR tnt = (TYPEOF(tnt))'') AND (rawaid  IN SET(s.nulls_rawaid,rawaid) OR rawaid = (TYPEOF(rawaid))'') AND (dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR dt_first_seen = (TYPEOF(dt_first_seen))'') AND (dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR dt_last_seen = (TYPEOF(dt_last_seen))'') AND (dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR dt_vendor_first_reported = (TYPEOF(dt_vendor_first_reported))'') AND (dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR dt_vendor_last_reported = (TYPEOF(dt_vendor_last_reported))''))),{did,data_permits,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,rawaid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT CommonestAddress_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( CommonestAddress_tab_address,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT CommonestAddress_method_address := cmn;



  // Create those fields with BestType: BestFirstName
  // First step is to get all of the data slimmed and row-reduced
  EXPORT BestFirstName_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,fname,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,fname,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(BestFirstName_tab_((fname NOT IN SET(s.nulls_fname,fname) AND fname <> (TYPEOF(fname))''),Watchdog_Best.fn_valid_fname_strict(TRIM((SALT311.StrType)fname),src)),{did,src,data_permits,fname,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestFirstName_tab_fname := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Adjust scores for fname using defined fuzzy logic 
  Fuzzy_layout := RECORD
    BestFirstName_tab_fname.did;
    BestFirstName_tab_fname.fname;
    UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
    UNSIGNED Row_Cnt;
    UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
  END;
  Fuzzy_layout NoteSupport(BestFirstName_tab_fname le,BestFirstName_tab_fname ri) := TRANSFORM
    SELF.Row_Cnt := ri.Row_Cnt;
    SELF.Orig_Row_Cnt := le.Row_Cnt;
    SELF := le;
  END;
  Supports := JOIN(BestFirstName_tab_fname,BestFirstName_tab_fname, LEFT.did = RIGHT.did  AND ( (LEFT.fname[1..LENGTH(TRIM(RIGHT.fname))] = RIGHT.fname OR RIGHT.fname[1..LENGTH(TRIM(LEFT.fname))] = LEFT.fname ) OR Watchdog_best.Config.WithinEditN(LEFT.fname,0,RIGHT.fname,0,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestFirstName_fuzz_fname := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( BestFirstName_fuzz_fname,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT BestFirstName_method_fname := cmn;



  // Create those fields with BestType: CommonFirstName
  // First step is to get all of the data slimmed and row-reduced
  EXPORT CommonFirstName_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,fname,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,fname,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(CommonFirstName_tab_((fname NOT IN SET(s.nulls_fname,fname) AND fname <> (TYPEOF(fname))''),Watchdog_Best.fn_valid_fname(TRIM((SALT311.StrType)fname),src)),{did,src,data_permits,fname,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT CommonFirstName_tab_fname := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Adjust scores for fname using defined fuzzy logic 
  Fuzzy_layout := RECORD
    CommonFirstName_tab_fname.did;
    CommonFirstName_tab_fname.fname;
    UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
    UNSIGNED Row_Cnt;
    UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
  END;
  Fuzzy_layout NoteSupport(CommonFirstName_tab_fname le,CommonFirstName_tab_fname ri) := TRANSFORM
    SELF.Row_Cnt := ri.Row_Cnt;
    SELF.Orig_Row_Cnt := le.Row_Cnt;
    SELF := le;
  END;
  Supports := JOIN(CommonFirstName_tab_fname,CommonFirstName_tab_fname, LEFT.did = RIGHT.did  AND ( (LEFT.fname[1..LENGTH(TRIM(RIGHT.fname))] = RIGHT.fname OR RIGHT.fname[1..LENGTH(TRIM(LEFT.fname))] = LEFT.fname ) OR Watchdog_best.Config.WithinEditN(LEFT.fname,0,RIGHT.fname,0,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT CommonFirstName_fuzz_fname := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( CommonFirstName_fuzz_fname,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT CommonFirstName_method_fname := cmn;



  // Create those fields with BestType: BestMiddleName
  // First step is to get all of the data slimmed and row-reduced
  EXPORT BestMiddleName_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,mname,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,mname,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(BestMiddleName_tab_((mname NOT IN SET(s.nulls_mname,mname) AND mname <> (TYPEOF(mname))''),Watchdog_Best.fn_valid_mname_strict(TRIM((SALT311.StrType)mname),src)),{did,src,data_permits,mname,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestMiddleName_tab_mname := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Adjust scores for mname using defined fuzzy logic 
  Fuzzy_layout := RECORD
    BestMiddleName_tab_mname.did;
    BestMiddleName_tab_mname.mname;
    UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
    UNSIGNED Row_Cnt;
    UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
  END;
  Fuzzy_layout NoteSupport(BestMiddleName_tab_mname le,BestMiddleName_tab_mname ri) := TRANSFORM
    SELF.Row_Cnt := ri.Row_Cnt;
    SELF.Orig_Row_Cnt := le.Row_Cnt;
    SELF := le;
  END;
  Supports := JOIN(BestMiddleName_tab_mname,BestMiddleName_tab_mname, LEFT.did = RIGHT.did  AND ( (LEFT.mname[1..LENGTH(TRIM(RIGHT.mname))] = RIGHT.mname OR RIGHT.mname[1..LENGTH(TRIM(LEFT.mname))] = LEFT.mname ) OR Watchdog_best.Config.WithinEditN(LEFT.mname,0,RIGHT.mname,0,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT BestMiddleName_fuzz_mname := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);

  // Now actually find the best value enforcing minimum
  EXPORT BestMiddleName_method_mname := DEDUP( SORT( BestMiddleName_fuzz_mname,did,-LENGTH(TRIM((SALT311.StrType)mname)),-Row_Cnt,LOCAL)(Row_Cnt >= 2),did,LOCAL);



  // Create those fields with BestType: CommonMiddleName
  // First step is to get all of the data slimmed and row-reduced
  EXPORT CommonMiddleName_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,mname,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,mname,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(CommonMiddleName_tab_((mname NOT IN SET(s.nulls_mname,mname) AND mname <> (TYPEOF(mname))''),Watchdog_Best.fn_valid_mname(TRIM((SALT311.StrType)mname),src)),{did,src,data_permits,mname,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT CommonMiddleName_tab_mname := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Adjust scores for mname using defined fuzzy logic 
  Fuzzy_layout := RECORD
    CommonMiddleName_tab_mname.did;
    CommonMiddleName_tab_mname.mname;
    UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
    UNSIGNED Row_Cnt;
    UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
  END;
  Fuzzy_layout NoteSupport(CommonMiddleName_tab_mname le,CommonMiddleName_tab_mname ri) := TRANSFORM
    SELF.Row_Cnt := ri.Row_Cnt;
    SELF.Orig_Row_Cnt := le.Row_Cnt;
    SELF := le;
  END;
  Supports := JOIN(CommonMiddleName_tab_mname,CommonMiddleName_tab_mname, LEFT.did = RIGHT.did  AND ( (LEFT.mname[1..LENGTH(TRIM(RIGHT.mname))] = RIGHT.mname OR RIGHT.mname[1..LENGTH(TRIM(LEFT.mname))] = LEFT.mname ) OR Watchdog_best.Config.WithinEditN(LEFT.mname,0,RIGHT.mname,0,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT CommonMiddleName_fuzz_mname := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( CommonMiddleName_fuzz_mname,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT CommonMiddleName_method_mname := cmn;



  // Create those fields with BestType: CommonLastName
  // First step is to get all of the data slimmed and row-reduced
  EXPORT CommonLastName_tab_ := DISTRIBUTE(TABLE(h_bm(did <> 0),{did,src,data_permits,lname,UNSIGNED Row_Cnt := COUNT(GROUP)},did,src,data_permits,lname,MERGE),HASH(did)); // Slim and reduce row-count

  Slim := TABLE(CommonLastName_tab_((lname NOT IN SET(s.nulls_lname,lname) AND lname <> (TYPEOF(lname))''),Watchdog_Best.fn_valid_lname(TRIM((SALT311.StrType)lname),src)),{did,src,data_permits,lname,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT CommonLastName_tab_lname := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,src,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,src,data_permits,LOCAL);

  // Adjust scores for lname using defined fuzzy logic 
  Fuzzy_layout := RECORD
    CommonLastName_tab_lname.did;
    CommonLastName_tab_lname.lname;
    UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
    UNSIGNED Row_Cnt;
    UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
  END;
  Fuzzy_layout NoteSupport(CommonLastName_tab_lname le,CommonLastName_tab_lname ri) := TRANSFORM
    SELF.Row_Cnt := ri.Row_Cnt;
    SELF.Orig_Row_Cnt := le.Row_Cnt;
    SELF := le;
  END;
  Supports := JOIN(CommonLastName_tab_lname,CommonLastName_tab_lname, LEFT.did = RIGHT.did  AND ( LEFT.lname = (TYPEOF(LEFT.lname))'' OR RIGHT.lname = (TYPEOF(RIGHT.lname))'' OR LEFT.lname = RIGHT.lname  OR SALT311.HyphenMatch(LEFT.lname,RIGHT.lname,1)<=1  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
  EXPORT CommonLastName_fuzz_lname := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);

  // Now actually find the best value
  grp := GROUP( CommonLastName_fuzz_lname,did,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
  EXPORT CommonLastName_method_lname := cmn;

  // Start to gather together all records with basis:did,src,data_permits
  // 0 - Gathering type:BestTitle Entries:1
  R0 := RECORD
    TYPEOF(BestTitle_method_title.did) did; // Need to copy in basis
    TYPEOF(BestTitle_method_title.title) BestTitle_title;
    UNSIGNED title_BestTitle_Row_Cnt;
    UNSIGNED4 title_BestTitle_data_permits;
  END;
  R0 T0(BestTitle_method_title ri) := TRANSFORM
    SELF.BestTitle_title := ri.title;
    SELF.title_BestTitle_Row_Cnt := ri.Row_Cnt;
    SELF.title_BestTitle_data_permits := ri.data_permits;
    SELF := ri;
  END;
  J0 := PROJECT(BestTitle_method_title,T0(left));
  // 1 - Gathering type:BestSuffix Entries:1
  R1 := RECORD
    J0; // The data so far
    TYPEOF(BestSuffix_method_name_suffix.name_suffix) BestSuffix_name_suffix;
    UNSIGNED name_suffix_BestSuffix_Row_Cnt;
    UNSIGNED4 name_suffix_BestSuffix_data_permits;
  END;
  R1 T1(J0 le,BestSuffix_method_name_suffix ri) := TRANSFORM
    SELF.BestSuffix_name_suffix := ri.name_suffix;
    SELF.name_suffix_BestSuffix_Row_Cnt := ri.Row_Cnt;
    SELF.name_suffix_BestSuffix_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J1 := JOIN(J0,BestSuffix_method_name_suffix,LEFT.did = RIGHT.did,T1(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 2 - Gathering type:BestSSN Entries:1
  R2 := RECORD
    J1; // The data so far
    TYPEOF(BestSSN_method_ssnum.ssn) BestSSN_ssnum_ssn;
    TYPEOF(BestSSN_method_ssnum.valid_ssn) BestSSN_ssnum_valid_ssn;
    UNSIGNED ssnum_BestSSN_Row_Cnt;
    UNSIGNED ssnum_BestSSN_Orig_Row_Cnt;
    UNSIGNED4 ssnum_BestSSN_data_permits;
  END;
  R2 T2(J1 le,BestSSN_method_ssnum ri) := TRANSFORM
    SELF.BestSSN_ssnum_ssn := ri.ssn;
    SELF.BestSSN_ssnum_valid_ssn := ri.valid_ssn;
    SELF.ssnum_BestSSN_Row_Cnt := ri.Row_Cnt;
    SELF.ssnum_BestSSN_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.ssnum_BestSSN_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J2 := JOIN(J1,BestSSN_method_ssnum,LEFT.did = RIGHT.did,T2(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 3 - Gathering type:SecondBestSSN Entries:1
  R3 := RECORD
    J2; // The data so far
    TYPEOF(SecondBestSSN_method_ssnum.ssn) SecondBestSSN_ssnum_ssn;
    TYPEOF(SecondBestSSN_method_ssnum.valid_ssn) SecondBestSSN_ssnum_valid_ssn;
    UNSIGNED ssnum_SecondBestSSN_Row_Cnt;
    UNSIGNED ssnum_SecondBestSSN_Orig_Row_Cnt;
    UNSIGNED4 ssnum_SecondBestSSN_data_permits;
  END;
  R3 T3(J2 le,SecondBestSSN_method_ssnum ri) := TRANSFORM
    SELF.SecondBestSSN_ssnum_ssn := ri.ssn;
    SELF.SecondBestSSN_ssnum_valid_ssn := ri.valid_ssn;
    SELF.ssnum_SecondBestSSN_Row_Cnt := ri.Row_Cnt;
    SELF.ssnum_SecondBestSSN_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.ssnum_SecondBestSSN_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J3 := JOIN(J2,SecondBestSSN_method_ssnum,LEFT.did = RIGHT.did,T3(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 4 - Gathering type:BestPhoneCurrentWithNpa Entries:1
  R4 := RECORD
    J3; // The data so far
    TYPEOF(BestPhoneCurrentWithNpa_method_phone.phone) BestPhoneCurrentWithNpa_phone;
    UNSIGNED phone_BestPhoneCurrentWithNpa_Row_Cnt;
    UNSIGNED phone_BestPhoneCurrentWithNpa_Orig_Row_Cnt;
    UNSIGNED4 phone_BestPhoneCurrentWithNpa_data_permits;
  END;
  R4 T4(J3 le,BestPhoneCurrentWithNpa_method_phone ri) := TRANSFORM
    SELF.BestPhoneCurrentWithNpa_phone := ri.phone;
    SELF.phone_BestPhoneCurrentWithNpa_Row_Cnt := ri.Row_Cnt;
    SELF.phone_BestPhoneCurrentWithNpa_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.phone_BestPhoneCurrentWithNpa_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J4 := JOIN(J3,BestPhoneCurrentWithNpa_method_phone,LEFT.did = RIGHT.did,T4(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 5 - Gathering type:BestDOB Entries:1
  R5 := RECORD
    J4; // The data so far
    TYPEOF(BestDOB_method_dob.dob) BestDOB_dob;
    UNSIGNED dob_BestDOB_Row_Cnt;
    UNSIGNED4 dob_BestDOB_data_permits;
  END;
  R5 T5(J4 le,BestDOB_method_dob ri) := TRANSFORM
    SELF.BestDOB_dob := ri.dob;
    SELF.dob_BestDOB_Row_Cnt := ri.Row_Cnt;
    SELF.dob_BestDOB_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J5 := JOIN(J4,BestDOB_method_dob,LEFT.did = RIGHT.did,T5(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 6 - Gathering type:NoDayDOB Entries:1
  R6 := RECORD
    J5; // The data so far
    TYPEOF(NoDayDOB_method_dob.dob) NoDayDOB_dob;
    UNSIGNED dob_NoDayDOB_Row_Cnt;
    UNSIGNED4 dob_NoDayDOB_data_permits;
  END;
  R6 T6(J5 le,NoDayDOB_method_dob ri) := TRANSFORM
    SELF.NoDayDOB_dob := ri.dob;
    SELF.dob_NoDayDOB_Row_Cnt := ri.Row_Cnt;
    SELF.dob_NoDayDOB_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J6 := JOIN(J5,NoDayDOB_method_dob,LEFT.did = RIGHT.did,T6(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 7 - Gathering type:NoMonthDOB Entries:1
  R7 := RECORD
    J6; // The data so far
    TYPEOF(NoMonthDOB_method_dob.dob) NoMonthDOB_dob;
    UNSIGNED dob_NoMonthDOB_Row_Cnt;
    UNSIGNED4 dob_NoMonthDOB_data_permits;
  END;
  R7 T7(J6 le,NoMonthDOB_method_dob ri) := TRANSFORM
    SELF.NoMonthDOB_dob := ri.dob;
    SELF.dob_NoMonthDOB_Row_Cnt := ri.Row_Cnt;
    SELF.dob_NoMonthDOB_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J7 := JOIN(J6,NoMonthDOB_method_dob,LEFT.did = RIGHT.did,T7(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 8 - Gathering type:BestAddress Entries:1
  R8 := RECORD
    J7; // The data so far
    TYPEOF(BestAddress_method_address.prim_range) BestAddress_address_prim_range;
    TYPEOF(BestAddress_method_address.predir) BestAddress_address_predir;
    TYPEOF(BestAddress_method_address.prim_name) BestAddress_address_prim_name;
    TYPEOF(BestAddress_method_address.suffix) BestAddress_address_suffix;
    TYPEOF(BestAddress_method_address.postdir) BestAddress_address_postdir;
    TYPEOF(BestAddress_method_address.unit_desig) BestAddress_address_unit_desig;
    TYPEOF(BestAddress_method_address.sec_range) BestAddress_address_sec_range;
    TYPEOF(BestAddress_method_address.city_name) BestAddress_address_city_name;
    TYPEOF(BestAddress_method_address.st) BestAddress_address_st;
    TYPEOF(BestAddress_method_address.zip) BestAddress_address_zip;
    TYPEOF(BestAddress_method_address.zip4) BestAddress_address_zip4;
    TYPEOF(BestAddress_method_address.tnt) BestAddress_address_tnt;
    TYPEOF(BestAddress_method_address.rawaid) BestAddress_address_rawaid;
    TYPEOF(BestAddress_method_address.dt_first_seen) BestAddress_address_dt_first_seen;
    TYPEOF(BestAddress_method_address.dt_last_seen) BestAddress_address_dt_last_seen;
    TYPEOF(BestAddress_method_address.dt_vendor_first_reported) BestAddress_address_dt_vendor_first_reported;
    TYPEOF(BestAddress_method_address.dt_vendor_last_reported) BestAddress_address_dt_vendor_last_reported;
    UNSIGNED address_BestAddress_Row_Cnt;
    UNSIGNED4 address_BestAddress_data_permits;
  END;
  R8 T8(J7 le,BestAddress_method_address ri) := TRANSFORM
    SELF.BestAddress_address_prim_range := ri.prim_range;
    SELF.BestAddress_address_predir := ri.predir;
    SELF.BestAddress_address_prim_name := ri.prim_name;
    SELF.BestAddress_address_suffix := ri.suffix;
    SELF.BestAddress_address_postdir := ri.postdir;
    SELF.BestAddress_address_unit_desig := ri.unit_desig;
    SELF.BestAddress_address_sec_range := ri.sec_range;
    SELF.BestAddress_address_city_name := ri.city_name;
    SELF.BestAddress_address_st := ri.st;
    SELF.BestAddress_address_zip := ri.zip;
    SELF.BestAddress_address_zip4 := ri.zip4;
    SELF.BestAddress_address_tnt := ri.tnt;
    SELF.BestAddress_address_rawaid := ri.rawaid;
    SELF.BestAddress_address_dt_first_seen := ri.dt_first_seen;
    SELF.BestAddress_address_dt_last_seen := ri.dt_last_seen;
    SELF.BestAddress_address_dt_vendor_first_reported := ri.dt_vendor_first_reported;
    SELF.BestAddress_address_dt_vendor_last_reported := ri.dt_vendor_last_reported;
    SELF.address_BestAddress_Row_Cnt := ri.Row_Cnt;
    SELF.address_BestAddress_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J8 := JOIN(J7,BestAddress_method_address,LEFT.did = RIGHT.did,T8(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 9 - Gathering type:GongAddressBySeen Entries:1
  R9 := RECORD
    J8; // The data so far
    TYPEOF(GongAddressBySeen_method_address.prim_range) GongAddressBySeen_address_prim_range;
    TYPEOF(GongAddressBySeen_method_address.predir) GongAddressBySeen_address_predir;
    TYPEOF(GongAddressBySeen_method_address.prim_name) GongAddressBySeen_address_prim_name;
    TYPEOF(GongAddressBySeen_method_address.suffix) GongAddressBySeen_address_suffix;
    TYPEOF(GongAddressBySeen_method_address.postdir) GongAddressBySeen_address_postdir;
    TYPEOF(GongAddressBySeen_method_address.unit_desig) GongAddressBySeen_address_unit_desig;
    TYPEOF(GongAddressBySeen_method_address.sec_range) GongAddressBySeen_address_sec_range;
    TYPEOF(GongAddressBySeen_method_address.city_name) GongAddressBySeen_address_city_name;
    TYPEOF(GongAddressBySeen_method_address.st) GongAddressBySeen_address_st;
    TYPEOF(GongAddressBySeen_method_address.zip) GongAddressBySeen_address_zip;
    TYPEOF(GongAddressBySeen_method_address.zip4) GongAddressBySeen_address_zip4;
    TYPEOF(GongAddressBySeen_method_address.tnt) GongAddressBySeen_address_tnt;
    TYPEOF(GongAddressBySeen_method_address.rawaid) GongAddressBySeen_address_rawaid;
    TYPEOF(GongAddressBySeen_method_address.dt_first_seen) GongAddressBySeen_address_dt_first_seen;
    TYPEOF(GongAddressBySeen_method_address.dt_last_seen) GongAddressBySeen_address_dt_last_seen;
    TYPEOF(GongAddressBySeen_method_address.dt_vendor_first_reported) GongAddressBySeen_address_dt_vendor_first_reported;
    TYPEOF(GongAddressBySeen_method_address.dt_vendor_last_reported) GongAddressBySeen_address_dt_vendor_last_reported;
    UNSIGNED address_GongAddressBySeen_Row_Cnt;
    UNSIGNED4 address_GongAddressBySeen_data_permits;
  END;
  R9 T9(J8 le,GongAddressBySeen_method_address ri) := TRANSFORM
    SELF.GongAddressBySeen_address_prim_range := ri.prim_range;
    SELF.GongAddressBySeen_address_predir := ri.predir;
    SELF.GongAddressBySeen_address_prim_name := ri.prim_name;
    SELF.GongAddressBySeen_address_suffix := ri.suffix;
    SELF.GongAddressBySeen_address_postdir := ri.postdir;
    SELF.GongAddressBySeen_address_unit_desig := ri.unit_desig;
    SELF.GongAddressBySeen_address_sec_range := ri.sec_range;
    SELF.GongAddressBySeen_address_city_name := ri.city_name;
    SELF.GongAddressBySeen_address_st := ri.st;
    SELF.GongAddressBySeen_address_zip := ri.zip;
    SELF.GongAddressBySeen_address_zip4 := ri.zip4;
    SELF.GongAddressBySeen_address_tnt := ri.tnt;
    SELF.GongAddressBySeen_address_rawaid := ri.rawaid;
    SELF.GongAddressBySeen_address_dt_first_seen := ri.dt_first_seen;
    SELF.GongAddressBySeen_address_dt_last_seen := ri.dt_last_seen;
    SELF.GongAddressBySeen_address_dt_vendor_first_reported := ri.dt_vendor_first_reported;
    SELF.GongAddressBySeen_address_dt_vendor_last_reported := ri.dt_vendor_last_reported;
    SELF.address_GongAddressBySeen_Row_Cnt := ri.Row_Cnt;
    SELF.address_GongAddressBySeen_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J9 := JOIN(J8,GongAddressBySeen_method_address,LEFT.did = RIGHT.did,T9(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 10 - Gathering type:BetterAddressBySeen Entries:1
  R10 := RECORD
    J9; // The data so far
    TYPEOF(BetterAddressBySeen_method_address.prim_range) BetterAddressBySeen_address_prim_range;
    TYPEOF(BetterAddressBySeen_method_address.predir) BetterAddressBySeen_address_predir;
    TYPEOF(BetterAddressBySeen_method_address.prim_name) BetterAddressBySeen_address_prim_name;
    TYPEOF(BetterAddressBySeen_method_address.suffix) BetterAddressBySeen_address_suffix;
    TYPEOF(BetterAddressBySeen_method_address.postdir) BetterAddressBySeen_address_postdir;
    TYPEOF(BetterAddressBySeen_method_address.unit_desig) BetterAddressBySeen_address_unit_desig;
    TYPEOF(BetterAddressBySeen_method_address.sec_range) BetterAddressBySeen_address_sec_range;
    TYPEOF(BetterAddressBySeen_method_address.city_name) BetterAddressBySeen_address_city_name;
    TYPEOF(BetterAddressBySeen_method_address.st) BetterAddressBySeen_address_st;
    TYPEOF(BetterAddressBySeen_method_address.zip) BetterAddressBySeen_address_zip;
    TYPEOF(BetterAddressBySeen_method_address.zip4) BetterAddressBySeen_address_zip4;
    TYPEOF(BetterAddressBySeen_method_address.tnt) BetterAddressBySeen_address_tnt;
    TYPEOF(BetterAddressBySeen_method_address.rawaid) BetterAddressBySeen_address_rawaid;
    TYPEOF(BetterAddressBySeen_method_address.dt_first_seen) BetterAddressBySeen_address_dt_first_seen;
    TYPEOF(BetterAddressBySeen_method_address.dt_last_seen) BetterAddressBySeen_address_dt_last_seen;
    TYPEOF(BetterAddressBySeen_method_address.dt_vendor_first_reported) BetterAddressBySeen_address_dt_vendor_first_reported;
    TYPEOF(BetterAddressBySeen_method_address.dt_vendor_last_reported) BetterAddressBySeen_address_dt_vendor_last_reported;
    UNSIGNED address_BetterAddressBySeen_Row_Cnt;
    UNSIGNED4 address_BetterAddressBySeen_data_permits;
  END;
  R10 T10(J9 le,BetterAddressBySeen_method_address ri) := TRANSFORM
    SELF.BetterAddressBySeen_address_prim_range := ri.prim_range;
    SELF.BetterAddressBySeen_address_predir := ri.predir;
    SELF.BetterAddressBySeen_address_prim_name := ri.prim_name;
    SELF.BetterAddressBySeen_address_suffix := ri.suffix;
    SELF.BetterAddressBySeen_address_postdir := ri.postdir;
    SELF.BetterAddressBySeen_address_unit_desig := ri.unit_desig;
    SELF.BetterAddressBySeen_address_sec_range := ri.sec_range;
    SELF.BetterAddressBySeen_address_city_name := ri.city_name;
    SELF.BetterAddressBySeen_address_st := ri.st;
    SELF.BetterAddressBySeen_address_zip := ri.zip;
    SELF.BetterAddressBySeen_address_zip4 := ri.zip4;
    SELF.BetterAddressBySeen_address_tnt := ri.tnt;
    SELF.BetterAddressBySeen_address_rawaid := ri.rawaid;
    SELF.BetterAddressBySeen_address_dt_first_seen := ri.dt_first_seen;
    SELF.BetterAddressBySeen_address_dt_last_seen := ri.dt_last_seen;
    SELF.BetterAddressBySeen_address_dt_vendor_first_reported := ri.dt_vendor_first_reported;
    SELF.BetterAddressBySeen_address_dt_vendor_last_reported := ri.dt_vendor_last_reported;
    SELF.address_BetterAddressBySeen_Row_Cnt := ri.Row_Cnt;
    SELF.address_BetterAddressBySeen_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J10 := JOIN(J9,BetterAddressBySeen_method_address,LEFT.did = RIGHT.did,T10(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 11 - Gathering type:RecentAddressBySeen Entries:1
  R11 := RECORD
    J10; // The data so far
    TYPEOF(RecentAddressBySeen_method_address.prim_range) RecentAddressBySeen_address_prim_range;
    TYPEOF(RecentAddressBySeen_method_address.predir) RecentAddressBySeen_address_predir;
    TYPEOF(RecentAddressBySeen_method_address.prim_name) RecentAddressBySeen_address_prim_name;
    TYPEOF(RecentAddressBySeen_method_address.suffix) RecentAddressBySeen_address_suffix;
    TYPEOF(RecentAddressBySeen_method_address.postdir) RecentAddressBySeen_address_postdir;
    TYPEOF(RecentAddressBySeen_method_address.unit_desig) RecentAddressBySeen_address_unit_desig;
    TYPEOF(RecentAddressBySeen_method_address.sec_range) RecentAddressBySeen_address_sec_range;
    TYPEOF(RecentAddressBySeen_method_address.city_name) RecentAddressBySeen_address_city_name;
    TYPEOF(RecentAddressBySeen_method_address.st) RecentAddressBySeen_address_st;
    TYPEOF(RecentAddressBySeen_method_address.zip) RecentAddressBySeen_address_zip;
    TYPEOF(RecentAddressBySeen_method_address.zip4) RecentAddressBySeen_address_zip4;
    TYPEOF(RecentAddressBySeen_method_address.tnt) RecentAddressBySeen_address_tnt;
    TYPEOF(RecentAddressBySeen_method_address.rawaid) RecentAddressBySeen_address_rawaid;
    TYPEOF(RecentAddressBySeen_method_address.dt_first_seen) RecentAddressBySeen_address_dt_first_seen;
    TYPEOF(RecentAddressBySeen_method_address.dt_last_seen) RecentAddressBySeen_address_dt_last_seen;
    TYPEOF(RecentAddressBySeen_method_address.dt_vendor_first_reported) RecentAddressBySeen_address_dt_vendor_first_reported;
    TYPEOF(RecentAddressBySeen_method_address.dt_vendor_last_reported) RecentAddressBySeen_address_dt_vendor_last_reported;
    UNSIGNED address_RecentAddressBySeen_Row_Cnt;
    UNSIGNED4 address_RecentAddressBySeen_data_permits;
  END;
  R11 T11(J10 le,RecentAddressBySeen_method_address ri) := TRANSFORM
    SELF.RecentAddressBySeen_address_prim_range := ri.prim_range;
    SELF.RecentAddressBySeen_address_predir := ri.predir;
    SELF.RecentAddressBySeen_address_prim_name := ri.prim_name;
    SELF.RecentAddressBySeen_address_suffix := ri.suffix;
    SELF.RecentAddressBySeen_address_postdir := ri.postdir;
    SELF.RecentAddressBySeen_address_unit_desig := ri.unit_desig;
    SELF.RecentAddressBySeen_address_sec_range := ri.sec_range;
    SELF.RecentAddressBySeen_address_city_name := ri.city_name;
    SELF.RecentAddressBySeen_address_st := ri.st;
    SELF.RecentAddressBySeen_address_zip := ri.zip;
    SELF.RecentAddressBySeen_address_zip4 := ri.zip4;
    SELF.RecentAddressBySeen_address_tnt := ri.tnt;
    SELF.RecentAddressBySeen_address_rawaid := ri.rawaid;
    SELF.RecentAddressBySeen_address_dt_first_seen := ri.dt_first_seen;
    SELF.RecentAddressBySeen_address_dt_last_seen := ri.dt_last_seen;
    SELF.RecentAddressBySeen_address_dt_vendor_first_reported := ri.dt_vendor_first_reported;
    SELF.RecentAddressBySeen_address_dt_vendor_last_reported := ri.dt_vendor_last_reported;
    SELF.address_RecentAddressBySeen_Row_Cnt := ri.Row_Cnt;
    SELF.address_RecentAddressBySeen_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J11 := JOIN(J10,RecentAddressBySeen_method_address,LEFT.did = RIGHT.did,T11(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 12 - Gathering type:BetterAddressByReported Entries:1
  R12 := RECORD
    J11; // The data so far
    TYPEOF(BetterAddressByReported_method_address.prim_range) BetterAddressByReported_address_prim_range;
    TYPEOF(BetterAddressByReported_method_address.predir) BetterAddressByReported_address_predir;
    TYPEOF(BetterAddressByReported_method_address.prim_name) BetterAddressByReported_address_prim_name;
    TYPEOF(BetterAddressByReported_method_address.suffix) BetterAddressByReported_address_suffix;
    TYPEOF(BetterAddressByReported_method_address.postdir) BetterAddressByReported_address_postdir;
    TYPEOF(BetterAddressByReported_method_address.unit_desig) BetterAddressByReported_address_unit_desig;
    TYPEOF(BetterAddressByReported_method_address.sec_range) BetterAddressByReported_address_sec_range;
    TYPEOF(BetterAddressByReported_method_address.city_name) BetterAddressByReported_address_city_name;
    TYPEOF(BetterAddressByReported_method_address.st) BetterAddressByReported_address_st;
    TYPEOF(BetterAddressByReported_method_address.zip) BetterAddressByReported_address_zip;
    TYPEOF(BetterAddressByReported_method_address.zip4) BetterAddressByReported_address_zip4;
    TYPEOF(BetterAddressByReported_method_address.tnt) BetterAddressByReported_address_tnt;
    TYPEOF(BetterAddressByReported_method_address.rawaid) BetterAddressByReported_address_rawaid;
    TYPEOF(BetterAddressByReported_method_address.dt_first_seen) BetterAddressByReported_address_dt_first_seen;
    TYPEOF(BetterAddressByReported_method_address.dt_last_seen) BetterAddressByReported_address_dt_last_seen;
    TYPEOF(BetterAddressByReported_method_address.dt_vendor_first_reported) BetterAddressByReported_address_dt_vendor_first_reported;
    TYPEOF(BetterAddressByReported_method_address.dt_vendor_last_reported) BetterAddressByReported_address_dt_vendor_last_reported;
    UNSIGNED address_BetterAddressByReported_Row_Cnt;
    UNSIGNED4 address_BetterAddressByReported_data_permits;
  END;
  R12 T12(J11 le,BetterAddressByReported_method_address ri) := TRANSFORM
    SELF.BetterAddressByReported_address_prim_range := ri.prim_range;
    SELF.BetterAddressByReported_address_predir := ri.predir;
    SELF.BetterAddressByReported_address_prim_name := ri.prim_name;
    SELF.BetterAddressByReported_address_suffix := ri.suffix;
    SELF.BetterAddressByReported_address_postdir := ri.postdir;
    SELF.BetterAddressByReported_address_unit_desig := ri.unit_desig;
    SELF.BetterAddressByReported_address_sec_range := ri.sec_range;
    SELF.BetterAddressByReported_address_city_name := ri.city_name;
    SELF.BetterAddressByReported_address_st := ri.st;
    SELF.BetterAddressByReported_address_zip := ri.zip;
    SELF.BetterAddressByReported_address_zip4 := ri.zip4;
    SELF.BetterAddressByReported_address_tnt := ri.tnt;
    SELF.BetterAddressByReported_address_rawaid := ri.rawaid;
    SELF.BetterAddressByReported_address_dt_first_seen := ri.dt_first_seen;
    SELF.BetterAddressByReported_address_dt_last_seen := ri.dt_last_seen;
    SELF.BetterAddressByReported_address_dt_vendor_first_reported := ri.dt_vendor_first_reported;
    SELF.BetterAddressByReported_address_dt_vendor_last_reported := ri.dt_vendor_last_reported;
    SELF.address_BetterAddressByReported_Row_Cnt := ri.Row_Cnt;
    SELF.address_BetterAddressByReported_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J12 := JOIN(J11,BetterAddressByReported_method_address,LEFT.did = RIGHT.did,T12(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 13 - Gathering type:RecentAddressByReported Entries:1
  R13 := RECORD
    J12; // The data so far
    TYPEOF(RecentAddressByReported_method_address.prim_range) RecentAddressByReported_address_prim_range;
    TYPEOF(RecentAddressByReported_method_address.predir) RecentAddressByReported_address_predir;
    TYPEOF(RecentAddressByReported_method_address.prim_name) RecentAddressByReported_address_prim_name;
    TYPEOF(RecentAddressByReported_method_address.suffix) RecentAddressByReported_address_suffix;
    TYPEOF(RecentAddressByReported_method_address.postdir) RecentAddressByReported_address_postdir;
    TYPEOF(RecentAddressByReported_method_address.unit_desig) RecentAddressByReported_address_unit_desig;
    TYPEOF(RecentAddressByReported_method_address.sec_range) RecentAddressByReported_address_sec_range;
    TYPEOF(RecentAddressByReported_method_address.city_name) RecentAddressByReported_address_city_name;
    TYPEOF(RecentAddressByReported_method_address.st) RecentAddressByReported_address_st;
    TYPEOF(RecentAddressByReported_method_address.zip) RecentAddressByReported_address_zip;
    TYPEOF(RecentAddressByReported_method_address.zip4) RecentAddressByReported_address_zip4;
    TYPEOF(RecentAddressByReported_method_address.tnt) RecentAddressByReported_address_tnt;
    TYPEOF(RecentAddressByReported_method_address.rawaid) RecentAddressByReported_address_rawaid;
    TYPEOF(RecentAddressByReported_method_address.dt_first_seen) RecentAddressByReported_address_dt_first_seen;
    TYPEOF(RecentAddressByReported_method_address.dt_last_seen) RecentAddressByReported_address_dt_last_seen;
    TYPEOF(RecentAddressByReported_method_address.dt_vendor_first_reported) RecentAddressByReported_address_dt_vendor_first_reported;
    TYPEOF(RecentAddressByReported_method_address.dt_vendor_last_reported) RecentAddressByReported_address_dt_vendor_last_reported;
    UNSIGNED address_RecentAddressByReported_Row_Cnt;
    UNSIGNED4 address_RecentAddressByReported_data_permits;
  END;
  R13 T13(J12 le,RecentAddressByReported_method_address ri) := TRANSFORM
    SELF.RecentAddressByReported_address_prim_range := ri.prim_range;
    SELF.RecentAddressByReported_address_predir := ri.predir;
    SELF.RecentAddressByReported_address_prim_name := ri.prim_name;
    SELF.RecentAddressByReported_address_suffix := ri.suffix;
    SELF.RecentAddressByReported_address_postdir := ri.postdir;
    SELF.RecentAddressByReported_address_unit_desig := ri.unit_desig;
    SELF.RecentAddressByReported_address_sec_range := ri.sec_range;
    SELF.RecentAddressByReported_address_city_name := ri.city_name;
    SELF.RecentAddressByReported_address_st := ri.st;
    SELF.RecentAddressByReported_address_zip := ri.zip;
    SELF.RecentAddressByReported_address_zip4 := ri.zip4;
    SELF.RecentAddressByReported_address_tnt := ri.tnt;
    SELF.RecentAddressByReported_address_rawaid := ri.rawaid;
    SELF.RecentAddressByReported_address_dt_first_seen := ri.dt_first_seen;
    SELF.RecentAddressByReported_address_dt_last_seen := ri.dt_last_seen;
    SELF.RecentAddressByReported_address_dt_vendor_first_reported := ri.dt_vendor_first_reported;
    SELF.RecentAddressByReported_address_dt_vendor_last_reported := ri.dt_vendor_last_reported;
    SELF.address_RecentAddressByReported_Row_Cnt := ri.Row_Cnt;
    SELF.address_RecentAddressByReported_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J13 := JOIN(J12,RecentAddressByReported_method_address,LEFT.did = RIGHT.did,T13(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 14 - Gathering type:CommonestAddress Entries:1
  R14 := RECORD
    J13; // The data so far
    TYPEOF(CommonestAddress_method_address.prim_range) CommonestAddress_address_prim_range;
    TYPEOF(CommonestAddress_method_address.predir) CommonestAddress_address_predir;
    TYPEOF(CommonestAddress_method_address.prim_name) CommonestAddress_address_prim_name;
    TYPEOF(CommonestAddress_method_address.suffix) CommonestAddress_address_suffix;
    TYPEOF(CommonestAddress_method_address.postdir) CommonestAddress_address_postdir;
    TYPEOF(CommonestAddress_method_address.unit_desig) CommonestAddress_address_unit_desig;
    TYPEOF(CommonestAddress_method_address.sec_range) CommonestAddress_address_sec_range;
    TYPEOF(CommonestAddress_method_address.city_name) CommonestAddress_address_city_name;
    TYPEOF(CommonestAddress_method_address.st) CommonestAddress_address_st;
    TYPEOF(CommonestAddress_method_address.zip) CommonestAddress_address_zip;
    TYPEOF(CommonestAddress_method_address.zip4) CommonestAddress_address_zip4;
    TYPEOF(CommonestAddress_method_address.tnt) CommonestAddress_address_tnt;
    TYPEOF(CommonestAddress_method_address.rawaid) CommonestAddress_address_rawaid;
    TYPEOF(CommonestAddress_method_address.dt_first_seen) CommonestAddress_address_dt_first_seen;
    TYPEOF(CommonestAddress_method_address.dt_last_seen) CommonestAddress_address_dt_last_seen;
    TYPEOF(CommonestAddress_method_address.dt_vendor_first_reported) CommonestAddress_address_dt_vendor_first_reported;
    TYPEOF(CommonestAddress_method_address.dt_vendor_last_reported) CommonestAddress_address_dt_vendor_last_reported;
    UNSIGNED address_CommonestAddress_Row_Cnt;
    UNSIGNED4 address_CommonestAddress_data_permits;
  END;
  R14 T14(J13 le,CommonestAddress_method_address ri) := TRANSFORM
    SELF.CommonestAddress_address_prim_range := ri.prim_range;
    SELF.CommonestAddress_address_predir := ri.predir;
    SELF.CommonestAddress_address_prim_name := ri.prim_name;
    SELF.CommonestAddress_address_suffix := ri.suffix;
    SELF.CommonestAddress_address_postdir := ri.postdir;
    SELF.CommonestAddress_address_unit_desig := ri.unit_desig;
    SELF.CommonestAddress_address_sec_range := ri.sec_range;
    SELF.CommonestAddress_address_city_name := ri.city_name;
    SELF.CommonestAddress_address_st := ri.st;
    SELF.CommonestAddress_address_zip := ri.zip;
    SELF.CommonestAddress_address_zip4 := ri.zip4;
    SELF.CommonestAddress_address_tnt := ri.tnt;
    SELF.CommonestAddress_address_rawaid := ri.rawaid;
    SELF.CommonestAddress_address_dt_first_seen := ri.dt_first_seen;
    SELF.CommonestAddress_address_dt_last_seen := ri.dt_last_seen;
    SELF.CommonestAddress_address_dt_vendor_first_reported := ri.dt_vendor_first_reported;
    SELF.CommonestAddress_address_dt_vendor_last_reported := ri.dt_vendor_last_reported;
    SELF.address_CommonestAddress_Row_Cnt := ri.Row_Cnt;
    SELF.address_CommonestAddress_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J14 := JOIN(J13,CommonestAddress_method_address,LEFT.did = RIGHT.did,T14(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 15 - Gathering type:BestFirstName Entries:1
  R15 := RECORD
    J14; // The data so far
    TYPEOF(BestFirstName_method_fname.fname) BestFirstName_fname;
    UNSIGNED fname_BestFirstName_Row_Cnt;
    UNSIGNED fname_BestFirstName_Orig_Row_Cnt;
    UNSIGNED4 fname_BestFirstName_data_permits;
  END;
  R15 T15(J14 le,BestFirstName_method_fname ri) := TRANSFORM
    SELF.BestFirstName_fname := ri.fname;
    SELF.fname_BestFirstName_Row_Cnt := ri.Row_Cnt;
    SELF.fname_BestFirstName_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.fname_BestFirstName_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J15 := JOIN(J14,BestFirstName_method_fname,LEFT.did = RIGHT.did,T15(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 16 - Gathering type:CommonFirstName Entries:1
  R16 := RECORD
    J15; // The data so far
    TYPEOF(CommonFirstName_method_fname.fname) CommonFirstName_fname;
    UNSIGNED fname_CommonFirstName_Row_Cnt;
    UNSIGNED fname_CommonFirstName_Orig_Row_Cnt;
    UNSIGNED4 fname_CommonFirstName_data_permits;
  END;
  R16 T16(J15 le,CommonFirstName_method_fname ri) := TRANSFORM
    SELF.CommonFirstName_fname := ri.fname;
    SELF.fname_CommonFirstName_Row_Cnt := ri.Row_Cnt;
    SELF.fname_CommonFirstName_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.fname_CommonFirstName_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J16 := JOIN(J15,CommonFirstName_method_fname,LEFT.did = RIGHT.did,T16(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 17 - Gathering type:BestMiddleName Entries:1
  R17 := RECORD
    J16; // The data so far
    TYPEOF(BestMiddleName_method_mname.mname) BestMiddleName_mname;
    UNSIGNED mname_BestMiddleName_Row_Cnt;
    UNSIGNED mname_BestMiddleName_Orig_Row_Cnt;
    UNSIGNED4 mname_BestMiddleName_data_permits;
  END;
  R17 T17(J16 le,BestMiddleName_method_mname ri) := TRANSFORM
    SELF.BestMiddleName_mname := ri.mname;
    SELF.mname_BestMiddleName_Row_Cnt := ri.Row_Cnt;
    SELF.mname_BestMiddleName_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.mname_BestMiddleName_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J17 := JOIN(J16,BestMiddleName_method_mname,LEFT.did = RIGHT.did,T17(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 18 - Gathering type:CommonMiddleName Entries:1
  R18 := RECORD
    J17; // The data so far
    TYPEOF(CommonMiddleName_method_mname.mname) CommonMiddleName_mname;
    UNSIGNED mname_CommonMiddleName_Row_Cnt;
    UNSIGNED mname_CommonMiddleName_Orig_Row_Cnt;
    UNSIGNED4 mname_CommonMiddleName_data_permits;
  END;
  R18 T18(J17 le,CommonMiddleName_method_mname ri) := TRANSFORM
    SELF.CommonMiddleName_mname := ri.mname;
    SELF.mname_CommonMiddleName_Row_Cnt := ri.Row_Cnt;
    SELF.mname_CommonMiddleName_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.mname_CommonMiddleName_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J18 := JOIN(J17,CommonMiddleName_method_mname,LEFT.did = RIGHT.did,T18(LEFT,RIGHT),FULL OUTER,LOCAL);
  // 19 - Gathering type:BestLastName Entries:0
  // 19 - Gathering type:CommonLastName Entries:1
  R19 := RECORD
    J18; // The data so far
    TYPEOF(CommonLastName_method_lname.lname) CommonLastName_lname;
    UNSIGNED lname_CommonLastName_Row_Cnt;
    UNSIGNED lname_CommonLastName_Orig_Row_Cnt;
    UNSIGNED4 lname_CommonLastName_data_permits;
  END;
  R19 T19(J18 le,CommonLastName_method_lname ri) := TRANSFORM
    SELF.CommonLastName_lname := ri.lname;
    SELF.lname_CommonLastName_Row_Cnt := ri.Row_Cnt;
    SELF.lname_CommonLastName_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.lname_CommonLastName_data_permits := ri.data_permits;
    BOOLEAN has_left := le.did <> (TYPEOF(le.did))''; // See if LHS is null
    SELF.did := IF( has_left, le.did, ri.did );
    SELF := le;
  END;
  J19 := JOIN(J18,CommonLastName_method_lname,LEFT.did = RIGHT.did,T19(LEFT,RIGHT),FULL OUTER,LOCAL);
  EXPORT BestBy_did_np := J19;
  EXPORT BestBy_did := BestBy_did_np : PERSIST('~temp::did::Watchdog_best::best::BestBy_did',EXPIRE(Watchdog_best.Config.PersistExpire));

  // Now gather some statistics to see how we did
  R := RECORD
    NumberOfBasis := COUNT(GROUP);
    REAL8 BestTitle_title_pcnt := AVE(GROUP,IF(BestBy_did.BestTitle_title=(typeof(BestBy_did.BestTitle_title))'',0,100));
    UNSIGNED BestTitle_title_permit1_cnt := COUNT(GROUP,BestBy_did.title_BestTitle_data_permits&1<>0);
    REAL8 BestSuffix_name_suffix_pcnt := AVE(GROUP,IF(BestBy_did.BestSuffix_name_suffix=(typeof(BestBy_did.BestSuffix_name_suffix))'',0,100));
    UNSIGNED BestSuffix_name_suffix_permit1_cnt := COUNT(GROUP,BestBy_did.name_suffix_BestSuffix_data_permits&1<>0);
    REAL8 BestSSN_ssnum_ssn_pcnt := AVE(GROUP,IF(BestBy_did.BestSSN_ssnum_ssn=(typeof(BestBy_did.BestSSN_ssnum_ssn))'',0,100));
    REAL8 BestSSN_ssnum_valid_ssn_pcnt := AVE(GROUP,IF(BestBy_did.BestSSN_ssnum_valid_ssn=(typeof(BestBy_did.BestSSN_ssnum_valid_ssn))'',0,100));
    UNSIGNED BestSSN_ssnum_permit1_cnt := COUNT(GROUP,BestBy_did.ssnum_BestSSN_data_permits&1<>0);
    REAL8 SecondBestSSN_ssnum_ssn_pcnt := AVE(GROUP,IF(BestBy_did.SecondBestSSN_ssnum_ssn=(typeof(BestBy_did.SecondBestSSN_ssnum_ssn))'',0,100));
    REAL8 SecondBestSSN_ssnum_valid_ssn_pcnt := AVE(GROUP,IF(BestBy_did.SecondBestSSN_ssnum_valid_ssn=(typeof(BestBy_did.SecondBestSSN_ssnum_valid_ssn))'',0,100));
    UNSIGNED SecondBestSSN_ssnum_permit1_cnt := COUNT(GROUP,BestBy_did.ssnum_SecondBestSSN_data_permits&1<>0);
    REAL8 BestPhoneCurrentWithNpa_phone_pcnt := AVE(GROUP,IF(BestBy_did.BestPhoneCurrentWithNpa_phone=(typeof(BestBy_did.BestPhoneCurrentWithNpa_phone))'',0,100));
    UNSIGNED BestPhoneCurrentWithNpa_phone_permit1_cnt := COUNT(GROUP,BestBy_did.phone_BestPhoneCurrentWithNpa_data_permits&1<>0);
    REAL8 BestDOB_dob_pcnt := AVE(GROUP,IF(BestBy_did.BestDOB_dob=(typeof(BestBy_did.BestDOB_dob))'',0,100));
    UNSIGNED BestDOB_dob_permit1_cnt := COUNT(GROUP,BestBy_did.dob_BestDOB_data_permits&1<>0);
    REAL8 NoDayDOB_dob_pcnt := AVE(GROUP,IF(BestBy_did.NoDayDOB_dob=(typeof(BestBy_did.NoDayDOB_dob))'',0,100));
    UNSIGNED NoDayDOB_dob_permit1_cnt := COUNT(GROUP,BestBy_did.dob_NoDayDOB_data_permits&1<>0);
    REAL8 NoMonthDOB_dob_pcnt := AVE(GROUP,IF(BestBy_did.NoMonthDOB_dob=(typeof(BestBy_did.NoMonthDOB_dob))'',0,100));
    UNSIGNED NoMonthDOB_dob_permit1_cnt := COUNT(GROUP,BestBy_did.dob_NoMonthDOB_data_permits&1<>0);
    REAL8 BestAddress_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_prim_range=(typeof(BestBy_did.BestAddress_address_prim_range))'',0,100));
    REAL8 BestAddress_address_predir_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_predir=(typeof(BestBy_did.BestAddress_address_predir))'',0,100));
    REAL8 BestAddress_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_prim_name=(typeof(BestBy_did.BestAddress_address_prim_name))'',0,100));
    REAL8 BestAddress_address_suffix_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_suffix=(typeof(BestBy_did.BestAddress_address_suffix))'',0,100));
    REAL8 BestAddress_address_postdir_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_postdir=(typeof(BestBy_did.BestAddress_address_postdir))'',0,100));
    REAL8 BestAddress_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_unit_desig=(typeof(BestBy_did.BestAddress_address_unit_desig))'',0,100));
    REAL8 BestAddress_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_sec_range=(typeof(BestBy_did.BestAddress_address_sec_range))'',0,100));
    REAL8 BestAddress_address_city_name_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_city_name=(typeof(BestBy_did.BestAddress_address_city_name))'',0,100));
    REAL8 BestAddress_address_st_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_st=(typeof(BestBy_did.BestAddress_address_st))'',0,100));
    REAL8 BestAddress_address_zip_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_zip=(typeof(BestBy_did.BestAddress_address_zip))'',0,100));
    REAL8 BestAddress_address_zip4_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_zip4=(typeof(BestBy_did.BestAddress_address_zip4))'',0,100));
    REAL8 BestAddress_address_tnt_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_tnt=(typeof(BestBy_did.BestAddress_address_tnt))'',0,100));
    REAL8 BestAddress_address_rawaid_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_rawaid=(typeof(BestBy_did.BestAddress_address_rawaid))'',0,100));
    REAL8 BestAddress_address_dt_first_seen_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_dt_first_seen=(typeof(BestBy_did.BestAddress_address_dt_first_seen))'',0,100));
    REAL8 BestAddress_address_dt_last_seen_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_dt_last_seen=(typeof(BestBy_did.BestAddress_address_dt_last_seen))'',0,100));
    REAL8 BestAddress_address_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_dt_vendor_first_reported=(typeof(BestBy_did.BestAddress_address_dt_vendor_first_reported))'',0,100));
    REAL8 BestAddress_address_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(BestBy_did.BestAddress_address_dt_vendor_last_reported=(typeof(BestBy_did.BestAddress_address_dt_vendor_last_reported))'',0,100));
    UNSIGNED BestAddress_address_permit1_cnt := COUNT(GROUP,BestBy_did.address_BestAddress_data_permits&1<>0);
    REAL8 GongAddressBySeen_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_prim_range=(typeof(BestBy_did.GongAddressBySeen_address_prim_range))'',0,100));
    REAL8 GongAddressBySeen_address_predir_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_predir=(typeof(BestBy_did.GongAddressBySeen_address_predir))'',0,100));
    REAL8 GongAddressBySeen_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_prim_name=(typeof(BestBy_did.GongAddressBySeen_address_prim_name))'',0,100));
    REAL8 GongAddressBySeen_address_suffix_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_suffix=(typeof(BestBy_did.GongAddressBySeen_address_suffix))'',0,100));
    REAL8 GongAddressBySeen_address_postdir_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_postdir=(typeof(BestBy_did.GongAddressBySeen_address_postdir))'',0,100));
    REAL8 GongAddressBySeen_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_unit_desig=(typeof(BestBy_did.GongAddressBySeen_address_unit_desig))'',0,100));
    REAL8 GongAddressBySeen_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_sec_range=(typeof(BestBy_did.GongAddressBySeen_address_sec_range))'',0,100));
    REAL8 GongAddressBySeen_address_city_name_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_city_name=(typeof(BestBy_did.GongAddressBySeen_address_city_name))'',0,100));
    REAL8 GongAddressBySeen_address_st_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_st=(typeof(BestBy_did.GongAddressBySeen_address_st))'',0,100));
    REAL8 GongAddressBySeen_address_zip_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_zip=(typeof(BestBy_did.GongAddressBySeen_address_zip))'',0,100));
    REAL8 GongAddressBySeen_address_zip4_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_zip4=(typeof(BestBy_did.GongAddressBySeen_address_zip4))'',0,100));
    REAL8 GongAddressBySeen_address_tnt_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_tnt=(typeof(BestBy_did.GongAddressBySeen_address_tnt))'',0,100));
    REAL8 GongAddressBySeen_address_rawaid_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_rawaid=(typeof(BestBy_did.GongAddressBySeen_address_rawaid))'',0,100));
    REAL8 GongAddressBySeen_address_dt_first_seen_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_dt_first_seen=(typeof(BestBy_did.GongAddressBySeen_address_dt_first_seen))'',0,100));
    REAL8 GongAddressBySeen_address_dt_last_seen_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_dt_last_seen=(typeof(BestBy_did.GongAddressBySeen_address_dt_last_seen))'',0,100));
    REAL8 GongAddressBySeen_address_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_dt_vendor_first_reported=(typeof(BestBy_did.GongAddressBySeen_address_dt_vendor_first_reported))'',0,100));
    REAL8 GongAddressBySeen_address_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(BestBy_did.GongAddressBySeen_address_dt_vendor_last_reported=(typeof(BestBy_did.GongAddressBySeen_address_dt_vendor_last_reported))'',0,100));
    UNSIGNED GongAddressBySeen_address_permit1_cnt := COUNT(GROUP,BestBy_did.address_GongAddressBySeen_data_permits&1<>0);
    REAL8 BetterAddressBySeen_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_prim_range=(typeof(BestBy_did.BetterAddressBySeen_address_prim_range))'',0,100));
    REAL8 BetterAddressBySeen_address_predir_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_predir=(typeof(BestBy_did.BetterAddressBySeen_address_predir))'',0,100));
    REAL8 BetterAddressBySeen_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_prim_name=(typeof(BestBy_did.BetterAddressBySeen_address_prim_name))'',0,100));
    REAL8 BetterAddressBySeen_address_suffix_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_suffix=(typeof(BestBy_did.BetterAddressBySeen_address_suffix))'',0,100));
    REAL8 BetterAddressBySeen_address_postdir_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_postdir=(typeof(BestBy_did.BetterAddressBySeen_address_postdir))'',0,100));
    REAL8 BetterAddressBySeen_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_unit_desig=(typeof(BestBy_did.BetterAddressBySeen_address_unit_desig))'',0,100));
    REAL8 BetterAddressBySeen_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_sec_range=(typeof(BestBy_did.BetterAddressBySeen_address_sec_range))'',0,100));
    REAL8 BetterAddressBySeen_address_city_name_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_city_name=(typeof(BestBy_did.BetterAddressBySeen_address_city_name))'',0,100));
    REAL8 BetterAddressBySeen_address_st_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_st=(typeof(BestBy_did.BetterAddressBySeen_address_st))'',0,100));
    REAL8 BetterAddressBySeen_address_zip_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_zip=(typeof(BestBy_did.BetterAddressBySeen_address_zip))'',0,100));
    REAL8 BetterAddressBySeen_address_zip4_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_zip4=(typeof(BestBy_did.BetterAddressBySeen_address_zip4))'',0,100));
    REAL8 BetterAddressBySeen_address_tnt_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_tnt=(typeof(BestBy_did.BetterAddressBySeen_address_tnt))'',0,100));
    REAL8 BetterAddressBySeen_address_rawaid_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_rawaid=(typeof(BestBy_did.BetterAddressBySeen_address_rawaid))'',0,100));
    REAL8 BetterAddressBySeen_address_dt_first_seen_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_dt_first_seen=(typeof(BestBy_did.BetterAddressBySeen_address_dt_first_seen))'',0,100));
    REAL8 BetterAddressBySeen_address_dt_last_seen_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_dt_last_seen=(typeof(BestBy_did.BetterAddressBySeen_address_dt_last_seen))'',0,100));
    REAL8 BetterAddressBySeen_address_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_dt_vendor_first_reported=(typeof(BestBy_did.BetterAddressBySeen_address_dt_vendor_first_reported))'',0,100));
    REAL8 BetterAddressBySeen_address_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressBySeen_address_dt_vendor_last_reported=(typeof(BestBy_did.BetterAddressBySeen_address_dt_vendor_last_reported))'',0,100));
    UNSIGNED BetterAddressBySeen_address_permit1_cnt := COUNT(GROUP,BestBy_did.address_BetterAddressBySeen_data_permits&1<>0);
    REAL8 RecentAddressBySeen_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_prim_range=(typeof(BestBy_did.RecentAddressBySeen_address_prim_range))'',0,100));
    REAL8 RecentAddressBySeen_address_predir_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_predir=(typeof(BestBy_did.RecentAddressBySeen_address_predir))'',0,100));
    REAL8 RecentAddressBySeen_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_prim_name=(typeof(BestBy_did.RecentAddressBySeen_address_prim_name))'',0,100));
    REAL8 RecentAddressBySeen_address_suffix_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_suffix=(typeof(BestBy_did.RecentAddressBySeen_address_suffix))'',0,100));
    REAL8 RecentAddressBySeen_address_postdir_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_postdir=(typeof(BestBy_did.RecentAddressBySeen_address_postdir))'',0,100));
    REAL8 RecentAddressBySeen_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_unit_desig=(typeof(BestBy_did.RecentAddressBySeen_address_unit_desig))'',0,100));
    REAL8 RecentAddressBySeen_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_sec_range=(typeof(BestBy_did.RecentAddressBySeen_address_sec_range))'',0,100));
    REAL8 RecentAddressBySeen_address_city_name_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_city_name=(typeof(BestBy_did.RecentAddressBySeen_address_city_name))'',0,100));
    REAL8 RecentAddressBySeen_address_st_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_st=(typeof(BestBy_did.RecentAddressBySeen_address_st))'',0,100));
    REAL8 RecentAddressBySeen_address_zip_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_zip=(typeof(BestBy_did.RecentAddressBySeen_address_zip))'',0,100));
    REAL8 RecentAddressBySeen_address_zip4_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_zip4=(typeof(BestBy_did.RecentAddressBySeen_address_zip4))'',0,100));
    REAL8 RecentAddressBySeen_address_tnt_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_tnt=(typeof(BestBy_did.RecentAddressBySeen_address_tnt))'',0,100));
    REAL8 RecentAddressBySeen_address_rawaid_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_rawaid=(typeof(BestBy_did.RecentAddressBySeen_address_rawaid))'',0,100));
    REAL8 RecentAddressBySeen_address_dt_first_seen_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_dt_first_seen=(typeof(BestBy_did.RecentAddressBySeen_address_dt_first_seen))'',0,100));
    REAL8 RecentAddressBySeen_address_dt_last_seen_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_dt_last_seen=(typeof(BestBy_did.RecentAddressBySeen_address_dt_last_seen))'',0,100));
    REAL8 RecentAddressBySeen_address_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_dt_vendor_first_reported=(typeof(BestBy_did.RecentAddressBySeen_address_dt_vendor_first_reported))'',0,100));
    REAL8 RecentAddressBySeen_address_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressBySeen_address_dt_vendor_last_reported=(typeof(BestBy_did.RecentAddressBySeen_address_dt_vendor_last_reported))'',0,100));
    UNSIGNED RecentAddressBySeen_address_permit1_cnt := COUNT(GROUP,BestBy_did.address_RecentAddressBySeen_data_permits&1<>0);
    REAL8 BetterAddressByReported_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_prim_range=(typeof(BestBy_did.BetterAddressByReported_address_prim_range))'',0,100));
    REAL8 BetterAddressByReported_address_predir_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_predir=(typeof(BestBy_did.BetterAddressByReported_address_predir))'',0,100));
    REAL8 BetterAddressByReported_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_prim_name=(typeof(BestBy_did.BetterAddressByReported_address_prim_name))'',0,100));
    REAL8 BetterAddressByReported_address_suffix_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_suffix=(typeof(BestBy_did.BetterAddressByReported_address_suffix))'',0,100));
    REAL8 BetterAddressByReported_address_postdir_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_postdir=(typeof(BestBy_did.BetterAddressByReported_address_postdir))'',0,100));
    REAL8 BetterAddressByReported_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_unit_desig=(typeof(BestBy_did.BetterAddressByReported_address_unit_desig))'',0,100));
    REAL8 BetterAddressByReported_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_sec_range=(typeof(BestBy_did.BetterAddressByReported_address_sec_range))'',0,100));
    REAL8 BetterAddressByReported_address_city_name_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_city_name=(typeof(BestBy_did.BetterAddressByReported_address_city_name))'',0,100));
    REAL8 BetterAddressByReported_address_st_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_st=(typeof(BestBy_did.BetterAddressByReported_address_st))'',0,100));
    REAL8 BetterAddressByReported_address_zip_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_zip=(typeof(BestBy_did.BetterAddressByReported_address_zip))'',0,100));
    REAL8 BetterAddressByReported_address_zip4_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_zip4=(typeof(BestBy_did.BetterAddressByReported_address_zip4))'',0,100));
    REAL8 BetterAddressByReported_address_tnt_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_tnt=(typeof(BestBy_did.BetterAddressByReported_address_tnt))'',0,100));
    REAL8 BetterAddressByReported_address_rawaid_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_rawaid=(typeof(BestBy_did.BetterAddressByReported_address_rawaid))'',0,100));
    REAL8 BetterAddressByReported_address_dt_first_seen_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_dt_first_seen=(typeof(BestBy_did.BetterAddressByReported_address_dt_first_seen))'',0,100));
    REAL8 BetterAddressByReported_address_dt_last_seen_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_dt_last_seen=(typeof(BestBy_did.BetterAddressByReported_address_dt_last_seen))'',0,100));
    REAL8 BetterAddressByReported_address_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_dt_vendor_first_reported=(typeof(BestBy_did.BetterAddressByReported_address_dt_vendor_first_reported))'',0,100));
    REAL8 BetterAddressByReported_address_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(BestBy_did.BetterAddressByReported_address_dt_vendor_last_reported=(typeof(BestBy_did.BetterAddressByReported_address_dt_vendor_last_reported))'',0,100));
    UNSIGNED BetterAddressByReported_address_permit1_cnt := COUNT(GROUP,BestBy_did.address_BetterAddressByReported_data_permits&1<>0);
    REAL8 RecentAddressByReported_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_prim_range=(typeof(BestBy_did.RecentAddressByReported_address_prim_range))'',0,100));
    REAL8 RecentAddressByReported_address_predir_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_predir=(typeof(BestBy_did.RecentAddressByReported_address_predir))'',0,100));
    REAL8 RecentAddressByReported_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_prim_name=(typeof(BestBy_did.RecentAddressByReported_address_prim_name))'',0,100));
    REAL8 RecentAddressByReported_address_suffix_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_suffix=(typeof(BestBy_did.RecentAddressByReported_address_suffix))'',0,100));
    REAL8 RecentAddressByReported_address_postdir_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_postdir=(typeof(BestBy_did.RecentAddressByReported_address_postdir))'',0,100));
    REAL8 RecentAddressByReported_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_unit_desig=(typeof(BestBy_did.RecentAddressByReported_address_unit_desig))'',0,100));
    REAL8 RecentAddressByReported_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_sec_range=(typeof(BestBy_did.RecentAddressByReported_address_sec_range))'',0,100));
    REAL8 RecentAddressByReported_address_city_name_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_city_name=(typeof(BestBy_did.RecentAddressByReported_address_city_name))'',0,100));
    REAL8 RecentAddressByReported_address_st_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_st=(typeof(BestBy_did.RecentAddressByReported_address_st))'',0,100));
    REAL8 RecentAddressByReported_address_zip_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_zip=(typeof(BestBy_did.RecentAddressByReported_address_zip))'',0,100));
    REAL8 RecentAddressByReported_address_zip4_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_zip4=(typeof(BestBy_did.RecentAddressByReported_address_zip4))'',0,100));
    REAL8 RecentAddressByReported_address_tnt_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_tnt=(typeof(BestBy_did.RecentAddressByReported_address_tnt))'',0,100));
    REAL8 RecentAddressByReported_address_rawaid_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_rawaid=(typeof(BestBy_did.RecentAddressByReported_address_rawaid))'',0,100));
    REAL8 RecentAddressByReported_address_dt_first_seen_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_dt_first_seen=(typeof(BestBy_did.RecentAddressByReported_address_dt_first_seen))'',0,100));
    REAL8 RecentAddressByReported_address_dt_last_seen_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_dt_last_seen=(typeof(BestBy_did.RecentAddressByReported_address_dt_last_seen))'',0,100));
    REAL8 RecentAddressByReported_address_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_dt_vendor_first_reported=(typeof(BestBy_did.RecentAddressByReported_address_dt_vendor_first_reported))'',0,100));
    REAL8 RecentAddressByReported_address_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(BestBy_did.RecentAddressByReported_address_dt_vendor_last_reported=(typeof(BestBy_did.RecentAddressByReported_address_dt_vendor_last_reported))'',0,100));
    UNSIGNED RecentAddressByReported_address_permit1_cnt := COUNT(GROUP,BestBy_did.address_RecentAddressByReported_data_permits&1<>0);
    REAL8 CommonestAddress_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_prim_range=(typeof(BestBy_did.CommonestAddress_address_prim_range))'',0,100));
    REAL8 CommonestAddress_address_predir_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_predir=(typeof(BestBy_did.CommonestAddress_address_predir))'',0,100));
    REAL8 CommonestAddress_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_prim_name=(typeof(BestBy_did.CommonestAddress_address_prim_name))'',0,100));
    REAL8 CommonestAddress_address_suffix_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_suffix=(typeof(BestBy_did.CommonestAddress_address_suffix))'',0,100));
    REAL8 CommonestAddress_address_postdir_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_postdir=(typeof(BestBy_did.CommonestAddress_address_postdir))'',0,100));
    REAL8 CommonestAddress_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_unit_desig=(typeof(BestBy_did.CommonestAddress_address_unit_desig))'',0,100));
    REAL8 CommonestAddress_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_sec_range=(typeof(BestBy_did.CommonestAddress_address_sec_range))'',0,100));
    REAL8 CommonestAddress_address_city_name_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_city_name=(typeof(BestBy_did.CommonestAddress_address_city_name))'',0,100));
    REAL8 CommonestAddress_address_st_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_st=(typeof(BestBy_did.CommonestAddress_address_st))'',0,100));
    REAL8 CommonestAddress_address_zip_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_zip=(typeof(BestBy_did.CommonestAddress_address_zip))'',0,100));
    REAL8 CommonestAddress_address_zip4_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_zip4=(typeof(BestBy_did.CommonestAddress_address_zip4))'',0,100));
    REAL8 CommonestAddress_address_tnt_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_tnt=(typeof(BestBy_did.CommonestAddress_address_tnt))'',0,100));
    REAL8 CommonestAddress_address_rawaid_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_rawaid=(typeof(BestBy_did.CommonestAddress_address_rawaid))'',0,100));
    REAL8 CommonestAddress_address_dt_first_seen_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_dt_first_seen=(typeof(BestBy_did.CommonestAddress_address_dt_first_seen))'',0,100));
    REAL8 CommonestAddress_address_dt_last_seen_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_dt_last_seen=(typeof(BestBy_did.CommonestAddress_address_dt_last_seen))'',0,100));
    REAL8 CommonestAddress_address_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_dt_vendor_first_reported=(typeof(BestBy_did.CommonestAddress_address_dt_vendor_first_reported))'',0,100));
    REAL8 CommonestAddress_address_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(BestBy_did.CommonestAddress_address_dt_vendor_last_reported=(typeof(BestBy_did.CommonestAddress_address_dt_vendor_last_reported))'',0,100));
    UNSIGNED CommonestAddress_address_permit1_cnt := COUNT(GROUP,BestBy_did.address_CommonestAddress_data_permits&1<>0);
    REAL8 BestFirstName_fname_pcnt := AVE(GROUP,IF(BestBy_did.BestFirstName_fname=(typeof(BestBy_did.BestFirstName_fname))'',0,100));
    UNSIGNED BestFirstName_fname_permit1_cnt := COUNT(GROUP,BestBy_did.fname_BestFirstName_data_permits&1<>0);
    REAL8 CommonFirstName_fname_pcnt := AVE(GROUP,IF(BestBy_did.CommonFirstName_fname=(typeof(BestBy_did.CommonFirstName_fname))'',0,100));
    UNSIGNED CommonFirstName_fname_permit1_cnt := COUNT(GROUP,BestBy_did.fname_CommonFirstName_data_permits&1<>0);
    REAL8 BestMiddleName_mname_pcnt := AVE(GROUP,IF(BestBy_did.BestMiddleName_mname=(typeof(BestBy_did.BestMiddleName_mname))'',0,100));
    UNSIGNED BestMiddleName_mname_permit1_cnt := COUNT(GROUP,BestBy_did.mname_BestMiddleName_data_permits&1<>0);
    REAL8 CommonMiddleName_mname_pcnt := AVE(GROUP,IF(BestBy_did.CommonMiddleName_mname=(typeof(BestBy_did.CommonMiddleName_mname))'',0,100));
    UNSIGNED CommonMiddleName_mname_permit1_cnt := COUNT(GROUP,BestBy_did.mname_CommonMiddleName_data_permits&1<>0);
    REAL8 CommonLastName_lname_pcnt := AVE(GROUP,IF(BestBy_did.CommonLastName_lname=(typeof(BestBy_did.CommonLastName_lname))'',0,100));
    UNSIGNED CommonLastName_lname_permit1_cnt := COUNT(GROUP,BestBy_did.lname_CommonLastName_data_permits&1<>0);
  END;
  EXPORT BestBy_did_population := TABLE(BestBy_did,R);

  // Take the wide table and turn it into a child-dataset version
  SHARED F_BestBy_did(DATASET({BestBy_did}) d) := FUNCTION
  ssnum_case_layout := RECORD
      TYPEOF(h_bm.ssn) ssnum_ssn;
      TYPEOF(h_bm.valid_ssn) ssnum_valid_ssn;
    UNSIGNED4 ssnum_data_permits;
    UNSIGNED1 ssnum_method; // This value could come from multiple BESTTYPE; track which one
  END;
  dob_case_layout := RECORD
      TYPEOF(h_bm.dob) dob;
    UNSIGNED4 dob_data_permits;
    UNSIGNED1 dob_method; // This value could come from multiple BESTTYPE; track which one
  END;
  address_case_layout := RECORD
      TYPEOF(h_bm.prim_range) address_prim_range;
      TYPEOF(h_bm.predir) address_predir;
      TYPEOF(h_bm.prim_name) address_prim_name;
      TYPEOF(h_bm.suffix) address_suffix;
      TYPEOF(h_bm.postdir) address_postdir;
      TYPEOF(h_bm.unit_desig) address_unit_desig;
      TYPEOF(h_bm.sec_range) address_sec_range;
      TYPEOF(h_bm.city_name) address_city_name;
      TYPEOF(h_bm.st) address_st;
      TYPEOF(h_bm.zip) address_zip;
      TYPEOF(h_bm.zip4) address_zip4;
      TYPEOF(h_bm.tnt) address_tnt;
      TYPEOF(h_bm.rawaid) address_rawaid;
      TYPEOF(h_bm.dt_first_seen) address_dt_first_seen;
      TYPEOF(h_bm.dt_last_seen) address_dt_last_seen;
      TYPEOF(h_bm.dt_vendor_first_reported) address_dt_vendor_first_reported;
      TYPEOF(h_bm.dt_vendor_last_reported) address_dt_vendor_last_reported;
    UNSIGNED4 address_data_permits;
    UNSIGNED1 address_method; // This value could come from multiple BESTTYPE; track which one
  END;
  fname_case_layout := RECORD
      TYPEOF(h_bm.fname) fname;
    UNSIGNED4 fname_data_permits;
    UNSIGNED1 fname_method; // This value could come from multiple BESTTYPE; track which one
  END;
  mname_case_layout := RECORD
      TYPEOF(h_bm.mname) mname;
    UNSIGNED4 mname_data_permits;
    UNSIGNED1 mname_method; // This value could come from multiple BESTTYPE; track which one
  END;
    R := RECORD
      TYPEOF(h_bm.did) did := 0;
      TYPEOF(h_bm.title) title;
    UNSIGNED4 title_data_permits;
      TYPEOF(h_bm.name_suffix) name_suffix;
    UNSIGNED4 name_suffix_data_permits;
    DATASET(ssnum_case_layout) ssnum_cases;
      TYPEOF(h_bm.phone) phone;
    UNSIGNED4 phone_data_permits;
    DATASET(dob_case_layout) dob_cases;
    DATASET(address_case_layout) address_cases;
    DATASET(fname_case_layout) fname_cases;
    DATASET(mname_case_layout) mname_cases;
      TYPEOF(h_bm.lname) lname;
    UNSIGNED4 lname_data_permits;
    END;
    R T(BestBy_did le) := TRANSFORM
      SELF.title := le.BestTitle_title;
      SELF.title_data_permits := le.title_BestTitle_data_permits;
      SELF.name_suffix := le.BestSuffix_name_suffix;
      SELF.name_suffix_data_permits := le.name_suffix_BestSuffix_data_permits;
      SELF.ssnum_cases := DATASET([
        {le.BestSSN_ssnum_ssn,le.BestSSN_ssnum_valid_ssn,le.ssnum_BestSSN_data_permits,1},
        {le.SecondBestSSN_ssnum_ssn,le.SecondBestSSN_ssnum_valid_ssn,le.ssnum_SecondBestSSN_data_permits,2}
          ],ssnum_case_layout)((ssnum_ssn NOT IN SET(s.nulls_ssn,ssn) AND ssnum_ssn <> (TYPEOF(ssnum_ssn))'') OR (ssnum_valid_ssn NOT IN SET(s.nulls_valid_ssn,valid_ssn) AND ssnum_valid_ssn <> (TYPEOF(ssnum_valid_ssn))''));
      SELF.phone := le.BestPhoneCurrentWithNpa_phone;
      SELF.phone_data_permits := le.phone_BestPhoneCurrentWithNpa_data_permits;
      SELF.dob_cases := DATASET([
        {le.BestDOB_dob,le.dob_BestDOB_data_permits,1},
        {le.NoDayDOB_dob,le.dob_NoDayDOB_data_permits,2},
        {le.NoMonthDOB_dob,le.dob_NoMonthDOB_data_permits,3}
          ],dob_case_layout)((dob NOT IN SET(s.nulls_dob,dob) AND dob <> (TYPEOF(dob))''));
      SELF.address_cases := DATASET([
        {le.BestAddress_address_prim_range,le.BestAddress_address_predir,le.BestAddress_address_prim_name,le.BestAddress_address_suffix,le.BestAddress_address_postdir,le.BestAddress_address_unit_desig,le.BestAddress_address_sec_range,le.BestAddress_address_city_name,le.BestAddress_address_st,le.BestAddress_address_zip,le.BestAddress_address_zip4,le.BestAddress_address_tnt,le.BestAddress_address_rawaid,le.BestAddress_address_dt_first_seen,le.BestAddress_address_dt_last_seen,le.BestAddress_address_dt_vendor_first_reported,le.BestAddress_address_dt_vendor_last_reported,le.address_BestAddress_data_permits,1},
        {le.GongAddressBySeen_address_prim_range,le.GongAddressBySeen_address_predir,le.GongAddressBySeen_address_prim_name,le.GongAddressBySeen_address_suffix,le.GongAddressBySeen_address_postdir,le.GongAddressBySeen_address_unit_desig,le.GongAddressBySeen_address_sec_range,le.GongAddressBySeen_address_city_name,le.GongAddressBySeen_address_st,le.GongAddressBySeen_address_zip,le.GongAddressBySeen_address_zip4,le.GongAddressBySeen_address_tnt,le.GongAddressBySeen_address_rawaid,le.GongAddressBySeen_address_dt_first_seen,le.GongAddressBySeen_address_dt_last_seen,le.GongAddressBySeen_address_dt_vendor_first_reported,le.GongAddressBySeen_address_dt_vendor_last_reported,le.address_GongAddressBySeen_data_permits,2},
        {le.BetterAddressBySeen_address_prim_range,le.BetterAddressBySeen_address_predir,le.BetterAddressBySeen_address_prim_name,le.BetterAddressBySeen_address_suffix,le.BetterAddressBySeen_address_postdir,le.BetterAddressBySeen_address_unit_desig,le.BetterAddressBySeen_address_sec_range,le.BetterAddressBySeen_address_city_name,le.BetterAddressBySeen_address_st,le.BetterAddressBySeen_address_zip,le.BetterAddressBySeen_address_zip4,le.BetterAddressBySeen_address_tnt,le.BetterAddressBySeen_address_rawaid,le.BetterAddressBySeen_address_dt_first_seen,le.BetterAddressBySeen_address_dt_last_seen,le.BetterAddressBySeen_address_dt_vendor_first_reported,le.BetterAddressBySeen_address_dt_vendor_last_reported,le.address_BetterAddressBySeen_data_permits,3},
        {le.BetterAddressByReported_address_prim_range,le.BetterAddressByReported_address_predir,le.BetterAddressByReported_address_prim_name,le.BetterAddressByReported_address_suffix,le.BetterAddressByReported_address_postdir,le.BetterAddressByReported_address_unit_desig,le.BetterAddressByReported_address_sec_range,le.BetterAddressByReported_address_city_name,le.BetterAddressByReported_address_st,le.BetterAddressByReported_address_zip,le.BetterAddressByReported_address_zip4,le.BetterAddressByReported_address_tnt,le.BetterAddressByReported_address_rawaid,le.BetterAddressByReported_address_dt_first_seen,le.BetterAddressByReported_address_dt_last_seen,le.BetterAddressByReported_address_dt_vendor_first_reported,le.BetterAddressByReported_address_dt_vendor_last_reported,le.address_BetterAddressByReported_data_permits,4},
        {le.RecentAddressBySeen_address_prim_range,le.RecentAddressBySeen_address_predir,le.RecentAddressBySeen_address_prim_name,le.RecentAddressBySeen_address_suffix,le.RecentAddressBySeen_address_postdir,le.RecentAddressBySeen_address_unit_desig,le.RecentAddressBySeen_address_sec_range,le.RecentAddressBySeen_address_city_name,le.RecentAddressBySeen_address_st,le.RecentAddressBySeen_address_zip,le.RecentAddressBySeen_address_zip4,le.RecentAddressBySeen_address_tnt,le.RecentAddressBySeen_address_rawaid,le.RecentAddressBySeen_address_dt_first_seen,le.RecentAddressBySeen_address_dt_last_seen,le.RecentAddressBySeen_address_dt_vendor_first_reported,le.RecentAddressBySeen_address_dt_vendor_last_reported,le.address_RecentAddressBySeen_data_permits,5},
        {le.RecentAddressByReported_address_prim_range,le.RecentAddressByReported_address_predir,le.RecentAddressByReported_address_prim_name,le.RecentAddressByReported_address_suffix,le.RecentAddressByReported_address_postdir,le.RecentAddressByReported_address_unit_desig,le.RecentAddressByReported_address_sec_range,le.RecentAddressByReported_address_city_name,le.RecentAddressByReported_address_st,le.RecentAddressByReported_address_zip,le.RecentAddressByReported_address_zip4,le.RecentAddressByReported_address_tnt,le.RecentAddressByReported_address_rawaid,le.RecentAddressByReported_address_dt_first_seen,le.RecentAddressByReported_address_dt_last_seen,le.RecentAddressByReported_address_dt_vendor_first_reported,le.RecentAddressByReported_address_dt_vendor_last_reported,le.address_RecentAddressByReported_data_permits,6},
        {le.CommonestAddress_address_prim_range,le.CommonestAddress_address_predir,le.CommonestAddress_address_prim_name,le.CommonestAddress_address_suffix,le.CommonestAddress_address_postdir,le.CommonestAddress_address_unit_desig,le.CommonestAddress_address_sec_range,le.CommonestAddress_address_city_name,le.CommonestAddress_address_st,le.CommonestAddress_address_zip,le.CommonestAddress_address_zip4,le.CommonestAddress_address_tnt,le.CommonestAddress_address_rawaid,le.CommonestAddress_address_dt_first_seen,le.CommonestAddress_address_dt_last_seen,le.CommonestAddress_address_dt_vendor_first_reported,le.CommonestAddress_address_dt_vendor_last_reported,le.address_CommonestAddress_data_permits,7}
          ],address_case_layout)((address_prim_range NOT IN SET(s.nulls_prim_range,prim_range) AND address_prim_range <> (TYPEOF(address_prim_range))'') OR (address_predir NOT IN SET(s.nulls_predir,predir) AND address_predir <> (TYPEOF(address_predir))'') OR (address_prim_name NOT IN SET(s.nulls_prim_name,prim_name) AND address_prim_name <> (TYPEOF(address_prim_name))'') OR (address_suffix NOT IN SET(s.nulls_suffix,suffix) AND address_suffix <> (TYPEOF(address_suffix))'') OR (address_postdir NOT IN SET(s.nulls_postdir,postdir) AND address_postdir <> (TYPEOF(address_postdir))'') OR (address_unit_desig NOT IN SET(s.nulls_unit_desig,unit_desig) AND address_unit_desig <> (TYPEOF(address_unit_desig))'') OR (address_sec_range NOT IN SET(s.nulls_sec_range,sec_range) AND address_sec_range <> (TYPEOF(address_sec_range))'') OR (address_city_name NOT IN SET(s.nulls_city_name,city_name) AND address_city_name <> (TYPEOF(address_city_name))'') OR (address_st NOT IN SET(s.nulls_st,st) AND address_st <> (TYPEOF(address_st))'') OR (address_zip NOT IN SET(s.nulls_zip,zip) AND address_zip <> (TYPEOF(address_zip))'') OR (address_zip4 NOT IN SET(s.nulls_zip4,zip4) AND address_zip4 <> (TYPEOF(address_zip4))'') OR (address_tnt NOT IN SET(s.nulls_tnt,tnt) AND address_tnt <> (TYPEOF(address_tnt))'') OR (address_rawaid NOT IN SET(s.nulls_rawaid,rawaid) AND address_rawaid <> (TYPEOF(address_rawaid))'') OR (address_dt_first_seen NOT IN SET(s.nulls_dt_first_seen,dt_first_seen) AND address_dt_first_seen <> (TYPEOF(address_dt_first_seen))'') OR (address_dt_last_seen NOT IN SET(s.nulls_dt_last_seen,dt_last_seen) AND address_dt_last_seen <> (TYPEOF(address_dt_last_seen))'') OR (address_dt_vendor_first_reported NOT IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) AND address_dt_vendor_first_reported <> (TYPEOF(address_dt_vendor_first_reported))'') OR (address_dt_vendor_last_reported NOT IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) AND address_dt_vendor_last_reported <> (TYPEOF(address_dt_vendor_last_reported))''));
      SELF.fname_cases := DATASET([
        {le.BestFirstName_fname,le.fname_BestFirstName_data_permits,1},
        {le.CommonFirstName_fname,le.fname_CommonFirstName_data_permits,2}
          ],fname_case_layout)((fname NOT IN SET(s.nulls_fname,fname) AND fname <> (TYPEOF(fname))''));
      SELF.mname_cases := DATASET([
        {le.BestMiddleName_mname,le.mname_BestMiddleName_data_permits,1},
        {le.CommonMiddleName_mname,le.mname_CommonMiddleName_data_permits,2}
          ],mname_case_layout)((mname NOT IN SET(s.nulls_mname,mname) AND mname <> (TYPEOF(mname))''));
      SELF.lname := le.CommonLastName_lname;
      SELF.lname_data_permits := le.lname_CommonLastName_data_permits;
      SELF := le; // Copy BASIS
    END;
    P1 := PROJECT(d,T(LEFT));
    RETURN P1;
  END;
  EXPORT BestBy_did_child := F_BestBy_did(BestBy_did);
  EXPORT BestBy_did_child_np := F_BestBy_did(BestBy_did_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
// Additionally apply OWN processing
  SHARED Flatten_BestBy_did(DATASET({BestBy_did_child}) d) := FUNCTION
    R := RECORD
      TYPEOF(h_bm.did) did := 0;
      TYPEOF(h_bm.title) title;
    UNSIGNED4 title_data_permits;
      TYPEOF(h_bm.name_suffix) name_suffix;
    UNSIGNED4 name_suffix_data_permits;
      TYPEOF(h_bm.ssn) ssnum_ssn;
      TYPEOF(h_bm.valid_ssn) ssnum_valid_ssn;
    UNSIGNED4 ssnum_data_permits;
    UNSIGNED1 ssnum_method; // This value could come from multiple BESTTYPE; track which one
      TYPEOF(h_bm.phone) phone;
    UNSIGNED4 phone_data_permits;
      TYPEOF(h_bm.dob) dob;
    UNSIGNED4 dob_data_permits;
    UNSIGNED1 dob_method; // This value could come from multiple BESTTYPE; track which one
      TYPEOF(h_bm.prim_range) address_prim_range;
      TYPEOF(h_bm.predir) address_predir;
      TYPEOF(h_bm.prim_name) address_prim_name;
      TYPEOF(h_bm.suffix) address_suffix;
      TYPEOF(h_bm.postdir) address_postdir;
      TYPEOF(h_bm.unit_desig) address_unit_desig;
      TYPEOF(h_bm.sec_range) address_sec_range;
      TYPEOF(h_bm.city_name) address_city_name;
      TYPEOF(h_bm.st) address_st;
      TYPEOF(h_bm.zip) address_zip;
      TYPEOF(h_bm.zip4) address_zip4;
      TYPEOF(h_bm.tnt) address_tnt;
      TYPEOF(h_bm.rawaid) address_rawaid;
      TYPEOF(h_bm.dt_first_seen) address_dt_first_seen;
      TYPEOF(h_bm.dt_last_seen) address_dt_last_seen;
      TYPEOF(h_bm.dt_vendor_first_reported) address_dt_vendor_first_reported;
      TYPEOF(h_bm.dt_vendor_last_reported) address_dt_vendor_last_reported;
    UNSIGNED4 address_data_permits;
    UNSIGNED1 address_method; // This value could come from multiple BESTTYPE; track which one
      TYPEOF(h_bm.fname) fname;
    UNSIGNED4 fname_data_permits;
    UNSIGNED1 fname_method; // This value could come from multiple BESTTYPE; track which one
      TYPEOF(h_bm.mname) mname;
    UNSIGNED4 mname_data_permits;
    UNSIGNED1 mname_method; // This value could come from multiple BESTTYPE; track which one
      TYPEOF(h_bm.lname) lname;
    UNSIGNED4 lname_data_permits;
    END;
    R T(BestBy_did_child le) := TRANSFORM
    SELF := le.ssnum_cases[1];
    SELF := le.dob_cases[1];
    SELF := le.address_cases[1];
    SELF := le.fname_cases[1];
    SELF := le.mname_cases[1];
      SELF := le; // Copy all non-multi fields
    END;
    P1 := PROJECT(d,T(LEFT));
    RETURN P1;
  END;
  EXPORT BestBy_did_best := Flatten_BestBy_did(BestBy_did_child);
  EXPORT BestBy_did_best_np := Flatten_BestBy_did(BestBy_did_child_np);
  EXPORT Stats := PARALLEL(OUTPUT(BestBy_did_population,NAMED('BestBy_did_Population')));
END;
RETURN M;
ENDMACRO;
