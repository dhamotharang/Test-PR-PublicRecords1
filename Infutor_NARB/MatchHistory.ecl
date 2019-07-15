IMPORT SALT34;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT34.UIDType rcid;
    SALT34.UIDType seleid_before;
    SALT34.UIDType seleid_after;
    UNSIGNED4 change_date;
  END;
EXPORT MatchHistoryName := '~keep::infutor_narb::seleid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::infutor_narb::seleid::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{seleid_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;

