IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT party_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 38;
  EXPORT NumRulesFromFieldType := 38;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 37;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(party_Layout_SANCTNKeys)
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
    SELF.batch_number_Invalid := party_Fields.InValid_batch_number((SALT38.StrType)le.batch_number);
    SELF.incident_number_Invalid := party_Fields.InValid_incident_number((SALT38.StrType)le.incident_number);
    SELF.party_number_Invalid := party_Fields.InValid_party_number((SALT38.StrType)le.party_number);
    SELF.order_number_Invalid := party_Fields.InValid_order_number((SALT38.StrType)le.order_number);
    SELF.party_name_Invalid := party_Fields.InValid_party_name((SALT38.StrType)le.party_name);
    SELF.inzip_Invalid := party_Fields.InValid_inzip((SALT38.StrType)le.inzip);
    SELF.ssnumber_Invalid := party_Fields.InValid_ssnumber((SALT38.StrType)le.ssnumber);
    SELF.fines_levied_Invalid := party_Fields.InValid_fines_levied((SALT38.StrType)le.fines_levied);
    SELF.restitution_Invalid := party_Fields.InValid_restitution((SALT38.StrType)le.restitution);
    SELF.st_Invalid := party_Fields.InValid_st((SALT38.StrType)le.st);
    SELF.dotid_Invalid := party_Fields.InValid_dotid((SALT38.StrType)le.dotid);
    SELF.dotscore_Invalid := party_Fields.InValid_dotscore((SALT38.StrType)le.dotscore);
    SELF.dotweight_Invalid := party_Fields.InValid_dotweight((SALT38.StrType)le.dotweight);
    SELF.empid_Invalid := party_Fields.InValid_empid((SALT38.StrType)le.empid);
    SELF.empscore_Invalid := party_Fields.InValid_empscore((SALT38.StrType)le.empscore);
    SELF.empweight_Invalid := party_Fields.InValid_empweight((SALT38.StrType)le.empweight);
    SELF.powid_Invalid := party_Fields.InValid_powid((SALT38.StrType)le.powid);
    SELF.powscore_Invalid := party_Fields.InValid_powscore((SALT38.StrType)le.powscore);
    SELF.powweight_Invalid := party_Fields.InValid_powweight((SALT38.StrType)le.powweight);
    SELF.proxid_Invalid := party_Fields.InValid_proxid((SALT38.StrType)le.proxid);
    SELF.proxscore_Invalid := party_Fields.InValid_proxscore((SALT38.StrType)le.proxscore);
    SELF.proxweight_Invalid := party_Fields.InValid_proxweight((SALT38.StrType)le.proxweight);
    SELF.seleid_Invalid := party_Fields.InValid_seleid((SALT38.StrType)le.seleid);
    SELF.selescore_Invalid := party_Fields.InValid_selescore((SALT38.StrType)le.selescore);
    SELF.seleweight_Invalid := party_Fields.InValid_seleweight((SALT38.StrType)le.seleweight);
    SELF.orgid_Invalid := party_Fields.InValid_orgid((SALT38.StrType)le.orgid);
    SELF.orgscore_Invalid := party_Fields.InValid_orgscore((SALT38.StrType)le.orgscore);
    SELF.orgweight_Invalid := party_Fields.InValid_orgweight((SALT38.StrType)le.orgweight);
    SELF.ultid_Invalid := party_Fields.InValid_ultid((SALT38.StrType)le.ultid);
    SELF.ultscore_Invalid := party_Fields.InValid_ultscore((SALT38.StrType)le.ultscore);
    SELF.ultweight_Invalid := party_Fields.InValid_ultweight((SALT38.StrType)le.ultweight);
    SELF.source_rec_id_Invalid := party_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id);
    SELF.did_Invalid := party_Fields.InValid_did((SALT38.StrType)le.did);
    SELF.did_score_Invalid := party_Fields.InValid_did_score((SALT38.StrType)le.did_score);
    SELF.bdid_Invalid := party_Fields.InValid_bdid((SALT38.StrType)le.bdid);
    SELF.bdid_score_Invalid := party_Fields.InValid_bdid_score((SALT38.StrType)le.bdid_score);
    SELF.ssn_appended_Invalid := party_Fields.InValid_ssn_appended((SALT38.StrType)le.ssn_appended);
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
    AnyRule_WithErrorsCount := COUNT(GROUP, h.batch_number_Invalid > 0 OR h.incident_number_Invalid > 0 OR h.party_number_Invalid > 0 OR h.order_number_Invalid > 0 OR h.party_name_Invalid > 0 OR h.inzip_Invalid > 0 OR h.ssnumber_Invalid > 0 OR h.fines_levied_Invalid > 0 OR h.restitution_Invalid > 0 OR h.st_Invalid > 0 OR h.dotid_Invalid > 0 OR h.dotscore_Invalid > 0 OR h.dotweight_Invalid > 0 OR h.empid_Invalid > 0 OR h.empscore_Invalid > 0 OR h.empweight_Invalid > 0 OR h.powid_Invalid > 0 OR h.powscore_Invalid > 0 OR h.powweight_Invalid > 0 OR h.proxid_Invalid > 0 OR h.proxscore_Invalid > 0 OR h.proxweight_Invalid > 0 OR h.seleid_Invalid > 0 OR h.selescore_Invalid > 0 OR h.seleweight_Invalid > 0 OR h.orgid_Invalid > 0 OR h.orgscore_Invalid > 0 OR h.orgweight_Invalid > 0 OR h.ultid_Invalid > 0 OR h.ultscore_Invalid > 0 OR h.ultweight_Invalid > 0 OR h.source_rec_id_Invalid > 0 OR h.did_Invalid > 0 OR h.did_score_Invalid > 0 OR h.bdid_Invalid > 0 OR h.bdid_score_Invalid > 0 OR h.ssn_appended_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.batch_number_Total_ErrorCount > 0, 1, 0) + IF(le.incident_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.order_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.inzip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ssnumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fines_levied_ALLOW_ErrorCount > 0, 1, 0) + IF(le.restitution_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dotid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dotscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dotweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seleid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.selescore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seleweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_appended_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.batch_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_number_LENGTH_ErrorCount > 0, 1, 0) + IF(le.incident_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.order_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.inzip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ssnumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fines_levied_ALLOW_ErrorCount > 0, 1, 0) + IF(le.restitution_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dotid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dotscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dotweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seleid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.selescore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seleweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_appended_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
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
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.batch_number,(SALT38.StrType)le.incident_number,(SALT38.StrType)le.party_number,(SALT38.StrType)le.order_number,(SALT38.StrType)le.party_name,(SALT38.StrType)le.inzip,(SALT38.StrType)le.ssnumber,(SALT38.StrType)le.fines_levied,(SALT38.StrType)le.restitution,(SALT38.StrType)le.st,(SALT38.StrType)le.dotid,(SALT38.StrType)le.dotscore,(SALT38.StrType)le.dotweight,(SALT38.StrType)le.empid,(SALT38.StrType)le.empscore,(SALT38.StrType)le.empweight,(SALT38.StrType)le.powid,(SALT38.StrType)le.powscore,(SALT38.StrType)le.powweight,(SALT38.StrType)le.proxid,(SALT38.StrType)le.proxscore,(SALT38.StrType)le.proxweight,(SALT38.StrType)le.seleid,(SALT38.StrType)le.selescore,(SALT38.StrType)le.seleweight,(SALT38.StrType)le.orgid,(SALT38.StrType)le.orgscore,(SALT38.StrType)le.orgweight,(SALT38.StrType)le.ultid,(SALT38.StrType)le.ultscore,(SALT38.StrType)le.ultweight,(SALT38.StrType)le.source_rec_id,(SALT38.StrType)le.did,(SALT38.StrType)le.did_score,(SALT38.StrType)le.bdid,(SALT38.StrType)le.bdid_score,(SALT38.StrType)le.ssn_appended,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,37,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(party_Layout_SANCTNKeys) prevDS = DATASET([], party_Layout_SANCTNKeys), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
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
          ,'ssn_appended:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
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
          ,party_Fields.InvalidMessage_ssn_appended(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
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
          ,le.ssn_appended_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
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
          ,le.ssn_appended_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := party_hygiene(PROJECT(h, party_Layout_SANCTNKeys));
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
          ,'batch_number:' + getFieldTypeText(h.batch_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'incident_number:' + getFieldTypeText(h.incident_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party_number:' + getFieldTypeText(h.party_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'order_number:' + getFieldTypeText(h.order_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party_name:' + getFieldTypeText(h.party_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party_position:' + getFieldTypeText(h.party_position) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party_vocation:' + getFieldTypeText(h.party_vocation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party_firm:' + getFieldTypeText(h.party_firm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inaddress:' + getFieldTypeText(h.inaddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'incity:' + getFieldTypeText(h.incity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'instate:' + getFieldTypeText(h.instate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inzip:' + getFieldTypeText(h.inzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssnumber:' + getFieldTypeText(h.ssnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fines_levied:' + getFieldTypeText(h.fines_levied) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'restitution:' + getFieldTypeText(h.restitution) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ok_for_fcr:' + getFieldTypeText(h.ok_for_fcr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party_text:' + getFieldTypeText(h.party_text) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cname:' + getFieldTypeText(h.cname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'zip5:' + getFieldTypeText(h.zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_state:' + getFieldTypeText(h.fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_rec_type:' + getFieldTypeText(h.addr_rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cbsa:' + getFieldTypeText(h.cbsa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotid:' + getFieldTypeText(h.dotid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotscore:' + getFieldTypeText(h.dotscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotweight:' + getFieldTypeText(h.dotweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empid:' + getFieldTypeText(h.empid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empscore:' + getFieldTypeText(h.empscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empweight:' + getFieldTypeText(h.empweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powscore:' + getFieldTypeText(h.powscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powweight:' + getFieldTypeText(h.powweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxscore:' + getFieldTypeText(h.proxscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxweight:' + getFieldTypeText(h.proxweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selescore:' + getFieldTypeText(h.selescore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleweight:' + getFieldTypeText(h.seleweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgscore:' + getFieldTypeText(h.orgscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgweight:' + getFieldTypeText(h.orgweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultscore:' + getFieldTypeText(h.ultscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid_score:' + getFieldTypeText(h.bdid_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn_appended:' + getFieldTypeText(h.ssn_appended) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba_name:' + getFieldTypeText(h.dba_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_name:' + getFieldTypeText(h.contact_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'enh_did_src:' + getFieldTypeText(h.enh_did_src) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_batch_number_cnt
          ,le.populated_incident_number_cnt
          ,le.populated_party_number_cnt
          ,le.populated_record_type_cnt
          ,le.populated_order_number_cnt
          ,le.populated_party_name_cnt
          ,le.populated_party_position_cnt
          ,le.populated_party_vocation_cnt
          ,le.populated_party_firm_cnt
          ,le.populated_inaddress_cnt
          ,le.populated_incity_cnt
          ,le.populated_instate_cnt
          ,le.populated_inzip_cnt
          ,le.populated_ssnumber_cnt
          ,le.populated_fines_levied_cnt
          ,le.populated_restitution_cnt
          ,le.populated_ok_for_fcr_cnt
          ,le.populated_party_text_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_cname_cnt
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
          ,le.populated_zip5_cnt
          ,le.populated_zip4_cnt
          ,le.populated_fips_state_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_addr_rec_type_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_cbsa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_dotid_cnt
          ,le.populated_dotscore_cnt
          ,le.populated_dotweight_cnt
          ,le.populated_empid_cnt
          ,le.populated_empscore_cnt
          ,le.populated_empweight_cnt
          ,le.populated_powid_cnt
          ,le.populated_powscore_cnt
          ,le.populated_powweight_cnt
          ,le.populated_proxid_cnt
          ,le.populated_proxscore_cnt
          ,le.populated_proxweight_cnt
          ,le.populated_seleid_cnt
          ,le.populated_selescore_cnt
          ,le.populated_seleweight_cnt
          ,le.populated_orgid_cnt
          ,le.populated_orgscore_cnt
          ,le.populated_orgweight_cnt
          ,le.populated_ultid_cnt
          ,le.populated_ultscore_cnt
          ,le.populated_ultweight_cnt
          ,le.populated_source_rec_id_cnt
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_bdid_cnt
          ,le.populated_bdid_score_cnt
          ,le.populated_ssn_appended_cnt
          ,le.populated_dba_name_cnt
          ,le.populated_contact_name_cnt
          ,le.populated_enh_did_src_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_batch_number_pcnt
          ,le.populated_incident_number_pcnt
          ,le.populated_party_number_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_order_number_pcnt
          ,le.populated_party_name_pcnt
          ,le.populated_party_position_pcnt
          ,le.populated_party_vocation_pcnt
          ,le.populated_party_firm_pcnt
          ,le.populated_inaddress_pcnt
          ,le.populated_incity_pcnt
          ,le.populated_instate_pcnt
          ,le.populated_inzip_pcnt
          ,le.populated_ssnumber_pcnt
          ,le.populated_fines_levied_pcnt
          ,le.populated_restitution_pcnt
          ,le.populated_ok_for_fcr_pcnt
          ,le.populated_party_text_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_cname_pcnt
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
          ,le.populated_zip5_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_fips_state_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_addr_rec_type_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_cbsa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_dotid_pcnt
          ,le.populated_dotscore_pcnt
          ,le.populated_dotweight_pcnt
          ,le.populated_empid_pcnt
          ,le.populated_empscore_pcnt
          ,le.populated_empweight_pcnt
          ,le.populated_powid_pcnt
          ,le.populated_powscore_pcnt
          ,le.populated_powweight_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_proxscore_pcnt
          ,le.populated_proxweight_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_selescore_pcnt
          ,le.populated_seleweight_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_orgscore_pcnt
          ,le.populated_orgweight_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_ultscore_pcnt
          ,le.populated_ultweight_pcnt
          ,le.populated_source_rec_id_pcnt
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_bdid_score_pcnt
          ,le.populated_ssn_appended_pcnt
          ,le.populated_dba_name_pcnt
          ,le.populated_contact_name_pcnt
          ,le.populated_enh_did_src_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,82,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := party_Delta(prevDS, PROJECT(h, party_Layout_SANCTNKeys));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),82,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(party_Layout_SANCTNKeys) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_SANCTNKeys, party_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
