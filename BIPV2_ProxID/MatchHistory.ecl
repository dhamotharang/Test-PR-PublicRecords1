IMPORT SALT37;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT37.UIDType rcid;
    SALT37.UIDType Proxid_before;
    SALT37.UIDType Proxid_after;
    SALT37.UIDType lgid3_before;
    SALT37.UIDType lgid3_after;
    SALT37.UIDType orgid_before;
    SALT37.UIDType orgid_after;
    SALT37.UIDType ultid_before;
    SALT37.UIDType ultid_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::BIPV2_ProxID::Proxid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::BIPV2_ProxID::Proxid::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{Proxid_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;

