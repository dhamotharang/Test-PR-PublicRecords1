import DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville;
/*
rCrimOffender2_WithDID
 :=
  record
	Layout_In_Court_Offender;
	unsigned6 	DID 		:= 0;
	unsigned6 	PreGLB_DID 	:= 0;
  end
 ;

dCombined_DOC_and_CrimOffender2
 := File_In_Court_Offender
 +	DOC_Offender_as_Offender2
 +  File_In_Arrest_Offender
 ;

lMatchSet := ['S','A','D'];

did_Add.MAC_Match_Flex//_Sensitive  // Removed sensitive macro
	(dCombined_DOC_and_CrimOffender2, lMatchSet,						
	 orig_ssn, dob, fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, state, phone_field, 
	 DID,
	 rCrimOffender2_WithDID,
	 false, DID_Score_field,
	 75,						//dids with a score below here will be dropped
	 dCrimOffender2_WithDID
	)

rCrimOffender2_WithDID_SSN
 :=
  record
	rCrimOffender2_WithDID;
	string9		ssn;
  end
;

rCrimOffender2_WithDID_SSN tUseSourceSSN(rCrimOffender2_WithDID pInput)
 :=
  transform
    self.offender_key := StringLib.StringToUpperCase(pInput.offender_key);
	self.ssn 	:= pInput.orig_ssn;
	self 		:= pInput;
  end
 ;

dCrimOffender2_WithDID_OrigSSN := project(dCrimOffender2_WithDID, tUseSourceSSN(left));

DID_Add.MAC_Add_SSN_By_DID(dCrimOffender2_WithDID_OrigSSN, DID, SSN, dCrimOffender2_WithDID_PatchedSSN)

Layout_Moxie_Crim_Offender2 tCreateMoxie(rCrimOffender2_WithDID_SSN pInput)
 :=
  transform
	self.did 	:= intformat(pInput.did, 12, 1);
	self.pgid 	:= intformat(pInput.preGLB_DID, 12, 1);
	self 		:= pInput;
  end
 ;

dPostDIDPrePatch := project(dCrimOffender2_WithDID_PatchedSSN(Nitro_Flag=''), tCreateMoxie(left));

string fRemoveLeadingZeros(string pStringIn) //expects numbers only--TRIM IT FIRST!
 :=
   if(length(pStringIn)>=01,if(pStringIn[01]='0','',pStringIn[01]),'')
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

Layout_Moxie_Crim_Offender2 tPostDIDPatch(Layout_Moxie_Crim_Offender2 pInput)
 :=
  transform
	self.Case_Type_Desc := if(pInput.Vendor = '01','Statewide Court',pInput.Case_Type_Desc);
	self.DID			:= if(pInput.Pty_Typ= '2' or pInput.DID = '000000000000','',pInput.DID);
	self.PGID			:= if(pInput.Pty_Typ= '2' or pInput.PGID = '000000000000','',pInput.PGID);
	self.FBI_Num		:= if(lib_stringlib.stringlib.stringfilterout(pInput.FBI_Num,'0') = ''
						   or lib_stringlib.stringlib.stringfilterout(pInput.FBI_Num,'X') = ''
						   or lib_stringlib.stringlib.stringfilterout(pInput.FBI_Num,'x') = '',
							  '',
							  fRemoveLeadingZeros(trim(pInput.FBI_Num))
							 );
	self.DLE_Num		:= if(lib_stringlib.stringlib.stringfilterout(pInput.DLE_Num,'0') = ''
						   or lib_stringlib.stringlib.stringfilterout(pInput.DLE_Num,'X') = ''
						   or lib_stringlib.stringlib.stringfilterout(pInput.DLE_Num,'x') = '',
							  '',
							  pInput.DLE_Num
							 );
	self.ID_Num			:= if(lib_stringlib.stringlib.stringfilterout(pInput.ID_Num,'0') = ''
						   or lib_stringlib.stringlib.stringfilterout(pInput.ID_Num,'X') = ''
						   or lib_stringlib.stringlib.stringfilterout(pInput.ID_Num,'x') = '',
							  '',
							  pInput.ID_Num
							 );
	self.SSN			:= if(lib_stringlib.stringlib.stringfilterout(pInput.SSN,'0') = ''
						   or lib_stringlib.stringlib.stringfilterout(pInput.SSN,'X') = ''
						   or lib_stringlib.stringlib.stringfilterout(pInput.SSN,'x') = '',
							  '',
							  if(pInput.Pty_Typ = '2',pInput.orig_SSN,pInput.SSN)
							 );
	self.fname			:= if(pInput.fname = '' and pInput.mname = '' and pInput.lname='',
							  pInput.Pty_Nm,
							  pInput.fname
							 );
	self.Pty_Typ		:= if(pInput.Pty_Typ = '2','2','0');
	self				:= pInput;
  end
 ;

dPostDIDPatched 			:= project(dPostDIDPrePatch,tPostDIDPatch(left));
dPostDIDPatchedDistributed 	:= distribute(dPostDIDPatched,hash(Offender_Key));
dGroupedPostDIDReady 		:= group(dPostDIDPatchedDistributed,Offender_Key,local);

Crim_Common.Macro_Fill_Blank_Offender_Traits(dGroupedPostDIDReady,FBI_Num,dGroupedPostDID_FBINum_Filled)
Crim_Common.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_FBINum_Filled,ID_Num,dGroupedPostDID_IDNum_Filled)
Crim_Common.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_IDNum_Filled,DLE_Num,dGroupedPostDID_DLENum_Filled)
Crim_Common.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_DLENum_Filled,Sex,dGroupedPostDID_Sex_Filled)
Crim_Common.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Sex_Filled,Race_Desc,dGroupedPostDID_Race_Desc_Filled)
Crim_Common.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Race_Desc_Filled,Hair_Color_Desc,dGroupedPostDID_Hair_Color_Desc_Filled)
Crim_Common.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Hair_Color_Desc_Filled,Eye_Color_Desc,dGroupedPostDID_Eye_Color_Desc_Filled)
Crim_Common.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Eye_Color_Desc_Filled,Skin_Color_Desc,dGroupedPostDID_Skin_Color_Desc_Filled)
Crim_Common.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Skin_Color_Desc_Filled,Place_Of_Birth,dGroupedPostDID_Place_Of_Birth_Filled)

dSortedGroupedByDLData := sort(dGroupedPostDID_Place_Of_Birth_Filled,-DL_State,-DL_Num);
 
Layout_Moxie_Crim_Offender2 tIterateTransform(Layout_Moxie_Crim_Offender2 pLeft, Layout_Moxie_Crim_Offender2 pRight)
 :=
  transform
	self.DL_State := if(pLeft.DL_State <> '',pLeft.DL_State,pRight.DL_State);
	self.DL_Num	  := if(pLeft.DL_Num <> '',pLeft.DL_State,pRight.DL_Num);
	self		  := pRight;
  end
 ;
 

dGroupedPostDID_DL_Data_Filled := iterate(dSortedGroupedByDLData,tIterateTransform(left,right));
dMoxieFile                     := ungroup(dGroupedPostDID_DL_Data_Filled);
dMoxieFileDedup                := dedup(dMoxieFile,record,all);

//--- EXPUNGE RECORDS 20070111 CNG

expunge_offender_key_layout
 :=
  record
	string60 offender_key;
  end;

expunge_offender_key := dataset('~thor_data400::in::expunge_offender_key', expunge_offender_key_layout, flat);

//dedup_expunge_offender_key:= dedup(Crim_Common.Expunge_Offender_Key_List, ALL);
dedup_expunge_offender_key:= dedup(expunge_offender_key, ALL);

Crim_Common.Layout_Moxie_Crim_Offender2 JoinKeys(Crim_Common.Layout_Moxie_Crim_Offender2 L, expunge_offender_key_layout R) 
 := TRANSFORM
	self := L;
 end;

dMoxieFileDedup2 :=
	JOIN(dMoxieFileDedup, dedup_expunge_offender_key, 
			LEFT.offender_key=RIGHT.offender_key, JoinKeys(left, right), left only, lookup);
			
//END EXPUNGE

hard_code_did_removals := crim_common.fn_blank_the_did(dMoxieFileDedup2);

export Out_Moxie_Crim_Offender2 := output(hard_code_did_removals,,Crim_Common.Name_Moxie_Crim_Offender2_Dev,Overwrite);
*/
