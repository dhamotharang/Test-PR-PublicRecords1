/*
**********************************************************************************
Created by    Comments
Vani 		  This attribute 
              1)Extracts the unique Names from header file
			  							
***********************************************************************************
*/	
				  
  Layout_Name_List Change_to_Name_Layout(Layout_Header_Subset L) := TRANSFORM
           
    SELF := L; 
	
  end;
 
  Name_List   := PROJECT(File_Generated_Header_subset, Change_to_Name_Layout(LEFT),LOCAL) ;
  
  S_Name_List := SORT(Name_List, persistent_key,did,title,fname,mname,lname,name_suffix,LOCAL) ;
  
  S_Name_List_dedup := DEDUP(S_Name_List, persistent_key,did,title,fname,mname,lname,name_suffix,LOCAL);
  
export Mapping_Extract_Name_List := S_Name_List_dedup ;//: Persist ('persist::IMAP::Name_List');