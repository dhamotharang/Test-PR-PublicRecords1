	D_Gong_History       := DISTRIBUTE(Files_Used.gong_file_history,HASH(did));
	
tempLayout_Gong_slim := RECORD
  layout_gong_slim and not [persistent_key,seisint_primary_key,relative_flag];
end;

tempLayout_Gong_slim  Change_Layout(Files_used.Layout_gong_history L ) := TRANSFORM
  SELF := L;
END; 

 J_Gong_Hist_slim   := PROJECT( D_Gong_History,Change_Layout(LEFT),LOCAL);

Layout_Gong_slim Join_DID_Gong (Layout_UNQ_PK_DID_Plus_Relatives L , tempLayout_Gong_slim R) := TRANSFORM
    
    SELF    := R;
    SELF	:= L;

  end;		
	
	J_Gong_slim_subset      := JOIN( File_Generated_UNQ_PK_DID_Plus_Relatives,J_Gong_Hist_slim, 
                                     LEFT.did = RIGHT.DID ,
							         Join_DID_Gong(LEFT,RIGHT),LOCAL);
								 

export File_generated_Gong_slim_subset := J_Gong_slim_subset : persist ('persist::Imap::Gong_Slim');