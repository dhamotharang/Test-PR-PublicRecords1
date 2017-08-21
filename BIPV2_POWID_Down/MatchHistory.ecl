IMPORT SALT35;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT35.UIDType rcid;
    SALT35.UIDType POWID_before;
    SALT35.UIDType POWID_after;
    UNSIGNED4 change_date;
  END;
EXPORT MatchHistoryName := '~keep::BIPV2_POWID_Down::POWID::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::BIPV2_POWID_Down::POWID::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{POWID_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;

