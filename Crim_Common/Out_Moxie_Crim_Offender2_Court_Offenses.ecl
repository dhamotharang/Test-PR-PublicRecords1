import DID_Add, Header_Slimsort, ut, WatchDog, didville, Crim_Expunctions;
///////////////////////////////////////////////////////////////////////////////////
//Create Offense file
///////////////////////////////////////////////////////////////////////////////////
string8 fFixDate(string8 pDateIn)
 := if(stringlib.StringFilter(pDateIn,'0123456789') <> pDateIn
	or (integer8)pDateIn = 0,
	   '',
	   pDateIn
	  )
 ;

Crim_Common.Layout_Moxie_Court_Offenses tCourtOffensesInToOut(Crim_Common.Layout_In_Court_Offenses pInput)
 :=
  transform
    self.offender_key       := StringLib.StringToUpperCase(pInput.offender_key);
    self.off_date			:= fFixDate(pInput.off_date);
    self.arr_date			:= fFixDate(pInput.arr_date);
    self.arr_disp_date		:= fFixDate(pInput.arr_disp_date);
    self.court_disp_date	:= fFixDate(pInput.court_disp_date);
    self.sent_date			:= fFixDate(pInput.sent_date);
    self.appeal_date		:= fFixDate(pInput.appeal_date);
	self := pInput;
  end
 ;

dCourtOffensesOut := project(Crim_Common.File_In_Court_Offenses,tCourtOffensesInToOut(left));
dArrestOffensesOut:= project(Crim_Common.File_In_Arrest_Offenses,tCourtOffensesInToOut(left));

dCombinedOffensesOut
 := dCourtOffensesOut
 +	dArrestOffensesOut
 ;

///////////////////////////////////////////////////////////////////////////////////
//Create Offender File
///////////////////////////////////////////////////////////////////////////////////

dCombined_DOC_and_CrimOffender2
 := Crim_Common.File_In_Court_Offender
 +	Crim_Common.DOC_Offender_as_Offender2
 +  Crim_Common.File_In_Arrest_Offender
 ;

//Apply New Offender Layout//////////////////////////

rNewOffenderLayout 
 :=
  record
  Crim_Common.Layout_In_Court_Offender;
  string8	file_date; //new field
  string13	county_of_birth; //new field
  string13	current_residence_county; //new field
  string13	legal_residence_county; //new field
  string10	scars_marks_tattoos_1; //new field
  string10	scars_marks_tattoos_2; //new field
  string10	scars_marks_tattoos_3; //new field
  string10	scars_marks_tattoos_4; //new field
  string10	scars_marks_tattoos_5; //new field
  string10	_3g_offender; //new field
  string10	violent_offender; //new field
  string10	sex_offender; //new field
  string10	vop_offender; //new field
  string26	record_setup_date; //new field
  end
  ;

rNewOffenderLayout tCrimOffenderNewLayout(dCombined_DOC_and_CrimOffender2 pInput)
 :=
  transform
	self.file_date:='';
	self.county_of_birth:='';
	self.current_residence_county:='';
	self.legal_residence_county:='';
	self.scars_marks_tattoos_1:='';
	self.scars_marks_tattoos_2:='';
	self.scars_marks_tattoos_3:='';
	self.scars_marks_tattoos_4:='';
	self.scars_marks_tattoos_5:='';
	self._3g_offender:='';
	self.violent_offender:='';
	self.sex_offender:='';
	self.vop_offender:='';
	self.record_setup_date:='';
	self := pInput;
  end
 ;

dCombined_DOC_and_CrimOffender2_New_Layout := project(dCombined_DOC_and_CrimOffender2, tCrimOffenderNewLayout(left));

//Conform TX DOC Offenders to New Standard Layout//////////////////////
dTXDOC := File_In_Court_Offender_TX_OAG;

rNewOffenderLayout tTXDOCNewLayout(dTXDOC pInput)
 :=
  transform
	self.state_origin := pInput.vendor;
	self.case_court := '';
	self.case_number:= '';
	self.case_name 	:= '';
	self.case_type_desc := 'Department of Corrections';
	self.case_type 	:= '';
	self.case_filing_dt := '';
	self.dl_num 	:= '';
	self.dl_state 	:= '';
	self.Height		:= if((integer2)pInput.Height = 0,'',pInput.Height);
	self.Weight		:= if((integer2)pInput.Weight = 0,'',pInput.Weight);
	self := pInput;
  end
 ;

dTXDOC_NewLayout := project(dTXDOC, tTXDOCNewLayout(left));

//Concat Crim & DOC Offenders into New Layout 
dConcatCrim_and_DOC_NewLayout := dCombined_DOC_and_CrimOffender2_New_Layout + dTXDOC_NewLayout;

rCrimOffender2_WithDID
 :=
  record
	rNewOffenderLayout;
	unsigned6 	DID 		:= 0;
	unsigned6 	PreGLB_DID 	:= 0;
  end
 ;

//DID

lMatchSet := ['S','A','D'];

did_Add.MAC_Match_Flex//_Sensitive  // Removed sensitive macro
	(dConcatCrim_and_DOC_NewLayout, lMatchSet,						
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

Crim_Common.Layout_Moxie_Crim_Offender2.new tCreateMoxie(rCrimOffender2_WithDID_SSN pInput)
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

Crim_Common.Layout_Moxie_Crim_Offender2.new tPostDIDPatch(Crim_Common.Layout_Moxie_Crim_Offender2.new pInput)
 :=
  transform
	self.Case_Type_Desc := if(pInput.Vendor = '01','Statewide Court',pInput.Case_Type_Desc);
	self.DID			:= if(pInput.Pty_Typ= '2' or pInput.DID = '000000000000','',pInput.DID);
	self.PGID			:= if(pInput.Pty_Typ= '2' or pInput.PGID = '000000000000','',pInput.PGID);
	self.FBI_Num		:= if(stringlib.stringfilterout(pInput.FBI_Num,'0') = ''
						   or stringlib.stringfilterout(pInput.FBI_Num,'X') = ''
						   or stringlib.stringfilterout(pInput.FBI_Num,'x') = '',
							  '',
							  fRemoveLeadingZeros(trim(pInput.FBI_Num))
							 );
	self.DLE_Num		:= if(stringlib.stringfilterout(pInput.DLE_Num,'0') = ''
						   or stringlib.stringfilterout(pInput.DLE_Num,'X') = ''
						   or stringlib.stringfilterout(pInput.DLE_Num,'x') = '',
							  '',
							  pInput.DLE_Num
							 );
	self.ID_Num			:= if(stringlib.stringfilterout(pInput.ID_Num,'0') = ''
						   or stringlib.stringfilterout(pInput.ID_Num,'X') = ''
						   or stringlib.stringfilterout(pInput.ID_Num,'x') = '',
							  '',
							  pInput.ID_Num
							 );
	self.SSN			:= if(stringlib.stringfilterout(pInput.SSN,'0') = ''
						   or stringlib.stringfilterout(pInput.SSN,'X') = ''
						   or stringlib.stringfilterout(pInput.SSN,'x') = '',
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
 
Crim_Common.Layout_Moxie_Crim_Offender2.new tIterateTransform(Crim_Common.Layout_Moxie_Crim_Offender2.new pLeft, Crim_Common.Layout_Moxie_Crim_Offender2.new pRight)
 :=
  transform
	self.DL_State := if(pLeft.DL_State <> '',pLeft.DL_State,pRight.DL_State);
	self.DL_Num	  := if(pLeft.DL_Num <> '',pLeft.DL_State,pRight.DL_Num);
	self		  := pRight;
  end
 ;
 

dGroupedPostDID_DL_Data_Filled := iterate(dSortedGroupedByDLData,tIterateTransform(left,right));
dMoxieFile                     := ungroup(dGroupedPostDID_DL_Data_Filled);
dMoxieFileDedup                := dedup(dMoxieFile,record,all) : persist('~thor_data400::persist::temp_offnd');




///////////////////////////////////////////////////////////
//Remove Expunctions
///////////////////////////////////////////////////////////
offns := dCombinedOffensesOut;
offnd := dMoxieFileDedup;

///////////////////////////////////////////////////////////
//Court Ventures Expunction List -- ttg 4/20/2009
///////////////////////////////////////////////////////////
cvExp := Crim_Expunctions.File_Court_Venture_Suppressions;
newLayout1 := record
string cvExp_source_file;
string20 cvExp_lname;
string20 cvExp_fname;
string20 cvExp_mname;
offns.offender_key;
offns.court_case_number;
end;
	
newLayout1 trecs(offns L, cvExp R) := transform
self.cvExp_source_file := R.source_file;
self.cvExp_lname := R.lname;
self.cvExp_fname := R.fname;
self.cvExp_mname := R.mname;
self := L;
end;

jrecs := join(offns(court_case_number<>''), cvExp, // get expunged offense record
				left.court_case_number = right.cau_nbr,
				trecs(left,right),lookup);
//------------------------------------------------------
newLayout2 := record   //expunction table layout
jrecs.cvExp_source_file;
string35 offns_court_case_number;
offnd.offender_key;
string60 offns_offender_key;
offnd.lname;
jrecs.cvExp_lname;
offnd.fname;
jrecs.cvExp_fname;
offnd.mname;
jrecs.cvExp_mname;
end;
				
newLayout2 trecs2(offnd L, jrecs R) := transform
self.cvExp_source_file := R.cvExp_source_file;
self.cvExp_lname := R.cvExp_lname;
self.cvExp_fname := R.cvExp_fname;
self.cvExp_mname := R.cvExp_mname;
self.offns_offender_key := R.offender_key;
self.offns_court_case_number := R.court_case_number;
self := L;
end;

jrecs2 := join(distribute(offnd(lname+fname<>''),hash(offender_key)), distribute(jrecs,hash(offender_key)),  // get corresponding offender record 
				left.offender_key = right.offender_key and
				left.lname = right.cvExp_lname and 
				left.fname = right.cvExp_fname,
				trecs2(left,right),local);
				
///////////////////////////////////////////////////////////
//--- EXPUNGE RECORDS 20070111 CN
///////////////////////////////////////////////////////////
dedup_expunge_offender_key:= dedup(Crim_Expunctions.File_MiscflaggedinNameField, ALL);

jrecs2 cmbnRecs(dedup_expunge_offender_key L) := transform

self := L;
self := [];
end;

precs := project(dedup_expunge_offender_key,cmbnRecs(Left));

//Combine Expunction Files	
allExp := precs+jrecs2;

Crim_Common.Layout_Moxie_Crim_Offender2.new JoinKeys(Crim_Common.Layout_Moxie_Crim_Offender2.new L, allExp R) 
 := TRANSFORM
	self := L;
 end;

offnd_dMoxieFileDedup2 :=
	JOIN(offnd, allExp, 
			LEFT.offender_key=RIGHT.offender_key, JoinKeys(left, right), left only, lookup);
offnd_hard_code_did_removals := crim_common.fn_blank_the_did(offnd_dMoxieFileDedup2);			
//END EXPUNGE -- Offender


Crim_Common.Layout_Moxie_Court_Offenses JoinKeys2(Crim_Common.Layout_Moxie_Court_Offenses L, allExp R) 
 := TRANSFORM
	self := L;
 end;

offns_dMoxieFileDedup2 :=
	JOIN(offns, allExp, 
			LEFT.offender_key=RIGHT.offender_key, JoinKeys2(left, right), left only, lookup);
//END EXPUNGE -- Offenses

//Reformat Offender to Old Moxie Layout
Crim_Common.Layout_Moxie_Crim_Offender2.previous rOffenderOldLayout(offnd_hard_code_did_removals pInput) 
 := TRANSFORM
	self := pInput;
 end;

dOldOffenderMoxieLayout := project(offnd_hard_code_did_removals,rOffenderOldLayout(Left));

//Output Offender and Offenses files
export Out_Moxie_Crim_Offender2_Court_Offenses := 
sequential(
	output(jrecs2,,'~thor_data400::base::cv_suppressions::found',overwrite),
	output(dOldOffenderMoxieLayout,,Crim_Common.Name_Moxie_Crim_Offender2_Dev,overwrite), //old layout offender
	output(offnd_hard_code_did_removals,,Crim_Common.Name_Moxie_Crim_Offender2_Dev +'_new',overwrite), //new layout offender
	output(offns_dMoxieFileDedup2,,Crim_Common.Name_Moxie_Court_Offenses_Dev,overwrite));


