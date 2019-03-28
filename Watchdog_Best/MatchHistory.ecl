IMPORT SALT311;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT311.UIDType rid;
    SALT311.UIDType did_before;
    SALT311.UIDType did_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::Watchdog_best::did::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history

EXPORT MatchHistoryKeyName := '~'+'key::Watchdog_best::did::History::Match';

EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{did_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;
