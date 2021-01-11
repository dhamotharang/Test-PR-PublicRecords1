IMPORT doxie, FFD, FCRA, Prof_LicenseV2, Prof_LicenseV2_Services, Suppress;

EXPORT Records := MODULE

	EXPORT GetFCRA(DATASET(prof_LicenseV2_Services.Layouts.FCRA.workRec) ds_work_recs,
		DATASET(FFD.Layouts.PersonContextBatch) ds_PersonContext,
		DATASET(FFD.layouts.ConsumerFlagsBatch) ds_AlertFlags,
		prof_LicenseV2_Services.IParams.BatchParams in_mod) := FUNCTION

		ds_dids:=DEDUP(SORT(PROJECT(ds_work_recs,TRANSFORM(doxie.layout_references,SELF:=LEFT)),did),did);
		ds_FlagFile:=FFD.GetFlagFile(PROJECT(ds_dids,doxie.layout_best),ds_PersonContext)(file_id=FCRA.FILE_ID.PROFLIC);

		// get any override records
		ds_override_recs:=JOIN(ds_FlagFile,FCRA.key_override_proflic_ffid,
			KEYED(LEFT.flag_file_id=RIGHT.flag_file_id),
			TRANSFORM(Prof_LicenseV2.Layouts_ProfLic.Layout_Base,SELF:=RIGHT,SELF:=[]),
			KEEP(FCRA.compliance.MAX_OVERRIDE_LIMIT),LIMIT(0));

		// get license records
		ds_proflic_recs:=JOIN(ds_dids,Prof_LicenseV2.Key_Proflic_Did(TRUE),
			KEYED(LEFT.did=RIGHT.did) AND RIGHT.prolic_key!='',
			TRANSFORM(Prof_LicenseV2.Layouts_ProfLic.Layout_Base,SELF.did:=(STRING)RIGHT.did,SELF:=RIGHT),
			KEEP(prof_LicenseV2_Services.Constants.FCRA.MaxProfLicPerDID),
			LIMIT(prof_LicenseV2_Services.Constants.FCRA.MaxProfLicRecords,SKIP));

		// less overwritten records
		ds_proflic_less_overwritten:=JOIN(ds_proflic_recs,ds_FlagFile,
			(UNSIGNED)LEFT.did=(UNSIGNED)RIGHT.did
			AND LEFT.prolic_key=TRIM(RIGHT.record_id),
			TRANSFORM(Prof_LicenseV2.Layouts_ProfLic.Layout_Base,SELF:=LEFT),LEFT ONLY);

		ds_proflic_raw:=ds_proflic_less_overwritten+ds_override_recs;

		// apply suppressions
		Suppress.MAC_Suppress(ds_proflic_raw,ds_dids_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.DID,did, isFCRA := true);
		Suppress.MAC_Suppress(ds_dids_pulled,ds_dids_ssns_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,best_ssn, isFCRA := true);

		// filter raw to disclose only fields restore acctno
		ds_proflic_disclose:=JOIN(ds_work_recs,ds_dids_ssns_pulled,
			LEFT.did=(UNSIGNED)RIGHT.did,
			TRANSFORM(prof_LicenseV2_Services.Layouts.FCRA.proflicWorkRec,
				SELF.acctno:=LEFT.acctno,
				SELF.did:=LEFT.did,
				// STANDARDIZE DATES FOR SORTING
				SELF.date_first_seen:=MAP(
					(UNSIGNED)RIGHT.date_first_seen=0 => '',
					LENGTH(TRIM(RIGHT.date_first_seen))=6 => TRIM(RIGHT.date_first_seen)+'00',
					RIGHT.date_first_seen),
				SELF.date_last_seen:=MAP(
					(UNSIGNED)RIGHT.date_last_seen=0 => '',
					LENGTH(TRIM(RIGHT.date_last_seen))=6 => TRIM(RIGHT.date_last_seen)+'00',
					RIGHT.date_last_seen),
				// MASKING
				DOB:=(UNSIGNED4)RIGHT.DOB;
				MASKED_DOB:=Suppress.date_mask(DOB,in_mod.dob_mask);
				SELF.DOB:=IF(DOB!=0,MASKED_DOB.Year+MASKED_DOB.Month+MASKED_DOB.day,''),
				SELF.inquiry_lexid:=IF(RIGHT.did!='',RIGHT.did,'');
				SELF:=RIGHT,SELF:=[]),
			LIMIT(0),KEEP(prof_LicenseV2_Services.Constants.FCRA.MaxProfLicPerDID));

		// max results and sequence
		prof_LicenseV2_Services.Layouts.FCRA.proflicWorkRec seqRecs(prof_LicenseV2_Services.Layouts.FCRA.proflicWorkRec L,INTEGER seq) := TRANSFORM
			SELF.SequenceNumber:=seq;
			SELF:=L;
		END;
		ds_proflic_srtd:=TOPN(GROUP(SORT(ds_proflic_disclose,acctno),acctno),in_mod.MaxResultsPerAcct,(UNSIGNED)acctno,-date_first_seen,-date_last_seen);
		ds_proflic_seqd:=PROJECT(UNGROUP(ds_proflic_srtd),seqRecs(LEFT,COUNTER));

		// pickup record level statements and disputes
		prof_LicenseV2_Services.Layouts.FCRA.proflicWorkRec addStatements(
			prof_LicenseV2_Services.Layouts.FCRA.proflicWorkRec L,FFD.Layouts.PersonContextBatchSlim R) := TRANSFORM,
			SKIP(~FFD.FFDMask.isShowDisputed(in_mod.FFDOptionsMask) AND R.isDisputed)
			SELF.StatementIds:=R.StatementIDs;
			SELF.IsDisputed:=R.isDisputed;
			SELF:=L;
		END;

		ds_proflic_statements:=JOIN(ds_proflic_seqd,FFD.SlimPersonContext(ds_PersonContext),
			LEFT.acctno=RIGHT.acctno AND
			LEFT.did=(UNSIGNED)RIGHT.lexid AND
			LEFT.prolic_key=RIGHT.RecId1,
			addStatements(LEFT,RIGHT),
			LEFT OUTER,KEEP(1),LIMIT(0));

		// initialize statement dispute
		prof_LicenseV2_Services.Layouts.FCRA.proflicWorkRec initializeStatements(prof_LicenseV2_Services.Layouts.FCRA.proflicWorkRec L) := TRANSFORM
			statements:=PROJECT(L.StatementIds,
				FFD.InitializeConsumerStatementBatch(LEFT,FFD.Constants.RecordType.RS,
				'main',FFD.Constants.DataGroups.PROFLIC,L.SequenceNumber,L.acctno,L.did));
			dispute:=IF(L.isDisputed,DATASET(ROW(FFD.InitializeConsumerStatementBatch(
				FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR,
				'main',FFD.Constants.DataGroups.PROFLIC,L.SequenceNumber,L.acctno,L.did))));
			SELF.StatementsAndDisputes:=statements+dispute;
			SELF:=L;
		END;

		ds_proflic_dispute:=PROJECT(ds_proflic_statements,initializeStatements(LEFT));
		ds_proflic_suppress:=FFD.MAC.ApplyConsumerAlertsBatch(ds_proflic_dispute,ds_AlertFlags,StatementIds,prof_LicenseV2_Services.Layouts.FCRA.proflicWorkRec,in_mod.FFDOptionsMask);
		ds_proflic_inquiry:=FFD.Mac.InquiryLexidBatch(ds_work_recs,ds_proflic_suppress,prof_LicenseV2_Services.Layouts.FCRA.proflicWorkRec,0);

		// OUTPUT(ds_AlertFlags,NAMED('ds_AlertFlags'));
		// OUTPUT(FFD.SlimPersonContext(ds_PersonContext),NAMED('ds_SlimPersonContext'));
		// OUTPUT(in_mod.DOBMask,NAMED('DOBMask'));
		// OUTPUT(in_mod.dob_mask,NAMED('dob_mask'));
		// OUTPUT(ds_dids,NAMED('ds_dids'));
		// OUTPUT(ds_FlagFile),NAMED('ds_FlagFile'));
		// OUTPUT(SORT(ds_override_recs,did,-date_first_seen,-date_last_seen),NAMED('ds_override_recs'));
		// OUTPUT(SORT(ds_proflic_recs,did,-date_first_seen,-date_last_seen),NAMED('ds_proflic_recs'));
		// OUTPUT(SORT(ds_proflic_raw,did,-date_first_seen,-date_last_seen),NAMED('ds_proflic_raw'));
		// OUTPUT(SORT(ds_proflic_disclose,(UNSIGNED)acctno,-date_first_seen,-date_last_seen),NAMED('ds_proflic_disclose'));
		// OUTPUT(SORT(ds_proflic_dispute,(UNSIGNED)acctno,-date_first_seen,-date_last_seen),NAMED('ds_proflic_dispute'));
		// OUTPUT(SORT(ds_proflic_suppress,(UNSIGNED)acctno,-date_first_seen,-date_last_seen),NAMED('ds_proflic_suppress'));

		RETURN SORT(ds_proflic_inquiry,(UNSIGNED)acctno,SequenceNumber);
	END;

END;
