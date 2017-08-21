import crimsrch, crim_common, DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville,lib_ziplib,corrections;

dCombined_Crim			:=	Crim_Offender2_as_CrimSrch_Offender;

	// rCombined_Crim_ForADL := record
		// corrections.layout_offender;
		// unsigned6	temp_did;
		// UNSIGNED4   xadl2_keys_used   := 0 ; //VC 20130204
    // INTEGER2    xadl2_weight      := 0 ;
    // UNSIGNED2   xadl2_Score       := 0 ;
    // UNSIGNED2   xadl2_distance    := 0 ;
    // String22    xadl2_matches     := '';// VC end
	// end;

	Layout_OffenderWithADLFields tBlankDIDandSSN(dCombined_Crim pInput):= transform
		self.did			:=	'';
		self.ssn			:=	'';
		self.temp_did	:=	0;
		self					:=	pInput;
	end;

dCombined_Crim_PreDID	:=	project(dCombined_Crim,tBlankDIDandSSN(left)):persist('~thor_200::persist::combined_Crim_PreDID');

//add origin state to XADL DOB matching

	add_orig_state_rec := record
		string2 temp_state;
		Layout_OffenderWithADLFields;
	end;

DID_add.mac_add_orig_state(dCombined_Crim_PreDID, add_orig_state_rec, zip5, st, orig_state, add_orig_state) 

pnameRec := add_orig_state(pty_typ='0'); 	//pull primary records only
anameRec := add_orig_state(pty_typ<>'0');

lMatchSet := ['S','A','D'];
DID_Add.MAC_Match_Flex_V2 
//did_Add.MAC_Match_Flex//_Sensitive  // NOTE <- removed sensitive macro 4/15/2008
	(pnameRec, lMatchSet,						
	 ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, temp_state, fake_phone_field, 
	 temp_did,
	 add_orig_state_rec,
	 false, fake_DID_Score_field,
	 75,						//dids with a score below here will be dropped
	 dCombined_Crim_WithDID,
	 ,,// bool_infile_has_name_source = 'false', src_field = '',	 
	 ,,// bool_outrec_has_indiv_scores='false', score_n_field = 'score_n',
	 ,// bool_clean_addr = 'false',  
	 ,,,// predir_field = 'predir',addr_suffix_field = 'addr_suffix',postdir_field = 'postdir',
	 ,,,// udesig_field = 'unit_desig',city_field = 'p_city_name', zip4_field = 'zip4',
	 true,,,false// bool_switch_priority = 'true', weight_threshold=30, distance=3, segmentation=false
	 ) 
		

dCombined_Crim_SexPred_FixDID := project(dCombined_Crim_WithDID,  transform({dCombined_Crim_WithDID},
                                                 mymatches := DID_Add.matches(left.xadl2_matches);
                                                 self.temp_DID := if(
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
																																,0, left.temp_DID);
																
																								 self := left; )):persist('~thor_200::persist::combined_Crim_postDID');

allRecs := dCombined_Crim_SexPred_FixDID + anameRec;

	Layout_OffenderWithADLFields tUseSourceSSN(allRecs pInput) := transform
		self.ssn 		:= pInput.ssn;
		self.did 		:= if(pInput.pty_typ in ['2','3'] or pInput.temp_DID = 0,
							  '',
							  intformat(pInput.temp_did, 12, 1));
		self.temp_did 	:= if(pInput.pty_typ in ['2','3'] or pInput.temp_DID = 0,
							  0,
							  pInput.temp_did);
		self 		:= pInput;
	end;

dCrimOffender2_WithDID_OrigSSN := project(allRecs, tUseSourceSSN(left));

DID_Add.MAC_Add_SSN_By_DID(dCrimOffender2_WithDID_OrigSSN, temp_DID, SSN, dCrimOffender2_WithDID_PatchedSSN)

set_off := ['V','I','C','T'];

//we want to keep the ADL fields as we need to filter out certain dids from FCRA only VC 20170216
	Layout_OffenderWithADLFields tCreateMoxie(dCrimOffender2_WithDID_PatchedSSN pInput) := transform
		self.ssn_appended 			:= pInput.ssn;
		self.fcra_traffic_flag 	:= if(pInput.offense_score in set_Off,
										'Y',
										pInput.fcra_traffic_flag );
		self.src_upload_date 		:= StringLib.StringFilter(pInput.src_upload_date, '0123456789');	
		self 					:= pInput;
	end;

tCreateMoxie_pre_did_removal := project(dCrimOffender2_WithDID_PatchedSSN,tCreateMoxie(left));

offnd_hard_code_did_removals := fn_blank_the_did(tCreateMoxie_pre_did_removal);	

//////////////////////////////////////////////////////////////////////////////////
//  There are many cases where one offender key has multiple dids. This code will pick the best did.
//	1)Pick the did if the DOB[YYMM] and Best_DOB[YYMM] match
//  2)Pick the lowest did. As per Jason the lowest did is the best did.
//-----------------------------------------------------
ds_orig := offnd_hard_code_did_removals; 
ds_orig_distributed := distribute(ds_orig,HASH(offender_key));

ds_withdid := distribute(ds_orig(did <> ''),HASH((INTEGER)did));

file_best_withdid := distribute(Watchdog.File_Best(did <> 0),HASH((INTEGER)did));

Is_best_layout := record
ds_orig;
string1 in_best_file ;
string1 best_dob_match;
string12 did_to_keep;
qstring9     bestssn := '';
integer4     bestdob := 0;
qstring20    bestfname := '';
qstring20    bestmname := '';
qstring20    bestlname := '';
qstring5     bestname_suffix := '';
end;

Is_best_layout jointhetwo  (ds_withdid L,file_best_withdid R) :=  TRANSFORM
self := L;
self.bestssn := R.ssn;
self.bestdob := R.dob;
self.bestfname    := R.fname;
self.bestmname    := R.mname;
self.bestlname    := R.lname;
self.bestname_suffix := R.name_suffix;
self.in_best_file := MAP(R.did <> 0 =>'1',
                         '2'
                        );
self.best_dob_match := MAP(L.DOB[1..6] = ((string)R.DOB)[1..6] =>'1',
                         '2'
                        );	
self.did_to_keep := '';												
end;
//Join with best file
J_ds_best := join(ds_withdid(pty_typ='0'),file_best_withdid,(integer)left.did = right.did,jointhetwo(left,right),left outer ,local) :persist('~thor_400::persist::Crim_records_joined_with_best_file');

Pick_best_did := dedup(sort(J_ds_best,offender_key,in_best_file,best_dob_match,(integer)did),offender_key,left) :persist('~thor_400::persist::Best_dids_in_Crim_records');


temp_ds_layout := record
ds_orig_distributed;
string12 did_to_keep;
end;

temp_ds_layout jointhetwoagain  (ds_orig_distributed L,Pick_best_did R) :=  TRANSFORM
//self.did := R.did;
self.ssn := R.ssn;
self.ssn_appended  := R.ssn;
self.did_to_keep := R.did;
self := L;

									
end;
ds_w_bestdid := join(ds_orig_distributed,distribute(Pick_best_did,HASH(offender_key)), left.offender_key = right.offender_key, 
                     jointhetwoagain(left,right),left outer,local) :persist('~thor_400::persist::Crim_records_with_bestdid_propagated');


//////////////////////////////////////////////////////////////////////////////////

export Offender_Joined := ds_w_bestdid :	persist('~thor_data400::persist::CrimSrch_Offender_Joined') //,'Thor400_84')
 ;



