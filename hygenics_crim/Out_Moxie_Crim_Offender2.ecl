import DID_Add, Header_Slimsort, ut, WatchDog, didville, Crim_Expunctions, lib_ziplib, Address, idl_header, crim_common, hygenics_images;

///////////////////////////////////////////////////////////////////////////////////
//Create Offender File
///////////////////////////////////////////////////////////////////////////////////

	dArrestOffenderOut				:= hygenics_crim.proc_build_arrest_crim_offender2_base;	
		
	//Pull LN Production Counties/Arrests that were not pulled from Hygenics	
		lnOffender          		:= hygenics_crim.File_in_LN_offender_preprocess;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		hygenics_crim.Layout_Common_Crim_Offender_orig stOffndrLayout2(lnOffender l) := transform
			self.pgid							:= '';
			self.src_upload_date	:= '';
			self.age							:= '';
			self.image_link				:= '';
			self 									:= l;
			
		end;
	
dLNCourtOffenderOut				:= project(lnOffender, stOffndrLayout2(left))(vendor in [//'02','03',
																//'1A','1E','1J','1L','1M','1N','1R','2H','2K','2L','2O','2Q',
																//'2U','2V','2W','2X','2Y','3J','3R','3Y'
																'1B','1I','1S','1T','1U','1W','1X',
																'1Z','2A','2B','2C','2D','2E','2F',
																'2Z','3K',//'3L', replaced with hygenics TX lamar
																'3N','3O', 
																//'42','43', replaced with hygenics FL pasco sources
																//'47','55','75','89','93','97','98',
																'63','73','77',
																//'64', replaced with crimwise  CALIFORNIA MENDOCINO COUNTY
																//'78', replaced with hygenics TX lamar
																'79','80','90','91','A3','A4','A7',
																'AP','AT','B7','D4','B8','4D','1V','WA']);
																//'MI','MT','OH','OK','NC','OR',

	dCourtOffenderOut					:= hygenics_crim.proc_build_crim_offender2_base;
	dCountyCourtOffenderOut		:= hygenics_crim.proc_build_county_crim_offender2_base;
	dDOCOffenderOut						:= hygenics_crim.proc_build_DOC_Offender_base(vendor not in ['EP']);
	                                                                   //'DV','DX','EE','EF',
																																		 
dCombined_DOC_and_CrimOffender
	:= dArrestOffenderOut
		+ dLNCourtOffenderOut
		+ dCourtOffenderOut
		+ dCountyCourtOffenderOut
		+ dDOCOffenderOut: persist('~thor20_241_10::persist::ln_offender_input_all');

Layout_Common_Crim_Offender assignClean(dCombined_DOC_and_CrimOffender l):= transform
	self.offender_persistent_id := 0;
	// self.nid										:= 0;
	// self.ntype									:= '';
	// self.nindicator							:= 0;
	self := l;
end;
	
all_recs := project(dCombined_DOC_and_CrimOffender, assignClean(left)):persist('~thor_200::persist::all_offender_pid');

/////////////////////////////////////////////////////
//Fix Image Links////////////////////////////////////
/////////////////////////////////////////////////////

	dsComb_DOC_and_CrimOff 	:= all_recs;

	ds_blank_image_recs 		:= sort(distribute(dsComb_DOC_and_CrimOff(trim(image_link,left,right) = ''), hash(state_origin, image_link)), state_origin, image_link, local);
	ds_nonblank_image_recs	:= dsComb_DOC_and_CrimOff(trim(image_link,left,right)<> '');
	
	ds_Sorted_AccurintFile 	:= sort(distribute(ds_nonblank_image_recs, hash(state_origin, image_link)), state_origin, image_link, local);
	Lookup_file 						:= sort(distribute(hygenics_images.File_Crim_Pics_Lookup(trim(image_file_name, left, right) <> ''), hash(state_of_origin, image_file_name)), state_of_origin, image_file_name, local);

	Layout_Common_Crim_Offender Clean_Image_Link_trf(Layout_Common_Crim_Offender l, Lookup_file r) := transform
		self.image_link 			:= if(trim(r.image_file_name,left,right) <> '', 
														l.image_link, 
														r.image_file_name);
		self 									:= l;	
	end;

	//Checking with the Image link lookup file to blank the main.image_link value if not found in the lookup file. 
	Clean_ds 				:= join(ds_Sorted_AccurintFile, Lookup_file, 
											trim(left.state_origin,left,right) = stringlib.StringToUpperCase(trim(right.state_of_origin,left,right)) and																										trim(left.image_link,left,right) = trim(right.image_file_name,left,right), 
											Clean_Image_Link_trf(left,right), left outer, local, keep(1));
											
dReCleanNamesAll 	:= clean_ds + ds_blank_image_recs;

	rCrimOffender2_WithDID := record
		Layout_Common_Crim_Offender;
		//unsigned6 	DID 		:= 0;
		//unsigned6 	PreGLB_DID 	:= 0;
	  end;
	  
	//add state origin to external linking
	add_orig_state_rec := record
		string2 temp_state;
		rCrimOffender2_WithDID;
	end;

	did_add.mac_add_orig_state(dReCleanNamesAll, add_orig_state_rec, zip5, state, state_origin, to_did)
/*
	//Flip names before DID process
	ut.mac_flipnames(to_did, fname, mname, lname, cleanFlipName);

	//DID
	lMatchSet := ['S','A','D'];

	did_Add.MAC_Match_Flex//_Sensitive  // Removed sensitive macro
		(cleanFlipName, lMatchSet,						
		 orig_ssn, dob, fname, mname,lname, name_suffix, 
		 prim_range, prim_name, sec_range, zip5, temp_state, phone_field, 
		 DID,
		 add_orig_state_rec,
		 false, DID_Score_field,
		 75,						//dids with a score below here will be dropped
		 dCrimOffender2_WithDID)

	rCrimOffender2_WithDID_SSN := record
		rCrimOffender2_WithDID;
		string9	ssn;
	end;

	rCrimOffender2_WithDID_SSN tUseSourceSSN(dCrimOffender2_WithDID pInput) := transform
		self.offender_key 	:= StringLib.StringToUpperCase(pInput.offender_key);
		self.ssn 			:= pInput.orig_ssn;
		self 				:= pInput;
	end;

	dCrimOffender2_WithDID_OrigSSN := project(dCrimOffender2_WithDID, tUseSourceSSN(left));

	DID_Add.MAC_Add_SSN_By_DID(dCrimOffender2_WithDID_OrigSSN, DID, SSN, dCrimOffender2_WithDID_PatchedSSN)

	hygenics_crim.Layout_Common_Crim_Offender_new tCreateMoxie(rCrimOffender2_WithDID_SSN pInput) := transform
		self.did 	:= intformat(pInput.did, 12, 1);
		self.pgid 	:= intformat(pInput.preGLB_DID, 12, 1);
		self 		:= pInput;
	end;

dPostDIDPrePatch := project(dCrimOffender2_WithDID_PatchedSSN(Nitro_Flag=''), tCreateMoxie(left));
*/

dPostDIDPrePatch := to_did;

	string fRemoveLeadingZeros(string pStringIn) //expects numbers only--TRIM IT FIRST!
		 := if(length(pStringIn)>=01,if(pStringIn[01]='0','',pStringIn[01]),'')
		 + if(length(pStringIn)>=02,if(pStringIn[01..02]='00','',pStringIn[02]),'')
		 + if(length(pStringIn)>=03,if(pStringIn[01..03]='000','',pStringIn[03]),'')
		 + if(length(pStringIn)>=04,if(pStringIn[01..04]='0000','',pStringIn[04]),'')
		 + if(length(pStringIn)>=05,if(pStringIn[01..05]='00000','',pStringIn[05]),'')
		 + if(length(pStringIn)>=06,if(pStringIn[01..06]='000000','',pStringIn[06]),'')
		 + if(length(pStringIn)>=07,if(pStringIn[01..07]='0000000','',pStringIn[07]),'')
		 + if(length(pStringIn)>=08,if(pStringIn[01..08]='00000000','',pStringIn[08]),'')
		 + if(length(pStringIn)>=09,if(pStringIn[01..09]='000000000','',pStringIn[09]),'')
		 + if(length(pStringIn)>=10,if(pStringIn[01..10]='0000000000','',pStringIn[10]),'')
		 + if(length(pStringIn)>=11,if(pStringIn[01..11]='00000000000','',pStringIn[11]),'')
		 + if(length(pStringIn)>=12,if(pStringIn[01..12]='000000000000','',pStringIn[12]),'')
		 ;

	hygenics_crim.Layout_Common_Crim_Offender_new tPostDIDPatch(to_did pInput) := transform
		self.Case_Type_Desc := if(pInput.Vendor = '01','Statewide Court', pInput.Case_Type_Desc);
		self.DID			:= '';
		self.PGID			:= '';
		self.FBI_Num	:= if(stringlib.stringfilterout(pInput.FBI_Num,'0') = ''
											 or stringlib.stringfilterout(pInput.FBI_Num,'X') = ''
											 or stringlib.stringfilterout(pInput.FBI_Num,'x') = '',
												'',
												fRemoveLeadingZeros(trim(pInput.FBI_Num))
											 );
		self.DLE_Num	:= if(stringlib.stringfilterout(pInput.DLE_Num,'0') = ''
											 or stringlib.stringfilterout(pInput.DLE_Num,'X') = ''
											 or stringlib.stringfilterout(pInput.DLE_Num,'x') = '',
												'',
												pInput.DLE_Num
											 );
		self.ID_Num		:= if(stringlib.stringfilterout(pInput.ID_Num,'0') = ''
											 or stringlib.stringfilterout(pInput.ID_Num,'X') = ''
											 or stringlib.stringfilterout(pInput.ID_Num,'x') = '',
												'',
												pInput.ID_Num
											 );
		self.SSN			:= ''; 
									
		self.fname		:= if(pInput.fname = '' and pInput.mname = '' and pInput.lname='',
												pInput.Pty_Nm,
												pInput.fname
											 );
		self.Pty_Typ	:= if(pInput.Pty_Typ = '2','2',
												if(pInput.Pty_Typ = '3','3',
												'0'));
		self					:= pInput;
	end;

dPostDIDPatched 						:= project(dPostDIDPrePatch,tPostDIDPatch(left));
dPostDIDPatchedDistributed 	:= distribute(dPostDIDPatched,hash(Offender_Key));
dGroupedPostDIDReady 				:= group(dPostDIDPatchedDistributed,Offender_Key,local);

	hygenics_crim.Macro_Fill_Blank_Offender_Traits(dGroupedPostDIDReady,FBI_Num,dGroupedPostDID_FBINum_Filled)
	hygenics_crim.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_FBINum_Filled,ID_Num,dGroupedPostDID_IDNum_Filled)
	hygenics_crim.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_IDNum_Filled,DLE_Num,dGroupedPostDID_DLENum_Filled)
	hygenics_crim.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_DLENum_Filled,Sex,dGroupedPostDID_Sex_Filled)
	hygenics_crim.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Sex_Filled,Race_Desc,dGroupedPostDID_Race_Desc_Filled)
	hygenics_crim.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Race_Desc_Filled,Hair_Color_Desc,dGroupedPostDID_Hair_Color_Desc_Filled)
	hygenics_crim.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Hair_Color_Desc_Filled,Eye_Color_Desc,dGroupedPostDID_Eye_Color_Desc_Filled)
	hygenics_crim.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Eye_Color_Desc_Filled,Skin_Color_Desc,dGroupedPostDID_Skin_Color_Desc_Filled)
	hygenics_crim.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Skin_Color_Desc_Filled,Place_Of_Birth,dGroupedPostDID_Place_Of_Birth_Filled)

	dSortedGroupedByDLData := sort(dGroupedPostDID_Place_Of_Birth_Filled,-DL_State,-DL_Num);
 
	hygenics_crim.Layout_Common_Crim_Offender_new tIterateTransform(hygenics_crim.Layout_Common_Crim_Offender_new pLeft, hygenics_crim.Layout_Common_Crim_Offender_new pRight) := transform
		self.DL_State := if(pLeft.DL_State <> '',pLeft.DL_State,pRight.DL_State);
		self.DL_Num	  := if(pLeft.DL_Num <> '',pLeft.DL_State,pRight.DL_Num);
		self		  := pRight;
	end;
 
dGroupedPostDID_DL_Data_Filled := iterate(dSortedGroupedByDLData,tIterateTransform(left,right));
dMoxieFile        := ungroup(dGroupedPostDID_DL_Data_Filled);
dMoxieFileDedup   := dedup(dMoxieFile,record, all);

EXPORT Out_Moxie_Crim_Offender2 := dMoxieFileDedup : persist('~thor_data400::persist::offender_rec');;