IMPORT SALT311,STD;
IMPORT Scrubs_IDA,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 105;
  EXPORT NumRulesFromFieldType := 105;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 64;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_IDA)
    UNSIGNED1 persistent_record_id_Invalid;
    UNSIGNED1 src_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 orig_first_name_Invalid;
    UNSIGNED1 orig_middle_name_Invalid;
    UNSIGNED1 orig_last_name_Invalid;
    UNSIGNED1 orig_suffix_Invalid;
    UNSIGNED1 orig_address1_Invalid;
    UNSIGNED1 orig_address2_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_province_Invalid;
    UNSIGNED1 orig_zip4_Invalid;
    UNSIGNED1 orig_zip5_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_ssn_Invalid;
    UNSIGNED1 orig_dl_Invalid;
    UNSIGNED1 orig_dlstate_Invalid;
    UNSIGNED1 orig_phone_Invalid;
    UNSIGNED1 clientassigneduniquerecordid_Invalid;
    UNSIGNED1 adl_ind_Invalid;
    UNSIGNED1 orig_email_Invalid;
    UNSIGNED1 orig_ipaddress_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 nid_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
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
    UNSIGNED1 fips_st_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 rawaid_Invalid;
    UNSIGNED1 aceaid_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 clean_dob_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_IDA)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
  EXPORT Rule_Layout := RECORD(Base_Layout_IDA)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'persistent_record_id:Invalid_Rec_ID:ALLOW','persistent_record_id:Invalid_Rec_ID:LENGTHS'
          ,'src:Invalid_Alpha:ALLOW'
          ,'dt_first_seen:Invalid_Date:CUSTOM'
          ,'dt_last_seen:Invalid_Date:CUSTOM'
          ,'dt_vendor_first_reported:Invalid_Date:CUSTOM'
          ,'dt_vendor_last_reported:Invalid_Date:CUSTOM'
          ,'did:Invalid_Num:ALLOW'
          ,'did_score:Invalid_Num:ALLOW'
          ,'orig_first_name:Invalid_FName:ALLOW','orig_first_name:Invalid_FName:LENGTHS','orig_first_name:Invalid_FName:WORDS'
          ,'orig_middle_name:Invalid_MName:ALLOW','orig_middle_name:Invalid_MName:LENGTHS','orig_middle_name:Invalid_MName:WORDS'
          ,'orig_last_name:Invalid_LName:ALLOW','orig_last_name:Invalid_LName:LENGTHS','orig_last_name:Invalid_LName:WORDS'
          ,'orig_suffix:Invalid_Suffix:ALLOW','orig_suffix:Invalid_Suffix:LENGTHS','orig_suffix:Invalid_Suffix:WORDS'
          ,'orig_address1:Invalid_Address1:ALLOW','orig_address1:Invalid_Address1:WORDS'
          ,'orig_address2:Invalid_Address2:ALLOW','orig_address2:Invalid_Address2:WORDS'
          ,'orig_city:Invalid_City:ALLOW','orig_city:Invalid_City:WORDS'
          ,'orig_state_province:Invalid_State:CUSTOM'
          ,'orig_zip4:Invalid_Zip:ALLOW','orig_zip4:Invalid_Zip:LENGTHS'
          ,'orig_zip5:Invalid_Zip:ALLOW','orig_zip5:Invalid_Zip:LENGTHS'
          ,'orig_dob:Invalid_Date:CUSTOM'
          ,'orig_ssn:Invalid_SSN:ALLOW','orig_ssn:Invalid_SSN:LENGTHS'
          ,'orig_dl:Invalid_DL:CUSTOM'
          ,'orig_dlstate:Invalid_State:CUSTOM'
          ,'orig_phone:Invalid_Phone:ALLOW','orig_phone:Invalid_Phone:LENGTHS'
          ,'clientassigneduniquerecordid:Invalid_Clientassigneduniquerecordid:ALLOW','clientassigneduniquerecordid:Invalid_Clientassigneduniquerecordid:LENGTHS'
          ,'adl_ind:Invalid_Alpha:ALLOW'
          ,'orig_email:Invalid_Emailaddress:CUSTOM'
          ,'orig_ipaddress:Invalid_Ipaddress:CUSTOM'
          ,'title:Invalid_Title:ALLOW','title:Invalid_Title:LENGTHS','title:Invalid_Title:WORDS'
          ,'fname:Invalid_FName:ALLOW','fname:Invalid_FName:LENGTHS','fname:Invalid_FName:WORDS'
          ,'mname:Invalid_MName:ALLOW','mname:Invalid_MName:LENGTHS','mname:Invalid_MName:WORDS'
          ,'lname:Invalid_LName:ALLOW','lname:Invalid_LName:LENGTHS','lname:Invalid_LName:WORDS'
          ,'name_suffix:Invalid_Suffix:ALLOW','name_suffix:Invalid_Suffix:LENGTHS','name_suffix:Invalid_Suffix:WORDS'
          ,'nid:Invalid_NID:ALLOW','nid:Invalid_NID:LENGTHS'
          ,'prim_range:Invalid_Num:ALLOW'
          ,'predir:Invalid_Dir:ALLOW','predir:Invalid_Dir:LENGTHS'
          ,'prim_name:Invalid_Add:ALLOW','prim_name:Invalid_Add:WORDS'
          ,'addr_suffix:Invalid_Add_Suff:ALLOW','addr_suffix:Invalid_Add_Suff:LENGTHS'
          ,'postdir:Invalid_Dir:ALLOW','postdir:Invalid_Dir:LENGTHS'
          ,'unit_desig:Invalid_Add_Suff:ALLOW','unit_desig:Invalid_Add_Suff:LENGTHS'
          ,'sec_range:Invalid_Num:ALLOW'
          ,'p_city_name:Invalid_City:ALLOW','p_city_name:Invalid_City:WORDS'
          ,'v_city_name:Invalid_City:ALLOW','v_city_name:Invalid_City:WORDS'
          ,'st:Invalid_State:CUSTOM'
          ,'zip:Invalid_Zip:ALLOW','zip:Invalid_Zip:LENGTHS'
          ,'zip4:Invalid_Zip4:ALLOW','zip4:Invalid_Zip4:LENGTHS'
          ,'cart:Invalid_AlphaNum:ALLOW'
          ,'cr_sort_sz:Invalid_Alpha:ALLOW'
          ,'lot:Invalid_Num:ALLOW'
          ,'lot_order:Invalid_Alpha:ALLOW'
          ,'dbpc:Invalid_Num:ALLOW'
          ,'chk_digit:Invalid_Num:ALLOW'
          ,'rec_type:Invalid_Alpha:ALLOW'
          ,'fips_st:Invalid_Num:ALLOW'
          ,'fips_county:Invalid_Num:ALLOW'
          ,'geo_lat:Invalid_Coor:CUSTOM'
          ,'geo_long:Invalid_Coor:CUSTOM'
          ,'msa:Invalid_Num:ALLOW'
          ,'geo_blk:Invalid_Num:ALLOW'
          ,'geo_match:Invalid_Num:ALLOW'
          ,'err_stat:Invalid_Err:ALLOW','err_stat:Invalid_Err:LENGTHS'
          ,'rawaid:Invalid_AID:ALLOW','rawaid:Invalid_AID:LENGTHS'
          ,'aceaid:Invalid_AID:ALLOW','aceaid:Invalid_AID:LENGTHS'
          ,'clean_phone:Invalid_Phone:ALLOW','clean_phone:Invalid_Phone:LENGTHS'
          ,'clean_dob:Invalid_Date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Base_Fields.InvalidMessage_persistent_record_id(1),Base_Fields.InvalidMessage_persistent_record_id(2)
          ,Base_Fields.InvalidMessage_src(1)
          ,Base_Fields.InvalidMessage_dt_first_seen(1)
          ,Base_Fields.InvalidMessage_dt_last_seen(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_did(1)
          ,Base_Fields.InvalidMessage_did_score(1)
          ,Base_Fields.InvalidMessage_orig_first_name(1),Base_Fields.InvalidMessage_orig_first_name(2),Base_Fields.InvalidMessage_orig_first_name(3)
          ,Base_Fields.InvalidMessage_orig_middle_name(1),Base_Fields.InvalidMessage_orig_middle_name(2),Base_Fields.InvalidMessage_orig_middle_name(3)
          ,Base_Fields.InvalidMessage_orig_last_name(1),Base_Fields.InvalidMessage_orig_last_name(2),Base_Fields.InvalidMessage_orig_last_name(3)
          ,Base_Fields.InvalidMessage_orig_suffix(1),Base_Fields.InvalidMessage_orig_suffix(2),Base_Fields.InvalidMessage_orig_suffix(3)
          ,Base_Fields.InvalidMessage_orig_address1(1),Base_Fields.InvalidMessage_orig_address1(2)
          ,Base_Fields.InvalidMessage_orig_address2(1),Base_Fields.InvalidMessage_orig_address2(2)
          ,Base_Fields.InvalidMessage_orig_city(1),Base_Fields.InvalidMessage_orig_city(2)
          ,Base_Fields.InvalidMessage_orig_state_province(1)
          ,Base_Fields.InvalidMessage_orig_zip4(1),Base_Fields.InvalidMessage_orig_zip4(2)
          ,Base_Fields.InvalidMessage_orig_zip5(1),Base_Fields.InvalidMessage_orig_zip5(2)
          ,Base_Fields.InvalidMessage_orig_dob(1)
          ,Base_Fields.InvalidMessage_orig_ssn(1),Base_Fields.InvalidMessage_orig_ssn(2)
          ,Base_Fields.InvalidMessage_orig_dl(1)
          ,Base_Fields.InvalidMessage_orig_dlstate(1)
          ,Base_Fields.InvalidMessage_orig_phone(1),Base_Fields.InvalidMessage_orig_phone(2)
          ,Base_Fields.InvalidMessage_clientassigneduniquerecordid(1),Base_Fields.InvalidMessage_clientassigneduniquerecordid(2)
          ,Base_Fields.InvalidMessage_adl_ind(1)
          ,Base_Fields.InvalidMessage_orig_email(1)
          ,Base_Fields.InvalidMessage_orig_ipaddress(1)
          ,Base_Fields.InvalidMessage_title(1),Base_Fields.InvalidMessage_title(2),Base_Fields.InvalidMessage_title(3)
          ,Base_Fields.InvalidMessage_fname(1),Base_Fields.InvalidMessage_fname(2),Base_Fields.InvalidMessage_fname(3)
          ,Base_Fields.InvalidMessage_mname(1),Base_Fields.InvalidMessage_mname(2),Base_Fields.InvalidMessage_mname(3)
          ,Base_Fields.InvalidMessage_lname(1),Base_Fields.InvalidMessage_lname(2),Base_Fields.InvalidMessage_lname(3)
          ,Base_Fields.InvalidMessage_name_suffix(1),Base_Fields.InvalidMessage_name_suffix(2),Base_Fields.InvalidMessage_name_suffix(3)
          ,Base_Fields.InvalidMessage_nid(1),Base_Fields.InvalidMessage_nid(2)
          ,Base_Fields.InvalidMessage_prim_range(1)
          ,Base_Fields.InvalidMessage_predir(1),Base_Fields.InvalidMessage_predir(2)
          ,Base_Fields.InvalidMessage_prim_name(1),Base_Fields.InvalidMessage_prim_name(2)
          ,Base_Fields.InvalidMessage_addr_suffix(1),Base_Fields.InvalidMessage_addr_suffix(2)
          ,Base_Fields.InvalidMessage_postdir(1),Base_Fields.InvalidMessage_postdir(2)
          ,Base_Fields.InvalidMessage_unit_desig(1),Base_Fields.InvalidMessage_unit_desig(2)
          ,Base_Fields.InvalidMessage_sec_range(1)
          ,Base_Fields.InvalidMessage_p_city_name(1),Base_Fields.InvalidMessage_p_city_name(2)
          ,Base_Fields.InvalidMessage_v_city_name(1),Base_Fields.InvalidMessage_v_city_name(2)
          ,Base_Fields.InvalidMessage_st(1)
          ,Base_Fields.InvalidMessage_zip(1),Base_Fields.InvalidMessage_zip(2)
          ,Base_Fields.InvalidMessage_zip4(1),Base_Fields.InvalidMessage_zip4(2)
          ,Base_Fields.InvalidMessage_cart(1)
          ,Base_Fields.InvalidMessage_cr_sort_sz(1)
          ,Base_Fields.InvalidMessage_lot(1)
          ,Base_Fields.InvalidMessage_lot_order(1)
          ,Base_Fields.InvalidMessage_dbpc(1)
          ,Base_Fields.InvalidMessage_chk_digit(1)
          ,Base_Fields.InvalidMessage_rec_type(1)
          ,Base_Fields.InvalidMessage_fips_st(1)
          ,Base_Fields.InvalidMessage_fips_county(1)
          ,Base_Fields.InvalidMessage_geo_lat(1)
          ,Base_Fields.InvalidMessage_geo_long(1)
          ,Base_Fields.InvalidMessage_msa(1)
          ,Base_Fields.InvalidMessage_geo_blk(1)
          ,Base_Fields.InvalidMessage_geo_match(1)
          ,Base_Fields.InvalidMessage_err_stat(1),Base_Fields.InvalidMessage_err_stat(2)
          ,Base_Fields.InvalidMessage_rawaid(1),Base_Fields.InvalidMessage_rawaid(2)
          ,Base_Fields.InvalidMessage_aceaid(1),Base_Fields.InvalidMessage_aceaid(2)
          ,Base_Fields.InvalidMessage_clean_phone(1),Base_Fields.InvalidMessage_clean_phone(2)
          ,Base_Fields.InvalidMessage_clean_dob(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Base_Layout_IDA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.persistent_record_id_Invalid := Base_Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id);
    SELF.src_Invalid := Base_Fields.InValid_src((SALT311.StrType)le.src);
    SELF.dt_first_seen_Invalid := Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.did_Invalid := Base_Fields.InValid_did((SALT311.StrType)le.did);
    SELF.did_score_Invalid := Base_Fields.InValid_did_score((SALT311.StrType)le.did_score);
    SELF.orig_first_name_Invalid := Base_Fields.InValid_orig_first_name((SALT311.StrType)le.orig_first_name);
    SELF.orig_middle_name_Invalid := Base_Fields.InValid_orig_middle_name((SALT311.StrType)le.orig_middle_name);
    SELF.orig_last_name_Invalid := Base_Fields.InValid_orig_last_name((SALT311.StrType)le.orig_last_name);
    SELF.orig_suffix_Invalid := Base_Fields.InValid_orig_suffix((SALT311.StrType)le.orig_suffix);
    SELF.orig_address1_Invalid := Base_Fields.InValid_orig_address1((SALT311.StrType)le.orig_address1);
    SELF.orig_address2_Invalid := Base_Fields.InValid_orig_address2((SALT311.StrType)le.orig_address2);
    SELF.orig_city_Invalid := Base_Fields.InValid_orig_city((SALT311.StrType)le.orig_city);
    SELF.orig_state_province_Invalid := Base_Fields.InValid_orig_state_province((SALT311.StrType)le.orig_state_province);
    SELF.orig_zip4_Invalid := Base_Fields.InValid_orig_zip4((SALT311.StrType)le.orig_zip4);
    SELF.orig_zip5_Invalid := Base_Fields.InValid_orig_zip5((SALT311.StrType)le.orig_zip5);
    SELF.orig_dob_Invalid := Base_Fields.InValid_orig_dob((SALT311.StrType)le.orig_dob);
    SELF.orig_ssn_Invalid := Base_Fields.InValid_orig_ssn((SALT311.StrType)le.orig_ssn);
    SELF.orig_dl_Invalid := Base_Fields.InValid_orig_dl((SALT311.StrType)le.orig_dl);
    SELF.orig_dlstate_Invalid := Base_Fields.InValid_orig_dlstate((SALT311.StrType)le.orig_dlstate);
    SELF.orig_phone_Invalid := Base_Fields.InValid_orig_phone((SALT311.StrType)le.orig_phone);
    SELF.clientassigneduniquerecordid_Invalid := Base_Fields.InValid_clientassigneduniquerecordid((SALT311.StrType)le.clientassigneduniquerecordid);
    SELF.adl_ind_Invalid := Base_Fields.InValid_adl_ind((SALT311.StrType)le.adl_ind);
    SELF.orig_email_Invalid := Base_Fields.InValid_orig_email((SALT311.StrType)le.orig_email);
    SELF.orig_ipaddress_Invalid := Base_Fields.InValid_orig_ipaddress((SALT311.StrType)le.orig_ipaddress);
    SELF.title_Invalid := Base_Fields.InValid_title((SALT311.StrType)le.title);
    SELF.fname_Invalid := Base_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := Base_Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := Base_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.name_suffix_Invalid := Base_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.nid_Invalid := Base_Fields.InValid_nid((SALT311.StrType)le.nid);
    SELF.prim_range_Invalid := Base_Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Base_Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Base_Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Base_Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Base_Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := Base_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Base_Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Base_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Base_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    SELF.st_Invalid := Base_Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip_Invalid := Base_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.zip4_Invalid := Base_Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.cart_Invalid := Base_Fields.InValid_cart((SALT311.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Base_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Base_Fields.InValid_lot((SALT311.StrType)le.lot);
    SELF.lot_order_Invalid := Base_Fields.InValid_lot_order((SALT311.StrType)le.lot_order);
    SELF.dbpc_Invalid := Base_Fields.InValid_dbpc((SALT311.StrType)le.dbpc);
    SELF.chk_digit_Invalid := Base_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Base_Fields.InValid_rec_type((SALT311.StrType)le.rec_type);
    SELF.fips_st_Invalid := Base_Fields.InValid_fips_st((SALT311.StrType)le.fips_st);
    SELF.fips_county_Invalid := Base_Fields.InValid_fips_county((SALT311.StrType)le.fips_county);
    SELF.geo_lat_Invalid := Base_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Base_Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    SELF.msa_Invalid := Base_Fields.InValid_msa((SALT311.StrType)le.msa);
    SELF.geo_blk_Invalid := Base_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Base_Fields.InValid_geo_match((SALT311.StrType)le.geo_match);
    SELF.err_stat_Invalid := Base_Fields.InValid_err_stat((SALT311.StrType)le.err_stat);
    SELF.rawaid_Invalid := Base_Fields.InValid_rawaid((SALT311.StrType)le.rawaid);
    SELF.aceaid_Invalid := Base_Fields.InValid_aceaid((SALT311.StrType)le.aceaid);
    SELF.clean_phone_Invalid := Base_Fields.InValid_clean_phone((SALT311.StrType)le.clean_phone);
    SELF.clean_dob_Invalid := Base_Fields.InValid_clean_dob((SALT311.StrType)le.clean_dob);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_IDA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.persistent_record_id_Invalid << 0 ) + ( le.src_Invalid << 2 ) + ( le.dt_first_seen_Invalid << 3 ) + ( le.dt_last_seen_Invalid << 4 ) + ( le.dt_vendor_first_reported_Invalid << 5 ) + ( le.dt_vendor_last_reported_Invalid << 6 ) + ( le.did_Invalid << 7 ) + ( le.did_score_Invalid << 8 ) + ( le.orig_first_name_Invalid << 9 ) + ( le.orig_middle_name_Invalid << 11 ) + ( le.orig_last_name_Invalid << 13 ) + ( le.orig_suffix_Invalid << 15 ) + ( le.orig_address1_Invalid << 17 ) + ( le.orig_address2_Invalid << 19 ) + ( le.orig_city_Invalid << 21 ) + ( le.orig_state_province_Invalid << 23 ) + ( le.orig_zip4_Invalid << 24 ) + ( le.orig_zip5_Invalid << 26 ) + ( le.orig_dob_Invalid << 28 ) + ( le.orig_ssn_Invalid << 29 ) + ( le.orig_dl_Invalid << 31 ) + ( le.orig_dlstate_Invalid << 32 ) + ( le.orig_phone_Invalid << 33 ) + ( le.clientassigneduniquerecordid_Invalid << 35 ) + ( le.adl_ind_Invalid << 37 ) + ( le.orig_email_Invalid << 38 ) + ( le.orig_ipaddress_Invalid << 39 ) + ( le.title_Invalid << 40 ) + ( le.fname_Invalid << 42 ) + ( le.mname_Invalid << 44 ) + ( le.lname_Invalid << 46 ) + ( le.name_suffix_Invalid << 48 ) + ( le.nid_Invalid << 50 ) + ( le.prim_range_Invalid << 52 ) + ( le.predir_Invalid << 53 ) + ( le.prim_name_Invalid << 55 ) + ( le.addr_suffix_Invalid << 57 ) + ( le.postdir_Invalid << 59 ) + ( le.unit_desig_Invalid << 61 ) + ( le.sec_range_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.p_city_name_Invalid << 0 ) + ( le.v_city_name_Invalid << 2 ) + ( le.st_Invalid << 4 ) + ( le.zip_Invalid << 5 ) + ( le.zip4_Invalid << 7 ) + ( le.cart_Invalid << 9 ) + ( le.cr_sort_sz_Invalid << 10 ) + ( le.lot_Invalid << 11 ) + ( le.lot_order_Invalid << 12 ) + ( le.dbpc_Invalid << 13 ) + ( le.chk_digit_Invalid << 14 ) + ( le.rec_type_Invalid << 15 ) + ( le.fips_st_Invalid << 16 ) + ( le.fips_county_Invalid << 17 ) + ( le.geo_lat_Invalid << 18 ) + ( le.geo_long_Invalid << 19 ) + ( le.msa_Invalid << 20 ) + ( le.geo_blk_Invalid << 21 ) + ( le.geo_match_Invalid << 22 ) + ( le.err_stat_Invalid << 23 ) + ( le.rawaid_Invalid << 25 ) + ( le.aceaid_Invalid << 27 ) + ( le.clean_phone_Invalid << 29 ) + ( le.clean_dob_Invalid << 31 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_IDA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.persistent_record_id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.src_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_first_name_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.orig_middle_name_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.orig_last_name_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.orig_suffix_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.orig_address1_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.orig_address2_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.orig_state_province_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.orig_zip4_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.orig_zip5_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.orig_ssn_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.orig_dl_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.orig_dlstate_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.orig_phone_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.clientassigneduniquerecordid_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.adl_ind_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.orig_email_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.orig_ipaddress_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.nid_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.v_city_name_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.st_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.zip_Invalid := (le.ScrubsBits2 >> 5) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits2 >> 7) & 3;
    SELF.cart_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.lot_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.dbpc_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.fips_st_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.fips_county_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.msa_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits2 >> 23) & 3;
    SELF.rawaid_Invalid := (le.ScrubsBits2 >> 25) & 3;
    SELF.aceaid_Invalid := (le.ScrubsBits2 >> 27) & 3;
    SELF.clean_phone_Invalid := (le.ScrubsBits2 >> 29) & 3;
    SELF.clean_dob_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    persistent_record_id_ALLOW_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
    persistent_record_id_LENGTHS_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=2);
    persistent_record_id_Total_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid>0);
    src_ALLOW_ErrorCount := COUNT(GROUP,h.src_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    orig_first_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_first_name_Invalid=1);
    orig_first_name_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_first_name_Invalid=2);
    orig_first_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_first_name_Invalid=3);
    orig_first_name_Total_ErrorCount := COUNT(GROUP,h.orig_first_name_Invalid>0);
    orig_middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_middle_name_Invalid=1);
    orig_middle_name_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_middle_name_Invalid=2);
    orig_middle_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_middle_name_Invalid=3);
    orig_middle_name_Total_ErrorCount := COUNT(GROUP,h.orig_middle_name_Invalid>0);
    orig_last_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_last_name_Invalid=1);
    orig_last_name_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_last_name_Invalid=2);
    orig_last_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_last_name_Invalid=3);
    orig_last_name_Total_ErrorCount := COUNT(GROUP,h.orig_last_name_Invalid>0);
    orig_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=1);
    orig_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=2);
    orig_suffix_WORDS_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=3);
    orig_suffix_Total_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid>0);
    orig_address1_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_Invalid=1);
    orig_address1_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_Invalid=2);
    orig_address1_Total_ErrorCount := COUNT(GROUP,h.orig_address1_Invalid>0);
    orig_address2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_Invalid=1);
    orig_address2_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_Invalid=2);
    orig_address2_Total_ErrorCount := COUNT(GROUP,h.orig_address2_Invalid>0);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_state_province_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_province_Invalid=1);
    orig_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=1);
    orig_zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=2);
    orig_zip4_Total_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid>0);
    orig_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=1);
    orig_zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=2);
    orig_zip5_Total_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid>0);
    orig_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=1);
    orig_ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=2);
    orig_ssn_Total_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid>0);
    orig_dl_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dl_Invalid=1);
    orig_dlstate_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dlstate_Invalid=1);
    orig_phone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=1);
    orig_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=2);
    orig_phone_Total_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid>0);
    clientassigneduniquerecordid_ALLOW_ErrorCount := COUNT(GROUP,h.clientassigneduniquerecordid_Invalid=1);
    clientassigneduniquerecordid_LENGTHS_ErrorCount := COUNT(GROUP,h.clientassigneduniquerecordid_Invalid=2);
    clientassigneduniquerecordid_Total_ErrorCount := COUNT(GROUP,h.clientassigneduniquerecordid_Invalid>0);
    adl_ind_ALLOW_ErrorCount := COUNT(GROUP,h.adl_ind_Invalid=1);
    orig_email_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_email_Invalid=1);
    orig_ipaddress_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_ipaddress_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_LENGTHS_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_WORDS_ErrorCount := COUNT(GROUP,h.title_Invalid=3);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_LENGTHS_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_WORDS_ErrorCount := COUNT(GROUP,h.fname_Invalid=3);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_LENGTHS_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_WORDS_ErrorCount := COUNT(GROUP,h.mname_Invalid=3);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_LENGTHS_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_WORDS_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_WORDS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=3);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    nid_ALLOW_ErrorCount := COUNT(GROUP,h.nid_Invalid=1);
    nid_LENGTHS_ErrorCount := COUNT(GROUP,h.nid_Invalid=2);
    nid_Total_ErrorCount := COUNT(GROUP,h.nid_Invalid>0);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_LENGTHS_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_WORDS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    addr_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=2);
    addr_suffix_Total_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid>0);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_LENGTHS_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_LENGTHS_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=2);
    unit_desig_Total_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid>0);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_WORDS_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_WORDS_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.fips_st_Invalid=1);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    geo_lat_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    err_stat_LENGTHS_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=2);
    err_stat_Total_ErrorCount := COUNT(GROUP,h.err_stat_Invalid>0);
    rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    rawaid_LENGTHS_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=2);
    rawaid_Total_ErrorCount := COUNT(GROUP,h.rawaid_Invalid>0);
    aceaid_ALLOW_ErrorCount := COUNT(GROUP,h.aceaid_Invalid=1);
    aceaid_LENGTHS_ErrorCount := COUNT(GROUP,h.aceaid_Invalid=2);
    aceaid_Total_ErrorCount := COUNT(GROUP,h.aceaid_Invalid>0);
    clean_phone_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    clean_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=2);
    clean_phone_Total_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid>0);
    clean_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_dob_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.persistent_record_id_Invalid > 0 OR h.src_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.did_Invalid > 0 OR h.did_score_Invalid > 0 OR h.orig_first_name_Invalid > 0 OR h.orig_middle_name_Invalid > 0 OR h.orig_last_name_Invalid > 0 OR h.orig_suffix_Invalid > 0 OR h.orig_address1_Invalid > 0 OR h.orig_address2_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_province_Invalid > 0 OR h.orig_zip4_Invalid > 0 OR h.orig_zip5_Invalid > 0 OR h.orig_dob_Invalid > 0 OR h.orig_ssn_Invalid > 0 OR h.orig_dl_Invalid > 0 OR h.orig_dlstate_Invalid > 0 OR h.orig_phone_Invalid > 0 OR h.clientassigneduniquerecordid_Invalid > 0 OR h.adl_ind_Invalid > 0 OR h.orig_email_Invalid > 0 OR h.orig_ipaddress_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.nid_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dbpc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.fips_st_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.rawaid_Invalid > 0 OR h.aceaid_Invalid > 0 OR h.clean_phone_Invalid > 0 OR h.clean_dob_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.persistent_record_id_Total_ErrorCount > 0, 1, 0) + IF(le.src_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_first_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_middle_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_last_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_state_province_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dlstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_phone_Total_ErrorCount > 0, 1, 0) + IF(le.clientassigneduniquerecordid_Total_ErrorCount > 0, 1, 0) + IF(le.adl_ind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_email_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_ipaddress_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title_Total_ErrorCount > 0, 1, 0) + IF(le.fname_Total_ErrorCount > 0, 1, 0) + IF(le.mname_Total_ErrorCount > 0, 1, 0) + IF(le.lname_Total_ErrorCount > 0, 1, 0) + IF(le.name_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.nid_Total_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_Total_ErrorCount > 0, 1, 0) + IF(le.prim_name_Total_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.postdir_Total_ErrorCount > 0, 1, 0) + IF(le.unit_desig_Total_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_Total_ErrorCount > 0, 1, 0) + IF(le.v_city_name_Total_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_Total_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_Total_ErrorCount > 0, 1, 0) + IF(le.rawaid_Total_ErrorCount > 0, 1, 0) + IF(le.aceaid_Total_ErrorCount > 0, 1, 0) + IF(le.clean_phone_Total_ErrorCount > 0, 1, 0) + IF(le.clean_dob_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.persistent_record_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.persistent_record_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.src_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_first_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_first_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_first_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_middle_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_middle_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_middle_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_last_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_last_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_last_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_state_province_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dlstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clientassigneduniquerecordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clientassigneduniquerecordid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.adl_ind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_email_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_ipaddress_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.title_WORDS_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fname_WORDS_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mname_WORDS_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lname_WORDS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.nid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawaid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.aceaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aceaid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_dob_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.persistent_record_id_Invalid,le.src_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.did_Invalid,le.did_score_Invalid,le.orig_first_name_Invalid,le.orig_middle_name_Invalid,le.orig_last_name_Invalid,le.orig_suffix_Invalid,le.orig_address1_Invalid,le.orig_address2_Invalid,le.orig_city_Invalid,le.orig_state_province_Invalid,le.orig_zip4_Invalid,le.orig_zip5_Invalid,le.orig_dob_Invalid,le.orig_ssn_Invalid,le.orig_dl_Invalid,le.orig_dlstate_Invalid,le.orig_phone_Invalid,le.clientassigneduniquerecordid_Invalid,le.adl_ind_Invalid,le.orig_email_Invalid,le.orig_ipaddress_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.nid_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.fips_st_Invalid,le.fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.rawaid_Invalid,le.aceaid_Invalid,le.clean_phone_Invalid,le.clean_dob_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),Base_Fields.InvalidMessage_src(le.src_Invalid),Base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_did(le.did_Invalid),Base_Fields.InvalidMessage_did_score(le.did_score_Invalid),Base_Fields.InvalidMessage_orig_first_name(le.orig_first_name_Invalid),Base_Fields.InvalidMessage_orig_middle_name(le.orig_middle_name_Invalid),Base_Fields.InvalidMessage_orig_last_name(le.orig_last_name_Invalid),Base_Fields.InvalidMessage_orig_suffix(le.orig_suffix_Invalid),Base_Fields.InvalidMessage_orig_address1(le.orig_address1_Invalid),Base_Fields.InvalidMessage_orig_address2(le.orig_address2_Invalid),Base_Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Base_Fields.InvalidMessage_orig_state_province(le.orig_state_province_Invalid),Base_Fields.InvalidMessage_orig_zip4(le.orig_zip4_Invalid),Base_Fields.InvalidMessage_orig_zip5(le.orig_zip5_Invalid),Base_Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Base_Fields.InvalidMessage_orig_ssn(le.orig_ssn_Invalid),Base_Fields.InvalidMessage_orig_dl(le.orig_dl_Invalid),Base_Fields.InvalidMessage_orig_dlstate(le.orig_dlstate_Invalid),Base_Fields.InvalidMessage_orig_phone(le.orig_phone_Invalid),Base_Fields.InvalidMessage_clientassigneduniquerecordid(le.clientassigneduniquerecordid_Invalid),Base_Fields.InvalidMessage_adl_ind(le.adl_ind_Invalid),Base_Fields.InvalidMessage_orig_email(le.orig_email_Invalid),Base_Fields.InvalidMessage_orig_ipaddress(le.orig_ipaddress_Invalid),Base_Fields.InvalidMessage_title(le.title_Invalid),Base_Fields.InvalidMessage_fname(le.fname_Invalid),Base_Fields.InvalidMessage_mname(le.mname_Invalid),Base_Fields.InvalidMessage_lname(le.lname_Invalid),Base_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Base_Fields.InvalidMessage_nid(le.nid_Invalid),Base_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Base_Fields.InvalidMessage_predir(le.predir_Invalid),Base_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Base_Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Base_Fields.InvalidMessage_postdir(le.postdir_Invalid),Base_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Base_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Base_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Base_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Base_Fields.InvalidMessage_st(le.st_Invalid),Base_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Fields.InvalidMessage_zip4(le.zip4_Invalid),Base_Fields.InvalidMessage_cart(le.cart_Invalid),Base_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Base_Fields.InvalidMessage_lot(le.lot_Invalid),Base_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Base_Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Base_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Base_Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Base_Fields.InvalidMessage_fips_st(le.fips_st_Invalid),Base_Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Base_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Base_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Base_Fields.InvalidMessage_msa(le.msa_Invalid),Base_Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Base_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Base_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Base_Fields.InvalidMessage_rawaid(le.rawaid_Invalid),Base_Fields.InvalidMessage_aceaid(le.aceaid_Invalid),Base_Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Base_Fields.InvalidMessage_clean_dob(le.clean_dob_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.persistent_record_id_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.src_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_first_name_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_middle_name_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_last_name_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_suffix_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_state_province_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.orig_zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_ssn_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.orig_dl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dlstate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_phone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.clientassigneduniquerecordid_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.adl_ind_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_email_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_ipaddress_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.nid_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.aceaid_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_dob_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'persistent_record_id','src','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','did','did_score','orig_first_name','orig_middle_name','orig_last_name','orig_suffix','orig_address1','orig_address2','orig_city','orig_state_province','orig_zip4','orig_zip5','orig_dob','orig_ssn','orig_dl','orig_dlstate','orig_phone','clientassigneduniquerecordid','adl_ind','orig_email','orig_ipaddress','title','fname','mname','lname','name_suffix','nid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','clean_dob','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Rec_ID','Invalid_Alpha','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_FName','Invalid_MName','Invalid_LName','Invalid_Suffix','Invalid_Address1','Invalid_Address2','Invalid_City','Invalid_State','Invalid_Zip','Invalid_Zip','Invalid_Date','Invalid_SSN','Invalid_DL','Invalid_State','Invalid_Phone','Invalid_Clientassigneduniquerecordid','Invalid_Alpha','Invalid_Emailaddress','Invalid_Ipaddress','Invalid_Title','Invalid_FName','Invalid_MName','Invalid_LName','Invalid_Suffix','Invalid_NID','Invalid_Num','Invalid_Dir','Invalid_Add','Invalid_Add_Suff','Invalid_Dir','Invalid_Add_Suff','Invalid_Num','Invalid_City','Invalid_City','Invalid_State','Invalid_Zip','Invalid_Zip4','Invalid_AlphaNum','Invalid_Alpha','Invalid_Num','Invalid_Alpha','Invalid_Num','Invalid_Num','Invalid_Alpha','Invalid_Num','Invalid_Num','Invalid_Coor','Invalid_Coor','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Err','Invalid_AID','Invalid_AID','Invalid_Phone','Invalid_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.persistent_record_id,(SALT311.StrType)le.src,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.did,(SALT311.StrType)le.did_score,(SALT311.StrType)le.orig_first_name,(SALT311.StrType)le.orig_middle_name,(SALT311.StrType)le.orig_last_name,(SALT311.StrType)le.orig_suffix,(SALT311.StrType)le.orig_address1,(SALT311.StrType)le.orig_address2,(SALT311.StrType)le.orig_city,(SALT311.StrType)le.orig_state_province,(SALT311.StrType)le.orig_zip4,(SALT311.StrType)le.orig_zip5,(SALT311.StrType)le.orig_dob,(SALT311.StrType)le.orig_ssn,(SALT311.StrType)le.orig_dl,(SALT311.StrType)le.orig_dlstate,(SALT311.StrType)le.orig_phone,(SALT311.StrType)le.clientassigneduniquerecordid,(SALT311.StrType)le.adl_ind,(SALT311.StrType)le.orig_email,(SALT311.StrType)le.orig_ipaddress,(SALT311.StrType)le.title,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.nid,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dbpc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.rec_type,(SALT311.StrType)le.fips_st,(SALT311.StrType)le.fips_county,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.msa,(SALT311.StrType)le.geo_blk,(SALT311.StrType)le.geo_match,(SALT311.StrType)le.err_stat,(SALT311.StrType)le.rawaid,(SALT311.StrType)le.aceaid,(SALT311.StrType)le.clean_phone,(SALT311.StrType)le.clean_dob,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,64,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_IDA) prevDS = DATASET([], Base_Layout_IDA), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.persistent_record_id_ALLOW_ErrorCount,le.persistent_record_id_LENGTHS_ErrorCount
          ,le.src_ALLOW_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.orig_first_name_ALLOW_ErrorCount,le.orig_first_name_LENGTHS_ErrorCount,le.orig_first_name_WORDS_ErrorCount
          ,le.orig_middle_name_ALLOW_ErrorCount,le.orig_middle_name_LENGTHS_ErrorCount,le.orig_middle_name_WORDS_ErrorCount
          ,le.orig_last_name_ALLOW_ErrorCount,le.orig_last_name_LENGTHS_ErrorCount,le.orig_last_name_WORDS_ErrorCount
          ,le.orig_suffix_ALLOW_ErrorCount,le.orig_suffix_LENGTHS_ErrorCount,le.orig_suffix_WORDS_ErrorCount
          ,le.orig_address1_ALLOW_ErrorCount,le.orig_address1_WORDS_ErrorCount
          ,le.orig_address2_ALLOW_ErrorCount,le.orig_address2_WORDS_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_province_CUSTOM_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount,le.orig_zip4_LENGTHS_ErrorCount
          ,le.orig_zip5_ALLOW_ErrorCount,le.orig_zip5_LENGTHS_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount
          ,le.orig_ssn_ALLOW_ErrorCount,le.orig_ssn_LENGTHS_ErrorCount
          ,le.orig_dl_CUSTOM_ErrorCount
          ,le.orig_dlstate_CUSTOM_ErrorCount
          ,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTHS_ErrorCount
          ,le.clientassigneduniquerecordid_ALLOW_ErrorCount,le.clientassigneduniquerecordid_LENGTHS_ErrorCount
          ,le.adl_ind_ALLOW_ErrorCount
          ,le.orig_email_CUSTOM_ErrorCount
          ,le.orig_ipaddress_CUSTOM_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTHS_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_ALLOW_ErrorCount,le.fname_LENGTHS_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_ALLOW_ErrorCount,le.mname_LENGTHS_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_ALLOW_ErrorCount,le.lname_LENGTHS_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTHS_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.nid_ALLOW_ErrorCount,le.nid_LENGTHS_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount,le.predir_LENGTHS_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount,le.prim_name_WORDS_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTHS_ErrorCount
          ,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTHS_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTHS_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_WORDS_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_WORDS_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTHS_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount
          ,le.dbpc_ALLOW_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount
          ,le.fips_st_ALLOW_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount
          ,le.geo_lat_CUSTOM_ErrorCount
          ,le.geo_long_CUSTOM_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTHS_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTHS_ErrorCount
          ,le.aceaid_ALLOW_ErrorCount,le.aceaid_LENGTHS_ErrorCount
          ,le.clean_phone_ALLOW_ErrorCount,le.clean_phone_LENGTHS_ErrorCount
          ,le.clean_dob_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.persistent_record_id_ALLOW_ErrorCount,le.persistent_record_id_LENGTHS_ErrorCount
          ,le.src_ALLOW_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.orig_first_name_ALLOW_ErrorCount,le.orig_first_name_LENGTHS_ErrorCount,le.orig_first_name_WORDS_ErrorCount
          ,le.orig_middle_name_ALLOW_ErrorCount,le.orig_middle_name_LENGTHS_ErrorCount,le.orig_middle_name_WORDS_ErrorCount
          ,le.orig_last_name_ALLOW_ErrorCount,le.orig_last_name_LENGTHS_ErrorCount,le.orig_last_name_WORDS_ErrorCount
          ,le.orig_suffix_ALLOW_ErrorCount,le.orig_suffix_LENGTHS_ErrorCount,le.orig_suffix_WORDS_ErrorCount
          ,le.orig_address1_ALLOW_ErrorCount,le.orig_address1_WORDS_ErrorCount
          ,le.orig_address2_ALLOW_ErrorCount,le.orig_address2_WORDS_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_province_CUSTOM_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount,le.orig_zip4_LENGTHS_ErrorCount
          ,le.orig_zip5_ALLOW_ErrorCount,le.orig_zip5_LENGTHS_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount
          ,le.orig_ssn_ALLOW_ErrorCount,le.orig_ssn_LENGTHS_ErrorCount
          ,le.orig_dl_CUSTOM_ErrorCount
          ,le.orig_dlstate_CUSTOM_ErrorCount
          ,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTHS_ErrorCount
          ,le.clientassigneduniquerecordid_ALLOW_ErrorCount,le.clientassigneduniquerecordid_LENGTHS_ErrorCount
          ,le.adl_ind_ALLOW_ErrorCount
          ,le.orig_email_CUSTOM_ErrorCount
          ,le.orig_ipaddress_CUSTOM_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTHS_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_ALLOW_ErrorCount,le.fname_LENGTHS_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_ALLOW_ErrorCount,le.mname_LENGTHS_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_ALLOW_ErrorCount,le.lname_LENGTHS_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTHS_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.nid_ALLOW_ErrorCount,le.nid_LENGTHS_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount,le.predir_LENGTHS_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount,le.prim_name_WORDS_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTHS_ErrorCount
          ,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTHS_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTHS_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_WORDS_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_WORDS_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTHS_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount
          ,le.dbpc_ALLOW_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount
          ,le.fips_st_ALLOW_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount
          ,le.geo_lat_CUSTOM_ErrorCount
          ,le.geo_long_CUSTOM_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTHS_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTHS_ErrorCount
          ,le.aceaid_ALLOW_ErrorCount,le.aceaid_LENGTHS_ErrorCount
          ,le.clean_phone_ALLOW_ErrorCount,le.clean_phone_LENGTHS_ErrorCount
          ,le.clean_dob_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);

    // field population stats
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_IDA));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'persistent_record_id:' + getFieldTypeText(h.persistent_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src:' + getFieldTypeText(h.src) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_first_name:' + getFieldTypeText(h.orig_first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_middle_name:' + getFieldTypeText(h.orig_middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_last_name:' + getFieldTypeText(h.orig_last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_suffix:' + getFieldTypeText(h.orig_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1:' + getFieldTypeText(h.orig_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2:' + getFieldTypeText(h.orig_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state_province:' + getFieldTypeText(h.orig_state_province) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip4:' + getFieldTypeText(h.orig_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip5:' + getFieldTypeText(h.orig_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob:' + getFieldTypeText(h.orig_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ssn:' + getFieldTypeText(h.orig_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dl:' + getFieldTypeText(h.orig_dl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dlstate:' + getFieldTypeText(h.orig_dlstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_phone:' + getFieldTypeText(h.orig_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clientassigneduniquerecordid:' + getFieldTypeText(h.clientassigneduniquerecordid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'adl_ind:' + getFieldTypeText(h.adl_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_email:' + getFieldTypeText(h.orig_email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ipaddress:' + getFieldTypeText(h.orig_ipaddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_filecategory:' + getFieldTypeText(h.orig_filecategory) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nid:' + getFieldTypeText(h.nid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'fips_st:' + getFieldTypeText(h.fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawaid:' + getFieldTypeText(h.rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aceaid:' + getFieldTypeText(h.aceaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phone:' + getFieldTypeText(h.clean_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_dob:' + getFieldTypeText(h.clean_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_persistent_record_id_cnt
          ,le.populated_src_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_orig_first_name_cnt
          ,le.populated_orig_middle_name_cnt
          ,le.populated_orig_last_name_cnt
          ,le.populated_orig_suffix_cnt
          ,le.populated_orig_address1_cnt
          ,le.populated_orig_address2_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_province_cnt
          ,le.populated_orig_zip4_cnt
          ,le.populated_orig_zip5_cnt
          ,le.populated_orig_dob_cnt
          ,le.populated_orig_ssn_cnt
          ,le.populated_orig_dl_cnt
          ,le.populated_orig_dlstate_cnt
          ,le.populated_orig_phone_cnt
          ,le.populated_clientassigneduniquerecordid_cnt
          ,le.populated_adl_ind_cnt
          ,le.populated_orig_email_cnt
          ,le.populated_orig_ipaddress_cnt
          ,le.populated_orig_filecategory_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_nid_cnt
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
          ,le.populated_fips_st_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_rawaid_cnt
          ,le.populated_aceaid_cnt
          ,le.populated_clean_phone_cnt
          ,le.populated_clean_dob_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_persistent_record_id_pcnt
          ,le.populated_src_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_orig_first_name_pcnt
          ,le.populated_orig_middle_name_pcnt
          ,le.populated_orig_last_name_pcnt
          ,le.populated_orig_suffix_pcnt
          ,le.populated_orig_address1_pcnt
          ,le.populated_orig_address2_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_province_pcnt
          ,le.populated_orig_zip4_pcnt
          ,le.populated_orig_zip5_pcnt
          ,le.populated_orig_dob_pcnt
          ,le.populated_orig_ssn_pcnt
          ,le.populated_orig_dl_pcnt
          ,le.populated_orig_dlstate_pcnt
          ,le.populated_orig_phone_pcnt
          ,le.populated_clientassigneduniquerecordid_pcnt
          ,le.populated_adl_ind_pcnt
          ,le.populated_orig_email_pcnt
          ,le.populated_orig_ipaddress_pcnt
          ,le.populated_orig_filecategory_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_nid_pcnt
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
          ,le.populated_fips_st_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_rawaid_pcnt
          ,le.populated_aceaid_pcnt
          ,le.populated_clean_phone_pcnt
          ,le.populated_clean_dob_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,65,xNormHygieneStats(LEFT,COUNTER,'POP'));

  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));

    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_IDA));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),65,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(Base_Layout_IDA) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_IDA, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));

  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);

  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));

  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
