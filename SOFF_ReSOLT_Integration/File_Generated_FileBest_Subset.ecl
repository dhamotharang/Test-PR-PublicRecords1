	D_File_best                        := DISTRIBUTE(Files_Used.Watchdog_File_Best,HASH(did));
	
Layout_unq_DID := RECORD
  Files_Used.watchdog_Layout_best.did;
end;

  // Unq_DID_list := PROJECT(SOFF_ReSOLT_Integration.File_Generated_UNQ_PK_DID_Plus_Relatives,Layout_unq_DID);
  // S_unq_DID_List := SORT(Unq_DID_list,DID, LOCAL);
  // S_Unq_DID_List_dedup := DEDUP(S_unq_DID_List,DID,LOCAL);
  Files_Used.watchdog_Layout_best Join_DID_BestFile (Layout_unq_DID L, Files_Used.watchdog_Layout_best R) := TRANSFORM
    
    SELF:=R;
	
  end;
	  
  J_WatchDog_subset   := JOIN( File_Generated_UNQ_did,D_File_best, 
                               LEFT.did = RIGHT.did ,
							   Join_DID_BestFile(LEFT,RIGHT),LOCAL);
																	
export File_Generated_FileBest_Subset := J_WatchDog_subset : persist ('persist::IMAP::Watchdog_FileBest_Subset');