//Extract DOB List
  Layout_DOB_list  Change_to_DOB_Layout(Layout_Header_Subset L) := TRANSFORM
           string10 V_dob := (string)L.DOB ;
           SELF.dob_year  := v_dob[1..4];
		   SELF.dob_month := Stringlib.StringFindReplace(v_dob[5..6],'00','??');
		   SELF.dob_day   := Stringlib.StringFindReplace(v_dob[7..8],'00','??');
           SELF := L; 
  end;
 
  DOB_List   := PROJECT(File_Generated_Header_Subset(dob <> 0), Change_to_DOB_Layout(LEFT),LOCAL) ;
  
  S_DOB_List := SORT(DOB_List, persistent_key,did,dob_year,dob_month,dob_day,LOCAL) ;
  
  S_DOB_List_dedup := DEDUP(S_DOB_List, persistent_key,did,dob_year,dob_month,dob_day,LOCAL) ;
  
export Mapping_Extract_DOB_List := S_DOB_List_dedup ;//: Persist ('persist::IMAP::DOB_List');