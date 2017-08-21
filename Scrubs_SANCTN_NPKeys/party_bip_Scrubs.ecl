IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT party_bip_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(party_bip_Layout_SANCTN_NPKeys)
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
    UNSIGNED1 dbcode_Invalid;
    UNSIGNED1 incident_num_Invalid;
    UNSIGNED1 party_num_Invalid;
    UNSIGNED1 sanctions_Invalid;
    UNSIGNED1 tin_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 party_key_Invalid;
    UNSIGNED1 int_key_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 aid_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 enh_did_src_Invalid;
    UNSIGNED1 name_suffix_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(party_bip_Layout_SANCTN_NPKeys)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(party_bip_Layout_SANCTN_NPKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dotid_Invalid := party_bip_Fields.InValid_dotid((SALT33.StrType)le.dotid);
    SELF.dotscore_Invalid := party_bip_Fields.InValid_dotscore((SALT33.StrType)le.dotscore);
    SELF.dotweight_Invalid := party_bip_Fields.InValid_dotweight((SALT33.StrType)le.dotweight);
    SELF.empid_Invalid := party_bip_Fields.InValid_empid((SALT33.StrType)le.empid);
    SELF.empscore_Invalid := party_bip_Fields.InValid_empscore((SALT33.StrType)le.empscore);
    SELF.empweight_Invalid := party_bip_Fields.InValid_empweight((SALT33.StrType)le.empweight);
    SELF.powid_Invalid := party_bip_Fields.InValid_powid((SALT33.StrType)le.powid);
    SELF.powscore_Invalid := party_bip_Fields.InValid_powscore((SALT33.StrType)le.powscore);
    SELF.powweight_Invalid := party_bip_Fields.InValid_powweight((SALT33.StrType)le.powweight);
    SELF.proxid_Invalid := party_bip_Fields.InValid_proxid((SALT33.StrType)le.proxid);
    SELF.proxscore_Invalid := party_bip_Fields.InValid_proxscore((SALT33.StrType)le.proxscore);
    SELF.proxweight_Invalid := party_bip_Fields.InValid_proxweight((SALT33.StrType)le.proxweight);
    SELF.seleid_Invalid := party_bip_Fields.InValid_seleid((SALT33.StrType)le.seleid);
    SELF.selescore_Invalid := party_bip_Fields.InValid_selescore((SALT33.StrType)le.selescore);
    SELF.seleweight_Invalid := party_bip_Fields.InValid_seleweight((SALT33.StrType)le.seleweight);
    SELF.orgid_Invalid := party_bip_Fields.InValid_orgid((SALT33.StrType)le.orgid);
    SELF.orgscore_Invalid := party_bip_Fields.InValid_orgscore((SALT33.StrType)le.orgscore);
    SELF.orgweight_Invalid := party_bip_Fields.InValid_orgweight((SALT33.StrType)le.orgweight);
    SELF.ultid_Invalid := party_bip_Fields.InValid_ultid((SALT33.StrType)le.ultid);
    SELF.ultscore_Invalid := party_bip_Fields.InValid_ultscore((SALT33.StrType)le.ultscore);
    SELF.ultweight_Invalid := party_bip_Fields.InValid_ultweight((SALT33.StrType)le.ultweight);
    SELF.source_rec_id_Invalid := party_bip_Fields.InValid_source_rec_id((SALT33.StrType)le.source_rec_id);
    SELF.batch_Invalid := party_bip_Fields.InValid_batch((SALT33.StrType)le.batch);
    SELF.dbcode_Invalid := party_bip_Fields.InValid_dbcode((SALT33.StrType)le.dbcode);
    SELF.incident_num_Invalid := party_bip_Fields.InValid_incident_num((SALT33.StrType)le.incident_num);
    SELF.party_num_Invalid := party_bip_Fields.InValid_party_num((SALT33.StrType)le.party_num);
    SELF.sanctions_Invalid := party_bip_Fields.InValid_sanctions((SALT33.StrType)le.sanctions);
    SELF.tin_Invalid := party_bip_Fields.InValid_tin((SALT33.StrType)le.tin);
    SELF.suffix_Invalid := party_bip_Fields.InValid_suffix((SALT33.StrType)le.suffix);
    SELF.ssn_Invalid := party_bip_Fields.InValid_ssn((SALT33.StrType)le.ssn);
    SELF.dob_Invalid := party_bip_Fields.InValid_dob((SALT33.StrType)le.dob);
    SELF.state_Invalid := party_bip_Fields.InValid_state((SALT33.StrType)le.state);
    SELF.zip_Invalid := party_bip_Fields.InValid_zip((SALT33.StrType)le.zip);
    SELF.party_key_Invalid := party_bip_Fields.InValid_party_key((SALT33.StrType)le.party_key);
    SELF.int_key_Invalid := party_bip_Fields.InValid_int_key((SALT33.StrType)le.int_key);
    SELF.phone_Invalid := party_bip_Fields.InValid_phone((SALT33.StrType)le.phone);
    SELF.aid_Invalid := party_bip_Fields.InValid_aid((SALT33.StrType)le.aid);
    SELF.did_Invalid := party_bip_Fields.InValid_did((SALT33.StrType)le.did);
    SELF.did_score_Invalid := party_bip_Fields.InValid_did_score((SALT33.StrType)le.did_score);
    SELF.bdid_Invalid := party_bip_Fields.InValid_bdid((SALT33.StrType)le.bdid);
    SELF.bdid_score_Invalid := party_bip_Fields.InValid_bdid_score((SALT33.StrType)le.bdid_score);
    SELF.enh_did_src_Invalid := party_bip_Fields.InValid_enh_did_src((SALT33.StrType)le.enh_did_src);
    SELF.name_suffix_Invalid := party_bip_Fields.InValid_name_suffix((SALT33.StrType)le.name_suffix);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),party_bip_Layout_SANCTN_NPKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dotid_Invalid << 0 ) + ( le.dotscore_Invalid << 1 ) + ( le.dotweight_Invalid << 2 ) + ( le.empid_Invalid << 3 ) + ( le.empscore_Invalid << 4 ) + ( le.empweight_Invalid << 5 ) + ( le.powid_Invalid << 6 ) + ( le.powscore_Invalid << 7 ) + ( le.powweight_Invalid << 8 ) + ( le.proxid_Invalid << 9 ) + ( le.proxscore_Invalid << 10 ) + ( le.proxweight_Invalid << 11 ) + ( le.seleid_Invalid << 12 ) + ( le.selescore_Invalid << 13 ) + ( le.seleweight_Invalid << 14 ) + ( le.orgid_Invalid << 15 ) + ( le.orgscore_Invalid << 16 ) + ( le.orgweight_Invalid << 17 ) + ( le.ultid_Invalid << 18 ) + ( le.ultscore_Invalid << 19 ) + ( le.ultweight_Invalid << 20 ) + ( le.source_rec_id_Invalid << 21 ) + ( le.batch_Invalid << 22 ) + ( le.dbcode_Invalid << 24 ) + ( le.incident_num_Invalid << 25 ) + ( le.party_num_Invalid << 26 ) + ( le.sanctions_Invalid << 27 ) + ( le.tin_Invalid << 28 ) + ( le.suffix_Invalid << 29 ) + ( le.ssn_Invalid << 30 ) + ( le.dob_Invalid << 31 ) + ( le.state_Invalid << 32 ) + ( le.zip_Invalid << 33 ) + ( le.party_key_Invalid << 34 ) + ( le.int_key_Invalid << 35 ) + ( le.phone_Invalid << 36 ) + ( le.aid_Invalid << 37 ) + ( le.did_Invalid << 38 ) + ( le.did_score_Invalid << 39 ) + ( le.bdid_Invalid << 40 ) + ( le.bdid_score_Invalid << 41 ) + ( le.enh_did_src_Invalid << 42 ) + ( le.name_suffix_Invalid << 43 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,party_bip_Layout_SANCTN_NPKeys);
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
    SELF.dbcode_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.incident_num_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.party_num_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.sanctions_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.tin_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.party_key_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.int_key_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.aid_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.bdid_score_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.enh_did_src_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 43) & 1;
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
    dbcode_ENUM_ErrorCount := COUNT(GROUP,h.dbcode_Invalid=1);
    incident_num_ALLOW_ErrorCount := COUNT(GROUP,h.incident_num_Invalid=1);
    party_num_ALLOW_ErrorCount := COUNT(GROUP,h.party_num_Invalid=1);
    sanctions_ALLOW_ErrorCount := COUNT(GROUP,h.sanctions_Invalid=1);
    tin_ALLOW_ErrorCount := COUNT(GROUP,h.tin_Invalid=1);
    suffix_ENUM_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    party_key_ALLOW_ErrorCount := COUNT(GROUP,h.party_key_Invalid=1);
    int_key_ALLOW_ErrorCount := COUNT(GROUP,h.int_key_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    aid_ALLOW_ErrorCount := COUNT(GROUP,h.aid_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_score_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    enh_did_src_ENUM_ErrorCount := COUNT(GROUP,h.enh_did_src_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,le.source_rec_id_Invalid,le.batch_Invalid,le.dbcode_Invalid,le.incident_num_Invalid,le.party_num_Invalid,le.sanctions_Invalid,le.tin_Invalid,le.suffix_Invalid,le.ssn_Invalid,le.dob_Invalid,le.state_Invalid,le.zip_Invalid,le.party_key_Invalid,le.int_key_Invalid,le.phone_Invalid,le.aid_Invalid,le.did_Invalid,le.did_score_Invalid,le.bdid_Invalid,le.bdid_score_Invalid,le.enh_did_src_Invalid,le.name_suffix_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,party_bip_Fields.InvalidMessage_dotid(le.dotid_Invalid),party_bip_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),party_bip_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),party_bip_Fields.InvalidMessage_empid(le.empid_Invalid),party_bip_Fields.InvalidMessage_empscore(le.empscore_Invalid),party_bip_Fields.InvalidMessage_empweight(le.empweight_Invalid),party_bip_Fields.InvalidMessage_powid(le.powid_Invalid),party_bip_Fields.InvalidMessage_powscore(le.powscore_Invalid),party_bip_Fields.InvalidMessage_powweight(le.powweight_Invalid),party_bip_Fields.InvalidMessage_proxid(le.proxid_Invalid),party_bip_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),party_bip_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),party_bip_Fields.InvalidMessage_seleid(le.seleid_Invalid),party_bip_Fields.InvalidMessage_selescore(le.selescore_Invalid),party_bip_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),party_bip_Fields.InvalidMessage_orgid(le.orgid_Invalid),party_bip_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),party_bip_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),party_bip_Fields.InvalidMessage_ultid(le.ultid_Invalid),party_bip_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),party_bip_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),party_bip_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),party_bip_Fields.InvalidMessage_batch(le.batch_Invalid),party_bip_Fields.InvalidMessage_dbcode(le.dbcode_Invalid),party_bip_Fields.InvalidMessage_incident_num(le.incident_num_Invalid),party_bip_Fields.InvalidMessage_party_num(le.party_num_Invalid),party_bip_Fields.InvalidMessage_sanctions(le.sanctions_Invalid),party_bip_Fields.InvalidMessage_tin(le.tin_Invalid),party_bip_Fields.InvalidMessage_suffix(le.suffix_Invalid),party_bip_Fields.InvalidMessage_ssn(le.ssn_Invalid),party_bip_Fields.InvalidMessage_dob(le.dob_Invalid),party_bip_Fields.InvalidMessage_state(le.state_Invalid),party_bip_Fields.InvalidMessage_zip(le.zip_Invalid),party_bip_Fields.InvalidMessage_party_key(le.party_key_Invalid),party_bip_Fields.InvalidMessage_int_key(le.int_key_Invalid),party_bip_Fields.InvalidMessage_phone(le.phone_Invalid),party_bip_Fields.InvalidMessage_aid(le.aid_Invalid),party_bip_Fields.InvalidMessage_did(le.did_Invalid),party_bip_Fields.InvalidMessage_did_score(le.did_score_Invalid),party_bip_Fields.InvalidMessage_bdid(le.bdid_Invalid),party_bip_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),party_bip_Fields.InvalidMessage_enh_did_src(le.enh_did_src_Invalid),party_bip_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),'UNKNOWN'));
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
          ,CHOOSE(le.dbcode_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.incident_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.party_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sanctions_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.tin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.party_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.int_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.enh_did_src_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','batch','dbcode','incident_num','party_num','sanctions','tin','suffix','ssn','dob','state','zip','party_key','int_key','phone','aid','did','did_score','bdid','bdid_score','enh_did_src','name_suffix','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Batch','Invalid_DBCode','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Num','Invalid_Suffix','Invalid_Num','Invalid_CurrentDate','Invalid_State','Invalid_Zip','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Enh_Did_Src','Invalid_Suffix','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.dotid,(SALT33.StrType)le.dotscore,(SALT33.StrType)le.dotweight,(SALT33.StrType)le.empid,(SALT33.StrType)le.empscore,(SALT33.StrType)le.empweight,(SALT33.StrType)le.powid,(SALT33.StrType)le.powscore,(SALT33.StrType)le.powweight,(SALT33.StrType)le.proxid,(SALT33.StrType)le.proxscore,(SALT33.StrType)le.proxweight,(SALT33.StrType)le.seleid,(SALT33.StrType)le.selescore,(SALT33.StrType)le.seleweight,(SALT33.StrType)le.orgid,(SALT33.StrType)le.orgscore,(SALT33.StrType)le.orgweight,(SALT33.StrType)le.ultid,(SALT33.StrType)le.ultscore,(SALT33.StrType)le.ultweight,(SALT33.StrType)le.source_rec_id,(SALT33.StrType)le.batch,(SALT33.StrType)le.dbcode,(SALT33.StrType)le.incident_num,(SALT33.StrType)le.party_num,(SALT33.StrType)le.sanctions,(SALT33.StrType)le.tin,(SALT33.StrType)le.suffix,(SALT33.StrType)le.ssn,(SALT33.StrType)le.dob,(SALT33.StrType)le.state,(SALT33.StrType)le.zip,(SALT33.StrType)le.party_key,(SALT33.StrType)le.int_key,(SALT33.StrType)le.phone,(SALT33.StrType)le.aid,(SALT33.StrType)le.did,(SALT33.StrType)le.did_score,(SALT33.StrType)le.bdid,(SALT33.StrType)le.bdid_score,(SALT33.StrType)le.enh_did_src,(SALT33.StrType)le.name_suffix,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,43,Into(LEFT,COUNTER));
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
          ,'dbcode:Invalid_DBCode:ENUM'
          ,'incident_num:Invalid_Num:ALLOW'
          ,'party_num:Invalid_Num:ALLOW'
          ,'sanctions:Invalid_Char:ALLOW'
          ,'tin:Invalid_Num:ALLOW'
          ,'suffix:Invalid_Suffix:ENUM'
          ,'ssn:Invalid_Num:ALLOW'
          ,'dob:Invalid_CurrentDate:CUSTOM'
          ,'state:Invalid_State:CUSTOM'
          ,'zip:Invalid_Zip:ALLOW'
          ,'party_key:Invalid_Num:ALLOW'
          ,'int_key:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'aid:Invalid_Num:ALLOW'
          ,'did:Invalid_Num:ALLOW'
          ,'did_score:Invalid_Num:ALLOW'
          ,'bdid:Invalid_Num:ALLOW'
          ,'bdid_score:Invalid_Num:ALLOW'
          ,'enh_did_src:Invalid_Enh_Did_Src:ENUM'
          ,'name_suffix:Invalid_Suffix:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,party_bip_Fields.InvalidMessage_dotid(1)
          ,party_bip_Fields.InvalidMessage_dotscore(1)
          ,party_bip_Fields.InvalidMessage_dotweight(1)
          ,party_bip_Fields.InvalidMessage_empid(1)
          ,party_bip_Fields.InvalidMessage_empscore(1)
          ,party_bip_Fields.InvalidMessage_empweight(1)
          ,party_bip_Fields.InvalidMessage_powid(1)
          ,party_bip_Fields.InvalidMessage_powscore(1)
          ,party_bip_Fields.InvalidMessage_powweight(1)
          ,party_bip_Fields.InvalidMessage_proxid(1)
          ,party_bip_Fields.InvalidMessage_proxscore(1)
          ,party_bip_Fields.InvalidMessage_proxweight(1)
          ,party_bip_Fields.InvalidMessage_seleid(1)
          ,party_bip_Fields.InvalidMessage_selescore(1)
          ,party_bip_Fields.InvalidMessage_seleweight(1)
          ,party_bip_Fields.InvalidMessage_orgid(1)
          ,party_bip_Fields.InvalidMessage_orgscore(1)
          ,party_bip_Fields.InvalidMessage_orgweight(1)
          ,party_bip_Fields.InvalidMessage_ultid(1)
          ,party_bip_Fields.InvalidMessage_ultscore(1)
          ,party_bip_Fields.InvalidMessage_ultweight(1)
          ,party_bip_Fields.InvalidMessage_source_rec_id(1)
          ,party_bip_Fields.InvalidMessage_batch(1),party_bip_Fields.InvalidMessage_batch(2)
          ,party_bip_Fields.InvalidMessage_dbcode(1)
          ,party_bip_Fields.InvalidMessage_incident_num(1)
          ,party_bip_Fields.InvalidMessage_party_num(1)
          ,party_bip_Fields.InvalidMessage_sanctions(1)
          ,party_bip_Fields.InvalidMessage_tin(1)
          ,party_bip_Fields.InvalidMessage_suffix(1)
          ,party_bip_Fields.InvalidMessage_ssn(1)
          ,party_bip_Fields.InvalidMessage_dob(1)
          ,party_bip_Fields.InvalidMessage_state(1)
          ,party_bip_Fields.InvalidMessage_zip(1)
          ,party_bip_Fields.InvalidMessage_party_key(1)
          ,party_bip_Fields.InvalidMessage_int_key(1)
          ,party_bip_Fields.InvalidMessage_phone(1)
          ,party_bip_Fields.InvalidMessage_aid(1)
          ,party_bip_Fields.InvalidMessage_did(1)
          ,party_bip_Fields.InvalidMessage_did_score(1)
          ,party_bip_Fields.InvalidMessage_bdid(1)
          ,party_bip_Fields.InvalidMessage_bdid_score(1)
          ,party_bip_Fields.InvalidMessage_enh_did_src(1)
          ,party_bip_Fields.InvalidMessage_name_suffix(1),'UNKNOWN');
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
          ,le.dbcode_ENUM_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.party_num_ALLOW_ErrorCount
          ,le.sanctions_ALLOW_ErrorCount
          ,le.tin_ALLOW_ErrorCount
          ,le.suffix_ENUM_ErrorCount
          ,le.ssn_ALLOW_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.party_key_ALLOW_ErrorCount
          ,le.int_key_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.aid_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_ALLOW_ErrorCount
          ,le.enh_did_src_ENUM_ErrorCount
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
          ,le.dbcode_ENUM_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.party_num_ALLOW_ErrorCount
          ,le.sanctions_ALLOW_ErrorCount
          ,le.tin_ALLOW_ErrorCount
          ,le.suffix_ENUM_ErrorCount
          ,le.ssn_ALLOW_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.party_key_ALLOW_ErrorCount
          ,le.int_key_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.aid_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_ALLOW_ErrorCount
          ,le.enh_did_src_ENUM_ErrorCount
          ,le.name_suffix_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,44,Into(LEFT,COUNTER));
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
