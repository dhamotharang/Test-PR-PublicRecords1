Layout_unq_DID := RECORD
  Files_Used.watchdog_Layout_best.did;
end;
  Unq_DID_list := PROJECT(SOFF_ReSOLT_Integration.File_Generated_UNQ_PK_DID_Plus_Relatives,Layout_unq_DID);
  S_unq_DID_List := SORT(Unq_DID_list,DID, LOCAL);
  S_Unq_DID_List_dedup := DEDUP(S_unq_DID_List,DID,LOCAL);
  
export File_Generated_UNQ_did := S_Unq_DID_List_dedup : persist('persist::imap::File_Gen_Unq_DID');;