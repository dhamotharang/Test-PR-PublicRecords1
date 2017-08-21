Layout_UNQ_PK_DID_Plus_Relatives Add_relative_flag(Layout_Persistent_KeyFile L) := TRANSFORM
  SELF.relative_flag :=0;
	SELF := L;
end;

 PK_DID_with_relative_flag := PROJECT(File_Generated_PKFile.withDID(name_type = '0'),Add_relative_flag(LEFT));
 
 //Sex Offenders
 UNQ_PK_DID         := DEDUP(PK_DID_with_relative_flag, Persistent_key, did,LOCAL);
 D_Header_relatives := DISTRIBUTE(Files_used.Header_relative_file, hash(person1));
	
// Get a DID list for relative
	Layout_UNQ_PK_DID_Plus_Relatives Join_KeyFile_Relatives1(Layout_UNQ_PK_DID_Plus_Relatives L, Files_used.Layout_Header_relative R) := TRANSFORM

		SELF.Did	        	:= R.person2;
		SELF.relative_flag  := 1;
    SELF:=L;

  end;
	//Relatives of sex_offenders
	J_PK_File_with_relatives1 	   := JOIN(UNQ_PK_DID, D_Header_relatives, 
	                                LEFT.did = RIGHT.person1 ,
									Join_KeyFile_Relatives1(LEFT,RIGHT), LOCAL);

   D_Header_relatives2 := DISTRIBUTE(Files_used.Header_relative_file, hash(person2));
// Get a DID list for relative
	Layout_UNQ_PK_DID_Plus_Relatives Join_KeyFile_Relatives2(Layout_UNQ_PK_DID_Plus_Relatives L, Files_used.Layout_Header_relative R) := TRANSFORM

		SELF.Did	        	:= R.person1;
		SELF.relative_flag  := 1;
    SELF:=L;

  end;
	//Relatives of sex_offenders
	J_PK_File_with_relatives2 	   := JOIN(UNQ_PK_DID, D_Header_relatives2, 
	                                       LEFT.did = RIGHT.person2 ,
									                       Join_KeyFile_Relatives2(LEFT,RIGHT), LOCAL);
									
  Combined_PK_DID         := DISTRIBUTE(UNQ_PK_DID+J_PK_File_with_relatives1+J_PK_File_with_relatives2,hash(did)); 
	S_combined_PK_DID       := SORT(Combined_PK_DID,persistent_key,did,relative_flag,local);
	S_combined_PK_DID_dedup := DEDUP(S_Combined_PK_DID,persistent_key,did,local);
	
										
export File_Generated_UNQ_PK_DID_Plus_Relatives := S_combined_PK_DID_dedup : persist('persist::imap::File_Pkey_DID_with_rel');