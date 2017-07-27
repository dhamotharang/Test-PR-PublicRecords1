import did_add,header_slimsort,address,ut,didville,death_master,mdr,header ,RoxieKeyBuild;

export	proc_deathmaster_buildfile(string	filedate)	:=
function

	dmp1	:=	header.File_Death_Master_Plus;

	recordof(dmp1)	t1(dmp1	l)	:=
	transform
		self.lname					:=	l.clean_lname;
		self.mname					:=	l.clean_mname;
		self.fname					:=	l.clean_fname;
		self.name_suffix		:=	l.clean_name_suffix[1..4];
		self.state_death_id	:=	if(l.state_death_id<>'',l.state_death_id,death_master.fn_fake_state_death_id(l.ssn,l.lname,l.dod8));
		self								:=	l;
	end;

	dmp2	:=	project(dmp1,t1(left));

	// apply SSN fix prior to DID'ing
	// with the original placement we wouldn't
	// be picking up the potential DID lift 
	// from the propagated SSN from the SSA
	dmp3	:=	header.fn_compare_ssa_and_direct_ssns(dmp2);

	// bad SSN's in CA Direct data
	// bug 29533 - removing the data altogether so no need to fix it
	dmp4 	:=	death_master.fn_ca_direct_filter(dmp3);

	in_file	:=	dmp3;
		
	mast_did_rec	:=
	record
		unsigned6	did				:=	0;
		unsigned1	did_score	:=	0;
		string12	strDID		:=	'';
		string5		zip5;
		header.layout_death_master_plus;
	end;

	mast_did_rec	mast_getdid(in_file	l)	:=
	transform
		self.zip5	:=	if(trim(l.zip_lastres)	!=	'',l.zip_lastres,l.zip_lastpayment);
		self     	:=	l;
	end; 

	mast_ready	:=	project(in_file,mast_getdid(left));

	// add src 
	src_rec	:=
	record
		header_slimsort.Layout_Source;
		mast_did_rec;
	end;

	DID_Add.Mac_Set_Source_Code(mast_ready,src_rec,'DE',mast_ready_src)

	matchset	:=	['D','S','Z'];

	did_add.mac_match_flex(	mast_ready_src,matchset,
													ssn,dob8,
													clean_fname,clean_mname,clean_lname,clean_name_suffix,
													foo,foo,foo,zip5,state,foo,
													did,src_rec,
													true,did_score,90,
													mast_out_src,true,src
												);
	
	// remove src
	mast_out	:=	project(	mast_out_src,
													transform(	mast_did_rec,
																			self.strDID	:=	intformat(left.DID,12,1);
																			self				:=	left;
																		)
												);

	// source matching removes the need for this macro
	// did_Add.mac_BlankDIDWhenSSNInvalid(mast_out,out_f)
	out_f	:=	mast_out	:	independent;
											 
	mast_out_rec	:=
	record
		string12	did;
		unsigned1	did_score;
		header.layout_death_master,
	end;

	mast_out_rec mast_getout(out_f l)	:=
	transform
		self.did	:=	l.strDID;
		self			:=	l;
	end;

	did_dead_mast	:=	project(out_f,mast_getout(left));

	STRING	BaseDeathMaster	:=	'~thor_data400::base::did_death_master_'+filedate;

	RoxieKeyBuild.Mac_SF_BuildProcess(did_dead_mast,'~thor_data400::base::did_death_master',BaseDeathMaster ,build_did_d_mast,2);

	// put state_death_id back in the base file for new keys and autokeys
	mastV2_out_rec	:=
	record
		mast_out_rec;
		string16	state_death_id;
	end;

	mastV2_out_rec	mastV2_getout(out_f	l)	:=
	transform
		self.did	:=	l.strDID;
		self			:=	l;
	end;

	did_dead_mastV2     	:=	project(out_f,mastV2_getout(left));
	did_dead_mastV2_dist	:=	distribute(did_dead_mastV2,hash(state_death_id));

	STRING	BaseDeathMasterV2	:=	'~thor_data400::base::did_death_masterV2_'+filedate;

	RoxieKeyBuild.Mac_SF_BuildProcess(did_dead_mastV2_dist,'~thor_data400::base::did_death_masterV2',BaseDeathMasterV2 ,build_did_d_mastV2,2);

	// put state_death_id back in the base file for new keys and autokeys
	mastV3_out_rec	:=
	record
		mast_out_rec;
		string16	state_death_id;
		string2		src				:=	'DE';
		string1		glb_flag	:=	'N';
	end;
	
	mastV3_out_rec	mastV3_getout(out_f	l)	:=
	transform
		self.did	:=	l.strDID;
		self			:=	l;
	end;
	
	dDeathsDIDV3	:=	project(out_f,mastV3_getout(left));
	
	// SSA death records being projected to DID V3 layout
	dSSADeathDIDV3			:=	project(out_f(state_death_flag	!=	'Y'),mastV3_getout(left));
	dSSADeathsDIDV3Dist	:=	distribute(dSSADeathDIDV3((unsigned)did	!=	0),hash32(did));
	
	// State death records being projected to DID V3 layout
	dStateDeathDIDV3	:=	project(out_f(state_death_flag	=	'Y'),mastV3_getout(left));

	// Credit bureau death records (transunion and experian)
	dCBDeathRecords	:=	distribute(Death_Master.fn_AddExperian_toDeathMaster,hash32(did));
	
	// Populate the state and zip information from the credit bureaus if SSA records don't have it
	mastV3_out_rec	tPopulateStateZip(dSSADeathsDIDV3Dist	le,dCBDeathRecords	ri)	:=
	transform
		self.zip_lastres	:=	if(le.did	=	ri.did	and	le.zip_lastres	=	''	and	le.rec_type	=	'A',ri.zip_lastres,le.zip_lastres);
		self.state				:=	if(le.did	=	ri.did	and	le.state	=	''	and	le.rec_type	=	'A',ri.state,le.state);
		self.glb_flag			:=	if(	(le.zip_lastres	=	''	and	self.zip_lastres	!=	'')	or	(le.state	=	''	and	self.state	!=	''),
															'Y',
															le.glb_flag
														);
		self							:=	le;
	end;
	
	dPopulateStateZip	:=	join(	dSSADeathsDIDV3Dist,
															dCBDeathRecords,
															left.did	=	right.did,
															tPopulateStateZip(left,right),
															left outer,
															keep(1),
															local
														);
	
	// Keep credit bureau death records only if they don't exist in the SSA file
	mastV3_out_rec	tKeepCBDeathsOnly(out_f	le,dCBDeathRecords	ri)	:=
	transform
		self	:=	ri;
	end;
	
	dCBDeathsOnly	:=	join(	distribute(out_f(did	>	0),hash32(strDID)),
													dCBDeathRecords,
													left.strDID	=	right.did,
													tKeepCBDeathsOnly(left,right),
													right only,
													local
												);
	
	// Combine all the death records
	dCombineDeathDIDV3	:=	dPopulateStateZip										+	// SSA records with state and zip propagated from credit bureaus
													dSSADeathDIDV3((unsigned)did	=	0)	+	// SSA records with did = 0
													dStateDeathDIDV3										+	// State death records
													dCBDeathsOnly												// Credit bureau death records
													;
	
	STRING	BaseDeathMasterV3	:=	'~thor_data400::base::did_death_masterV3_'+filedate;

	RoxieKeyBuild.Mac_SF_BuildProcess(dCombineDeathDIDV3,'~thor_data400::base::did_death_masterV3',BaseDeathMasterV3 ,build_did_d_mastV3,2);
	
	return	sequential(build_did_d_mast,build_did_d_mastV2,build_did_d_mastV3);
end;