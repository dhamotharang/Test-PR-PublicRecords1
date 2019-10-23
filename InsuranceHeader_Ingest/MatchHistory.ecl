IMPORT SALT37;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT37.UIDType RID;
    SALT37.UIDType Did_before;
    SALT37.UIDType Did_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::InsuranceHeader_Ingest::Did::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
EXPORT MatchHistoryKeyName := '~'+'key::InsuranceHeader_Ingest::Did::History::Match';
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{Did_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;

