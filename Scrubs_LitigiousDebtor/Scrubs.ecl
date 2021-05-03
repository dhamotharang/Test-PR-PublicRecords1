IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 101;
  EXPORT NumRulesFromFieldType := 101;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 94;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_LitigiousDebtor)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 recid_Invalid;
    UNSIGNED1 courtstate_Invalid;
    UNSIGNED1 courtid_Invalid;
    UNSIGNED1 courtname_Invalid;
    UNSIGNED1 docketnumber_Invalid;
    UNSIGNED1 officename_Invalid;
    UNSIGNED1 asofdate_Invalid;
    UNSIGNED1 classcode_Invalid;
    UNSIGNED1 casecaption_Invalid;
    UNSIGNED1 datefiled_Invalid;
    UNSIGNED1 judgetitle_Invalid;
    UNSIGNED1 judgename_Invalid;
    UNSIGNED1 referredtojudgetitle_Invalid;
    UNSIGNED1 referredtojudge_Invalid;
    UNSIGNED1 jurydemand_Invalid;
    UNSIGNED1 demandamount_Invalid;
    UNSIGNED1 suitnaturecode_Invalid;
    UNSIGNED1 suitnaturedesc_Invalid;
    UNSIGNED1 leaddocketnumber_Invalid;
    UNSIGNED1 jurisdiction_Invalid;
    UNSIGNED1 cause_Invalid;
    UNSIGNED1 statute_Invalid;
    UNSIGNED1 ca_Invalid;
    UNSIGNED1 caseclosed_Invalid;
    UNSIGNED1 dateretrieved_Invalid;
    UNSIGNED1 otherdocketnumber_Invalid;
    UNSIGNED1 litigantname_Invalid;
    UNSIGNED1 litigantlabel_Invalid;
    UNSIGNED1 layoutcode_Invalid;
    UNSIGNED1 terminationdate_Invalid;
    UNSIGNED1 attorneyname_Invalid;
    UNSIGNED1 attorneylabel_Invalid;
    UNSIGNED1 firmname_Invalid;
    UNSIGNED1 address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 termdate_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 causecode_Invalid;
    UNSIGNED1 judge_title_Invalid;
    UNSIGNED1 judge_fname_Invalid;
    UNSIGNED1 judge_mname_Invalid;
    UNSIGNED1 judge_lname_Invalid;
    UNSIGNED1 judge_suffix_Invalid;
    UNSIGNED1 judge_score_Invalid;
    UNSIGNED1 business_person_Invalid;
    UNSIGNED1 debtor_Invalid;
    UNSIGNED1 debtor_title_Invalid;
    UNSIGNED1 debtor_fname_Invalid;
    UNSIGNED1 debtor_mname_Invalid;
    UNSIGNED1 debtor_lname_Invalid;
    UNSIGNED1 debtor_suffix_Invalid;
    UNSIGNED1 debtor_score_Invalid;
    UNSIGNED1 attorney_title_Invalid;
    UNSIGNED1 attorney_fname_Invalid;
    UNSIGNED1 attorney_mname_Invalid;
    UNSIGNED1 attorney_lname_Invalid;
    UNSIGNED1 attorney_suffix_Invalid;
    UNSIGNED1 attorney_score_Invalid;
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
    UNSIGNED1 fips_state_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_LitigiousDebtor)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
  EXPORT Rule_Layout := RECORD(Layout_LitigiousDebtor)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dt_first_seen:Invalid_Date:CUSTOM'
          ,'dt_last_seen:Invalid_Date:CUSTOM'
          ,'dt_vendor_first_reported:Invalid_Date:CUSTOM'
          ,'dt_vendor_last_reported:Invalid_Date:CUSTOM'
          ,'record_type:Invalid_Alpha:CUSTOM'
          ,'recid:Invalid_No:CUSTOM'
          ,'courtstate:Invalid_State:ALLOW','courtstate:Invalid_State:LENGTHS'
          ,'courtid:Invalid_AlphaChar:CUSTOM'
          ,'courtname:Invalid_Alpha:CUSTOM'
          ,'docketnumber:Invalid_AlphaNumChar:CUSTOM'
          ,'officename:Invalid_AlphaChar:CUSTOM'
          ,'asofdate:Invalid_Date:CUSTOM'
          ,'classcode:Invalid_AlphaNumChar:CUSTOM'
          ,'casecaption:Invalid_AlphaChar:CUSTOM'
          ,'datefiled:Invalid_Date:CUSTOM'
          ,'judgetitle:Invalid_Alpha:CUSTOM'
          ,'judgename:Invalid_AlphaChar:CUSTOM'
          ,'referredtojudgetitle:Invalid_Alpha:CUSTOM'
          ,'referredtojudge:Invalid_AlphaChar:CUSTOM'
          ,'jurydemand:Invalid_Alpha:CUSTOM'
          ,'demandamount:Invalid_Float:ALLOW'
          ,'suitnaturecode:Invalid_No:CUSTOM'
          ,'suitnaturedesc:Invalid_AlphaChar:CUSTOM'
          ,'leaddocketnumber:Invalid_Alpha:CUSTOM'
          ,'jurisdiction:Invalid_AlphaChar:CUSTOM'
          ,'cause:Invalid_Alpha:CUSTOM'
          ,'statute:Invalid_Float:ALLOW'
          ,'ca:Invalid_YOrN:ALLOW','ca:Invalid_YOrN:LENGTHS'
          ,'caseclosed:Invalid_YOrN:ALLOW','caseclosed:Invalid_YOrN:LENGTHS'
          ,'dateretrieved:Invalid_Date:CUSTOM'
          ,'otherdocketnumber:Invalid_AlphaNumChar:CUSTOM'
          ,'litigantname:Invalid_AlphaChar:CUSTOM'
          ,'litigantlabel:Invalid_Alpha:CUSTOM'
          ,'layoutcode:Invalid_Alpha:CUSTOM'
          ,'terminationdate:Invalid_Date:CUSTOM'
          ,'attorneyname:Invalid_AlphaChar:CUSTOM'
          ,'attorneylabel:Invalid_AlphaChar:CUSTOM'
          ,'firmname:Invalid_AlphaChar:CUSTOM'
          ,'address:Invalid_AlphaNumChar:CUSTOM'
          ,'city:Invalid_Alpha:CUSTOM'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTHS'
          ,'zipcode:Invalid_Zip:ALLOW','zipcode:Invalid_Zip:LENGTHS'
          ,'country:Invalid_Alpha:CUSTOM'
          ,'termdate:Invalid_Date:CUSTOM'
          ,'bdid:Invalid_No:CUSTOM'
          ,'did:Invalid_No:CUSTOM'
          ,'causecode:Invalid_No:CUSTOM'
          ,'judge_title:Invalid_Alpha:CUSTOM'
          ,'judge_fname:Invalid_Alpha:CUSTOM'
          ,'judge_mname:Invalid_Alpha:CUSTOM'
          ,'judge_lname:Invalid_Alpha:CUSTOM'
          ,'judge_suffix:Invalid_Alpha:CUSTOM'
          ,'judge_score:Invalid_No:CUSTOM'
          ,'business_person:Invalid_Alpha:CUSTOM'
          ,'debtor:Invalid_AlphaChar:CUSTOM'
          ,'debtor_title:Invalid_Alpha:CUSTOM'
          ,'debtor_fname:Invalid_Alpha:CUSTOM'
          ,'debtor_mname:Invalid_Alpha:CUSTOM'
          ,'debtor_lname:Invalid_Alpha:CUSTOM'
          ,'debtor_suffix:Invalid_Alpha:CUSTOM'
          ,'debtor_score:Invalid_Alpha:CUSTOM'
          ,'attorney_title:Invalid_Alpha:CUSTOM'
          ,'attorney_fname:Invalid_Alpha:CUSTOM'
          ,'attorney_mname:Invalid_Alpha:CUSTOM'
          ,'attorney_lname:Invalid_Alpha:CUSTOM'
          ,'attorney_suffix:Invalid_Alpha:CUSTOM'
          ,'attorney_score:Invalid_No:CUSTOM'
          ,'prim_range:Invalid_No:CUSTOM'
          ,'predir:Invalid_Alpha:CUSTOM'
          ,'prim_name:Invalid_AlphaNum:CUSTOM'
          ,'addr_suffix:Invalid_Alpha:CUSTOM'
          ,'postdir:Invalid_Alpha:CUSTOM'
          ,'unit_desig:Invalid_AlphaChar:CUSTOM'
          ,'sec_range:Invalid_AlphaNum:CUSTOM'
          ,'p_city_name:Invalid_Alpha:CUSTOM'
          ,'v_city_name:Invalid_Alpha:CUSTOM'
          ,'st:Invalid_State:ALLOW','st:Invalid_State:LENGTHS'
          ,'zip:Invalid_Zip:ALLOW','zip:Invalid_Zip:LENGTHS'
          ,'zip4:Invalid_No:CUSTOM'
          ,'cart:Invalid_AlphaNum:CUSTOM'
          ,'cr_sort_sz:Invalid_Alpha:CUSTOM'
          ,'lot:Invalid_No:CUSTOM'
          ,'lot_order:Invalid_Alpha:CUSTOM'
          ,'dbpc:Invalid_No:CUSTOM'
          ,'chk_digit:Invalid_No:CUSTOM'
          ,'rec_type:Invalid_Alpha:CUSTOM'
          ,'fips_state:Invalid_No:CUSTOM'
          ,'fips_county:Invalid_No:CUSTOM'
          ,'geo_lat:Invalid_Float:ALLOW'
          ,'geo_long:Invalid_Float:ALLOW'
          ,'msa:Invalid_No:CUSTOM'
          ,'geo_blk:Invalid_No:CUSTOM'
          ,'geo_match:Invalid_No:CUSTOM'
          ,'err_stat:Invalid_AlphaNum:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_dt_first_seen(1)
          ,Fields.InvalidMessage_dt_last_seen(1)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Fields.InvalidMessage_record_type(1)
          ,Fields.InvalidMessage_recid(1)
          ,Fields.InvalidMessage_courtstate(1),Fields.InvalidMessage_courtstate(2)
          ,Fields.InvalidMessage_courtid(1)
          ,Fields.InvalidMessage_courtname(1)
          ,Fields.InvalidMessage_docketnumber(1)
          ,Fields.InvalidMessage_officename(1)
          ,Fields.InvalidMessage_asofdate(1)
          ,Fields.InvalidMessage_classcode(1)
          ,Fields.InvalidMessage_casecaption(1)
          ,Fields.InvalidMessage_datefiled(1)
          ,Fields.InvalidMessage_judgetitle(1)
          ,Fields.InvalidMessage_judgename(1)
          ,Fields.InvalidMessage_referredtojudgetitle(1)
          ,Fields.InvalidMessage_referredtojudge(1)
          ,Fields.InvalidMessage_jurydemand(1)
          ,Fields.InvalidMessage_demandamount(1)
          ,Fields.InvalidMessage_suitnaturecode(1)
          ,Fields.InvalidMessage_suitnaturedesc(1)
          ,Fields.InvalidMessage_leaddocketnumber(1)
          ,Fields.InvalidMessage_jurisdiction(1)
          ,Fields.InvalidMessage_cause(1)
          ,Fields.InvalidMessage_statute(1)
          ,Fields.InvalidMessage_ca(1),Fields.InvalidMessage_ca(2)
          ,Fields.InvalidMessage_caseclosed(1),Fields.InvalidMessage_caseclosed(2)
          ,Fields.InvalidMessage_dateretrieved(1)
          ,Fields.InvalidMessage_otherdocketnumber(1)
          ,Fields.InvalidMessage_litigantname(1)
          ,Fields.InvalidMessage_litigantlabel(1)
          ,Fields.InvalidMessage_layoutcode(1)
          ,Fields.InvalidMessage_terminationdate(1)
          ,Fields.InvalidMessage_attorneyname(1)
          ,Fields.InvalidMessage_attorneylabel(1)
          ,Fields.InvalidMessage_firmname(1)
          ,Fields.InvalidMessage_address(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_zipcode(1),Fields.InvalidMessage_zipcode(2)
          ,Fields.InvalidMessage_country(1)
          ,Fields.InvalidMessage_termdate(1)
          ,Fields.InvalidMessage_bdid(1)
          ,Fields.InvalidMessage_did(1)
          ,Fields.InvalidMessage_causecode(1)
          ,Fields.InvalidMessage_judge_title(1)
          ,Fields.InvalidMessage_judge_fname(1)
          ,Fields.InvalidMessage_judge_mname(1)
          ,Fields.InvalidMessage_judge_lname(1)
          ,Fields.InvalidMessage_judge_suffix(1)
          ,Fields.InvalidMessage_judge_score(1)
          ,Fields.InvalidMessage_business_person(1)
          ,Fields.InvalidMessage_debtor(1)
          ,Fields.InvalidMessage_debtor_title(1)
          ,Fields.InvalidMessage_debtor_fname(1)
          ,Fields.InvalidMessage_debtor_mname(1)
          ,Fields.InvalidMessage_debtor_lname(1)
          ,Fields.InvalidMessage_debtor_suffix(1)
          ,Fields.InvalidMessage_debtor_score(1)
          ,Fields.InvalidMessage_attorney_title(1)
          ,Fields.InvalidMessage_attorney_fname(1)
          ,Fields.InvalidMessage_attorney_mname(1)
          ,Fields.InvalidMessage_attorney_lname(1)
          ,Fields.InvalidMessage_attorney_suffix(1)
          ,Fields.InvalidMessage_attorney_score(1)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_addr_suffix(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_unit_desig(1)
          ,Fields.InvalidMessage_sec_range(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_zip4(1)
          ,Fields.InvalidMessage_cart(1)
          ,Fields.InvalidMessage_cr_sort_sz(1)
          ,Fields.InvalidMessage_lot(1)
          ,Fields.InvalidMessage_lot_order(1)
          ,Fields.InvalidMessage_dbpc(1)
          ,Fields.InvalidMessage_chk_digit(1)
          ,Fields.InvalidMessage_rec_type(1)
          ,Fields.InvalidMessage_fips_state(1)
          ,Fields.InvalidMessage_fips_county(1)
          ,Fields.InvalidMessage_geo_lat(1)
          ,Fields.InvalidMessage_geo_long(1)
          ,Fields.InvalidMessage_msa(1)
          ,Fields.InvalidMessage_geo_blk(1)
          ,Fields.InvalidMessage_geo_match(1)
          ,Fields.InvalidMessage_err_stat(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_LitigiousDebtor) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.record_type_Invalid := Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.recid_Invalid := Fields.InValid_recid((SALT311.StrType)le.recid);
    SELF.courtstate_Invalid := Fields.InValid_courtstate((SALT311.StrType)le.courtstate);
    SELF.courtid_Invalid := Fields.InValid_courtid((SALT311.StrType)le.courtid);
    SELF.courtname_Invalid := Fields.InValid_courtname((SALT311.StrType)le.courtname);
    SELF.docketnumber_Invalid := Fields.InValid_docketnumber((SALT311.StrType)le.docketnumber);
    SELF.officename_Invalid := Fields.InValid_officename((SALT311.StrType)le.officename);
    SELF.asofdate_Invalid := Fields.InValid_asofdate((SALT311.StrType)le.asofdate);
    SELF.classcode_Invalid := Fields.InValid_classcode((SALT311.StrType)le.classcode);
    SELF.casecaption_Invalid := Fields.InValid_casecaption((SALT311.StrType)le.casecaption);
    SELF.datefiled_Invalid := Fields.InValid_datefiled((SALT311.StrType)le.datefiled);
    SELF.judgetitle_Invalid := Fields.InValid_judgetitle((SALT311.StrType)le.judgetitle);
    SELF.judgename_Invalid := Fields.InValid_judgename((SALT311.StrType)le.judgename);
    SELF.referredtojudgetitle_Invalid := Fields.InValid_referredtojudgetitle((SALT311.StrType)le.referredtojudgetitle);
    SELF.referredtojudge_Invalid := Fields.InValid_referredtojudge((SALT311.StrType)le.referredtojudge);
    SELF.jurydemand_Invalid := Fields.InValid_jurydemand((SALT311.StrType)le.jurydemand);
    SELF.demandamount_Invalid := Fields.InValid_demandamount((SALT311.StrType)le.demandamount);
    SELF.suitnaturecode_Invalid := Fields.InValid_suitnaturecode((SALT311.StrType)le.suitnaturecode);
    SELF.suitnaturedesc_Invalid := Fields.InValid_suitnaturedesc((SALT311.StrType)le.suitnaturedesc);
    SELF.leaddocketnumber_Invalid := Fields.InValid_leaddocketnumber((SALT311.StrType)le.leaddocketnumber);
    SELF.jurisdiction_Invalid := Fields.InValid_jurisdiction((SALT311.StrType)le.jurisdiction);
    SELF.cause_Invalid := Fields.InValid_cause((SALT311.StrType)le.cause);
    SELF.statute_Invalid := Fields.InValid_statute((SALT311.StrType)le.statute);
    SELF.ca_Invalid := Fields.InValid_ca((SALT311.StrType)le.ca);
    SELF.caseclosed_Invalid := Fields.InValid_caseclosed((SALT311.StrType)le.caseclosed);
    SELF.dateretrieved_Invalid := Fields.InValid_dateretrieved((SALT311.StrType)le.dateretrieved);
    SELF.otherdocketnumber_Invalid := Fields.InValid_otherdocketnumber((SALT311.StrType)le.otherdocketnumber);
    SELF.litigantname_Invalid := Fields.InValid_litigantname((SALT311.StrType)le.litigantname);
    SELF.litigantlabel_Invalid := Fields.InValid_litigantlabel((SALT311.StrType)le.litigantlabel);
    SELF.layoutcode_Invalid := Fields.InValid_layoutcode((SALT311.StrType)le.layoutcode);
    SELF.terminationdate_Invalid := Fields.InValid_terminationdate((SALT311.StrType)le.terminationdate);
    SELF.attorneyname_Invalid := Fields.InValid_attorneyname((SALT311.StrType)le.attorneyname);
    SELF.attorneylabel_Invalid := Fields.InValid_attorneylabel((SALT311.StrType)le.attorneylabel);
    SELF.firmname_Invalid := Fields.InValid_firmname((SALT311.StrType)le.firmname);
    SELF.address_Invalid := Fields.InValid_address((SALT311.StrType)le.address);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zipcode_Invalid := Fields.InValid_zipcode((SALT311.StrType)le.zipcode);
    SELF.country_Invalid := Fields.InValid_country((SALT311.StrType)le.country);
    SELF.termdate_Invalid := Fields.InValid_termdate((SALT311.StrType)le.termdate);
    SELF.bdid_Invalid := Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.did_Invalid := Fields.InValid_did((SALT311.StrType)le.did);
    SELF.causecode_Invalid := Fields.InValid_causecode((SALT311.StrType)le.causecode);
    SELF.judge_title_Invalid := Fields.InValid_judge_title((SALT311.StrType)le.judge_title);
    SELF.judge_fname_Invalid := Fields.InValid_judge_fname((SALT311.StrType)le.judge_fname);
    SELF.judge_mname_Invalid := Fields.InValid_judge_mname((SALT311.StrType)le.judge_mname);
    SELF.judge_lname_Invalid := Fields.InValid_judge_lname((SALT311.StrType)le.judge_lname);
    SELF.judge_suffix_Invalid := Fields.InValid_judge_suffix((SALT311.StrType)le.judge_suffix);
    SELF.judge_score_Invalid := Fields.InValid_judge_score((SALT311.StrType)le.judge_score);
    SELF.business_person_Invalid := Fields.InValid_business_person((SALT311.StrType)le.business_person);
    SELF.debtor_Invalid := Fields.InValid_debtor((SALT311.StrType)le.debtor);
    SELF.debtor_title_Invalid := Fields.InValid_debtor_title((SALT311.StrType)le.debtor_title);
    SELF.debtor_fname_Invalid := Fields.InValid_debtor_fname((SALT311.StrType)le.debtor_fname);
    SELF.debtor_mname_Invalid := Fields.InValid_debtor_mname((SALT311.StrType)le.debtor_mname);
    SELF.debtor_lname_Invalid := Fields.InValid_debtor_lname((SALT311.StrType)le.debtor_lname);
    SELF.debtor_suffix_Invalid := Fields.InValid_debtor_suffix((SALT311.StrType)le.debtor_suffix);
    SELF.debtor_score_Invalid := Fields.InValid_debtor_score((SALT311.StrType)le.debtor_score);
    SELF.attorney_title_Invalid := Fields.InValid_attorney_title((SALT311.StrType)le.attorney_title);
    SELF.attorney_fname_Invalid := Fields.InValid_attorney_fname((SALT311.StrType)le.attorney_fname);
    SELF.attorney_mname_Invalid := Fields.InValid_attorney_mname((SALT311.StrType)le.attorney_mname);
    SELF.attorney_lname_Invalid := Fields.InValid_attorney_lname((SALT311.StrType)le.attorney_lname);
    SELF.attorney_suffix_Invalid := Fields.InValid_attorney_suffix((SALT311.StrType)le.attorney_suffix);
    SELF.attorney_score_Invalid := Fields.InValid_attorney_score((SALT311.StrType)le.attorney_score);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.cart_Invalid := Fields.InValid_cart((SALT311.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Fields.InValid_lot((SALT311.StrType)le.lot);
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT311.StrType)le.lot_order);
    SELF.dbpc_Invalid := Fields.InValid_dbpc((SALT311.StrType)le.dbpc);
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT311.StrType)le.rec_type);
    SELF.fips_state_Invalid := Fields.InValid_fips_state((SALT311.StrType)le.fips_state);
    SELF.fips_county_Invalid := Fields.InValid_fips_county((SALT311.StrType)le.fips_county);
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    SELF.msa_Invalid := Fields.InValid_msa((SALT311.StrType)le.msa);
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT311.StrType)le.geo_match);
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT311.StrType)le.err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_LitigiousDebtor);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 1 ) + ( le.dt_vendor_first_reported_Invalid << 2 ) + ( le.dt_vendor_last_reported_Invalid << 3 ) + ( le.record_type_Invalid << 4 ) + ( le.recid_Invalid << 5 ) + ( le.courtstate_Invalid << 6 ) + ( le.courtid_Invalid << 8 ) + ( le.courtname_Invalid << 9 ) + ( le.docketnumber_Invalid << 10 ) + ( le.officename_Invalid << 11 ) + ( le.asofdate_Invalid << 12 ) + ( le.classcode_Invalid << 13 ) + ( le.casecaption_Invalid << 14 ) + ( le.datefiled_Invalid << 15 ) + ( le.judgetitle_Invalid << 16 ) + ( le.judgename_Invalid << 17 ) + ( le.referredtojudgetitle_Invalid << 18 ) + ( le.referredtojudge_Invalid << 19 ) + ( le.jurydemand_Invalid << 20 ) + ( le.demandamount_Invalid << 21 ) + ( le.suitnaturecode_Invalid << 22 ) + ( le.suitnaturedesc_Invalid << 23 ) + ( le.leaddocketnumber_Invalid << 24 ) + ( le.jurisdiction_Invalid << 25 ) + ( le.cause_Invalid << 26 ) + ( le.statute_Invalid << 27 ) + ( le.ca_Invalid << 28 ) + ( le.caseclosed_Invalid << 30 ) + ( le.dateretrieved_Invalid << 32 ) + ( le.otherdocketnumber_Invalid << 33 ) + ( le.litigantname_Invalid << 34 ) + ( le.litigantlabel_Invalid << 35 ) + ( le.layoutcode_Invalid << 36 ) + ( le.terminationdate_Invalid << 37 ) + ( le.attorneyname_Invalid << 38 ) + ( le.attorneylabel_Invalid << 39 ) + ( le.firmname_Invalid << 40 ) + ( le.address_Invalid << 41 ) + ( le.city_Invalid << 42 ) + ( le.state_Invalid << 43 ) + ( le.zipcode_Invalid << 45 ) + ( le.country_Invalid << 47 ) + ( le.termdate_Invalid << 48 ) + ( le.bdid_Invalid << 49 ) + ( le.did_Invalid << 50 ) + ( le.causecode_Invalid << 51 ) + ( le.judge_title_Invalid << 52 ) + ( le.judge_fname_Invalid << 53 ) + ( le.judge_mname_Invalid << 54 ) + ( le.judge_lname_Invalid << 55 ) + ( le.judge_suffix_Invalid << 56 ) + ( le.judge_score_Invalid << 57 ) + ( le.business_person_Invalid << 58 ) + ( le.debtor_Invalid << 59 ) + ( le.debtor_title_Invalid << 60 ) + ( le.debtor_fname_Invalid << 61 ) + ( le.debtor_mname_Invalid << 62 ) + ( le.debtor_lname_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.debtor_suffix_Invalid << 0 ) + ( le.debtor_score_Invalid << 1 ) + ( le.attorney_title_Invalid << 2 ) + ( le.attorney_fname_Invalid << 3 ) + ( le.attorney_mname_Invalid << 4 ) + ( le.attorney_lname_Invalid << 5 ) + ( le.attorney_suffix_Invalid << 6 ) + ( le.attorney_score_Invalid << 7 ) + ( le.prim_range_Invalid << 8 ) + ( le.predir_Invalid << 9 ) + ( le.prim_name_Invalid << 10 ) + ( le.addr_suffix_Invalid << 11 ) + ( le.postdir_Invalid << 12 ) + ( le.unit_desig_Invalid << 13 ) + ( le.sec_range_Invalid << 14 ) + ( le.p_city_name_Invalid << 15 ) + ( le.v_city_name_Invalid << 16 ) + ( le.st_Invalid << 17 ) + ( le.zip_Invalid << 19 ) + ( le.zip4_Invalid << 21 ) + ( le.cart_Invalid << 22 ) + ( le.cr_sort_sz_Invalid << 23 ) + ( le.lot_Invalid << 24 ) + ( le.lot_order_Invalid << 25 ) + ( le.dbpc_Invalid << 26 ) + ( le.chk_digit_Invalid << 27 ) + ( le.rec_type_Invalid << 28 ) + ( le.fips_state_Invalid << 29 ) + ( le.fips_county_Invalid << 30 ) + ( le.geo_lat_Invalid << 31 ) + ( le.geo_long_Invalid << 32 ) + ( le.msa_Invalid << 33 ) + ( le.geo_blk_Invalid << 34 ) + ( le.geo_match_Invalid << 35 ) + ( le.err_stat_Invalid << 36 );
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
  EXPORT Infile := PROJECT(h,Layout_LitigiousDebtor);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.recid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.courtstate_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.courtid_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.courtname_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.docketnumber_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.officename_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.asofdate_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.classcode_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.casecaption_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.datefiled_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.judgetitle_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.judgename_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.referredtojudgetitle_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.referredtojudge_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.jurydemand_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.demandamount_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.suitnaturecode_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.suitnaturedesc_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.leaddocketnumber_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.jurisdiction_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.cause_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.statute_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.ca_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.caseclosed_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.dateretrieved_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.otherdocketnumber_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.litigantname_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.litigantlabel_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.layoutcode_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.terminationdate_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.attorneyname_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.attorneylabel_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.firmname_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.address_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.country_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.termdate_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.causecode_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.judge_title_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.judge_fname_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.judge_mname_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.judge_lname_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.judge_suffix_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.judge_score_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.business_person_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.debtor_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.debtor_title_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.debtor_fname_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.debtor_mname_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.debtor_lname_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.debtor_suffix_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.debtor_score_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.attorney_title_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.attorney_fname_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.attorney_mname_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.attorney_lname_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.attorney_suffix_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.attorney_score_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.predir_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.st_Invalid := (le.ScrubsBits2 >> 17) & 3;
    SELF.zip_Invalid := (le.ScrubsBits2 >> 19) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.cart_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.lot_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.dbpc_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.fips_state_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.fips_county_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.msa_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    record_type_CUSTOM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    recid_CUSTOM_ErrorCount := COUNT(GROUP,h.recid_Invalid=1);
    courtstate_ALLOW_ErrorCount := COUNT(GROUP,h.courtstate_Invalid=1);
    courtstate_LENGTHS_ErrorCount := COUNT(GROUP,h.courtstate_Invalid=2);
    courtstate_Total_ErrorCount := COUNT(GROUP,h.courtstate_Invalid>0);
    courtid_CUSTOM_ErrorCount := COUNT(GROUP,h.courtid_Invalid=1);
    courtname_CUSTOM_ErrorCount := COUNT(GROUP,h.courtname_Invalid=1);
    docketnumber_CUSTOM_ErrorCount := COUNT(GROUP,h.docketnumber_Invalid=1);
    officename_CUSTOM_ErrorCount := COUNT(GROUP,h.officename_Invalid=1);
    asofdate_CUSTOM_ErrorCount := COUNT(GROUP,h.asofdate_Invalid=1);
    classcode_CUSTOM_ErrorCount := COUNT(GROUP,h.classcode_Invalid=1);
    casecaption_CUSTOM_ErrorCount := COUNT(GROUP,h.casecaption_Invalid=1);
    datefiled_CUSTOM_ErrorCount := COUNT(GROUP,h.datefiled_Invalid=1);
    judgetitle_CUSTOM_ErrorCount := COUNT(GROUP,h.judgetitle_Invalid=1);
    judgename_CUSTOM_ErrorCount := COUNT(GROUP,h.judgename_Invalid=1);
    referredtojudgetitle_CUSTOM_ErrorCount := COUNT(GROUP,h.referredtojudgetitle_Invalid=1);
    referredtojudge_CUSTOM_ErrorCount := COUNT(GROUP,h.referredtojudge_Invalid=1);
    jurydemand_CUSTOM_ErrorCount := COUNT(GROUP,h.jurydemand_Invalid=1);
    demandamount_ALLOW_ErrorCount := COUNT(GROUP,h.demandamount_Invalid=1);
    suitnaturecode_CUSTOM_ErrorCount := COUNT(GROUP,h.suitnaturecode_Invalid=1);
    suitnaturedesc_CUSTOM_ErrorCount := COUNT(GROUP,h.suitnaturedesc_Invalid=1);
    leaddocketnumber_CUSTOM_ErrorCount := COUNT(GROUP,h.leaddocketnumber_Invalid=1);
    jurisdiction_CUSTOM_ErrorCount := COUNT(GROUP,h.jurisdiction_Invalid=1);
    cause_CUSTOM_ErrorCount := COUNT(GROUP,h.cause_Invalid=1);
    statute_ALLOW_ErrorCount := COUNT(GROUP,h.statute_Invalid=1);
    ca_ALLOW_ErrorCount := COUNT(GROUP,h.ca_Invalid=1);
    ca_LENGTHS_ErrorCount := COUNT(GROUP,h.ca_Invalid=2);
    ca_Total_ErrorCount := COUNT(GROUP,h.ca_Invalid>0);
    caseclosed_ALLOW_ErrorCount := COUNT(GROUP,h.caseclosed_Invalid=1);
    caseclosed_LENGTHS_ErrorCount := COUNT(GROUP,h.caseclosed_Invalid=2);
    caseclosed_Total_ErrorCount := COUNT(GROUP,h.caseclosed_Invalid>0);
    dateretrieved_CUSTOM_ErrorCount := COUNT(GROUP,h.dateretrieved_Invalid=1);
    otherdocketnumber_CUSTOM_ErrorCount := COUNT(GROUP,h.otherdocketnumber_Invalid=1);
    litigantname_CUSTOM_ErrorCount := COUNT(GROUP,h.litigantname_Invalid=1);
    litigantlabel_CUSTOM_ErrorCount := COUNT(GROUP,h.litigantlabel_Invalid=1);
    layoutcode_CUSTOM_ErrorCount := COUNT(GROUP,h.layoutcode_Invalid=1);
    terminationdate_CUSTOM_ErrorCount := COUNT(GROUP,h.terminationdate_Invalid=1);
    attorneyname_CUSTOM_ErrorCount := COUNT(GROUP,h.attorneyname_Invalid=1);
    attorneylabel_CUSTOM_ErrorCount := COUNT(GROUP,h.attorneylabel_Invalid=1);
    firmname_CUSTOM_ErrorCount := COUNT(GROUP,h.firmname_Invalid=1);
    address_CUSTOM_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    zipcode_LENGTHS_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=2);
    zipcode_Total_ErrorCount := COUNT(GROUP,h.zipcode_Invalid>0);
    country_CUSTOM_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    termdate_CUSTOM_ErrorCount := COUNT(GROUP,h.termdate_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    did_CUSTOM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    causecode_CUSTOM_ErrorCount := COUNT(GROUP,h.causecode_Invalid=1);
    judge_title_CUSTOM_ErrorCount := COUNT(GROUP,h.judge_title_Invalid=1);
    judge_fname_CUSTOM_ErrorCount := COUNT(GROUP,h.judge_fname_Invalid=1);
    judge_mname_CUSTOM_ErrorCount := COUNT(GROUP,h.judge_mname_Invalid=1);
    judge_lname_CUSTOM_ErrorCount := COUNT(GROUP,h.judge_lname_Invalid=1);
    judge_suffix_CUSTOM_ErrorCount := COUNT(GROUP,h.judge_suffix_Invalid=1);
    judge_score_CUSTOM_ErrorCount := COUNT(GROUP,h.judge_score_Invalid=1);
    business_person_CUSTOM_ErrorCount := COUNT(GROUP,h.business_person_Invalid=1);
    debtor_CUSTOM_ErrorCount := COUNT(GROUP,h.debtor_Invalid=1);
    debtor_title_CUSTOM_ErrorCount := COUNT(GROUP,h.debtor_title_Invalid=1);
    debtor_fname_CUSTOM_ErrorCount := COUNT(GROUP,h.debtor_fname_Invalid=1);
    debtor_mname_CUSTOM_ErrorCount := COUNT(GROUP,h.debtor_mname_Invalid=1);
    debtor_lname_CUSTOM_ErrorCount := COUNT(GROUP,h.debtor_lname_Invalid=1);
    debtor_suffix_CUSTOM_ErrorCount := COUNT(GROUP,h.debtor_suffix_Invalid=1);
    debtor_score_CUSTOM_ErrorCount := COUNT(GROUP,h.debtor_score_Invalid=1);
    attorney_title_CUSTOM_ErrorCount := COUNT(GROUP,h.attorney_title_Invalid=1);
    attorney_fname_CUSTOM_ErrorCount := COUNT(GROUP,h.attorney_fname_Invalid=1);
    attorney_mname_CUSTOM_ErrorCount := COUNT(GROUP,h.attorney_mname_Invalid=1);
    attorney_lname_CUSTOM_ErrorCount := COUNT(GROUP,h.attorney_lname_Invalid=1);
    attorney_suffix_CUSTOM_ErrorCount := COUNT(GROUP,h.attorney_suffix_Invalid=1);
    attorney_score_CUSTOM_ErrorCount := COUNT(GROUP,h.attorney_score_Invalid=1);
    prim_range_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_CUSTOM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_CUSTOM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_CUSTOM_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_CUSTOM_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTHS_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cart_CUSTOM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_CUSTOM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_CUSTOM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_CUSTOM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dbpc_CUSTOM_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    chk_digit_CUSTOM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    rec_type_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    fips_state_CUSTOM_ErrorCount := COUNT(GROUP,h.fips_state_Invalid=1);
    fips_county_CUSTOM_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_CUSTOM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_blk_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_match_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_CUSTOM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.record_type_Invalid > 0 OR h.recid_Invalid > 0 OR h.courtstate_Invalid > 0 OR h.courtid_Invalid > 0 OR h.courtname_Invalid > 0 OR h.docketnumber_Invalid > 0 OR h.officename_Invalid > 0 OR h.asofdate_Invalid > 0 OR h.classcode_Invalid > 0 OR h.casecaption_Invalid > 0 OR h.datefiled_Invalid > 0 OR h.judgetitle_Invalid > 0 OR h.judgename_Invalid > 0 OR h.referredtojudgetitle_Invalid > 0 OR h.referredtojudge_Invalid > 0 OR h.jurydemand_Invalid > 0 OR h.demandamount_Invalid > 0 OR h.suitnaturecode_Invalid > 0 OR h.suitnaturedesc_Invalid > 0 OR h.leaddocketnumber_Invalid > 0 OR h.jurisdiction_Invalid > 0 OR h.cause_Invalid > 0 OR h.statute_Invalid > 0 OR h.ca_Invalid > 0 OR h.caseclosed_Invalid > 0 OR h.dateretrieved_Invalid > 0 OR h.otherdocketnumber_Invalid > 0 OR h.litigantname_Invalid > 0 OR h.litigantlabel_Invalid > 0 OR h.layoutcode_Invalid > 0 OR h.terminationdate_Invalid > 0 OR h.attorneyname_Invalid > 0 OR h.attorneylabel_Invalid > 0 OR h.firmname_Invalid > 0 OR h.address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zipcode_Invalid > 0 OR h.country_Invalid > 0 OR h.termdate_Invalid > 0 OR h.bdid_Invalid > 0 OR h.did_Invalid > 0 OR h.causecode_Invalid > 0 OR h.judge_title_Invalid > 0 OR h.judge_fname_Invalid > 0 OR h.judge_mname_Invalid > 0 OR h.judge_lname_Invalid > 0 OR h.judge_suffix_Invalid > 0 OR h.judge_score_Invalid > 0 OR h.business_person_Invalid > 0 OR h.debtor_Invalid > 0 OR h.debtor_title_Invalid > 0 OR h.debtor_fname_Invalid > 0 OR h.debtor_mname_Invalid > 0 OR h.debtor_lname_Invalid > 0 OR h.debtor_suffix_Invalid > 0 OR h.debtor_score_Invalid > 0 OR h.attorney_title_Invalid > 0 OR h.attorney_fname_Invalid > 0 OR h.attorney_mname_Invalid > 0 OR h.attorney_lname_Invalid > 0 OR h.attorney_suffix_Invalid > 0 OR h.attorney_score_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dbpc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.fips_state_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.recid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.courtstate_Total_ErrorCount > 0, 1, 0) + IF(le.courtid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.courtname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.docketnumber_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.officename_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.asofdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.classcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.casecaption_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.datefiled_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judgetitle_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judgename_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.referredtojudgetitle_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.referredtojudge_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jurydemand_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.demandamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suitnaturecode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.suitnaturedesc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.leaddocketnumber_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jurisdiction_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cause_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.statute_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ca_Total_ErrorCount > 0, 1, 0) + IF(le.caseclosed_Total_ErrorCount > 0, 1, 0) + IF(le.dateretrieved_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.otherdocketnumber_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.litigantname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.litigantlabel_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.layoutcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.terminationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorneyname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorneylabel_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.firmname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.zipcode_Total_ErrorCount > 0, 1, 0) + IF(le.country_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.termdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.causecode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_suffix_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_person_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_suffix_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_suffix_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_desig_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_Total_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_order_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbpc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rec_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_blk_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.recid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.courtstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.courtstate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.courtid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.courtname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.docketnumber_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.officename_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.asofdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.classcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.casecaption_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.datefiled_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judgetitle_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judgename_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.referredtojudgetitle_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.referredtojudge_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jurydemand_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.demandamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suitnaturecode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.suitnaturedesc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.leaddocketnumber_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jurisdiction_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cause_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.statute_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ca_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ca_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.caseclosed_ALLOW_ErrorCount > 0, 1, 0) + IF(le.caseclosed_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dateretrieved_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.otherdocketnumber_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.litigantname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.litigantlabel_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.layoutcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.terminationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorneyname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorneylabel_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.firmname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zipcode_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.country_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.termdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.causecode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_suffix_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judge_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_person_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_suffix_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debtor_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_suffix_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorney_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_desig_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_order_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbpc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rec_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_blk_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.record_type_Invalid,le.recid_Invalid,le.courtstate_Invalid,le.courtid_Invalid,le.courtname_Invalid,le.docketnumber_Invalid,le.officename_Invalid,le.asofdate_Invalid,le.classcode_Invalid,le.casecaption_Invalid,le.datefiled_Invalid,le.judgetitle_Invalid,le.judgename_Invalid,le.referredtojudgetitle_Invalid,le.referredtojudge_Invalid,le.jurydemand_Invalid,le.demandamount_Invalid,le.suitnaturecode_Invalid,le.suitnaturedesc_Invalid,le.leaddocketnumber_Invalid,le.jurisdiction_Invalid,le.cause_Invalid,le.statute_Invalid,le.ca_Invalid,le.caseclosed_Invalid,le.dateretrieved_Invalid,le.otherdocketnumber_Invalid,le.litigantname_Invalid,le.litigantlabel_Invalid,le.layoutcode_Invalid,le.terminationdate_Invalid,le.attorneyname_Invalid,le.attorneylabel_Invalid,le.firmname_Invalid,le.address_Invalid,le.city_Invalid,le.state_Invalid,le.zipcode_Invalid,le.country_Invalid,le.termdate_Invalid,le.bdid_Invalid,le.did_Invalid,le.causecode_Invalid,le.judge_title_Invalid,le.judge_fname_Invalid,le.judge_mname_Invalid,le.judge_lname_Invalid,le.judge_suffix_Invalid,le.judge_score_Invalid,le.business_person_Invalid,le.debtor_Invalid,le.debtor_title_Invalid,le.debtor_fname_Invalid,le.debtor_mname_Invalid,le.debtor_lname_Invalid,le.debtor_suffix_Invalid,le.debtor_score_Invalid,le.attorney_title_Invalid,le.attorney_fname_Invalid,le.attorney_mname_Invalid,le.attorney_lname_Invalid,le.attorney_suffix_Invalid,le.attorney_score_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.fips_state_Invalid,le.fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_record_type(le.record_type_Invalid),Fields.InvalidMessage_recid(le.recid_Invalid),Fields.InvalidMessage_courtstate(le.courtstate_Invalid),Fields.InvalidMessage_courtid(le.courtid_Invalid),Fields.InvalidMessage_courtname(le.courtname_Invalid),Fields.InvalidMessage_docketnumber(le.docketnumber_Invalid),Fields.InvalidMessage_officename(le.officename_Invalid),Fields.InvalidMessage_asofdate(le.asofdate_Invalid),Fields.InvalidMessage_classcode(le.classcode_Invalid),Fields.InvalidMessage_casecaption(le.casecaption_Invalid),Fields.InvalidMessage_datefiled(le.datefiled_Invalid),Fields.InvalidMessage_judgetitle(le.judgetitle_Invalid),Fields.InvalidMessage_judgename(le.judgename_Invalid),Fields.InvalidMessage_referredtojudgetitle(le.referredtojudgetitle_Invalid),Fields.InvalidMessage_referredtojudge(le.referredtojudge_Invalid),Fields.InvalidMessage_jurydemand(le.jurydemand_Invalid),Fields.InvalidMessage_demandamount(le.demandamount_Invalid),Fields.InvalidMessage_suitnaturecode(le.suitnaturecode_Invalid),Fields.InvalidMessage_suitnaturedesc(le.suitnaturedesc_Invalid),Fields.InvalidMessage_leaddocketnumber(le.leaddocketnumber_Invalid),Fields.InvalidMessage_jurisdiction(le.jurisdiction_Invalid),Fields.InvalidMessage_cause(le.cause_Invalid),Fields.InvalidMessage_statute(le.statute_Invalid),Fields.InvalidMessage_ca(le.ca_Invalid),Fields.InvalidMessage_caseclosed(le.caseclosed_Invalid),Fields.InvalidMessage_dateretrieved(le.dateretrieved_Invalid),Fields.InvalidMessage_otherdocketnumber(le.otherdocketnumber_Invalid),Fields.InvalidMessage_litigantname(le.litigantname_Invalid),Fields.InvalidMessage_litigantlabel(le.litigantlabel_Invalid),Fields.InvalidMessage_layoutcode(le.layoutcode_Invalid),Fields.InvalidMessage_terminationdate(le.terminationdate_Invalid),Fields.InvalidMessage_attorneyname(le.attorneyname_Invalid),Fields.InvalidMessage_attorneylabel(le.attorneylabel_Invalid),Fields.InvalidMessage_firmname(le.firmname_Invalid),Fields.InvalidMessage_address(le.address_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zipcode(le.zipcode_Invalid),Fields.InvalidMessage_country(le.country_Invalid),Fields.InvalidMessage_termdate(le.termdate_Invalid),Fields.InvalidMessage_bdid(le.bdid_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_causecode(le.causecode_Invalid),Fields.InvalidMessage_judge_title(le.judge_title_Invalid),Fields.InvalidMessage_judge_fname(le.judge_fname_Invalid),Fields.InvalidMessage_judge_mname(le.judge_mname_Invalid),Fields.InvalidMessage_judge_lname(le.judge_lname_Invalid),Fields.InvalidMessage_judge_suffix(le.judge_suffix_Invalid),Fields.InvalidMessage_judge_score(le.judge_score_Invalid),Fields.InvalidMessage_business_person(le.business_person_Invalid),Fields.InvalidMessage_debtor(le.debtor_Invalid),Fields.InvalidMessage_debtor_title(le.debtor_title_Invalid),Fields.InvalidMessage_debtor_fname(le.debtor_fname_Invalid),Fields.InvalidMessage_debtor_mname(le.debtor_mname_Invalid),Fields.InvalidMessage_debtor_lname(le.debtor_lname_Invalid),Fields.InvalidMessage_debtor_suffix(le.debtor_suffix_Invalid),Fields.InvalidMessage_debtor_score(le.debtor_score_Invalid),Fields.InvalidMessage_attorney_title(le.attorney_title_Invalid),Fields.InvalidMessage_attorney_fname(le.attorney_fname_Invalid),Fields.InvalidMessage_attorney_mname(le.attorney_mname_Invalid),Fields.InvalidMessage_attorney_lname(le.attorney_lname_Invalid),Fields.InvalidMessage_attorney_suffix(le.attorney_suffix_Invalid),Fields.InvalidMessage_attorney_score(le.attorney_score_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_fips_state(le.fips_state_Invalid),Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.recid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.courtstate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.courtid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.courtname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.docketnumber_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.officename_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.asofdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.classcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.casecaption_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.datefiled_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.judgetitle_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.judgename_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.referredtojudgetitle_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.referredtojudge_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jurydemand_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.demandamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suitnaturecode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.suitnaturedesc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.leaddocketnumber_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jurisdiction_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cause_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.statute_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ca_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.caseclosed_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dateretrieved_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.otherdocketnumber_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.litigantname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.litigantlabel_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.layoutcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.terminationdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.attorneyname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.attorneylabel_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.firmname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.termdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.causecode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.judge_title_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.judge_fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.judge_mname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.judge_lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.judge_suffix_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.judge_score_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_person_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debtor_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debtor_title_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debtor_fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debtor_mname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debtor_lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debtor_suffix_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debtor_score_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.attorney_title_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.attorney_fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.attorney_mname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.attorney_lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.attorney_suffix_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.attorney_score_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','recid','courtstate','courtid','courtname','docketnumber','officename','asofdate','classcode','casecaption','datefiled','judgetitle','judgename','referredtojudgetitle','referredtojudge','jurydemand','demandamount','suitnaturecode','suitnaturedesc','leaddocketnumber','jurisdiction','cause','statute','ca','caseclosed','dateretrieved','otherdocketnumber','litigantname','litigantlabel','layoutcode','terminationdate','attorneyname','attorneylabel','firmname','address','city','state','zipcode','country','termdate','bdid','did','causecode','judge_title','judge_fname','judge_mname','judge_lname','judge_suffix','judge_score','business_person','debtor','debtor_title','debtor_fname','debtor_mname','debtor_lname','debtor_suffix','debtor_score','attorney_title','attorney_fname','attorney_mname','attorney_lname','attorney_suffix','attorney_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_No','Invalid_State','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_Date','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_Date','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Float','Invalid_No','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Float','Invalid_YOrN','Invalid_YOrN','Invalid_Date','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_Alpha','Invalid_Date','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.record_type,(SALT311.StrType)le.recid,(SALT311.StrType)le.courtstate,(SALT311.StrType)le.courtid,(SALT311.StrType)le.courtname,(SALT311.StrType)le.docketnumber,(SALT311.StrType)le.officename,(SALT311.StrType)le.asofdate,(SALT311.StrType)le.classcode,(SALT311.StrType)le.casecaption,(SALT311.StrType)le.datefiled,(SALT311.StrType)le.judgetitle,(SALT311.StrType)le.judgename,(SALT311.StrType)le.referredtojudgetitle,(SALT311.StrType)le.referredtojudge,(SALT311.StrType)le.jurydemand,(SALT311.StrType)le.demandamount,(SALT311.StrType)le.suitnaturecode,(SALT311.StrType)le.suitnaturedesc,(SALT311.StrType)le.leaddocketnumber,(SALT311.StrType)le.jurisdiction,(SALT311.StrType)le.cause,(SALT311.StrType)le.statute,(SALT311.StrType)le.ca,(SALT311.StrType)le.caseclosed,(SALT311.StrType)le.dateretrieved,(SALT311.StrType)le.otherdocketnumber,(SALT311.StrType)le.litigantname,(SALT311.StrType)le.litigantlabel,(SALT311.StrType)le.layoutcode,(SALT311.StrType)le.terminationdate,(SALT311.StrType)le.attorneyname,(SALT311.StrType)le.attorneylabel,(SALT311.StrType)le.firmname,(SALT311.StrType)le.address,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zipcode,(SALT311.StrType)le.country,(SALT311.StrType)le.termdate,(SALT311.StrType)le.bdid,(SALT311.StrType)le.did,(SALT311.StrType)le.causecode,(SALT311.StrType)le.judge_title,(SALT311.StrType)le.judge_fname,(SALT311.StrType)le.judge_mname,(SALT311.StrType)le.judge_lname,(SALT311.StrType)le.judge_suffix,(SALT311.StrType)le.judge_score,(SALT311.StrType)le.business_person,(SALT311.StrType)le.debtor,(SALT311.StrType)le.debtor_title,(SALT311.StrType)le.debtor_fname,(SALT311.StrType)le.debtor_mname,(SALT311.StrType)le.debtor_lname,(SALT311.StrType)le.debtor_suffix,(SALT311.StrType)le.debtor_score,(SALT311.StrType)le.attorney_title,(SALT311.StrType)le.attorney_fname,(SALT311.StrType)le.attorney_mname,(SALT311.StrType)le.attorney_lname,(SALT311.StrType)le.attorney_suffix,(SALT311.StrType)le.attorney_score,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dbpc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.rec_type,(SALT311.StrType)le.fips_state,(SALT311.StrType)le.fips_county,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.msa,(SALT311.StrType)le.geo_blk,(SALT311.StrType)le.geo_match,(SALT311.StrType)le.err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,94,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_LitigiousDebtor) prevDS = DATASET([], Layout_LitigiousDebtor), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_CUSTOM_ErrorCount
          ,le.recid_CUSTOM_ErrorCount
          ,le.courtstate_ALLOW_ErrorCount,le.courtstate_LENGTHS_ErrorCount
          ,le.courtid_CUSTOM_ErrorCount
          ,le.courtname_CUSTOM_ErrorCount
          ,le.docketnumber_CUSTOM_ErrorCount
          ,le.officename_CUSTOM_ErrorCount
          ,le.asofdate_CUSTOM_ErrorCount
          ,le.classcode_CUSTOM_ErrorCount
          ,le.casecaption_CUSTOM_ErrorCount
          ,le.datefiled_CUSTOM_ErrorCount
          ,le.judgetitle_CUSTOM_ErrorCount
          ,le.judgename_CUSTOM_ErrorCount
          ,le.referredtojudgetitle_CUSTOM_ErrorCount
          ,le.referredtojudge_CUSTOM_ErrorCount
          ,le.jurydemand_CUSTOM_ErrorCount
          ,le.demandamount_ALLOW_ErrorCount
          ,le.suitnaturecode_CUSTOM_ErrorCount
          ,le.suitnaturedesc_CUSTOM_ErrorCount
          ,le.leaddocketnumber_CUSTOM_ErrorCount
          ,le.jurisdiction_CUSTOM_ErrorCount
          ,le.cause_CUSTOM_ErrorCount
          ,le.statute_ALLOW_ErrorCount
          ,le.ca_ALLOW_ErrorCount,le.ca_LENGTHS_ErrorCount
          ,le.caseclosed_ALLOW_ErrorCount,le.caseclosed_LENGTHS_ErrorCount
          ,le.dateretrieved_CUSTOM_ErrorCount
          ,le.otherdocketnumber_CUSTOM_ErrorCount
          ,le.litigantname_CUSTOM_ErrorCount
          ,le.litigantlabel_CUSTOM_ErrorCount
          ,le.layoutcode_CUSTOM_ErrorCount
          ,le.terminationdate_CUSTOM_ErrorCount
          ,le.attorneyname_CUSTOM_ErrorCount
          ,le.attorneylabel_CUSTOM_ErrorCount
          ,le.firmname_CUSTOM_ErrorCount
          ,le.address_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTHS_ErrorCount
          ,le.country_CUSTOM_ErrorCount
          ,le.termdate_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.did_CUSTOM_ErrorCount
          ,le.causecode_CUSTOM_ErrorCount
          ,le.judge_title_CUSTOM_ErrorCount
          ,le.judge_fname_CUSTOM_ErrorCount
          ,le.judge_mname_CUSTOM_ErrorCount
          ,le.judge_lname_CUSTOM_ErrorCount
          ,le.judge_suffix_CUSTOM_ErrorCount
          ,le.judge_score_CUSTOM_ErrorCount
          ,le.business_person_CUSTOM_ErrorCount
          ,le.debtor_CUSTOM_ErrorCount
          ,le.debtor_title_CUSTOM_ErrorCount
          ,le.debtor_fname_CUSTOM_ErrorCount
          ,le.debtor_mname_CUSTOM_ErrorCount
          ,le.debtor_lname_CUSTOM_ErrorCount
          ,le.debtor_suffix_CUSTOM_ErrorCount
          ,le.debtor_score_CUSTOM_ErrorCount
          ,le.attorney_title_CUSTOM_ErrorCount
          ,le.attorney_fname_CUSTOM_ErrorCount
          ,le.attorney_mname_CUSTOM_ErrorCount
          ,le.attorney_lname_CUSTOM_ErrorCount
          ,le.attorney_suffix_CUSTOM_ErrorCount
          ,le.attorney_score_CUSTOM_ErrorCount
          ,le.prim_range_CUSTOM_ErrorCount
          ,le.predir_CUSTOM_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.addr_suffix_CUSTOM_ErrorCount
          ,le.postdir_CUSTOM_ErrorCount
          ,le.unit_desig_CUSTOM_ErrorCount
          ,le.sec_range_CUSTOM_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTHS_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.cart_CUSTOM_ErrorCount
          ,le.cr_sort_sz_CUSTOM_ErrorCount
          ,le.lot_CUSTOM_ErrorCount
          ,le.lot_order_CUSTOM_ErrorCount
          ,le.dbpc_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount
          ,le.fips_state_CUSTOM_ErrorCount
          ,le.fips_county_CUSTOM_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.geo_blk_CUSTOM_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_CUSTOM_ErrorCount
          ,le.recid_CUSTOM_ErrorCount
          ,le.courtstate_ALLOW_ErrorCount,le.courtstate_LENGTHS_ErrorCount
          ,le.courtid_CUSTOM_ErrorCount
          ,le.courtname_CUSTOM_ErrorCount
          ,le.docketnumber_CUSTOM_ErrorCount
          ,le.officename_CUSTOM_ErrorCount
          ,le.asofdate_CUSTOM_ErrorCount
          ,le.classcode_CUSTOM_ErrorCount
          ,le.casecaption_CUSTOM_ErrorCount
          ,le.datefiled_CUSTOM_ErrorCount
          ,le.judgetitle_CUSTOM_ErrorCount
          ,le.judgename_CUSTOM_ErrorCount
          ,le.referredtojudgetitle_CUSTOM_ErrorCount
          ,le.referredtojudge_CUSTOM_ErrorCount
          ,le.jurydemand_CUSTOM_ErrorCount
          ,le.demandamount_ALLOW_ErrorCount
          ,le.suitnaturecode_CUSTOM_ErrorCount
          ,le.suitnaturedesc_CUSTOM_ErrorCount
          ,le.leaddocketnumber_CUSTOM_ErrorCount
          ,le.jurisdiction_CUSTOM_ErrorCount
          ,le.cause_CUSTOM_ErrorCount
          ,le.statute_ALLOW_ErrorCount
          ,le.ca_ALLOW_ErrorCount,le.ca_LENGTHS_ErrorCount
          ,le.caseclosed_ALLOW_ErrorCount,le.caseclosed_LENGTHS_ErrorCount
          ,le.dateretrieved_CUSTOM_ErrorCount
          ,le.otherdocketnumber_CUSTOM_ErrorCount
          ,le.litigantname_CUSTOM_ErrorCount
          ,le.litigantlabel_CUSTOM_ErrorCount
          ,le.layoutcode_CUSTOM_ErrorCount
          ,le.terminationdate_CUSTOM_ErrorCount
          ,le.attorneyname_CUSTOM_ErrorCount
          ,le.attorneylabel_CUSTOM_ErrorCount
          ,le.firmname_CUSTOM_ErrorCount
          ,le.address_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTHS_ErrorCount
          ,le.country_CUSTOM_ErrorCount
          ,le.termdate_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.did_CUSTOM_ErrorCount
          ,le.causecode_CUSTOM_ErrorCount
          ,le.judge_title_CUSTOM_ErrorCount
          ,le.judge_fname_CUSTOM_ErrorCount
          ,le.judge_mname_CUSTOM_ErrorCount
          ,le.judge_lname_CUSTOM_ErrorCount
          ,le.judge_suffix_CUSTOM_ErrorCount
          ,le.judge_score_CUSTOM_ErrorCount
          ,le.business_person_CUSTOM_ErrorCount
          ,le.debtor_CUSTOM_ErrorCount
          ,le.debtor_title_CUSTOM_ErrorCount
          ,le.debtor_fname_CUSTOM_ErrorCount
          ,le.debtor_mname_CUSTOM_ErrorCount
          ,le.debtor_lname_CUSTOM_ErrorCount
          ,le.debtor_suffix_CUSTOM_ErrorCount
          ,le.debtor_score_CUSTOM_ErrorCount
          ,le.attorney_title_CUSTOM_ErrorCount
          ,le.attorney_fname_CUSTOM_ErrorCount
          ,le.attorney_mname_CUSTOM_ErrorCount
          ,le.attorney_lname_CUSTOM_ErrorCount
          ,le.attorney_suffix_CUSTOM_ErrorCount
          ,le.attorney_score_CUSTOM_ErrorCount
          ,le.prim_range_CUSTOM_ErrorCount
          ,le.predir_CUSTOM_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.addr_suffix_CUSTOM_ErrorCount
          ,le.postdir_CUSTOM_ErrorCount
          ,le.unit_desig_CUSTOM_ErrorCount
          ,le.sec_range_CUSTOM_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTHS_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.cart_CUSTOM_ErrorCount
          ,le.cr_sort_sz_CUSTOM_ErrorCount
          ,le.lot_CUSTOM_ErrorCount
          ,le.lot_order_CUSTOM_ErrorCount
          ,le.dbpc_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount
          ,le.fips_state_CUSTOM_ErrorCount
          ,le.fips_county_CUSTOM_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.geo_blk_CUSTOM_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_LitigiousDebtor));
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
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recid:' + getFieldTypeText(h.recid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtstate:' + getFieldTypeText(h.courtstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtid:' + getFieldTypeText(h.courtid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtname:' + getFieldTypeText(h.courtname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'docketnumber:' + getFieldTypeText(h.docketnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officename:' + getFieldTypeText(h.officename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'asofdate:' + getFieldTypeText(h.asofdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classcode:' + getFieldTypeText(h.classcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casecaption:' + getFieldTypeText(h.casecaption) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'datefiled:' + getFieldTypeText(h.datefiled) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judgetitle:' + getFieldTypeText(h.judgetitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judgename:' + getFieldTypeText(h.judgename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'referredtojudgetitle:' + getFieldTypeText(h.referredtojudgetitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'referredtojudge:' + getFieldTypeText(h.referredtojudge) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jurydemand:' + getFieldTypeText(h.jurydemand) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'demandamount:' + getFieldTypeText(h.demandamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suitnaturecode:' + getFieldTypeText(h.suitnaturecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suitnaturedesc:' + getFieldTypeText(h.suitnaturedesc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'leaddocketnumber:' + getFieldTypeText(h.leaddocketnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jurisdiction:' + getFieldTypeText(h.jurisdiction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cause:' + getFieldTypeText(h.cause) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statute:' + getFieldTypeText(h.statute) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ca:' + getFieldTypeText(h.ca) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'caseclosed:' + getFieldTypeText(h.caseclosed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateretrieved:' + getFieldTypeText(h.dateretrieved) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'otherdocketnumber:' + getFieldTypeText(h.otherdocketnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'litigantname:' + getFieldTypeText(h.litigantname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'litigantlabel:' + getFieldTypeText(h.litigantlabel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'layoutcode:' + getFieldTypeText(h.layoutcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'terminationdate:' + getFieldTypeText(h.terminationdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneyname:' + getFieldTypeText(h.attorneyname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneylabel:' + getFieldTypeText(h.attorneylabel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmname:' + getFieldTypeText(h.firmname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address:' + getFieldTypeText(h.address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zipcode:' + getFieldTypeText(h.zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country:' + getFieldTypeText(h.country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addtlinfo:' + getFieldTypeText(h.addtlinfo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'termdate:' + getFieldTypeText(h.termdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'causecode:' + getFieldTypeText(h.causecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judge_title:' + getFieldTypeText(h.judge_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judge_fname:' + getFieldTypeText(h.judge_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judge_mname:' + getFieldTypeText(h.judge_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judge_lname:' + getFieldTypeText(h.judge_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judge_suffix:' + getFieldTypeText(h.judge_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judge_score:' + getFieldTypeText(h.judge_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_person:' + getFieldTypeText(h.business_person) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtor:' + getFieldTypeText(h.debtor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtor_title:' + getFieldTypeText(h.debtor_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtor_fname:' + getFieldTypeText(h.debtor_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtor_mname:' + getFieldTypeText(h.debtor_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtor_lname:' + getFieldTypeText(h.debtor_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtor_suffix:' + getFieldTypeText(h.debtor_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debtor_score:' + getFieldTypeText(h.debtor_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorney_title:' + getFieldTypeText(h.attorney_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorney_fname:' + getFieldTypeText(h.attorney_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorney_mname:' + getFieldTypeText(h.attorney_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorney_lname:' + getFieldTypeText(h.attorney_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorney_suffix:' + getFieldTypeText(h.attorney_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorney_score:' + getFieldTypeText(h.attorney_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'fips_state:' + getFieldTypeText(h.fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_record_type_cnt
          ,le.populated_recid_cnt
          ,le.populated_courtstate_cnt
          ,le.populated_courtid_cnt
          ,le.populated_courtname_cnt
          ,le.populated_docketnumber_cnt
          ,le.populated_officename_cnt
          ,le.populated_asofdate_cnt
          ,le.populated_classcode_cnt
          ,le.populated_casecaption_cnt
          ,le.populated_datefiled_cnt
          ,le.populated_judgetitle_cnt
          ,le.populated_judgename_cnt
          ,le.populated_referredtojudgetitle_cnt
          ,le.populated_referredtojudge_cnt
          ,le.populated_jurydemand_cnt
          ,le.populated_demandamount_cnt
          ,le.populated_suitnaturecode_cnt
          ,le.populated_suitnaturedesc_cnt
          ,le.populated_leaddocketnumber_cnt
          ,le.populated_jurisdiction_cnt
          ,le.populated_cause_cnt
          ,le.populated_statute_cnt
          ,le.populated_ca_cnt
          ,le.populated_caseclosed_cnt
          ,le.populated_dateretrieved_cnt
          ,le.populated_otherdocketnumber_cnt
          ,le.populated_litigantname_cnt
          ,le.populated_litigantlabel_cnt
          ,le.populated_layoutcode_cnt
          ,le.populated_terminationdate_cnt
          ,le.populated_attorneyname_cnt
          ,le.populated_attorneylabel_cnt
          ,le.populated_firmname_cnt
          ,le.populated_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zipcode_cnt
          ,le.populated_country_cnt
          ,le.populated_addtlinfo_cnt
          ,le.populated_termdate_cnt
          ,le.populated_bdid_cnt
          ,le.populated_did_cnt
          ,le.populated_causecode_cnt
          ,le.populated_judge_title_cnt
          ,le.populated_judge_fname_cnt
          ,le.populated_judge_mname_cnt
          ,le.populated_judge_lname_cnt
          ,le.populated_judge_suffix_cnt
          ,le.populated_judge_score_cnt
          ,le.populated_business_person_cnt
          ,le.populated_debtor_cnt
          ,le.populated_debtor_title_cnt
          ,le.populated_debtor_fname_cnt
          ,le.populated_debtor_mname_cnt
          ,le.populated_debtor_lname_cnt
          ,le.populated_debtor_suffix_cnt
          ,le.populated_debtor_score_cnt
          ,le.populated_attorney_title_cnt
          ,le.populated_attorney_fname_cnt
          ,le.populated_attorney_mname_cnt
          ,le.populated_attorney_lname_cnt
          ,le.populated_attorney_suffix_cnt
          ,le.populated_attorney_score_cnt
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
          ,le.populated_fips_state_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_recid_pcnt
          ,le.populated_courtstate_pcnt
          ,le.populated_courtid_pcnt
          ,le.populated_courtname_pcnt
          ,le.populated_docketnumber_pcnt
          ,le.populated_officename_pcnt
          ,le.populated_asofdate_pcnt
          ,le.populated_classcode_pcnt
          ,le.populated_casecaption_pcnt
          ,le.populated_datefiled_pcnt
          ,le.populated_judgetitle_pcnt
          ,le.populated_judgename_pcnt
          ,le.populated_referredtojudgetitle_pcnt
          ,le.populated_referredtojudge_pcnt
          ,le.populated_jurydemand_pcnt
          ,le.populated_demandamount_pcnt
          ,le.populated_suitnaturecode_pcnt
          ,le.populated_suitnaturedesc_pcnt
          ,le.populated_leaddocketnumber_pcnt
          ,le.populated_jurisdiction_pcnt
          ,le.populated_cause_pcnt
          ,le.populated_statute_pcnt
          ,le.populated_ca_pcnt
          ,le.populated_caseclosed_pcnt
          ,le.populated_dateretrieved_pcnt
          ,le.populated_otherdocketnumber_pcnt
          ,le.populated_litigantname_pcnt
          ,le.populated_litigantlabel_pcnt
          ,le.populated_layoutcode_pcnt
          ,le.populated_terminationdate_pcnt
          ,le.populated_attorneyname_pcnt
          ,le.populated_attorneylabel_pcnt
          ,le.populated_firmname_pcnt
          ,le.populated_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zipcode_pcnt
          ,le.populated_country_pcnt
          ,le.populated_addtlinfo_pcnt
          ,le.populated_termdate_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_did_pcnt
          ,le.populated_causecode_pcnt
          ,le.populated_judge_title_pcnt
          ,le.populated_judge_fname_pcnt
          ,le.populated_judge_mname_pcnt
          ,le.populated_judge_lname_pcnt
          ,le.populated_judge_suffix_pcnt
          ,le.populated_judge_score_pcnt
          ,le.populated_business_person_pcnt
          ,le.populated_debtor_pcnt
          ,le.populated_debtor_title_pcnt
          ,le.populated_debtor_fname_pcnt
          ,le.populated_debtor_mname_pcnt
          ,le.populated_debtor_lname_pcnt
          ,le.populated_debtor_suffix_pcnt
          ,le.populated_debtor_score_pcnt
          ,le.populated_attorney_title_pcnt
          ,le.populated_attorney_fname_pcnt
          ,le.populated_attorney_mname_pcnt
          ,le.populated_attorney_lname_pcnt
          ,le.populated_attorney_suffix_pcnt
          ,le.populated_attorney_score_pcnt
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
          ,le.populated_fips_state_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,95,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_LitigiousDebtor));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),95,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_LitigiousDebtor) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_LitigiousDebtor, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
