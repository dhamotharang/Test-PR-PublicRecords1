IMPORT SALT36;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT36.UIDType rcid;
    SALT36.UIDType _before;
    SALT36.UIDType _after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::tris_lnssi_ingest::::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::tris_lnssi_ingest::::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;

