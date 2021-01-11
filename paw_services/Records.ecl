IMPORT doxie, FCRA, FFD, Paw, paw_services, Suppress;

EXPORT Records := MODULE

	EXPORT GetFCRA(DATASET(paw_services.Layouts.FCRA.workRec) ds_work_recs,
		DATASET(FFD.Layouts.PersonContextBatch) ds_PersonContext,
		DATASET(FFD.layouts.ConsumerFlagsBatch) ds_AlertFlags,
		paw_services.IParams.BatchParams in_mod) := FUNCTION

		ds_dids:=DEDUP(SORT(PROJECT(ds_work_recs,TRANSFORM(doxie.layout_references,SELF:=LEFT)),did),did);
		ds_FlagFile:=FFD.GetFlagFile(PROJECT(ds_dids,doxie.layout_best),ds_PersonContext)(file_id=FCRA.FILE_ID.PAW);

		// get any override records
		ds_override_recs:=JOIN(ds_FlagFile,FCRA.key_override_paw_ffid,
			KEYED(LEFT.flag_file_id=RIGHT.flag_file_id),
			TRANSFORM(Paw.Layout.Employment_Out,SELF:=RIGHT),
			KEEP(FCRA.compliance.MAX_OVERRIDE_LIMIT),LIMIT(0));

		// get paw records
		ds_paw_recs:=JOIN(ds_dids,PAW.Key_DID_FCRA,
			KEYED(LEFT.did=RIGHT.did) AND RIGHT.contact_id>0,
			TRANSFORM(Paw.Layout.Employment_Out,SELF:=RIGHT),
			KEEP(paw_services.Constants.FCRA.MaxPawPerDID),
			LIMIT(paw_services.Constants.FCRA.MaxPawRecords,SKIP));

		// less overwritten records
		ds_paw_less_overwritten:=JOIN(ds_paw_recs,ds_FlagFile,
			LEFT.did=(UNSIGNED)RIGHT.did
			AND (STRING)LEFT.contact_id=TRIM(RIGHT.record_id),
			TRANSFORM(Paw.Layout.Employment_Out,SELF:=LEFT),LEFT ONLY);

		ds_paw_raw:=(ds_paw_less_overwritten+ds_override_recs)(glb='N' OR in_mod.isValidGlb()); // apply GLB filter

		// apply suppressions
		Suppress.MAC_Suppress(ds_paw_raw,ds_dids_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.DID,did, isFCRA := true);
		Suppress.MAC_Suppress(ds_dids_pulled,ds_dids_ssns_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,ssn, isFCRA := true);

		// filter raw to disclose only fields restore acctno
		ds_paw_disclose:=JOIN(ds_work_recs,ds_dids_ssns_pulled,
			LEFT.did=RIGHT.did,
			TRANSFORM(paw_services.Layouts.FCRA.pawWorkRec,
				SELF.acctno:=LEFT.acctno,
				SELF.did:=LEFT.did,
				SELF.inquiry_lexid:=IF(RIGHT.did>0,(STRING)RIGHT.did,'');
				SELF:=RIGHT,SELF:=[]),
			LIMIT(0),KEEP(paw_services.Constants.FCRA.MaxPAWPerDID));

		// max results and sequence
		paw_services.Layouts.FCRA.pawWorkRec seqRecs(paw_services.Layouts.FCRA.pawWorkRec L,INTEGER seq) := TRANSFORM
			SELF.SequenceNumber:=seq;
			SELF:=L;
		END;
		ds_paw_srtd:=TOPN(GROUP(SORT(ds_paw_disclose,acctno),acctno),in_mod.MaxResultsPerAcct,(UNSIGNED)acctno,-dt_first_seen,-dt_last_seen);
		ds_paw_seqd:=PROJECT(UNGROUP(ds_paw_srtd),seqRecs(LEFT,COUNTER));

		// pickup record level statements and disputes
		paw_services.Layouts.FCRA.pawWorkRec addStatements(
			paw_services.Layouts.FCRA.pawWorkRec L,FFD.Layouts.PersonContextBatchSlim R) := TRANSFORM,
			SKIP(~FFD.FFDMask.isShowDisputed(in_mod.FFDOptionsMask) AND R.isDisputed)
			SELF.StatementIds:=R.StatementIDs;
			SELF.IsDisputed:=R.isDisputed;
			SELF:=L;
		END;

		ds_paw_statements:=JOIN(ds_paw_seqd,FFD.SlimPersonContext(ds_PersonContext),
			LEFT.acctno=RIGHT.acctno AND
			LEFT.did=(UNSIGNED)RIGHT.lexid AND
			(STRING)LEFT.contact_id=RIGHT.RecId1,
			addStatements(LEFT,RIGHT),
			LEFT OUTER,KEEP(1),LIMIT(0));

		// initialize statement dispute
		paw_services.Layouts.FCRA.pawWorkRec initializeStatements(paw_services.Layouts.FCRA.pawWorkRec L) := TRANSFORM
			statements:=PROJECT(L.StatementIds,
				FFD.InitializeConsumerStatementBatch(LEFT,FFD.Constants.RecordType.RS,
				'main',FFD.Constants.DataGroups.PAW,L.SequenceNumber,L.acctno,L.did));
			dispute:=IF(L.isDisputed,DATASET(ROW(FFD.InitializeConsumerStatementBatch(
				FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR,
				'main',FFD.Constants.DataGroups.PAW,L.SequenceNumber,L.acctno,L.did))));
			SELF.StatementsAndDisputes:=statements+dispute;
			SELF:=L;
		END;

		ds_paw_dispute:=PROJECT(ds_paw_statements,initializeStatements(LEFT));
		ds_paw_suppress:=FFD.MAC.ApplyConsumerAlertsBatch(ds_paw_dispute,ds_AlertFlags,StatementIds,paw_services.Layouts.FCRA.pawWorkRec,in_mod.FFDOptionsMask);
		ds_paw_inquiry:=FFD.Mac.InquiryLexidBatch(ds_work_recs,ds_paw_suppress,paw_services.Layouts.FCRA.pawWorkRec,0);

		// OUTPUT(ds_AlertFlags,NAMED('ds_AlertFlags'));
		// OUTPUT(FFD.SlimPersonContext(ds_PersonContext),NAMED('ds_SlimPersonContext'));
		// OUTPUT(ds_dids,NAMED('ds_dids'));
		// OUTPUT(ds_FlagFile,NAMED('ds_FlagFile'));
		// OUTPUT(SORT(ds_override_recs,did,-dt_first_seen,-dt_last_seen),NAMED('ds_override_recs'));
		// OUTPUT(SORT(ds_paw_recs,did,-dt_first_seen,-dt_last_seen),NAMED('ds_paw_recs'));
		// OUTPUT(SORT(ds_paw_raw,did,-dt_first_seen,-dt_last_seen),NAMED('ds_paw_raw'));
		// OUTPUT(SORT(ds_paw_disclose,(UNSIGNED)acctno,-dt_first_seen,-dt_last_seen),NAMED('ds_paw_disclose'));
		// OUTPUT(SORT(ds_paw_dispute,(UNSIGNED)acctno,-dt_first_seen,-dt_last_seen),NAMED('ds_paw_dispute'));
		// OUTPUT(SORT(ds_paw_suppress,(UNSIGNED)acctno,-dt_first_seen,-dt_last_seen),NAMED('ds_paw_suppress'));

		RETURN SORT(ds_paw_inquiry,(UNSIGNED)acctno,SequenceNumber);
	END;

END;
