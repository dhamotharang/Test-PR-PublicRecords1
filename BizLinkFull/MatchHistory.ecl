IMPORT SALT311;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT311.UIDType rcid;
    SALT311.UIDType proxid_before;
    SALT311.UIDType proxid_after;
    SALT311.UIDType seleid_before;
    SALT311.UIDType seleid_after;
    SALT311.UIDType orgid_before;
    SALT311.UIDType orgid_after;
    SALT311.UIDType ultid_before;
    SALT311.UIDType ultid_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::BizLinkFull::proxid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::BizLinkFull::proxid::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{proxid_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;
