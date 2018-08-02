IMPORT SALT37;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT37.UIDType RID;
    SALT37.UIDType DID_before;
    SALT37.UIDType DID_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::InsuranceHeader_RemoteLinking::DID::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::InsuranceHeader_RemoteLinking::DID::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{DID_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;

