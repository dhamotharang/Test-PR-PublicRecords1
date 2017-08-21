IMPORT SALT34;
EXPORT MatchHistory := MODULE
EXPORT id_shift_r := RECORD
    SALT34.UIDType rid;
    SALT34.UIDType DPROPTXID_before;
    SALT34.UIDType DPROPTXID_after;
    UNSIGNED4 change_date;
  END;
EXPORT MatchHistoryName := '~keep::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,id_shift_r,THOR); // Read in all the change history
EXPORT MatchHistoryKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::History::Match';
EXPORT MatchHistoryKey := INDEX(MatchHistoryFile,{DPROPTXID_after},{MatchHistoryFile},MatchHistoryKeyName);
EXPORT BuildAll := BUILDINDEX(MatchHistoryKey, OVERWRITE);
END;

