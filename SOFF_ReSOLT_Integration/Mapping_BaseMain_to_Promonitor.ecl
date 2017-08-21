/*
**********************************************************************************
Created by    Comments
Vani 					This attribute 
              1)Transforms Sex Offender Base Main into Promonitor Layout. 
							2)Extract DOB and BEST DL from Best File. Join Persistent_key file and Best file.
							3)Extract state from DL File. Join result from 2 and DL file.
							4)Extract DL data from certegy for the records if DL file did not have DL
							
							
***********************************************************************************
*/	


Layout_PromitorExt_Enhanced := RECORD , MAXLENGTH(4096)
			Layout_Promonitor_extract; 
			Layout_SexOffender_Main.seisint_primary_key;
			Layout_SexOffender_Main.name_type;
			Layout_SexOffender_Main.name_orig; 
			Layout_SexOffender_Main.orig_state;
End; 

Layout_PromitorExt_Enhanced BaseToPromonitor(Layout_SexOffender_Main L) := TRANSFORM

    SELF.EXTERNAL_ID 		:= '';
		SELF.SSN						:= IF (L.ssn_appended ='0','',L.ssn_appended);
    SELF.DOB_MONTH			:= L.dob[5..6];
    SELF.DOB_DAY				:= L.dob[7..8];
		SELF.DOB_YEAR			  := L.dob[1..4];
		SELF.FIRST_NAME			:= L.fname;
		SELF.MIDDLE_NAME		:= L.mname;
		SELF.LAST_NAME			:= L.lname;
		SELF.STREET_1				:= trim(trim(trim(trim(
		                            IF (L.prim_range <> '',    trim(L.prim_range),'')+
		                            IF (L.predir     <> '',' '+trim(L.predir),''),LEFT)+
																IF (L.prim_name  <> '',' '+trim(L.prim_name),''),LEFT)+
																IF (L.addr_suffix<> '',' '+trim(L.addr_suffix),''),LEFT)+
																IF (L.postdir    <> '',' '+L.postdir,''),LEFT,RIGHT);
																
		SELF.STREET_2				:= trim(trim(L.unit_desig)+' '+L.sec_range);
		SELF.STREET_3				:= '';
		SELF.CITY						:= If(trim(L.v_city_name) ='0','',L.v_city_name);
		SELF.STATE					:= L.st;
		SELF.POSTAL_CODE		:= L.zip5;
		SELF.ACCOUNT_ID			:= '';
		SELF.USERNAME				:= '';
		SELF.OPERATION_TYPE	:= 'A';
		SELF.REFERENCE_ID		:= '';
		SELF.DL_NUM					:= '';
		SELF.DL_STATE				:= '';
		SELF.LINK_ID        := L.did;
		SELF.orig_state     := L.orig_state_code;
		SELF := L;

 END;
 //(not (name_type ='2' and did =0) ) Not sure if this where clause is requied.
PromonitorEnhanced_Recs 		:= PROJECT(File_In_SexOffender_Main, BaseToPromonitor(LEFT));
//----------------------------------------------------------------------------------------------------------------------------
//Append Account Information and user name
//----------------------------------------------------------------------------------------------------------------------------
Layout_PromitorExt_Enhanced Join_KeyFile_AccLkp (Layout_PromitorExt_Enhanced L, Layout_Account_Lookup R) := TRANSFORM

		SELF.ACCOUNT_ID        := R.account_id;
		SELF.USERNAME          := R.User_name; 
    SELF:=L;

end;

  PromonitorExtactWithAccount   := JOIN( PromonitorEnhanced_Recs, 
																         File_Account_Lookup, LEFT.orig_state = RIGHT.src_state ,
																	       Join_KeyFile_AccLkp(LEFT,RIGHT),LEFT OUTER, LOOKUP);
//----------------------------------------------------------------------------------------------------------------------------
//Extract DL and DOB
//----------------------------------------------------------------------------------------------------------------------------

Layout_DL_num_state_DOB  := RECORD

   Layout_Persistent_KeyFile;
	 Layout_BestDL.Layout_Best_FileDL_DL_num_state.dl_number;
	 Layout_BestDL.Layout_Best_FileDL_DL_num_state.orig_state;
	 Files_Used.watchdog_Layout_best.dob;
	 Layout_BestDL.Layout_Best_Certegy_DL_num_state.orig_dl_num;
	 Layout_BestDL.Layout_Best_Certegy_DL_num_state.orig_dl_state;
	 Files_used.DriversV2_layout_dl.history;
	 Files_used.DriversV2_layout_dl.dt_first_seen;
	 Files_used.DriversV2_layout_dl.dt_last_seen;
end;	 

Layout_DL_num_state_dob ChangeFormat (Layout_Persistent_KeyFile L) := TRANSFORM
    SELF.DL_number	  := '';
		SELF.dob          := 0;
		SELF.orig_state   := '';
		SELF.Orig_DL_num	:= '';
		SELF.orig_dl_state := '';
		SELF.history 			 := '';
		SELF.dt_first_seen := 0;
		SELF.dt_last_seen  := 0;
    SELF:=L;
 
end; 
  //Persistent_key_file                := Generate_Persistent_key_File;
  //PersistentkeyFile_noDID            := PROJECT(Persistent_key_file(did = 0),ChangeFormat(LEFT)) ;
	//PersistentkeyFile_withDID          := Persistent_key_file(did <> 0);
	//D_File_Generated_PersistentkeyFile := DISTRIBUTE(PersistentkeyFile_withDID, HASH(did));
  
	PersistentkeyFile_noDID            := PROJECT(File_Generated_PKFile.noDID,ChangeFormat(LEFT)) ;
	D_File_Generated_PersistentkeyFile := File_Generated_PKFile.withDID;
	
	//D_File_best                        := DISTRIBUTE(Files_Used.Watchdog_File_Best,HASH(did));
	D_File_best := File_Generated_FileBest_Subset;
	
  Layout_DL_num_state_dob Join_KeyFile_BestFile (Layout_Persistent_KeyFile L, Files_Used.watchdog_Layout_best R) := TRANSFORM
    SELF.DL_number	:= R.DL_number;
		SELF.dob        := R.dob;
		SELF.orig_state := '';
		SELF.Orig_DL_num	 := '';
		SELF.orig_dl_state := '';
		SELF.history 			 := '';
		SELF.dt_first_seen := 0;
		SELF.dt_last_seen  := 0;
    SELF:=L;

  end;
	//output(count(D_File_Generated_PersistentkeyFile(name_type ='0')));
	  
  J_KeyFilePlusPlusDOB   := JOIN( D_File_Generated_PersistentkeyFile,
								  D_File_best, LEFT.did = RIGHT.did ,
								  Join_KeyFile_BestFile(LEFT,RIGHT),LEFT OUTER,LOCAL);
																	
	Layout_DL_num_state_dob Join_KeyFile_DLData(Layout_DL_num_state_dob L, Layout_BestDL.Layout_Best_FileDL_DL_num_state R) := TRANSFORM

		SELF.DL_number	:= L.DL_number;
		SELF.orig_state := R.orig_state;
		SELF.Orig_DL_num	:= '';
		SELF.orig_dl_state  := '';
    SELF:=L;

  end;
	
	J_KeyFilePlusDOB_DLData   := JOIN(J_KeyFilePlusPlusDOB, File_Generated_Best_DL_num_state, 
	                                  LEFT.did = RIGHT.did and trim(LEFT.DL_number) = RIGHT.DL_number,
																	  Join_KeyFile_DLData(LEFT,RIGHT),LEFT OUTER, LOCAL);
																		
	//output(count(J_KeyFilePlusDOB_DLData(name_type ='0')));																 
	// S_J_KeyFilePlusDOB_DLData := SORT(J_KeyFilePlusDOB_DLData, did, seisint_primary_key, name_type, 
	                                                           // dl_number, history, -dt_last_seen, -dt_first_seen,LOCAL);
																															 
	// J_KeyFilePlusDOB_DLData_Dedup := DEDUP( S_J_KeyFilePlusDOB_DLData,did, seisint_primary_key, name_type, 
	                                                                  // dl_number,LOCAL);	
	
	D_KeyFile_With_DL_Num         := J_KeyFilePlusDOB_DLData(orig_state <> '' and dl_NUMBER <> '') ;
		
	D_KeyFile_ToJoinWithCertegy   := J_KeyFilePlusDOB_DLData(orig_state  = '' OR  dl_NUMBER = '') ;
	
	//output(count(D_KeyFile_With_DL_Num(name_type ='0')));
	//output(count(D_KeyFile_ToJoinWithCertegy(name_type ='0')));
	//output(D_KeyFile_ToJoinWithCertegy(did in [ 11977959,11266581,13781917]));
	
//----------------------------------------------------------------------------------------------------------------------------
//Extract DL from certegy file
//----------------------------------------------------------------------------------------------------------------------------
 Layout_DL_num_state_dob Join_KeyFile_certegy(Layout_DL_num_state_dob L, Layout_BestDL.Layout_Best_Certegy_DL_num_state R) := TRANSFORM

		SELF.Orig_DL_num	  := R.Orig_DL_num;
		SELF.orig_dl_state  := R.orig_dl_state;
    SELF:=L;
  end;
	
	DS_Certegy_DL            := SORT(File_Generated_Certegy_DL_num_state, did, -date_vendor_last_reported, -date_vendor_first_reported, LOCAL);
  DS_BEST_Certegy_DL_dedup := DEDUP(DS_Certegy_DL, did, LOCAL);
	
	J_KeyFilePlusDOB_Certgy_DLData := JOIN( D_KeyFile_ToJoinWithCertegy, DS_BEST_Certegy_DL_dedup, 
	                                  LEFT.did = RIGHT.did ,
																	  Join_KeyFile_certegy(LEFT,RIGHT),LEFT OUTER, LOCAL);
  
	//output(J_KeyFilePlusDOB_Certgy_DLData(did in [ 11977959,11266581,13781917]));
	
  Fullset_with_DLandDOB := J_KeyFilePlusDOB_Certgy_DLData +D_KeyFile_With_DL_Num + PersistentkeyFile_noDID ; // : persist('persist::Temp_vani');
	//output(count(Fullset_with_DLandDOB(name_type ='0')));
	//output(Fullset_with_DLandDOB(did in [ 11977959,11266581,13781917]));
		
//----------------------------------------------------------------------------------------------------------------------------
//Append DL and DOB to Promitor extract
//----------------------------------------------------------------------------------------------------------------------------
 Layout_PromitorExt_Enhanced AppendInfo_FromKeyFile (Layout_PromitorExt_Enhanced L, Layout_DL_num_state_dob R) := TRANSFORM

        SELF.DOB_MONTH   := If  ( L.DOB_MONTH = '' ,IF (R.DOB <> 0, R.DOB[5..6],L.DOB_MONTH),L.DOB_MONTH);
			  SELF.DOB_DAY     := If  ( L.DOB_DAY   = '' ,IF (R.DOB <> 0, R.DOB[7..8],L.DOB_DAY),L.DOB_DAY); 	
			  SELF.DOB_YEAR    := If  ( L.DOB_MONTH = '' OR L.DOB_DAY = '' OR L.DOB_YEAR = '',IF (R.DOB <> 0, R.DOB[1..4],L.DOB_YEAR),L.DOB_YEAR); 	
			 
		   SELF.DL_NUM       := MAP ( R.DL_number <> '' and R.orig_state <> '' => R.DL_Number,
			                            R.DL_number <> '' and R.orig_state = '' and R.orig_DL_num <> '' and R.orig_dl_state <> '' => R.orig_DL_num,
																	R.DL_number =  '' => R.orig_DL_num,
																  R.DL_number);
																
			 SELF.DL_state     := MAP ( R.DL_number <> '' and R.orig_state <> '' => R.orig_state,
			                            R.DL_number <> '' and R.orig_state = '' and R.orig_DL_num <> '' and R.orig_dl_state <> '' => R.orig_dl_state,
																	R.DL_number =  '' => R.orig_dl_state,
																  R.orig_state);    
       SELF.EXTERNAL_ID  := R.persistent_key;
			 SELF.REFERENCE_ID := R.persistent_key;
			 SELF.orig_state   := R.orig_state;
		   SELF              := R;
       SELF              := L;

 end;
 
 J_Promonitor_Extract  := JOIN( PromonitorExtactWithAccount, Fullset_with_DLandDOB, 
                                LEFT.seisint_primary_key = RIGHT.seisint_primary_key and 
																Left.LINK_ID = right.did and 
																LEFT.name_type = RIGHT.Name_type,
								                AppendInfo_FromKeyFile(LEFT,RIGHT),LEFT OUTER)	;
 //output(count(J_Promonitor_Extract(name_type ='0'))); 															
 //output(J_Promonitor_Extract(did in [ 11977959,11266581,13781917]))				;												 
 Promon_ext_TrueNames := PROJECT(J_Promonitor_Extract(name_type='0'),Layout_Promonitor_extract) ;
									 
export Mapping_BaseMain_to_Promonitor := Promon_ext_TrueNames  ;//: persist('persist::new_dl_num_new');

