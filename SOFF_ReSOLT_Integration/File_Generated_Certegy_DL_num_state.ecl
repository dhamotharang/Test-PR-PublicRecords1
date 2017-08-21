
Layout_BestDL.Layout_Best_Certegy_DL_num_state Get_Certegy_DL_Num_state(Files_used.certegy_layout_base L) := TRANSFORM
SELF:= L;
END;

DL_Num_state := PROJECT(Files_used.certegy_base_File, Get_Certegy_DL_Num_state(LEFT));
D_DL_Num_state := DISTRIBUTE(DL_Num_state, HASH(did));

export File_Generated_Certegy_DL_num_state := D_DL_Num_state : persist('persist::IMAP::File_Certegy_DL'); ;

