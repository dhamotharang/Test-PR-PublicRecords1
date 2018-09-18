/*
This function gets Relatives, Employers, Associates, and Businesses (REAB) for accounts with input for 
firstname, lastname, and (DID or SSN or full address or DOB).
*/
IMPORT BatchServices,BIPV2,BIPV2_Build,Codes,DeathV2_Services,Doxie,Doxie_Raw,EmailService,Header,
       MDR,PAW,PhoneOwnership,Phones,POE,STD,Suppress,ut;

EXPORT GetREAB(DATASET(PhoneOwnership.Layouts.PhonesCommon) dBatchIn,PhoneOwnership.IParams.BatchParams inMod) :=FUNCTION //

  mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
      EXPORT unsigned1 glb := inMod.glbpurpose;
      EXPORT unsigned1 dppa := inMod.dppapurpose;
      EXPORT string DataPermissionMask := inMod.DataPermissionMask;
      EXPORT string DataRestrictionMask := inMod.DataRestrictionMask;
      EXPORT string5 industry_class := inMod.industryclass;
      EXPORT string32 application_type := inMod.applicationtype;
      EXPORT string ssn_mask := inMod.ssn_mask;
      EXPORT unsigned1 dl_mask :=	IF (inMod.mask_dl, 1, 0);
		END;	

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
	// *** Relatives and associates
	dsRA := Doxie_Raw.relative_raw(DEDUP(subjectDIDs,ALL),,mod_access.dppa, mod_access.glb,,,,,,Constants.MAX_RelativeDept);
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
							NOT DeathV2_Services.Functions.Restricted(RIGHT.src, RIGHT.glb_flag, mod_access.isValidGLB(), deathParams),
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
//	dsRelativeBestRecs := Doxie.best_records(relativesDid,DPPA_override:=inMod.DPPAPurpose,GLB_override:=inMod.GLBPurpose);
	dsRelativeBestRecs := Doxie.best_records(relativesDid, modAccess := mod_access);
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
	// *** Employers										
	dsPOE 			:= JOIN(needREA,POE.Keys().did.qa,
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
										SELF.src:=RIGHT.source,
										SELF:=RIGHT,
										SELF:=LEFT,
										SELF:=[]),
							LIMIT(Constants.MAX_RECORDS,SKIP));
										 
	dsPAWContact 	:= JOIN(needREA,PAW.Key_Did,
							KEYED(LEFT.did = RIGHT.did),	
							LIMIT(Constants.MAX_RECORDS,SKIP));	
	dsPAW		 	:= JOIN(dsPAWContact,PAW.Key_contactID,
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
										SELF.src:=RIGHT.source,
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
	dsEmployerUnfiltered := ROLLUP(SORT(dsPOE + dsPAW,acctno,did,bdid,-dt_last_seen,dt_first_seen),
						LEFT.acctno=RIGHT.acctno AND
						LEFT.did=RIGHT.did AND
						LEFT.bdid=RIGHT.bdid,
						rollEmployer(LEFT,RIGHT)); 
	// remove royalty sources					
	dsEmployer := dsEmployerUnfiltered(src NOT IN BatchServices.WorkPlace_Constants.WP_ROYALTY_SOURCE_SET);
	// *** Business
	ds_results_w_acct := 	BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(PROJECT(subjectDIDs,TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,SELF.contact_did:=LEFT.did,SELF:=[]))).uid_results_w_acct;
	ds_BIPIDs := PROJECT(ds_results_w_acct,TRANSFORM( BIPV2.IDlayouts.l_xlink_ids,
														SELF := LEFT));
	bizContacts := BIPV2_Build.key_contact_linkids.kFetch(ds_BIPIDs,'S');	
	dsBiz 		:= JOIN(needREA,bizContacts(contact_did<>0),
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
	dsBusiness := ROLLUP(SORT(dsBiz,acctno,did,#expand(BIPV2.IDmacros.mac_ListAllLinkids()),-dt_last_seen,dt_first_seen),
								LEFT.acctno=RIGHT.acctno AND
								LEFT.did=RIGHT.did AND
								BIPV2.IDmacros.mac_JoinAllLinkids(),
								rollBusiness(LEFT,RIGHT)); 										 
	
	Suppress.MAC_Suppress(dsRelativesInfo,dsRelativesUnrestricted,mod_access.application_type,Suppress.Constants.LinkTypes.DID,DID);
	// Returns a max of 15 identities including max 2 employers and max 2 businesses	
	REAB := UNGROUP(TOPN(GROUP(SORT(dsRelativesUnrestricted(fname <> '' AND lname <> ''),acctno,isdeceased,-isfirstdegree,titleno),acctno),Constants.MAXCOUNT_Relative,acctno) & 
									TOPN(GROUP(SORT(dsEmployer,acctno,-dt_last_seen,dt_first_seen,bdid),acctno),Constants.MAXCOUNT_Employer,acctno) & 
									TOPN(GROUP(SORT(dsBusiness,acctno,-dt_last_seen,dt_first_seen,#expand(BIPV2.IDmacros.mac_ListAllLinkids())),acctno),Constants.MAXCOUNT_Business,acctno));
	sortedREAB :=	SORT(PROJECT(dBatchIn,TRANSFORM(PhoneOwnership.Layouts.Phone_Relationship,SELF:=LEFT,SELF:=[])) + REAB, 
														acctno,subj2own_relationship != Constants.Relationship.SUBJECT,seq=0,seq,isdeceased,-isfirstdegree,titleno=0,titleno);
	// *** sequence output based on sorted significance of the relationship				
	PhoneOwnership.Layouts.Phone_Relationship seqREAB(PhoneOwnership.Layouts.Phone_Relationship l, PhoneOwnership.Layouts.Phone_Relationship r) := TRANSFORM
		match := l.acctno=r.acctno;
		SELF.acctno := r.acctno;
		SELF.seq := IF(match,l.seq + 1,1);
		SELF.companyName := IF(r.companyName<>'',Phones.Functions.GetCleanCompanyName(r.companyName),'');
		SELF:=r;
		SELF:=[];
	END;
	sequencedREAB	:= ITERATE(sortedREAB,seqREAB(LEFT,RIGHT));
	//append Email for relative
	dsEmails := doxie.email_records (PROJECT(sequencedREAB,doxie.layout_references),
														inMod.ssn_mask, inMod.ApplicationType,FALSE,inMod.industryclass);
	nonRoyaltyEmails := dsEmails(src NOT in	SET(codes.Key_Codes_V3(file_name	=	'EMAIL_SOURCES',field_name	=	'ROYALTY'),code));
	layout_emails := RECORD
		dsEmails.did;
		DATASET(PhoneOwnership.Layouts.Emails) emails {MAXCOUNT(Constants.MAX_EMAILS_PER_PERSON)};
	END;														

	layout_emails getEmails (EmailService.Assorted_Layouts.layout_report_rollup l) := TRANSFORM 
		SELF.DID := l.DID;
		SELF.emails := CHOOSEN(PROJECT(l.emails, TRANSFORM(PhoneOwnership.Layouts.Emails,SELF.DID := l.DID,SELF:=LEFT)),Constants.MAX_EMAILS_PER_PERSON);
	END;
	REABwEmail := PROJECT(nonRoyaltyEmails, getEmails(LEFT));

	dsBestEmails := DEDUP(SORT(PROJECT(REABwEmail.emails,PhoneOwnership.Layouts.Emails),DID,-date_last_seen,date_first_seen),DID);

	sequencedREABwEmail := JOIN(sequencedREAB,dsBestEmails,
								LEFT.DID = RIGHT.DID,
								TRANSFORM(PhoneOwnership.Layouts.Phone_Relationship,
								SELF.emailAddress := RIGHT.clean_email,
								SELF:=LEFT),
								LEFT OUTER, KEEP(1));																		
	
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
		OUTPUT(ds_BIPIDs,NAMED('ds_BIPIDs'));	
		OUTPUT(bizContacts,NAMED('bizContacts'));	
		OUTPUT(dsBiz,NAMED('dsBiz'));
		OUTPUT(dsBusiness,NAMED('dsBusiness'));
		OUTPUT(dsEmployer,NAMED('dsEmployer'));
		// OUTPUT(REAB,NAMED('REAB'));
		OUTPUT(sequencedREAB,NAMED('sequencedREAB'));
		OUTPUT(dsEmails,NAMED('dsEmails'));
		OUTPUT(sequencedREABwEmail,NAMED('sequencedREABwEmail'));
	#END
	RETURN sequencedREABwEmail;
END;	