IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 44;
  EXPORT NumRulesFromFieldType := 44;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 29;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_BKMortgage_Release)
    UNSIGNED1 ln_filedate_Invalid;
    UNSIGNED1 rectype_Invalid;
    UNSIGNED1 documenttype_Invalid;
    UNSIGNED1 fipscode_Invalid;
    UNSIGNED1 releaserecdate_Invalid;
    UNSIGNED1 releaseeffecdate_Invalid;
    UNSIGNED1 mortgagepayoffdate_Invalid;
    UNSIGNED1 origdotrecdate_Invalid;
    UNSIGNED1 origdotcontractdate_Invalid;
    UNSIGNED1 origlenderben_Invalid;
    UNSIGNED1 currentlenderben_Invalid;
    UNSIGNED1 mers_Invalid;
    UNSIGNED1 borrowername_Invalid;
    UNSIGNED1 borrmailfulladdress_Invalid;
    UNSIGNED1 borrmailcity_Invalid;
    UNSIGNED1 borrmailstate_Invalid;
    UNSIGNED1 borrmailzip_Invalid;
    UNSIGNED1 borrmailzip4_Invalid;
    UNSIGNED1 apn_Invalid;
    UNSIGNED1 propertyfulladd_Invalid;
    UNSIGNED1 propertycity_Invalid;
    UNSIGNED1 propertystate_Invalid;
    UNSIGNED1 propertyzip_Invalid;
    UNSIGNED1 propertyzip4_Invalid;
    UNSIGNED1 assessorpropertyfulladd_Invalid;
    UNSIGNED1 assessorpropertycity_Invalid;
    UNSIGNED1 assessorpropertystate_Invalid;
    UNSIGNED1 assessorpropertyzip_Invalid;
    UNSIGNED1 assessorpropertyzip4_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_BKMortgage_Release)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_BKMortgage_Release) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ln_filedate_Invalid := Fields.InValid_ln_filedate((SALT311.StrType)le.ln_filedate);
    SELF.rectype_Invalid := Fields.InValid_rectype((SALT311.StrType)le.rectype);
    SELF.documenttype_Invalid := Fields.InValid_documenttype((SALT311.StrType)le.documenttype);
    SELF.fipscode_Invalid := Fields.InValid_fipscode((SALT311.StrType)le.fipscode);
    SELF.releaserecdate_Invalid := Fields.InValid_releaserecdate((SALT311.StrType)le.releaserecdate);
    SELF.releaseeffecdate_Invalid := Fields.InValid_releaseeffecdate((SALT311.StrType)le.releaseeffecdate);
    SELF.mortgagepayoffdate_Invalid := Fields.InValid_mortgagepayoffdate((SALT311.StrType)le.mortgagepayoffdate);
    SELF.origdotrecdate_Invalid := Fields.InValid_origdotrecdate((SALT311.StrType)le.origdotrecdate);
    SELF.origdotcontractdate_Invalid := Fields.InValid_origdotcontractdate((SALT311.StrType)le.origdotcontractdate);
    SELF.origlenderben_Invalid := Fields.InValid_origlenderben((SALT311.StrType)le.origlenderben);
    SELF.currentlenderben_Invalid := Fields.InValid_currentlenderben((SALT311.StrType)le.currentlenderben);
    SELF.mers_Invalid := Fields.InValid_mers((SALT311.StrType)le.mers);
    SELF.borrowername_Invalid := Fields.InValid_borrowername((SALT311.StrType)le.borrowername);
    SELF.borrmailfulladdress_Invalid := Fields.InValid_borrmailfulladdress((SALT311.StrType)le.borrmailfulladdress);
    SELF.borrmailcity_Invalid := Fields.InValid_borrmailcity((SALT311.StrType)le.borrmailcity);
    SELF.borrmailstate_Invalid := Fields.InValid_borrmailstate((SALT311.StrType)le.borrmailstate);
    SELF.borrmailzip_Invalid := Fields.InValid_borrmailzip((SALT311.StrType)le.borrmailzip);
    SELF.borrmailzip4_Invalid := Fields.InValid_borrmailzip4((SALT311.StrType)le.borrmailzip4);
    SELF.apn_Invalid := Fields.InValid_apn((SALT311.StrType)le.apn);
    SELF.propertyfulladd_Invalid := Fields.InValid_propertyfulladd((SALT311.StrType)le.propertyfulladd);
    SELF.propertycity_Invalid := Fields.InValid_propertycity((SALT311.StrType)le.propertycity);
    SELF.propertystate_Invalid := Fields.InValid_propertystate((SALT311.StrType)le.propertystate);
    SELF.propertyzip_Invalid := Fields.InValid_propertyzip((SALT311.StrType)le.propertyzip);
    SELF.propertyzip4_Invalid := Fields.InValid_propertyzip4((SALT311.StrType)le.propertyzip4);
    SELF.assessorpropertyfulladd_Invalid := Fields.InValid_assessorpropertyfulladd((SALT311.StrType)le.assessorpropertyfulladd);
    SELF.assessorpropertycity_Invalid := Fields.InValid_assessorpropertycity((SALT311.StrType)le.assessorpropertycity);
    SELF.assessorpropertystate_Invalid := Fields.InValid_assessorpropertystate((SALT311.StrType)le.assessorpropertystate);
    SELF.assessorpropertyzip_Invalid := Fields.InValid_assessorpropertyzip((SALT311.StrType)le.assessorpropertyzip);
    SELF.assessorpropertyzip4_Invalid := Fields.InValid_assessorpropertyzip4((SALT311.StrType)le.assessorpropertyzip4);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_BKMortgage_Release);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ln_filedate_Invalid << 0 ) + ( le.rectype_Invalid << 2 ) + ( le.documenttype_Invalid << 3 ) + ( le.fipscode_Invalid << 4 ) + ( le.releaserecdate_Invalid << 5 ) + ( le.releaseeffecdate_Invalid << 7 ) + ( le.mortgagepayoffdate_Invalid << 9 ) + ( le.origdotrecdate_Invalid << 11 ) + ( le.origdotcontractdate_Invalid << 13 ) + ( le.origlenderben_Invalid << 15 ) + ( le.currentlenderben_Invalid << 16 ) + ( le.mers_Invalid << 17 ) + ( le.borrowername_Invalid << 18 ) + ( le.borrmailfulladdress_Invalid << 19 ) + ( le.borrmailcity_Invalid << 20 ) + ( le.borrmailstate_Invalid << 21 ) + ( le.borrmailzip_Invalid << 23 ) + ( le.borrmailzip4_Invalid << 25 ) + ( le.apn_Invalid << 27 ) + ( le.propertyfulladd_Invalid << 28 ) + ( le.propertycity_Invalid << 29 ) + ( le.propertystate_Invalid << 30 ) + ( le.propertyzip_Invalid << 32 ) + ( le.propertyzip4_Invalid << 34 ) + ( le.assessorpropertyfulladd_Invalid << 36 ) + ( le.assessorpropertycity_Invalid << 37 ) + ( le.assessorpropertystate_Invalid << 38 ) + ( le.assessorpropertyzip_Invalid << 40 ) + ( le.assessorpropertyzip4_Invalid << 42 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_BKMortgage_Release);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ln_filedate_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.rectype_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.documenttype_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.fipscode_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.releaserecdate_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.releaseeffecdate_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.mortgagepayoffdate_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.origdotrecdate_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.origdotcontractdate_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.origlenderben_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.currentlenderben_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.mers_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.borrowername_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.borrmailfulladdress_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.borrmailcity_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.borrmailstate_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.borrmailzip_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.borrmailzip4_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.apn_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.propertyfulladd_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.propertycity_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.propertystate_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.propertyzip_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.propertyzip4_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.assessorpropertyfulladd_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.assessorpropertycity_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.assessorpropertystate_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.assessorpropertyzip_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.assessorpropertyzip4_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ln_filedate_ALLOW_ErrorCount := COUNT(GROUP,h.ln_filedate_Invalid=1);
    ln_filedate_LENGTHS_ErrorCount := COUNT(GROUP,h.ln_filedate_Invalid=2);
    ln_filedate_Total_ErrorCount := COUNT(GROUP,h.ln_filedate_Invalid>0);
    rectype_ENUM_ErrorCount := COUNT(GROUP,h.rectype_Invalid=1);
    documenttype_ENUM_ErrorCount := COUNT(GROUP,h.documenttype_Invalid=1);
    fipscode_ALLOW_ErrorCount := COUNT(GROUP,h.fipscode_Invalid=1);
    releaserecdate_ALLOW_ErrorCount := COUNT(GROUP,h.releaserecdate_Invalid=1);
    releaserecdate_LENGTHS_ErrorCount := COUNT(GROUP,h.releaserecdate_Invalid=2);
    releaserecdate_Total_ErrorCount := COUNT(GROUP,h.releaserecdate_Invalid>0);
    releaseeffecdate_ALLOW_ErrorCount := COUNT(GROUP,h.releaseeffecdate_Invalid=1);
    releaseeffecdate_LENGTHS_ErrorCount := COUNT(GROUP,h.releaseeffecdate_Invalid=2);
    releaseeffecdate_Total_ErrorCount := COUNT(GROUP,h.releaseeffecdate_Invalid>0);
    mortgagepayoffdate_ALLOW_ErrorCount := COUNT(GROUP,h.mortgagepayoffdate_Invalid=1);
    mortgagepayoffdate_LENGTHS_ErrorCount := COUNT(GROUP,h.mortgagepayoffdate_Invalid=2);
    mortgagepayoffdate_Total_ErrorCount := COUNT(GROUP,h.mortgagepayoffdate_Invalid>0);
    origdotrecdate_ALLOW_ErrorCount := COUNT(GROUP,h.origdotrecdate_Invalid=1);
    origdotrecdate_LENGTHS_ErrorCount := COUNT(GROUP,h.origdotrecdate_Invalid=2);
    origdotrecdate_Total_ErrorCount := COUNT(GROUP,h.origdotrecdate_Invalid>0);
    origdotcontractdate_ALLOW_ErrorCount := COUNT(GROUP,h.origdotcontractdate_Invalid=1);
    origdotcontractdate_LENGTHS_ErrorCount := COUNT(GROUP,h.origdotcontractdate_Invalid=2);
    origdotcontractdate_Total_ErrorCount := COUNT(GROUP,h.origdotcontractdate_Invalid>0);
    origlenderben_ALLOW_ErrorCount := COUNT(GROUP,h.origlenderben_Invalid=1);
    currentlenderben_ALLOW_ErrorCount := COUNT(GROUP,h.currentlenderben_Invalid=1);
    mers_ALLOW_ErrorCount := COUNT(GROUP,h.mers_Invalid=1);
    borrowername_ALLOW_ErrorCount := COUNT(GROUP,h.borrowername_Invalid=1);
    borrmailfulladdress_ALLOW_ErrorCount := COUNT(GROUP,h.borrmailfulladdress_Invalid=1);
    borrmailcity_ALLOW_ErrorCount := COUNT(GROUP,h.borrmailcity_Invalid=1);
    borrmailstate_ALLOW_ErrorCount := COUNT(GROUP,h.borrmailstate_Invalid=1);
    borrmailstate_LENGTHS_ErrorCount := COUNT(GROUP,h.borrmailstate_Invalid=2);
    borrmailstate_Total_ErrorCount := COUNT(GROUP,h.borrmailstate_Invalid>0);
    borrmailzip_ALLOW_ErrorCount := COUNT(GROUP,h.borrmailzip_Invalid=1);
    borrmailzip_LENGTHS_ErrorCount := COUNT(GROUP,h.borrmailzip_Invalid=2);
    borrmailzip_Total_ErrorCount := COUNT(GROUP,h.borrmailzip_Invalid>0);
    borrmailzip4_ALLOW_ErrorCount := COUNT(GROUP,h.borrmailzip4_Invalid=1);
    borrmailzip4_LENGTHS_ErrorCount := COUNT(GROUP,h.borrmailzip4_Invalid=2);
    borrmailzip4_Total_ErrorCount := COUNT(GROUP,h.borrmailzip4_Invalid>0);
    apn_ALLOW_ErrorCount := COUNT(GROUP,h.apn_Invalid=1);
    propertyfulladd_ALLOW_ErrorCount := COUNT(GROUP,h.propertyfulladd_Invalid=1);
    propertycity_ALLOW_ErrorCount := COUNT(GROUP,h.propertycity_Invalid=1);
    propertystate_ALLOW_ErrorCount := COUNT(GROUP,h.propertystate_Invalid=1);
    propertystate_LENGTHS_ErrorCount := COUNT(GROUP,h.propertystate_Invalid=2);
    propertystate_Total_ErrorCount := COUNT(GROUP,h.propertystate_Invalid>0);
    propertyzip_ALLOW_ErrorCount := COUNT(GROUP,h.propertyzip_Invalid=1);
    propertyzip_LENGTHS_ErrorCount := COUNT(GROUP,h.propertyzip_Invalid=2);
    propertyzip_Total_ErrorCount := COUNT(GROUP,h.propertyzip_Invalid>0);
    propertyzip4_ALLOW_ErrorCount := COUNT(GROUP,h.propertyzip4_Invalid=1);
    propertyzip4_LENGTHS_ErrorCount := COUNT(GROUP,h.propertyzip4_Invalid=2);
    propertyzip4_Total_ErrorCount := COUNT(GROUP,h.propertyzip4_Invalid>0);
    assessorpropertyfulladd_ALLOW_ErrorCount := COUNT(GROUP,h.assessorpropertyfulladd_Invalid=1);
    assessorpropertycity_ALLOW_ErrorCount := COUNT(GROUP,h.assessorpropertycity_Invalid=1);
    assessorpropertystate_ALLOW_ErrorCount := COUNT(GROUP,h.assessorpropertystate_Invalid=1);
    assessorpropertystate_LENGTHS_ErrorCount := COUNT(GROUP,h.assessorpropertystate_Invalid=2);
    assessorpropertystate_Total_ErrorCount := COUNT(GROUP,h.assessorpropertystate_Invalid>0);
    assessorpropertyzip_ALLOW_ErrorCount := COUNT(GROUP,h.assessorpropertyzip_Invalid=1);
    assessorpropertyzip_LENGTHS_ErrorCount := COUNT(GROUP,h.assessorpropertyzip_Invalid=2);
    assessorpropertyzip_Total_ErrorCount := COUNT(GROUP,h.assessorpropertyzip_Invalid>0);
    assessorpropertyzip4_ALLOW_ErrorCount := COUNT(GROUP,h.assessorpropertyzip4_Invalid=1);
    assessorpropertyzip4_LENGTHS_ErrorCount := COUNT(GROUP,h.assessorpropertyzip4_Invalid=2);
    assessorpropertyzip4_Total_ErrorCount := COUNT(GROUP,h.assessorpropertyzip4_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ln_filedate_Invalid > 0 OR h.rectype_Invalid > 0 OR h.documenttype_Invalid > 0 OR h.fipscode_Invalid > 0 OR h.releaserecdate_Invalid > 0 OR h.releaseeffecdate_Invalid > 0 OR h.mortgagepayoffdate_Invalid > 0 OR h.origdotrecdate_Invalid > 0 OR h.origdotcontractdate_Invalid > 0 OR h.origlenderben_Invalid > 0 OR h.currentlenderben_Invalid > 0 OR h.mers_Invalid > 0 OR h.borrowername_Invalid > 0 OR h.borrmailfulladdress_Invalid > 0 OR h.borrmailcity_Invalid > 0 OR h.borrmailstate_Invalid > 0 OR h.borrmailzip_Invalid > 0 OR h.borrmailzip4_Invalid > 0 OR h.apn_Invalid > 0 OR h.propertyfulladd_Invalid > 0 OR h.propertycity_Invalid > 0 OR h.propertystate_Invalid > 0 OR h.propertyzip_Invalid > 0 OR h.propertyzip4_Invalid > 0 OR h.assessorpropertyfulladd_Invalid > 0 OR h.assessorpropertycity_Invalid > 0 OR h.assessorpropertystate_Invalid > 0 OR h.assessorpropertyzip_Invalid > 0 OR h.assessorpropertyzip4_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ln_filedate_Total_ErrorCount > 0, 1, 0) + IF(le.rectype_ENUM_ErrorCount > 0, 1, 0) + IF(le.documenttype_ENUM_ErrorCount > 0, 1, 0) + IF(le.fipscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.releaserecdate_Total_ErrorCount > 0, 1, 0) + IF(le.releaseeffecdate_Total_ErrorCount > 0, 1, 0) + IF(le.mortgagepayoffdate_Total_ErrorCount > 0, 1, 0) + IF(le.origdotrecdate_Total_ErrorCount > 0, 1, 0) + IF(le.origdotcontractdate_Total_ErrorCount > 0, 1, 0) + IF(le.origlenderben_ALLOW_ErrorCount > 0, 1, 0) + IF(le.currentlenderben_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mers_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrowername_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrmailfulladdress_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrmailcity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrmailstate_Total_ErrorCount > 0, 1, 0) + IF(le.borrmailzip_Total_ErrorCount > 0, 1, 0) + IF(le.borrmailzip4_Total_ErrorCount > 0, 1, 0) + IF(le.apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertyfulladd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertycity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertystate_Total_ErrorCount > 0, 1, 0) + IF(le.propertyzip_Total_ErrorCount > 0, 1, 0) + IF(le.propertyzip4_Total_ErrorCount > 0, 1, 0) + IF(le.assessorpropertyfulladd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessorpropertycity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessorpropertystate_Total_ErrorCount > 0, 1, 0) + IF(le.assessorpropertyzip_Total_ErrorCount > 0, 1, 0) + IF(le.assessorpropertyzip4_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ln_filedate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_filedate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rectype_ENUM_ErrorCount > 0, 1, 0) + IF(le.documenttype_ENUM_ErrorCount > 0, 1, 0) + IF(le.fipscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.releaserecdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.releaserecdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.releaseeffecdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.releaseeffecdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mortgagepayoffdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mortgagepayoffdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.origdotrecdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.origdotrecdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.origdotcontractdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.origdotcontractdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.origlenderben_ALLOW_ErrorCount > 0, 1, 0) + IF(le.currentlenderben_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mers_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrowername_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrmailfulladdress_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrmailcity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrmailstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrmailstate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.borrmailzip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrmailzip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.borrmailzip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrmailzip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertyfulladd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertycity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertystate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertystate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.propertyzip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertyzip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.propertyzip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertyzip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.assessorpropertyfulladd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessorpropertycity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessorpropertystate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessorpropertystate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.assessorpropertyzip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessorpropertyzip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.assessorpropertyzip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessorpropertyzip4_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ln_filedate_Invalid,le.rectype_Invalid,le.documenttype_Invalid,le.fipscode_Invalid,le.releaserecdate_Invalid,le.releaseeffecdate_Invalid,le.mortgagepayoffdate_Invalid,le.origdotrecdate_Invalid,le.origdotcontractdate_Invalid,le.origlenderben_Invalid,le.currentlenderben_Invalid,le.mers_Invalid,le.borrowername_Invalid,le.borrmailfulladdress_Invalid,le.borrmailcity_Invalid,le.borrmailstate_Invalid,le.borrmailzip_Invalid,le.borrmailzip4_Invalid,le.apn_Invalid,le.propertyfulladd_Invalid,le.propertycity_Invalid,le.propertystate_Invalid,le.propertyzip_Invalid,le.propertyzip4_Invalid,le.assessorpropertyfulladd_Invalid,le.assessorpropertycity_Invalid,le.assessorpropertystate_Invalid,le.assessorpropertyzip_Invalid,le.assessorpropertyzip4_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ln_filedate(le.ln_filedate_Invalid),Fields.InvalidMessage_rectype(le.rectype_Invalid),Fields.InvalidMessage_documenttype(le.documenttype_Invalid),Fields.InvalidMessage_fipscode(le.fipscode_Invalid),Fields.InvalidMessage_releaserecdate(le.releaserecdate_Invalid),Fields.InvalidMessage_releaseeffecdate(le.releaseeffecdate_Invalid),Fields.InvalidMessage_mortgagepayoffdate(le.mortgagepayoffdate_Invalid),Fields.InvalidMessage_origdotrecdate(le.origdotrecdate_Invalid),Fields.InvalidMessage_origdotcontractdate(le.origdotcontractdate_Invalid),Fields.InvalidMessage_origlenderben(le.origlenderben_Invalid),Fields.InvalidMessage_currentlenderben(le.currentlenderben_Invalid),Fields.InvalidMessage_mers(le.mers_Invalid),Fields.InvalidMessage_borrowername(le.borrowername_Invalid),Fields.InvalidMessage_borrmailfulladdress(le.borrmailfulladdress_Invalid),Fields.InvalidMessage_borrmailcity(le.borrmailcity_Invalid),Fields.InvalidMessage_borrmailstate(le.borrmailstate_Invalid),Fields.InvalidMessage_borrmailzip(le.borrmailzip_Invalid),Fields.InvalidMessage_borrmailzip4(le.borrmailzip4_Invalid),Fields.InvalidMessage_apn(le.apn_Invalid),Fields.InvalidMessage_propertyfulladd(le.propertyfulladd_Invalid),Fields.InvalidMessage_propertycity(le.propertycity_Invalid),Fields.InvalidMessage_propertystate(le.propertystate_Invalid),Fields.InvalidMessage_propertyzip(le.propertyzip_Invalid),Fields.InvalidMessage_propertyzip4(le.propertyzip4_Invalid),Fields.InvalidMessage_assessorpropertyfulladd(le.assessorpropertyfulladd_Invalid),Fields.InvalidMessage_assessorpropertycity(le.assessorpropertycity_Invalid),Fields.InvalidMessage_assessorpropertystate(le.assessorpropertystate_Invalid),Fields.InvalidMessage_assessorpropertyzip(le.assessorpropertyzip_Invalid),Fields.InvalidMessage_assessorpropertyzip4(le.assessorpropertyzip4_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ln_filedate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rectype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.documenttype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.fipscode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.releaserecdate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.releaseeffecdate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mortgagepayoffdate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.origdotrecdate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.origdotcontractdate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.origlenderben_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.currentlenderben_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mers_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.borrowername_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.borrmailfulladdress_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.borrmailcity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.borrmailstate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.borrmailzip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.borrmailzip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.apn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.propertyfulladd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.propertycity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.propertystate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.propertyzip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.propertyzip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.assessorpropertyfulladd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assessorpropertycity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assessorpropertystate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.assessorpropertyzip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.assessorpropertyzip4_Invalid,'ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ln_filedate','rectype','documenttype','fipscode','releaserecdate','releaseeffecdate','mortgagepayoffdate','origdotrecdate','origdotcontractdate','origlenderben','currentlenderben','mers','borrowername','borrmailfulladdress','borrmailcity','borrmailstate','borrmailzip','borrmailzip4','apn','propertyfulladd','propertycity','propertystate','propertyzip','propertyzip4','assessorpropertyfulladd','assessorpropertycity','assessorpropertystate','assessorpropertyzip','assessorpropertyzip4','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','Invalid_RecType','Invalid_DocType','invalid_number','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_name','invalid_name','invalid_mers','invalid_name','invalid_AlphaNum','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','invalid_apn','invalid_AlphaNum','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','invalid_AlphaNum','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ln_filedate,(SALT311.StrType)le.rectype,(SALT311.StrType)le.documenttype,(SALT311.StrType)le.fipscode,(SALT311.StrType)le.releaserecdate,(SALT311.StrType)le.releaseeffecdate,(SALT311.StrType)le.mortgagepayoffdate,(SALT311.StrType)le.origdotrecdate,(SALT311.StrType)le.origdotcontractdate,(SALT311.StrType)le.origlenderben,(SALT311.StrType)le.currentlenderben,(SALT311.StrType)le.mers,(SALT311.StrType)le.borrowername,(SALT311.StrType)le.borrmailfulladdress,(SALT311.StrType)le.borrmailcity,(SALT311.StrType)le.borrmailstate,(SALT311.StrType)le.borrmailzip,(SALT311.StrType)le.borrmailzip4,(SALT311.StrType)le.apn,(SALT311.StrType)le.propertyfulladd,(SALT311.StrType)le.propertycity,(SALT311.StrType)le.propertystate,(SALT311.StrType)le.propertyzip,(SALT311.StrType)le.propertyzip4,(SALT311.StrType)le.assessorpropertyfulladd,(SALT311.StrType)le.assessorpropertycity,(SALT311.StrType)le.assessorpropertystate,(SALT311.StrType)le.assessorpropertyzip,(SALT311.StrType)le.assessorpropertyzip4,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,29,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_BKMortgage_Release) prevDS = DATASET([], Layout_BKMortgage_Release), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ln_filedate:invalid_date:ALLOW','ln_filedate:invalid_date:LENGTHS'
          ,'rectype:Invalid_RecType:ENUM'
          ,'documenttype:Invalid_DocType:ENUM'
          ,'fipscode:invalid_number:ALLOW'
          ,'releaserecdate:invalid_date:ALLOW','releaserecdate:invalid_date:LENGTHS'
          ,'releaseeffecdate:invalid_date:ALLOW','releaseeffecdate:invalid_date:LENGTHS'
          ,'mortgagepayoffdate:invalid_date:ALLOW','mortgagepayoffdate:invalid_date:LENGTHS'
          ,'origdotrecdate:invalid_date:ALLOW','origdotrecdate:invalid_date:LENGTHS'
          ,'origdotcontractdate:invalid_date:ALLOW','origdotcontractdate:invalid_date:LENGTHS'
          ,'origlenderben:invalid_name:ALLOW'
          ,'currentlenderben:invalid_name:ALLOW'
          ,'mers:invalid_mers:ALLOW'
          ,'borrowername:invalid_name:ALLOW'
          ,'borrmailfulladdress:invalid_AlphaNum:ALLOW'
          ,'borrmailcity:invalid_AlphaNum:ALLOW'
          ,'borrmailstate:invalid_state:ALLOW','borrmailstate:invalid_state:LENGTHS'
          ,'borrmailzip:invalid_zip:ALLOW','borrmailzip:invalid_zip:LENGTHS'
          ,'borrmailzip4:invalid_zip:ALLOW','borrmailzip4:invalid_zip:LENGTHS'
          ,'apn:invalid_apn:ALLOW'
          ,'propertyfulladd:invalid_AlphaNum:ALLOW'
          ,'propertycity:invalid_AlphaNum:ALLOW'
          ,'propertystate:invalid_state:ALLOW','propertystate:invalid_state:LENGTHS'
          ,'propertyzip:invalid_zip:ALLOW','propertyzip:invalid_zip:LENGTHS'
          ,'propertyzip4:invalid_zip:ALLOW','propertyzip4:invalid_zip:LENGTHS'
          ,'assessorpropertyfulladd:invalid_AlphaNum:ALLOW'
          ,'assessorpropertycity:invalid_AlphaNum:ALLOW'
          ,'assessorpropertystate:invalid_state:ALLOW','assessorpropertystate:invalid_state:LENGTHS'
          ,'assessorpropertyzip:invalid_zip:ALLOW','assessorpropertyzip:invalid_zip:LENGTHS'
          ,'assessorpropertyzip4:invalid_zip:ALLOW','assessorpropertyzip4:invalid_zip:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_ln_filedate(1),Fields.InvalidMessage_ln_filedate(2)
          ,Fields.InvalidMessage_rectype(1)
          ,Fields.InvalidMessage_documenttype(1)
          ,Fields.InvalidMessage_fipscode(1)
          ,Fields.InvalidMessage_releaserecdate(1),Fields.InvalidMessage_releaserecdate(2)
          ,Fields.InvalidMessage_releaseeffecdate(1),Fields.InvalidMessage_releaseeffecdate(2)
          ,Fields.InvalidMessage_mortgagepayoffdate(1),Fields.InvalidMessage_mortgagepayoffdate(2)
          ,Fields.InvalidMessage_origdotrecdate(1),Fields.InvalidMessage_origdotrecdate(2)
          ,Fields.InvalidMessage_origdotcontractdate(1),Fields.InvalidMessage_origdotcontractdate(2)
          ,Fields.InvalidMessage_origlenderben(1)
          ,Fields.InvalidMessage_currentlenderben(1)
          ,Fields.InvalidMessage_mers(1)
          ,Fields.InvalidMessage_borrowername(1)
          ,Fields.InvalidMessage_borrmailfulladdress(1)
          ,Fields.InvalidMessage_borrmailcity(1)
          ,Fields.InvalidMessage_borrmailstate(1),Fields.InvalidMessage_borrmailstate(2)
          ,Fields.InvalidMessage_borrmailzip(1),Fields.InvalidMessage_borrmailzip(2)
          ,Fields.InvalidMessage_borrmailzip4(1),Fields.InvalidMessage_borrmailzip4(2)
          ,Fields.InvalidMessage_apn(1)
          ,Fields.InvalidMessage_propertyfulladd(1)
          ,Fields.InvalidMessage_propertycity(1)
          ,Fields.InvalidMessage_propertystate(1),Fields.InvalidMessage_propertystate(2)
          ,Fields.InvalidMessage_propertyzip(1),Fields.InvalidMessage_propertyzip(2)
          ,Fields.InvalidMessage_propertyzip4(1),Fields.InvalidMessage_propertyzip4(2)
          ,Fields.InvalidMessage_assessorpropertyfulladd(1)
          ,Fields.InvalidMessage_assessorpropertycity(1)
          ,Fields.InvalidMessage_assessorpropertystate(1),Fields.InvalidMessage_assessorpropertystate(2)
          ,Fields.InvalidMessage_assessorpropertyzip(1),Fields.InvalidMessage_assessorpropertyzip(2)
          ,Fields.InvalidMessage_assessorpropertyzip4(1),Fields.InvalidMessage_assessorpropertyzip4(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ln_filedate_ALLOW_ErrorCount,le.ln_filedate_LENGTHS_ErrorCount
          ,le.rectype_ENUM_ErrorCount
          ,le.documenttype_ENUM_ErrorCount
          ,le.fipscode_ALLOW_ErrorCount
          ,le.releaserecdate_ALLOW_ErrorCount,le.releaserecdate_LENGTHS_ErrorCount
          ,le.releaseeffecdate_ALLOW_ErrorCount,le.releaseeffecdate_LENGTHS_ErrorCount
          ,le.mortgagepayoffdate_ALLOW_ErrorCount,le.mortgagepayoffdate_LENGTHS_ErrorCount
          ,le.origdotrecdate_ALLOW_ErrorCount,le.origdotrecdate_LENGTHS_ErrorCount
          ,le.origdotcontractdate_ALLOW_ErrorCount,le.origdotcontractdate_LENGTHS_ErrorCount
          ,le.origlenderben_ALLOW_ErrorCount
          ,le.currentlenderben_ALLOW_ErrorCount
          ,le.mers_ALLOW_ErrorCount
          ,le.borrowername_ALLOW_ErrorCount
          ,le.borrmailfulladdress_ALLOW_ErrorCount
          ,le.borrmailcity_ALLOW_ErrorCount
          ,le.borrmailstate_ALLOW_ErrorCount,le.borrmailstate_LENGTHS_ErrorCount
          ,le.borrmailzip_ALLOW_ErrorCount,le.borrmailzip_LENGTHS_ErrorCount
          ,le.borrmailzip4_ALLOW_ErrorCount,le.borrmailzip4_LENGTHS_ErrorCount
          ,le.apn_ALLOW_ErrorCount
          ,le.propertyfulladd_ALLOW_ErrorCount
          ,le.propertycity_ALLOW_ErrorCount
          ,le.propertystate_ALLOW_ErrorCount,le.propertystate_LENGTHS_ErrorCount
          ,le.propertyzip_ALLOW_ErrorCount,le.propertyzip_LENGTHS_ErrorCount
          ,le.propertyzip4_ALLOW_ErrorCount,le.propertyzip4_LENGTHS_ErrorCount
          ,le.assessorpropertyfulladd_ALLOW_ErrorCount
          ,le.assessorpropertycity_ALLOW_ErrorCount
          ,le.assessorpropertystate_ALLOW_ErrorCount,le.assessorpropertystate_LENGTHS_ErrorCount
          ,le.assessorpropertyzip_ALLOW_ErrorCount,le.assessorpropertyzip_LENGTHS_ErrorCount
          ,le.assessorpropertyzip4_ALLOW_ErrorCount,le.assessorpropertyzip4_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ln_filedate_ALLOW_ErrorCount,le.ln_filedate_LENGTHS_ErrorCount
          ,le.rectype_ENUM_ErrorCount
          ,le.documenttype_ENUM_ErrorCount
          ,le.fipscode_ALLOW_ErrorCount
          ,le.releaserecdate_ALLOW_ErrorCount,le.releaserecdate_LENGTHS_ErrorCount
          ,le.releaseeffecdate_ALLOW_ErrorCount,le.releaseeffecdate_LENGTHS_ErrorCount
          ,le.mortgagepayoffdate_ALLOW_ErrorCount,le.mortgagepayoffdate_LENGTHS_ErrorCount
          ,le.origdotrecdate_ALLOW_ErrorCount,le.origdotrecdate_LENGTHS_ErrorCount
          ,le.origdotcontractdate_ALLOW_ErrorCount,le.origdotcontractdate_LENGTHS_ErrorCount
          ,le.origlenderben_ALLOW_ErrorCount
          ,le.currentlenderben_ALLOW_ErrorCount
          ,le.mers_ALLOW_ErrorCount
          ,le.borrowername_ALLOW_ErrorCount
          ,le.borrmailfulladdress_ALLOW_ErrorCount
          ,le.borrmailcity_ALLOW_ErrorCount
          ,le.borrmailstate_ALLOW_ErrorCount,le.borrmailstate_LENGTHS_ErrorCount
          ,le.borrmailzip_ALLOW_ErrorCount,le.borrmailzip_LENGTHS_ErrorCount
          ,le.borrmailzip4_ALLOW_ErrorCount,le.borrmailzip4_LENGTHS_ErrorCount
          ,le.apn_ALLOW_ErrorCount
          ,le.propertyfulladd_ALLOW_ErrorCount
          ,le.propertycity_ALLOW_ErrorCount
          ,le.propertystate_ALLOW_ErrorCount,le.propertystate_LENGTHS_ErrorCount
          ,le.propertyzip_ALLOW_ErrorCount,le.propertyzip_LENGTHS_ErrorCount
          ,le.propertyzip4_ALLOW_ErrorCount,le.propertyzip4_LENGTHS_ErrorCount
          ,le.assessorpropertyfulladd_ALLOW_ErrorCount
          ,le.assessorpropertycity_ALLOW_ErrorCount
          ,le.assessorpropertystate_ALLOW_ErrorCount,le.assessorpropertystate_LENGTHS_ErrorCount
          ,le.assessorpropertyzip_ALLOW_ErrorCount,le.assessorpropertyzip_LENGTHS_ErrorCount
          ,le.assessorpropertyzip4_ALLOW_ErrorCount,le.assessorpropertyzip4_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_BKMortgage_Release));
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
          ,'ln_filedate:' + getFieldTypeText(h.ln_filedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bk_infile_type:' + getFieldTypeText(h.bk_infile_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rectype:' + getFieldTypeText(h.rectype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'documenttype:' + getFieldTypeText(h.documenttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fipscode:' + getFieldTypeText(h.fipscode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mainaddendum:' + getFieldTypeText(h.mainaddendum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'releaserecdate:' + getFieldTypeText(h.releaserecdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'releaseeffecdate:' + getFieldTypeText(h.releaseeffecdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mortgagepayoffdate:' + getFieldTypeText(h.mortgagepayoffdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'releasedoc:' + getFieldTypeText(h.releasedoc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'releasebk:' + getFieldTypeText(h.releasebk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'releasepg:' + getFieldTypeText(h.releasepg) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'multiplepageimage:' + getFieldTypeText(h.multiplepageimage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkfsimageid:' + getFieldTypeText(h.bkfsimageid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origdotrecdate:' + getFieldTypeText(h.origdotrecdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origdotcontractdate:' + getFieldTypeText(h.origdotcontractdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origdotdoc:' + getFieldTypeText(h.origdotdoc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origdotbk:' + getFieldTypeText(h.origdotbk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origdotpg:' + getFieldTypeText(h.origdotpg) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origlenderben:' + getFieldTypeText(h.origlenderben) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origloanamnt:' + getFieldTypeText(h.origloanamnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loannumber:' + getFieldTypeText(h.loannumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'currentlenderben:' + getFieldTypeText(h.currentlenderben) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mers:' + getFieldTypeText(h.mers) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mersvalidation:' + getFieldTypeText(h.mersvalidation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mspsvrloan:' + getFieldTypeText(h.mspsvrloan) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'currentlenderpool:' + getFieldTypeText(h.currentlenderpool) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrowername:' + getFieldTypeText(h.borrowername) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrmailfulladdress:' + getFieldTypeText(h.borrmailfulladdress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrmailunit:' + getFieldTypeText(h.borrmailunit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrmailcity:' + getFieldTypeText(h.borrmailcity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrmailstate:' + getFieldTypeText(h.borrmailstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrmailzip:' + getFieldTypeText(h.borrmailzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrmailzip4:' + getFieldTypeText(h.borrmailzip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apn:' + getFieldTypeText(h.apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'multiapncode:' + getFieldTypeText(h.multiapncode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxacctid:' + getFieldTypeText(h.taxacctid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertyfulladd:' + getFieldTypeText(h.propertyfulladd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertyunit:' + getFieldTypeText(h.propertyunit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertycity:' + getFieldTypeText(h.propertycity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertystate:' + getFieldTypeText(h.propertystate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertyzip:' + getFieldTypeText(h.propertyzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertyzip4:' + getFieldTypeText(h.propertyzip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dataentrydate:' + getFieldTypeText(h.dataentrydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dataentryopercode:' + getFieldTypeText(h.dataentryopercode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendorsourcecode:' + getFieldTypeText(h.vendorsourcecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hids_recordingflag:' + getFieldTypeText(h.hids_recordingflag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hids_docnumber:' + getFieldTypeText(h.hids_docnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transfercertificateoftitle:' + getFieldTypeText(h.transfercertificateoftitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hi_condo_cpr_hpr:' + getFieldTypeText(h.hi_condo_cpr_hpr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hi_situs_unit_number:' + getFieldTypeText(h.hi_situs_unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hids_previous_docnumber:' + getFieldTypeText(h.hids_previous_docnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prevtransfercertificateoftitle:' + getFieldTypeText(h.prevtransfercertificateoftitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pid:' + getFieldTypeText(h.pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'matchedororphan:' + getFieldTypeText(h.matchedororphan) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deed_pid:' + getFieldTypeText(h.deed_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sam_pid:' + getFieldTypeText(h.sam_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorparcelnumber_matched:' + getFieldTypeText(h.assessorparcelnumber_matched) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyfulladd:' + getFieldTypeText(h.assessorpropertyfulladd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyunittype:' + getFieldTypeText(h.assessorpropertyunittype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyunit:' + getFieldTypeText(h.assessorpropertyunit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertycity:' + getFieldTypeText(h.assessorpropertycity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertystate:' + getFieldTypeText(h.assessorpropertystate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyzip:' + getFieldTypeText(h.assessorpropertyzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyzip4:' + getFieldTypeText(h.assessorpropertyzip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyaddrsource:' + getFieldTypeText(h.assessorpropertyaddrsource) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_file_name:' + getFieldTypeText(h.raw_file_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ln_filedate_cnt
          ,le.populated_bk_infile_type_cnt
          ,le.populated_rectype_cnt
          ,le.populated_documenttype_cnt
          ,le.populated_fipscode_cnt
          ,le.populated_mainaddendum_cnt
          ,le.populated_releaserecdate_cnt
          ,le.populated_releaseeffecdate_cnt
          ,le.populated_mortgagepayoffdate_cnt
          ,le.populated_releasedoc_cnt
          ,le.populated_releasebk_cnt
          ,le.populated_releasepg_cnt
          ,le.populated_multiplepageimage_cnt
          ,le.populated_bkfsimageid_cnt
          ,le.populated_origdotrecdate_cnt
          ,le.populated_origdotcontractdate_cnt
          ,le.populated_origdotdoc_cnt
          ,le.populated_origdotbk_cnt
          ,le.populated_origdotpg_cnt
          ,le.populated_origlenderben_cnt
          ,le.populated_origloanamnt_cnt
          ,le.populated_loannumber_cnt
          ,le.populated_currentlenderben_cnt
          ,le.populated_mers_cnt
          ,le.populated_mersvalidation_cnt
          ,le.populated_mspsvrloan_cnt
          ,le.populated_currentlenderpool_cnt
          ,le.populated_borrowername_cnt
          ,le.populated_borrmailfulladdress_cnt
          ,le.populated_borrmailunit_cnt
          ,le.populated_borrmailcity_cnt
          ,le.populated_borrmailstate_cnt
          ,le.populated_borrmailzip_cnt
          ,le.populated_borrmailzip4_cnt
          ,le.populated_apn_cnt
          ,le.populated_multiapncode_cnt
          ,le.populated_taxacctid_cnt
          ,le.populated_propertyfulladd_cnt
          ,le.populated_propertyunit_cnt
          ,le.populated_propertycity_cnt
          ,le.populated_propertystate_cnt
          ,le.populated_propertyzip_cnt
          ,le.populated_propertyzip4_cnt
          ,le.populated_dataentrydate_cnt
          ,le.populated_dataentryopercode_cnt
          ,le.populated_vendorsourcecode_cnt
          ,le.populated_hids_recordingflag_cnt
          ,le.populated_hids_docnumber_cnt
          ,le.populated_transfercertificateoftitle_cnt
          ,le.populated_hi_condo_cpr_hpr_cnt
          ,le.populated_hi_situs_unit_number_cnt
          ,le.populated_hids_previous_docnumber_cnt
          ,le.populated_prevtransfercertificateoftitle_cnt
          ,le.populated_pid_cnt
          ,le.populated_matchedororphan_cnt
          ,le.populated_deed_pid_cnt
          ,le.populated_sam_pid_cnt
          ,le.populated_assessorparcelnumber_matched_cnt
          ,le.populated_assessorpropertyfulladd_cnt
          ,le.populated_assessorpropertyunittype_cnt
          ,le.populated_assessorpropertyunit_cnt
          ,le.populated_assessorpropertycity_cnt
          ,le.populated_assessorpropertystate_cnt
          ,le.populated_assessorpropertyzip_cnt
          ,le.populated_assessorpropertyzip4_cnt
          ,le.populated_assessorpropertyaddrsource_cnt
          ,le.populated_raw_file_name_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ln_filedate_pcnt
          ,le.populated_bk_infile_type_pcnt
          ,le.populated_rectype_pcnt
          ,le.populated_documenttype_pcnt
          ,le.populated_fipscode_pcnt
          ,le.populated_mainaddendum_pcnt
          ,le.populated_releaserecdate_pcnt
          ,le.populated_releaseeffecdate_pcnt
          ,le.populated_mortgagepayoffdate_pcnt
          ,le.populated_releasedoc_pcnt
          ,le.populated_releasebk_pcnt
          ,le.populated_releasepg_pcnt
          ,le.populated_multiplepageimage_pcnt
          ,le.populated_bkfsimageid_pcnt
          ,le.populated_origdotrecdate_pcnt
          ,le.populated_origdotcontractdate_pcnt
          ,le.populated_origdotdoc_pcnt
          ,le.populated_origdotbk_pcnt
          ,le.populated_origdotpg_pcnt
          ,le.populated_origlenderben_pcnt
          ,le.populated_origloanamnt_pcnt
          ,le.populated_loannumber_pcnt
          ,le.populated_currentlenderben_pcnt
          ,le.populated_mers_pcnt
          ,le.populated_mersvalidation_pcnt
          ,le.populated_mspsvrloan_pcnt
          ,le.populated_currentlenderpool_pcnt
          ,le.populated_borrowername_pcnt
          ,le.populated_borrmailfulladdress_pcnt
          ,le.populated_borrmailunit_pcnt
          ,le.populated_borrmailcity_pcnt
          ,le.populated_borrmailstate_pcnt
          ,le.populated_borrmailzip_pcnt
          ,le.populated_borrmailzip4_pcnt
          ,le.populated_apn_pcnt
          ,le.populated_multiapncode_pcnt
          ,le.populated_taxacctid_pcnt
          ,le.populated_propertyfulladd_pcnt
          ,le.populated_propertyunit_pcnt
          ,le.populated_propertycity_pcnt
          ,le.populated_propertystate_pcnt
          ,le.populated_propertyzip_pcnt
          ,le.populated_propertyzip4_pcnt
          ,le.populated_dataentrydate_pcnt
          ,le.populated_dataentryopercode_pcnt
          ,le.populated_vendorsourcecode_pcnt
          ,le.populated_hids_recordingflag_pcnt
          ,le.populated_hids_docnumber_pcnt
          ,le.populated_transfercertificateoftitle_pcnt
          ,le.populated_hi_condo_cpr_hpr_pcnt
          ,le.populated_hi_situs_unit_number_pcnt
          ,le.populated_hids_previous_docnumber_pcnt
          ,le.populated_prevtransfercertificateoftitle_pcnt
          ,le.populated_pid_pcnt
          ,le.populated_matchedororphan_pcnt
          ,le.populated_deed_pid_pcnt
          ,le.populated_sam_pid_pcnt
          ,le.populated_assessorparcelnumber_matched_pcnt
          ,le.populated_assessorpropertyfulladd_pcnt
          ,le.populated_assessorpropertyunittype_pcnt
          ,le.populated_assessorpropertyunit_pcnt
          ,le.populated_assessorpropertycity_pcnt
          ,le.populated_assessorpropertystate_pcnt
          ,le.populated_assessorpropertyzip_pcnt
          ,le.populated_assessorpropertyzip4_pcnt
          ,le.populated_assessorpropertyaddrsource_pcnt
          ,le.populated_raw_file_name_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,67,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_BKMortgage_Release));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),67,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_BKMortgage_Release) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_BKMortgage_Release, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
