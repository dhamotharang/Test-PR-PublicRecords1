IMPORT DueDiligence, iesp;


EXPORT InternalBusiness := MODULE

    EXPORT BusinessIdentifiers := RECORD
      UNSIGNED6 seq;
      UNSIGNED6 ultID;
      UNSIGNED6 orgID;
      UNSIGNED6 seleID;
      UNSIGNED6 proxID;
      UNSIGNED6 powID;      
    END;

    EXPORT SlimBestSearch := RECORD
      UNSIGNED6 seq;
      UNSIGNED6 inquiredBusiness;
      DueDiligence.v3Layouts.Internal.SlimBusiness;
      UNSIGNED4 historyDate;
      UNSIGNED2 lexIDScore;
    END;
    
    EXPORT BusinessAttributes := RECORD
      BusinessIdentifiers;
      DueDiligence.v3Layouts.DDOutput.BusAttributes;
    END; 
    
    EXPORT BusinessBEO := RECORD
      BusinessIdentifiers;
      UNSIGNED6 beoLexID;
    END;
    
    EXPORT BusinessReport := RECORD
      BusinessIdentifiers;
      iesp.duediligencebusinessreport.t_DDRBusinessReport businessReport;
    END;
    
    
    EXPORT BusinessResults := RECORD
      BusinessIdentifiers;
      BOOLEAN legalReportIncluded;
      BOOLEAN economicReportIncluded;
      BOOLEAN operatingReportIncluded;
      BOOLEAN networkReportIncluded;
      DueDiligence.v3Layouts.DDOutput.BusAttributes;
      iesp.duediligencebusinessreport.t_DDRBusinessResult report;
    END;


END;