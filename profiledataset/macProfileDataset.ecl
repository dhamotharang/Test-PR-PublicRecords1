EXPORT macProfileDataset(dIn) := FUNCTIONMACRO
  IMPORT SALT36;
  #UNIQUENAME(mod)
	%mod% := MODULE
    SHARED modProfileDataset := SALT36.MOD_Profile(dIn);
    SHARED dAllProfiles      := modProfileDataset.AllProfiles;
    
    SHARED FieldIdentification := RECORD
      UNSIGNED2 FieldNumber;
      STRING    FieldName;
    END;
    
    dInvSummary      := modProfileDataset.invSummary;
    
    rProfile := RECORD
      FieldIdentification;
      UNSIGNED NumberOfRecords;
      REAL8  PopulatedPercent;
      UNSIGNED  MaxLength;
      REAL8  AveLength;
      UNSIGNED Cardinality;
      STRING30 MinVal30;
      STRING30 MaxVal30;
      REAL8 AsNumberMinVal;
      REAL8 AsNumberMaxVal;
      REAL8 AsNumberMean;
      REAL8 AsNumberVar;
    END;
    EXPORT dProfile := JOIN(dAllProfiles, dInvSummary,
      LEFT.FldNo = RIGHT.FldNo,
      TRANSFORM(rProfile,
        SELF.FieldNumber      := LEFT.FldNo,
        SELF.AsNumberMinVal   := LEFT.AsNumber_MinVal,
        SELF.AsNumberMaxVal   := LEFT.AsNumber_MaxVal,
        SELF.AsNumberMean     := LEFT.AsNumber_Mean,
        SELF.AsNumberVar      := LEFT.AsNumber_Var,
        SELF.PopulatedPercent := RIGHT.populated_pcnt,
        SELF := LEFT,
        SELF := RIGHT),
      KEEP(1));
        
    rLength := RECORD
      FieldIdentification;
      UNSIGNED2 FieldLength;
      UNSIGNED  RecordCount;
      REAL Percent;
    END;
    EXPORT dLength := NORMALIZE(dAllProfiles,LEFT.Len,
      TRANSFORM(rLength, 
        SELF.FieldNumber  := LEFT.FldNo,
        SELF.FieldName    := LEFT.FieldName,
        SELF.FieldLength  := RIGHT.len,
        SELF.RecordCount := RIGHT.cnt,
        SELF.Percent      := RIGHT.pcnt));

    rWords := RECORD
      FieldIdentification;
      UNSIGNED2 WordCounts;
      UNSIGNED  RecordCount;
      REAL Percent;
    END;
    EXPORT dWords := NORMALIZE(dAllProfiles,LEFT.Words,
      TRANSFORM(rWords, 
        SELF.FieldNumber  := LEFT.FldNo,
        SELF.FieldName    := LEFT.FieldName,
        SELF.WordCounts   := RIGHT.words,
        SELF.RecordCount  := RIGHT.cnt,
        SELF.Percent      := RIGHT.pcnt));

    rChar := RECORD
      FieldIdentification;
      STRING1 Character;
      UNSIGNED RecordCount;
      REAL Percent;	
    END;
    EXPORT dCharacters := NORMALIZE(dAllProfiles,LEFT.Characters,
      TRANSFORM(rChar, 
        SELF.FieldNumber  := LEFT.FldNo,
        SELF.FieldName    := LEFT.FieldName,
        SELF.Character    := RIGHT.c,
        SELF.RecordCount  := RIGHT.cnt,
        SELF.Percent      := RIGHT.pcnt));

    rPattern := RECORD
      FieldIdentification;
      STRING DataPattern {maxlength(200000)};
      UNSIGNED RecordCount;
      REAL Percent;
    END;
    EXPORT dPatterns := NORMALIZE(dAllProfiles,LEFT.Patterns,
      TRANSFORM(rPattern, 
        SELF.FieldNumber  := LEFT.FldNo,
        SELF.FieldName    := LEFT.FieldName,
        SELF.DataPattern  := RIGHT.data_pattern,
        SELF.RecordCount := RIGHT.cnt,
        SELF.Percent      := RIGHT.pcnt));

    rValue := RECORD
      FieldIdentification;
      STRING Value {maxlength(200000)};
      UNSIGNED RecordCount;
      REAL Percent;
    END;
    EXPORT dValue := NORMALIZE(dAllProfiles,LEFT.Frequent_Terms,
      TRANSFORM(rValue, 
        SELF.FieldNumber  := LEFT.FldNo,
        SELF.FieldName    := LEFT.FieldName,
        SELF.Value        := RIGHT.val,
        SELF.RecordCount  := RIGHT.cnt,
        SELF.Percent      := RIGHT.pcnt));
  END;
  RETURN %mod%;
ENDMACRO;
