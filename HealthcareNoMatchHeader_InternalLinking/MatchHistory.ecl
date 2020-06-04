/*HACK-O-MATIC*/IMPORT SALT311,HealthcareNoMatchHeader_Ingest,STD;
/*HACK-O-MATIC*/EXPORT MatchHistory(STRING pSrc, STRING pVersion =  (STRING)STD.Date.Today()) := MODULE
EXPORT id_shift_r := RECORD
    SALT311.UIDType RID;
    SALT311.UIDType nomatch_id_before;
    SALT311.UIDType nomatch_id_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := /*HACK-O-MATIC*/HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Linking().Changes.QA;
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := /*HACK-O-MATIC*/HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).DebugKeys.History_Match.new;
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{nomatch_id_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;
