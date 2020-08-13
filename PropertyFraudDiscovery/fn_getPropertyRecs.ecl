IMPORT LN_PropertyV2_Services,Suppress,LN_PropertyV2,BatchShare,Codes;

EXPORT fn_getPropertyRecs(DATASET(Layouts.batch_working) ds_work_recs,
													IParams.BatchParams in_mod) := FUNCTION

	UNSIGNED thisYear:=(UNSIGNED)StringLib.getDateYYYYMMDD()[1..4];
	STRING8  minDate:=(STRING)(thisYear-in_mod.NumberPropertyYears)+'0000';

	acctnoFidRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		LN_PropertyV2_Services.layouts.search_fid;
	END;


	getDeeds(DATASET(acctnoFidRec) fids) := FUNCTION

		DEEDS_FILE:=LN_PropertyV2_Services.consts.deeds_codefile;

		acctnoDeedRec:=RECORD
			BatchShare.Layouts.ShareAcct;
			Layouts.coreSlim;
			Layouts.deedSlim;
		END;

		acctnoDeedRec xformDeeds(acctnoDeedRec L) := TRANSFORM
			// FILTER RECORDS BY DATE
			sortby_date:=LN_PropertyV2_Services.Raw.deed_recency(L);
			SELF.sortby_date:=IF(sortby_date>=minDate,sortby_date,SKIP);
			fid_type:=LN_PropertyV2.fn_fid_type(L.ln_fares_id);
			SELF.fid_type:=fid_type;
			SELF.fid_type_desc:=LN_PropertyV2_Services.fn_fid_type_desc(fid_type);
			SELF.vendor_source_flag:=LN_PropertyV2_Services.fn_vendor_source_obscure(L.vendor_source_flag);
			vsource:=LN_PropertyV2_Services.fn_vendor_source(L.vendor_source_flag);
			SELF.vendor_source_desc:=vsource;
			SELF.document_type_desc:=Codes.KeyCodes(DEEDS_FILE,'DOCUMENT_TYPE',vsource,L.document_type_code,TRUE);
			SELF.fares_mortgage_deed_type_desc:=Codes.KeyCodes(DEEDS_FILE,'MORTGAGE_DEED_TYPE',vsource,L.fares_mortgage_deed_type,TRUE);
			SELF:=L;
		END;

		rawDeeds:=JOIN(fids,LN_PropertyV2.key_deed_fid(),
			KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id) AND right.record_type NOT IN LN_PropertyV2.Constants.setAssignRelsRecordTypes,//Assignments and Releases codes excluded
			TRANSFORM(acctnoDeedRec,SELF:=LEFT,SELF:=RIGHT,SELF:=[]),
			LIMIT(LN_PropertyV2_Services.consts.MAX_RAW,SKIP));

		addlDeeds:=JOIN(rawDeeds,LN_PropertyV2.key_addl_fares_deed_fid,
			KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id),
			TRANSFORM(acctnoDeedRec,
				SELF.fares_mortgage_date:=RIGHT.fares_mortgage_date,
				SELF.fares_mortgage_deed_type:=RIGHT.fares_mortgage_deed_type,
				SELF:=LEFT,SELF:=[]),
			LEFT OUTER,LIMIT(0),KEEP(1));

		RETURN PROJECT(addlDeeds,xformDeeds(LEFT));
	END;


	getAssessments(DATASET(acctnoFidRec) fids) := FUNCTION

		ASSESS_FILE:=LN_PropertyV2_Services.consts.assess_codefile;

		acctnoAssessmentRec:=RECORD
			BatchShare.Layouts.ShareAcct;
			Layouts.coreSlim;
			Layouts.assessmentSlim;
		END;

		acctnoAssessmentRec xformAssessments(acctnoAssessmentRec L) := TRANSFORM
			// FILTER RECORDS BY DATE
			SELF.sortby_date:=IF(L.sortby_date>=minDate,L.sortby_date,SKIP);
			fid_type:=LN_PropertyV2.fn_fid_type(L.ln_fares_id);
			SELF.fid_type:=fid_type;
			SELF.fid_type_desc:=LN_PropertyV2_Services.fn_fid_type_desc(fid_type);
			SELF.vendor_source_flag:=LN_PropertyV2_Services.fn_vendor_source_obscure(L.vendor_source_flag);
			vsource:=LN_PropertyV2_Services.fn_vendor_source(L.vendor_source_flag);
			SELF.vendor_source_desc:=vsource;
			SELF.assessee_ownership_rights_desc:=Codes.KeyCodes(ASSESS_FILE,'OWNER_OWNERSHIP_RIGHTS_CODE',vsource,L.assessee_ownership_rights_code,TRUE);
			SELF.assessee_relationship_desc:=Codes.KeyCodes(ASSESS_FILE,'OWNER_RELATIONSHIP_CODE',vsource,L.assessee_relationship_code,TRUE);
			SELF.document_type_desc:=Codes.KeyCodes(ASSESS_FILE,'DOCUMENT_TYPE',vsource,L.document_type,TRUE);
			SELF:=L;
		END;

		rawAssessments:=JOIN(fids,LN_PropertyV2.key_assessor_fid(),
			KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id),
			TRANSFORM(acctnoAssessmentRec,
				SELF.sortby_date:=LN_PropertyV2_Services.Raw.assess_recency(RIGHT),
				SELF:=LEFT,SELF:=RIGHT,SELF:=[]),
			LIMIT(LN_PropertyV2_Services.consts.MAX_RAW,SKIP));

		RETURN PROJECT(rawAssessments,xformAssessments(LEFT));
	END;


	getParties(DATASET(acctnoFidRec) fids) := FUNCTION

		acctnoRawPartyRec:=RECORD
			BatchShare.Layouts.ShareAcct;
			LN_PropertyV2_Services.layouts.parties.raw_source;
		END;

		partyParentRec:=RECORD
			BatchShare.Layouts.ShareAcct;
			LN_PropertyV2_Services.layouts.fid.ln_fares_id;
			LN_PropertyV2_Services.layouts.core.fid_type;
		END;

		acctnoPartyEntityRec:=RECORD
			partyParentRec;
			LN_PropertyV2_Services.layouts.parties.tmp1.dt_last_seen;
			LN_PropertyV2_Services.layouts.parties.tmp1.addr_type;
			LN_PropertyV2_Services.layouts.parties.pparty.party_type;
			LN_PropertyV2_Services.layouts.parties.pparty.party_type_name;
			LN_PropertyV2_Services.layouts.parties.entity;
		END;

		rollParties(DATASET(acctnoPartyEntityRec) preSortedEntities) := FUNCTION

			partyChildRec:=RECORD
				LN_PropertyV2_Services.layouts.parties.pparty.party_type;
				LN_PropertyV2_Services.layouts.parties.pparty.party_type_name;
				DATASET(LN_PropertyV2_Services.layouts.parties.entity) entity;
			END;

			acctnoParentChildRec:=RECORD
				partyParentRec;
				partyChildRec;
			END;

			acctnoPartyRec:=RECORD
				partyParentRec;
				DATASET(partyChildRec) parties;
			END;

			acctnoParentChildRec rollEntities(acctnoPartyEntityRec L,DATASET(acctnoPartyEntityRec) R) := TRANSFORM
				SELF.entity:=PROJECT(R,TRANSFORM(LN_PropertyV2_Services.layouts.parties.entity,SELF:=LEFT,SELF:=[]));
				SELF:=L;
			END;

			acctnoPartyRec rollParties(acctnoParentChildRec L,DATASET(acctnoParentChildRec) R) := TRANSFORM
				SELF.parties:=PROJECT(R,TRANSFORM(partyChildRec,SELF:=LEFT,SELF:=[]));
				SELF:=L;
			END;

			grpEntities := GROUP(preSortedEntities,acctno,fid_type,ln_fares_id,party_type);
			rolEntities := ROLLUP(grpEntities,GROUP,rollEntities(LEFT,ROWS(LEFT)));
			srtParties  := SORT(rolEntities,acctno,fid_type,ln_fares_id);
			grpParties  := GROUP(srtParties,acctno,fid_type,ln_fares_id);

			RETURN ROLLUP(grpParties,GROUP,rollParties(LEFT,ROWS(LEFT)));
		END;

		acctnoPartyEntityRec slimPartyRecs(acctnoRawPartyRec L) := TRANSFORM
			fid_type:=LN_PropertyV2.fn_fid_type(L.ln_fares_id);
			SELF.fid_type:=fid_type;
			party_type:=L.source_code_1;
			SELF.addr_type:=L.source_code_2;
			SELF.party_type:=party_type;
			SELF.party_type_name:=LN_PropertyV2_Services.party_type_named(fid_type,party_type);		
			SELF.did:=IF(L.did!=0,(STRING12)L.did,'');
			SELF.bdid:=IF(L.bdid!=0,(STRING12)L.bdid,'');
			SELF:=L;
		END;

		acctnoPartyEntityRec setPropertyRecs(acctnoPartyEntityRec L) := TRANSFORM
			SELF.acctno:=L.acctno;
			SELF.ln_fares_id:=L.ln_fares_id;
			SELF.fid_type:=L.fid_type;
			SELF.addr_type:=L.addr_type;
			SELF.party_type:='P';
			SELF.party_type_name:='Property';
			SELF:=[];
		end;

		rawParties:=JOIN(fids,LN_PropertyV2.key_search_fid(),
			KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id),
			TRANSFORM(acctnoRawPartyRec,SELF:=LEFT,SELF:=RIGHT,SELF:=[]),
			LIMIT(LN_PropertyV2_Services.consts.MAX_PARTIES,SKIP));

		tmpParties1 := PROJECT(rawParties,slimPartyRecs(LEFT));
		ds_addrType_P := tmpParties1(addr_type='P');       // property addr recs
		ds_addrType_N := tmpParties1(addr_type!='P');      // non-property addr recs
		ds_addrType_X := JOIN(ds_addrType_P,ds_addrType_N, // propagate recs with no property addr duplicate
			LEFT.ln_fares_id=RIGHT.ln_fares_id AND
			LEFT.party_type=RIGHT.party_type,LEFT ONLY);
		tmpParties2 := PROJECT(ds_addrType_P,setPropertyRecs(LEFT))+ds_addrType_N+ds_addrType_X;
		dupSrtParties := DEDUP(SORT(tmpParties2,acctno,fid_type,ln_fares_id,party_type,-dt_last_seen,RECORD),RECORD);

		RETURN rollParties(dupSrtParties);
	END;


	slimPropRec := RECORD
		Layouts.coreSlim;
		DATASET(Layouts.deedSlim) deeds;
		DATASET(Layouts.assessmentSlim) assessments;
		DATASET(Layouts.partySlim) parties;
	END;

	slimAcctPropRec := RECORD
		BatchShare.Layouts.ShareAcct;
		slimPropRec;
	END;

	workingSlimPropRec := RECORD
		Layouts.batch_working;
		DATASET(slimPropRec) properties;
	END;

	workingSlimPropRec addPropsToWorking(Layouts.batch_working L,DATASET(slimAcctPropRec) R) := TRANSFORM
		SELF.properties:=PROJECT(R,TRANSFORM(slimPropRec,SELF:=LEFT));
		SELF:=L;
	END;

	Layouts.deedVndr addDeedChildren(Layouts.deedVndr L,DATASET(slimPropRec) ds_prop_recs) := TRANSFORM
		SELF.vndrSrcFlg:=L.vndrSrcFlg;
		SELF.deedsParties:=PROJECT(ds_prop_recs,TRANSFORM(Layouts.deedsPartiesRec,SELF:=LEFT));
	END;

	Layouts.assessmentVndr addAssessmentChildren(Layouts.assessmentVndr L,DATASET(slimPropRec) ds_prop_recs) := TRANSFORM
		SELF.vndrSrcFlg:=L.vndrSrcFlg;
		SELF.assessmentsParties:=PROJECT(ds_prop_recs,TRANSFORM(Layouts.assessmentsPartiesRec,SELF:=LEFT));
	END;

	Layouts.batch_working_prop separatePropertiesByVendor(workingSlimPropRec L) := TRANSFORM
		deedRecs:=L.properties(fid_type=LN_PropertyV2.Constants.RECORD_TYPE.DEED);
		deedParentRecs:=DEDUP(PROJECT(deedRecs,TRANSFORM(Layouts.deedVndr,SELF.vndrSrcFlg:=LEFT.vendor_source_flag,SELF:=[])),ALL);
		SELF.deedVndrProperties:=DENORMALIZE(deedParentRecs,deedRecs,LEFT.vndrSrcFlg=RIGHT.vendor_source_flag,
			GROUP,addDeedChildren(LEFT,ROWS(RIGHT)));
		assessmentRecs:=L.properties(fid_type=LN_PropertyV2.Constants.RECORD_TYPE.ASSESSMENT);
		assessmentParentRecs:=DEDUP(PROJECT(assessmentRecs,TRANSFORM(Layouts.assessmentVndr,SELF.vndrSrcFlg:=LEFT.vendor_source_flag,SELF:=[])),ALL);
		SELF.assessorVndrProperties:=DENORMALIZE(assessmentParentRecs,assessmentRecs,LEFT.vndrSrcFlg=RIGHT.vendor_source_flag,
			GROUP,addAssessmentChildren(LEFT,ROWS(RIGHT)));
		SELF:=L;
		SELF:=[];
	END;

	raw_fid_recs:=JOIN(ds_work_recs,LN_PropertyV2.key_addr_fid(),
		KEYED(LEFT.prim_name=RIGHT.prim_name) AND
		KEYED(LEFT.prim_range=RIGHT.prim_range) AND
		KEYED(LEFT.z5=RIGHT.zip) AND
		KEYED(LEFT.predir=RIGHT.predir) AND
		KEYED(LEFT.postdir=RIGHT.postdir) AND
		KEYED(LEFT.addr_suffix=RIGHT.suffix) AND
		KEYED(LEFT.sec_range=RIGHT.sec_range) AND
		RIGHT.source_code_2='P',
		TRANSFORM(acctnoFidRec,SELF:=LEFT,SELF:=RIGHT),
		LIMIT(LN_PropertyV2_Services.consts.MAX_RAW,SKIP));

	dup_fid_recs:=DEDUP(SORT(raw_fid_recs,acctno,ln_fares_id),acctno,ln_fares_id);

	// APPLY DATA_RESTRICTION_MASK USING FIRST CHARACTER OF LN_FARES_ID
	// 'R' = FARES = VENDOR_SOURCE_DESC IS 'FAR_F' AND 'FAR_S'
	// 'O' = FIDELITY = VENDOR_SOURCE_DESC IS 'OKCTY'
	// 'D' = LNBRANDED = VENDOR_SOURCE_DESC IS 'DAYTN'
	// DRM = '00000' ALLOW['O','R'] RESTRICT['D']
	// DRM = '10000' ALLOW['O'] RESTRICT['R','D']
	// DRM = '00001' ALLOW['R'] RESTRICT['O','D']
	// TO ALLOW['D'] FIDELITY MUST BE INCLUDED AND LNBRANDED=TRUE
	tmp_fid_recs:=dup_fid_recs(ln_fares_id[1] NOT IN LN_PropertyV2_Services.input.srcRestrict);

	deed_recs:=getDeeds(tmp_fid_recs);
	assessment_recs:=getAssessments(tmp_fid_recs);

	// DEEDS AND ASSESSMENTS MAY BE FILTERED BY DATE
	prty_fid_recs:= PROJECT(deed_recs,TRANSFORM(acctnoFidRec,SELF:=LEFT))+
						PROJECT(assessment_recs,TRANSFORM(acctnoFidRec,SELF:=LEFT));

	party_recs:=getParties(prty_fid_recs);

	deed_party_recs:=JOIN(deed_recs,party_recs,
		LEFT.acctno=RIGHT.acctno AND
		LEFT.ln_fares_id=RIGHT.ln_fares_id AND
		LEFT.fid_type=RIGHT.fid_type,
		TRANSFORM(slimAcctPropRec,
			SELF.deeds:=PROJECT(LEFT,TRANSFORM(Layouts.deedSlim,SELF:=LEFT)),
			SELF.parties:=PROJECT(RIGHT.parties,TRANSFORM(Layouts.partySlim,SELF:=LEFT)),
			SELF:=LEFT,SELF:=[]),
		LIMIT(0),KEEP(1));

	assessment_party_recs:=JOIN(assessment_recs,party_recs,
		LEFT.acctno=RIGHT.acctno AND
		LEFT.ln_fares_id=RIGHT.ln_fares_id AND
		LEFT.fid_type=RIGHT.fid_type,
		TRANSFORM(slimAcctPropRec,
			SELF.assessments:=PROJECT(LEFT,TRANSFORM(Layouts.assessmentSlim,SELF:=LEFT)),
			SELF.parties:=PROJECT(RIGHT.parties,TRANSFORM(Layouts.partySlim,SELF:=LEFT)),
			SELF:=LEFT,SELF:=[]),
		LIMIT(0),KEEP(1));

	property_recs:=SORT(deed_party_recs+assessment_party_recs,-sortby_date,ln_fares_id);

	tmp_prop_recs:=DENORMALIZE(ds_work_recs,property_recs,
		LEFT.acctno=RIGHT.acctno,GROUP,addPropsToWorking(LEFT,ROWS(RIGHT)));

	RETURN PROJECT(tmp_prop_recs,separatePropertiesByVendor(LEFT));
END;