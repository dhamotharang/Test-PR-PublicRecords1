IMPORT SALT37;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT37.UIDType rcid;
    SALT37.UIDType seleid_before;
    SALT37.UIDType seleid_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::Equifax_Business_Data::seleid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::Equifax_Business_Data::seleid::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{seleid_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;

