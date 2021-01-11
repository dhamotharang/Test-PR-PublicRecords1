IMPORT doxie, FCRA, FFD, dx_Gong, Gong_Services, Suppress, data_services;

EXPORT Records := MODULE

		EXPORT GetFCRA(DATASET(Gong_Services.Layouts.FCRA.workRec) ds_work_recs,
			DATASET(FFD.Layouts.PersonContextBatch) ds_PersonContext,
			DATASET(FFD.layouts.ConsumerFlagsBatch) ds_AlertFlags,
			Gong_Services.IParams.BatchParams in_mod) := FUNCTION

			ds_dids:=DEDUP(SORT(PROJECT(ds_work_recs,TRANSFORM(doxie.layout_references,SELF:=LEFT)),did),did);
			ds_FlagFile:=FFD.GetFlagFile(PROJECT(ds_dids,doxie.layout_best),ds_PersonContext)(file_id=FCRA.FILE_ID.GONG);
			override_ids:=SET(ds_FlagFile,TRIM(record_id));

			// get any override records
			ds_override_recs:=JOIN(ds_FlagFile,FCRA.key_override_gong_ffid,
				KEYED(LEFT.flag_file_id=RIGHT.flag_file_id),
				TRANSFORM(FCRA.Layout_Override_Gong,SELF:=RIGHT),
				KEEP(FCRA.compliance.MAX_OVERRIDE_LIMIT),LIMIT(0));

			// get gong records
			ds_gong_recs:=JOIN(ds_dids,dx_Gong.key_history_did(data_services.data_env.iFCRA),
				KEYED(LEFT.did=RIGHT.l_did),
				TRANSFORM(FCRA.Layout_Override_Gong,SELF:=RIGHT,SELF:=[]),
				KEEP(Gong_Services.Constants.FCRA.MaxGongPerDID),
				LIMIT(Gong_Services.Constants.FCRA.MaxGongRecords,SKIP));

			// less overwritten records
			ds_gong_less_overwritten:=JOIN(ds_gong_recs,ds_FlagFile,
				LEFT.did=(UNSIGNED)RIGHT.did
				AND ((STRING)LEFT.did+(STRING)LEFT.phone10+(STRING)LEFT.dt_first_seen=TRIM(RIGHT.record_id) // old way - prior to 11/13/2012
				OR (STRING)LEFT.persistent_record_id=TRIM(RIGHT.record_id)), // new way - using persistent_record_id
				TRANSFORM(FCRA.Layout_Override_Gong,SELF:=LEFT),LEFT ONLY);

			ds_gong_raw:=ds_gong_less_overwritten+ds_override_recs;

			// apply suppressions
			Suppress.MAC_Suppress(ds_gong_raw,ds_dids_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.DID,l_did, isFCRA := true);

			// filter raw to disclose only fields restore acctno
			ds_gong_disclose:=JOIN(ds_work_recs,ds_dids_pulled,
				LEFT.did=RIGHT.l_did,
				TRANSFORM(Gong_Services.Layouts.FCRA.gongWorkRec,
					SELF.acctno:=LEFT.acctno,
					SELF.did:=LEFT.did,
					SELF.inquiry_lexid:=IF(RIGHT.l_did>0,(STRING)RIGHT.l_did,'');
					SELF:=RIGHT,SELF:=[]),
				LIMIT(0),KEEP(Gong_Services.Constants.FCRA.MaxGongPerDID));

		// max results and sequence
			Gong_Services.Layouts.FCRA.gongWorkRec seqRecs(Gong_Services.Layouts.FCRA.gongWorkRec L,INTEGER seq) := TRANSFORM
				SELF.SequenceNumber:=seq;
				SELF:=L;
			END;
			ds_gong_srtd:=TOPN(GROUP(SORT(ds_gong_disclose,acctno),acctno),in_mod.MaxResultsPerAcct,(UNSIGNED)acctno,-dt_first_seen,-dt_last_seen);
			ds_gong_seqd:=PROJECT(UNGROUP(ds_gong_srtd),seqRecs(LEFT,COUNTER));

			// pickup record level statements and disputes
			Gong_Services.Layouts.FCRA.gongWorkRec addStatements(
				Gong_Services.Layouts.FCRA.gongWorkRec L,FFD.Layouts.PersonContextBatchSlim R) := TRANSFORM,
				SKIP(~FFD.FFDMask.isShowDisputed(in_mod.FFDOptionsMask) AND R.isDisputed)
				SELF.StatementIds:=R.StatementIDs;
				SELF.IsDisputed:=R.isDisputed;
				SELF:=L;
			END;

			ds_gong_statements:=JOIN(ds_gong_seqd,FFD.SlimPersonContext(ds_PersonContext),
				LEFT.acctno=RIGHT.acctno AND
				LEFT.did=(UNSIGNED)RIGHT.lexid AND
				(STRING)LEFT.persistent_record_id=RIGHT.RecId1,
				addStatements(LEFT,RIGHT),
				LEFT OUTER,KEEP(1),LIMIT(0));

			// initialize statement dispute
			Gong_Services.Layouts.FCRA.gongWorkRec initializeStatements(Gong_Services.Layouts.FCRA.gongWorkRec L) := TRANSFORM
				statements:=PROJECT(L.StatementIds,
					FFD.InitializeConsumerStatementBatch(LEFT,FFD.Constants.RecordType.RS,
					'main',FFD.Constants.DataGroups.GONG,L.SequenceNumber,L.acctno,L.did));
				dispute:=IF(L.isDisputed,DATASET(ROW(FFD.InitializeConsumerStatementBatch(
					FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR,
					'main',FFD.Constants.DataGroups.GONG,L.SequenceNumber,L.acctno,L.did))));
				SELF.StatementsAndDisputes:=statements+dispute;
				SELF:=L;
			END;

			ds_gong_dispute:=PROJECT(ds_gong_statements,initializeStatements(LEFT));
			ds_gong_suppress:=FFD.MAC.ApplyConsumerAlertsBatch(ds_gong_dispute,ds_AlertFlags,StatementIds,Gong_Services.Layouts.FCRA.gongWorkRec,in_mod.FFDOptionsMask);
			ds_gong_inquiry:=FFD.Mac.InquiryLexidBatch(ds_work_recs,ds_gong_suppress,Gong_Services.Layouts.FCRA.gongWorkRec,0);

			// OUTPUT(ds_AlertFlags,NAMED('ds_AlertFlags'));
			// OUTPUT(FFD.SlimPersonContext(ds_PersonContext),NAMED('ds_SlimPersonContext'));
			// OUTPUT(ds_dids,NAMED('ds_dids'));
			// OUTPUT(ds_FlagFile,NAMED('ds_FlagFile'));
			// OUTPUT(SORT(ds_override_recs,did,-dt_first_seen,-dt_last_seen),NAMED('ds_override_recs'));
			// OUTPUT(SORT(ds_gong_recs,did,-dt_first_seen,-dt_last_seen),NAMED('ds_gong_recs'));
			// OUTPUT(SORT(ds_gong_raw,did,-dt_first_seen,-dt_last_seen),NAMED('ds_gong_raw'));
			// OUTPUT(SORT(ds_gong_disclose,(UNSIGNED)acctno,-dt_first_seen,-dt_last_seen),NAMED('ds_gong_disclose'));
			// OUTPUT(SORT(ds_gong_dispute,(UNSIGNED)acctno,-dt_first_seen,-dt_last_seen),NAMED('ds_gong_dispute'));
			// OUTPUT(SORT(ds_gong_suppress,(UNSIGNED)acctno,-dt_first_seen,-dt_last_seen),NAMED('ds_gong_suppress'));

			RETURN SORT(ds_gong_inquiry,(UNSIGNED)acctno,SequenceNumber);
		END;

END;
