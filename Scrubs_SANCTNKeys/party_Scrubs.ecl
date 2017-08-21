IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT party_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(party_Layout_SANCTNKeys)
    UNSIGNED1 batch_number_Invalid;
    UNSIGNED1 incident_number_Invalid;
    UNSIGNED1 party_number_Invalid;
    UNSIGNED1 order_number_Invalid;
    UNSIGNED1 party_name_Invalid;
    UNSIGNED1 inzip_Invalid;
    UNSIGNED1 ssnumber_Invalid;
    UNSIGNED1 fines_levied_Invalid;
    UNSIGNED1 restitution_Invalid;
    UNSIGNED1 st_Invalid;
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
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 ssn_appended_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(party_Layout_SANCTNKeys)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(party_Layout_SANCTNKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.batch_number_Invalid := party_Fields.InValid_batch_number((SALT33.StrType)le.batch_number);
    SELF.incident_number_Invalid := party_Fields.InValid_incident_number((SALT33.StrType)le.incident_number);
    SELF.party_number_Invalid := party_Fields.InValid_party_number((SALT33.StrType)le.party_number);
    SELF.order_number_Invalid := party_Fields.InValid_order_number((SALT33.StrType)le.order_number);
    SELF.party_name_Invalid := party_Fields.InValid_party_name((SALT33.StrType)le.party_name);
    SELF.inzip_Invalid := party_Fields.InValid_inzip((SALT33.StrType)le.inzip);
    SELF.ssnumber_Invalid := party_Fields.InValid_ssnumber((SALT33.StrType)le.ssnumber);
    SELF.fines_levied_Invalid := party_Fields.InValid_fines_levied((SALT33.StrType)le.fines_levied);
    SELF.restitution_Invalid := party_Fields.InValid_restitution((SALT33.StrType)le.restitution);
    SELF.st_Invalid := party_Fields.InValid_st((SALT33.StrType)le.st);
    SELF.dotid_Invalid := party_Fields.InValid_dotid((SALT33.StrType)le.dotid);
    SELF.dotscore_Invalid := party_Fields.InValid_dotscore((SALT33.StrType)le.dotscore);
    SELF.dotweight_Invalid := party_Fields.InValid_dotweight((SALT33.StrType)le.dotweight);
    SELF.empid_Invalid := party_Fields.InValid_empid((SALT33.StrType)le.empid);
    SELF.empscore_Invalid := party_Fields.InValid_empscore((SALT33.StrType)le.empscore);
    SELF.empweight_Invalid := party_Fields.InValid_empweight((SALT33.StrType)le.empweight);
    SELF.powid_Invalid := party_Fields.InValid_powid((SALT33.StrType)le.powid);
    SELF.powscore_Invalid := party_Fields.InValid_powscore((SALT33.StrType)le.powscore);
    SELF.powweight_Invalid := party_Fields.InValid_powweight((SALT33.StrType)le.powweight);
    SELF.proxid_Invalid := party_Fields.InValid_proxid((SALT33.StrType)le.proxid);
    SELF.proxscore_Invalid := party_Fields.InValid_proxscore((SALT33.StrType)le.proxscore);
    SELF.proxweight_Invalid := party_Fields.InValid_proxweight((SALT33.StrType)le.proxweight);
    SELF.seleid_Invalid := party_Fields.InValid_seleid((SALT33.StrType)le.seleid);
    SELF.selescore_Invalid := party_Fields.InValid_selescore((SALT33.StrType)le.selescore);
    SELF.seleweight_Invalid := party_Fields.InValid_seleweight((SALT33.StrType)le.seleweight);
    SELF.orgid_Invalid := party_Fields.InValid_orgid((SALT33.StrType)le.orgid);
    SELF.orgscore_Invalid := party_Fields.InValid_orgscore((SALT33.StrType)le.orgscore);
    SELF.orgweight_Invalid := party_Fields.InValid_orgweight((SALT33.StrType)le.orgweight);
    SELF.ultid_Invalid := party_Fields.InValid_ultid((SALT33.StrType)le.ultid);
    SELF.ultscore_Invalid := party_Fields.InValid_ultscore((SALT33.StrType)le.ultscore);
    SELF.ultweight_Invalid := party_Fields.InValid_ultweight((SALT33.StrType)le.ultweight);
    SELF.source_rec_id_Invalid := party_Fields.InValid_source_rec_id((SALT33.StrType)le.source_rec_id);
    SELF.did_Invalid := party_Fields.InValid_did((SALT33.StrType)le.did);
    SELF.did_score_Invalid := party_Fields.InValid_did_score((SALT33.StrType)le.did_score);
    SELF.bdid_Invalid := party_Fields.InValid_bdid((SALT33.StrType)le.bdid);
    SELF.bdid_score_Invalid := party_Fields.InValid_bdid_score((SALT33.StrType)le.bdid_score);
    SELF.ssn_appended_Invalid := party_Fields.InValid_ssn_appended((SALT33.StrType)le.ssn_appended);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),party_Layout_SANCTNKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.batch_number_Invalid << 0 ) + ( le.incident_number_Invalid << 2 ) + ( le.party_number_Invalid << 3 ) + ( le.order_number_Invalid << 4 ) + ( le.party_name_Invalid << 5 ) + ( le.inzip_Invalid << 6 ) + ( le.ssnumber_Invalid << 7 ) + ( le.fines_levied_Invalid << 8 ) + ( le.restitution_Invalid << 9 ) + ( le.st_Invalid << 10 ) + ( le.dotid_Invalid << 11 ) + ( le.dotscore_Invalid << 12 ) + ( le.dotweight_Invalid << 13 ) + ( le.empid_Invalid << 14 ) + ( le.empscore_Invalid << 15 ) + ( le.empweight_Invalid << 16 ) + ( le.powid_Invalid << 17 ) + ( le.powscore_Invalid << 18 ) + ( le.powweight_Invalid << 19 ) + ( le.proxid_Invalid << 20 ) + ( le.proxscore_Invalid << 21 ) + ( le.proxweight_Invalid << 22 ) + ( le.seleid_Invalid << 23 ) + ( le.selescore_Invalid << 24 ) + ( le.seleweight_Invalid << 25 ) + ( le.orgid_Invalid << 26 ) + ( le.orgscore_Invalid << 27 ) + ( le.orgweight_Invalid << 28 ) + ( le.ultid_Invalid << 29 ) + ( le.ultscore_Invalid << 30 ) + ( le.ultweight_Invalid << 31 ) + ( le.source_rec_id_Invalid << 32 ) + ( le.did_Invalid << 33 ) + ( le.did_score_Invalid << 34 ) + ( le.bdid_Invalid << 35 ) + ( le.bdid_score_Invalid << 36 ) + ( le.ssn_appended_Invalid << 37 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,party_Layout_SANCTNKeys);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.batch_number_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.incident_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.party_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.order_number_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.party_name_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.inzip_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.ssnumber_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.fines_levied_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.restitution_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.dotid_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.dotscore_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.dotweight_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.empid_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.empscore_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.empweight_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.powid_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.powscore_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.powweight_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.proxscore_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.proxweight_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.selescore_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.seleweight_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.orgscore_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.orgweight_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.ultscore_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.ultweight_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.bdid_score_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.ssn_appended_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    batch_number_ALLOW_ErrorCount := COUNT(GROUP,h.batch_number_Invalid=1);
    batch_number_LENGTH_ErrorCount := COUNT(GROUP,h.batch_number_Invalid=2);
    batch_number_Total_ErrorCount := COUNT(GROUP,h.batch_number_Invalid>0);
    incident_number_ALLOW_ErrorCount := COUNT(GROUP,h.incident_number_Invalid=1);
    party_number_ALLOW_ErrorCount := COUNT(GROUP,h.party_number_Invalid=1);
    order_number_ALLOW_ErrorCount := COUNT(GROUP,h.order_number_Invalid=1);
    party_name_LENGTH_ErrorCount := COUNT(GROUP,h.party_name_Invalid=1);
    inzip_CUSTOM_ErrorCount := COUNT(GROUP,h.inzip_Invalid=1);
    ssnumber_ALLOW_ErrorCount := COUNT(GROUP,h.ssnumber_Invalid=1);
    fines_levied_ALLOW_ErrorCount := COUNT(GROUP,h.fines_levied_Invalid=1);
    restitution_ALLOW_ErrorCount := COUNT(GROUP,h.restitution_Invalid=1);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
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
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_score_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    ssn_appended_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_appended_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.batch_number_Invalid,le.incident_number_Invalid,le.party_number_Invalid,le.order_number_Invalid,le.party_name_Invalid,le.inzip_Invalid,le.ssnumber_Invalid,le.fines_levied_Invalid,le.restitution_Invalid,le.st_Invalid,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,le.source_rec_id_Invalid,le.did_Invalid,le.did_score_Invalid,le.bdid_Invalid,le.bdid_score_Invalid,le.ssn_appended_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,party_Fields.InvalidMessage_batch_number(le.batch_number_Invalid),party_Fields.InvalidMessage_incident_number(le.incident_number_Invalid),party_Fields.InvalidMessage_party_number(le.party_number_Invalid),party_Fields.InvalidMessage_order_number(le.order_number_Invalid),party_Fields.InvalidMessage_party_name(le.party_name_Invalid),party_Fields.InvalidMessage_inzip(le.inzip_Invalid),party_Fields.InvalidMessage_ssnumber(le.ssnumber_Invalid),party_Fields.InvalidMessage_fines_levied(le.fines_levied_Invalid),party_Fields.InvalidMessage_restitution(le.restitution_Invalid),party_Fields.InvalidMessage_st(le.st_Invalid),party_Fields.InvalidMessage_dotid(le.dotid_Invalid),party_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),party_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),party_Fields.InvalidMessage_empid(le.empid_Invalid),party_Fields.InvalidMessage_empscore(le.empscore_Invalid),party_Fields.InvalidMessage_empweight(le.empweight_Invalid),party_Fields.InvalidMessage_powid(le.powid_Invalid),party_Fields.InvalidMessage_powscore(le.powscore_Invalid),party_Fields.InvalidMessage_powweight(le.powweight_Invalid),party_Fields.InvalidMessage_proxid(le.proxid_Invalid),party_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),party_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),party_Fields.InvalidMessage_seleid(le.seleid_Invalid),party_Fields.InvalidMessage_selescore(le.selescore_Invalid),party_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),party_Fields.InvalidMessage_orgid(le.orgid_Invalid),party_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),party_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),party_Fields.InvalidMessage_ultid(le.ultid_Invalid),party_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),party_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),party_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),party_Fields.InvalidMessage_did(le.did_Invalid),party_Fields.InvalidMessage_did_score(le.did_score_Invalid),party_Fields.InvalidMessage_bdid(le.bdid_Invalid),party_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),party_Fields.InvalidMessage_ssn_appended(le.ssn_appended_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.batch_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.incident_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.party_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.order_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.party_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.inzip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ssnumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fines_levied_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.restitution_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
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
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ssn_appended_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'batch_number','incident_number','party_number','order_number','party_name','inzip','ssnumber','fines_levied','restitution','st','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','did','did_score','bdid','bdid_score','ssn_appended','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Batch','Invalid_Num','Invalid_Num','Invalid_Num','Non_Blank','Invalid_Zip','Invalid_SSN','Invalid_Money','Invalid_Money','Invalid_State','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.batch_number,(SALT33.StrType)le.incident_number,(SALT33.StrType)le.party_number,(SALT33.StrType)le.order_number,(SALT33.StrType)le.party_name,(SALT33.StrType)le.inzip,(SALT33.StrType)le.ssnumber,(SALT33.StrType)le.fines_levied,(SALT33.StrType)le.restitution,(SALT33.StrType)le.st,(SALT33.StrType)le.dotid,(SALT33.StrType)le.dotscore,(SALT33.StrType)le.dotweight,(SALT33.StrType)le.empid,(SALT33.StrType)le.empscore,(SALT33.StrType)le.empweight,(SALT33.StrType)le.powid,(SALT33.StrType)le.powscore,(SALT33.StrType)le.powweight,(SALT33.StrType)le.proxid,(SALT33.StrType)le.proxscore,(SALT33.StrType)le.proxweight,(SALT33.StrType)le.seleid,(SALT33.StrType)le.selescore,(SALT33.StrType)le.seleweight,(SALT33.StrType)le.orgid,(SALT33.StrType)le.orgscore,(SALT33.StrType)le.orgweight,(SALT33.StrType)le.ultid,(SALT33.StrType)le.ultscore,(SALT33.StrType)le.ultweight,(SALT33.StrType)le.source_rec_id,(SALT33.StrType)le.did,(SALT33.StrType)le.did_score,(SALT33.StrType)le.bdid,(SALT33.StrType)le.bdid_score,(SALT33.StrType)le.ssn_appended,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,37,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'batch_number:Invalid_Batch:ALLOW','batch_number:Invalid_Batch:LENGTH'
          ,'incident_number:Invalid_Num:ALLOW'
          ,'party_number:Invalid_Num:ALLOW'
          ,'order_number:Invalid_Num:ALLOW'
          ,'party_name:Non_Blank:LENGTH'
          ,'inzip:Invalid_Zip:CUSTOM'
          ,'ssnumber:Invalid_SSN:ALLOW'
          ,'fines_levied:Invalid_Money:ALLOW'
          ,'restitution:Invalid_Money:ALLOW'
          ,'st:Invalid_State:CUSTOM'
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
          ,'did:Invalid_Num:ALLOW'
          ,'did_score:Invalid_Num:ALLOW'
          ,'bdid:Invalid_Num:ALLOW'
          ,'bdid_score:Invalid_Num:ALLOW'
          ,'ssn_appended:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,party_Fields.InvalidMessage_batch_number(1),party_Fields.InvalidMessage_batch_number(2)
          ,party_Fields.InvalidMessage_incident_number(1)
          ,party_Fields.InvalidMessage_party_number(1)
          ,party_Fields.InvalidMessage_order_number(1)
          ,party_Fields.InvalidMessage_party_name(1)
          ,party_Fields.InvalidMessage_inzip(1)
          ,party_Fields.InvalidMessage_ssnumber(1)
          ,party_Fields.InvalidMessage_fines_levied(1)
          ,party_Fields.InvalidMessage_restitution(1)
          ,party_Fields.InvalidMessage_st(1)
          ,party_Fields.InvalidMessage_dotid(1)
          ,party_Fields.InvalidMessage_dotscore(1)
          ,party_Fields.InvalidMessage_dotweight(1)
          ,party_Fields.InvalidMessage_empid(1)
          ,party_Fields.InvalidMessage_empscore(1)
          ,party_Fields.InvalidMessage_empweight(1)
          ,party_Fields.InvalidMessage_powid(1)
          ,party_Fields.InvalidMessage_powscore(1)
          ,party_Fields.InvalidMessage_powweight(1)
          ,party_Fields.InvalidMessage_proxid(1)
          ,party_Fields.InvalidMessage_proxscore(1)
          ,party_Fields.InvalidMessage_proxweight(1)
          ,party_Fields.InvalidMessage_seleid(1)
          ,party_Fields.InvalidMessage_selescore(1)
          ,party_Fields.InvalidMessage_seleweight(1)
          ,party_Fields.InvalidMessage_orgid(1)
          ,party_Fields.InvalidMessage_orgscore(1)
          ,party_Fields.InvalidMessage_orgweight(1)
          ,party_Fields.InvalidMessage_ultid(1)
          ,party_Fields.InvalidMessage_ultscore(1)
          ,party_Fields.InvalidMessage_ultweight(1)
          ,party_Fields.InvalidMessage_source_rec_id(1)
          ,party_Fields.InvalidMessage_did(1)
          ,party_Fields.InvalidMessage_did_score(1)
          ,party_Fields.InvalidMessage_bdid(1)
          ,party_Fields.InvalidMessage_bdid_score(1)
          ,party_Fields.InvalidMessage_ssn_appended(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.batch_number_ALLOW_ErrorCount,le.batch_number_LENGTH_ErrorCount
          ,le.incident_number_ALLOW_ErrorCount
          ,le.party_number_ALLOW_ErrorCount
          ,le.order_number_ALLOW_ErrorCount
          ,le.party_name_LENGTH_ErrorCount
          ,le.inzip_CUSTOM_ErrorCount
          ,le.ssnumber_ALLOW_ErrorCount
          ,le.fines_levied_ALLOW_ErrorCount
          ,le.restitution_ALLOW_ErrorCount
          ,le.st_CUSTOM_ErrorCount
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
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_ALLOW_ErrorCount
          ,le.ssn_appended_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.batch_number_ALLOW_ErrorCount,le.batch_number_LENGTH_ErrorCount
          ,le.incident_number_ALLOW_ErrorCount
          ,le.party_number_ALLOW_ErrorCount
          ,le.order_number_ALLOW_ErrorCount
          ,le.party_name_LENGTH_ErrorCount
          ,le.inzip_CUSTOM_ErrorCount
          ,le.ssnumber_ALLOW_ErrorCount
          ,le.fines_levied_ALLOW_ErrorCount
          ,le.restitution_ALLOW_ErrorCount
          ,le.st_CUSTOM_ErrorCount
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
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_ALLOW_ErrorCount
          ,le.ssn_appended_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,38,Into(LEFT,COUNTER));
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
