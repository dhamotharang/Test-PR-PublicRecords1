IMPORT DueDiligence, iesp;


EXPORT InternalBusinessIndustry := MODULE

    EXPORT IndustrySlim := RECORD
      DueDiligence.v3Layouts.InternalShared.InternalIDs -did;
      UNSIGNED4 historyDate;
      UNSIGNED4 dateFirstSeen;
      UNSIGNED4 dateLastSeen;
      STRING8 sicCode;
      STRING80 sicDesc;
      STRING6 naicsCode;
      STRING120 naicsDesc;
      BOOLEAN isBest;
      STRING5 sicIndustry;
      STRING7 sicRiskLevel;
      STRING5 naicsIndustry;
      STRING7 naicsRiskLevel;
      UNSIGNED1 riskiestOverallLevel;
    END;
    
    EXPORT IndustryReport := RECORD
      DueDiligence.v3Layouts.InternalShared.InternalIDs -did;
      DATASET(iesp.duediligencebusinessreport.t_DDRSICNAIC) sicNaicsData;
    END;

END;