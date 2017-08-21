import address;
	
  Layout_SOR_Offense_out	 Join_KeyFile_SOR(Layout_Persistent_KeyFile L, Layout_SexOffender_Offense R) := TRANSFORM

	  SELF:= R;
		SELF:= L;
		
  end;
	
  SOR_Offense_List 	:= JOIN(File_Generated_PKFile.full_file(name_type = '0' ),File_In_SexOffender_Offense, 
	                                left.seisint_primary_key = RIGHT.seisint_primary_key,
								                  Join_KeyFile_SOR(LEFT,RIGHT));


export Mapping_extract_SOR_Offense := SOR_Offense_List ;//: persist('persist::Imap::SOR_Offense');