IMPORT DueDiligence, iesp;

/*
  Layouts Related to Legal Data
*/
EXPORT InternalPersonLegal := MODULE

    
    EXPORT DOCSpecificDetails := RECORD
      UNSIGNED4 DOCConvictionOverrideDate;
      UNSIGNED4 DOCScheduledReleaseDate;
      UNSIGNED4 DOCActualReleaseDate;
      STRING50 DOCInmateStatus;
      STRING50 DOCParoleStatus;
      STRING30 maxTerm;
      BOOLEAN currentlyIncarcerated;
      BOOLEAN currentlyParoled;
      BOOLEAN currentlyProbation;
      BOOLEAN previouslyIncarcerated;
      UNSIGNED4 DOCParoleActualReleaseDate;
      UNSIGNED4 DOCParolePresumptiveReleaseDate;
      UNSIGNED4 DOCParoleScheduledReleaseDate;
      STRING50 DOCParoleCurrentStatus;
      STRING50 DOCCurrentKnownInmateStatus;
      STRING25 DOCCurrentLocationSecurity;
    END;
    
    EXPORT NONDOCSpecificDetails := RECORD
      UNSIGNED4 appealDate;
      UNSIGNED4 courtDispDate;
      STRING50 courtDisposition1;
      STRING50 courtDisposition2;
    END;
    
    EXPORT CrimCalcFields := RECORD
      STRING1 offenseScore;
      STRING5 offenseLevel;
      STRING8 offenseDate;
      STRING50 parole;
      STRING50 probation;
      STRING120 partyName;
      UNSIGNED4 calcdFirstSeen;
      UNSIGNED4 incarAdmitDate;
      UNSIGNED4 sentenceEndDate;
      UNSIGNED6 category;
    END;
    
    EXPORT CrimSourceDetails := RECORD
      UNSIGNED4 reportedDate;
      STRING75 charge;
      STRING1 conviction;
      UNSIGNED4 arrestDate;
      UNSIGNED4 sentenceDate;
      UNSIGNED4 sentenceStartDate;
      DATASET({STRING120 name}) partyNames;
      STRING35 chargeLevelReported;
      DOCSpecificDetails;
      NONDOCSpecificDetails;
    END;
    
    EXPORT CrimDetails := RECORD
      UNSIGNED6 did;
      UNSIGNED4 historyDate;
      STRING75 offenderKey;
      STRING35 sortKey;
      
      //Any source have any of the following
      BOOLEAN sourceContainsIncarceration;
      BOOLEAN sourceContainsParoled;
      BOOLEAN sourceContainsProbation;
      BOOLEAN sourceContainsPrevIncarceration;
      
      //Top Level Data
      STRING2 state;
      STRING25 source;
      STRING35 caseNumber;
      STRING35 offenseStatute;
      UNSIGNED4 offenseDDFirstReportedActivity;
      UNSIGNED4 offenseDDLastReportedActivity;
      UNSIGNED4 offenseDDLastCourtDispDate;
      UNSIGNED2 offenseTypeLevel;
      STRING100 offenseTypeDescription;
      UNSIGNED3 offenseTypeID;
      STRING75 offenseCharge;
      STRING1 offenseDDChargeLevelCalculated;
      STRING35 offenseChargeLevelReported; 
      STRING1 offenseConviction;
      STRING25 offenseIncarcerationProbationParole; //DOC Overall Status;
      STRING1 offenseTrafficRelated;

      //Additional details
      STRING county;
      STRING50 countyCourt;
      STRING25 city;
      STRING50 agency;
      STRING30 race;
      STRING1 sex;
      STRING15 hairColor;
      STRING5 eyeColor;
      STRING3 height;
      STRING3 weight;
      
      //Supporting source detail for the offense
      CrimSourceDetails det;
      DATASET(iesp.duediligenceshared.t_DDRLegalSourceInfo) details {MAXCOUNT(DueDiligence.Constants.MAX_PARENTS)};
      
      //additional fields to be used in calculations
      CrimCalcFields additionalCalcDetails;
    END;
    
    EXPORT FinalCrimData := RECORD
      UNSIGNED6 did;
      UNSIGNED4 historyDate;
      UNSIGNED4 ddFirstReportedActivity;
      BOOLEAN currentlyIncarcerated;
      BOOLEAN currentlyParoled;
      BOOLEAN currentlyProbation;
      BOOLEAN prevIncarcerated;
      iesp.duediligenceshared.t_DDRLegalStateCriminal;
    END;

END;