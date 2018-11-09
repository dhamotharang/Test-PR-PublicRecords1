IMPORT SALT37;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT37.UIDType rid;
    SALT37.UIDType LocId_before;
    SALT37.UIDType LocId_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::LocationId_iLink::LocId::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::LocationId_iLink::LocId::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{LocId_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;

