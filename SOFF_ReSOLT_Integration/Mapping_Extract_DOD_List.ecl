//Extract DOB List
  Layout_DOD_list  Join_keyFile_best_Layout(Layout_UNQ_PK_DID_Plus_Relatives L, Files_used.watchdog_Layout_best R) := TRANSFORM
      string10 v_dod := (string)R.DOD ;
			SELF.death_indicator := IF(v_dod <> '', 'Y','N');
      SELF.dod_year  := v_dod[1..4];
			SELF.dod_month := Stringlib.StringFindReplace(v_dod[5..6],'00','??');
			SELF.dod_day   := Stringlib.StringFindReplace(v_dod[7..8],'00','??');
      SELF := L; 
  end;
	

  J_DOD_List  	   := JOIN(File_Generated_UNQ_PK_DID_Plus_Relatives,File_Generated_FileBest_Subset(dod <> '') , 
	                         LEFT.did = RIGHT.did ,
								           Join_keyFile_best_Layout(LEFT,RIGHT), LOCAL);
   
  S_DOD_List       := SORT(j_DOD_List, persistent_key,did,dod_year,dod_month,dod_day,LOCAL) ;
  
  S_DOD_List_dedup := DEDUP(S_DOD_List, persistent_key,did,dod_year,dod_month,dod_day,LOCAL) ;
  
export Mapping_Extract_DOD_List := S_DOD_List_dedup ;//: Persist ('persist::IMAP::DOD_List');

