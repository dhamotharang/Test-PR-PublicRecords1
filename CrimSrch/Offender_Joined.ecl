import crim_common, DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville,lib_ziplib;

dCombined_Crim_SexPred	:=	Crim_Offender2_as_CrimSrch_Offender	 +	Sex_Pred_Search_DID_as_CrimSrch_Offender;

rCombined_Crim_SexPred_ForADL
 :=
  record
	Layout_Moxie_Offender_temp;
	unsigned6	temp_did;
  end
 ;

rCombined_Crim_SexPred_ForADL	tBlankDIDandSSN(dCombined_Crim_SexPred pInput)
 :=
  transform
	self.did		:=	'';
	self.ssn		:=	'';
	self.temp_did	:=	0;
	self			:=	pInput;
  end
 ;

dCombined_Crim_SexPred_PreDID	:=	project(dCombined_Crim_SexPred,tBlankDIDandSSN(left));

//add origin state to XADL DOB matching

add_orig_state_rec := record
string2 temp_state;
rCombined_Crim_SexPred_ForADL;
end;

DID_add.mac_add_orig_state(dCombined_Crim_SexPred_PreDID, add_orig_state_rec, zip5, state,state_of_origin, add_orig_state) 

lMatchSet := ['S','A','D'];

did_Add.MAC_Match_Flex//_Sensitive  // NOTE <- removed sensitive macro 4/15/2008
	(add_orig_state, lMatchSet,						
	 orig_ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, temp_state, fake_phone_field, 
	 temp_did,
	 add_orig_state_rec,
	 false, fake_DID_Score_field,
	 75,						//dids with a score below here will be dropped
	 dCombined_Crim_SexPred_WithDID
	)

rCombined_Crim_SexPred_ForADL tUseSourceSSN(dCombined_Crim_SexPred_WithDID pInput)
 :=
  transform
	self.ssn 		:= pInput.orig_ssn;
	self.did 		:= if(pInput.off_name_type= '2' or pInput.temp_DID = 0,
						  '',
						  intformat(pInput.temp_did, 12, 1)
						 );
	self.temp_did 	:= if(pInput.off_name_type= '2' or pInput.temp_DID = 0,
						  0,
						  pInput.temp_did
						 );
	self 		:= pInput;
  end
 ;

dCrimOffender2_WithDID_OrigSSN := project(dCombined_Crim_SexPred_WithDID, tUseSourceSSN(left));

DID_Add.MAC_Add_SSN_By_DID(dCrimOffender2_WithDID_OrigSSN, temp_DID, SSN, dCrimOffender2_WithDID_PatchedSSN)

set_off := ['V','I','C','T'];
Layout_Moxie_Offender_temp tCreateMoxie(dCrimOffender2_WithDID_PatchedSSN pInput)
 :=
  transform
  self.fcra_traffic_flag := if(pInput.offense_score in set_Off,'Y',pInput.fcra_traffic_flag );
	self 		:= pInput;
  end
 ;

tCreateMoxie_pre_did_removal := project(dCrimOffender2_WithDID_PatchedSSN,tCreateMoxie(left));

offnd_hard_code_did_removals := CrimSrch.fn_blank_the_did(tCreateMoxie_pre_did_removal);	

export Offender_Joined
 := offnd_hard_code_did_removals
 :	persist('~thor_data400::persist::CrimSrch_Offender_Joined' //,'Thor400_84'
 )
 ;
 
//export Offender_Joined
// := project(dCrimOffender2_WithDID_PatchedSSN,tCreateMoxie(left))
// :	persist('~thor_data400::persist::CrimSrch_Offender_Joined' ,'Thor400_84')
// ;




