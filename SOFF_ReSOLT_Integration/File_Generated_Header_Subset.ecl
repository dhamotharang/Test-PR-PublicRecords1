/*
**********************************************************************************
Created by    Comments
Vani 		  This attribute creates a subset of Header file by joining it with 
              unique Persisitent_key and DID' values
							
***********************************************************************************
*/	

import address;
//----------------------------------------------------------------------------------------------------------------------------
//Generate Header file Subset
//----------------------------------------------------------------------------------------------------------------------------

D_Header_file := DISTRIBUTE(Files_Used.Header_file, hash(DID));

Layout_Header_Subset	 Join_KeyFile_Header(Layout_UNQ_PK_DID_Plus_Relatives L, Files_Used.layout_Header_file R) := TRANSFORM

    SELF:= L;
	  SELF:= R;
  end;
	
	J_Header_data   	  := JOIN(File_Generated_UNQ_PK_DID_Plus_Relatives,D_Header_file , 
	                            LEFT.did = RIGHT.did ,
								              Join_KeyFile_Header(LEFT,RIGHT), LOCAL);
															
export File_Generated_Header_Subset := J_Header_data : persist ('persist::IMAP::header_subset');