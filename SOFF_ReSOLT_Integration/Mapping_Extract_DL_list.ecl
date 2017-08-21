	/*
**********************************************************************************
Created by    Comments
Vani 					This attribute 
              1)Use the persistent_key file with unique Persisitent_key and DID' values
							2)Extract DL List from DL File. 
							3)Extract DL List from Certegy File.
							4)Combine and dedup. 
							
***********************************************************************************
*/	
import address;

//----------------------------------------------------------------------------------------------------------------------------
//Extract DL List from DL file
//----------------------------------------------------------------------------------------------------------------------------


	Layout_DLS_LIST Join_KeyFile_DLData(Layout_UNQ_PK_DID_Plus_Relatives L, Layout_BestDL.Layout_Best_FileDL_DL_num_state R) := TRANSFORM

		SELF.DL_num	        	:= trim(R.DL_number);
		SELF.DL_state       	:= trim(R.orig_state);
		SELF.lic_issue_date	  := MAP( R.lic_issue_date =0 => '',
		                             trim((string)R.lic_issue_date));
		SELF.expiration_date  := MAP( R.expiration_date =0 => '',
		                             trim((string)R.expiration_date)) ;
		//SELF.source		      := 'D';
    SELF:=L;

  end;
	
	J_DL_List_DLFile   		  := JOIN(File_Generated_UNQ_PK_DID_Plus_Relatives, File_Generated_Best_DL_num_state, 
	                                LEFT.did = RIGHT.did ,
																	Join_KeyFile_DLData(LEFT,RIGHT), LOCAL);
																	 
	//S_DL_List_DLFile        := SORT(J_DL_List_DLFile, Persistent_key, did, DL_num, DL_state,expiration_date,lic_issue_date, LOCAL);
	//S_DL_List_DLFile_Dedup  := DEDUP(S_DL_List_DLFile, Persistent_key, did, DL_num, DL_state,expiration_date,lic_issue_date, LOCAL);
	
//----------------------------------------------------------------------------------------------------------------------------
//Extract DL List from certegy file
//----------------------------------------------------------------------------------------------------------------------------
 Layout_DLS_LIST Join_KeyFile_certegy(Layout_UNQ_PK_DID_Plus_Relatives L, Layout_BestDL.Layout_Best_Certegy_DL_num_state R) := TRANSFORM

		SELF.DL_num	        	:= trim(R.orig_DL_Num);
		SELF.DL_state       	:= trim(R.orig_DL_State);
		SELF.lic_issue_date	  := MAP (R.orig_DL_Issue_Dte = '2099-12-31' =>  '',
		                              trim(stringlib.StringFindReplace(R.orig_DL_Issue_Dte,'-',''))) ;
		SELF.expiration_date  := MAP (R.orig_DL_Expire_Dte = '2099-12-31' => '',
		                              trim(stringlib.StringFindReplace(R.orig_DL_Expire_Dte,'-','')));
		//SELF.source		        := 'C';
    SELF:=L;
  end;
	
   J_DL_List_CertegyFile := JOIN( File_Generated_UNQ_PK_DID_Plus_Relatives, File_Generated_Certegy_DL_num_state, 
	                                  LEFT.did = RIGHT.did ,
																	  Join_KeyFile_certegy(LEFT,RIGHT), LOCAL);
																		
   S_Full_DL_List        := SORT(J_DL_List_DLFile+J_DL_List_CertegyFile, Persistent_key, did, DL_num, DL_state,expiration_date,lic_issue_date, LOCAL);

   S_Full_DL_List_Dedup  := DEDUP(S_Full_DL_List, Persistent_key, did, DL_num, DL_state,expiration_date,lic_issue_date, LOCAL);
	
	// S_cert_DL_List        := SORT(J_DL_List_CertegyFile, Persistent_key, did, DL_num, DL_state,expiration_date,lic_issue_date,source, LOCAL);
	// S_cert_DL_List_Dedup  := DEDUP(S_cert_DL_List, Persistent_key, did, DL_num, DL_state,expiration_date,lic_issue_date,source, LOCAL);
	
	//S_cert_DL_List_Dedup_nulldates    := S_cert_DL_List_Dedup(lic_issue_date ='' and expiration_date ='');
	//S_cert_DL_List_Dedup_notnulldates := S_cert_DL_List_Dedup(lic_issue_date <> '' or expiration_date <> '');
	
  //Combine the DL records and eliminate dups. Pick the DL record when there is a match.  
  // Layout_DLS_LIST Combine_common(Layout_DLS_LIST L, Layout_DLS_LIST R) := TRANSFORM

  // SELF.source		             := MAP (L.persistent_key <> '' and R.persistent_key <>''  => 'C,D',
		                                   // L.persistent_key = ''  and R.persistent_key <>''  => R.source,
																	     // L.persistent_key <> '' and R.persistent_key ='' => L.source,
																	     // '');
    // SELF.Persistent_key        := If (L.persistent_key <> '', L.Persistent_key, R.Persistent_key) ;
    // SELF.did                   := If (L.persistent_key <> '', L.did , R.did ) ;
    // SELF.seisint_primary_key   := If (L.persistent_key <> '', L.seisint_primary_key, R.seisint_primary_key) ;
    // SELF.DL_num	        			:= If (L.persistent_key <> '', L.DL_num, R.DL_num) ;
		// SELF.DL_state       			  := If (L.persistent_key <> '', L.DL_state, R.DL_state) ;
		// SELF.lic_issue_date	  		:= If (L.persistent_key <> '', L.lic_issue_date, R.lic_issue_date );
		// SELF.expiration_date  		  := If (L.persistent_key <> '', L.expiration_date, R.expiration_date) ;
    // SELF.relative_flag         := If (L.persistent_key <> '', L.relative_flag, R.relative_flag) ;		                              
  // end;

	// J_DL_List_common := JOIN( S_DL_List_DLFile_Dedup, S_cert_DL_List_Dedup_nulldates, 
	                               // LEFT.persistent_key = RIGHT. persistent_key and 
																 // LEFT.did = RIGHT.did  and  
																 // LEFT.Relative_flag = RIGHT.Relative_flag and
																 // LEFT.dl_num = RIGHT.dl_num and
																 // LEFT.dl_state = RIGHT.dl_state ,
																 // Combine_common(LEFT,RIGHT),FULL OUTER, LOCAL);
																		
  //Combine the DL records and eliminate dups.  
	// Layout_DLS_LIST Combine_common2(Layout_DLS_LIST L, Layout_DLS_LIST R) := TRANSFORM

		// SELF.source		        		:= IF (L.source = 'C,D','C,D', 
		                                               // MAP (L.persistent_key <> '' and R.persistent_key <>''  => 'C,D',
		                                                    // L.persistent_key = ''  and R.persistent_key <>''  => R.source,
																	                      // L.persistent_key <> '' and R.persistent_key = ''  => L.source,
																	                      // ''))
																												// ;
		// SELF.Persistent_key        := If (L.persistent_key <> '', L.Persistent_key, R.Persistent_key) ;
    // SELF.did                   := If (L.persistent_key <> '', L.did , R.did ) ;
    // SELF.seisint_primary_key   := If (L.persistent_key <> '', L.seisint_primary_key, R.seisint_primary_key) ;															
    // SELF.DL_num	        			:= If (L.persistent_key <> '', L.DL_num, R.DL_num) ;
		// SELF.DL_state       			  := If (L.persistent_key <> '', L.DL_state, R.DL_state) ;
		// SELF.lic_issue_date	  		:= If (L.persistent_key <> '', L.lic_issue_date, R.lic_issue_date );
		// SELF.expiration_date  		  := If (L.persistent_key <> '', L.expiration_date, R.expiration_date) ;
		// SELF.relative_flag         := If (L.persistent_key <> '', L.relative_flag, R.relative_flag) ;	
  // end;
	
	// J_DL_List_common2 := JOIN( J_DL_List_common, S_cert_DL_List_Dedup_notnulldates, 
	                               // LEFT.persistent_key = RIGHT. persistent_key and 
																 // LEFT.did = RIGHT.did  and 
																 // LEFT.Relative_flag = RIGHT.Relative_flag and 
																 // LEFT.dl_num = RIGHT.dl_num and
																 // LEFT.dl_state = RIGHT.dl_state and 
																 // LEFT.lic_issue_date = RIGHT.lic_issue_date and 
																 // LEFT.expiration_date = RIGHT.expiration_date ,
																 // Combine_common2(LEFT,RIGHT),FULL OUTER, LOCAL);
	
	Full_DL_List					:= S_Full_DL_List_Dedup ;

export Mapping_Extract_DL_list := Full_DL_List ;//:persist ('persist::IMAP::DL_list');																		