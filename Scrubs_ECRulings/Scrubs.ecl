IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 56;
  EXPORT NumRulesFromFieldType := 56;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 54;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_ECRulings)
    UNSIGNED1 dartid_Invalid;
    UNSIGNED1 dateadded_Invalid;
    UNSIGNED1 dateupdated_Invalid;
    UNSIGNED1 website_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 euid_Invalid;
    UNSIGNED1 policyarea_Invalid;
    UNSIGNED1 casenumber_Invalid;
    UNSIGNED1 memberstate_Invalid;
    UNSIGNED1 lastdecisiondate_Invalid;
    UNSIGNED1 businessname_Invalid;
    UNSIGNED1 region_Invalid;
    UNSIGNED1 primaryobjective_Invalid;
    UNSIGNED1 aidinstrument_Invalid;
    UNSIGNED1 casetype_Invalid;
    UNSIGNED1 durationdatefrom_Invalid;
    UNSIGNED1 durationdateto_Invalid;
    UNSIGNED1 notificationregistrationdate_Invalid;
    UNSIGNED1 dgresponsible_Invalid;
    UNSIGNED1 relatedcasenumber1_Invalid;
    UNSIGNED1 relatedcasenumber2_Invalid;
    UNSIGNED1 relatedcasenumber3_Invalid;
    UNSIGNED1 relatedcasenumber4_Invalid;
    UNSIGNED1 relatedcasenumber5_Invalid;
    UNSIGNED1 provisionaldeadlinedate_Invalid;
    UNSIGNED1 provisionaldeadlinearticle_Invalid;
    UNSIGNED1 provisionaldeadlinestatus_Invalid;
    UNSIGNED1 regulation_Invalid;
    UNSIGNED1 relatedlink_Invalid;
    UNSIGNED1 decpubid_Invalid;
    UNSIGNED1 decisiondate_Invalid;
    UNSIGNED1 decisionarticle_Invalid;
    UNSIGNED1 decisiondetails_Invalid;
    UNSIGNED1 pressrelease_Invalid;
    UNSIGNED1 pressreleasedate_Invalid;
    UNSIGNED1 publicationjournaldate_Invalid;
    UNSIGNED1 publicationjournal_Invalid;
    UNSIGNED1 publicationjournaledition_Invalid;
    UNSIGNED1 publicationjournalyear_Invalid;
    UNSIGNED1 publicationpriorjournal_Invalid;
    UNSIGNED1 publicationpriorjournaldate_Invalid;
    UNSIGNED1 econactid_Invalid;
    UNSIGNED1 economicactivity_Invalid;
    UNSIGNED1 compeventid_Invalid;
    UNSIGNED1 eventdate_Invalid;
    UNSIGNED1 eventdoctype_Invalid;
    UNSIGNED1 eventdocument_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 eu_country_code_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_ECRulings)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_ECRulings)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dartid:Invalid_No:ALLOW'
          ,'dateadded:Invalid_Date:CUSTOM'
          ,'dateupdated:Invalid_Date:CUSTOM'
          ,'website:Invalid_Alpha:ALLOW'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTHS'
          ,'euid:Invalid_No:ALLOW'
          ,'policyarea:Invalid_Alpha:ALLOW'
          ,'casenumber:Invalid_AlphaNumChar:ALLOW'
          ,'memberstate:Invalid_Alpha:ALLOW'
          ,'lastdecisiondate:Invalid_Date:CUSTOM'
          ,'businessname:Invalid_AlphaChar:ALLOW'
          ,'region:Invalid_Alpha:ALLOW'
          ,'primaryobjective:Invalid_Alpha:ALLOW'
          ,'aidinstrument:Invalid_AlphaChar:ALLOW'
          ,'casetype:Invalid_Date:CUSTOM'
          ,'durationdatefrom:Invalid_Date:CUSTOM'
          ,'durationdateto:Invalid_Future:CUSTOM'
          ,'notificationregistrationdate:Invalid_Date:CUSTOM'
          ,'dgresponsible:Invalid_Alpha:ALLOW'
          ,'relatedcasenumber1:Invalid_No:ALLOW'
          ,'relatedcasenumber2:Invalid_No:ALLOW'
          ,'relatedcasenumber3:Invalid_No:ALLOW'
          ,'relatedcasenumber4:Invalid_No:ALLOW'
          ,'relatedcasenumber5:Invalid_No:ALLOW'
          ,'provisionaldeadlinedate:Invalid_Date:CUSTOM'
          ,'provisionaldeadlinearticle:Invalid_Alpha:ALLOW'
          ,'provisionaldeadlinestatus:Invalid_Alpha:ALLOW'
          ,'regulation:Invalid_AlphaNumChar:ALLOW'
          ,'relatedlink:Invalid_Date:CUSTOM'
          ,'decpubid:Invalid_No:ALLOW'
          ,'decisiondate:Invalid_Date:CUSTOM'
          ,'decisionarticle:Invalid_AlphaNumChar:ALLOW'
          ,'decisiondetails:Invalid_Alpha:ALLOW'
          ,'pressrelease:Invalid_AlphaNumChar:ALLOW'
          ,'pressreleasedate:Invalid_Date:CUSTOM'
          ,'publicationjournaldate:Invalid_Date:CUSTOM'
          ,'publicationjournal:Invalid_AlphaNum:ALLOW'
          ,'publicationjournaledition:Invalid_No:ALLOW'
          ,'publicationjournalyear:Invalid_No:ALLOW'
          ,'publicationpriorjournal:Invalid_AlphaNum:ALLOW'
          ,'publicationpriorjournaldate:Invalid_Date:CUSTOM'
          ,'econactid:Invalid_No:ALLOW'
          ,'economicactivity:Invalid_AlphaNumChar:ALLOW'
          ,'compeventid:Invalid_No:ALLOW'
          ,'eventdate:Invalid_Date:CUSTOM'
          ,'eventdoctype:Invalid_Alpha:ALLOW'
          ,'eventdocument:Invalid_AlphaChar:ALLOW'
          ,'did:Invalid_No:ALLOW'
          ,'bdid:Invalid_No:ALLOW'
          ,'dt_vendor_first_reported:Invalid_Date:CUSTOM'
          ,'dt_vendor_last_reported:Invalid_Date:CUSTOM'
          ,'dt_first_seen:Invalid_Date:CUSTOM'
          ,'dt_last_seen:Invalid_Date:CUSTOM'
          ,'eu_country_code:Invalid_State:ALLOW','eu_country_code:Invalid_State:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_dartid(1)
          ,Fields.InvalidMessage_dateadded(1)
          ,Fields.InvalidMessage_dateupdated(1)
          ,Fields.InvalidMessage_website(1)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_euid(1)
          ,Fields.InvalidMessage_policyarea(1)
          ,Fields.InvalidMessage_casenumber(1)
          ,Fields.InvalidMessage_memberstate(1)
          ,Fields.InvalidMessage_lastdecisiondate(1)
          ,Fields.InvalidMessage_businessname(1)
          ,Fields.InvalidMessage_region(1)
          ,Fields.InvalidMessage_primaryobjective(1)
          ,Fields.InvalidMessage_aidinstrument(1)
          ,Fields.InvalidMessage_casetype(1)
          ,Fields.InvalidMessage_durationdatefrom(1)
          ,Fields.InvalidMessage_durationdateto(1)
          ,Fields.InvalidMessage_notificationregistrationdate(1)
          ,Fields.InvalidMessage_dgresponsible(1)
          ,Fields.InvalidMessage_relatedcasenumber1(1)
          ,Fields.InvalidMessage_relatedcasenumber2(1)
          ,Fields.InvalidMessage_relatedcasenumber3(1)
          ,Fields.InvalidMessage_relatedcasenumber4(1)
          ,Fields.InvalidMessage_relatedcasenumber5(1)
          ,Fields.InvalidMessage_provisionaldeadlinedate(1)
          ,Fields.InvalidMessage_provisionaldeadlinearticle(1)
          ,Fields.InvalidMessage_provisionaldeadlinestatus(1)
          ,Fields.InvalidMessage_regulation(1)
          ,Fields.InvalidMessage_relatedlink(1)
          ,Fields.InvalidMessage_decpubid(1)
          ,Fields.InvalidMessage_decisiondate(1)
          ,Fields.InvalidMessage_decisionarticle(1)
          ,Fields.InvalidMessage_decisiondetails(1)
          ,Fields.InvalidMessage_pressrelease(1)
          ,Fields.InvalidMessage_pressreleasedate(1)
          ,Fields.InvalidMessage_publicationjournaldate(1)
          ,Fields.InvalidMessage_publicationjournal(1)
          ,Fields.InvalidMessage_publicationjournaledition(1)
          ,Fields.InvalidMessage_publicationjournalyear(1)
          ,Fields.InvalidMessage_publicationpriorjournal(1)
          ,Fields.InvalidMessage_publicationpriorjournaldate(1)
          ,Fields.InvalidMessage_econactid(1)
          ,Fields.InvalidMessage_economicactivity(1)
          ,Fields.InvalidMessage_compeventid(1)
          ,Fields.InvalidMessage_eventdate(1)
          ,Fields.InvalidMessage_eventdoctype(1)
          ,Fields.InvalidMessage_eventdocument(1)
          ,Fields.InvalidMessage_did(1)
          ,Fields.InvalidMessage_bdid(1)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Fields.InvalidMessage_dt_first_seen(1)
          ,Fields.InvalidMessage_dt_last_seen(1)
          ,Fields.InvalidMessage_eu_country_code(1),Fields.InvalidMessage_eu_country_code(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_ECRulings) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dartid_Invalid := Fields.InValid_dartid((SALT311.StrType)le.dartid);
    SELF.dateadded_Invalid := Fields.InValid_dateadded((SALT311.StrType)le.dateadded);
    SELF.dateupdated_Invalid := Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated);
    SELF.website_Invalid := Fields.InValid_website((SALT311.StrType)le.website);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.euid_Invalid := Fields.InValid_euid((SALT311.StrType)le.euid);
    SELF.policyarea_Invalid := Fields.InValid_policyarea((SALT311.StrType)le.policyarea);
    SELF.casenumber_Invalid := Fields.InValid_casenumber((SALT311.StrType)le.casenumber);
    SELF.memberstate_Invalid := Fields.InValid_memberstate((SALT311.StrType)le.memberstate);
    SELF.lastdecisiondate_Invalid := Fields.InValid_lastdecisiondate((SALT311.StrType)le.lastdecisiondate);
    SELF.businessname_Invalid := Fields.InValid_businessname((SALT311.StrType)le.businessname);
    SELF.region_Invalid := Fields.InValid_region((SALT311.StrType)le.region);
    SELF.primaryobjective_Invalid := Fields.InValid_primaryobjective((SALT311.StrType)le.primaryobjective);
    SELF.aidinstrument_Invalid := Fields.InValid_aidinstrument((SALT311.StrType)le.aidinstrument);
    SELF.casetype_Invalid := Fields.InValid_casetype((SALT311.StrType)le.casetype);
    SELF.durationdatefrom_Invalid := Fields.InValid_durationdatefrom((SALT311.StrType)le.durationdatefrom);
    SELF.durationdateto_Invalid := Fields.InValid_durationdateto((SALT311.StrType)le.durationdateto);
    SELF.notificationregistrationdate_Invalid := Fields.InValid_notificationregistrationdate((SALT311.StrType)le.notificationregistrationdate);
    SELF.dgresponsible_Invalid := Fields.InValid_dgresponsible((SALT311.StrType)le.dgresponsible);
    SELF.relatedcasenumber1_Invalid := Fields.InValid_relatedcasenumber1((SALT311.StrType)le.relatedcasenumber1);
    SELF.relatedcasenumber2_Invalid := Fields.InValid_relatedcasenumber2((SALT311.StrType)le.relatedcasenumber2);
    SELF.relatedcasenumber3_Invalid := Fields.InValid_relatedcasenumber3((SALT311.StrType)le.relatedcasenumber3);
    SELF.relatedcasenumber4_Invalid := Fields.InValid_relatedcasenumber4((SALT311.StrType)le.relatedcasenumber4);
    SELF.relatedcasenumber5_Invalid := Fields.InValid_relatedcasenumber5((SALT311.StrType)le.relatedcasenumber5);
    SELF.provisionaldeadlinedate_Invalid := Fields.InValid_provisionaldeadlinedate((SALT311.StrType)le.provisionaldeadlinedate);
    SELF.provisionaldeadlinearticle_Invalid := Fields.InValid_provisionaldeadlinearticle((SALT311.StrType)le.provisionaldeadlinearticle);
    SELF.provisionaldeadlinestatus_Invalid := Fields.InValid_provisionaldeadlinestatus((SALT311.StrType)le.provisionaldeadlinestatus);
    SELF.regulation_Invalid := Fields.InValid_regulation((SALT311.StrType)le.regulation);
    SELF.relatedlink_Invalid := Fields.InValid_relatedlink((SALT311.StrType)le.relatedlink);
    SELF.decpubid_Invalid := Fields.InValid_decpubid((SALT311.StrType)le.decpubid);
    SELF.decisiondate_Invalid := Fields.InValid_decisiondate((SALT311.StrType)le.decisiondate);
    SELF.decisionarticle_Invalid := Fields.InValid_decisionarticle((SALT311.StrType)le.decisionarticle);
    SELF.decisiondetails_Invalid := Fields.InValid_decisiondetails((SALT311.StrType)le.decisiondetails);
    SELF.pressrelease_Invalid := Fields.InValid_pressrelease((SALT311.StrType)le.pressrelease);
    SELF.pressreleasedate_Invalid := Fields.InValid_pressreleasedate((SALT311.StrType)le.pressreleasedate);
    SELF.publicationjournaldate_Invalid := Fields.InValid_publicationjournaldate((SALT311.StrType)le.publicationjournaldate);
    SELF.publicationjournal_Invalid := Fields.InValid_publicationjournal((SALT311.StrType)le.publicationjournal);
    SELF.publicationjournaledition_Invalid := Fields.InValid_publicationjournaledition((SALT311.StrType)le.publicationjournaledition);
    SELF.publicationjournalyear_Invalid := Fields.InValid_publicationjournalyear((SALT311.StrType)le.publicationjournalyear);
    SELF.publicationpriorjournal_Invalid := Fields.InValid_publicationpriorjournal((SALT311.StrType)le.publicationpriorjournal);
    SELF.publicationpriorjournaldate_Invalid := Fields.InValid_publicationpriorjournaldate((SALT311.StrType)le.publicationpriorjournaldate);
    SELF.econactid_Invalid := Fields.InValid_econactid((SALT311.StrType)le.econactid);
    SELF.economicactivity_Invalid := Fields.InValid_economicactivity((SALT311.StrType)le.economicactivity);
    SELF.compeventid_Invalid := Fields.InValid_compeventid((SALT311.StrType)le.compeventid);
    SELF.eventdate_Invalid := Fields.InValid_eventdate((SALT311.StrType)le.eventdate);
    SELF.eventdoctype_Invalid := Fields.InValid_eventdoctype((SALT311.StrType)le.eventdoctype);
    SELF.eventdocument_Invalid := Fields.InValid_eventdocument((SALT311.StrType)le.eventdocument);
    SELF.did_Invalid := Fields.InValid_did((SALT311.StrType)le.did);
    SELF.bdid_Invalid := Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.eu_country_code_Invalid := Fields.InValid_eu_country_code((SALT311.StrType)le.eu_country_code);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_ECRulings);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dartid_Invalid << 0 ) + ( le.dateadded_Invalid << 1 ) + ( le.dateupdated_Invalid << 2 ) + ( le.website_Invalid << 3 ) + ( le.state_Invalid << 4 ) + ( le.euid_Invalid << 6 ) + ( le.policyarea_Invalid << 7 ) + ( le.casenumber_Invalid << 8 ) + ( le.memberstate_Invalid << 9 ) + ( le.lastdecisiondate_Invalid << 10 ) + ( le.businessname_Invalid << 11 ) + ( le.region_Invalid << 12 ) + ( le.primaryobjective_Invalid << 13 ) + ( le.aidinstrument_Invalid << 14 ) + ( le.casetype_Invalid << 15 ) + ( le.durationdatefrom_Invalid << 16 ) + ( le.durationdateto_Invalid << 17 ) + ( le.notificationregistrationdate_Invalid << 18 ) + ( le.dgresponsible_Invalid << 19 ) + ( le.relatedcasenumber1_Invalid << 20 ) + ( le.relatedcasenumber2_Invalid << 21 ) + ( le.relatedcasenumber3_Invalid << 22 ) + ( le.relatedcasenumber4_Invalid << 23 ) + ( le.relatedcasenumber5_Invalid << 24 ) + ( le.provisionaldeadlinedate_Invalid << 25 ) + ( le.provisionaldeadlinearticle_Invalid << 26 ) + ( le.provisionaldeadlinestatus_Invalid << 27 ) + ( le.regulation_Invalid << 28 ) + ( le.relatedlink_Invalid << 29 ) + ( le.decpubid_Invalid << 30 ) + ( le.decisiondate_Invalid << 31 ) + ( le.decisionarticle_Invalid << 32 ) + ( le.decisiondetails_Invalid << 33 ) + ( le.pressrelease_Invalid << 34 ) + ( le.pressreleasedate_Invalid << 35 ) + ( le.publicationjournaldate_Invalid << 36 ) + ( le.publicationjournal_Invalid << 37 ) + ( le.publicationjournaledition_Invalid << 38 ) + ( le.publicationjournalyear_Invalid << 39 ) + ( le.publicationpriorjournal_Invalid << 40 ) + ( le.publicationpriorjournaldate_Invalid << 41 ) + ( le.econactid_Invalid << 42 ) + ( le.economicactivity_Invalid << 43 ) + ( le.compeventid_Invalid << 44 ) + ( le.eventdate_Invalid << 45 ) + ( le.eventdoctype_Invalid << 46 ) + ( le.eventdocument_Invalid << 47 ) + ( le.did_Invalid << 48 ) + ( le.bdid_Invalid << 49 ) + ( le.dt_vendor_first_reported_Invalid << 50 ) + ( le.dt_vendor_last_reported_Invalid << 51 ) + ( le.dt_first_seen_Invalid << 52 ) + ( le.dt_last_seen_Invalid << 53 ) + ( le.eu_country_code_Invalid << 54 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,Layout_ECRulings);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dartid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dateadded_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dateupdated_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.website_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.euid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.policyarea_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.casenumber_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.memberstate_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.lastdecisiondate_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.businessname_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.region_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.primaryobjective_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.aidinstrument_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.casetype_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.durationdatefrom_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.durationdateto_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.notificationregistrationdate_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.dgresponsible_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.relatedcasenumber1_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.relatedcasenumber2_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.relatedcasenumber3_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.relatedcasenumber4_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.relatedcasenumber5_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.provisionaldeadlinedate_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.provisionaldeadlinearticle_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.provisionaldeadlinestatus_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.regulation_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.relatedlink_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.decpubid_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.decisiondate_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.decisionarticle_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.decisiondetails_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.pressrelease_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.pressreleasedate_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.publicationjournaldate_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.publicationjournal_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.publicationjournaledition_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.publicationjournalyear_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.publicationpriorjournal_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.publicationpriorjournaldate_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.econactid_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.economicactivity_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.compeventid_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.eventdate_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.eventdoctype_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.eventdocument_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.eu_country_code_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dartid_ALLOW_ErrorCount := COUNT(GROUP,h.dartid_Invalid=1);
    dateadded_CUSTOM_ErrorCount := COUNT(GROUP,h.dateadded_Invalid=1);
    dateupdated_CUSTOM_ErrorCount := COUNT(GROUP,h.dateupdated_Invalid=1);
    website_ALLOW_ErrorCount := COUNT(GROUP,h.website_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    euid_ALLOW_ErrorCount := COUNT(GROUP,h.euid_Invalid=1);
    policyarea_ALLOW_ErrorCount := COUNT(GROUP,h.policyarea_Invalid=1);
    casenumber_ALLOW_ErrorCount := COUNT(GROUP,h.casenumber_Invalid=1);
    memberstate_ALLOW_ErrorCount := COUNT(GROUP,h.memberstate_Invalid=1);
    lastdecisiondate_CUSTOM_ErrorCount := COUNT(GROUP,h.lastdecisiondate_Invalid=1);
    businessname_ALLOW_ErrorCount := COUNT(GROUP,h.businessname_Invalid=1);
    region_ALLOW_ErrorCount := COUNT(GROUP,h.region_Invalid=1);
    primaryobjective_ALLOW_ErrorCount := COUNT(GROUP,h.primaryobjective_Invalid=1);
    aidinstrument_ALLOW_ErrorCount := COUNT(GROUP,h.aidinstrument_Invalid=1);
    casetype_CUSTOM_ErrorCount := COUNT(GROUP,h.casetype_Invalid=1);
    durationdatefrom_CUSTOM_ErrorCount := COUNT(GROUP,h.durationdatefrom_Invalid=1);
    durationdateto_CUSTOM_ErrorCount := COUNT(GROUP,h.durationdateto_Invalid=1);
    notificationregistrationdate_CUSTOM_ErrorCount := COUNT(GROUP,h.notificationregistrationdate_Invalid=1);
    dgresponsible_ALLOW_ErrorCount := COUNT(GROUP,h.dgresponsible_Invalid=1);
    relatedcasenumber1_ALLOW_ErrorCount := COUNT(GROUP,h.relatedcasenumber1_Invalid=1);
    relatedcasenumber2_ALLOW_ErrorCount := COUNT(GROUP,h.relatedcasenumber2_Invalid=1);
    relatedcasenumber3_ALLOW_ErrorCount := COUNT(GROUP,h.relatedcasenumber3_Invalid=1);
    relatedcasenumber4_ALLOW_ErrorCount := COUNT(GROUP,h.relatedcasenumber4_Invalid=1);
    relatedcasenumber5_ALLOW_ErrorCount := COUNT(GROUP,h.relatedcasenumber5_Invalid=1);
    provisionaldeadlinedate_CUSTOM_ErrorCount := COUNT(GROUP,h.provisionaldeadlinedate_Invalid=1);
    provisionaldeadlinearticle_ALLOW_ErrorCount := COUNT(GROUP,h.provisionaldeadlinearticle_Invalid=1);
    provisionaldeadlinestatus_ALLOW_ErrorCount := COUNT(GROUP,h.provisionaldeadlinestatus_Invalid=1);
    regulation_ALLOW_ErrorCount := COUNT(GROUP,h.regulation_Invalid=1);
    relatedlink_CUSTOM_ErrorCount := COUNT(GROUP,h.relatedlink_Invalid=1);
    decpubid_ALLOW_ErrorCount := COUNT(GROUP,h.decpubid_Invalid=1);
    decisiondate_CUSTOM_ErrorCount := COUNT(GROUP,h.decisiondate_Invalid=1);
    decisionarticle_ALLOW_ErrorCount := COUNT(GROUP,h.decisionarticle_Invalid=1);
    decisiondetails_ALLOW_ErrorCount := COUNT(GROUP,h.decisiondetails_Invalid=1);
    pressrelease_ALLOW_ErrorCount := COUNT(GROUP,h.pressrelease_Invalid=1);
    pressreleasedate_CUSTOM_ErrorCount := COUNT(GROUP,h.pressreleasedate_Invalid=1);
    publicationjournaldate_CUSTOM_ErrorCount := COUNT(GROUP,h.publicationjournaldate_Invalid=1);
    publicationjournal_ALLOW_ErrorCount := COUNT(GROUP,h.publicationjournal_Invalid=1);
    publicationjournaledition_ALLOW_ErrorCount := COUNT(GROUP,h.publicationjournaledition_Invalid=1);
    publicationjournalyear_ALLOW_ErrorCount := COUNT(GROUP,h.publicationjournalyear_Invalid=1);
    publicationpriorjournal_ALLOW_ErrorCount := COUNT(GROUP,h.publicationpriorjournal_Invalid=1);
    publicationpriorjournaldate_CUSTOM_ErrorCount := COUNT(GROUP,h.publicationpriorjournaldate_Invalid=1);
    econactid_ALLOW_ErrorCount := COUNT(GROUP,h.econactid_Invalid=1);
    economicactivity_ALLOW_ErrorCount := COUNT(GROUP,h.economicactivity_Invalid=1);
    compeventid_ALLOW_ErrorCount := COUNT(GROUP,h.compeventid_Invalid=1);
    eventdate_CUSTOM_ErrorCount := COUNT(GROUP,h.eventdate_Invalid=1);
    eventdoctype_ALLOW_ErrorCount := COUNT(GROUP,h.eventdoctype_Invalid=1);
    eventdocument_ALLOW_ErrorCount := COUNT(GROUP,h.eventdocument_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    eu_country_code_ALLOW_ErrorCount := COUNT(GROUP,h.eu_country_code_Invalid=1);
    eu_country_code_LENGTHS_ErrorCount := COUNT(GROUP,h.eu_country_code_Invalid=2);
    eu_country_code_Total_ErrorCount := COUNT(GROUP,h.eu_country_code_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dartid_Invalid > 0 OR h.dateadded_Invalid > 0 OR h.dateupdated_Invalid > 0 OR h.website_Invalid > 0 OR h.state_Invalid > 0 OR h.euid_Invalid > 0 OR h.policyarea_Invalid > 0 OR h.casenumber_Invalid > 0 OR h.memberstate_Invalid > 0 OR h.lastdecisiondate_Invalid > 0 OR h.businessname_Invalid > 0 OR h.region_Invalid > 0 OR h.primaryobjective_Invalid > 0 OR h.aidinstrument_Invalid > 0 OR h.casetype_Invalid > 0 OR h.durationdatefrom_Invalid > 0 OR h.durationdateto_Invalid > 0 OR h.notificationregistrationdate_Invalid > 0 OR h.dgresponsible_Invalid > 0 OR h.relatedcasenumber1_Invalid > 0 OR h.relatedcasenumber2_Invalid > 0 OR h.relatedcasenumber3_Invalid > 0 OR h.relatedcasenumber4_Invalid > 0 OR h.relatedcasenumber5_Invalid > 0 OR h.provisionaldeadlinedate_Invalid > 0 OR h.provisionaldeadlinearticle_Invalid > 0 OR h.provisionaldeadlinestatus_Invalid > 0 OR h.regulation_Invalid > 0 OR h.relatedlink_Invalid > 0 OR h.decpubid_Invalid > 0 OR h.decisiondate_Invalid > 0 OR h.decisionarticle_Invalid > 0 OR h.decisiondetails_Invalid > 0 OR h.pressrelease_Invalid > 0 OR h.pressreleasedate_Invalid > 0 OR h.publicationjournaldate_Invalid > 0 OR h.publicationjournal_Invalid > 0 OR h.publicationjournaledition_Invalid > 0 OR h.publicationjournalyear_Invalid > 0 OR h.publicationpriorjournal_Invalid > 0 OR h.publicationpriorjournaldate_Invalid > 0 OR h.econactid_Invalid > 0 OR h.economicactivity_Invalid > 0 OR h.compeventid_Invalid > 0 OR h.eventdate_Invalid > 0 OR h.eventdoctype_Invalid > 0 OR h.eventdocument_Invalid > 0 OR h.did_Invalid > 0 OR h.bdid_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.eu_country_code_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateadded_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.euid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policyarea_ALLOW_ErrorCount > 0, 1, 0) + IF(le.casenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.memberstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdecisiondate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.businessname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primaryobjective_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aidinstrument_ALLOW_ErrorCount > 0, 1, 0) + IF(le.casetype_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.durationdatefrom_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.durationdateto_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.notificationregistrationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dgresponsible_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedcasenumber1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedcasenumber2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedcasenumber3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedcasenumber4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedcasenumber5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.provisionaldeadlinedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.provisionaldeadlinearticle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.provisionaldeadlinestatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regulation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedlink_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.decpubid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.decisiondate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.decisionarticle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.decisiondetails_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pressrelease_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pressreleasedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.publicationjournaldate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.publicationjournal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicationjournaledition_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicationjournalyear_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicationpriorjournal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicationpriorjournaldate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.econactid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.economicactivity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.compeventid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eventdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eventdoctype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eventdocument_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eu_country_code_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateadded_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.euid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policyarea_ALLOW_ErrorCount > 0, 1, 0) + IF(le.casenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.memberstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdecisiondate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.businessname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primaryobjective_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aidinstrument_ALLOW_ErrorCount > 0, 1, 0) + IF(le.casetype_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.durationdatefrom_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.durationdateto_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.notificationregistrationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dgresponsible_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedcasenumber1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedcasenumber2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedcasenumber3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedcasenumber4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedcasenumber5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.provisionaldeadlinedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.provisionaldeadlinearticle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.provisionaldeadlinestatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regulation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.relatedlink_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.decpubid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.decisiondate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.decisionarticle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.decisiondetails_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pressrelease_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pressreleasedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.publicationjournaldate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.publicationjournal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicationjournaledition_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicationjournalyear_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicationpriorjournal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicationpriorjournaldate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.econactid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.economicactivity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.compeventid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eventdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eventdoctype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eventdocument_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eu_country_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eu_country_code_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dartid_Invalid,le.dateadded_Invalid,le.dateupdated_Invalid,le.website_Invalid,le.state_Invalid,le.euid_Invalid,le.policyarea_Invalid,le.casenumber_Invalid,le.memberstate_Invalid,le.lastdecisiondate_Invalid,le.businessname_Invalid,le.region_Invalid,le.primaryobjective_Invalid,le.aidinstrument_Invalid,le.casetype_Invalid,le.durationdatefrom_Invalid,le.durationdateto_Invalid,le.notificationregistrationdate_Invalid,le.dgresponsible_Invalid,le.relatedcasenumber1_Invalid,le.relatedcasenumber2_Invalid,le.relatedcasenumber3_Invalid,le.relatedcasenumber4_Invalid,le.relatedcasenumber5_Invalid,le.provisionaldeadlinedate_Invalid,le.provisionaldeadlinearticle_Invalid,le.provisionaldeadlinestatus_Invalid,le.regulation_Invalid,le.relatedlink_Invalid,le.decpubid_Invalid,le.decisiondate_Invalid,le.decisionarticle_Invalid,le.decisiondetails_Invalid,le.pressrelease_Invalid,le.pressreleasedate_Invalid,le.publicationjournaldate_Invalid,le.publicationjournal_Invalid,le.publicationjournaledition_Invalid,le.publicationjournalyear_Invalid,le.publicationpriorjournal_Invalid,le.publicationpriorjournaldate_Invalid,le.econactid_Invalid,le.economicactivity_Invalid,le.compeventid_Invalid,le.eventdate_Invalid,le.eventdoctype_Invalid,le.eventdocument_Invalid,le.did_Invalid,le.bdid_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.eu_country_code_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dartid(le.dartid_Invalid),Fields.InvalidMessage_dateadded(le.dateadded_Invalid),Fields.InvalidMessage_dateupdated(le.dateupdated_Invalid),Fields.InvalidMessage_website(le.website_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_euid(le.euid_Invalid),Fields.InvalidMessage_policyarea(le.policyarea_Invalid),Fields.InvalidMessage_casenumber(le.casenumber_Invalid),Fields.InvalidMessage_memberstate(le.memberstate_Invalid),Fields.InvalidMessage_lastdecisiondate(le.lastdecisiondate_Invalid),Fields.InvalidMessage_businessname(le.businessname_Invalid),Fields.InvalidMessage_region(le.region_Invalid),Fields.InvalidMessage_primaryobjective(le.primaryobjective_Invalid),Fields.InvalidMessage_aidinstrument(le.aidinstrument_Invalid),Fields.InvalidMessage_casetype(le.casetype_Invalid),Fields.InvalidMessage_durationdatefrom(le.durationdatefrom_Invalid),Fields.InvalidMessage_durationdateto(le.durationdateto_Invalid),Fields.InvalidMessage_notificationregistrationdate(le.notificationregistrationdate_Invalid),Fields.InvalidMessage_dgresponsible(le.dgresponsible_Invalid),Fields.InvalidMessage_relatedcasenumber1(le.relatedcasenumber1_Invalid),Fields.InvalidMessage_relatedcasenumber2(le.relatedcasenumber2_Invalid),Fields.InvalidMessage_relatedcasenumber3(le.relatedcasenumber3_Invalid),Fields.InvalidMessage_relatedcasenumber4(le.relatedcasenumber4_Invalid),Fields.InvalidMessage_relatedcasenumber5(le.relatedcasenumber5_Invalid),Fields.InvalidMessage_provisionaldeadlinedate(le.provisionaldeadlinedate_Invalid),Fields.InvalidMessage_provisionaldeadlinearticle(le.provisionaldeadlinearticle_Invalid),Fields.InvalidMessage_provisionaldeadlinestatus(le.provisionaldeadlinestatus_Invalid),Fields.InvalidMessage_regulation(le.regulation_Invalid),Fields.InvalidMessage_relatedlink(le.relatedlink_Invalid),Fields.InvalidMessage_decpubid(le.decpubid_Invalid),Fields.InvalidMessage_decisiondate(le.decisiondate_Invalid),Fields.InvalidMessage_decisionarticle(le.decisionarticle_Invalid),Fields.InvalidMessage_decisiondetails(le.decisiondetails_Invalid),Fields.InvalidMessage_pressrelease(le.pressrelease_Invalid),Fields.InvalidMessage_pressreleasedate(le.pressreleasedate_Invalid),Fields.InvalidMessage_publicationjournaldate(le.publicationjournaldate_Invalid),Fields.InvalidMessage_publicationjournal(le.publicationjournal_Invalid),Fields.InvalidMessage_publicationjournaledition(le.publicationjournaledition_Invalid),Fields.InvalidMessage_publicationjournalyear(le.publicationjournalyear_Invalid),Fields.InvalidMessage_publicationpriorjournal(le.publicationpriorjournal_Invalid),Fields.InvalidMessage_publicationpriorjournaldate(le.publicationpriorjournaldate_Invalid),Fields.InvalidMessage_econactid(le.econactid_Invalid),Fields.InvalidMessage_economicactivity(le.economicactivity_Invalid),Fields.InvalidMessage_compeventid(le.compeventid_Invalid),Fields.InvalidMessage_eventdate(le.eventdate_Invalid),Fields.InvalidMessage_eventdoctype(le.eventdoctype_Invalid),Fields.InvalidMessage_eventdocument(le.eventdocument_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_bdid(le.bdid_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_eu_country_code(le.eu_country_code_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dartid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dateadded_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dateupdated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.website_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.euid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.policyarea_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.casenumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.memberstate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lastdecisiondate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.businessname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.region_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primaryobjective_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aidinstrument_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.casetype_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.durationdatefrom_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.durationdateto_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.notificationregistrationdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dgresponsible_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.relatedcasenumber1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.relatedcasenumber2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.relatedcasenumber3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.relatedcasenumber4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.relatedcasenumber5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.provisionaldeadlinedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.provisionaldeadlinearticle_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.provisionaldeadlinestatus_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.regulation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.relatedlink_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.decpubid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.decisiondate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.decisionarticle_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.decisiondetails_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pressrelease_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pressreleasedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.publicationjournaldate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.publicationjournal_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.publicationjournaledition_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.publicationjournalyear_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.publicationpriorjournal_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.publicationpriorjournaldate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.econactid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.economicactivity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.compeventid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.eventdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.eventdoctype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.eventdocument_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.eu_country_code_Invalid,'ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dartid','dateadded','dateupdated','website','state','euid','policyarea','casenumber','memberstate','lastdecisiondate','businessname','region','primaryobjective','aidinstrument','casetype','durationdatefrom','durationdateto','notificationregistrationdate','dgresponsible','relatedcasenumber1','relatedcasenumber2','relatedcasenumber3','relatedcasenumber4','relatedcasenumber5','provisionaldeadlinedate','provisionaldeadlinearticle','provisionaldeadlinestatus','regulation','relatedlink','decpubid','decisiondate','decisionarticle','decisiondetails','pressrelease','pressreleasedate','publicationjournaldate','publicationjournal','publicationjournaledition','publicationjournalyear','publicationpriorjournal','publicationpriorjournaldate','econactid','economicactivity','compeventid','eventdate','eventdoctype','eventdocument','did','bdid','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','eu_country_code','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_State','Invalid_No','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_Date','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChar','Invalid_Date','Invalid_Date','Invalid_Future','Invalid_Date','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_Date','Invalid_No','Invalid_Date','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_Date','Invalid_Date','Invalid_AlphaNum','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_Date','Invalid_No','Invalid_AlphaNumChar','Invalid_No','Invalid_Date','Invalid_Alpha','Invalid_AlphaChar','Invalid_No','Invalid_No','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_State','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dartid,(SALT311.StrType)le.dateadded,(SALT311.StrType)le.dateupdated,(SALT311.StrType)le.website,(SALT311.StrType)le.state,(SALT311.StrType)le.euid,(SALT311.StrType)le.policyarea,(SALT311.StrType)le.casenumber,(SALT311.StrType)le.memberstate,(SALT311.StrType)le.lastdecisiondate,(SALT311.StrType)le.businessname,(SALT311.StrType)le.region,(SALT311.StrType)le.primaryobjective,(SALT311.StrType)le.aidinstrument,(SALT311.StrType)le.casetype,(SALT311.StrType)le.durationdatefrom,(SALT311.StrType)le.durationdateto,(SALT311.StrType)le.notificationregistrationdate,(SALT311.StrType)le.dgresponsible,(SALT311.StrType)le.relatedcasenumber1,(SALT311.StrType)le.relatedcasenumber2,(SALT311.StrType)le.relatedcasenumber3,(SALT311.StrType)le.relatedcasenumber4,(SALT311.StrType)le.relatedcasenumber5,(SALT311.StrType)le.provisionaldeadlinedate,(SALT311.StrType)le.provisionaldeadlinearticle,(SALT311.StrType)le.provisionaldeadlinestatus,(SALT311.StrType)le.regulation,(SALT311.StrType)le.relatedlink,(SALT311.StrType)le.decpubid,(SALT311.StrType)le.decisiondate,(SALT311.StrType)le.decisionarticle,(SALT311.StrType)le.decisiondetails,(SALT311.StrType)le.pressrelease,(SALT311.StrType)le.pressreleasedate,(SALT311.StrType)le.publicationjournaldate,(SALT311.StrType)le.publicationjournal,(SALT311.StrType)le.publicationjournaledition,(SALT311.StrType)le.publicationjournalyear,(SALT311.StrType)le.publicationpriorjournal,(SALT311.StrType)le.publicationpriorjournaldate,(SALT311.StrType)le.econactid,(SALT311.StrType)le.economicactivity,(SALT311.StrType)le.compeventid,(SALT311.StrType)le.eventdate,(SALT311.StrType)le.eventdoctype,(SALT311.StrType)le.eventdocument,(SALT311.StrType)le.did,(SALT311.StrType)le.bdid,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.eu_country_code,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,54,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_ECRulings) prevDS = DATASET([], Layout_ECRulings), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dartid_ALLOW_ErrorCount
          ,le.dateadded_CUSTOM_ErrorCount
          ,le.dateupdated_CUSTOM_ErrorCount
          ,le.website_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.euid_ALLOW_ErrorCount
          ,le.policyarea_ALLOW_ErrorCount
          ,le.casenumber_ALLOW_ErrorCount
          ,le.memberstate_ALLOW_ErrorCount
          ,le.lastdecisiondate_CUSTOM_ErrorCount
          ,le.businessname_ALLOW_ErrorCount
          ,le.region_ALLOW_ErrorCount
          ,le.primaryobjective_ALLOW_ErrorCount
          ,le.aidinstrument_ALLOW_ErrorCount
          ,le.casetype_CUSTOM_ErrorCount
          ,le.durationdatefrom_CUSTOM_ErrorCount
          ,le.durationdateto_CUSTOM_ErrorCount
          ,le.notificationregistrationdate_CUSTOM_ErrorCount
          ,le.dgresponsible_ALLOW_ErrorCount
          ,le.relatedcasenumber1_ALLOW_ErrorCount
          ,le.relatedcasenumber2_ALLOW_ErrorCount
          ,le.relatedcasenumber3_ALLOW_ErrorCount
          ,le.relatedcasenumber4_ALLOW_ErrorCount
          ,le.relatedcasenumber5_ALLOW_ErrorCount
          ,le.provisionaldeadlinedate_CUSTOM_ErrorCount
          ,le.provisionaldeadlinearticle_ALLOW_ErrorCount
          ,le.provisionaldeadlinestatus_ALLOW_ErrorCount
          ,le.regulation_ALLOW_ErrorCount
          ,le.relatedlink_CUSTOM_ErrorCount
          ,le.decpubid_ALLOW_ErrorCount
          ,le.decisiondate_CUSTOM_ErrorCount
          ,le.decisionarticle_ALLOW_ErrorCount
          ,le.decisiondetails_ALLOW_ErrorCount
          ,le.pressrelease_ALLOW_ErrorCount
          ,le.pressreleasedate_CUSTOM_ErrorCount
          ,le.publicationjournaldate_CUSTOM_ErrorCount
          ,le.publicationjournal_ALLOW_ErrorCount
          ,le.publicationjournaledition_ALLOW_ErrorCount
          ,le.publicationjournalyear_ALLOW_ErrorCount
          ,le.publicationpriorjournal_ALLOW_ErrorCount
          ,le.publicationpriorjournaldate_CUSTOM_ErrorCount
          ,le.econactid_ALLOW_ErrorCount
          ,le.economicactivity_ALLOW_ErrorCount
          ,le.compeventid_ALLOW_ErrorCount
          ,le.eventdate_CUSTOM_ErrorCount
          ,le.eventdoctype_ALLOW_ErrorCount
          ,le.eventdocument_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.bdid_ALLOW_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.eu_country_code_ALLOW_ErrorCount,le.eu_country_code_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dartid_ALLOW_ErrorCount
          ,le.dateadded_CUSTOM_ErrorCount
          ,le.dateupdated_CUSTOM_ErrorCount
          ,le.website_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.euid_ALLOW_ErrorCount
          ,le.policyarea_ALLOW_ErrorCount
          ,le.casenumber_ALLOW_ErrorCount
          ,le.memberstate_ALLOW_ErrorCount
          ,le.lastdecisiondate_CUSTOM_ErrorCount
          ,le.businessname_ALLOW_ErrorCount
          ,le.region_ALLOW_ErrorCount
          ,le.primaryobjective_ALLOW_ErrorCount
          ,le.aidinstrument_ALLOW_ErrorCount
          ,le.casetype_CUSTOM_ErrorCount
          ,le.durationdatefrom_CUSTOM_ErrorCount
          ,le.durationdateto_CUSTOM_ErrorCount
          ,le.notificationregistrationdate_CUSTOM_ErrorCount
          ,le.dgresponsible_ALLOW_ErrorCount
          ,le.relatedcasenumber1_ALLOW_ErrorCount
          ,le.relatedcasenumber2_ALLOW_ErrorCount
          ,le.relatedcasenumber3_ALLOW_ErrorCount
          ,le.relatedcasenumber4_ALLOW_ErrorCount
          ,le.relatedcasenumber5_ALLOW_ErrorCount
          ,le.provisionaldeadlinedate_CUSTOM_ErrorCount
          ,le.provisionaldeadlinearticle_ALLOW_ErrorCount
          ,le.provisionaldeadlinestatus_ALLOW_ErrorCount
          ,le.regulation_ALLOW_ErrorCount
          ,le.relatedlink_CUSTOM_ErrorCount
          ,le.decpubid_ALLOW_ErrorCount
          ,le.decisiondate_CUSTOM_ErrorCount
          ,le.decisionarticle_ALLOW_ErrorCount
          ,le.decisiondetails_ALLOW_ErrorCount
          ,le.pressrelease_ALLOW_ErrorCount
          ,le.pressreleasedate_CUSTOM_ErrorCount
          ,le.publicationjournaldate_CUSTOM_ErrorCount
          ,le.publicationjournal_ALLOW_ErrorCount
          ,le.publicationjournaledition_ALLOW_ErrorCount
          ,le.publicationjournalyear_ALLOW_ErrorCount
          ,le.publicationpriorjournal_ALLOW_ErrorCount
          ,le.publicationpriorjournaldate_CUSTOM_ErrorCount
          ,le.econactid_ALLOW_ErrorCount
          ,le.economicactivity_ALLOW_ErrorCount
          ,le.compeventid_ALLOW_ErrorCount
          ,le.eventdate_CUSTOM_ErrorCount
          ,le.eventdoctype_ALLOW_ErrorCount
          ,le.eventdocument_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.bdid_ALLOW_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.eu_country_code_ALLOW_ErrorCount,le.eu_country_code_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_ECRulings));
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
          ,'dartid:' + getFieldTypeText(h.dartid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateadded:' + getFieldTypeText(h.dateadded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateupdated:' + getFieldTypeText(h.dateupdated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'website:' + getFieldTypeText(h.website) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'euid:' + getFieldTypeText(h.euid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policyarea:' + getFieldTypeText(h.policyarea) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casenumber:' + getFieldTypeText(h.casenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'memberstate:' + getFieldTypeText(h.memberstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastdecisiondate:' + getFieldTypeText(h.lastdecisiondate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessname:' + getFieldTypeText(h.businessname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region:' + getFieldTypeText(h.region) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primaryobjective:' + getFieldTypeText(h.primaryobjective) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aidinstrument:' + getFieldTypeText(h.aidinstrument) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casetype:' + getFieldTypeText(h.casetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'durationdatefrom:' + getFieldTypeText(h.durationdatefrom) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'durationdateto:' + getFieldTypeText(h.durationdateto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'notificationregistrationdate:' + getFieldTypeText(h.notificationregistrationdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dgresponsible:' + getFieldTypeText(h.dgresponsible) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedcasenumber1:' + getFieldTypeText(h.relatedcasenumber1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedcaseinformation1:' + getFieldTypeText(h.relatedcaseinformation1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedcasenumber2:' + getFieldTypeText(h.relatedcasenumber2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedcaseinformation2:' + getFieldTypeText(h.relatedcaseinformation2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedcasenumber3:' + getFieldTypeText(h.relatedcasenumber3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedcaseinformation3:' + getFieldTypeText(h.relatedcaseinformation3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedcasenumber4:' + getFieldTypeText(h.relatedcasenumber4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedcaseinformation4:' + getFieldTypeText(h.relatedcaseinformation4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedcasenumber5:' + getFieldTypeText(h.relatedcasenumber5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedcaseinformation5:' + getFieldTypeText(h.relatedcaseinformation5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'provisionaldeadlinedate:' + getFieldTypeText(h.provisionaldeadlinedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'provisionaldeadlinearticle:' + getFieldTypeText(h.provisionaldeadlinearticle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'provisionaldeadlinestatus:' + getFieldTypeText(h.provisionaldeadlinestatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regulation:' + getFieldTypeText(h.regulation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relatedlink:' + getFieldTypeText(h.relatedlink) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'decpubid:' + getFieldTypeText(h.decpubid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'decisiondate:' + getFieldTypeText(h.decisiondate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'decisionarticle:' + getFieldTypeText(h.decisionarticle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'decisiondetails:' + getFieldTypeText(h.decisiondetails) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pressrelease:' + getFieldTypeText(h.pressrelease) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pressreleasedate:' + getFieldTypeText(h.pressreleasedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicationjournaldate:' + getFieldTypeText(h.publicationjournaldate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicationjournal:' + getFieldTypeText(h.publicationjournal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicationjournaledition:' + getFieldTypeText(h.publicationjournaledition) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicationjournalyear:' + getFieldTypeText(h.publicationjournalyear) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicationpriorjournal:' + getFieldTypeText(h.publicationpriorjournal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicationpriorjournaldate:' + getFieldTypeText(h.publicationpriorjournaldate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'econactid:' + getFieldTypeText(h.econactid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'economicactivity:' + getFieldTypeText(h.economicactivity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'compeventid:' + getFieldTypeText(h.compeventid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eventdate:' + getFieldTypeText(h.eventdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eventdoctype:' + getFieldTypeText(h.eventdoctype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eventdocument:' + getFieldTypeText(h.eventdocument) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu_country_code:' + getFieldTypeText(h.eu_country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dartid_cnt
          ,le.populated_dateadded_cnt
          ,le.populated_dateupdated_cnt
          ,le.populated_website_cnt
          ,le.populated_state_cnt
          ,le.populated_euid_cnt
          ,le.populated_policyarea_cnt
          ,le.populated_casenumber_cnt
          ,le.populated_memberstate_cnt
          ,le.populated_lastdecisiondate_cnt
          ,le.populated_title_cnt
          ,le.populated_businessname_cnt
          ,le.populated_region_cnt
          ,le.populated_primaryobjective_cnt
          ,le.populated_aidinstrument_cnt
          ,le.populated_casetype_cnt
          ,le.populated_durationdatefrom_cnt
          ,le.populated_durationdateto_cnt
          ,le.populated_notificationregistrationdate_cnt
          ,le.populated_dgresponsible_cnt
          ,le.populated_relatedcasenumber1_cnt
          ,le.populated_relatedcaseinformation1_cnt
          ,le.populated_relatedcasenumber2_cnt
          ,le.populated_relatedcaseinformation2_cnt
          ,le.populated_relatedcasenumber3_cnt
          ,le.populated_relatedcaseinformation3_cnt
          ,le.populated_relatedcasenumber4_cnt
          ,le.populated_relatedcaseinformation4_cnt
          ,le.populated_relatedcasenumber5_cnt
          ,le.populated_relatedcaseinformation5_cnt
          ,le.populated_provisionaldeadlinedate_cnt
          ,le.populated_provisionaldeadlinearticle_cnt
          ,le.populated_provisionaldeadlinestatus_cnt
          ,le.populated_regulation_cnt
          ,le.populated_relatedlink_cnt
          ,le.populated_decpubid_cnt
          ,le.populated_decisiondate_cnt
          ,le.populated_decisionarticle_cnt
          ,le.populated_decisiondetails_cnt
          ,le.populated_pressrelease_cnt
          ,le.populated_pressreleasedate_cnt
          ,le.populated_publicationjournaldate_cnt
          ,le.populated_publicationjournal_cnt
          ,le.populated_publicationjournaledition_cnt
          ,le.populated_publicationjournalyear_cnt
          ,le.populated_publicationpriorjournal_cnt
          ,le.populated_publicationpriorjournaldate_cnt
          ,le.populated_econactid_cnt
          ,le.populated_economicactivity_cnt
          ,le.populated_compeventid_cnt
          ,le.populated_eventdate_cnt
          ,le.populated_eventdoctype_cnt
          ,le.populated_eventdocument_cnt
          ,le.populated_did_cnt
          ,le.populated_bdid_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_eu_country_code_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dartid_pcnt
          ,le.populated_dateadded_pcnt
          ,le.populated_dateupdated_pcnt
          ,le.populated_website_pcnt
          ,le.populated_state_pcnt
          ,le.populated_euid_pcnt
          ,le.populated_policyarea_pcnt
          ,le.populated_casenumber_pcnt
          ,le.populated_memberstate_pcnt
          ,le.populated_lastdecisiondate_pcnt
          ,le.populated_title_pcnt
          ,le.populated_businessname_pcnt
          ,le.populated_region_pcnt
          ,le.populated_primaryobjective_pcnt
          ,le.populated_aidinstrument_pcnt
          ,le.populated_casetype_pcnt
          ,le.populated_durationdatefrom_pcnt
          ,le.populated_durationdateto_pcnt
          ,le.populated_notificationregistrationdate_pcnt
          ,le.populated_dgresponsible_pcnt
          ,le.populated_relatedcasenumber1_pcnt
          ,le.populated_relatedcaseinformation1_pcnt
          ,le.populated_relatedcasenumber2_pcnt
          ,le.populated_relatedcaseinformation2_pcnt
          ,le.populated_relatedcasenumber3_pcnt
          ,le.populated_relatedcaseinformation3_pcnt
          ,le.populated_relatedcasenumber4_pcnt
          ,le.populated_relatedcaseinformation4_pcnt
          ,le.populated_relatedcasenumber5_pcnt
          ,le.populated_relatedcaseinformation5_pcnt
          ,le.populated_provisionaldeadlinedate_pcnt
          ,le.populated_provisionaldeadlinearticle_pcnt
          ,le.populated_provisionaldeadlinestatus_pcnt
          ,le.populated_regulation_pcnt
          ,le.populated_relatedlink_pcnt
          ,le.populated_decpubid_pcnt
          ,le.populated_decisiondate_pcnt
          ,le.populated_decisionarticle_pcnt
          ,le.populated_decisiondetails_pcnt
          ,le.populated_pressrelease_pcnt
          ,le.populated_pressreleasedate_pcnt
          ,le.populated_publicationjournaldate_pcnt
          ,le.populated_publicationjournal_pcnt
          ,le.populated_publicationjournaledition_pcnt
          ,le.populated_publicationjournalyear_pcnt
          ,le.populated_publicationpriorjournal_pcnt
          ,le.populated_publicationpriorjournaldate_pcnt
          ,le.populated_econactid_pcnt
          ,le.populated_economicactivity_pcnt
          ,le.populated_compeventid_pcnt
          ,le.populated_eventdate_pcnt
          ,le.populated_eventdoctype_pcnt
          ,le.populated_eventdocument_pcnt
          ,le.populated_did_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_eu_country_code_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,60,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_ECRulings));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),60,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_ECRulings) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_ECRulings, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
