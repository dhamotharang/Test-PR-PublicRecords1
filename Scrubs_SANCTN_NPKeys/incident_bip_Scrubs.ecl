IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT incident_bip_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(incident_bip_Layout_SANCTN_NPKeys)
    UNSIGNED1 dotid_Invalid;
    UNSIGNED1 dotscore_Invalid;
    UNSIGNED1 dotweight_Invalid;
    UNSIGNED1 empid_Invalid;
    UNSIGNED1 empscore_Invalid;
    UNSIGNED1 empweight_Invalid;
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 powscore_Invalid;
    UNSIGNED1 powweight_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 proxscore_Invalid;
    UNSIGNED1 proxweight_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 selescore_Invalid;
    UNSIGNED1 seleweight_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 orgscore_Invalid;
    UNSIGNED1 orgweight_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 ultscore_Invalid;
    UNSIGNED1 ultweight_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
    UNSIGNED1 batch_Invalid;
    UNSIGNED1 batch_date_Invalid;
    UNSIGNED1 dbcode_Invalid;
    UNSIGNED1 incident_num_Invalid;
    UNSIGNED1 incident_date_Invalid;
    UNSIGNED1 int_key_Invalid;
    UNSIGNED1 srce_cd_Invalid;
    UNSIGNED1 modified_date_Invalid;
    UNSIGNED1 entry_date_Invalid;
    UNSIGNED1 submitter_phone_Invalid;
    UNSIGNED1 submitter_fax_Invalid;
    UNSIGNED1 prop_state_Invalid;
    UNSIGNED1 prop_zip_Invalid;
    UNSIGNED1 aid_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 name_suffix_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(incident_bip_Layout_SANCTN_NPKeys)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(incident_bip_Layout_SANCTN_NPKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dotid_Invalid := incident_bip_Fields.InValid_dotid((SALT33.StrType)le.dotid);
    SELF.dotscore_Invalid := incident_bip_Fields.InValid_dotscore((SALT33.StrType)le.dotscore);
    SELF.dotweight_Invalid := incident_bip_Fields.InValid_dotweight((SALT33.StrType)le.dotweight);
    SELF.empid_Invalid := incident_bip_Fields.InValid_empid((SALT33.StrType)le.empid);
    SELF.empscore_Invalid := incident_bip_Fields.InValid_empscore((SALT33.StrType)le.empscore);
    SELF.empweight_Invalid := incident_bip_Fields.InValid_empweight((SALT33.StrType)le.empweight);
    SELF.powid_Invalid := incident_bip_Fields.InValid_powid((SALT33.StrType)le.powid);
    SELF.powscore_Invalid := incident_bip_Fields.InValid_powscore((SALT33.StrType)le.powscore);
    SELF.powweight_Invalid := incident_bip_Fields.InValid_powweight((SALT33.StrType)le.powweight);
    SELF.proxid_Invalid := incident_bip_Fields.InValid_proxid((SALT33.StrType)le.proxid);
    SELF.proxscore_Invalid := incident_bip_Fields.InValid_proxscore((SALT33.StrType)le.proxscore);
    SELF.proxweight_Invalid := incident_bip_Fields.InValid_proxweight((SALT33.StrType)le.proxweight);
    SELF.seleid_Invalid := incident_bip_Fields.InValid_seleid((SALT33.StrType)le.seleid);
    SELF.selescore_Invalid := incident_bip_Fields.InValid_selescore((SALT33.StrType)le.selescore);
    SELF.seleweight_Invalid := incident_bip_Fields.InValid_seleweight((SALT33.StrType)le.seleweight);
    SELF.orgid_Invalid := incident_bip_Fields.InValid_orgid((SALT33.StrType)le.orgid);
    SELF.orgscore_Invalid := incident_bip_Fields.InValid_orgscore((SALT33.StrType)le.orgscore);
    SELF.orgweight_Invalid := incident_bip_Fields.InValid_orgweight((SALT33.StrType)le.orgweight);
    SELF.ultid_Invalid := incident_bip_Fields.InValid_ultid((SALT33.StrType)le.ultid);
    SELF.ultscore_Invalid := incident_bip_Fields.InValid_ultscore((SALT33.StrType)le.ultscore);
    SELF.ultweight_Invalid := incident_bip_Fields.InValid_ultweight((SALT33.StrType)le.ultweight);
    SELF.source_rec_id_Invalid := incident_bip_Fields.InValid_source_rec_id((SALT33.StrType)le.source_rec_id);
    SELF.batch_Invalid := incident_bip_Fields.InValid_batch((SALT33.StrType)le.batch);
    SELF.batch_date_Invalid := incident_bip_Fields.InValid_batch_date((SALT33.StrType)le.batch_date);
    SELF.dbcode_Invalid := incident_bip_Fields.InValid_dbcode((SALT33.StrType)le.dbcode);
    SELF.incident_num_Invalid := incident_bip_Fields.InValid_incident_num((SALT33.StrType)le.incident_num);
    SELF.incident_date_Invalid := incident_bip_Fields.InValid_incident_date((SALT33.StrType)le.incident_date);
    SELF.int_key_Invalid := incident_bip_Fields.InValid_int_key((SALT33.StrType)le.int_key);
    SELF.srce_cd_Invalid := incident_bip_Fields.InValid_srce_cd((SALT33.StrType)le.srce_cd);
    SELF.modified_date_Invalid := incident_bip_Fields.InValid_modified_date((SALT33.StrType)le.modified_date);
    SELF.entry_date_Invalid := incident_bip_Fields.InValid_entry_date((SALT33.StrType)le.entry_date);
    SELF.submitter_phone_Invalid := incident_bip_Fields.InValid_submitter_phone((SALT33.StrType)le.submitter_phone);
    SELF.submitter_fax_Invalid := incident_bip_Fields.InValid_submitter_fax((SALT33.StrType)le.submitter_fax);
    SELF.prop_state_Invalid := incident_bip_Fields.InValid_prop_state((SALT33.StrType)le.prop_state);
    SELF.prop_zip_Invalid := incident_bip_Fields.InValid_prop_zip((SALT33.StrType)le.prop_zip);
    SELF.aid_Invalid := incident_bip_Fields.InValid_aid((SALT33.StrType)le.aid);
    SELF.did_Invalid := incident_bip_Fields.InValid_did((SALT33.StrType)le.did);
    SELF.did_score_Invalid := incident_bip_Fields.InValid_did_score((SALT33.StrType)le.did_score);
    SELF.bdid_Invalid := incident_bip_Fields.InValid_bdid((SALT33.StrType)le.bdid);
    SELF.bdid_score_Invalid := incident_bip_Fields.InValid_bdid_score((SALT33.StrType)le.bdid_score);
    SELF.name_suffix_Invalid := incident_bip_Fields.InValid_name_suffix((SALT33.StrType)le.name_suffix);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),incident_bip_Layout_SANCTN_NPKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dotid_Invalid << 0 ) + ( le.dotscore_Invalid << 1 ) + ( le.dotweight_Invalid << 2 ) + ( le.empid_Invalid << 3 ) + ( le.empscore_Invalid << 4 ) + ( le.empweight_Invalid << 5 ) + ( le.powid_Invalid << 6 ) + ( le.powscore_Invalid << 7 ) + ( le.powweight_Invalid << 8 ) + ( le.proxid_Invalid << 9 ) + ( le.proxscore_Invalid << 10 ) + ( le.proxweight_Invalid << 11 ) + ( le.seleid_Invalid << 12 ) + ( le.selescore_Invalid << 13 ) + ( le.seleweight_Invalid << 14 ) + ( le.orgid_Invalid << 15 ) + ( le.orgscore_Invalid << 16 ) + ( le.orgweight_Invalid << 17 ) + ( le.ultid_Invalid << 18 ) + ( le.ultscore_Invalid << 19 ) + ( le.ultweight_Invalid << 20 ) + ( le.source_rec_id_Invalid << 21 ) + ( le.batch_Invalid << 22 ) + ( le.batch_date_Invalid << 24 ) + ( le.dbcode_Invalid << 25 ) + ( le.incident_num_Invalid << 26 ) + ( le.incident_date_Invalid << 27 ) + ( le.int_key_Invalid << 28 ) + ( le.srce_cd_Invalid << 29 ) + ( le.modified_date_Invalid << 30 ) + ( le.entry_date_Invalid << 31 ) + ( le.submitter_phone_Invalid << 32 ) + ( le.submitter_fax_Invalid << 33 ) + ( le.prop_state_Invalid << 34 ) + ( le.prop_zip_Invalid << 35 ) + ( le.aid_Invalid << 36 ) + ( le.did_Invalid << 37 ) + ( le.did_score_Invalid << 38 ) + ( le.bdid_Invalid << 39 ) + ( le.bdid_score_Invalid << 40 ) + ( le.name_suffix_Invalid << 41 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,incident_bip_Layout_SANCTN_NPKeys);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dotid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dotscore_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dotweight_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.empid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.empscore_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.empweight_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.powid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.powscore_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.powweight_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.proxscore_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.proxweight_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.selescore_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.seleweight_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orgscore_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.orgweight_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.ultscore_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.ultweight_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.batch_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.batch_date_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.dbcode_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.incident_num_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.incident_date_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.int_key_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.srce_cd_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.modified_date_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.entry_date_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.submitter_phone_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.submitter_fax_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.prop_state_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.prop_zip_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.aid_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.bdid_score_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.dbcode;
    TotalCnt := COUNT(GROUP); // Number of records in total
    dotid_ALLOW_ErrorCount := COUNT(GROUP,h.dotid_Invalid=1);
    dotscore_ALLOW_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=1);
    dotweight_ALLOW_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=1);
    empid_ALLOW_ErrorCount := COUNT(GROUP,h.empid_Invalid=1);
    empscore_ALLOW_ErrorCount := COUNT(GROUP,h.empscore_Invalid=1);
    empweight_ALLOW_ErrorCount := COUNT(GROUP,h.empweight_Invalid=1);
    powid_ALLOW_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    powscore_ALLOW_ErrorCount := COUNT(GROUP,h.powscore_Invalid=1);
    powweight_ALLOW_ErrorCount := COUNT(GROUP,h.powweight_Invalid=1);
    proxid_ALLOW_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    proxscore_ALLOW_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=1);
    proxweight_ALLOW_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=1);
    seleid_ALLOW_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    selescore_ALLOW_ErrorCount := COUNT(GROUP,h.selescore_Invalid=1);
    seleweight_ALLOW_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=1);
    orgid_ALLOW_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgscore_ALLOW_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=1);
    orgweight_ALLOW_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=1);
    ultid_ALLOW_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultscore_ALLOW_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=1);
    ultweight_ALLOW_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=1);
    source_rec_id_ALLOW_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    batch_ALLOW_ErrorCount := COUNT(GROUP,h.batch_Invalid=1);
    batch_LENGTH_ErrorCount := COUNT(GROUP,h.batch_Invalid=2);
    batch_Total_ErrorCount := COUNT(GROUP,h.batch_Invalid>0);
    batch_date_CUSTOM_ErrorCount := COUNT(GROUP,h.batch_date_Invalid=1);
    dbcode_ENUM_ErrorCount := COUNT(GROUP,h.dbcode_Invalid=1);
    incident_num_ALLOW_ErrorCount := COUNT(GROUP,h.incident_num_Invalid=1);
    incident_date_CUSTOM_ErrorCount := COUNT(GROUP,h.incident_date_Invalid=1);
    int_key_ALLOW_ErrorCount := COUNT(GROUP,h.int_key_Invalid=1);
    srce_cd_ALLOW_ErrorCount := COUNT(GROUP,h.srce_cd_Invalid=1);
    modified_date_CUSTOM_ErrorCount := COUNT(GROUP,h.modified_date_Invalid=1);
    entry_date_CUSTOM_ErrorCount := COUNT(GROUP,h.entry_date_Invalid=1);
    submitter_phone_ALLOW_ErrorCount := COUNT(GROUP,h.submitter_phone_Invalid=1);
    submitter_fax_ALLOW_ErrorCount := COUNT(GROUP,h.submitter_fax_Invalid=1);
    prop_state_CUSTOM_ErrorCount := COUNT(GROUP,h.prop_state_Invalid=1);
    prop_zip_ALLOW_ErrorCount := COUNT(GROUP,h.prop_zip_Invalid=1);
    aid_ALLOW_ErrorCount := COUNT(GROUP,h.aid_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_score_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    name_suffix_ENUM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,dbcode,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.dbcode;
    UNSIGNED1 ErrNum := CHOOSE(c,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,le.source_rec_id_Invalid,le.batch_Invalid,le.batch_date_Invalid,le.dbcode_Invalid,le.incident_num_Invalid,le.incident_date_Invalid,le.int_key_Invalid,le.srce_cd_Invalid,le.modified_date_Invalid,le.entry_date_Invalid,le.submitter_phone_Invalid,le.submitter_fax_Invalid,le.prop_state_Invalid,le.prop_zip_Invalid,le.aid_Invalid,le.did_Invalid,le.did_score_Invalid,le.bdid_Invalid,le.bdid_score_Invalid,le.name_suffix_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,incident_bip_Fields.InvalidMessage_dotid(le.dotid_Invalid),incident_bip_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),incident_bip_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),incident_bip_Fields.InvalidMessage_empid(le.empid_Invalid),incident_bip_Fields.InvalidMessage_empscore(le.empscore_Invalid),incident_bip_Fields.InvalidMessage_empweight(le.empweight_Invalid),incident_bip_Fields.InvalidMessage_powid(le.powid_Invalid),incident_bip_Fields.InvalidMessage_powscore(le.powscore_Invalid),incident_bip_Fields.InvalidMessage_powweight(le.powweight_Invalid),incident_bip_Fields.InvalidMessage_proxid(le.proxid_Invalid),incident_bip_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),incident_bip_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),incident_bip_Fields.InvalidMessage_seleid(le.seleid_Invalid),incident_bip_Fields.InvalidMessage_selescore(le.selescore_Invalid),incident_bip_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),incident_bip_Fields.InvalidMessage_orgid(le.orgid_Invalid),incident_bip_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),incident_bip_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),incident_bip_Fields.InvalidMessage_ultid(le.ultid_Invalid),incident_bip_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),incident_bip_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),incident_bip_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),incident_bip_Fields.InvalidMessage_batch(le.batch_Invalid),incident_bip_Fields.InvalidMessage_batch_date(le.batch_date_Invalid),incident_bip_Fields.InvalidMessage_dbcode(le.dbcode_Invalid),incident_bip_Fields.InvalidMessage_incident_num(le.incident_num_Invalid),incident_bip_Fields.InvalidMessage_incident_date(le.incident_date_Invalid),incident_bip_Fields.InvalidMessage_int_key(le.int_key_Invalid),incident_bip_Fields.InvalidMessage_srce_cd(le.srce_cd_Invalid),incident_bip_Fields.InvalidMessage_modified_date(le.modified_date_Invalid),incident_bip_Fields.InvalidMessage_entry_date(le.entry_date_Invalid),incident_bip_Fields.InvalidMessage_submitter_phone(le.submitter_phone_Invalid),incident_bip_Fields.InvalidMessage_submitter_fax(le.submitter_fax_Invalid),incident_bip_Fields.InvalidMessage_prop_state(le.prop_state_Invalid),incident_bip_Fields.InvalidMessage_prop_zip(le.prop_zip_Invalid),incident_bip_Fields.InvalidMessage_aid(le.aid_Invalid),incident_bip_Fields.InvalidMessage_did(le.did_Invalid),incident_bip_Fields.InvalidMessage_did_score(le.did_score_Invalid),incident_bip_Fields.InvalidMessage_bdid(le.bdid_Invalid),incident_bip_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),incident_bip_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dotid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dotscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dotweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.empid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.empscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.empweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.powscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.powweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.selescore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seleweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orgscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orgweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ultscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ultweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.batch_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.batch_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dbcode_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.incident_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.incident_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.int_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.srce_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.modified_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.entry_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.submitter_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitter_fax_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prop_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prop_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','batch','batch_date','dbcode','incident_num','incident_date','int_key','srce_cd','modified_date','entry_date','submitter_phone','submitter_fax','prop_state','prop_zip','aid','did','did_score','bdid','bdid_score','name_suffix','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Batch','Invalid_CurrentDate','Invalid_DBCode','Invalid_Num','Invalid_CurrentDate','Invalid_Num','Invalid_Srce_Cd','Invalid_CurrentDate','Invalid_CurrentDate','Invalid_Num','Invalid_Num','Invalid_State','Invalid_Zip','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Suffix','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.dotid,(SALT33.StrType)le.dotscore,(SALT33.StrType)le.dotweight,(SALT33.StrType)le.empid,(SALT33.StrType)le.empscore,(SALT33.StrType)le.empweight,(SALT33.StrType)le.powid,(SALT33.StrType)le.powscore,(SALT33.StrType)le.powweight,(SALT33.StrType)le.proxid,(SALT33.StrType)le.proxscore,(SALT33.StrType)le.proxweight,(SALT33.StrType)le.seleid,(SALT33.StrType)le.selescore,(SALT33.StrType)le.seleweight,(SALT33.StrType)le.orgid,(SALT33.StrType)le.orgscore,(SALT33.StrType)le.orgweight,(SALT33.StrType)le.ultid,(SALT33.StrType)le.ultscore,(SALT33.StrType)le.ultweight,(SALT33.StrType)le.source_rec_id,(SALT33.StrType)le.batch,(SALT33.StrType)le.batch_date,(SALT33.StrType)le.dbcode,(SALT33.StrType)le.incident_num,(SALT33.StrType)le.incident_date,(SALT33.StrType)le.int_key,(SALT33.StrType)le.srce_cd,(SALT33.StrType)le.modified_date,(SALT33.StrType)le.entry_date,(SALT33.StrType)le.submitter_phone,(SALT33.StrType)le.submitter_fax,(SALT33.StrType)le.prop_state,(SALT33.StrType)le.prop_zip,(SALT33.StrType)le.aid,(SALT33.StrType)le.did,(SALT33.StrType)le.did_score,(SALT33.StrType)le.bdid,(SALT33.StrType)le.bdid_score,(SALT33.StrType)le.name_suffix,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,41,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.dbcode;
      SELF.ruledesc := CHOOSE(c
          ,'dotid:Invalid_Num:ALLOW'
          ,'dotscore:Invalid_Num:ALLOW'
          ,'dotweight:Invalid_Num:ALLOW'
          ,'empid:Invalid_Num:ALLOW'
          ,'empscore:Invalid_Num:ALLOW'
          ,'empweight:Invalid_Num:ALLOW'
          ,'powid:Invalid_Num:ALLOW'
          ,'powscore:Invalid_Num:ALLOW'
          ,'powweight:Invalid_Num:ALLOW'
          ,'proxid:Invalid_Num:ALLOW'
          ,'proxscore:Invalid_Num:ALLOW'
          ,'proxweight:Invalid_Num:ALLOW'
          ,'seleid:Invalid_Num:ALLOW'
          ,'selescore:Invalid_Num:ALLOW'
          ,'seleweight:Invalid_Num:ALLOW'
          ,'orgid:Invalid_Num:ALLOW'
          ,'orgscore:Invalid_Num:ALLOW'
          ,'orgweight:Invalid_Num:ALLOW'
          ,'ultid:Invalid_Num:ALLOW'
          ,'ultscore:Invalid_Num:ALLOW'
          ,'ultweight:Invalid_Num:ALLOW'
          ,'source_rec_id:Invalid_Num:ALLOW'
          ,'batch:Invalid_Batch:ALLOW','batch:Invalid_Batch:LENGTH'
          ,'batch_date:Invalid_CurrentDate:CUSTOM'
          ,'dbcode:Invalid_DBCode:ENUM'
          ,'incident_num:Invalid_Num:ALLOW'
          ,'incident_date:Invalid_CurrentDate:CUSTOM'
          ,'int_key:Invalid_Num:ALLOW'
          ,'srce_cd:Invalid_Srce_Cd:ALLOW'
          ,'modified_date:Invalid_CurrentDate:CUSTOM'
          ,'entry_date:Invalid_CurrentDate:CUSTOM'
          ,'submitter_phone:Invalid_Num:ALLOW'
          ,'submitter_fax:Invalid_Num:ALLOW'
          ,'prop_state:Invalid_State:CUSTOM'
          ,'prop_zip:Invalid_Zip:ALLOW'
          ,'aid:Invalid_Num:ALLOW'
          ,'did:Invalid_Num:ALLOW'
          ,'did_score:Invalid_Num:ALLOW'
          ,'bdid:Invalid_Num:ALLOW'
          ,'bdid_score:Invalid_Num:ALLOW'
          ,'name_suffix:Invalid_Suffix:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,incident_bip_Fields.InvalidMessage_dotid(1)
          ,incident_bip_Fields.InvalidMessage_dotscore(1)
          ,incident_bip_Fields.InvalidMessage_dotweight(1)
          ,incident_bip_Fields.InvalidMessage_empid(1)
          ,incident_bip_Fields.InvalidMessage_empscore(1)
          ,incident_bip_Fields.InvalidMessage_empweight(1)
          ,incident_bip_Fields.InvalidMessage_powid(1)
          ,incident_bip_Fields.InvalidMessage_powscore(1)
          ,incident_bip_Fields.InvalidMessage_powweight(1)
          ,incident_bip_Fields.InvalidMessage_proxid(1)
          ,incident_bip_Fields.InvalidMessage_proxscore(1)
          ,incident_bip_Fields.InvalidMessage_proxweight(1)
          ,incident_bip_Fields.InvalidMessage_seleid(1)
          ,incident_bip_Fields.InvalidMessage_selescore(1)
          ,incident_bip_Fields.InvalidMessage_seleweight(1)
          ,incident_bip_Fields.InvalidMessage_orgid(1)
          ,incident_bip_Fields.InvalidMessage_orgscore(1)
          ,incident_bip_Fields.InvalidMessage_orgweight(1)
          ,incident_bip_Fields.InvalidMessage_ultid(1)
          ,incident_bip_Fields.InvalidMessage_ultscore(1)
          ,incident_bip_Fields.InvalidMessage_ultweight(1)
          ,incident_bip_Fields.InvalidMessage_source_rec_id(1)
          ,incident_bip_Fields.InvalidMessage_batch(1),incident_bip_Fields.InvalidMessage_batch(2)
          ,incident_bip_Fields.InvalidMessage_batch_date(1)
          ,incident_bip_Fields.InvalidMessage_dbcode(1)
          ,incident_bip_Fields.InvalidMessage_incident_num(1)
          ,incident_bip_Fields.InvalidMessage_incident_date(1)
          ,incident_bip_Fields.InvalidMessage_int_key(1)
          ,incident_bip_Fields.InvalidMessage_srce_cd(1)
          ,incident_bip_Fields.InvalidMessage_modified_date(1)
          ,incident_bip_Fields.InvalidMessage_entry_date(1)
          ,incident_bip_Fields.InvalidMessage_submitter_phone(1)
          ,incident_bip_Fields.InvalidMessage_submitter_fax(1)
          ,incident_bip_Fields.InvalidMessage_prop_state(1)
          ,incident_bip_Fields.InvalidMessage_prop_zip(1)
          ,incident_bip_Fields.InvalidMessage_aid(1)
          ,incident_bip_Fields.InvalidMessage_did(1)
          ,incident_bip_Fields.InvalidMessage_did_score(1)
          ,incident_bip_Fields.InvalidMessage_bdid(1)
          ,incident_bip_Fields.InvalidMessage_bdid_score(1)
          ,incident_bip_Fields.InvalidMessage_name_suffix(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dotid_ALLOW_ErrorCount
          ,le.dotscore_ALLOW_ErrorCount
          ,le.dotweight_ALLOW_ErrorCount
          ,le.empid_ALLOW_ErrorCount
          ,le.empscore_ALLOW_ErrorCount
          ,le.empweight_ALLOW_ErrorCount
          ,le.powid_ALLOW_ErrorCount
          ,le.powscore_ALLOW_ErrorCount
          ,le.powweight_ALLOW_ErrorCount
          ,le.proxid_ALLOW_ErrorCount
          ,le.proxscore_ALLOW_ErrorCount
          ,le.proxweight_ALLOW_ErrorCount
          ,le.seleid_ALLOW_ErrorCount
          ,le.selescore_ALLOW_ErrorCount
          ,le.seleweight_ALLOW_ErrorCount
          ,le.orgid_ALLOW_ErrorCount
          ,le.orgscore_ALLOW_ErrorCount
          ,le.orgweight_ALLOW_ErrorCount
          ,le.ultid_ALLOW_ErrorCount
          ,le.ultscore_ALLOW_ErrorCount
          ,le.ultweight_ALLOW_ErrorCount
          ,le.source_rec_id_ALLOW_ErrorCount
          ,le.batch_ALLOW_ErrorCount,le.batch_LENGTH_ErrorCount
          ,le.batch_date_CUSTOM_ErrorCount
          ,le.dbcode_ENUM_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.incident_date_CUSTOM_ErrorCount
          ,le.int_key_ALLOW_ErrorCount
          ,le.srce_cd_ALLOW_ErrorCount
          ,le.modified_date_CUSTOM_ErrorCount
          ,le.entry_date_CUSTOM_ErrorCount
          ,le.submitter_phone_ALLOW_ErrorCount
          ,le.submitter_fax_ALLOW_ErrorCount
          ,le.prop_state_CUSTOM_ErrorCount
          ,le.prop_zip_ALLOW_ErrorCount
          ,le.aid_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_ALLOW_ErrorCount
          ,le.name_suffix_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.dotid_ALLOW_ErrorCount
          ,le.dotscore_ALLOW_ErrorCount
          ,le.dotweight_ALLOW_ErrorCount
          ,le.empid_ALLOW_ErrorCount
          ,le.empscore_ALLOW_ErrorCount
          ,le.empweight_ALLOW_ErrorCount
          ,le.powid_ALLOW_ErrorCount
          ,le.powscore_ALLOW_ErrorCount
          ,le.powweight_ALLOW_ErrorCount
          ,le.proxid_ALLOW_ErrorCount
          ,le.proxscore_ALLOW_ErrorCount
          ,le.proxweight_ALLOW_ErrorCount
          ,le.seleid_ALLOW_ErrorCount
          ,le.selescore_ALLOW_ErrorCount
          ,le.seleweight_ALLOW_ErrorCount
          ,le.orgid_ALLOW_ErrorCount
          ,le.orgscore_ALLOW_ErrorCount
          ,le.orgweight_ALLOW_ErrorCount
          ,le.ultid_ALLOW_ErrorCount
          ,le.ultscore_ALLOW_ErrorCount
          ,le.ultweight_ALLOW_ErrorCount
          ,le.source_rec_id_ALLOW_ErrorCount
          ,le.batch_ALLOW_ErrorCount,le.batch_LENGTH_ErrorCount
          ,le.batch_date_CUSTOM_ErrorCount
          ,le.dbcode_ENUM_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.incident_date_CUSTOM_ErrorCount
          ,le.int_key_ALLOW_ErrorCount
          ,le.srce_cd_ALLOW_ErrorCount
          ,le.modified_date_CUSTOM_ErrorCount
          ,le.entry_date_CUSTOM_ErrorCount
          ,le.submitter_phone_ALLOW_ErrorCount
          ,le.submitter_fax_ALLOW_ErrorCount
          ,le.prop_state_CUSTOM_ErrorCount
          ,le.prop_zip_ALLOW_ErrorCount
          ,le.aid_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_ALLOW_ErrorCount
          ,le.name_suffix_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,42,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
