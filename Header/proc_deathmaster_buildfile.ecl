import did_add,header_slimsort,address,ut,didville,death_master,Obituaries,mdr,header ,RoxieKeyBuild, OKC_Probate;

export proc_deathmaster_buildfile(string	filedate)	:= function
//	Force the build to link DIDs on THOR
#STORED('did_add_force','thor');

/*************************************************************************/
/*************************************************************************/
/***********        Building Death Master DID Base File      *************/
/*************************************************************************/
/*************************************************************************/

	dDeathMasterPlus	:=	header.File_Death_Master_Plus_SSA;

	recordof(dDeathMasterPlus)	tFakeStateDeathID(dDeathMasterPlus	l)	:=
	transform
		self.lname					:=	l.clean_lname;
		self.mname					:=	l.clean_mname;
		self.fname					:=	l.clean_fname;
		self.name_suffix		:=	l.clean_name_suffix[1..4];
		self.state_death_id	:=	if(l.state_death_id<>'',l.state_death_id,death_master.fn_fake_state_death_id(l.ssn,SELF.lname,l.dod8));
		self								:=	l;
	end;

	dFakeStateDeathID	:=	project(dDeathMasterPlus,tFakeStateDeathID(left));
	
	// Joining the death_master_plus file to state supplemental to populate source state for source_code lookup
	// and address for DID
	dDeathMasterSupp	:= header.file_death_master_supplemental_SSA;
	
	Death_Master.Layouts.Expanded	tFillSrcState(dFakeStateDeathID	l)	:=
	transform
		self.source_state	:=	IF(l.state_death_flag = 'Y' and l.state=l.state_death_id[1..2],l.state,
															IF(l.state_death_flag = 'N', 'SS',''));
		self							:=	l;
	end;
	
	dFillSrcState	:= project(dFakeStateDeathID,tFillSrcState(left));
	
	Death_Master.Layouts.Expanded	tGetSrcStateAndAddress(dFillSrcState	l, dDeathMasterSupp r)	:=
	transform
	  self.source_state	:= 	IF(l.source_state<>'',l.source_state,
													IF(l.source_state='' and l.state_death_flag = 'Y',r.source_state,'SS'));
		self.prim_range		:=	r.prim_range;
		self.prim_name		:=	r.prim_name;
		self.sec_range		:=	r.sec_range;
		self.zip5 				:=	r.zip5;
		self							:=	l;
	end;

	dGetSrcState := join(	DISTRIBUTE(dFillSrcState,HASH32(state_death_id)), 
												DISTRIBUTE(dDeathMasterSupp,HASH32(state_death_id)),
													trim(left.state_death_id,left,right) = trim(right.state_death_id,left,right),
												tGetSrcStateAndAddress(left,right),
												left outer,
												LOCAL
											);
								
	sStateInHeader	:=	['CAL','FLA','GAA','MIC','MNT','NEV','OHI','VGA'];
	
	Death_Master.Layouts.DeathHeaderSource	tLkpSrcCodeAndZip(dGetSrcState	l, death_master.lkp_death_source_cd r)	:=
	transform
		self.zip5							:=	IF(TRIM(l.zip5,all)	!=	'',l.zip5,
																IF(TRIM(l.zip_lastres,all)	!=	'',l.zip_lastres,l.zip_lastpayment));
		self.state_death_flag :=	l.state_death_flag;
		self.death_rec_src		:=	IF(l.source_state = 'GA' and l.state_death_id[1..2] != 'GA','GAH',//GAH = GA history record
																IF(l.source_state = 'FL' and l.state_death_id[1..2] != 'FL','FLH',//FLH = FL history record
																	IF(l.state_death_flag = 'Y',r.src_cd,'SSA')
																	)
																); 
		self.src							:=	IF(self.death_rec_src IN sStateInHeader, death_master.lkp_death_src_codes(state_cd=l.source_state)[1].src, 'DE');
		self     							:=	l;
	end; 

	dDeathMasterReadyForDID := join(	dGetSrcState, 
																		death_master.lkp_death_source_cd,
																			trim(left.source_state,left,right) = trim(right.state_cd,left,right),
																		tLkpSrcCodeAndZip(left,right),
																		left outer,lookup
																	);
											
	dHasSSN	:=	dDeathMasterReadyForDID((UNSIGNED)ssn<>0);
	dNoSSN	:=	dDeathMasterReadyForDID((UNSIGNED)ssn=0);

	matchSetDSZ4	:=	['D','S','Z','4'];

	DID_Add.Mac_Match_Flex(	dHasSSN,
													matchSetDSZ4,
													ssn,dob8,
													clean_fname,clean_mname,clean_lname,clean_name_suffix,
													prim_range,prim_name,sec_range,zip5,state,foo,
													did,
													Death_Master.Layouts.DeathHeaderSource,
													true,	//has score field
													did_score,90,
													dHasSSNDID,
													true,	//has source field
													src		//source field
												);

	matchSetDAZ	:=	['D','A','Z'];

	DID_Add.Mac_Match_Flex(	dNoSSN+dHasSSNDID(did=0),
													matchSetDAZ,
													ssn,dob8,
													clean_fname,clean_mname,clean_lname,clean_name_suffix,
													prim_range,prim_name,sec_range,zip5,state,foo,
													did,
													Death_Master.Layouts.DeathHeaderSource,
													true,	//has score field
													did_score,90,
													dNoSSNDID,
													true,	//has source field
													src		//source field
												);

	dDeathMasterDID	:=	dHasSSNDID(did<>0)+dNoSSNDID;
	
	// Remove source code and partial ssn
	// Filter out records that are just matched on Name and State only
	Death_Master.Layouts.Expanded	tDeathMasterDIDBase(dDeathMasterDID	pInput)	:=	TRANSFORM
		mymatches				:=	DID_Add.matches(TRIM(pInput.xadl2_matches,ALL));
		SELF.strDID			:=	IF(
														mymatches.isNameStOnlyMatch 
														,INTFORMAT(0,12,1)
														,INTFORMAT(pInput.DID,12,1)
												);
		SELF.did_score	:=	IF((UNSIGNED)SELF.strDID=0,0,pInput.did_score);
		SELF.ssn				:=	IF(pInput.ssn[1..5] = '00000','',pInput.ssn);
		SELF						:=	pInput;
	END;
	persistDIDFilename	:=	'~thor_data400::persist::death_master::did_ssa';
	dDeathMasterDIDBase	:=	PROJECT(dDeathMasterDID,tDeathMasterDIDBase(LEFT)):PERSIST(persistDIDFilename);
																	
/*************************************************************************/
/*************************************************************************/
/***********        Building Death Master DID Delete File    *************/
/*************************************************************************/
/*************************************************************************/
	
	// Death deletes data
	dDeathDeletes				:=	Death_master.Files.Deletes;
	dDeathDeletes_dedup	:=	DEDUP(SORT(DISTRIBUTE(dDeathDeletes,HASH(ssn, lname, fname, mname, name_suffix[1..4], dob8, zip_lastres, zip_lastpayment)),
														-filedate, ssn, lname, fname, mname, name_suffix[1..4], dob8, zip_lastres, zip_lastpayment, LOCAL), // SORT
																			 ssn, lname, fname, mname, name_suffix[1..4], dob8, zip_lastres, zip_lastpayment, LOCAL); // DEDUP

	// Convert to death master plus common DID layout
	Death_Master.Layouts.DeathHeaderSource	tConvert2Common(dDeathDeletes_dedup	pInput)	:=
	transform
		dCleanName	:=	Address.CleanPersonFML73_fields(ut.CleanSpacesAndUpper(pInput.fname+' '+pInput.mname+' '+pInput.lname)).CleanNameRecord;
		
		self.lname							:=	dCleanName.lname;
		self.fname							:=	dCleanName.fname;
		self.mname							:=	dCleanName.mname;
		self.name_suffix				:=	dCleanName.name_suffix[1..4];
		self.clean_lname				:=	dCleanName.lname;
		self.clean_fname				:=	dCleanName.fname;
		self.clean_mname				:=	dCleanName.mname;
		self.clean_name_suffix	:=	dCleanName.name_suffix[1..4];
		// Convert from MMDDYYYY to YYYYMMDD
		SELF.dob8								:=	pInput.dob8[5..8]+pInput.dob8[1..2]+pInput.dob8[3..4];
		SELF.dod8								:=	pInput.dod8[5..8]+pInput.dod8[1..2]+pInput.dod8[3..4];
		self.zip5								:=	if(ut.CleanSpacesAndUpper(pInput.zip_lastres) != '',pInput.zip_lastres,pInput.zip_lastpayment);
		self.src								:=	'DE';
		self										:=	pInput;
		self										:=	[];
	end;

	persistDeletesFilename		:=	'~thor_data400::persist::death_master::clean_deletes_ssa';
	dDeletes2Common	:=	project(dDeathDeletes_dedup,tConvert2Common(left)):persist(persistDeletesFilename);

	// Append DID for the deletes file
	matchSetDeletes	:=	['D','S','Z'];

	DID_Add.Mac_Match_Flex(	dDeletes2Common,
													matchSetDeletes,
													ssn,dob8,
													clean_fname,clean_mname,clean_lname,clean_name_suffix,
													prim_range,prim_name,sec_range,zip5,state,foo,
													did,
													Death_Master.Layouts.DeathHeaderSource,
													true,	//has score field
													did_score,90,
													dDeletesDID,
													true,	//has source field
													src		//source field
												);
	
	// Convert to DID V1 layout
	Death_Master.Layouts.DID_V1	tConvertDeletes2V1(dDeletesDID	pInput)	:=
	transform
		self.DID	:=	intformat(pInput.DID,12,1);
		self			:=	pInput;
	end;
	
	dDeathMasterDIDDeletes	:=	project(dDeletesDID,tConvertDeletes2V1(left))	:	independent;
	
	STRING	BaseDeathMasterDeletes	:=	Death_Master.Files.vDeletesDIDFileName+'_'+filedate;

	RoxieKeyBuild.Mac_SF_BuildProcess(dDeathMasterDIDDeletes,Death_Master.Files.vDeletesDIDFileName,BaseDeathMasterDeletes,bldDeathMasterDIDDeletes,3,,TRUE);

/*************************************************************************/
/*************************************************************************/
/***********        Building Death Master Base V3            *************/
/*************************************************************************/
/*************************************************************************/

	// put state_death_id back in the base file for new keys and autokeys
	// Add src code for each death master source	
	Death_Master.Layouts.DID_V3	tConvert2V3(dDeathMasterDIDBase	l, death_master.lkp_death_src_codes r)	:=
	transform
		self.did	:=	l.strDID;
		self.src  :=	IF(l.death_rec_src IN sStateInHeader, r.src,
										IF( Death_Master.isDateSSARestricted(l.dod8) AND l.death_rec_src='SSA', 
												MDR.sourceTools.src_Death_Restricted,
												MDR.sourceTools.src_Death_Master
										)
									);
		self			:=	l;
	end;
	
	// Base Death Records projected to DID V3 layout
	dDeathMasterDIDV3	:= join(dDeathMasterDIDBase, death_master.lkp_death_src_codes,
														trim(left.source_state,left,right) = trim(right.state_cd,left,right),
														tConvert2V3(left,right),
														left outer,lookup
														);
	
	// SSA death records in DID V3 layout
	dSSADeathMasterDIDV3			:=	dDeathMasterDIDV3(state_death_flag	!=	'Y');
	dSSADeathMasterDIDV3Dist	:=	distribute(dSSADeathMasterDIDV3((unsigned)did	!=	0),hash32(did));
	
	// State death records in DID V3 layout
	dStateDeathMasterDIDV3		:=	dDeathMasterDIDV3(state_death_flag	=	'Y');

	// Get Credit Bureau death records (transunion and experian)
	dCBDeathMasterDIDV3Dist		:=	distribute(Death_Master.fn_AddExperian_toDeathMaster,hash32(did));
																
	// Populate the state and zip information from the credit bureaus if SSA records don't have it
	Death_Master.Layouts.DID_V3	tSSADeathsPopulateStateZip(dSSADeathMasterDIDV3Dist	le, dCBDeathMasterDIDV3Dist	ri)	:=
	transform
		self.zip_lastres			:=	if(le.did	=	ri.did	and	le.zip_lastres			=	''	and	le.rec_type	=	'A',ri.zip_lastres,le.zip_lastres);
		self.state						:=	if(le.did	=	ri.did	and	le.state						=	''	and	le.rec_type	=	'A',ri.state,le.state);
		self.st_country_code	:=	if(le.did	=	ri.did	and	le.st_country_code	=	''	and	le.rec_type	=	'A',ri.st_country_code,le.st_country_code);
		self.fipscounty				:=	if(le.did	=	ri.did	and	le.fipscounty				=	''	and	le.rec_type	=	'A',ri.fipscounty,le.fipscounty);
		self.glb_flag					:=	if(	(le.zip_lastres	=	''	and	self.zip_lastres			!=	'')	OR	
															(le.state						=	''	and	self.state						!=	'') OR
															(le.st_country_code	=	''	and	self.st_country_code	!=	'') OR
															(le.fipscounty			=	''	and	self.fipscounty				!=	''),
															'Y',
															le.glb_flag
														);
		self							:=	le;
	end;
	
	dSSADeathMasterDIDV3PopulateStateZip	:=	join(	dSSADeathMasterDIDV3Dist,
																									dCBDeathMasterDIDV3Dist,
																										left.did	=	right.did,
																									tSSADeathsPopulateStateZip(left,right),
																									left outer,
																									local
																								);
																								
	// Create second non-glb record without credit bureau supplied state and zip information -- Bug #102014
	Death_Master.Layouts.DID_V3	tSSANonGLB(dSSADeathMasterDIDV3Dist	le, dSSADeathMasterDIDV3PopulateStateZip	ri)	:=
	transform
		// Set to lowercase 'n' until Bug #102014 is fully implemented.
		self.glb_flag	:=	'n';
		self					:=	le;
	end;

	dSSADeathMasterDIDV3NonGLBonly	:=	join(	dSSADeathMasterDIDV3Dist,
																						dSSADeathMasterDIDV3PopulateStateZip(glb_flag='Y'),
																							left.did						=	right.did							AND
																							left.state_death_id	=	right.state_death_id,
																						tSSANonGLB(left,right),
																						LOCAL,
																						LOOKUP
																					);
	
	// Keep credit bureau death records only if they don't already exist
	Death_Master.Layouts.DID_V3	tKeepCBDeathsOnly(dDeathMasterDIDV3	le,dCBDeathMasterDIDV3Dist	ri)	:=
	transform
		self	:=	ri;
	end;
	
	dCBDeathMasterDIDV3Only	:=	join(	DISTRIBUTE(dDeathMasterDIDV3,HASH32(did)),
																		dCBDeathMasterDIDV3Dist,
																			left.did	=	right.did,
																		tKeepCBDeathsOnly(left,right),
																		right only,
																		local
																	);
	
	// Get Obits
	dObitsDeathMasterDIDV3			:=	Obituaries.file_obituary_dmasterv3_base;
	// Get Enclarity
	dEnclarityDeathMasterDIDV3	:=	Death_Master.File_EnclarityToV3;
	
  // Get OKC Probate
	dOKC_ProbateDIDV3	          :=	OKC_Probate.Files().file_deathmasterv3 ;
	
	// Combine all the death records
	dCombineDeathMasterDIDV3	:=	dSSADeathMasterDIDV3PopulateStateZip			+	// SSA records with state and zip propagated from credit bureaus
																dSSADeathMasterDIDV3((unsigned)did	=	0)	+	// SSA records with did = 0
																dSSADeathMasterDIDV3NonGLBonly    				+ // Second SSA records that match credit bureaus without state and zip population added																dStateDeathMasterDIDV3										+	// State death records
																dStateDeathMasterDIDV3										+	// State death records
																dCBDeathMasterDIDV3Only										+	// Credit bureau death records
																dObitsDeathMasterDIDV3										+	// Tributes/obituary records with src = 'TR' & src = 'OB'
																dEnclarityDeathMasterDIDV3								+	// Enclarity death records
																dOKC_ProbateDIDV3((unsigned)did>0)                           // OKC Probate records
																;

	
	ut.CleanFields(dCombineDeathMasterDIDV3,dDeathMasterDIDV3CleanFields);

	// Compare records to what is in Watchdog
  dValidSSNDeathMasterDIDV3				:=	death_master.fnValidateSSNs(dDeathMasterDIDV3CleanFields);

	// Resurrect V3 records based on Delete records from SSA
	dResurrectionsDeathMasterDIDV3	:=	Death_Master.fn_clean_resurrections(dValidSSNDeathMasterDIDV3);
	
	//Remove bad SSN's
	Header.Layout_Did_Death_MasterV3	clnDeathSSN(dResurrectionsDeathMasterDIDV3 l) := TRANSFORM
		SELF.ssn	:=	Death_Master.fn_clean_death_ssn(l.ssn,FALSE);
		SELF			:=	l;
	END;
	
	persistV3BaseFilename					:=	'~thor_data400::persist::death_master::dCleanSSNDeathMasterDIDV3_ssa';
	dDeathMasterDIDV3Base_SSA_Raw :=	PROJECT(dResurrectionsDeathMasterDIDV3,clnDeathSSN(left)):PERSIST(persistV3BaseFilename);

	// Manually remove any records from the build by DID
	dDeathMasterDIDV3Base_SSA			:=	dDeathMasterDIDV3Base_SSA_Raw((UNSIGNED)did NOT IN Death_Master.Files.BadDIDSet);
	dDeathMasterDIDV3Base					:=	dDeathMasterDIDV3Base_SSA(src<>MDR.sourceTools.src_Death_Restricted);

	// Display records that are being suppressed
	suppressDIDs	:=	OUTPUT(dDeathMasterDIDV3Base_SSA_Raw((UNSIGNED)did IN Death_Master.Files.BadDIDSet),NAMED('Suppressed_by_DID'));
		
	STRING	BaseDeathMasterV3_SSA	:=	'~thor_data400::base::did_death_masterV3_SSA_'+filedate;	
	STRING	V3_Filename_SSA				:=	'~thor_data400::base::did_death_masterV3_SSA';	
	STRING	BaseDeathMasterV3			:=	'~thor_data400::base::did_death_masterV3_'+filedate;	
	STRING	V3_Filename						:=	'~thor_data400::base::did_death_masterV3';	
	// Remove records with lowercase 'n' until Bug #102014 is fully implemented.
	RoxieKeyBuild.Mac_SF_BuildProcess(dDeathMasterDIDV3Base_SSA(glb_flag<>'n'),V3_Filename_SSA,BaseDeathMasterV3_SSA ,bldDeathMasterDIDV3_SSA,3,,TRUE);
	RoxieKeyBuild.Mac_SF_BuildProcess(dDeathMasterDIDV3Base(glb_flag<>'n'),V3_Filename,BaseDeathMasterV3 ,bldDeathMasterDIDV3,3,,TRUE);

/*************************************************************************/
/*************************************************************************/
/***********        Building Death Master Base V1            *************/
/*************************************************************************/
/*************************************************************************/
	CBSet	:=	['EXP','TUN','TCS'];
	
	Header.Layout_Did_Death_Master	tConvert2V1(dDeathMasterDIDV3Base_SSA l)	:=
	transform
		self			:=	l;
	end;

	dDeathMasterDIDV1Base_SSA	:=	PROJECT(dDeathMasterDIDV3Base_SSA(death_rec_src NOT IN CBSet AND glb_flag<>'Y'),tConvert2V1(LEFT));
	dDeathMasterDIDV1Base			:=	PROJECT(dDeathMasterDIDV3Base(death_rec_src NOT IN CBSet AND glb_flag<>'Y'),tConvert2V1(LEFT));

	STRING	BaseDeathMasterV1_SSA	:=	'~thor_data400::base::did_death_master_SSA_'+filedate;	
	STRING	V1_Filename_SSA				:=	'~thor_data400::base::did_death_master_SSA';	
	STRING	BaseDeathMasterV1			:=	'~thor_data400::base::did_death_master_'+filedate;	
	STRING	V1_Filename						:=	'~thor_data400::base::did_death_master';	

	RoxieKeyBuild.Mac_SF_BuildProcess(dDeathMasterDIDV1Base_SSA,V1_Filename_SSA,BaseDeathMasterV1_SSA,bldDeathMasterDIDV1_SSA,3,,TRUE);
	RoxieKeyBuild.Mac_SF_BuildProcess(dDeathMasterDIDV1Base,V1_Filename,BaseDeathMasterV1,bldDeathMasterDIDV1,3,,TRUE);

/*************************************************************************/
/*************************************************************************/
/***********        Building Death Master V2 File            *************/
/*************************************************************************/
/*************************************************************************/

	// put state_death_id back in the base file for new keys and autokeys. V2 has state_death_id field.
	Header.Layout_Did_Death_MasterV2	tConvert2V2(dDeathMasterDIDV3Base_SSA	l)	:=
	transform
		self			:=	l;
	end;

	dDeathMasterDIDV2Base_SSA			:=	PROJECT(dDeathMasterDIDV3Base_SSA(death_rec_src NOT IN CBSet AND glb_flag<>'Y'),tConvert2V2(LEFT));
	dDeathMasterDIDV2BaseDist_SSA	:=	DISTRIBUTE(dDeathMasterDIDV2Base_SSA,HASH(state_death_id));
	dDeathMasterDIDV2Base					:=	PROJECT(dDeathMasterDIDV3Base(death_rec_src NOT IN CBSet AND glb_flag<>'Y'),tConvert2V2(LEFT));
	dDeathMasterDIDV2BaseDist			:=	DISTRIBUTE(dDeathMasterDIDV2Base,HASH(state_death_id));

	STRING	BaseDeathMasterV2_SSA	:=	'~thor_data400::base::did_death_masterV2_SSA_'+filedate;	
	STRING	V2_Filename_SSA				:=	'~thor_data400::base::did_death_masterV2_SSA';	
	STRING	BaseDeathMasterV2			:=	'~thor_data400::base::did_death_masterV2_'+filedate;	
	STRING	V2_Filename						:=	'~thor_data400::base::did_death_masterV2';	
	
	RoxieKeyBuild.Mac_SF_BuildProcess(dDeathMasterDIDV2BaseDist_SSA,V2_Filename_SSA,BaseDeathMasterV2_SSA,bldDeathMasterDIDV2_SSA,3,,TRUE);
	RoxieKeyBuild.Mac_SF_BuildProcess(dDeathMasterDIDV2BaseDist,V2_Filename,BaseDeathMasterV2,bldDeathMasterDIDV2,3,,TRUE);


/*************************************************************************/
/*************************************************************************/
/***********        Building Death Master                    *************/
/*************************************************************************/
/*************************************************************************/

	RETURN	SEQUENTIAL(
		 bldDeathMasterDIDDeletes
		,suppressDIDs
		,bldDeathMasterDIDV3_SSA
		,bldDeathMasterDIDV3
		,bldDeathMasterDIDV1_SSA
		,bldDeathMasterDIDV1
		,bldDeathMasterDIDV2_SSA
		,bldDeathMasterDIDV2
	);

end;
