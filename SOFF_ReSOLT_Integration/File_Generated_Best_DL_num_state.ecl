
Layout_BestDL.Layout_Best_FileDL_DL_num_state Get_DL_Num_state(Files_used.driversV2_Layout_DL L) := TRANSFORM
SELF := L;
END;

DL_Num_state := PROJECT(Files_used.Drivers2_File_Dl(did <> 0), Get_DL_Num_state(LEFT));
D_DL_Num_state := DISTRIBUTE(DL_Num_state, HASH(did));

DS_DL_Num_state := SORT(D_DL_Num_state, did,dl_number, history, -dt_last_seen, -dt_first_seen, LOCAL);
DSD_DL_Num_state := DEDUP(DS_DL_Num_state, did,dl_number, LOCAL);

 
export File_Generated_Best_DL_num_state := DSD_DL_Num_state : persist('persist::IMAP::Dl2::Drvlic_File');