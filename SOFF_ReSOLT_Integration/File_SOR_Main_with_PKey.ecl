import address;
	

  Layout_SOR_Main_temp := RECORD 
  
	  File_Generated_UNQ_PK_DID_Plus_Relatives.persistent_key;
	  Layout_SexOffender_Main;
  
  END;


  Layout_SOR_Main_temp	 Join_KeyFile_SOR(Layout_Persistent_KeyFile L, Layout_SexOffender_Main R) := TRANSFORM

	  SELF:= R;
		SELF:= L;
		
  end;
	
  SOR_OffenderMain_List 	:= JOIN(File_Generated_PKFile.full_file(name_type = '0' ),File_In_SexOffender_Main(name_type <> '3'), 
	                                left.seisint_primary_key = RIGHT.seisint_primary_key,
								                  Join_KeyFile_SOR(LEFT,RIGHT));

  D_SOR_OffenderMain_List := distribute(SOR_OffenderMain_List,hash(seisint_primary_key));
export File_SOR_Main_with_PKey := D_SOR_OffenderMain_List : persist ('persist::IMAP::SOR_Offender_Main');