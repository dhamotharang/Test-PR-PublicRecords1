//verify orphans on payload and override keys

export Mac_Orphans_Evaluate(keydatasetname,datasetname,in_base = '',dsout, hascompanyinfo = 'false', LexidField='\'\'',RecID1_field ='\'\'',RecID2_field='\'\'',
RecID3_field='\'\'',RecID4_field='\'\'',fname_field ='\'\'',lname_field='\'\'',prange_field='\'\'',prim_field='\'\'', zip_field='\'\'',
company_title_field='\'\'',company_name_field='\'\'',company_prange_field='\'\'',company_prim_field='\'\'',company_zip_field='\'\''):= macro

#uniquename(orphans)
#uniquename(payload_key)
#uniquename(override_key)
#uniquename(load_payload)
#uniquename(dsout_did)
#uniquename(dsout_recID)
#uniquename(dsout_did_only)
#uniquename(dsout_comb)
#uniquename(DID_diff)
#uniquename(recID_diff)
#uniquename(override_recID)
#uniquename(override_DID)

//#uniquename(dsout)

%orphans% := in_base(datagroup = STD.Str.ToUpperCase(datasetname));
//payload keys 
%payload_key% := pull(overrides.payload_Keys.keydatasetname);


%load_payload% := table(%payload_key%, {string12 did := (string)LexidField,
string100 RecID			:=	trim((string)RecID1_field) + trim((string)RecID2_field) + trim((string)RecID3_field) + trim((string)RecID4_field)
,string100 RecID1 := (string)RecID1_field
			,string100 RecID2 := (string)RecID2_field
			,string100 RecID3 := (string)RecID3_field
			,string100 RecID4 := (string)RecID4_field
			,string fname := fname_field
			,string lname := lname_field
			,string prim_name := prim_field
			,string prim_range := prange_field
		  ,string zip := zip_field
			#if(hascompanyinfo)
			,string company_title := company_title_field
			,string company_name := company_name_field
			,string company_prim_name := company_prim_field
			,string company_prim_range := company_prange_field
			,string company_zip := company_zip_field
			#end
},
 LexidField,RecID1_field, RecID2_field, RecID3_field, RecID4_field, merge);
%override_key% := pull(overrides.Keys.keydatasetname);

/*dsout := join(%load_payload%, %orphans%,	
	   left.RecID = right.RecID
		and (unsigned)left.DID=(unsigned)right.did
		,transform({boolean isinvalid, string RecID, string DID},
		 self.isinvalid	:=(unsigned)right.DID > 0, self := left),lookup);
	
	rec_basefileIDs := RECORD
  string20 datagroup;
  string20 flag_file_id;
  string12 did;
  string100 recid;
  string100 recid1;
  string100 recid2;
  string100 recid3;
  string100 recid4;
 END;
 
OverrideBase := dataset('~thor_data400::persist::override_basefileIDs',rec_basefileIDs, thor);

j_base_2 :=join(OverrideBase(datagroup in overrides.Constants.datagroup_m_set),%orphans%,
		left.RecID=right.RecID
		//and  (unsigned)left.DID=(unsigned)right.Lexid
		//and  left.Datagroup=right.Datagroup
		,transform({unsigned subject_did, OverrideBase},
		  self.subject_did := (unsigned)right.did;
			self:=left;
			self:=right	
			));
			
//get bk orphans 
j_base_2_bk := join(j_base_2,FCRA.File_flag(file_id = FCRA.FILE_ID.BANKRUPTCY),
		//left.RecID=right.Record_id
		(unsigned)left.subject_did=(unsigned)right.did
		and left.flag_file_id = right.flag_file_id
		,transform({boolean Orphan,j_base_2},
		self.Orphan	:=(unsigned)right.did > 0;
			self:=left;
			self:=right	
			)
		,left outer, keep(1), limit(0));
	
	bk_search_orphans := sort(j_base_2_bk(orphan), subject_did, did);
*/

	//match on DID 
	#if(hascompanyinfo)
	%dsout_did% := join(%load_payload%, %orphans%,	
		(unsigned)left.DID=(unsigned)right.did and (unsigned)right.did != 0
		and left.fname = right.fname and left.lname = right.lname and left.prim_range = right.prim_range
		and left.prim_name = right.prim_name and left.zip = right.zip and left.company_title = right.company_title 
		and left.company_name = right.company_name and left.company_prim_range = right.company_prim_range 
		and left.company_prim_name = right.company_prim_name and left.company_zip = right.company_zip
		,transform({string RecID_payload, string DID_payload, string RecID, string DID},
		 self.RecID_payload := left.RecID, self.DID_payload := left.DID, self := right, self := []),lookup);
	#else
	%dsout_did% := join(%load_payload%, %orphans%,	
		(unsigned)left.DID=(unsigned)right.did and (unsigned)right.did != 0
		and left.fname = right.fname and left.lname = right.lname and left.prim_range = right.prim_range
		and left.prim_name = right.prim_name and left.zip = right.zip
		,transform({string RecID_payload, string DID_payload, string RecID, string DID},
		 self.RecID_payload := left.RecID, self.DID_payload := left.DID, self := right, self := []),lookup);
	#end

	// match on did only	
	%dsout_did_only% := join(%load_payload%, %orphans%,	
		(unsigned)left.DID=(unsigned)right.did and (unsigned)right.did != 0
		,transform({string RecID_payload, string DID_payload, string RecID, string DID},
		 self.RecID_payload := left.RecID, self.DID_payload := left.DID, self := right, self := []),lookup);
	
	//match on recID
	%dsout_recID% := join(%load_payload%, %orphans%,	
		left.recID= right.recID and right.recID != ''
		,transform({string RecID_payload, string DID_payload, string RecID, string DID},
		 self.DID_payload := left.DID, self.RecID_payload := left.recID, self := right, self := []),lookup);

	%dsout_comb% := dedup(%dsout_did% + %dsout_did_only% + %dsout_recID%, all);

//unmatch on both DID and RecID

//orphans_only := join(%orphans%, dsout_comb, 
//(unsigned)left.DID = (unsigned)right.did or left.recID = right.recID, left only);

%DID_diff% := %dsout_comb%((unsigned)did <> 0 and (unsigned)recID <> 0 and (unsigned)did != (unsigned)DID_payload and recID = RecID_payload); 
	
%recID_diff% := %dsout_comb%((unsigned)did <> 0 and (unsigned)recID <> 0 and (unsigned)did = (unsigned)DID_payload and recID != RecID_payload); 

//retrieve data from overrides with diff recID

%override_recID%:= join(%override_key%, %recID_diff%, 
	(unsigned)left.DID =(unsigned)right.DID
		,transform({string diff_ind, string recID_payload,string DID_payload, recordof(%override_key%)},
		 self.diff_ind := 'R', self := left,self := right, self := []));
		 
//dsout := 	dedup(override_recID,all);	 
		 
//retrieve data from overrides with diff recID

//%override_DID% := join(%override_key%, %DID_diff%, 
//	(unsigned)left.email_rec_key = (unsigned)right.recID
	//	,transform({string diff_ind, string recID_payload,string DID_payload, recordof(%override_key%)},
	//	 self.diff_ind := 'D', self := left, self := right, self := []));
	 
//dsout := 	dedup(override_recID, all) + dedup(override_DID,all);	 

dsout_ := table(%dsout_recID%, {DID_payload, DID, recID}, DID_payload, DID, recID,merge);
//dsout_ := table(%dsout_did%,{recID_payload, recID, did_payload, did,}, recID_payload, recID, did_payload, did,merge);
dsout := 	%dsout_comb%;

endmacro;

	