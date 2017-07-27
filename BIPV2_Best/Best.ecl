// Begin code to BEST data for each basis
import SALT24,ut;
EXPORT Best(DATASET(layout_Base) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := Specificities(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
//Create those fields with BestType: BestCompanyNameCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameCommon_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source,data_permits,company_name,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameCommon_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT24.StrType)company_name),source)),{Proxid,source,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCommon_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_name using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyNameCommon_tab_company_name.Proxid;
  BestCompanyNameCommon_tab_company_name.company_name;
  UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyNameCommon_tab_company_name le,BestCompanyNameCommon_tab_company_name ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyNameCommon_tab_company_name,BestCompanyNameCommon_tab_company_name, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_name = (TYPEOF(LEFT.company_name))'' OR RIGHT.company_name = (TYPEOF(RIGHT.company_name))'' OR metaphonelib.DMetaPhone1(LEFT.company_name)=metaphonelib.DMetaPhone1(RIGHT.company_name) OR SALT24.WithinEditN(LEFT.company_name,RIGHT.company_name,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCommon_fuzz_company_name := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestCompanyNameCommon_fuzz_company_name,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestCompanyNameCommon_method_company_name := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestCompanyNameCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameCurrent_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source,data_permits,company_name,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source,data_permits,company_name,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameCurrent_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT24.StrType)company_name),source)),{Proxid,source,data_permits,company_name,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCurrent_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for company_name using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyNameCurrent_tab_company_name.Proxid;
  BestCompanyNameCurrent_tab_company_name.company_name;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyNameCurrent_tab_company_name le,BestCompanyNameCurrent_tab_company_name ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyNameCurrent_tab_company_name,BestCompanyNameCurrent_tab_company_name, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_name = (TYPEOF(LEFT.company_name))'' OR RIGHT.company_name = (TYPEOF(RIGHT.company_name))'' OR metaphonelib.DMetaPhone1(LEFT.company_name)=metaphonelib.DMetaPhone1(RIGHT.company_name) OR SALT24.WithinEditN(LEFT.company_name,RIGHT.company_name,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCurrent_fuzz_company_name := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestCompanyNameCurrent_method_company_name := DEDUP( SORT( BestCompanyNameCurrent_fuzz_company_name(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),Proxid,LOCAL);
//Create those fields with BestType: BestCompanyNameLength
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameLength_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source,data_permits,company_name,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameLength_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT24.StrType)company_name),source)),{Proxid,source,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameLength_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_name using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyNameLength_tab_company_name.Proxid;
  BestCompanyNameLength_tab_company_name.company_name;
  UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyNameLength_tab_company_name le,BestCompanyNameLength_tab_company_name ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyNameLength_tab_company_name,BestCompanyNameLength_tab_company_name, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_name = (TYPEOF(LEFT.company_name))'' OR RIGHT.company_name = (TYPEOF(RIGHT.company_name))'' OR metaphonelib.DMetaPhone1(LEFT.company_name)=metaphonelib.DMetaPhone1(RIGHT.company_name) OR SALT24.WithinEditN(LEFT.company_name,RIGHT.company_name,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameLength_fuzz_company_name := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
EXPORT BestCompanyNameLength_method_company_name := DEDUP( SORT( BestCompanyNameLength_fuzz_company_name,Proxid,-LENGTH(TRIM((SALT24.StrType)company_name)),-Row_Cnt,LOCAL),Proxid,LOCAL);
//Create those fields with BestType: BestCompanyAddressCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressCurrent_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source,data_permits,company_prim_range,company_predir,company_prim_name,company_addr_suffix,company_postdir,company_unit_desig,company_sec_range,company_v_city_name,company_st,company_zip5,company_zip4,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source,data_permits,company_prim_range,company_predir,company_prim_name,company_addr_suffix,company_postdir,company_unit_desig,company_sec_range,company_v_city_name,company_st,company_zip5,company_zip4,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressCurrent_tab_(~((company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND company_predir  IN SET(s.nulls_company_predir,company_predir) AND company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range)) AND (company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND company_st  IN SET(s.nulls_company_st,company_st) AND company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND company_zip4  IN SET(s.nulls_company_zip4,company_zip4))),fn_valid_caddress(TRIM((SALT24.StrType)company_prim_range) + ' ' + TRIM((SALT24.StrType)company_predir) + ' ' + TRIM((SALT24.StrType)company_prim_name) + ' ' + TRIM((SALT24.StrType)company_addr_suffix) + ' ' + TRIM((SALT24.StrType)company_postdir) + ' ' + TRIM((SALT24.StrType)company_unit_desig) + ' ' + TRIM((SALT24.StrType)company_sec_range) + ' ' + TRIM((SALT24.StrType)company_v_city_name) + ' ' + TRIM((SALT24.StrType)company_st) + ' ' + TRIM((SALT24.StrType)company_zip5) + ' ' + TRIM((SALT24.StrType)company_zip4),source)),{Proxid,source,data_permits,company_prim_range,company_predir,company_prim_name,company_addr_suffix,company_postdir,company_unit_desig,company_sec_range,company_v_city_name,company_st,company_zip5,company_zip4,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCurrent_tab_company_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for company_address using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyAddressCurrent_tab_company_address.Proxid;
  BestCompanyAddressCurrent_tab_company_address.company_prim_range;
  BestCompanyAddressCurrent_tab_company_address.company_predir;
  BestCompanyAddressCurrent_tab_company_address.company_prim_name;
  BestCompanyAddressCurrent_tab_company_address.company_addr_suffix;
  BestCompanyAddressCurrent_tab_company_address.company_postdir;
  BestCompanyAddressCurrent_tab_company_address.company_unit_desig;
  BestCompanyAddressCurrent_tab_company_address.company_sec_range;
  BestCompanyAddressCurrent_tab_company_address.company_v_city_name;
  BestCompanyAddressCurrent_tab_company_address.company_st;
  BestCompanyAddressCurrent_tab_company_address.company_zip5;
  BestCompanyAddressCurrent_tab_company_address.company_zip4;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyAddressCurrent_tab_company_address le,BestCompanyAddressCurrent_tab_company_address ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyAddressCurrent_tab_company_address,BestCompanyAddressCurrent_tab_company_address, LEFT.Proxid = RIGHT.Proxid  AND ( ((LEFT.company_prim_range = (TYPEOF(LEFT.company_prim_range))'' OR RIGHT.company_prim_range = (TYPEOF(RIGHT.company_prim_range))'' OR LEFT.company_prim_range = RIGHT.company_prim_range ) AND (LEFT.company_predir = (TYPEOF(LEFT.company_predir))'' OR RIGHT.company_predir = (TYPEOF(RIGHT.company_predir))'' OR LEFT.company_predir = RIGHT.company_predir ) AND (LEFT.company_prim_name = (TYPEOF(LEFT.company_prim_name))'' OR RIGHT.company_prim_name = (TYPEOF(RIGHT.company_prim_name))'' OR LEFT.company_prim_name = RIGHT.company_prim_name ) AND (LEFT.company_addr_suffix = (TYPEOF(LEFT.company_addr_suffix))'' OR RIGHT.company_addr_suffix = (TYPEOF(RIGHT.company_addr_suffix))'' OR LEFT.company_addr_suffix = RIGHT.company_addr_suffix ) AND (LEFT.company_postdir = (TYPEOF(LEFT.company_postdir))'' OR RIGHT.company_postdir = (TYPEOF(RIGHT.company_postdir))'' OR LEFT.company_postdir = RIGHT.company_postdir ) AND (LEFT.company_unit_desig = (TYPEOF(LEFT.company_unit_desig))'' OR RIGHT.company_unit_desig = (TYPEOF(RIGHT.company_unit_desig))'' OR LEFT.company_unit_desig = RIGHT.company_unit_desig ) AND (LEFT.company_sec_range = (TYPEOF(LEFT.company_sec_range))'' OR RIGHT.company_sec_range = (TYPEOF(RIGHT.company_sec_range))'' OR LEFT.company_sec_range = RIGHT.company_sec_range )) AND ((LEFT.company_v_city_name = (TYPEOF(LEFT.company_v_city_name))'' OR RIGHT.company_v_city_name = (TYPEOF(RIGHT.company_v_city_name))'' OR LEFT.company_v_city_name = RIGHT.company_v_city_name ) AND (LEFT.company_st = (TYPEOF(LEFT.company_st))'' OR RIGHT.company_st = (TYPEOF(RIGHT.company_st))'' OR LEFT.company_st = RIGHT.company_st ) AND (LEFT.company_zip5 = (TYPEOF(LEFT.company_zip5))'' OR RIGHT.company_zip5 = (TYPEOF(RIGHT.company_zip5))'' OR LEFT.company_zip5 = RIGHT.company_zip5 ) AND (LEFT.company_zip4 = (TYPEOF(LEFT.company_zip4))'' OR RIGHT.company_zip4 = (TYPEOF(RIGHT.company_zip4))'' OR LEFT.company_zip4 = RIGHT.company_zip4 )) ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCurrent_fuzz_company_address := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestCompanyAddressCurrent_method_company_address := DEDUP( SORT( BestCompanyAddressCurrent_fuzz_company_address(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),Proxid,LOCAL);
//Create those fields with BestType: BestPhoneCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneCurrent_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source,data_permits,company_phone,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source,data_permits,company_phone,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneCurrent_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone(TRIM((SALT24.StrType)company_phone),source)),{Proxid,source,data_permits,company_phone,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCurrent_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestPhoneCurrent_tab_company_phone.Proxid;
  BestPhoneCurrent_tab_company_phone.company_phone;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneCurrent_tab_company_phone le,BestPhoneCurrent_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneCurrent_tab_company_phone,BestPhoneCurrent_tab_company_phone, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT24.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCurrent_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestPhoneCurrent_method_company_phone := DEDUP( SORT( BestPhoneCurrent_fuzz_company_phone(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),Proxid,LOCAL);
//Create those fields with BestType: BestPhoneStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneStrong_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source,data_permits,company_phone,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneStrong_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone(TRIM((SALT24.StrType)company_phone),source)),{Proxid,source,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneStrong_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestPhoneStrong_tab_company_phone.Proxid;
  BestPhoneStrong_tab_company_phone.company_phone;
  UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneStrong_tab_company_phone le,BestPhoneStrong_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneStrong_tab_company_phone,BestPhoneStrong_tab_company_phone, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT24.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneStrong_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestPhoneStrong_fuzz_company_phone,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the Orig_row_cnts.
  Totals := TABLE(grp,{Proxid,Tot := SUM(GROUP,Orig_Row_Cnt)},Proxid);
export BestPhoneStrong_method_company_phone := JOIN( cmn,Totals,left.Proxid = right.Proxid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestFeinStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinStrong_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source,data_permits,company_fein,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinStrong_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT24.StrType)company_fein),source)),{Proxid,source,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinStrong_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestFeinStrong_tab_company_fein.Proxid;
  BestFeinStrong_tab_company_fein.company_fein;
  UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinStrong_tab_company_fein le,BestFeinStrong_tab_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinStrong_tab_company_fein,BestFeinStrong_tab_company_fein, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT24.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinStrong_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestFeinStrong_fuzz_company_fein,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the Orig_row_cnts.
  Totals := TABLE(grp,{Proxid,Tot := SUM(GROUP,Orig_Row_Cnt)},Proxid);
export BestFeinStrong_method_company_fein := JOIN( cmn,Totals,left.Proxid = right.Proxid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestFeinCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinCommon_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source,data_permits,company_fein,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinCommon_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT24.StrType)company_fein),source)),{Proxid,source,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinCommon_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestFeinCommon_tab_company_fein.Proxid;
  BestFeinCommon_tab_company_fein.company_fein;
  UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinCommon_tab_company_fein le,BestFeinCommon_tab_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinCommon_tab_company_fein,BestFeinCommon_tab_company_fein, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT24.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinCommon_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestFeinCommon_fuzz_company_fein,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestFeinCommon_method_company_fein := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestUrlCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlCommon_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source,data_permits,company_url,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source,data_permits,company_url,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlCommon_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT24.StrType)company_url),source)),{Proxid,source,data_permits,company_url,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlCommon_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_url using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestUrlCommon_tab_company_url.Proxid;
  BestUrlCommon_tab_company_url.company_url;
  UNSIGNED4 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestUrlCommon_tab_company_url le,BestUrlCommon_tab_company_url ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestUrlCommon_tab_company_url,BestUrlCommon_tab_company_url, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_url = (TYPEOF(LEFT.company_url))'' OR RIGHT.company_url = (TYPEOF(RIGHT.company_url))'' OR SALT24.WithinEditN(LEFT.company_url,RIGHT.company_url,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlCommon_fuzz_company_url := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestUrlCommon_fuzz_company_url,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestUrlCommon_method_company_url := cmn(Row_Cnt >= 2);
// Start to gather together all records with basis:Proxid,source,data_permits
// 0 - Gathering type:BestCompanyNameCommon Entries:1
  R0 := RECORD
    typeof(BestCompanyNameCommon_method_company_name.Proxid) Proxid; // Need to copy in basis
    typeof(BestCompanyNameCommon_method_company_name.company_name) BestCompanyNameCommon_company_name;
    UNSIGNED company_name_BestCompanyNameCommon_Row_Cnt;
    UNSIGNED company_name_BestCompanyNameCommon_Orig_Row_Cnt;
    UNSIGNED4 company_name_BestCompanyNameCommon_data_permits;
  END;
  R0 T0(BestCompanyNameCommon_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameCommon_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_name_BestCompanyNameCommon_data_permits := ri.data_permits;
    SELF := ri;
  END;
  J0 := PROJECT(BestCompanyNameCommon_method_company_name,T0(left));
// 1 - Gathering type:BestCompanyNameCurrent Entries:1
  R1 := RECORD
    J0; // The data so far
    typeof(BestCompanyNameCurrent_method_company_name.company_name) BestCompanyNameCurrent_company_name;
    UNSIGNED company_name_BestCompanyNameCurrent_Row_Cnt;
    UNSIGNED company_name_BestCompanyNameCurrent_Orig_Row_Cnt;
    UNSIGNED4 company_name_BestCompanyNameCurrent_data_permits;
  END;
  R1 T1(J0 le,BestCompanyNameCurrent_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameCurrent_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_name_BestCompanyNameCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J1 := JOIN(J0,BestCompanyNameCurrent_method_company_name,LEFT.Proxid = RIGHT.Proxid,T1(LEFT,RIGHT),FULL OUTER,LOCAL);
// 2 - Gathering type:BestCompanyNameLength Entries:1
  R2 := RECORD
    J1; // The data so far
    typeof(BestCompanyNameLength_method_company_name.company_name) BestCompanyNameLength_company_name;
    UNSIGNED company_name_BestCompanyNameLength_Row_Cnt;
    UNSIGNED company_name_BestCompanyNameLength_Orig_Row_Cnt;
    UNSIGNED4 company_name_BestCompanyNameLength_data_permits;
  END;
  R2 T2(J1 le,BestCompanyNameLength_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameLength_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameLength_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameLength_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_name_BestCompanyNameLength_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J2 := JOIN(J1,BestCompanyNameLength_method_company_name,LEFT.Proxid = RIGHT.Proxid,T2(LEFT,RIGHT),FULL OUTER,LOCAL);
// 3 - Gathering type:BestCompanyAddressCurrent Entries:1
  R3 := RECORD
    J2; // The data so far
    typeof(BestCompanyAddressCurrent_method_company_address.company_prim_range) BestCompanyAddressCurrent_company_address_company_addr1_company_prim_range;
    typeof(BestCompanyAddressCurrent_method_company_address.company_predir) BestCompanyAddressCurrent_company_address_company_addr1_company_predir;
    typeof(BestCompanyAddressCurrent_method_company_address.company_prim_name) BestCompanyAddressCurrent_company_address_company_addr1_company_prim_name;
    typeof(BestCompanyAddressCurrent_method_company_address.company_addr_suffix) BestCompanyAddressCurrent_company_address_company_addr1_company_addr_suffix;
    typeof(BestCompanyAddressCurrent_method_company_address.company_postdir) BestCompanyAddressCurrent_company_address_company_addr1_company_postdir;
    typeof(BestCompanyAddressCurrent_method_company_address.company_unit_desig) BestCompanyAddressCurrent_company_address_company_addr1_company_unit_desig;
    typeof(BestCompanyAddressCurrent_method_company_address.company_sec_range) BestCompanyAddressCurrent_company_address_company_addr1_company_sec_range;
    typeof(BestCompanyAddressCurrent_method_company_address.company_v_city_name) BestCompanyAddressCurrent_company_address_company_csz_company_v_city_name;
    typeof(BestCompanyAddressCurrent_method_company_address.company_st) BestCompanyAddressCurrent_company_address_company_csz_company_st;
    typeof(BestCompanyAddressCurrent_method_company_address.company_zip5) BestCompanyAddressCurrent_company_address_company_csz_company_zip5;
    typeof(BestCompanyAddressCurrent_method_company_address.company_zip4) BestCompanyAddressCurrent_company_address_company_csz_company_zip4;
    UNSIGNED company_address_BestCompanyAddressCurrent_Row_Cnt;
    UNSIGNED company_address_BestCompanyAddressCurrent_Orig_Row_Cnt;
    UNSIGNED4 company_address_BestCompanyAddressCurrent_data_permits;
  END;
  R3 T3(J2 le,BestCompanyAddressCurrent_method_company_address ri) := TRANSFORM
    SELF.BestCompanyAddressCurrent_company_address_company_addr1_company_prim_range := ri.company_prim_range;
    SELF.BestCompanyAddressCurrent_company_address_company_addr1_company_predir := ri.company_predir;
    SELF.BestCompanyAddressCurrent_company_address_company_addr1_company_prim_name := ri.company_prim_name;
    SELF.BestCompanyAddressCurrent_company_address_company_addr1_company_addr_suffix := ri.company_addr_suffix;
    SELF.BestCompanyAddressCurrent_company_address_company_addr1_company_postdir := ri.company_postdir;
    SELF.BestCompanyAddressCurrent_company_address_company_addr1_company_unit_desig := ri.company_unit_desig;
    SELF.BestCompanyAddressCurrent_company_address_company_addr1_company_sec_range := ri.company_sec_range;
    SELF.BestCompanyAddressCurrent_company_address_company_csz_company_v_city_name := ri.company_v_city_name;
    SELF.BestCompanyAddressCurrent_company_address_company_csz_company_st := ri.company_st;
    SELF.BestCompanyAddressCurrent_company_address_company_csz_company_zip5 := ri.company_zip5;
    SELF.BestCompanyAddressCurrent_company_address_company_csz_company_zip4 := ri.company_zip4;
    SELF.company_address_BestCompanyAddressCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_address_BestCompanyAddressCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_address_BestCompanyAddressCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J3 := JOIN(J2,BestCompanyAddressCurrent_method_company_address,LEFT.Proxid = RIGHT.Proxid,T3(LEFT,RIGHT),FULL OUTER,LOCAL);
// 4 - Gathering type:BestPhoneCurrent Entries:1
  R4 := RECORD
    J3; // The data so far
    typeof(BestPhoneCurrent_method_company_phone.company_phone) BestPhoneCurrent_company_phone;
    UNSIGNED company_phone_BestPhoneCurrent_Row_Cnt;
    UNSIGNED company_phone_BestPhoneCurrent_Orig_Row_Cnt;
    UNSIGNED4 company_phone_BestPhoneCurrent_data_permits;
  END;
  R4 T4(J3 le,BestPhoneCurrent_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneCurrent_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J4 := JOIN(J3,BestPhoneCurrent_method_company_phone,LEFT.Proxid = RIGHT.Proxid,T4(LEFT,RIGHT),FULL OUTER,LOCAL);
// 5 - Gathering type:BestPhoneStrong Entries:1
  R5 := RECORD
    J4; // The data so far
    typeof(BestPhoneStrong_method_company_phone.company_phone) BestPhoneStrong_company_phone;
    UNSIGNED company_phone_BestPhoneStrong_Row_Cnt;
    UNSIGNED company_phone_BestPhoneStrong_Orig_Row_Cnt;
    UNSIGNED4 company_phone_BestPhoneStrong_data_permits;
  END;
  R5 T5(J4 le,BestPhoneStrong_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneStrong_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneStrong_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneStrong_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J5 := JOIN(J4,BestPhoneStrong_method_company_phone,LEFT.Proxid = RIGHT.Proxid,T5(LEFT,RIGHT),FULL OUTER,LOCAL);
// 6 - Gathering type:BestFeinStrong Entries:1
  R6 := RECORD
    J5; // The data so far
    typeof(BestFeinStrong_method_company_fein.company_fein) BestFeinStrong_company_fein;
    UNSIGNED company_fein_BestFeinStrong_Row_Cnt;
    UNSIGNED company_fein_BestFeinStrong_Orig_Row_Cnt;
    UNSIGNED4 company_fein_BestFeinStrong_data_permits;
  END;
  R6 T6(J5 le,BestFeinStrong_method_company_fein ri) := TRANSFORM
    SELF.BestFeinStrong_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinStrong_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinStrong_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J6 := JOIN(J5,BestFeinStrong_method_company_fein,LEFT.Proxid = RIGHT.Proxid,T6(LEFT,RIGHT),FULL OUTER,LOCAL);
// 7 - Gathering type:BestFeinCommon Entries:1
  R7 := RECORD
    J6; // The data so far
    typeof(BestFeinCommon_method_company_fein.company_fein) BestFeinCommon_company_fein;
    UNSIGNED company_fein_BestFeinCommon_Row_Cnt;
    UNSIGNED company_fein_BestFeinCommon_Orig_Row_Cnt;
    UNSIGNED4 company_fein_BestFeinCommon_data_permits;
  END;
  R7 T7(J6 le,BestFeinCommon_method_company_fein ri) := TRANSFORM
    SELF.BestFeinCommon_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J7 := JOIN(J6,BestFeinCommon_method_company_fein,LEFT.Proxid = RIGHT.Proxid,T7(LEFT,RIGHT),FULL OUTER,LOCAL);
// 8 - Gathering type:BestUrlCommon Entries:1
  R8 := RECORD
    J7; // The data so far
    typeof(BestUrlCommon_method_company_url.company_url) BestUrlCommon_company_url;
    UNSIGNED company_url_BestUrlCommon_Row_Cnt;
    UNSIGNED company_url_BestUrlCommon_Orig_Row_Cnt;
    UNSIGNED4 company_url_BestUrlCommon_data_permits;
  END;
  R8 T8(J7 le,BestUrlCommon_method_company_url ri) := TRANSFORM
    SELF.BestUrlCommon_company_url := ri.company_url;
    SELF.company_url_BestUrlCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_url_BestUrlCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J8 := JOIN(J7,BestUrlCommon_method_company_url,LEFT.Proxid = RIGHT.Proxid,T8(LEFT,RIGHT),FULL OUTER,LOCAL);
EXPORT BestBy_Proxid_np := J8;
EXPORT BestBy_Proxid := BestBy_Proxid_np  : PERSIST('temp::Proxid::BIPV2_Best::BestBy_Proxid::best');
// Now gather some statistics to see how we did
  R := RECORD
    NumberOfBasis := COUNT(GROUP);
    REAL8 BestCompanyNameCommon_company_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyNameCommon_company_name=(typeof(BestBy_Proxid.BestCompanyNameCommon_company_name))'',0,100));
    UNSIGNED BestCompanyNameCommon_company_name_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&1<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&2<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&4<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&8<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&16<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit6_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&32<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit7_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&64<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit8_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&128<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit9_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&256<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit10_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&512<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit11_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&1024<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit12_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&2048<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit13_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&4096<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit14_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&8192<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit15_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&16384<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit16_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&32768<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit17_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&65536<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit18_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&131072<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit19_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&262144<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit20_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&524288<>0);
    REAL8 BestCompanyNameCurrent_company_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyNameCurrent_company_name=(typeof(BestBy_Proxid.BestCompanyNameCurrent_company_name))'',0,100));
    UNSIGNED BestCompanyNameCurrent_company_name_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&1<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&2<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&4<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&8<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&16<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit6_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&32<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit7_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&64<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit8_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&128<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit9_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&256<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit10_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&512<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit11_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&1024<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit12_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&2048<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit13_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&4096<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit14_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&8192<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit15_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&16384<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit16_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&32768<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit17_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&65536<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit18_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&131072<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit19_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&262144<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit20_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&524288<>0);
    REAL8 BestCompanyNameLength_company_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyNameLength_company_name=(typeof(BestBy_Proxid.BestCompanyNameLength_company_name))'',0,100));
    UNSIGNED BestCompanyNameLength_company_name_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&1<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&2<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&4<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&8<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&16<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit6_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&32<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit7_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&64<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit8_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&128<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit9_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&256<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit10_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&512<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit11_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&1024<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit12_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&2048<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit13_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&4096<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit14_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&8192<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit15_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&16384<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit16_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&32768<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit17_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&65536<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit18_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&131072<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit19_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&262144<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit20_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&524288<>0);
    REAL8 BestCompanyAddressCurrent_company_address_company_addr1_company_prim_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_prim_range=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_prim_range))'',0,100));
    REAL8 BestCompanyAddressCurrent_company_address_company_addr1_company_predir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_predir=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_predir))'',0,100));
    REAL8 BestCompanyAddressCurrent_company_address_company_addr1_company_prim_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_prim_name=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_prim_name))'',0,100));
    REAL8 BestCompanyAddressCurrent_company_address_company_addr1_company_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_addr_suffix=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressCurrent_company_address_company_addr1_company_postdir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_postdir=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_postdir))'',0,100));
    REAL8 BestCompanyAddressCurrent_company_address_company_addr1_company_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_unit_desig=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_unit_desig))'',0,100));
    REAL8 BestCompanyAddressCurrent_company_address_company_addr1_company_sec_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_sec_range=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_addr1_company_sec_range))'',0,100));
    REAL8 BestCompanyAddressCurrent_company_address_company_csz_company_v_city_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_csz_company_v_city_name=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_csz_company_v_city_name))'',0,100));
    REAL8 BestCompanyAddressCurrent_company_address_company_csz_company_st_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_csz_company_st=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_csz_company_st))'',0,100));
    REAL8 BestCompanyAddressCurrent_company_address_company_csz_company_zip5_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_csz_company_zip5=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_csz_company_zip5))'',0,100));
    REAL8 BestCompanyAddressCurrent_company_address_company_csz_company_zip4_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_csz_company_zip4=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_company_address_company_csz_company_zip4))'',0,100));
    UNSIGNED BestCompanyAddressCurrent_company_address_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&1<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&2<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&4<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&8<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&16<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit6_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&32<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit7_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&64<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit8_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&128<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit9_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&256<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit10_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&512<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit11_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&1024<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit12_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&2048<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit13_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&4096<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit14_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&8192<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit15_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&16384<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit16_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&32768<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit17_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&65536<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit18_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&131072<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit19_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&262144<>0);
    UNSIGNED BestCompanyAddressCurrent_company_address_permit20_cnt := COUNT(GROUP,BestBy_Proxid.company_address_BestCompanyAddressCurrent_data_permits&524288<>0);
    REAL8 BestPhoneCurrent_company_phone_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestPhoneCurrent_company_phone=(typeof(BestBy_Proxid.BestPhoneCurrent_company_phone))'',0,100));
    UNSIGNED BestPhoneCurrent_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&1<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&2<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&4<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&8<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&16<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit6_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&32<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit7_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&64<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit8_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&128<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit9_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&256<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit10_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&512<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit11_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&1024<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit12_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&2048<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit13_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&4096<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit14_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&8192<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit15_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&16384<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit16_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&32768<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit17_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&65536<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit18_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&131072<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit19_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&262144<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit20_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&524288<>0);
    REAL8 BestPhoneStrong_company_phone_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestPhoneStrong_company_phone=(typeof(BestBy_Proxid.BestPhoneStrong_company_phone))'',0,100));
    UNSIGNED BestPhoneStrong_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&1<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&2<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&4<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&8<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&16<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit6_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&32<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit7_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&64<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit8_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&128<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit9_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&256<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit10_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&512<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit11_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&1024<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit12_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&2048<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit13_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&4096<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit14_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&8192<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit15_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&16384<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit16_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&32768<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit17_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&65536<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit18_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&131072<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit19_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&262144<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit20_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&524288<>0);
    REAL8 BestFeinStrong_company_fein_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestFeinStrong_company_fein=(typeof(BestBy_Proxid.BestFeinStrong_company_fein))'',0,100));
    UNSIGNED BestFeinStrong_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&1<>0);
    UNSIGNED BestFeinStrong_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&2<>0);
    UNSIGNED BestFeinStrong_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&4<>0);
    UNSIGNED BestFeinStrong_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&8<>0);
    UNSIGNED BestFeinStrong_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&16<>0);
    UNSIGNED BestFeinStrong_company_fein_permit6_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&32<>0);
    UNSIGNED BestFeinStrong_company_fein_permit7_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&64<>0);
    UNSIGNED BestFeinStrong_company_fein_permit8_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&128<>0);
    UNSIGNED BestFeinStrong_company_fein_permit9_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&256<>0);
    UNSIGNED BestFeinStrong_company_fein_permit10_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&512<>0);
    UNSIGNED BestFeinStrong_company_fein_permit11_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&1024<>0);
    UNSIGNED BestFeinStrong_company_fein_permit12_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&2048<>0);
    UNSIGNED BestFeinStrong_company_fein_permit13_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&4096<>0);
    UNSIGNED BestFeinStrong_company_fein_permit14_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&8192<>0);
    UNSIGNED BestFeinStrong_company_fein_permit15_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&16384<>0);
    UNSIGNED BestFeinStrong_company_fein_permit16_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&32768<>0);
    UNSIGNED BestFeinStrong_company_fein_permit17_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&65536<>0);
    UNSIGNED BestFeinStrong_company_fein_permit18_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&131072<>0);
    UNSIGNED BestFeinStrong_company_fein_permit19_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&262144<>0);
    UNSIGNED BestFeinStrong_company_fein_permit20_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&524288<>0);
    REAL8 BestFeinCommon_company_fein_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestFeinCommon_company_fein=(typeof(BestBy_Proxid.BestFeinCommon_company_fein))'',0,100));
    UNSIGNED BestFeinCommon_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&1<>0);
    UNSIGNED BestFeinCommon_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&2<>0);
    UNSIGNED BestFeinCommon_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&4<>0);
    UNSIGNED BestFeinCommon_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&8<>0);
    UNSIGNED BestFeinCommon_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&16<>0);
    UNSIGNED BestFeinCommon_company_fein_permit6_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&32<>0);
    UNSIGNED BestFeinCommon_company_fein_permit7_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&64<>0);
    UNSIGNED BestFeinCommon_company_fein_permit8_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&128<>0);
    UNSIGNED BestFeinCommon_company_fein_permit9_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&256<>0);
    UNSIGNED BestFeinCommon_company_fein_permit10_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&512<>0);
    UNSIGNED BestFeinCommon_company_fein_permit11_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&1024<>0);
    UNSIGNED BestFeinCommon_company_fein_permit12_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&2048<>0);
    UNSIGNED BestFeinCommon_company_fein_permit13_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&4096<>0);
    UNSIGNED BestFeinCommon_company_fein_permit14_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&8192<>0);
    UNSIGNED BestFeinCommon_company_fein_permit15_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&16384<>0);
    UNSIGNED BestFeinCommon_company_fein_permit16_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&32768<>0);
    UNSIGNED BestFeinCommon_company_fein_permit17_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&65536<>0);
    UNSIGNED BestFeinCommon_company_fein_permit18_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&131072<>0);
    UNSIGNED BestFeinCommon_company_fein_permit19_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&262144<>0);
    UNSIGNED BestFeinCommon_company_fein_permit20_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&524288<>0);
    REAL8 BestUrlCommon_company_url_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestUrlCommon_company_url=(typeof(BestBy_Proxid.BestUrlCommon_company_url))'',0,100));
    UNSIGNED BestUrlCommon_company_url_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&1<>0);
    UNSIGNED BestUrlCommon_company_url_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&2<>0);
    UNSIGNED BestUrlCommon_company_url_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&4<>0);
    UNSIGNED BestUrlCommon_company_url_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&8<>0);
    UNSIGNED BestUrlCommon_company_url_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&16<>0);
    UNSIGNED BestUrlCommon_company_url_permit6_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&32<>0);
    UNSIGNED BestUrlCommon_company_url_permit7_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&64<>0);
    UNSIGNED BestUrlCommon_company_url_permit8_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&128<>0);
    UNSIGNED BestUrlCommon_company_url_permit9_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&256<>0);
    UNSIGNED BestUrlCommon_company_url_permit10_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&512<>0);
    UNSIGNED BestUrlCommon_company_url_permit11_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&1024<>0);
    UNSIGNED BestUrlCommon_company_url_permit12_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&2048<>0);
    UNSIGNED BestUrlCommon_company_url_permit13_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&4096<>0);
    UNSIGNED BestUrlCommon_company_url_permit14_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&8192<>0);
    UNSIGNED BestUrlCommon_company_url_permit15_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&16384<>0);
    UNSIGNED BestUrlCommon_company_url_permit16_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&32768<>0);
    UNSIGNED BestUrlCommon_company_url_permit17_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&65536<>0);
    UNSIGNED BestUrlCommon_company_url_permit18_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&131072<>0);
    UNSIGNED BestUrlCommon_company_url_permit19_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&262144<>0);
    UNSIGNED BestUrlCommon_company_url_permit20_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&524288<>0);
  END;
EXPORT BestBy_Proxid_population := TABLE(BestBy_Proxid,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_Proxid(DATASET({BestBy_Proxid}) d) := FUNCTION
  company_name_case_layout := RECORD
    typeof(h.company_name) company_name;
    UNSIGNED4 company_name_data_permits;
    UNSIGNED1 company_name_method; // This value could come from multiple BESTTYPE; track which one
  END;
  company_phone_case_layout := RECORD
    typeof(h.company_phone) company_phone;
    UNSIGNED4 company_phone_data_permits;
    UNSIGNED1 company_phone_method; // This value could come from multiple BESTTYPE; track which one
  END;
  company_fein_case_layout := RECORD
    typeof(h.company_fein) company_fein;
    UNSIGNED4 company_fein_data_permits;
    UNSIGNED1 company_fein_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED company_fein_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  company_fein_owns := false; // Does this cluster own this value?
  END;
  R := RECORD
    typeof(h.Proxid) Proxid := 0;
    DATASET(company_name_case_layout) company_name_cases;
    typeof(h.company_prim_range) company_address_company_addr1_company_prim_range;
    typeof(h.company_predir) company_address_company_addr1_company_predir;
    typeof(h.company_prim_name) company_address_company_addr1_company_prim_name;
    typeof(h.company_addr_suffix) company_address_company_addr1_company_addr_suffix;
    typeof(h.company_postdir) company_address_company_addr1_company_postdir;
    typeof(h.company_unit_desig) company_address_company_addr1_company_unit_desig;
    typeof(h.company_sec_range) company_address_company_addr1_company_sec_range;
    typeof(h.company_v_city_name) company_address_company_csz_company_v_city_name;
    typeof(h.company_st) company_address_company_csz_company_st;
    typeof(h.company_zip5) company_address_company_csz_company_zip5;
    typeof(h.company_zip4) company_address_company_csz_company_zip4;
    UNSIGNED4 company_address_data_permits;
    DATASET(company_phone_case_layout) company_phone_cases;
    DATASET(company_fein_case_layout) company_fein_cases;
    typeof(h.company_url) company_url;
    UNSIGNED4 company_url_data_permits;
  END;
  R T(BestBy_Proxid le) := TRANSFORM
    SELF.company_name_cases := DATASET([
        {le.BestCompanyNameCommon_company_name,le.company_name_BestCompanyNameCommon_data_permits,1},
        {le.BestCompanyNameCurrent_company_name,le.company_name_BestCompanyNameCurrent_data_permits,2},
        {le.BestCompanyNameLength_company_name,le.company_name_BestCompanyNameLength_data_permits,3}
          ],company_name_case_layout)(company_name NOT IN SET(s.nulls_company_name,company_name));
    SELF.company_address_company_addr1_company_prim_range := le.BestCompanyAddressCurrent_company_address_company_addr1_company_prim_range;
    SELF.company_address_company_addr1_company_predir := le.BestCompanyAddressCurrent_company_address_company_addr1_company_predir;
    SELF.company_address_company_addr1_company_prim_name := le.BestCompanyAddressCurrent_company_address_company_addr1_company_prim_name;
    SELF.company_address_company_addr1_company_addr_suffix := le.BestCompanyAddressCurrent_company_address_company_addr1_company_addr_suffix;
    SELF.company_address_company_addr1_company_postdir := le.BestCompanyAddressCurrent_company_address_company_addr1_company_postdir;
    SELF.company_address_company_addr1_company_unit_desig := le.BestCompanyAddressCurrent_company_address_company_addr1_company_unit_desig;
    SELF.company_address_company_addr1_company_sec_range := le.BestCompanyAddressCurrent_company_address_company_addr1_company_sec_range;
    SELF.company_address_company_csz_company_v_city_name := le.BestCompanyAddressCurrent_company_address_company_csz_company_v_city_name;
    SELF.company_address_company_csz_company_st := le.BestCompanyAddressCurrent_company_address_company_csz_company_st;
    SELF.company_address_company_csz_company_zip5 := le.BestCompanyAddressCurrent_company_address_company_csz_company_zip5;
    SELF.company_address_company_csz_company_zip4 := le.BestCompanyAddressCurrent_company_address_company_csz_company_zip4;
    SELF.company_address_data_permits := le.company_address_BestCompanyAddressCurrent_data_permits;
    SELF.company_phone_cases := DATASET([
        {le.BestPhoneCurrent_company_phone,le.company_phone_BestPhoneCurrent_data_permits,1},
        {le.BestPhoneStrong_company_phone,le.company_phone_BestPhoneStrong_data_permits,2}
          ],company_phone_case_layout)(company_phone NOT IN SET(s.nulls_company_phone,company_phone));
    SELF.company_fein_cases := DATASET([
        {le.BestFeinStrong_company_fein,le.company_fein_BestFeinStrong_data_permits,1,le.company_fein_BestFeinStrong_row_cnt,false},
        {le.BestFeinCommon_company_fein,le.company_fein_BestFeinCommon_data_permits,2,le.company_fein_BestFeinCommon_row_cnt,false}
          ],company_fein_case_layout)(company_fein NOT IN SET(s.nulls_company_fein,company_fein));
    SELF.company_url := le.BestUrlCommon_company_url;
    SELF.company_url_data_permits := le.company_url_BestUrlCommon_data_permits;
    SELF := le; // Copy BASIS
  END;
  P1 := PROJECT(d,T(LEFT));
  RETURN P1;
END;
EXPORT BestBy_Proxid_child := F_BestBy_Proxid(BestBy_Proxid);
EXPORT BestBy_Proxid_child_np := F_BestBy_Proxid(BestBy_Proxid_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
// Additionally apply OWN processing
SHARED Flatten_BestBy_Proxid(DATASET({BestBy_Proxid_child}) d) := FUNCTION
  R := RECORD
    typeof(h.Proxid) Proxid := 0;
    typeof(h.company_name) company_name;
    UNSIGNED4 company_name_data_permits;
    UNSIGNED1 company_name_method; // This value could come from multiple BESTTYPE; track which one
    typeof(h.company_prim_range) company_address_company_addr1_company_prim_range;
    typeof(h.company_predir) company_address_company_addr1_company_predir;
    typeof(h.company_prim_name) company_address_company_addr1_company_prim_name;
    typeof(h.company_addr_suffix) company_address_company_addr1_company_addr_suffix;
    typeof(h.company_postdir) company_address_company_addr1_company_postdir;
    typeof(h.company_unit_desig) company_address_company_addr1_company_unit_desig;
    typeof(h.company_sec_range) company_address_company_addr1_company_sec_range;
    typeof(h.company_v_city_name) company_address_company_csz_company_v_city_name;
    typeof(h.company_st) company_address_company_csz_company_st;
    typeof(h.company_zip5) company_address_company_csz_company_zip5;
    typeof(h.company_zip4) company_address_company_csz_company_zip4;
    UNSIGNED4 company_address_data_permits;
    typeof(h.company_phone) company_phone;
    UNSIGNED4 company_phone_data_permits;
    UNSIGNED1 company_phone_method; // This value could come from multiple BESTTYPE; track which one
    typeof(h.company_fein) company_fein;
    UNSIGNED4 company_fein_data_permits;
    UNSIGNED1 company_fein_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED company_fein_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  company_fein_owns := false; // Does this cluster own this value?
    typeof(h.company_url) company_url;
    UNSIGNED4 company_url_data_permits;
  END;
  R T(BestBy_Proxid_child le) := TRANSFORM
    SELF := le.company_name_cases[1];
    SELF := le.company_phone_cases[1];
    SELF := le.company_fein_cases[1];
    SELF := le; // Copy all non-multi fields
  END;
  P1 := PROJECT(d,T(LEFT));
  OwnCands := SORT( DISTRIBUTE(P1(company_fein_cnt>0),HASH(company_fein)), company_fein, -company_fein_cnt, Proxid,LOCAL);
  PassThru := P1(company_fein_cnt=0);
  TYPEOF(P1) AddOwn(P1 le,P1 ri) := TRANSFORM
    SELF.company_fein_owns := le.company_fein <> ri.company_fein; // The first in line with this value
    SELF := ri;
  END;
  P1_After_company_fein := ITERATE(OwnCands,AddOwn(LEFT,RIGHT),LOCAL) + PassThru;
  RETURN P1_After_company_fein;
END;
EXPORT BestBy_Proxid_best := Flatten_BestBy_Proxid(BestBy_Proxid_child);
EXPORT BestBy_Proxid_best_np := Flatten_BestBy_Proxid(BestBy_Proxid_child_np);
EXPORT Stats := PARALLEL(OUTPUT(BestBy_Proxid_population,NAMED('BestBy_Proxid_Population')));
// Append flags to the regular file
  TYPEOF(ih) NoteFlags(ih le,BestBy_Proxid_Best ri) := TRANSFORM
    SELF.company_name_flag := MAP ( ri.company_name  IN SET(s.nulls_company_name,company_name) => SALT24.Flags.Null,
      le.company_name  IN SET(s.nulls_company_name,company_name) => SALT24.Flags.Missing,
      le.company_name = ri.company_name => SALT24.Flags.Equal,
      le.company_name = (TYPEOF(le.company_name))'' OR ri.company_name = (TYPEOF(ri.company_name))'' OR metaphonelib.DMetaPhone1(le.company_name)=metaphonelib.DMetaPhone1(ri.company_name) OR SALT24.WithinEditN(le.company_name,ri.company_name,1)  => SALT24.Flags.Fuzzy,
      SALT24.Flags.Bad);
    SELF.company_fein_flag := MAP ( ri.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT24.Flags.Null,
      le.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT24.Flags.Missing,
      ri.company_fein_owns => SALT24.Flags.Owns,
      le.company_fein = ri.company_fein => SALT24.Flags.Equal,
      le.company_fein = (TYPEOF(le.company_fein))'' OR ri.company_fein = (TYPEOF(ri.company_fein))'' OR SALT24.WithinEditN(le.company_fein,ri.company_fein,1)  OR fn_Right4(ri.company_fein) = fn_Right4(le.company_fein)  => SALT24.Flags.Fuzzy,
      SALT24.Flags.Bad);
    SELF.company_phone_flag := MAP ( ri.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT24.Flags.Null,
      le.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT24.Flags.Missing,
      le.company_phone = ri.company_phone => SALT24.Flags.Equal,
      le.company_phone = (TYPEOF(le.company_phone))'' OR ri.company_phone = (TYPEOF(ri.company_phone))'' OR SALT24.WithinEditN(le.company_phone,ri.company_phone,1)  => SALT24.Flags.Fuzzy,
      SALT24.Flags.Bad);
    SELF.company_url_flag := MAP ( ri.company_url  IN SET(s.nulls_company_url,company_url) => SALT24.Flags.Null,
      le.company_url  IN SET(s.nulls_company_url,company_url) => SALT24.Flags.Missing,
      le.company_url = ri.company_url => SALT24.Flags.Equal,
      le.company_url = (TYPEOF(le.company_url))'' OR ri.company_url = (TYPEOF(ri.company_url))'' OR SALT24.WithinEditN(le.company_url,ri.company_url,1)  => SALT24.Flags.Fuzzy,
      SALT24.Flags.Bad);
    SELF.company_address_flag := MAP ( ((ri.company_address_company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND ri.company_address_company_predir  IN SET(s.nulls_company_predir,company_predir) AND ri.company_address_company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND ri.company_address_company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND ri.company_address_company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND ri.company_address_company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND ri.company_address_company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range)) AND (ri.company_address_company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND ri.company_address_company_st  IN SET(s.nulls_company_st,company_st) AND ri.company_address_company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND ri.company_address_company_zip4  IN SET(s.nulls_company_zip4,company_zip4))) => SALT24.Flags.Null,
      ((le.company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND le.company_predir  IN SET(s.nulls_company_predir,company_predir) AND le.company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND le.company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND le.company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND le.company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND le.company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range)) AND (le.company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND le.company_st  IN SET(s.nulls_company_st,company_st) AND le.company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND le.company_zip4  IN SET(s.nulls_company_zip4,company_zip4))) => SALT24.Flags.Missing,
      ((le.company_prim_range = ri.company_address_company_prim_range) AND (le.company_predir = ri.company_address_company_predir) AND (le.company_prim_name = ri.company_address_company_prim_name) AND (le.company_addr_suffix = ri.company_address_company_addr_suffix) AND (le.company_postdir = ri.company_address_company_postdir) AND (le.company_unit_desig = ri.company_address_company_unit_desig) AND (le.company_sec_range = ri.company_address_company_sec_range)) AND ((le.company_v_city_name = ri.company_address_company_v_city_name) AND (le.company_st = ri.company_address_company_st) AND (le.company_zip5 = ri.company_address_company_zip5) AND (le.company_zip4 = ri.company_address_company_zip4)) => SALT24.Flags.Equal,
      ((le.company_prim_range = (TYPEOF(le.company_prim_range))'' OR ri.company_address_company_prim_range = (TYPEOF(ri.company_address_company_prim_range))'' OR le.company_prim_range = ri.company_address_company_prim_range ) AND (le.company_predir = (TYPEOF(le.company_predir))'' OR ri.company_address_company_predir = (TYPEOF(ri.company_address_company_predir))'' OR le.company_predir = ri.company_address_company_predir ) AND (le.company_prim_name = (TYPEOF(le.company_prim_name))'' OR ri.company_address_company_prim_name = (TYPEOF(ri.company_address_company_prim_name))'' OR le.company_prim_name = ri.company_address_company_prim_name ) AND (le.company_addr_suffix = (TYPEOF(le.company_addr_suffix))'' OR ri.company_address_company_addr_suffix = (TYPEOF(ri.company_address_company_addr_suffix))'' OR le.company_addr_suffix = ri.company_address_company_addr_suffix ) AND (le.company_postdir = (TYPEOF(le.company_postdir))'' OR ri.company_address_company_postdir = (TYPEOF(ri.company_address_company_postdir))'' OR le.company_postdir = ri.company_address_company_postdir ) AND (le.company_unit_desig = (TYPEOF(le.company_unit_desig))'' OR ri.company_address_company_unit_desig = (TYPEOF(ri.company_address_company_unit_desig))'' OR le.company_unit_desig = ri.company_address_company_unit_desig ) AND (le.company_sec_range = (TYPEOF(le.company_sec_range))'' OR ri.company_address_company_sec_range = (TYPEOF(ri.company_address_company_sec_range))'' OR le.company_sec_range = ri.company_address_company_sec_range )) AND ((le.company_v_city_name = (TYPEOF(le.company_v_city_name))'' OR ri.company_address_company_v_city_name = (TYPEOF(ri.company_address_company_v_city_name))'' OR le.company_v_city_name = ri.company_address_company_v_city_name ) AND (le.company_st = (TYPEOF(le.company_st))'' OR ri.company_address_company_st = (TYPEOF(ri.company_address_company_st))'' OR le.company_st = ri.company_address_company_st ) AND (le.company_zip5 = (TYPEOF(le.company_zip5))'' OR ri.company_address_company_zip5 = (TYPEOF(ri.company_address_company_zip5))'' OR le.company_zip5 = ri.company_address_company_zip5 ) AND (le.company_zip4 = (TYPEOF(le.company_zip4))'' OR ri.company_address_company_zip4 = (TYPEOF(ri.company_address_company_zip4))'' OR le.company_zip4 = ri.company_address_company_zip4 )) => SALT24.Flags.Fuzzy,
      SALT24.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(ih,BestBy_Proxid_Best,LEFT.Proxid=RIGHT.Proxid,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
EXPORT In_Flagged := j;
  FlagTots := RECORD
    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 company_name_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT24.Flags.Null,100,0));
    REAL4 company_name_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT24.Flags.Equal,100,0));
    REAL4 company_name_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT24.Flags.Fuzzy,100,0));
    REAL4 company_name_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT24.Flags.Bad,100,0));
    REAL4 company_name_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT24.Flags.Missing,100,0));
    REAL4 company_fein_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Null,100,0));
    REAL4 company_fein_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Equal,100,0));
    REAL4 company_fein_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Fuzzy,100,0));
    REAL4 company_fein_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Bad,100,0));
    REAL4 company_fein_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Missing,100,0));
    REAL4 company_fein_Owns_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Owns,100,0));
    REAL4 company_phone_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT24.Flags.Null,100,0));
    REAL4 company_phone_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT24.Flags.Equal,100,0));
    REAL4 company_phone_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT24.Flags.Fuzzy,100,0));
    REAL4 company_phone_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT24.Flags.Bad,100,0));
    REAL4 company_phone_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT24.Flags.Missing,100,0));
    REAL4 company_url_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT24.Flags.Null,100,0));
    REAL4 company_url_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT24.Flags.Equal,100,0));
    REAL4 company_url_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT24.Flags.Fuzzy,100,0));
    REAL4 company_url_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT24.Flags.Bad,100,0));
    REAL4 company_url_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT24.Flags.Missing,100,0));
    REAL4 company_address_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_address_Flag = SALT24.Flags.Null,100,0));
    REAL4 company_address_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_address_Flag = SALT24.Flags.Equal,100,0));
    REAL4 company_address_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_address_Flag = SALT24.Flags.Fuzzy,100,0));
    REAL4 company_address_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_address_Flag = SALT24.Flags.Bad,100,0));
    REAL4 company_address_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_address_Flag = SALT24.Flags.Missing,100,0));
  END;
EXPORT In_Flagged_Summary := TABLE(In_Flagged,FlagTots); // Global summary
  FlagTots := RECORD
    In_Flagged.source; // Group by sourcefield    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 company_name_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT24.Flags.Null,100,0));
    REAL4 company_name_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT24.Flags.Equal,100,0));
    REAL4 company_name_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT24.Flags.Fuzzy,100,0));
    REAL4 company_name_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT24.Flags.Bad,100,0));
    REAL4 company_name_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT24.Flags.Missing,100,0));
    REAL4 company_fein_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Null,100,0));
    REAL4 company_fein_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Equal,100,0));
    REAL4 company_fein_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Fuzzy,100,0));
    REAL4 company_fein_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Bad,100,0));
    REAL4 company_fein_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Missing,100,0));
    REAL4 company_fein_Owns_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT24.Flags.Owns,100,0));
    REAL4 company_phone_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT24.Flags.Null,100,0));
    REAL4 company_phone_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT24.Flags.Equal,100,0));
    REAL4 company_phone_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT24.Flags.Fuzzy,100,0));
    REAL4 company_phone_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT24.Flags.Bad,100,0));
    REAL4 company_phone_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT24.Flags.Missing,100,0));
    REAL4 company_url_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT24.Flags.Null,100,0));
    REAL4 company_url_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT24.Flags.Equal,100,0));
    REAL4 company_url_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT24.Flags.Fuzzy,100,0));
    REAL4 company_url_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT24.Flags.Bad,100,0));
    REAL4 company_url_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT24.Flags.Missing,100,0));
    REAL4 company_address_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_address_Flag = SALT24.Flags.Null,100,0));
    REAL4 company_address_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_address_Flag = SALT24.Flags.Equal,100,0));
    REAL4 company_address_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_address_Flag = SALT24.Flags.Fuzzy,100,0));
    REAL4 company_address_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_address_Flag = SALT24.Flags.Bad,100,0));
    REAL4 company_address_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_address_Flag = SALT24.Flags.Missing,100,0));
  END;
EXPORT In_Flagged_Summary_BySrc := TABLE(In_Flagged,FlagTots,source,FEW);
// Append flags to the input file
  TYPEOF(h) NoteFlags(h le,BestBy_Proxid_Best ri) := TRANSFORM
    SELF.company_name_flag := MAP ( ri.company_name  IN SET(s.nulls_company_name,company_name) => SALT24.Flags.Null,
      le.company_name  IN SET(s.nulls_company_name,company_name) => SALT24.Flags.Missing,
      le.company_name = ri.company_name => SALT24.Flags.Equal,
      le.company_name = (TYPEOF(le.company_name))'' OR ri.company_name = (TYPEOF(ri.company_name))'' OR metaphonelib.DMetaPhone1(le.company_name)=metaphonelib.DMetaPhone1(ri.company_name) OR SALT24.WithinEditN(le.company_name,ri.company_name,1)  => SALT24.Flags.Fuzzy,
      SALT24.Flags.Bad);
    SELF.company_fein_flag := MAP ( ri.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT24.Flags.Null,
      le.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT24.Flags.Missing,
      ri.company_fein_owns => SALT24.Flags.Owns,
      le.company_fein = ri.company_fein => SALT24.Flags.Equal,
      le.company_fein = (TYPEOF(le.company_fein))'' OR ri.company_fein = (TYPEOF(ri.company_fein))'' OR SALT24.WithinEditN(le.company_fein,ri.company_fein,1)  OR fn_Right4(ri.company_fein) = fn_Right4(le.company_fein)  => SALT24.Flags.Fuzzy,
      SALT24.Flags.Bad);
    SELF.company_phone_flag := MAP ( ri.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT24.Flags.Null,
      le.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT24.Flags.Missing,
      le.company_phone = ri.company_phone => SALT24.Flags.Equal,
      le.company_phone = (TYPEOF(le.company_phone))'' OR ri.company_phone = (TYPEOF(ri.company_phone))'' OR SALT24.WithinEditN(le.company_phone,ri.company_phone,1)  => SALT24.Flags.Fuzzy,
      SALT24.Flags.Bad);
    SELF.company_url_flag := MAP ( ri.company_url  IN SET(s.nulls_company_url,company_url) => SALT24.Flags.Null,
      le.company_url  IN SET(s.nulls_company_url,company_url) => SALT24.Flags.Missing,
      le.company_url = ri.company_url => SALT24.Flags.Equal,
      le.company_url = (TYPEOF(le.company_url))'' OR ri.company_url = (TYPEOF(ri.company_url))'' OR SALT24.WithinEditN(le.company_url,ri.company_url,1)  => SALT24.Flags.Fuzzy,
      SALT24.Flags.Bad);
    SELF.company_address_flag := MAP ( ((ri.company_address_company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND ri.company_address_company_predir  IN SET(s.nulls_company_predir,company_predir) AND ri.company_address_company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND ri.company_address_company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND ri.company_address_company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND ri.company_address_company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND ri.company_address_company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range)) AND (ri.company_address_company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND ri.company_address_company_st  IN SET(s.nulls_company_st,company_st) AND ri.company_address_company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND ri.company_address_company_zip4  IN SET(s.nulls_company_zip4,company_zip4))) => SALT24.Flags.Null,
      ((le.company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND le.company_predir  IN SET(s.nulls_company_predir,company_predir) AND le.company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND le.company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND le.company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND le.company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND le.company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range)) AND (le.company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND le.company_st  IN SET(s.nulls_company_st,company_st) AND le.company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND le.company_zip4  IN SET(s.nulls_company_zip4,company_zip4))) => SALT24.Flags.Missing,
      ((le.company_prim_range = ri.company_address_company_prim_range) AND (le.company_predir = ri.company_address_company_predir) AND (le.company_prim_name = ri.company_address_company_prim_name) AND (le.company_addr_suffix = ri.company_address_company_addr_suffix) AND (le.company_postdir = ri.company_address_company_postdir) AND (le.company_unit_desig = ri.company_address_company_unit_desig) AND (le.company_sec_range = ri.company_address_company_sec_range)) AND ((le.company_v_city_name = ri.company_address_company_v_city_name) AND (le.company_st = ri.company_address_company_st) AND (le.company_zip5 = ri.company_address_company_zip5) AND (le.company_zip4 = ri.company_address_company_zip4)) => SALT24.Flags.Equal,
      ((le.company_prim_range = (TYPEOF(le.company_prim_range))'' OR ri.company_address_company_prim_range = (TYPEOF(ri.company_address_company_prim_range))'' OR le.company_prim_range = ri.company_address_company_prim_range ) AND (le.company_predir = (TYPEOF(le.company_predir))'' OR ri.company_address_company_predir = (TYPEOF(ri.company_address_company_predir))'' OR le.company_predir = ri.company_address_company_predir ) AND (le.company_prim_name = (TYPEOF(le.company_prim_name))'' OR ri.company_address_company_prim_name = (TYPEOF(ri.company_address_company_prim_name))'' OR le.company_prim_name = ri.company_address_company_prim_name ) AND (le.company_addr_suffix = (TYPEOF(le.company_addr_suffix))'' OR ri.company_address_company_addr_suffix = (TYPEOF(ri.company_address_company_addr_suffix))'' OR le.company_addr_suffix = ri.company_address_company_addr_suffix ) AND (le.company_postdir = (TYPEOF(le.company_postdir))'' OR ri.company_address_company_postdir = (TYPEOF(ri.company_address_company_postdir))'' OR le.company_postdir = ri.company_address_company_postdir ) AND (le.company_unit_desig = (TYPEOF(le.company_unit_desig))'' OR ri.company_address_company_unit_desig = (TYPEOF(ri.company_address_company_unit_desig))'' OR le.company_unit_desig = ri.company_address_company_unit_desig ) AND (le.company_sec_range = (TYPEOF(le.company_sec_range))'' OR ri.company_address_company_sec_range = (TYPEOF(ri.company_address_company_sec_range))'' OR le.company_sec_range = ri.company_address_company_sec_range )) AND ((le.company_v_city_name = (TYPEOF(le.company_v_city_name))'' OR ri.company_address_company_v_city_name = (TYPEOF(ri.company_address_company_v_city_name))'' OR le.company_v_city_name = ri.company_address_company_v_city_name ) AND (le.company_st = (TYPEOF(le.company_st))'' OR ri.company_address_company_st = (TYPEOF(ri.company_address_company_st))'' OR le.company_st = ri.company_address_company_st ) AND (le.company_zip5 = (TYPEOF(le.company_zip5))'' OR ri.company_address_company_zip5 = (TYPEOF(ri.company_address_company_zip5))'' OR le.company_zip5 = ri.company_address_company_zip5 ) AND (le.company_zip4 = (TYPEOF(le.company_zip4))'' OR ri.company_address_company_zip4 = (TYPEOF(ri.company_address_company_zip4))'' OR le.company_zip4 = ri.company_address_company_zip4 )) => SALT24.Flags.Fuzzy,
      SALT24.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(h,BestBy_Proxid_Best,LEFT.Proxid=RIGHT.Proxid,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
EXPORT Input_Flagged := j;
END;
