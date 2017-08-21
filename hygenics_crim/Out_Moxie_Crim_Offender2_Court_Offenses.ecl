/*2013-02-06T15:12:02Z (Vani Chikte_prod)
filter some dids that match the criteria
*/
import DID_Add, Header_Slimsort, ut, WatchDog, didville, Crim_Expunctions, lib_ziplib, Address, idl_header, crim_common, hygenics_images;

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
	dArrestOffensesOut				:= hygenics_crim.proc_build_arrest_offenses;
	
	LNOffense_layout := RECORD
	 hygenics_crim.Layout_Common_Court_Offenses AND NOT [sent_court_cost_orig, sent_court_fine_orig, sent_susp_court_fine_orig];
	end;
	
	//Pull LN Production Counties/Arrests that were not pulled from Hygenics	
		//lnOffenses				:= dataset(ut.foreign_prod+'~thor_data400::base::court_offenses_20120727', hygenics_crim.Layout_Common_Court_Offenses, flat);
		// lnOffenses				:= dataset(ut.foreign_prod+'~thor_data400::base::court_offenses_20120727', LNOffense_layout, flat);
		lnOffenses					:= hygenics_crim.File_In_Court_Offenses + hygenics_crim.File_In_Arrest_Offenses;
	
		hygenics_crim.Layout_Common_Court_Offenses stOffLayout2(lnOffenses l):= transform
		  self.offender_key     := StringLib.StringToUpperCase(l.offender_key);
      self.off_date			    := fFixDate(l.off_date);
      self.arr_date			    := fFixDate(l.arr_date);
      self.arr_disp_date		:= fFixDate(l.arr_disp_date);
      self.court_disp_date	:= fFixDate(l.court_disp_date);
      self.sent_date			:= fFixDate(l.sent_date);
      self.appeal_date		:= fFixDate(l.appeal_date);
		
			self.convict_dt			:= '';
			self.offense_town		:= '';
			self.cty_conv			  := '';
			self.restitution		:= '';
			self.community_service	:= '';
			self.parole				  := '';
			self.addl_sent_dates	:= '';
			self.Probation_desc2	:= '';
			self.court_dt			  := '';
			self.court_county		:= '';
			SELF.sent_court_cost_orig      := '';
      SELF.sent_court_fine_orig      := '';
      SELF.sent_susp_court_fine_orig := '';
			self 					:= l;
		end;
	
	dLNCourtOffensesOut			:= project(lnOffenses, stOffLayout2(left))(vendor in [//'02','03',
                    '1A',
										'1B','1I','1J','1L','1M','1N','1R','1S','1T','1U','1W','1X',
										'1Z','2A','2B','2C','2D','2E','2F','2H','2K','2L','2O','2Q',
										'2U','2V','2W','2X','2Y','2Z','3J','3K','3L','3N','3O','3R',
										'3Y','42','43','47','4D','55','63','64','73','77','78',
										'79','80','89','90','91','93','97','98','A3','A4','A7',
										'AP','AT','B7','D4','B8','75','1V','1E']);
	// dLNCourtOffensesOut     := lnOffenses(vendor in ['02','03','1A',
										// '1B','1I','1J','1L','1M','1N','1R','1S','1T','1U','1W','1X',
										// '1Z','2A','2B','2C','2D','2E','2F','2H','2K','2L','2O','2Q',
										// '2U','2V','2W','2X','2Y','2Z','3J','3K','3L','3N','3O','3R',
										// '3Y','42','43','47','4D','55','63','64','73','77','78',
										// '79','80','89','90','91','93','97','98','A3','A4','A7',
										// 'AP','AT','B7','D4','B8','75','1V','1E']);							
	
	dCourtOffensesOut 			:= hygenics_crim.proc_build_court_offenses_base(/*(vendor not in ['Z8','Z9']*/);
	dCountyCourtOffensesOut 	:= hygenics_crim.proc_build_county_court_offenses(/*vendor not in ['FD']*/);

dCombinedOffensesOut
	:= dArrestOffensesOut 
		+ dLNCourtOffensesOut
		+ dCourtOffensesOut 
		+ dCountyCourtOffensesOut;

///////////////////////////////////////////////////////////////////////////////////
//Create Offender File
///////////////////////////////////////////////////////////////////////////////////

	dArrestOffenderOut				:= hygenics_crim.proc_build_arrest_crim_offender2_base;	
		
	//Pull LN Production Counties/Arrests that were not pulled from Hygenics	
		
		// lnOffender				:= dataset(ut.foreign_prod+'~thor_data400::base::crim_offender2_did_20120727', Crim_Common.Layout_Moxie_Crim_Offender2.previous, flat);
		lnOffender          := hygenics_crim.File_in_LN_offender_preprocess;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		hygenics_crim.Layout_Common_Crim_Offender_temp stOffndrLayout2(lnOffender l) := transform
			//self.ssn				:= '';
			//self.did				:= '';
			self.pgid				:= '';
			self.src_upload_date	:= '';
			self.age				:= '';
			self.image_link			:= '';
			self 					:= l;
		end;
	
	dLNCourtOffenderOut			:= project(lnOffender, stOffndrLayout2(left))(vendor in [//'02','03',
	                  '1A',
										'1B','1I','1J','1L','1M','1N','1R','1S','1T','1U','1W','1X',
										'1Z','2A','2B','2C','2D','2E','2F','2H','2K','2L','2O','2Q',
										'2U','2V','2W','2X','2Y','2Z','3J','3K','3L','3N','3O','3R',
										'3Y','42','43','47','4D','55','63','64','73','77','78',
										'79','80','89','90','91','93','97','98','A3','A4','A7',
										'AP','AT','B7','D4','B8','75','1V','1E','WA']);
	                  //'MI','MT','OH','OK','NC','OR',
	dCourtOffenderOut			:= hygenics_crim.proc_build_crim_offender2_base(/*vendor not in ['Z8','Z9']*/);
	dCountyCourtOffenderOut		:= hygenics_crim.proc_build_county_crim_offender2_base(/*vendor not in ['FD']*/);
	dDOCOffenderOut				:= hygenics_crim.proc_build_DOC_Offender_base(vendor not in ['EP']);
	                                                                   //'DV','DX','EE','EF', 'EV','EG',
	
dCombined_DOC_and_CrimOffender
	:= dArrestOffenderOut
		+ dLNCourtOffenderOut
		+ dCourtOffenderOut
		+ dCountyCourtOffenderOut
		+ dDOCOffenderOut;

//Fix Image Links////////////////////////////////////

	dsComb_DOC_and_CrimOff 	:= dCombined_DOC_and_CrimOffender;

	ds_blank_image_recs 	:= sort(distribute(dsComb_DOC_and_CrimOff(trim(image_link,left,right) = ''), hash(state_origin, image_link)), state_origin, image_link, local);
	ds_nonblank_image_recs	:= dsComb_DOC_and_CrimOff(trim(image_link,left,right)<> '');
	
	ds_Sorted_AccurintFile 	:= sort(distribute(ds_nonblank_image_recs, hash(state_origin, image_link)), state_origin, image_link, local);
	Lookup_file 			:= sort(distribute(hygenics_images.File_Crim_Pics_Lookup(trim(image_file_name, left, right) <> ''), hash(state_of_origin, image_file_name)), state_of_origin, image_file_name, local);

	hygenics_crim.Layout_Common_Crim_Offender_temp Clean_Image_Link_trf(hygenics_crim.Layout_Common_Crim_Offender_temp l, Lookup_file r) := transform
		self.image_link 	:= if(trim(r.image_file_name,left,right) <> '', 
									l.image_link, 
									r.image_file_name);
		self 				:= l;	
	end;

	//Checking with the Image link lookup file to blank the main.image_link value if not found in the lookup file. 
	Clean_ds 				:= join(ds_Sorted_AccurintFile, Lookup_file, 
									trim(left.state_origin,left,right) = stringlib.StringToUpperCase(trim(right.state_of_origin,left,right)) and																										trim(left.image_link,left,right) = trim(right.image_file_name,left,right), 
									Clean_Image_Link_trf(left,right), left outer, local, keep(1));
									
dCombined_DOC_and_CrimOffender2 	:= clean_ds + ds_blank_image_recs;
	
//Apply New Offender Layout//////////////////////////

	rNewOffenderLayout :=record
	  hygenics_crim.Layout_Common_Crim_Offender_temp;
	  string8	file_date; 					//new field
	  string13	county_of_birth; 			//new field
	  string13	current_residence_county; 	//new field
	  string13	legal_residence_county; 	//new field
	  string10	scars_marks_tattoos_1; 		//new field
	  string10	scars_marks_tattoos_2; 		//new field
	  string10	scars_marks_tattoos_3; 		//new field
	  string10	scars_marks_tattoos_4; 		//new field
	  string10	scars_marks_tattoos_5; 		//new field
	  string10	_3g_offender; 				//new field
	  string10	violent_offender; 			//new field
	  string10	sex_offender; 				//new field
	  string10	vop_offender; 				//new field
	  string26	record_setup_date; 			//new field
		UNSIGNED4   xadl2_keys_used   := 0 ; //VC 20120204
    INTEGER2    xadl2_weight      := 0 ;
    UNSIGNED2   xadl2_Score       := 0 ;
    UNSIGNED2   xadl2_distance    := 0 ;
    String22    xadl2_matches     := '';
	end;

	rNewOffenderLayout tCrimOffenderNewLayout(dCombined_DOC_and_CrimOffender2 pInput) := transform
		self.file_date					:='';
		self.county_of_birth			:='';
		self.current_residence_county	:='';
		self.legal_residence_county		:='';
		self.scars_marks_tattoos_1		:='';
		self.scars_marks_tattoos_2		:='';
		self.scars_marks_tattoos_3		:='';
		self.scars_marks_tattoos_4		:='';
		self.scars_marks_tattoos_5		:='';
		self._3g_offender				:='';
		self.violent_offender			:='';
		self.sex_offender				:='';
		self.vop_offender				:='';
		self.record_setup_date			:='';
		self 							:= pInput;
	end;

dCombined_DOC_and_CrimOffender2_New_Layout 	:= project(dCombined_DOC_and_CrimOffender2, tCrimOffenderNewLayout(left));
dConcatCrim_and_DOC_NewLayout 				:= dCombined_DOC_and_CrimOffender2_New_Layout;
dReCleanNamesAll 							:= dConcatCrim_and_DOC_NewLayout :persist('persist::crim::hd::Combined_offender');

	rCrimOffender2_WithDID := record
		rNewOffenderLayout;
		unsigned6 	DID 		:= 0;
		unsigned6 	PreGLB_DID 	:= 0;

	  end;
	  
	//add state origin to external linking
	add_orig_state_rec := record
		string2 temp_state;
		rCrimOffender2_WithDID;

	end;

	did_add.mac_add_orig_state(dReCleanNamesAll, add_orig_state_rec, zip5, state, state_origin, to_did)

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

dCrimOffender2_FixDID := 
project( dCrimOffender2_WithDID, transform({dCrimOffender2_WithDID},
               mymatches := DID_Add.matches(left.xadl2_matches);
               self.did := if(
                                 mymatches.isFirstMatch 
                                and mymatches.isLastMatch 
                                and mymatches.isDOBMatch 
                                and not mymatches.isPrimRangeMatch
                                and not mymatches.isPrimNameMatch
                                and not mymatches.isSecRangeMatch
                                and not mymatches.isCityMatch
                                and not mymatches.isStateMatch
                                and not mymatches.isZipMatch
                                and not mymatches.isSSN5Match
                                and not mymatches.isSSN4Match
                                and not mymatches.isPhoneMatch
                                and left.xadl2_weight <= 46
                        ,0, left.did);

               self := left; ));


	rCrimOffender2_WithDID_SSN := record
		rCrimOffender2_WithDID;
		string9	ssn;
	end;

	rCrimOffender2_WithDID_SSN tUseSourceSSN(dCrimOffender2_FixDID pInput) := transform
		self.offender_key 	:= StringLib.StringToUpperCase(pInput.offender_key);
		self.ssn 			:= pInput.orig_ssn;
		self 				:= pInput;
	end;

	dCrimOffender2_WithDID_OrigSSN := project(dCrimOffender2_FixDID, tUseSourceSSN(left));

	DID_Add.MAC_Add_SSN_By_DID(dCrimOffender2_WithDID_OrigSSN, DID, SSN, dCrimOffender2_WithDID_PatchedSSN)

	hygenics_crim.Layout_Common_Crim_Offender_new tCreateMoxie(rCrimOffender2_WithDID_SSN pInput) := transform
		self.did 	:= intformat(pInput.did, 12, 1);
		self.pgid 	:= intformat(pInput.preGLB_DID, 12, 1);
		self 		:= pInput;
	end;

dPostDIDPrePatch := project(dCrimOffender2_WithDID_PatchedSSN(Nitro_Flag=''), tCreateMoxie(left));

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

	hygenics_crim.Layout_Common_Crim_Offender_new tPostDIDPatch(hygenics_crim.Layout_Common_Crim_Offender_new pInput) := transform
		self.Case_Type_Desc := if(pInput.Vendor = '01','Statewide Court', pInput.Case_Type_Desc);
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
	end;

dPostDIDPatched 			:= project(dPostDIDPrePatch,tPostDIDPatch(left));
dPostDIDPatchedDistributed 	:= distribute(dPostDIDPatched,hash(Offender_Key));
dGroupedPostDIDReady 		:= group(dPostDIDPatchedDistributed,Offender_Key,local);

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
dMoxieFile                     := ungroup(dGroupedPostDID_DL_Data_Filled);
dMoxieFileDedup                := dedup(dMoxieFile,record,all) : persist('~thor_data400::persist::temp_offnd_hyg');


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

hygenics_crim.Layout_Common_Crim_Offender_new JoinKeys(hygenics_crim.Layout_Common_Crim_Offender_new L, allExp R) 
 := TRANSFORM
	self := L;
 end;

offnd_dMoxieFileDedup2 :=
	JOIN(offnd, allExp, 
			LEFT.offender_key=RIGHT.offender_key, JoinKeys(left, right), left only, lookup);

offnd_hard_code_did_removals := hygenics_crim.fn_blank_the_did(offnd_dMoxieFileDedup2);			
//END EXPUNGE -- Offender

///////////////////////////////////////////////////////////////////////////

hygenics_crim.Layout_Common_Court_Offenses JoinKeys2(hygenics_crim.Layout_Common_Court_Offenses L, allExp R) 
 := TRANSFORM
	self := L;
 end;

offns_dMoxieFileDedup2 :=
	JOIN(offns, allExp, 
			LEFT.offender_key=RIGHT.offender_key, JoinKeys2(left, right), left only, lookup);
//END EXPUNGE -- Offenses



//LifeEIR
	oldOffdrLayout := record
		hygenics_crim.Layout_Common_Crim_Offender2.previous;
		string9 	ssn;
		string12 	did;
		string12 	pgid;
	end;
	
	//Reformat Offender to Old Moxie Layout
	oldOffdrLayout rOffenderOldLayout(dMoxieFileDedup pInput) := TRANSFORM
		self := pInput;
	end;

dOldOffenderMoxieLayout := project(offnd_hard_code_did_removals, rOffenderOldLayout(Left));

//Output Offender and Offenses files
export Out_Moxie_Crim_Offender2_Court_Offenses := sequential(
	output(jrecs2,,'~thor_data400::base::cv_suppressions::found',overwrite),
	output(dOldOffenderMoxieLayout,, Crim_Common.Name_Moxie_Crim_Offender2_Dev, overwrite,__compressed__), //old layout offender
	output(offnd_hard_code_did_removals,, Crim_Common.Name_Moxie_Crim_Offender2_Dev +'_new',overwrite,__compressed__), //new layout offender
	output(offns_dMoxieFileDedup2,, Crim_Common.Name_Moxie_Court_Offenses_Dev, overwrite,__compressed__));
