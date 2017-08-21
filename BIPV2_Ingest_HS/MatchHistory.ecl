IMPORT SALT35;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT35.UIDType rcid;
    SALT35.UIDType DOTid_before;
    SALT35.UIDType DOTid_after;
    UNSIGNED4 change_date;
  END;
EXPORT MatchHistoryName := '~keep::BIPV2_Ingest_HS::DOTid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::BIPV2_Ingest_HS::DOTid::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{DOTid_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;

