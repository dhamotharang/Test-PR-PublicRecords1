IMPORT SALT311;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT311.UIDType RID;
    SALT311.UIDType ADDRESS_GROUP_ID_before;
    SALT311.UIDType ADDRESS_GROUP_ID_after;
    UNSIGNED6 change_date;
  END;
EXPORT MatchHistoryName := '~keep::InsuranceHeader_Address::ADDRESS_GROUP_ID::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::History::Match';
 
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{ADDRESS_GROUP_ID_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;
