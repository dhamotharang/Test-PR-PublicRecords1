IMPORT DueDiligence, iesp;


EXPORT InternalPerson := MODULE

    EXPORT SlimBestSearch := RECORD
      UNSIGNED6 seq;
      UNSIGNED6 inquiredLexID;
      DueDiligence.v3Layouts.Internal.SlimPerson;
      UNSIGNED4 historyDate;
      UNSIGNED2 lexIDScore;
    END;
    
    EXPORT SlimRelationshipLayout := RECORD
      UNSIGNED6 did1;
      UNSIGNED6 did2;
      UNSIGNED1 title;
      INTEGER1 sourceType;
      STRING10 relationshipType;
      STRING10 confidence;
    END;
    
    EXPORT SlimPersonDetails := RECORD
      UNSIGNED6 seq;
      UNSIGNED6 inquiredDID;
      DueDiligence.v3Layouts.Internal.SlimPerson;
      STRING2 relationToInquired;
      UNSIGNED historyDate;
    END;
    
    
    EXPORT PersonAttributes := RECORD
      UNSIGNED6 seq;
      UNSIGNED6 lexID;
      DueDiligence.v3Layouts.DDOutput.PerAttributes;
    END; 
    
    EXPORT PersonReport := RECORD
      UNSIGNED6 seq;
      UNSIGNED6 lexID;
      iesp.duediligencepersonreport.t_DDRPersonReport personReport;
    END;
    
    EXPORT PersonResults := RECORD
      UNSIGNED6 seq;
      UNSIGNED6 lexID;
      UNSIGNED2 lexIDScore;
      BOOLEAN legalReportIncluded;
      BOOLEAN economicReportIncluded;
      BOOLEAN geographicReportIncluded;
      BOOLEAN identityReportIncluded;
      BOOLEAN networkReportIncluded;
      DueDiligence.v3Layouts.DDOutput.PerAttributes;
      iesp.duediligencepersonreport.t_DDRPersonReport personReport;
    END;
    
END;