IMPORT doxie, FFD, FCRA, Email_Data, EmailService, Royalty, Suppress;

EXPORT Records := MODULE

	EXPORT GetFCRA(DATASET(EmailService.Layouts.FCRA.workRec) ds_work_recs,
		DATASET(FFD.Layouts.PersonContextBatch) ds_PersonContext,
		DATASET(FFD.layouts.ConsumerFlagsBatch) ds_AlertFlags,
		EmailService.IParams.BatchParams in_mod) := FUNCTION

		ds_dids:=DEDUP(SORT(PROJECT(ds_work_recs,TRANSFORM(doxie.layout_references,SELF:=LEFT)),did),did);
		ds_FlagFile:=FFD.GetFlagFile(PROJECT(ds_dids,doxie.layout_best),ds_PersonContext);

		// get any override records
		ds_override_recs:=JOIN(ds_FlagFile,FCRA.key_override_email_data_ffid,
			KEYED(LEFT.flag_file_id=RIGHT.flag_file_id),
			TRANSFORM(Email_Data.Layout_Email.Base,SELF:=RIGHT,SELF:=[]),
			KEEP(FCRA.compliance.MAX_OVERRIDE_LIMIT),LIMIT(0));

		// get email records
		ds_email_recs:=JOIN(ds_dids,Email_Data.Key_Did_FCRA,
			KEYED(LEFT.did=RIGHT.did) AND RIGHT.email_rec_key!=0,
			TRANSFORM(Email_Data.Layout_Email.Base,SELF:=RIGHT),
			KEEP(EmailService.Constants.FCRA.MaxEmailPerDID),
			LIMIT(EmailService.Constants.FCRA.MaxEmailRecords,SKIP));

		// less overwritten records
		ds_email_less_overwritten:=JOIN(ds_email_recs,ds_FlagFile,
			LEFT.did=(UNSIGNED)RIGHT.did
			AND (STRING)LEFT.email_rec_key=TRIM(RIGHT.record_id),
			TRANSFORM(Email_Data.Layout_Email.Base,SELF:=LEFT),LEFT ONLY);

		// dedup results by email address push non-Royalty sources to the bottom
		ds_email_raw:=DEDUP(SORT(ds_email_less_overwritten+ds_override_recs,did,clean_email,
			IF(email_src IN Royalty.Constants.EMAIL_ROYALTY_SET(TRUE),0,1),
			-date_last_seen,-date_first_seen),did,clean_email);

		// apply suppressions
		Suppress.MAC_Suppress(ds_email_raw,ds_dids_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.DID,did, isFCRA := true);
		Suppress.MAC_Suppress(ds_dids_pulled,ds_dids_ssns_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,best_ssn, isFCRA := true);

		// filter raw to disclose only fields restore acctno
		ds_email_disclose:=JOIN(ds_work_recs,ds_dids_ssns_pulled,
			LEFT.did=RIGHT.did,
			TRANSFORM(EmailService.Layouts.FCRA.emailWorkRec,
				SELF.acctno:=LEFT.acctno,
				SELF.did:=LEFT.did,
				SELF.title:=RIGHT.clean_name.title,
				SELF.fname:=RIGHT.clean_name.fname,
				SELF.mname:=RIGHT.clean_name.mname,
				SELF.lname:=RIGHT.clean_name.lname,
				SELF.name_suffix:=RIGHT.clean_name.name_suffix,
				SELF.prim_range:=RIGHT.clean_address.prim_range,
				SELF.predir:=RIGHT.clean_address.predir,
				SELF.prim_name:=RIGHT.clean_address.prim_name,
				SELF.addr_suffix:=RIGHT.clean_address.addr_suffix,
				SELF.postdir:=RIGHT.clean_address.postdir,
				SELF.unit_desig:=RIGHT.clean_address.unit_desig,
				SELF.sec_range:=RIGHT.clean_address.sec_range,
				SELF.p_city_name:=RIGHT.clean_address.p_city_name,
				SELF.st:=RIGHT.clean_address.st,
				SELF.zip:=RIGHT.clean_address.zip,
				SELF.zip4:=RIGHT.clean_address.zip4,
				SELF.county:=RIGHT.clean_address.county,
				SELF.inquiry_lexid:=IF(RIGHT.did>0,(STRING)RIGHT.did,'');
				SELF:=RIGHT,SELF:=[]),
			LIMIT(0),KEEP(EmailService.Constants.FCRA.MaxEmailPerDID));

		// max results and sequence
		EmailService.Layouts.FCRA.emailWorkRec seqRecs(EmailService.Layouts.FCRA.emailWorkRec L,INTEGER seq) := TRANSFORM
			SELF.SequenceNumber:=seq;
			SELF:=L;
		END;
		ds_email_srtd:=TOPN(GROUP(SORT(ds_email_disclose,acctno),acctno),in_mod.MaxResultsPerAcct,(UNSIGNED)acctno,-date_first_seen,-date_last_seen);
		ds_email_seqd:=PROJECT(UNGROUP(ds_email_srtd),seqRecs(LEFT,COUNTER));

		// pickup record level statements and disputes
		EmailService.Layouts.FCRA.emailWorkRec addStatements(
			EmailService.Layouts.FCRA.emailWorkRec L,FFD.Layouts.PersonContextBatchSlim R) := TRANSFORM,
			SKIP(~FFD.FFDMask.isShowDisputed(in_mod.FFDOptionsMask) AND R.isDisputed)
			SELF.StatementIds:=R.StatementIDs;
			SELF.IsDisputed:=R.isDisputed;
			SELF:=L;
		END;

		ds_email_statements:=JOIN(ds_email_seqd,FFD.SlimPersonContext(ds_PersonContext),
			LEFT.acctno=RIGHT.acctno AND
			LEFT.did=(UNSIGNED)RIGHT.lexid AND
			(STRING)LEFT.email_rec_key=RIGHT.RecId1,
			addStatements(LEFT,RIGHT),
			LEFT OUTER,KEEP(1),LIMIT(0));

		// initialize statement dispute
		EmailService.Layouts.FCRA.emailWorkRec initializeStatements(EmailService.Layouts.FCRA.emailWorkRec L) := TRANSFORM
			statements:=PROJECT(L.StatementIds,
				FFD.InitializeConsumerStatementBatch(LEFT,FFD.Constants.RecordType.RS,
				'main',FFD.Constants.DataGroups.EMAIL_DATA,L.SequenceNumber,L.acctno,L.did));
			dispute:=IF(L.isDisputed,DATASET(ROW(FFD.InitializeConsumerStatementBatch(
				FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR,
				'main',FFD.Constants.DataGroups.EMAIL_DATA,L.SequenceNumber,L.acctno,L.did))));
			SELF.StatementsAndDisputes:=statements+dispute;
			SELF:=L;
		END;

		ds_email_dispute:=PROJECT(ds_email_statements,initializeStatements(LEFT));
		ds_email_suppress:=FFD.MAC.ApplyConsumerAlertsBatch(ds_email_dispute,ds_AlertFlags,StatementIds,EmailService.Layouts.FCRA.emailWorkRec,in_mod.FFDOptionsMask);
		ds_email_inquiry:=FFD.Mac.InquiryLexidBatch(ds_work_recs,ds_email_suppress,EmailService.Layouts.FCRA.emailWorkRec,0);

		// OUTPUT(ds_AlertFlags,NAMED('ds_AlertFlags'));
		// OUTPUT(FFD.SlimPersonContext(ds_PersonContext),NAMED('ds_SlimPersonContext'));
		// OUTPUT(ds_dids,NAMED('ds_dids'));
		// OUTPUT(ds_FlagFile,NAMED('ds_FlagFile'));
		// OUTPUT(SORT(ds_override_recs,did,-date_first_seen,-date_last_seen),NAMED('ds_override_recs'));
		// OUTPUT(SORT(ds_email_recs,did,-date_first_seen,-date_last_seen),NAMED('ds_email_recs'));
		// OUTPUT(SORT(ds_email_less_overwritten,did,-date_first_seen,-date_last_seen),NAMED('ds_email_less_overwritten'));
		// OUTPUT(SORT(ds_email_raw,did,-date_first_seen,-date_last_seen),NAMED('ds_email_raw'));
		// OUTPUT(SORT(ds_email_disclose,(UNSIGNED)acctno,-date_first_seen,-date_last_seen),NAMED('ds_email_disclose'));
		// OUTPUT(SORT(ds_email_dispute,(UNSIGNED)acctno,-date_first_seen,-date_last_seen),NAMED('ds_email_dispute'));
		// OUTPUT(SORT(ds_email_suppress,(UNSIGNED)acctno,-date_first_seen,-date_last_seen),NAMED('ds_email_suppress'));

		RETURN SORT(ds_email_inquiry,(UNSIGNED)acctno,SequenceNumber);
	END;

END;
