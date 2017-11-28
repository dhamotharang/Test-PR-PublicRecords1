IMPORT Address,BIPV2,DeathV2_Services,Doxie,Doxie_Raw,Header,PAW,PhoneOwnership,Phones,POE,PSS,STD,Suppress,TopBusiness_Services,ut;
EXPORT GetREAB(DATASET(PhoneOwnership.Layouts.PhonesCommon) dBatchIn,PhoneOwnership.IParams.BatchParams inMod) :=FUNCTION //
	Constants := PhoneOwnership.Constants;
	//REA Utilities
	validFullSSN(STRING ssn):= LENGTH(STD.Str.FilterOut(ssn,'0123456789')) = 9;
	validAddress(STRING prim_range, STRING prim_name, STRING city,STRING state,STRING zip):= 
																																((prim_range<>'' AND prim_name<>'') OR ut.isPOBox(prim_name) OR ut.isRR(prim_name)) AND
																																((city<>'' AND state<>'') OR  zip<>'');
	validDOB(STRING dob) := Std.Date.IsValidDate((UNSIGNED)dob);
	
	needREA := DEDUP(SORT(dBatchIn(did>0 AND batch_in.name_first<>'' AND batch_in.name_last<>'' AND (batch_in.did > 0 OR 
																					 validFullSSN(TRIM(batch_in.ssn,ALL)) OR 
																					 validAddress(batch_in.prim_range,batch_in.prim_name,batch_in.p_city_name,batch_in.st,batch_in.zip) OR 
																					 validDOB(batch_in.dob)))
																,acctno,seq),acctno);
	subjectDIDs := PROJECT(needREA,Doxie.layout_references);													

	dsRA := Doxie_Raw.relative_raw(DEDUP(subjectDIDs,ALL),,inMod.dppaPurpose,inMod.glbPurpose,,,,,,Constants.MAX_RelativeDept);
	dsUniqueRA := DEDUP(SORT(dsRA,srcdid,person2,-rel_dt_last_seen,rel_dt_first_seen,titleno),srcdid,person2);
	deathParams := PROJECT(inMod, DeathV2_Services.IParam.DeathRestrictions, OPT);
	
	PhoneOwnership.Layouts.Phone_Relationship updateRelatives(doxie_Raw.Layout_RelativeRawOutput l,Doxie.key_death_masterV2_ssa_DID r) :=TRANSFORM
		SELF.did := l.person2;
		SELF.titleno := l.titleno;
		SELF.isDeceased := (BOOLEAN)(r.l_did != 0);
		SELF.batch_in.did := l.srcdid;
		SELF.dt_first_seen:=(STRING)l.rel_dt_first_seen,
		SELF.dt_last_seen:=(STRING)l.rel_dt_last_seen,
		SELF := [];
	END;
	dsRAwDeceased := JOIN(dsUniqueRA, Doxie.key_death_masterV2_ssa_DID,
												KEYED(LEFT.person2 = RIGHT.l_did) AND
												NOT DeathV2_Services.Functions.Restricted(RIGHT.src, RIGHT.glb_flag, ut.glb_ok(inMod.GLBPurpose), deathParams),
												updateRelatives(LEFT,RIGHT),
												LEFT OUTER,
												LIMIT(0),KEEP(1));

	dsRelatives:= JOIN(needREA,dsRAwDeceased,
										 LEFT.did = RIGHT.batch_in.did,	
										 TRANSFORM(PhoneOwnership.Layouts.Phone_Relationship,
										 SELF.acctno := LEFT.acctno,
										 SELF.did := RIGHT.did,
										 SELF.titleno := RIGHT.titleno,
										 SELF.subj2own_relationship := 'Possible ' + Header.relative_titles.fn_get_str_title(RIGHT.titleno);
										 SELF.isFirstDegree := (BOOLEAN)(RIGHT.titleno IN Header.relative_titles.set_FirstDegreeRelative);
										 SELF.dt_first_seen:=RIGHT.dt_first_seen,
										 SELF.dt_last_seen:=RIGHT.dt_last_seen,										 
										 SELF.batch_in := LEFT.batch_in;
										 SELF:=[]),
										 LIMIT(Constants.MAX_RECORDS,SKIP));				
										 
	relativesDid := DEDUP(PROJECT(dsRelatives(did<>0),doxie.layout_references),did,ALL);
	dsRelativeBestRecs := Doxie.best_records(relativesDid,DPPA_override:=inMod.DPPAPurpose,GLB_override:=inMod.GLBPurpose);
	ut.PermissionTools.GLB.mac_FilterOutMinors(dsRelativeBestRecs,dsRABest_noMinors,did,,dob);		
	dsRelativesInfo := JOIN(dsRelatives,dsRABest_noMinors,
													LEFT.did = RIGHT.did,
													TRANSFORM(PhoneOwnership.Layouts.Phone_Relationship,
													SELF.acctno := LEFT.acctno,
													SELF.did := LEFT.did,
													SELF:=RIGHT,
													SELF:=LEFT,
													SELF:=[]),
													LIMIT(Constants.MAX_RECORDS,SKIP));
											
	dsPOE 				:= JOIN(needREA,POE.Keys().did.qa,
										 KEYED(LEFT.did = RIGHT.did),	
										 TRANSFORM(PhoneOwnership.Layouts.Phone_Relationship,
															 SELF.acctno := LEFT.acctno,
															 SELF.did := LEFT.did,
															 SELF.bdid := RIGHT.bdid,
															 SELF.ssn := if(RIGHT.subject_ssn=0,'',INTFORMAT(RIGHT.subject_ssn,9,1)),
															 SELF.companyName := RIGHT.company_name,
															 SELF := RIGHT.subject_name,
															 SELF := RIGHT.company_address,
															 SELF.subj2own_relationship := Constants.Relationship.EMPLOYER,
															 SELF.dt_first_seen:=(STRING)RIGHT.dt_first_seen,
															 SELF.dt_last_seen:=(STRING)RIGHT.dt_last_seen,
															 SELF:=RIGHT,
															 SELF:=LEFT,
															 SELF:=[]),
										 LIMIT(Constants.MAX_RECORDS,SKIP));
										 
	dsPAWContact 	:= JOIN(needREA,PAW.Key_Did,
										 KEYED(LEFT.did = RIGHT.did),	
										 LIMIT(Constants.MAX_RECORDS,SKIP));	
	dsPAW		 			:= JOIN(dsPAWContact,PAW.Key_contactID,
										 KEYED(LEFT.contact_id = right.contact_id),	
										 TRANSFORM(PhoneOwnership.Layouts.Phone_Relationship,
										 SELF.acctno := LEFT.acctno,
										 SELF.did := LEFT.did,
										 SELF.bdid := RIGHT.bdid,
										 SELF.companyName := RIGHT.company_name,
										 SELF.fname:=RIGHT.fname,
										 SELF.mname:=RIGHT.mname,
										 SELF.lname:=RIGHT.lname,
										 SELF.subj2own_relationship := Constants.Relationship.EMPLOYER,
										 SELF.suffix:=RIGHT.addr_suffix,
										 SELF.dt_first_seen:=(STRING)RIGHT.dt_first_seen,
										 SELF.dt_last_seen:=(STRING)RIGHT.dt_last_seen,
										 SELF:=RIGHT,
										 SELF:=LEFT,
										 SELF:=[]),										 
										 LIMIT(Constants.MAX_RECORDS,SKIP));	
	PhoneOwnership.Layouts.Phone_Relationship rollEmployer(PhoneOwnership.Layouts.Phone_Relationship l, PhoneOwnership.Layouts.Phone_Relationship r) := TRANSFORM
		SELF.seq := 0;
		SELF.dt_first_seen := (STRING)ut.Min2((INTEGER)l.dt_first_seen,(INTEGER)r.dt_first_seen);
		SELF := l;
		SELF := r;
		SELF := [];
	END;										 							 
	dsEmployer := ROLLUP(SORT(dsPOE + dsPAW,acctno,did,bdid,-dt_last_seen,dt_first_seen),
														LEFT.acctno=RIGHT.acctno AND
														LEFT.did=RIGHT.did AND
														LEFT.bdid=RIGHT.bdid,
														rollEmployer(LEFT,RIGHT)); 
	ds_results_w_acct := 	BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(PROJECT(subjectDIDs,TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,SELF.contact_did:=LEFT.did,SELF:=[]))).uid_results_w_acct;
	ds_BIPIDs := PROJECT(ds_results_w_acct,TRANSFORM( BIPV2.IDlayouts.l_xlink_ids2,
																														SELF.uniqueid := COUNTER,
																														SELF := LEFT));
	bizContacts:=TopBusiness_Services.Key_Fetches(ds_BIPIDs,'S').ds_contact_linkidskey_recs;	
				

	dsBiz 		:= JOIN(needREA,bizContacts,
										 LEFT.did = RIGHT.contact_did,	
										 TRANSFORM(PhoneOwnership.Layouts.Phone_Relationship,
										 SELF.acctno := LEFT.acctno,
										 SELF.did := LEFT.did,
										 SELF.bdid := RIGHT.company_bdid,
										 SELF.ssn := RIGHT.contact_ssn,
										 SELF.companyName := RIGHT.company_name,
										 SELF := RIGHT.contact_name,
										 SELF := RIGHT.company_address,
										 SELF.subj2own_relationship := Constants.Relationship.BUSINESS,
										 SELF.dt_first_seen:=(STRING)RIGHT.dt_first_seen,
										 SELF.dt_last_seen:=(STRING)RIGHT.dt_last_seen,
										 SELF:=RIGHT,
										 SELF:=LEFT,
										 SELF:=[]),
										 LIMIT(Constants.MAX_RECORDS,SKIP));	
	PhoneOwnership.Layouts.Phone_Relationship rollBusiness(PhoneOwnership.Layouts.Phone_Relationship l, PhoneOwnership.Layouts.Phone_Relationship r) := TRANSFORM
		SELF.seq := 0;
		SELF.dt_first_seen := (STRING)ut.Min2((INTEGER)l.dt_first_seen,(INTEGER)r.dt_first_seen);
		SELF := l;
		SELF := r;
		SELF := [];
	END;										 							 
	dsBusiness := ROLLUP(SORT(dsBiz,acctno,did,bdid,#expand(BIPV2.IDmacros.mac_ListAllLinkids()),-dt_last_seen,dt_first_seen),
														LEFT.acctno=RIGHT.acctno AND
														LEFT.did=RIGHT.did AND
														LEFT.bdid=RIGHT.bdid AND
														BIPV2.IDmacros.mac_JoinAllLinkids(),
														rollBusiness(LEFT,RIGHT)); 										 
	
	Suppress.MAC_Suppress(dsRelativesInfo,dsRelativesUnrestricted,inMod.ApplicationType,Suppress.Constants.LinkTypes.DID,DID);	
	REAB := UNGROUP(TOPN(GROUP(SORT(dsRelativesUnrestricted(fname <> '' AND lname <> ''),acctno,isdeceased,-isfirstdegree,titleno),acctno),Constants.MAXCOUNT_Relative,acctno) & 
									TOPN(GROUP(SORT(dsEmployer,acctno,-dt_last_seen,dt_first_seen,bdid),acctno),Constants.MAXCOUNT_Employer,acctno) & 
									TOPN(GROUP(SORT(dsBusiness,acctno,-dt_last_seen,dt_first_seen,#expand(BIPV2.IDmacros.mac_ListAllLinkids())),acctno),Constants.MAXCOUNT_Business,acctno));
	sortedREAB :=	SORT(PROJECT(dBatchIn,TRANSFORM(PhoneOwnership.Layouts.Phone_Relationship,SELF:=LEFT,SELF:=[])) + REAB, 
														acctno,subj2own_relationship != Constants.Relationship.SUBJECT,seq=0,seq,isdeceased,-isfirstdegree,titleno=0,titleno);
					
	PhoneOwnership.Layouts.Phone_Relationship seqREAB(PhoneOwnership.Layouts.Phone_Relationship l, PhoneOwnership.Layouts.Phone_Relationship r) := TRANSFORM
		match := l.acctno=r.acctno;
		SELF.acctno := r.acctno;
		SELF.seq := IF(match,l.seq + 1,1);
		SELF:=r;
		SELF:=[];
	END;
	sequencedREAB	:= ITERATE(sortedREAB,seqREAB(LEFT,RIGHT));
	#IF(PhoneOwnership.Constants.Debug.REAB)			
		// OUTPUT(dBatchIn,NAMED('dBatchInREA'));
		OUTPUT(needREA,NAMED('needREA'));
		// OUTPUT(dsRA,NAMED('DoxieRelatives'));
		// OUTPUT(dsUniqueRA,NAMED('dsUniqueRA'));
		// OUTPUT(dsRAwDeceased,NAMED('dsRAwDeceased'));
		// OUTPUT(dsRelativeBestRecs,NAMED('dsRelativeBestRecs'));
		// OUTPUT(dsRelativeBestRecs,NAMED('dsRelativeBestRecs'));
		// OUTPUT(dsRABest_noMinors,NAMED('dsRABest_noMinors'));
		// OUTPUT(dsRelativesInfo,NAMED('dsRelativesInfo'));
		// OUTPUT(dsPOE,NAMED('dsPOE'));
		// OUTPUT(dsPAW,NAMED('dsPAW'));
		// OUTPUT(bizContacts,NAMED('bizContacts'));	
		// OUTPUT(dsBiz,NAMED('dsBiz'));
		// OUTPUT(dsBusiness,NAMED('dsBusiness'));
		// OUTPUT(dsEmployer,NAMED('dsEmployer'));
		// OUTPUT(REAB,NAMED('REAB'));
		OUTPUT(sequencedREAB,NAMED('sequencedREAB'));
	#END
	RETURN sequencedREAB;
END;	