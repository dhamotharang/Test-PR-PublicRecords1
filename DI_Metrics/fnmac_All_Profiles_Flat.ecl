/*
fnmac_All_Profiles_Flat functionmacro returs All Profiles Salt report in a flat normalized data format.  
*/ 

EXPORT fnmac_All_Profiles_Flat(infile) := FUNCTIONMACRO
// 1. Infile refers to the file to runt he Salt Profile on. 
// SALT311.MAC_Profile(eval_file_combined,,,0,,0); // Here is the macro we usually call.

// 2. Instead of calling the SALT profile macro, call instead the module referenced in 
// the macro above, so we have access to the AllProfiles report on our terms.
modProfile := SALT311.MOD_Profile(infile,,,0,,0); 

// 3. Convert all values in the AllProfiles report to STRINGs; else any blanks will be
// converted to zeroes in the flat layout. Blank values ought to remain blank.

// The following layouts from SALT311.MAC_Character_Counts are SHARED (not EXPORTable), so
// we need to copy them here to use them in this script:

Length_Layout_old := record
  unsigned2 len;
  unsigned  cnt;
  REAL pcnt;  
end;
  
Words_Layout_old := record
  unsigned2 words;
  unsigned  cnt;
  REAL pcnt;  
end;
  
Character_Layout_old := record
  SALT311.CharType c;
  unsigned cnt;
  REAL pcnt;  
end;  
  
Pattern_Layout_old := record
  SALT311.StrType data_pattern {maxlength(200000)};
  unsigned cnt;
  REAL pcnt;
end;
  
Value_Layout_old := record
  SALT311.StrType val  {maxlength(200000)};
  unsigned cnt;
  REAL pcnt;
end;

// 3a. Define an identical layout for AllProfiles dataset, but specify STRINGs for all fields.
Length_Layout := RECORD
  STRING len;
  STRING cnt;
  STRING pcnt;  
END;
  
Words_Layout := RECORD
  STRING words;
  STRING cnt;
  STRING pcnt;  
END;
  
Character_Layout := RECORD
  STRING c;
  STRING cnt;
  STRING pcnt;  
END;  
  
Pattern_Layout := RECORD
  STRING data_pattern {MAXLENGTH(200000)};
  STRING cnt;
  STRING pcnt;
END;
  
Value_Layout := RECORD
  STRING val  {MAXLENGTH(200000)};
  STRING cnt;
  STRING pcnt;
END;

MaxChars := 256;
MaxExamples := 300;

ResultLine_Layout_As_STRING := RECORD
  STRING FldNo;
  STRING FieldName;
  STRING Cardinality;
  STRING MinVal30;
  STRING MaxVal30;
  STRING AsNumber_MinVal;
  STRING AsNumber_MaxVal;
  STRING AsNumber_Mean;
  STRING AsNumber_Var;
  DATASET(Length_Layout)    Len {MAXCOUNT(MaxChars)} := DATASET([],Length_Layout);
  DATASET(Words_Layout)     Words {MAXCOUNT(MaxChars)} := DATASET([],Words_Layout);
  DATASET(Character_Layout) Characters {MAXCOUNT(MaxChars)} := DATASET([],Character_Layout);
  DATASET(Pattern_Layout)   Patterns {MAXCOUNT(MaxExamples)}:= DATASET([],Pattern_Layout);
  DATASET(Value_Layout)     Frequent_Terms {MAXCOUNT(MaxExamples)}:= DATASET([],Value_Layout);
END;

// 3b. Project AllProfiles dataset into ResultLine_Layout_As_STRING layout.

Length_Layout xfm_Len_childDataset_to_STRING( Length_Layout_old le ) :=
  TRANSFORM
    SELF.len  := TRIM((STRING)le.len);
    SELF.cnt  := TRIM((STRING)le.cnt);
    SELF.pcnt := TRIM((STRING)le.pcnt);  
  END;

Words_Layout xfm_Words_childDataset_to_STRING( Words_Layout_old le ) :=
  TRANSFORM
    SELF.words := TRIM((STRING)le.words);
    SELF.cnt   := TRIM((STRING)le.cnt);
    SELF.pcnt  := TRIM((STRING)le.pcnt);  
  END;

Character_Layout xfm_Characters_childDataset_to_STRING( Character_Layout_old le ) :=
  TRANSFORM
    SELF.c    := TRIM((STRING)le.c);
    SELF.cnt  := TRIM((STRING)le.cnt);
    SELF.pcnt := TRIM((STRING)le.pcnt);  
  END;

Pattern_Layout xfm_Patterns_childDataset_to_STRING( Pattern_Layout_old le ) :=
  TRANSFORM
    SELF.data_pattern  := TRIM((STRING)le.data_pattern);
    SELF.cnt           := TRIM((STRING)le.cnt);
    SELF.pcnt          := TRIM((STRING)le.pcnt);  
  END;

Value_Layout xfm_FrequentTerms_childDataset_to_STRING( Value_Layout_old le ) :=
  TRANSFORM
    SELF.val  := TRIM((STRING)le.val);
    SELF.cnt  := TRIM((STRING)le.cnt);
    SELF.pcnt := TRIM((STRING)le.pcnt);  
  END;

ResultLine_Layout_As_STRING xfm_As_STRING( SALT311.MAC_Character_Counts.ResultLine_Layout le ) :=
  TRANSFORM
    SELF.FldNo           := TRIM((STRING)le.FldNo);
    SELF.FieldName       := TRIM((STRING)le.FieldName);
    SELF.Cardinality     := TRIM((STRING)le.Cardinality);
    SELF.MinVal30        := TRIM((STRING)le.MinVal30);
    SELF.MaxVal30        := TRIM((STRING)le.MaxVal30);
    SELF.AsNumber_MinVal := TRIM((STRING)le.AsNumber_MinVal);
    SELF.AsNumber_MaxVal := TRIM((STRING)le.AsNumber_MaxVal);
    SELF.AsNumber_Mean   := TRIM((STRING)le.AsNumber_Mean);
    SELF.AsNumber_Var    := TRIM((STRING)le.AsNumber_Var);
    SELF.Len             := PROJECT( le.Len           , xfm_Len_childDataset_to_STRING(LEFT) );
    SELF.Words           := PROJECT( le.Words         , xfm_Words_childDataset_to_STRING(LEFT) );
    SELF.Characters      := PROJECT( le.Characters    , xfm_Characters_childDataset_to_STRING(LEFT) );
    SELF.Patterns        := PROJECT( le.Patterns      , xfm_Patterns_childDataset_to_STRING(LEFT) );
    SELF.Frequent_Terms  := PROJECT( le.Frequent_Terms, xfm_FrequentTerms_childDataset_to_STRING(LEFT) );
  END;

AllProfiles_As_STRING := PROJECT( modProfile.AllProfiles, xfm_As_STRING(LEFT) );

// 4. Finally, project AllProfiles_As_STRING into a flat layout.

Layout_utterlyFlat := RECORD
  STRING FldNo;
  STRING FieldName;
  STRING Cardinality;
  STRING MinVal30;
  STRING MaxVal30;
  STRING AsNumber_MinVal;
  STRING AsNumber_MaxVal;
  STRING AsNumber_Mean;
  STRING AsNumber_Var;
  // formerly:  DATASET(Length_Layout)    Len {MAXCOUNT(MaxChars)} := DATASET([],Length_Layout);
  STRING len__len;
  STRING len__cnt;
  STRING len__pcnt;  
  // formerly:  DATASET(Words_Layout)     Words {MAXCOUNT(MaxChars)} := DATASET([],Words_Layout);
  STRING words__words;
  STRING words__cnt;
  STRING words__pcnt;
  // formerly:  DATASET(Character_Layout) Characters {MAXCOUNT(MaxChars)} := DATASET([],Character_Layout);
  STRING char__c;
  STRING char__cnt;
  STRING char__pcnt;  
  // formerly:  DATASET(Pattern_Layout)   Patterns {MAXCOUNT(MaxExamples)}:= DATASET([],Pattern_Layout);
  STRING patt__data_pattern {MAXLENGTH(200000)};
  STRING patt__cnt;
  STRING patt__pcnt;
  // formerly:  DATASET(Value_Layout)   Frequent_Terms {MAXCOUNT(MaxExamples)}:= DATASET([],Value_Layout);
  STRING val__val {MAXLENGTH(200000)};
  STRING val__cnt;
  STRING val__pcnt;
END;

Layout_utterlyFlat xfm_toUtterlyFlat( ResultLine_Layout_As_STRING le, INTEGER c ) :=
  TRANSFORM
    SELF.FldNo           := le.FldNo; // Write FldNo to each row since it's our record identifier.
    SELF.FieldName       := le.FieldName;
    SELF.Cardinality     := le.Cardinality;
    SELF.MinVal30        := le.MinVal30;
    SELF.MaxVal30        := le.MaxVal30;
    SELF.AsNumber_MinVal := le.AsNumber_MinVal;
    SELF.AsNumber_MaxVal := le.AsNumber_MaxVal;
    SELF.AsNumber_Mean   := le.AsNumber_Mean;
    SELF.AsNumber_Var    := le.AsNumber_Var;
    SELF.len__len        := le.Len[c].len;
    SELF.len__cnt        := le.Len[c].cnt;
    SELF.len__pcnt       := le.Len[c].pcnt;  
    SELF.words__words    := le.Words[c].words;
    SELF.words__cnt      := le.Words[c].cnt;
    SELF.words__pcnt     := le.Words[c].pcnt;
    SELF.char__c         := le.Characters[c].c;
    SELF.char__cnt       := le.Characters[c].cnt;
    SELF.char__pcnt      := le.Characters[c].pcnt;  
    SELF.patt__data_pattern := le.Patterns[c].data_pattern;
    SELF.patt__cnt       := le.Patterns[c].cnt;
    SELF.patt__pcnt      := le.Patterns[c].pcnt;
    SELF.val__val        := le.Frequent_Terms[c].val;
    SELF.val__cnt        := le.Frequent_Terms[c].cnt;
    SELF.val__pcnt       := le.Frequent_Terms[c].pcnt;
  END;
  

AllProfiles_utterlyFlat := 
  NORMALIZE(
    AllProfiles_As_STRING,
    MAX(
      COUNT(LEFT.Len),
      COUNT(LEFT.Words),
      COUNT(LEFT.Characters),
      COUNT(LEFT.Patterns),
      COUNT(LEFT.Frequent_Terms)
    ),
    xfm_toUtterlyFlat(LEFT,COUNTER)
  );

//filename := '~tracesmart::data_insight::SALT_AllProfiles::'+ds_name;

// OUTPUT( modProfile.AllProfiles, NAMED('AllProfiles_orig'), ALL );
// OUTPUT( AllProfiles_As_STRING , NAMED('AllProfiles_As_STRING'), ALL );
// OUTPUT( AllProfiles_utterlyFlat, NAMED('AllProfiles_utterlyFlat'), ALL );
//OUTPUT( AllProfiles_utterlyFlat, , filename, thor, overwrite, compressed);
 
  
 
RETURN AllProfiles_utterlyFlat;


ENDMACRO;

