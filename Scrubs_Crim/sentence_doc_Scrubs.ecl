IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT sentence_doc_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(sentence_doc_Layout_crim)
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
  EXPORT  Bitmap_Layout := RECORD(sentence_doc_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(sentence_doc_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.recordid_Invalid := sentence_doc_Fields.InValid_recordid((SALT33.StrType)le.recordid);
    SELF.statecode_Invalid := sentence_doc_Fields.InValid_statecode((SALT33.StrType)le.statecode);
    SELF.caseid_Invalid := sentence_doc_Fields.InValid_caseid((SALT33.StrType)le.caseid);
    SELF.sentencedate_Invalid := sentence_doc_Fields.InValid_sentencedate((SALT33.StrType)le.sentencedate);
    SELF.sentencebegindate_Invalid := sentence_doc_Fields.InValid_sentencebegindate((SALT33.StrType)le.sentencebegindate);
    SELF.sentenceenddate_Invalid := sentence_doc_Fields.InValid_sentenceenddate((SALT33.StrType)le.sentenceenddate);
    SELF.sentencemaxyears_Invalid := sentence_doc_Fields.InValid_sentencemaxyears((SALT33.StrType)le.sentencemaxyears);
    SELF.sentencemaxmonths_Invalid := sentence_doc_Fields.InValid_sentencemaxmonths((SALT33.StrType)le.sentencemaxmonths);
    SELF.sentencemaxdays_Invalid := sentence_doc_Fields.InValid_sentencemaxdays((SALT33.StrType)le.sentencemaxdays);
    SELF.sentenceminyears_Invalid := sentence_doc_Fields.InValid_sentenceminyears((SALT33.StrType)le.sentenceminyears);
    SELF.sentenceminmonths_Invalid := sentence_doc_Fields.InValid_sentenceminmonths((SALT33.StrType)le.sentenceminmonths);
    SELF.sentencemindays_Invalid := sentence_doc_Fields.InValid_sentencemindays((SALT33.StrType)le.sentencemindays);
    SELF.scheduledreleasedate_Invalid := sentence_doc_Fields.InValid_scheduledreleasedate((SALT33.StrType)le.scheduledreleasedate);
    SELF.actualreleasedate_Invalid := sentence_doc_Fields.InValid_actualreleasedate((SALT33.StrType)le.actualreleasedate);
    SELF.timeservedyears_Invalid := sentence_doc_Fields.InValid_timeservedyears((SALT33.StrType)le.timeservedyears);
    SELF.timeservedmonths_Invalid := sentence_doc_Fields.InValid_timeservedmonths((SALT33.StrType)le.timeservedmonths);
    SELF.timeserveddays_Invalid := sentence_doc_Fields.InValid_timeserveddays((SALT33.StrType)le.timeserveddays);
    SELF.publicservicehours_Invalid := sentence_doc_Fields.InValid_publicservicehours((SALT33.StrType)le.publicservicehours);
    SELF.communitysupervisionyears_Invalid := sentence_doc_Fields.InValid_communitysupervisionyears((SALT33.StrType)le.communitysupervisionyears);
    SELF.communitysupervisionmonths_Invalid := sentence_doc_Fields.InValid_communitysupervisionmonths((SALT33.StrType)le.communitysupervisionmonths);
    SELF.communitysupervisiondays_Invalid := sentence_doc_Fields.InValid_communitysupervisiondays((SALT33.StrType)le.communitysupervisiondays);
    SELF.parolebegindate_Invalid := sentence_doc_Fields.InValid_parolebegindate((SALT33.StrType)le.parolebegindate);
    SELF.paroleenddate_Invalid := sentence_doc_Fields.InValid_paroleenddate((SALT33.StrType)le.paroleenddate);
    SELF.paroleeligibilitydate_Invalid := sentence_doc_Fields.InValid_paroleeligibilitydate((SALT33.StrType)le.paroleeligibilitydate);
    SELF.parolehearingdate_Invalid := sentence_doc_Fields.InValid_parolehearingdate((SALT33.StrType)le.parolehearingdate);
    SELF.parolemaxyears_Invalid := sentence_doc_Fields.InValid_parolemaxyears((SALT33.StrType)le.parolemaxyears);
    SELF.parolemaxmonths_Invalid := sentence_doc_Fields.InValid_parolemaxmonths((SALT33.StrType)le.parolemaxmonths);
    SELF.parolemaxdays_Invalid := sentence_doc_Fields.InValid_parolemaxdays((SALT33.StrType)le.parolemaxdays);
    SELF.paroleminyears_Invalid := sentence_doc_Fields.InValid_paroleminyears((SALT33.StrType)le.paroleminyears);
    SELF.paroleminmonths_Invalid := sentence_doc_Fields.InValid_paroleminmonths((SALT33.StrType)le.paroleminmonths);
    SELF.parolemindays_Invalid := sentence_doc_Fields.InValid_parolemindays((SALT33.StrType)le.parolemindays);
    SELF.probationbegindate_Invalid := sentence_doc_Fields.InValid_probationbegindate((SALT33.StrType)le.probationbegindate);
    SELF.probationenddate_Invalid := sentence_doc_Fields.InValid_probationenddate((SALT33.StrType)le.probationenddate);
    SELF.probationmaxyears_Invalid := sentence_doc_Fields.InValid_probationmaxyears((SALT33.StrType)le.probationmaxyears);
    SELF.probationmaxmonths_Invalid := sentence_doc_Fields.InValid_probationmaxmonths((SALT33.StrType)le.probationmaxmonths);
    SELF.probationmaxdays_Invalid := sentence_doc_Fields.InValid_probationmaxdays((SALT33.StrType)le.probationmaxdays);
    SELF.probationminyears_Invalid := sentence_doc_Fields.InValid_probationminyears((SALT33.StrType)le.probationminyears);
    SELF.probationminmonths_Invalid := sentence_doc_Fields.InValid_probationminmonths((SALT33.StrType)le.probationminmonths);
    SELF.probationmindays_Invalid := sentence_doc_Fields.InValid_probationmindays((SALT33.StrType)le.probationmindays);
    SELF.sourcename_Invalid := sentence_doc_Fields.InValid_sourcename((SALT33.StrType)le.sourcename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),sentence_doc_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.recordid_Invalid << 0 ) + ( le.statecode_Invalid << 1 ) + ( le.caseid_Invalid << 2 ) + ( le.sentencedate_Invalid << 3 ) + ( le.sentencebegindate_Invalid << 4 ) + ( le.sentenceenddate_Invalid << 5 ) + ( le.sentencemaxyears_Invalid << 6 ) + ( le.sentencemaxmonths_Invalid << 7 ) + ( le.sentencemaxdays_Invalid << 8 ) + ( le.sentenceminyears_Invalid << 9 ) + ( le.sentenceminmonths_Invalid << 10 ) + ( le.sentencemindays_Invalid << 11 ) + ( le.scheduledreleasedate_Invalid << 12 ) + ( le.actualreleasedate_Invalid << 13 ) + ( le.timeservedyears_Invalid << 14 ) + ( le.timeservedmonths_Invalid << 15 ) + ( le.timeserveddays_Invalid << 16 ) + ( le.publicservicehours_Invalid << 17 ) + ( le.communitysupervisionyears_Invalid << 18 ) + ( le.communitysupervisionmonths_Invalid << 19 ) + ( le.communitysupervisiondays_Invalid << 20 ) + ( le.parolebegindate_Invalid << 21 ) + ( le.paroleenddate_Invalid << 22 ) + ( le.paroleeligibilitydate_Invalid << 23 ) + ( le.parolehearingdate_Invalid << 24 ) + ( le.parolemaxyears_Invalid << 25 ) + ( le.parolemaxmonths_Invalid << 26 ) + ( le.parolemaxdays_Invalid << 27 ) + ( le.paroleminyears_Invalid << 28 ) + ( le.paroleminmonths_Invalid << 29 ) + ( le.parolemindays_Invalid << 30 ) + ( le.probationbegindate_Invalid << 31 ) + ( le.probationenddate_Invalid << 32 ) + ( le.probationmaxyears_Invalid << 33 ) + ( le.probationmaxmonths_Invalid << 34 ) + ( le.probationmaxdays_Invalid << 35 ) + ( le.probationminyears_Invalid << 36 ) + ( le.probationminmonths_Invalid << 37 ) + ( le.probationmindays_Invalid << 38 ) + ( le.sourcename_Invalid << 39 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,sentence_doc_Layout_crim);
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
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.vendor;
    TotalCnt := COUNT(GROUP); // Number of records in total
    recordid_ALLOW_ErrorCount := COUNT(GROUP,h.recordid_Invalid=1);
    statecode_ALLOW_ErrorCount := COUNT(GROUP,h.statecode_Invalid=1);
    caseid_LENGTH_ErrorCount := COUNT(GROUP,h.caseid_Invalid=1);
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
    sourcename_LENGTH_ErrorCount := COUNT(GROUP,h.sourcename_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,vendor,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.vendor;
    UNSIGNED1 ErrNum := CHOOSE(c,le.recordid_Invalid,le.statecode_Invalid,le.caseid_Invalid,le.sentencedate_Invalid,le.sentencebegindate_Invalid,le.sentenceenddate_Invalid,le.sentencemaxyears_Invalid,le.sentencemaxmonths_Invalid,le.sentencemaxdays_Invalid,le.sentenceminyears_Invalid,le.sentenceminmonths_Invalid,le.sentencemindays_Invalid,le.scheduledreleasedate_Invalid,le.actualreleasedate_Invalid,le.timeservedyears_Invalid,le.timeservedmonths_Invalid,le.timeserveddays_Invalid,le.publicservicehours_Invalid,le.communitysupervisionyears_Invalid,le.communitysupervisionmonths_Invalid,le.communitysupervisiondays_Invalid,le.parolebegindate_Invalid,le.paroleenddate_Invalid,le.paroleeligibilitydate_Invalid,le.parolehearingdate_Invalid,le.parolemaxyears_Invalid,le.parolemaxmonths_Invalid,le.parolemaxdays_Invalid,le.paroleminyears_Invalid,le.paroleminmonths_Invalid,le.parolemindays_Invalid,le.probationbegindate_Invalid,le.probationenddate_Invalid,le.probationmaxyears_Invalid,le.probationmaxmonths_Invalid,le.probationmaxdays_Invalid,le.probationminyears_Invalid,le.probationminmonths_Invalid,le.probationmindays_Invalid,le.sourcename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,sentence_doc_Fields.InvalidMessage_recordid(le.recordid_Invalid),sentence_doc_Fields.InvalidMessage_statecode(le.statecode_Invalid),sentence_doc_Fields.InvalidMessage_caseid(le.caseid_Invalid),sentence_doc_Fields.InvalidMessage_sentencedate(le.sentencedate_Invalid),sentence_doc_Fields.InvalidMessage_sentencebegindate(le.sentencebegindate_Invalid),sentence_doc_Fields.InvalidMessage_sentenceenddate(le.sentenceenddate_Invalid),sentence_doc_Fields.InvalidMessage_sentencemaxyears(le.sentencemaxyears_Invalid),sentence_doc_Fields.InvalidMessage_sentencemaxmonths(le.sentencemaxmonths_Invalid),sentence_doc_Fields.InvalidMessage_sentencemaxdays(le.sentencemaxdays_Invalid),sentence_doc_Fields.InvalidMessage_sentenceminyears(le.sentenceminyears_Invalid),sentence_doc_Fields.InvalidMessage_sentenceminmonths(le.sentenceminmonths_Invalid),sentence_doc_Fields.InvalidMessage_sentencemindays(le.sentencemindays_Invalid),sentence_doc_Fields.InvalidMessage_scheduledreleasedate(le.scheduledreleasedate_Invalid),sentence_doc_Fields.InvalidMessage_actualreleasedate(le.actualreleasedate_Invalid),sentence_doc_Fields.InvalidMessage_timeservedyears(le.timeservedyears_Invalid),sentence_doc_Fields.InvalidMessage_timeservedmonths(le.timeservedmonths_Invalid),sentence_doc_Fields.InvalidMessage_timeserveddays(le.timeserveddays_Invalid),sentence_doc_Fields.InvalidMessage_publicservicehours(le.publicservicehours_Invalid),sentence_doc_Fields.InvalidMessage_communitysupervisionyears(le.communitysupervisionyears_Invalid),sentence_doc_Fields.InvalidMessage_communitysupervisionmonths(le.communitysupervisionmonths_Invalid),sentence_doc_Fields.InvalidMessage_communitysupervisiondays(le.communitysupervisiondays_Invalid),sentence_doc_Fields.InvalidMessage_parolebegindate(le.parolebegindate_Invalid),sentence_doc_Fields.InvalidMessage_paroleenddate(le.paroleenddate_Invalid),sentence_doc_Fields.InvalidMessage_paroleeligibilitydate(le.paroleeligibilitydate_Invalid),sentence_doc_Fields.InvalidMessage_parolehearingdate(le.parolehearingdate_Invalid),sentence_doc_Fields.InvalidMessage_parolemaxyears(le.parolemaxyears_Invalid),sentence_doc_Fields.InvalidMessage_parolemaxmonths(le.parolemaxmonths_Invalid),sentence_doc_Fields.InvalidMessage_parolemaxdays(le.parolemaxdays_Invalid),sentence_doc_Fields.InvalidMessage_paroleminyears(le.paroleminyears_Invalid),sentence_doc_Fields.InvalidMessage_paroleminmonths(le.paroleminmonths_Invalid),sentence_doc_Fields.InvalidMessage_parolemindays(le.parolemindays_Invalid),sentence_doc_Fields.InvalidMessage_probationbegindate(le.probationbegindate_Invalid),sentence_doc_Fields.InvalidMessage_probationenddate(le.probationenddate_Invalid),sentence_doc_Fields.InvalidMessage_probationmaxyears(le.probationmaxyears_Invalid),sentence_doc_Fields.InvalidMessage_probationmaxmonths(le.probationmaxmonths_Invalid),sentence_doc_Fields.InvalidMessage_probationmaxdays(le.probationmaxdays_Invalid),sentence_doc_Fields.InvalidMessage_probationminyears(le.probationminyears_Invalid),sentence_doc_Fields.InvalidMessage_probationminmonths(le.probationminmonths_Invalid),sentence_doc_Fields.InvalidMessage_probationmindays(le.probationmindays_Invalid),sentence_doc_Fields.InvalidMessage_sourcename(le.sourcename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.recordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.caseid_Invalid,'LENGTH','UNKNOWN')
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
          ,CHOOSE(le.sourcename_Invalid,'LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'recordid','statecode','caseid','sentencedate','sentencebegindate','sentenceenddate','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','timeservedyears','timeservedmonths','timeserveddays','publicservicehours','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','parolebegindate','paroleenddate','paroleeligibilitydate','parolehearingdate','parolemaxyears','parolemaxmonths','parolemaxdays','paroleminyears','paroleminmonths','parolemindays','probationbegindate','probationenddate','probationmaxyears','probationmaxmonths','probationmaxdays','probationminyears','probationminmonths','probationmindays','sourcename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Record_ID','Invalid_Char','Non_Blank','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Future_Date','Invalid_Future_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Future_Date','Invalid_Future_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Non_Blank','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.recordid,(SALT33.StrType)le.statecode,(SALT33.StrType)le.caseid,(SALT33.StrType)le.sentencedate,(SALT33.StrType)le.sentencebegindate,(SALT33.StrType)le.sentenceenddate,(SALT33.StrType)le.sentencemaxyears,(SALT33.StrType)le.sentencemaxmonths,(SALT33.StrType)le.sentencemaxdays,(SALT33.StrType)le.sentenceminyears,(SALT33.StrType)le.sentenceminmonths,(SALT33.StrType)le.sentencemindays,(SALT33.StrType)le.scheduledreleasedate,(SALT33.StrType)le.actualreleasedate,(SALT33.StrType)le.timeservedyears,(SALT33.StrType)le.timeservedmonths,(SALT33.StrType)le.timeserveddays,(SALT33.StrType)le.publicservicehours,(SALT33.StrType)le.communitysupervisionyears,(SALT33.StrType)le.communitysupervisionmonths,(SALT33.StrType)le.communitysupervisiondays,(SALT33.StrType)le.parolebegindate,(SALT33.StrType)le.paroleenddate,(SALT33.StrType)le.paroleeligibilitydate,(SALT33.StrType)le.parolehearingdate,(SALT33.StrType)le.parolemaxyears,(SALT33.StrType)le.parolemaxmonths,(SALT33.StrType)le.parolemaxdays,(SALT33.StrType)le.paroleminyears,(SALT33.StrType)le.paroleminmonths,(SALT33.StrType)le.parolemindays,(SALT33.StrType)le.probationbegindate,(SALT33.StrType)le.probationenddate,(SALT33.StrType)le.probationmaxyears,(SALT33.StrType)le.probationmaxmonths,(SALT33.StrType)le.probationmaxdays,(SALT33.StrType)le.probationminyears,(SALT33.StrType)le.probationminmonths,(SALT33.StrType)le.probationmindays,(SALT33.StrType)le.sourcename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,40,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor;
      SELF.ruledesc := CHOOSE(c
          ,'recordid:Invalid_Record_ID:ALLOW'
          ,'statecode:Invalid_Char:ALLOW'
          ,'caseid:Non_Blank:LENGTH'
          ,'sentencedate:Invalid_Future_Date:CUSTOM'
          ,'sentencebegindate:Invalid_Future_Date:CUSTOM'
          ,'sentenceenddate:Invalid_Future_Date:CUSTOM'
          ,'sentencemaxyears:Invalid_Num:ALLOW'
          ,'sentencemaxmonths:Invalid_Num:ALLOW'
          ,'sentencemaxdays:Invalid_Num:ALLOW'
          ,'sentenceminyears:Invalid_Num:ALLOW'
          ,'sentenceminmonths:Invalid_Num:ALLOW'
          ,'sentencemindays:Invalid_Num:ALLOW'
          ,'scheduledreleasedate:Invalid_Future_Date:CUSTOM'
          ,'actualreleasedate:Invalid_Future_Date:CUSTOM'
          ,'timeservedyears:Invalid_Num:ALLOW'
          ,'timeservedmonths:Invalid_Num:ALLOW'
          ,'timeserveddays:Invalid_Num:ALLOW'
          ,'publicservicehours:Invalid_Num:ALLOW'
          ,'communitysupervisionyears:Invalid_Num:ALLOW'
          ,'communitysupervisionmonths:Invalid_Num:ALLOW'
          ,'communitysupervisiondays:Invalid_Num:ALLOW'
          ,'parolebegindate:Invalid_Future_Date:CUSTOM'
          ,'paroleenddate:Invalid_Future_Date:CUSTOM'
          ,'paroleeligibilitydate:Invalid_Future_Date:CUSTOM'
          ,'parolehearingdate:Invalid_Future_Date:CUSTOM'
          ,'parolemaxyears:Invalid_Num:ALLOW'
          ,'parolemaxmonths:Invalid_Num:ALLOW'
          ,'parolemaxdays:Invalid_Num:ALLOW'
          ,'paroleminyears:Invalid_Num:ALLOW'
          ,'paroleminmonths:Invalid_Num:ALLOW'
          ,'parolemindays:Invalid_Num:ALLOW'
          ,'probationbegindate:Invalid_Future_Date:CUSTOM'
          ,'probationenddate:Invalid_Future_Date:CUSTOM'
          ,'probationmaxyears:Invalid_Num:ALLOW'
          ,'probationmaxmonths:Invalid_Num:ALLOW'
          ,'probationmaxdays:Invalid_Num:ALLOW'
          ,'probationminyears:Invalid_Num:ALLOW'
          ,'probationminmonths:Invalid_Num:ALLOW'
          ,'probationmindays:Invalid_Num:ALLOW'
          ,'sourcename:Non_Blank:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,sentence_doc_Fields.InvalidMessage_recordid(1)
          ,sentence_doc_Fields.InvalidMessage_statecode(1)
          ,sentence_doc_Fields.InvalidMessage_caseid(1)
          ,sentence_doc_Fields.InvalidMessage_sentencedate(1)
          ,sentence_doc_Fields.InvalidMessage_sentencebegindate(1)
          ,sentence_doc_Fields.InvalidMessage_sentenceenddate(1)
          ,sentence_doc_Fields.InvalidMessage_sentencemaxyears(1)
          ,sentence_doc_Fields.InvalidMessage_sentencemaxmonths(1)
          ,sentence_doc_Fields.InvalidMessage_sentencemaxdays(1)
          ,sentence_doc_Fields.InvalidMessage_sentenceminyears(1)
          ,sentence_doc_Fields.InvalidMessage_sentenceminmonths(1)
          ,sentence_doc_Fields.InvalidMessage_sentencemindays(1)
          ,sentence_doc_Fields.InvalidMessage_scheduledreleasedate(1)
          ,sentence_doc_Fields.InvalidMessage_actualreleasedate(1)
          ,sentence_doc_Fields.InvalidMessage_timeservedyears(1)
          ,sentence_doc_Fields.InvalidMessage_timeservedmonths(1)
          ,sentence_doc_Fields.InvalidMessage_timeserveddays(1)
          ,sentence_doc_Fields.InvalidMessage_publicservicehours(1)
          ,sentence_doc_Fields.InvalidMessage_communitysupervisionyears(1)
          ,sentence_doc_Fields.InvalidMessage_communitysupervisionmonths(1)
          ,sentence_doc_Fields.InvalidMessage_communitysupervisiondays(1)
          ,sentence_doc_Fields.InvalidMessage_parolebegindate(1)
          ,sentence_doc_Fields.InvalidMessage_paroleenddate(1)
          ,sentence_doc_Fields.InvalidMessage_paroleeligibilitydate(1)
          ,sentence_doc_Fields.InvalidMessage_parolehearingdate(1)
          ,sentence_doc_Fields.InvalidMessage_parolemaxyears(1)
          ,sentence_doc_Fields.InvalidMessage_parolemaxmonths(1)
          ,sentence_doc_Fields.InvalidMessage_parolemaxdays(1)
          ,sentence_doc_Fields.InvalidMessage_paroleminyears(1)
          ,sentence_doc_Fields.InvalidMessage_paroleminmonths(1)
          ,sentence_doc_Fields.InvalidMessage_parolemindays(1)
          ,sentence_doc_Fields.InvalidMessage_probationbegindate(1)
          ,sentence_doc_Fields.InvalidMessage_probationenddate(1)
          ,sentence_doc_Fields.InvalidMessage_probationmaxyears(1)
          ,sentence_doc_Fields.InvalidMessage_probationmaxmonths(1)
          ,sentence_doc_Fields.InvalidMessage_probationmaxdays(1)
          ,sentence_doc_Fields.InvalidMessage_probationminyears(1)
          ,sentence_doc_Fields.InvalidMessage_probationminmonths(1)
          ,sentence_doc_Fields.InvalidMessage_probationmindays(1)
          ,sentence_doc_Fields.InvalidMessage_sourcename(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_LENGTH_ErrorCount
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
          ,le.sourcename_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_LENGTH_ErrorCount
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
          ,le.sourcename_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,40,Into(LEFT,COUNTER));
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
