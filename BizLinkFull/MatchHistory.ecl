IMPORT SALT44;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT44.UIDType rcid;
    SALT44.UIDType proxid_before;
    SALT44.UIDType proxid_after;
    SALT44.UIDType seleid_before;
    SALT44.UIDType seleid_after;
    SALT44.UIDType orgid_before;
    SALT44.UIDType orgid_after;
    SALT44.UIDType ultid_before;
    SALT44.UIDType ultid_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::BizLinkFull::proxid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::BizLinkFull::proxid::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{proxid_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;
