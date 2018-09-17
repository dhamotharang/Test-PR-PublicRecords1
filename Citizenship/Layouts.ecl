EXPORT Layouts := MODULE
    
    EXPORT Indicators := RECORD
      INTEGER7 lexID;
      INTEGER2 identityAge;
      INTEGER2 emergenceAgeHeader;
      INTEGER2 emergenceAgeBureau;
      INTEGER2 ssnIssuanceAge;
      INTEGER2 ssnIssuanceYears;
      INTEGER2 relativeCount;
      INTEGER2 ver_voterRecords;
      INTEGER2 ver_insuranceRecords;
      INTEGER2 ver_studentFile;
      INTEGER2 firstSeenAddr10;
      INTEGER2 reportedCurAddressYears;
      INTEGER2 addressFirstReportedAge;
      INTEGER2 timeSinceLastReportedNonBureau;
      INTEGER2 inputSSNRandomlyIssued;
      INTEGER2 inputSSNRandomIssuedInvalid;
      INTEGER2 inputSSNIssuedToNonUS;
      INTEGER2 inputSSNITIN;
      INTEGER2 inputSSNInvalid;
      INTEGER2 inputSSNIssuedPriorDOB;
      INTEGER2 inputSSNAssociatedMultLexIDs;
      INTEGER2 inputSSNReportedDeceased;
      INTEGER2 inputSSNNotPrimaryLexID;
      INTEGER2 lexIDBestSSNInvalid;
      INTEGER2 lexIDReportedDeceased;
      INTEGER2 lexIDMultipleSSNs;
      INTEGER2 inputComponentDivRisk;
    END;
    
    EXPORT LayoutScoreAndIndicators  := RECORD
      STRING3 citizenshipScore;
      Indicators;
    END;
    
    //Used in conjunction with Due Diligence Input
    //but specific to Citizenship
    EXPORT Input := RECORD
      STRING15 modelName;
      STRING14 phone2;
      STRING20 dlNumber;
      STRING2 dlState;
    END;
    
    //Citizenship Model Layout
    EXPORT ModelOutput_Layout := RECORD
      UNSIGNED4 seq;   
      STRING3 citizenshipScore;
    END;
    
    EXPORT IndicatorLayout := RECORD
      UNSIGNED4 seq;
      UNSIGNED4 inputSeq;
      STRING30 acctNo;
      Indicators;
    END;
    
END;