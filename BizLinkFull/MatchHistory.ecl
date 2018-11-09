IMPORT SALT37;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT37.UIDType rcid;
    SALT37.UIDType proxid_before;
    SALT37.UIDType proxid_after;
    SALT37.UIDType seleid_before;
    SALT37.UIDType seleid_after;
    SALT37.UIDType orgid_before;
    SALT37.UIDType orgid_after;
    SALT37.UIDType ultid_before;
    SALT37.UIDType ultid_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::BizLinkFull::proxid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::BizLinkFull::proxid::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{proxid_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;
