IMPORT DueDiligence, iesp;


EXPORT InternalShared := MODULE

    
    EXPORT InternalIDs := RECORD
      UNSIGNED6 seq;
      UNSIGNED6 ultID;
      UNSIGNED6 orgID;
      UNSIGNED6 seleID;
      UNSIGNED6 did;
    END;
    
    
    //Liens, Judgements, Evictions - Civil Events
    EXPORT LiensJudgementsEvictions := RECORD
      InternalIDs; 
      UNSIGNED4 historyDate;
      STRING50 rmsid;
      STRING50 tmsid;
      iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions espDetails;
      UNSIGNED4 dateFirstSeen;
      UNSIGNED4 dateLastSeen;
      UNSIGNED4 releaseDate;
      UNSIGNED4 filingDate;
      STRING2 state;
      STRING3 county;
      STRING1 nameType;
      UNSIGNED6 partyLexID; 
    END;
    
    EXPORT Bankruptcies := RECORD
      InternalIDs; 
      UNSIGNED4 historyDate;
      UNSIGNED4 dateFirstSeen;
      UNSIGNED4 dateLastSeen;
      UNSIGNED4 filingDate;
      STRING35 disposition;
      BOOLEAN dismissed;
      STRING50 tmsid;
      STRING7 caseNumber;
    END;
    
    
    //Criminal & Civil Report Sections
    EXPORT ReportSharedLegal := RECORD
      InternalIDs; 
      DATASET(iesp.duediligenceshared.t_DDRLegalStateCriminal) criminals {MAXCOUNT(iesp.constants.DDRAttributesConst.MaxLegalEvents)};
      DATASET(iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions) liensJudgementsEvictions {MAXCOUNT(iesp.constants.DDRAttributesConst.MaxLienJudgementsEvictions)};
    END;

END;