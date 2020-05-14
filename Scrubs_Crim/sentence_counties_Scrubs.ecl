IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT sentence_counties_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 40;
  EXPORT NumRulesFromFieldType := 40;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 40;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(sentence_counties_Layout_crim)
    UNSIGNED1 recordid_Invalid;
    UNSIGNED1 statecode_Invalid;
    UNSIGNED1 caseid_Invalid;
    UNSIGNED1 sentencedate_Invalid;
    UNSIGNED1 sentencebegindate_Invalid;
    UNSIGNED1 sentenceenddate_Invalid;
    UNSIGNED1 sentencemaxyears_Invalid;
    UNSIGNED1 sentencemaxmonths_Invalid;
    UNSIGNED1 sentencemaxdays_Invalid;
    UNSIGNED1 sentenceminyears_Invalid;
    UNSIGNED1 sentenceminmonths_Invalid;
    UNSIGNED1 sentencemindays_Invalid;
    UNSIGNED1 scheduledreleasedate_Invalid;
    UNSIGNED1 actualreleasedate_Invalid;
    UNSIGNED1 timeservedyears_Invalid;
    UNSIGNED1 timeservedmonths_Invalid;
    UNSIGNED1 timeserveddays_Invalid;
    UNSIGNED1 publicservicehours_Invalid;
    UNSIGNED1 communitysupervisionyears_Invalid;
    UNSIGNED1 communitysupervisionmonths_Invalid;
    UNSIGNED1 communitysupervisiondays_Invalid;
    UNSIGNED1 parolebegindate_Invalid;
    UNSIGNED1 paroleenddate_Invalid;
    UNSIGNED1 paroleeligibilitydate_Invalid;
    UNSIGNED1 parolehearingdate_Invalid;
    UNSIGNED1 parolemaxyears_Invalid;
    UNSIGNED1 parolemaxmonths_Invalid;
    UNSIGNED1 parolemaxdays_Invalid;
    UNSIGNED1 paroleminyears_Invalid;
    UNSIGNED1 paroleminmonths_Invalid;
    UNSIGNED1 parolemindays_Invalid;
    UNSIGNED1 probationbegindate_Invalid;
    UNSIGNED1 probationenddate_Invalid;
    UNSIGNED1 probationmaxyears_Invalid;
    UNSIGNED1 probationmaxmonths_Invalid;
    UNSIGNED1 probationmaxdays_Invalid;
    UNSIGNED1 probationminyears_Invalid;
    UNSIGNED1 probationminmonths_Invalid;
    UNSIGNED1 probationmindays_Invalid;
    UNSIGNED1 sourcename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(sentence_counties_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(sentence_counties_Layout_crim)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'recordid:Invalid_Record_ID:ALLOW'
          ,'statecode:Invalid_Char:ALLOW'
          ,'caseid:Non_Blank:LENGTHS'
          ,'sentencedate:Invalid_Future_Date:CUSTOM'
          ,'sentencebegindate:Invalid_Future_Date:CUSTOM'
          ,'sentenceenddate:Invalid_Future_Date:CUSTOM'
          ,'sentencemaxyears:Invalid_Time:ALLOW'
          ,'sentencemaxmonths:Invalid_Time:ALLOW'
          ,'sentencemaxdays:Invalid_Time:ALLOW'
          ,'sentenceminyears:Invalid_Time:ALLOW'
          ,'sentenceminmonths:Invalid_Time:ALLOW'
          ,'sentencemindays:Invalid_Time:ALLOW'
          ,'scheduledreleasedate:Invalid_Future_Date:CUSTOM'
          ,'actualreleasedate:Invalid_Future_Date:CUSTOM'
          ,'timeservedyears:Invalid_Time:ALLOW'
          ,'timeservedmonths:Invalid_Time:ALLOW'
          ,'timeserveddays:Invalid_Time:ALLOW'
          ,'publicservicehours:Invalid_Num:ALLOW'
          ,'communitysupervisionyears:Invalid_Time:ALLOW'
          ,'communitysupervisionmonths:Invalid_Time:ALLOW'
          ,'communitysupervisiondays:Invalid_Time:ALLOW'
          ,'parolebegindate:Invalid_Future_Date:CUSTOM'
          ,'paroleenddate:Invalid_Future_Date:CUSTOM'
          ,'paroleeligibilitydate:Invalid_Future_Date:CUSTOM'
          ,'parolehearingdate:Invalid_Future_Date:CUSTOM'
          ,'parolemaxyears:Invalid_Time:ALLOW'
          ,'parolemaxmonths:Invalid_Time:ALLOW'
          ,'parolemaxdays:Invalid_Time:ALLOW'
          ,'paroleminyears:Invalid_Time:ALLOW'
          ,'paroleminmonths:Invalid_Time:ALLOW'
          ,'parolemindays:Invalid_Time:ALLOW'
          ,'probationbegindate:Invalid_Future_Date:CUSTOM'
          ,'probationenddate:Invalid_Future_Date:CUSTOM'
          ,'probationmaxyears:Invalid_Time:ALLOW'
          ,'probationmaxmonths:Invalid_Time:ALLOW'
          ,'probationmaxdays:Invalid_Time:ALLOW'
          ,'probationminyears:Invalid_Time:ALLOW'
          ,'probationminmonths:Invalid_Time:ALLOW'
          ,'probationmindays:Invalid_Time:ALLOW'
          ,'sourcename:Non_Blank:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,sentence_counties_Fields.InvalidMessage_recordid(1)
          ,sentence_counties_Fields.InvalidMessage_statecode(1)
          ,sentence_counties_Fields.InvalidMessage_caseid(1)
          ,sentence_counties_Fields.InvalidMessage_sentencedate(1)
          ,sentence_counties_Fields.InvalidMessage_sentencebegindate(1)
          ,sentence_counties_Fields.InvalidMessage_sentenceenddate(1)
          ,sentence_counties_Fields.InvalidMessage_sentencemaxyears(1)
          ,sentence_counties_Fields.InvalidMessage_sentencemaxmonths(1)
          ,sentence_counties_Fields.InvalidMessage_sentencemaxdays(1)
          ,sentence_counties_Fields.InvalidMessage_sentenceminyears(1)
          ,sentence_counties_Fields.InvalidMessage_sentenceminmonths(1)
          ,sentence_counties_Fields.InvalidMessage_sentencemindays(1)
          ,sentence_counties_Fields.InvalidMessage_scheduledreleasedate(1)
          ,sentence_counties_Fields.InvalidMessage_actualreleasedate(1)
          ,sentence_counties_Fields.InvalidMessage_timeservedyears(1)
          ,sentence_counties_Fields.InvalidMessage_timeservedmonths(1)
          ,sentence_counties_Fields.InvalidMessage_timeserveddays(1)
          ,sentence_counties_Fields.InvalidMessage_publicservicehours(1)
          ,sentence_counties_Fields.InvalidMessage_communitysupervisionyears(1)
          ,sentence_counties_Fields.InvalidMessage_communitysupervisionmonths(1)
          ,sentence_counties_Fields.InvalidMessage_communitysupervisiondays(1)
          ,sentence_counties_Fields.InvalidMessage_parolebegindate(1)
          ,sentence_counties_Fields.InvalidMessage_paroleenddate(1)
          ,sentence_counties_Fields.InvalidMessage_paroleeligibilitydate(1)
          ,sentence_counties_Fields.InvalidMessage_parolehearingdate(1)
          ,sentence_counties_Fields.InvalidMessage_parolemaxyears(1)
          ,sentence_counties_Fields.InvalidMessage_parolemaxmonths(1)
          ,sentence_counties_Fields.InvalidMessage_parolemaxdays(1)
          ,sentence_counties_Fields.InvalidMessage_paroleminyears(1)
          ,sentence_counties_Fields.InvalidMessage_paroleminmonths(1)
          ,sentence_counties_Fields.InvalidMessage_parolemindays(1)
          ,sentence_counties_Fields.InvalidMessage_probationbegindate(1)
          ,sentence_counties_Fields.InvalidMessage_probationenddate(1)
          ,sentence_counties_Fields.InvalidMessage_probationmaxyears(1)
          ,sentence_counties_Fields.InvalidMessage_probationmaxmonths(1)
          ,sentence_counties_Fields.InvalidMessage_probationmaxdays(1)
          ,sentence_counties_Fields.InvalidMessage_probationminyears(1)
          ,sentence_counties_Fields.InvalidMessage_probationminmonths(1)
          ,sentence_counties_Fields.InvalidMessage_probationmindays(1)
          ,sentence_counties_Fields.InvalidMessage_sourcename(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(sentence_counties_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.recordid_Invalid := sentence_counties_Fields.InValid_recordid((SALT311.StrType)le.recordid);
    SELF.statecode_Invalid := sentence_counties_Fields.InValid_statecode((SALT311.StrType)le.statecode);
    SELF.caseid_Invalid := sentence_counties_Fields.InValid_caseid((SALT311.StrType)le.caseid);
    SELF.sentencedate_Invalid := sentence_counties_Fields.InValid_sentencedate((SALT311.StrType)le.sentencedate);
    SELF.sentencebegindate_Invalid := sentence_counties_Fields.InValid_sentencebegindate((SALT311.StrType)le.sentencebegindate);
    SELF.sentenceenddate_Invalid := sentence_counties_Fields.InValid_sentenceenddate((SALT311.StrType)le.sentenceenddate);
    SELF.sentencemaxyears_Invalid := sentence_counties_Fields.InValid_sentencemaxyears((SALT311.StrType)le.sentencemaxyears);
    SELF.sentencemaxmonths_Invalid := sentence_counties_Fields.InValid_sentencemaxmonths((SALT311.StrType)le.sentencemaxmonths);
    SELF.sentencemaxdays_Invalid := sentence_counties_Fields.InValid_sentencemaxdays((SALT311.StrType)le.sentencemaxdays);
    SELF.sentenceminyears_Invalid := sentence_counties_Fields.InValid_sentenceminyears((SALT311.StrType)le.sentenceminyears);
    SELF.sentenceminmonths_Invalid := sentence_counties_Fields.InValid_sentenceminmonths((SALT311.StrType)le.sentenceminmonths);
    SELF.sentencemindays_Invalid := sentence_counties_Fields.InValid_sentencemindays((SALT311.StrType)le.sentencemindays);
    SELF.scheduledreleasedate_Invalid := sentence_counties_Fields.InValid_scheduledreleasedate((SALT311.StrType)le.scheduledreleasedate);
    SELF.actualreleasedate_Invalid := sentence_counties_Fields.InValid_actualreleasedate((SALT311.StrType)le.actualreleasedate);
    SELF.timeservedyears_Invalid := sentence_counties_Fields.InValid_timeservedyears((SALT311.StrType)le.timeservedyears);
    SELF.timeservedmonths_Invalid := sentence_counties_Fields.InValid_timeservedmonths((SALT311.StrType)le.timeservedmonths);
    SELF.timeserveddays_Invalid := sentence_counties_Fields.InValid_timeserveddays((SALT311.StrType)le.timeserveddays);
    SELF.publicservicehours_Invalid := sentence_counties_Fields.InValid_publicservicehours((SALT311.StrType)le.publicservicehours);
    SELF.communitysupervisionyears_Invalid := sentence_counties_Fields.InValid_communitysupervisionyears((SALT311.StrType)le.communitysupervisionyears);
    SELF.communitysupervisionmonths_Invalid := sentence_counties_Fields.InValid_communitysupervisionmonths((SALT311.StrType)le.communitysupervisionmonths);
    SELF.communitysupervisiondays_Invalid := sentence_counties_Fields.InValid_communitysupervisiondays((SALT311.StrType)le.communitysupervisiondays);
    SELF.parolebegindate_Invalid := sentence_counties_Fields.InValid_parolebegindate((SALT311.StrType)le.parolebegindate);
    SELF.paroleenddate_Invalid := sentence_counties_Fields.InValid_paroleenddate((SALT311.StrType)le.paroleenddate);
    SELF.paroleeligibilitydate_Invalid := sentence_counties_Fields.InValid_paroleeligibilitydate((SALT311.StrType)le.paroleeligibilitydate);
    SELF.parolehearingdate_Invalid := sentence_counties_Fields.InValid_parolehearingdate((SALT311.StrType)le.parolehearingdate);
    SELF.parolemaxyears_Invalid := sentence_counties_Fields.InValid_parolemaxyears((SALT311.StrType)le.parolemaxyears);
    SELF.parolemaxmonths_Invalid := sentence_counties_Fields.InValid_parolemaxmonths((SALT311.StrType)le.parolemaxmonths);
    SELF.parolemaxdays_Invalid := sentence_counties_Fields.InValid_parolemaxdays((SALT311.StrType)le.parolemaxdays);
    SELF.paroleminyears_Invalid := sentence_counties_Fields.InValid_paroleminyears((SALT311.StrType)le.paroleminyears);
    SELF.paroleminmonths_Invalid := sentence_counties_Fields.InValid_paroleminmonths((SALT311.StrType)le.paroleminmonths);
    SELF.parolemindays_Invalid := sentence_counties_Fields.InValid_parolemindays((SALT311.StrType)le.parolemindays);
    SELF.probationbegindate_Invalid := sentence_counties_Fields.InValid_probationbegindate((SALT311.StrType)le.probationbegindate);
    SELF.probationenddate_Invalid := sentence_counties_Fields.InValid_probationenddate((SALT311.StrType)le.probationenddate);
    SELF.probationmaxyears_Invalid := sentence_counties_Fields.InValid_probationmaxyears((SALT311.StrType)le.probationmaxyears);
    SELF.probationmaxmonths_Invalid := sentence_counties_Fields.InValid_probationmaxmonths((SALT311.StrType)le.probationmaxmonths);
    SELF.probationmaxdays_Invalid := sentence_counties_Fields.InValid_probationmaxdays((SALT311.StrType)le.probationmaxdays);
    SELF.probationminyears_Invalid := sentence_counties_Fields.InValid_probationminyears((SALT311.StrType)le.probationminyears);
    SELF.probationminmonths_Invalid := sentence_counties_Fields.InValid_probationminmonths((SALT311.StrType)le.probationminmonths);
    SELF.probationmindays_Invalid := sentence_counties_Fields.InValid_probationmindays((SALT311.StrType)le.probationmindays);
    SELF.sourcename_Invalid := sentence_counties_Fields.InValid_sourcename((SALT311.StrType)le.sourcename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),sentence_counties_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.recordid_Invalid << 0 ) + ( le.statecode_Invalid << 1 ) + ( le.caseid_Invalid << 2 ) + ( le.sentencedate_Invalid << 3 ) + ( le.sentencebegindate_Invalid << 4 ) + ( le.sentenceenddate_Invalid << 5 ) + ( le.sentencemaxyears_Invalid << 6 ) + ( le.sentencemaxmonths_Invalid << 7 ) + ( le.sentencemaxdays_Invalid << 8 ) + ( le.sentenceminyears_Invalid << 9 ) + ( le.sentenceminmonths_Invalid << 10 ) + ( le.sentencemindays_Invalid << 11 ) + ( le.scheduledreleasedate_Invalid << 12 ) + ( le.actualreleasedate_Invalid << 13 ) + ( le.timeservedyears_Invalid << 14 ) + ( le.timeservedmonths_Invalid << 15 ) + ( le.timeserveddays_Invalid << 16 ) + ( le.publicservicehours_Invalid << 17 ) + ( le.communitysupervisionyears_Invalid << 18 ) + ( le.communitysupervisionmonths_Invalid << 19 ) + ( le.communitysupervisiondays_Invalid << 20 ) + ( le.parolebegindate_Invalid << 21 ) + ( le.paroleenddate_Invalid << 22 ) + ( le.paroleeligibilitydate_Invalid << 23 ) + ( le.parolehearingdate_Invalid << 24 ) + ( le.parolemaxyears_Invalid << 25 ) + ( le.parolemaxmonths_Invalid << 26 ) + ( le.parolemaxdays_Invalid << 27 ) + ( le.paroleminyears_Invalid << 28 ) + ( le.paroleminmonths_Invalid << 29 ) + ( le.parolemindays_Invalid << 30 ) + ( le.probationbegindate_Invalid << 31 ) + ( le.probationenddate_Invalid << 32 ) + ( le.probationmaxyears_Invalid << 33 ) + ( le.probationmaxmonths_Invalid << 34 ) + ( le.probationmaxdays_Invalid << 35 ) + ( le.probationminyears_Invalid << 36 ) + ( le.probationminmonths_Invalid << 37 ) + ( le.probationmindays_Invalid << 38 ) + ( le.sourcename_Invalid << 39 );
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
  EXPORT Infile := PROJECT(h,sentence_counties_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.recordid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.statecode_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.caseid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.sentencedate_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.sentencebegindate_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.sentenceenddate_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.sentencemaxyears_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.sentencemaxmonths_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.sentencemaxdays_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sentenceminyears_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.sentenceminmonths_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.sentencemindays_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.scheduledreleasedate_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.actualreleasedate_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.timeservedyears_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.timeservedmonths_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.timeserveddays_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.publicservicehours_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.communitysupervisionyears_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.communitysupervisionmonths_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.communitysupervisiondays_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.parolebegindate_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.paroleenddate_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.paroleeligibilitydate_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.parolehearingdate_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.parolemaxyears_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.parolemaxmonths_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.parolemaxdays_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.paroleminyears_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.paroleminmonths_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.parolemindays_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.probationbegindate_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.probationenddate_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.probationmaxyears_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.probationmaxmonths_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.probationmaxdays_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.probationminyears_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.probationminmonths_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.probationmindays_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.sourcename_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.vendor) vendor := IF(Glob, '', h.vendor);
    TotalCnt := COUNT(GROUP); // Number of records in total
    recordid_ALLOW_ErrorCount := COUNT(GROUP,h.recordid_Invalid=1);
    statecode_ALLOW_ErrorCount := COUNT(GROUP,h.statecode_Invalid=1);
    caseid_LENGTHS_ErrorCount := COUNT(GROUP,h.caseid_Invalid=1);
    sentencedate_CUSTOM_ErrorCount := COUNT(GROUP,h.sentencedate_Invalid=1);
    sentencebegindate_CUSTOM_ErrorCount := COUNT(GROUP,h.sentencebegindate_Invalid=1);
    sentenceenddate_CUSTOM_ErrorCount := COUNT(GROUP,h.sentenceenddate_Invalid=1);
    sentencemaxyears_ALLOW_ErrorCount := COUNT(GROUP,h.sentencemaxyears_Invalid=1);
    sentencemaxmonths_ALLOW_ErrorCount := COUNT(GROUP,h.sentencemaxmonths_Invalid=1);
    sentencemaxdays_ALLOW_ErrorCount := COUNT(GROUP,h.sentencemaxdays_Invalid=1);
    sentenceminyears_ALLOW_ErrorCount := COUNT(GROUP,h.sentenceminyears_Invalid=1);
    sentenceminmonths_ALLOW_ErrorCount := COUNT(GROUP,h.sentenceminmonths_Invalid=1);
    sentencemindays_ALLOW_ErrorCount := COUNT(GROUP,h.sentencemindays_Invalid=1);
    scheduledreleasedate_CUSTOM_ErrorCount := COUNT(GROUP,h.scheduledreleasedate_Invalid=1);
    actualreleasedate_CUSTOM_ErrorCount := COUNT(GROUP,h.actualreleasedate_Invalid=1);
    timeservedyears_ALLOW_ErrorCount := COUNT(GROUP,h.timeservedyears_Invalid=1);
    timeservedmonths_ALLOW_ErrorCount := COUNT(GROUP,h.timeservedmonths_Invalid=1);
    timeserveddays_ALLOW_ErrorCount := COUNT(GROUP,h.timeserveddays_Invalid=1);
    publicservicehours_ALLOW_ErrorCount := COUNT(GROUP,h.publicservicehours_Invalid=1);
    communitysupervisionyears_ALLOW_ErrorCount := COUNT(GROUP,h.communitysupervisionyears_Invalid=1);
    communitysupervisionmonths_ALLOW_ErrorCount := COUNT(GROUP,h.communitysupervisionmonths_Invalid=1);
    communitysupervisiondays_ALLOW_ErrorCount := COUNT(GROUP,h.communitysupervisiondays_Invalid=1);
    parolebegindate_CUSTOM_ErrorCount := COUNT(GROUP,h.parolebegindate_Invalid=1);
    paroleenddate_CUSTOM_ErrorCount := COUNT(GROUP,h.paroleenddate_Invalid=1);
    paroleeligibilitydate_CUSTOM_ErrorCount := COUNT(GROUP,h.paroleeligibilitydate_Invalid=1);
    parolehearingdate_CUSTOM_ErrorCount := COUNT(GROUP,h.parolehearingdate_Invalid=1);
    parolemaxyears_ALLOW_ErrorCount := COUNT(GROUP,h.parolemaxyears_Invalid=1);
    parolemaxmonths_ALLOW_ErrorCount := COUNT(GROUP,h.parolemaxmonths_Invalid=1);
    parolemaxdays_ALLOW_ErrorCount := COUNT(GROUP,h.parolemaxdays_Invalid=1);
    paroleminyears_ALLOW_ErrorCount := COUNT(GROUP,h.paroleminyears_Invalid=1);
    paroleminmonths_ALLOW_ErrorCount := COUNT(GROUP,h.paroleminmonths_Invalid=1);
    parolemindays_ALLOW_ErrorCount := COUNT(GROUP,h.parolemindays_Invalid=1);
    probationbegindate_CUSTOM_ErrorCount := COUNT(GROUP,h.probationbegindate_Invalid=1);
    probationenddate_CUSTOM_ErrorCount := COUNT(GROUP,h.probationenddate_Invalid=1);
    probationmaxyears_ALLOW_ErrorCount := COUNT(GROUP,h.probationmaxyears_Invalid=1);
    probationmaxmonths_ALLOW_ErrorCount := COUNT(GROUP,h.probationmaxmonths_Invalid=1);
    probationmaxdays_ALLOW_ErrorCount := COUNT(GROUP,h.probationmaxdays_Invalid=1);
    probationminyears_ALLOW_ErrorCount := COUNT(GROUP,h.probationminyears_Invalid=1);
    probationminmonths_ALLOW_ErrorCount := COUNT(GROUP,h.probationminmonths_Invalid=1);
    probationmindays_ALLOW_ErrorCount := COUNT(GROUP,h.probationmindays_Invalid=1);
    sourcename_LENGTHS_ErrorCount := COUNT(GROUP,h.sourcename_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.recordid_Invalid > 0 OR h.statecode_Invalid > 0 OR h.caseid_Invalid > 0 OR h.sentencedate_Invalid > 0 OR h.sentencebegindate_Invalid > 0 OR h.sentenceenddate_Invalid > 0 OR h.sentencemaxyears_Invalid > 0 OR h.sentencemaxmonths_Invalid > 0 OR h.sentencemaxdays_Invalid > 0 OR h.sentenceminyears_Invalid > 0 OR h.sentenceminmonths_Invalid > 0 OR h.sentencemindays_Invalid > 0 OR h.scheduledreleasedate_Invalid > 0 OR h.actualreleasedate_Invalid > 0 OR h.timeservedyears_Invalid > 0 OR h.timeservedmonths_Invalid > 0 OR h.timeserveddays_Invalid > 0 OR h.publicservicehours_Invalid > 0 OR h.communitysupervisionyears_Invalid > 0 OR h.communitysupervisionmonths_Invalid > 0 OR h.communitysupervisiondays_Invalid > 0 OR h.parolebegindate_Invalid > 0 OR h.paroleenddate_Invalid > 0 OR h.paroleeligibilitydate_Invalid > 0 OR h.parolehearingdate_Invalid > 0 OR h.parolemaxyears_Invalid > 0 OR h.parolemaxmonths_Invalid > 0 OR h.parolemaxdays_Invalid > 0 OR h.paroleminyears_Invalid > 0 OR h.paroleminmonths_Invalid > 0 OR h.parolemindays_Invalid > 0 OR h.probationbegindate_Invalid > 0 OR h.probationenddate_Invalid > 0 OR h.probationmaxyears_Invalid > 0 OR h.probationmaxmonths_Invalid > 0 OR h.probationmaxdays_Invalid > 0 OR h.probationminyears_Invalid > 0 OR h.probationminmonths_Invalid > 0 OR h.probationmindays_Invalid > 0 OR h.sourcename_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,vendor,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.recordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statecode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.caseid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sentencedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sentencebegindate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sentenceenddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sentencemaxyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sentencemaxmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sentencemaxdays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sentenceminyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sentenceminmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sentencemindays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.scheduledreleasedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.actualreleasedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.timeservedyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.timeservedmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.timeserveddays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicservicehours_ALLOW_ErrorCount > 0, 1, 0) + IF(le.communitysupervisionyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.communitysupervisionmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.communitysupervisiondays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parolebegindate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.paroleenddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.paroleeligibilitydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.parolehearingdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.parolemaxyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parolemaxmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parolemaxdays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.paroleminyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.paroleminmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parolemindays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationbegindate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.probationenddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.probationmaxyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationmaxmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationmaxdays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationminyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationminmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationmindays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sourcename_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.recordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statecode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.caseid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sentencedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sentencebegindate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sentenceenddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sentencemaxyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sentencemaxmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sentencemaxdays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sentenceminyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sentenceminmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sentencemindays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.scheduledreleasedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.actualreleasedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.timeservedyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.timeservedmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.timeserveddays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicservicehours_ALLOW_ErrorCount > 0, 1, 0) + IF(le.communitysupervisionyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.communitysupervisionmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.communitysupervisiondays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parolebegindate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.paroleenddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.paroleeligibilitydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.parolehearingdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.parolemaxyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parolemaxmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parolemaxdays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.paroleminyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.paroleminmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parolemindays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationbegindate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.probationenddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.probationmaxyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationmaxmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationmaxdays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationminyears_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationminmonths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.probationmindays_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sourcename_LENGTHS_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  le.vendor;
    UNSIGNED1 ErrNum := CHOOSE(c,le.recordid_Invalid,le.statecode_Invalid,le.caseid_Invalid,le.sentencedate_Invalid,le.sentencebegindate_Invalid,le.sentenceenddate_Invalid,le.sentencemaxyears_Invalid,le.sentencemaxmonths_Invalid,le.sentencemaxdays_Invalid,le.sentenceminyears_Invalid,le.sentenceminmonths_Invalid,le.sentencemindays_Invalid,le.scheduledreleasedate_Invalid,le.actualreleasedate_Invalid,le.timeservedyears_Invalid,le.timeservedmonths_Invalid,le.timeserveddays_Invalid,le.publicservicehours_Invalid,le.communitysupervisionyears_Invalid,le.communitysupervisionmonths_Invalid,le.communitysupervisiondays_Invalid,le.parolebegindate_Invalid,le.paroleenddate_Invalid,le.paroleeligibilitydate_Invalid,le.parolehearingdate_Invalid,le.parolemaxyears_Invalid,le.parolemaxmonths_Invalid,le.parolemaxdays_Invalid,le.paroleminyears_Invalid,le.paroleminmonths_Invalid,le.parolemindays_Invalid,le.probationbegindate_Invalid,le.probationenddate_Invalid,le.probationmaxyears_Invalid,le.probationmaxmonths_Invalid,le.probationmaxdays_Invalid,le.probationminyears_Invalid,le.probationminmonths_Invalid,le.probationmindays_Invalid,le.sourcename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,sentence_counties_Fields.InvalidMessage_recordid(le.recordid_Invalid),sentence_counties_Fields.InvalidMessage_statecode(le.statecode_Invalid),sentence_counties_Fields.InvalidMessage_caseid(le.caseid_Invalid),sentence_counties_Fields.InvalidMessage_sentencedate(le.sentencedate_Invalid),sentence_counties_Fields.InvalidMessage_sentencebegindate(le.sentencebegindate_Invalid),sentence_counties_Fields.InvalidMessage_sentenceenddate(le.sentenceenddate_Invalid),sentence_counties_Fields.InvalidMessage_sentencemaxyears(le.sentencemaxyears_Invalid),sentence_counties_Fields.InvalidMessage_sentencemaxmonths(le.sentencemaxmonths_Invalid),sentence_counties_Fields.InvalidMessage_sentencemaxdays(le.sentencemaxdays_Invalid),sentence_counties_Fields.InvalidMessage_sentenceminyears(le.sentenceminyears_Invalid),sentence_counties_Fields.InvalidMessage_sentenceminmonths(le.sentenceminmonths_Invalid),sentence_counties_Fields.InvalidMessage_sentencemindays(le.sentencemindays_Invalid),sentence_counties_Fields.InvalidMessage_scheduledreleasedate(le.scheduledreleasedate_Invalid),sentence_counties_Fields.InvalidMessage_actualreleasedate(le.actualreleasedate_Invalid),sentence_counties_Fields.InvalidMessage_timeservedyears(le.timeservedyears_Invalid),sentence_counties_Fields.InvalidMessage_timeservedmonths(le.timeservedmonths_Invalid),sentence_counties_Fields.InvalidMessage_timeserveddays(le.timeserveddays_Invalid),sentence_counties_Fields.InvalidMessage_publicservicehours(le.publicservicehours_Invalid),sentence_counties_Fields.InvalidMessage_communitysupervisionyears(le.communitysupervisionyears_Invalid),sentence_counties_Fields.InvalidMessage_communitysupervisionmonths(le.communitysupervisionmonths_Invalid),sentence_counties_Fields.InvalidMessage_communitysupervisiondays(le.communitysupervisiondays_Invalid),sentence_counties_Fields.InvalidMessage_parolebegindate(le.parolebegindate_Invalid),sentence_counties_Fields.InvalidMessage_paroleenddate(le.paroleenddate_Invalid),sentence_counties_Fields.InvalidMessage_paroleeligibilitydate(le.paroleeligibilitydate_Invalid),sentence_counties_Fields.InvalidMessage_parolehearingdate(le.parolehearingdate_Invalid),sentence_counties_Fields.InvalidMessage_parolemaxyears(le.parolemaxyears_Invalid),sentence_counties_Fields.InvalidMessage_parolemaxmonths(le.parolemaxmonths_Invalid),sentence_counties_Fields.InvalidMessage_parolemaxdays(le.parolemaxdays_Invalid),sentence_counties_Fields.InvalidMessage_paroleminyears(le.paroleminyears_Invalid),sentence_counties_Fields.InvalidMessage_paroleminmonths(le.paroleminmonths_Invalid),sentence_counties_Fields.InvalidMessage_parolemindays(le.parolemindays_Invalid),sentence_counties_Fields.InvalidMessage_probationbegindate(le.probationbegindate_Invalid),sentence_counties_Fields.InvalidMessage_probationenddate(le.probationenddate_Invalid),sentence_counties_Fields.InvalidMessage_probationmaxyears(le.probationmaxyears_Invalid),sentence_counties_Fields.InvalidMessage_probationmaxmonths(le.probationmaxmonths_Invalid),sentence_counties_Fields.InvalidMessage_probationmaxdays(le.probationmaxdays_Invalid),sentence_counties_Fields.InvalidMessage_probationminyears(le.probationminyears_Invalid),sentence_counties_Fields.InvalidMessage_probationminmonths(le.probationminmonths_Invalid),sentence_counties_Fields.InvalidMessage_probationmindays(le.probationmindays_Invalid),sentence_counties_Fields.InvalidMessage_sourcename(le.sourcename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.recordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.caseid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.sentencedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sentencebegindate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sentenceenddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sentencemaxyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sentencemaxmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sentencemaxdays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sentenceminyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sentenceminmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sentencemindays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.scheduledreleasedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.actualreleasedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.timeservedyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.timeservedmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.timeserveddays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.publicservicehours_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.communitysupervisionyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.communitysupervisionmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.communitysupervisiondays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.parolebegindate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.paroleenddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.paroleeligibilitydate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.parolehearingdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.parolemaxyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.parolemaxmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.parolemaxdays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.paroleminyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.paroleminmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.parolemindays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.probationbegindate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.probationenddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.probationmaxyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.probationmaxmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.probationmaxdays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.probationminyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.probationminmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.probationmindays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sourcename_Invalid,'LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'recordid','statecode','caseid','sentencedate','sentencebegindate','sentenceenddate','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','timeservedyears','timeservedmonths','timeserveddays','publicservicehours','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','parolebegindate','paroleenddate','paroleeligibilitydate','parolehearingdate','parolemaxyears','parolemaxmonths','parolemaxdays','paroleminyears','paroleminmonths','parolemindays','probationbegindate','probationenddate','probationmaxyears','probationmaxmonths','probationmaxdays','probationminyears','probationminmonths','probationmindays','sourcename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Record_ID','Invalid_Char','Non_Blank','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Future_Date','Invalid_Future_Date','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Num','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Future_Date','Invalid_Future_Date','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Time','Invalid_Time','Non_Blank','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.recordid,(SALT311.StrType)le.statecode,(SALT311.StrType)le.caseid,(SALT311.StrType)le.sentencedate,(SALT311.StrType)le.sentencebegindate,(SALT311.StrType)le.sentenceenddate,(SALT311.StrType)le.sentencemaxyears,(SALT311.StrType)le.sentencemaxmonths,(SALT311.StrType)le.sentencemaxdays,(SALT311.StrType)le.sentenceminyears,(SALT311.StrType)le.sentenceminmonths,(SALT311.StrType)le.sentencemindays,(SALT311.StrType)le.scheduledreleasedate,(SALT311.StrType)le.actualreleasedate,(SALT311.StrType)le.timeservedyears,(SALT311.StrType)le.timeservedmonths,(SALT311.StrType)le.timeserveddays,(SALT311.StrType)le.publicservicehours,(SALT311.StrType)le.communitysupervisionyears,(SALT311.StrType)le.communitysupervisionmonths,(SALT311.StrType)le.communitysupervisiondays,(SALT311.StrType)le.parolebegindate,(SALT311.StrType)le.paroleenddate,(SALT311.StrType)le.paroleeligibilitydate,(SALT311.StrType)le.parolehearingdate,(SALT311.StrType)le.parolemaxyears,(SALT311.StrType)le.parolemaxmonths,(SALT311.StrType)le.parolemaxdays,(SALT311.StrType)le.paroleminyears,(SALT311.StrType)le.paroleminmonths,(SALT311.StrType)le.parolemindays,(SALT311.StrType)le.probationbegindate,(SALT311.StrType)le.probationenddate,(SALT311.StrType)le.probationmaxyears,(SALT311.StrType)le.probationmaxmonths,(SALT311.StrType)le.probationmaxdays,(SALT311.StrType)le.probationminyears,(SALT311.StrType)le.probationminmonths,(SALT311.StrType)le.probationmindays,(SALT311.StrType)le.sourcename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,40,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(sentence_counties_Layout_crim) prevDS = DATASET([], sentence_counties_Layout_crim)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_LENGTHS_ErrorCount
          ,le.sentencedate_CUSTOM_ErrorCount
          ,le.sentencebegindate_CUSTOM_ErrorCount
          ,le.sentenceenddate_CUSTOM_ErrorCount
          ,le.sentencemaxyears_ALLOW_ErrorCount
          ,le.sentencemaxmonths_ALLOW_ErrorCount
          ,le.sentencemaxdays_ALLOW_ErrorCount
          ,le.sentenceminyears_ALLOW_ErrorCount
          ,le.sentenceminmonths_ALLOW_ErrorCount
          ,le.sentencemindays_ALLOW_ErrorCount
          ,le.scheduledreleasedate_CUSTOM_ErrorCount
          ,le.actualreleasedate_CUSTOM_ErrorCount
          ,le.timeservedyears_ALLOW_ErrorCount
          ,le.timeservedmonths_ALLOW_ErrorCount
          ,le.timeserveddays_ALLOW_ErrorCount
          ,le.publicservicehours_ALLOW_ErrorCount
          ,le.communitysupervisionyears_ALLOW_ErrorCount
          ,le.communitysupervisionmonths_ALLOW_ErrorCount
          ,le.communitysupervisiondays_ALLOW_ErrorCount
          ,le.parolebegindate_CUSTOM_ErrorCount
          ,le.paroleenddate_CUSTOM_ErrorCount
          ,le.paroleeligibilitydate_CUSTOM_ErrorCount
          ,le.parolehearingdate_CUSTOM_ErrorCount
          ,le.parolemaxyears_ALLOW_ErrorCount
          ,le.parolemaxmonths_ALLOW_ErrorCount
          ,le.parolemaxdays_ALLOW_ErrorCount
          ,le.paroleminyears_ALLOW_ErrorCount
          ,le.paroleminmonths_ALLOW_ErrorCount
          ,le.parolemindays_ALLOW_ErrorCount
          ,le.probationbegindate_CUSTOM_ErrorCount
          ,le.probationenddate_CUSTOM_ErrorCount
          ,le.probationmaxyears_ALLOW_ErrorCount
          ,le.probationmaxmonths_ALLOW_ErrorCount
          ,le.probationmaxdays_ALLOW_ErrorCount
          ,le.probationminyears_ALLOW_ErrorCount
          ,le.probationminmonths_ALLOW_ErrorCount
          ,le.probationmindays_ALLOW_ErrorCount
          ,le.sourcename_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_LENGTHS_ErrorCount
          ,le.sentencedate_CUSTOM_ErrorCount
          ,le.sentencebegindate_CUSTOM_ErrorCount
          ,le.sentenceenddate_CUSTOM_ErrorCount
          ,le.sentencemaxyears_ALLOW_ErrorCount
          ,le.sentencemaxmonths_ALLOW_ErrorCount
          ,le.sentencemaxdays_ALLOW_ErrorCount
          ,le.sentenceminyears_ALLOW_ErrorCount
          ,le.sentenceminmonths_ALLOW_ErrorCount
          ,le.sentencemindays_ALLOW_ErrorCount
          ,le.scheduledreleasedate_CUSTOM_ErrorCount
          ,le.actualreleasedate_CUSTOM_ErrorCount
          ,le.timeservedyears_ALLOW_ErrorCount
          ,le.timeservedmonths_ALLOW_ErrorCount
          ,le.timeserveddays_ALLOW_ErrorCount
          ,le.publicservicehours_ALLOW_ErrorCount
          ,le.communitysupervisionyears_ALLOW_ErrorCount
          ,le.communitysupervisionmonths_ALLOW_ErrorCount
          ,le.communitysupervisiondays_ALLOW_ErrorCount
          ,le.parolebegindate_CUSTOM_ErrorCount
          ,le.paroleenddate_CUSTOM_ErrorCount
          ,le.paroleeligibilitydate_CUSTOM_ErrorCount
          ,le.parolehearingdate_CUSTOM_ErrorCount
          ,le.parolemaxyears_ALLOW_ErrorCount
          ,le.parolemaxmonths_ALLOW_ErrorCount
          ,le.parolemaxdays_ALLOW_ErrorCount
          ,le.paroleminyears_ALLOW_ErrorCount
          ,le.paroleminmonths_ALLOW_ErrorCount
          ,le.parolemindays_ALLOW_ErrorCount
          ,le.probationbegindate_CUSTOM_ErrorCount
          ,le.probationenddate_CUSTOM_ErrorCount
          ,le.probationmaxyears_ALLOW_ErrorCount
          ,le.probationmaxmonths_ALLOW_ErrorCount
          ,le.probationmaxdays_ALLOW_ErrorCount
          ,le.probationminyears_ALLOW_ErrorCount
          ,le.probationminmonths_ALLOW_ErrorCount
          ,le.probationmindays_ALLOW_ErrorCount
          ,le.sourcename_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := sentence_counties_hygiene(PROJECT(h, sentence_counties_Layout_crim));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'recordid:' + getFieldTypeText(h.recordid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statecode:' + getFieldTypeText(h.statecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'caseid:' + getFieldTypeText(h.caseid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencedate:' + getFieldTypeText(h.sentencedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencebegindate:' + getFieldTypeText(h.sentencebegindate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentenceenddate:' + getFieldTypeText(h.sentenceenddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencetype:' + getFieldTypeText(h.sentencetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencemaxyears:' + getFieldTypeText(h.sentencemaxyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencemaxmonths:' + getFieldTypeText(h.sentencemaxmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencemaxdays:' + getFieldTypeText(h.sentencemaxdays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentenceminyears:' + getFieldTypeText(h.sentenceminyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentenceminmonths:' + getFieldTypeText(h.sentenceminmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencemindays:' + getFieldTypeText(h.sentencemindays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'scheduledreleasedate:' + getFieldTypeText(h.scheduledreleasedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'actualreleasedate:' + getFieldTypeText(h.actualreleasedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencestatus:' + getFieldTypeText(h.sentencestatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timeservedyears:' + getFieldTypeText(h.timeservedyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timeservedmonths:' + getFieldTypeText(h.timeservedmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timeserveddays:' + getFieldTypeText(h.timeserveddays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicservicehours:' + getFieldTypeText(h.publicservicehours) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentenceadditionalinfo:' + getFieldTypeText(h.sentenceadditionalinfo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'communitysupervisioncounty:' + getFieldTypeText(h.communitysupervisioncounty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'communitysupervisionyears:' + getFieldTypeText(h.communitysupervisionyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'communitysupervisionmonths:' + getFieldTypeText(h.communitysupervisionmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'communitysupervisiondays:' + getFieldTypeText(h.communitysupervisiondays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolebegindate:' + getFieldTypeText(h.parolebegindate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleenddate:' + getFieldTypeText(h.paroleenddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleeligibilitydate:' + getFieldTypeText(h.paroleeligibilitydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolehearingdate:' + getFieldTypeText(h.parolehearingdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolemaxyears:' + getFieldTypeText(h.parolemaxyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolemaxmonths:' + getFieldTypeText(h.parolemaxmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolemaxdays:' + getFieldTypeText(h.parolemaxdays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleminyears:' + getFieldTypeText(h.paroleminyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleminmonths:' + getFieldTypeText(h.paroleminmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolemindays:' + getFieldTypeText(h.parolemindays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolestatus:' + getFieldTypeText(h.parolestatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleofficer:' + getFieldTypeText(h.paroleofficer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleoffcerphone:' + getFieldTypeText(h.paroleoffcerphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationbegindate:' + getFieldTypeText(h.probationbegindate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationenddate:' + getFieldTypeText(h.probationenddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationmaxyears:' + getFieldTypeText(h.probationmaxyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationmaxmonths:' + getFieldTypeText(h.probationmaxmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationmaxdays:' + getFieldTypeText(h.probationmaxdays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationminyears:' + getFieldTypeText(h.probationminyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationminmonths:' + getFieldTypeText(h.probationminmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationmindays:' + getFieldTypeText(h.probationmindays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationstatus:' + getFieldTypeText(h.probationstatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sourcename:' + getFieldTypeText(h.sourcename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor:' + getFieldTypeText(h.vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_recordid_cnt
          ,le.populated_statecode_cnt
          ,le.populated_caseid_cnt
          ,le.populated_sentencedate_cnt
          ,le.populated_sentencebegindate_cnt
          ,le.populated_sentenceenddate_cnt
          ,le.populated_sentencetype_cnt
          ,le.populated_sentencemaxyears_cnt
          ,le.populated_sentencemaxmonths_cnt
          ,le.populated_sentencemaxdays_cnt
          ,le.populated_sentenceminyears_cnt
          ,le.populated_sentenceminmonths_cnt
          ,le.populated_sentencemindays_cnt
          ,le.populated_scheduledreleasedate_cnt
          ,le.populated_actualreleasedate_cnt
          ,le.populated_sentencestatus_cnt
          ,le.populated_timeservedyears_cnt
          ,le.populated_timeservedmonths_cnt
          ,le.populated_timeserveddays_cnt
          ,le.populated_publicservicehours_cnt
          ,le.populated_sentenceadditionalinfo_cnt
          ,le.populated_communitysupervisioncounty_cnt
          ,le.populated_communitysupervisionyears_cnt
          ,le.populated_communitysupervisionmonths_cnt
          ,le.populated_communitysupervisiondays_cnt
          ,le.populated_parolebegindate_cnt
          ,le.populated_paroleenddate_cnt
          ,le.populated_paroleeligibilitydate_cnt
          ,le.populated_parolehearingdate_cnt
          ,le.populated_parolemaxyears_cnt
          ,le.populated_parolemaxmonths_cnt
          ,le.populated_parolemaxdays_cnt
          ,le.populated_paroleminyears_cnt
          ,le.populated_paroleminmonths_cnt
          ,le.populated_parolemindays_cnt
          ,le.populated_parolestatus_cnt
          ,le.populated_paroleofficer_cnt
          ,le.populated_paroleoffcerphone_cnt
          ,le.populated_probationbegindate_cnt
          ,le.populated_probationenddate_cnt
          ,le.populated_probationmaxyears_cnt
          ,le.populated_probationmaxmonths_cnt
          ,le.populated_probationmaxdays_cnt
          ,le.populated_probationminyears_cnt
          ,le.populated_probationminmonths_cnt
          ,le.populated_probationmindays_cnt
          ,le.populated_probationstatus_cnt
          ,le.populated_sourcename_cnt
          ,le.populated_vendor_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_recordid_pcnt
          ,le.populated_statecode_pcnt
          ,le.populated_caseid_pcnt
          ,le.populated_sentencedate_pcnt
          ,le.populated_sentencebegindate_pcnt
          ,le.populated_sentenceenddate_pcnt
          ,le.populated_sentencetype_pcnt
          ,le.populated_sentencemaxyears_pcnt
          ,le.populated_sentencemaxmonths_pcnt
          ,le.populated_sentencemaxdays_pcnt
          ,le.populated_sentenceminyears_pcnt
          ,le.populated_sentenceminmonths_pcnt
          ,le.populated_sentencemindays_pcnt
          ,le.populated_scheduledreleasedate_pcnt
          ,le.populated_actualreleasedate_pcnt
          ,le.populated_sentencestatus_pcnt
          ,le.populated_timeservedyears_pcnt
          ,le.populated_timeservedmonths_pcnt
          ,le.populated_timeserveddays_pcnt
          ,le.populated_publicservicehours_pcnt
          ,le.populated_sentenceadditionalinfo_pcnt
          ,le.populated_communitysupervisioncounty_pcnt
          ,le.populated_communitysupervisionyears_pcnt
          ,le.populated_communitysupervisionmonths_pcnt
          ,le.populated_communitysupervisiondays_pcnt
          ,le.populated_parolebegindate_pcnt
          ,le.populated_paroleenddate_pcnt
          ,le.populated_paroleeligibilitydate_pcnt
          ,le.populated_parolehearingdate_pcnt
          ,le.populated_parolemaxyears_pcnt
          ,le.populated_parolemaxmonths_pcnt
          ,le.populated_parolemaxdays_pcnt
          ,le.populated_paroleminyears_pcnt
          ,le.populated_paroleminmonths_pcnt
          ,le.populated_parolemindays_pcnt
          ,le.populated_parolestatus_pcnt
          ,le.populated_paroleofficer_pcnt
          ,le.populated_paroleoffcerphone_pcnt
          ,le.populated_probationbegindate_pcnt
          ,le.populated_probationenddate_pcnt
          ,le.populated_probationmaxyears_pcnt
          ,le.populated_probationmaxmonths_pcnt
          ,le.populated_probationmaxdays_pcnt
          ,le.populated_probationminyears_pcnt
          ,le.populated_probationminmonths_pcnt
          ,le.populated_probationmindays_pcnt
          ,le.populated_probationstatus_pcnt
          ,le.populated_sourcename_pcnt
          ,le.populated_vendor_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,49,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := sentence_counties_Delta(prevDS, PROJECT(h, sentence_counties_Layout_crim));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),49,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(sentence_counties_Layout_crim) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Crim, sentence_counties_Fields, 'RECORDOF(scrubsSummaryOverall)', 'vendor');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, vendor, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
