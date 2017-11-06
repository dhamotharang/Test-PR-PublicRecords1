IMPORT Autokey_batch, AutoStandardI, BatchServices, Codes, Suppress, MDR, Royalty, ut, D2C;

EXPORT Email_BatchService_Records(BatchServices.Email_BatchService_Interfaces.BatchParams email_batch_params,
																	DATASET(BatchServices.Layouts.Email.rec_batch_email_input) batch_in,
																	BOOLEAN useCannedRecs = FALSE) := MODULE

		Boolean use_dm_email_sources_only := email_batch_params.useDMEmailSourcesOnly;
				
		sample_email_set := BatchServices._Sample_inBatchMaster('EMAIL');
		test_email_recs := PROJECT(sample_email_set, TRANSFORM(BatchServices.Layouts.email.rec_batch_email_input,
																														SELF.acctno := LEFT.acctno,
																														SELF.name_first := LEFT.name_first,
																														SELF.name_last  := LEFT.name_last,
																														SELF.email_addrFull := LEFT.sic_code,
																														SELF := LEFT));
		ds_batch_in_email := IF (NOT useCannedRecs, batch_in ,test_email_recs);
		
    // move raw input into layout to pass to autokeys.
		ds_batch_in := PROJECT(ds_batch_in_email, Autokey_batch.Layouts.rec_inBatchMaster);

		// Search via AutoKey
		fromAK :=  BatchServices.Email_BatchIds.AutoKeyIds(ds_batch_in);
		
		// Search via DID and DID Lookup (deepdive)
		fromDID := BatchServices.Email_BatchIds.byDIDIds(ds_batch_in);
		
		// Search via Input Email
		fromInputEmail := BatchServices.Email_BatchIds.byInputEmail(ds_batch_in_email);

		ds_raw := fromAK + fromDID + fromInputEmail;
		ds_raw_slim := dedup(sort(ds_raw(orig_email <> ''), acctno, orig_email), acctno, orig_email);
		
    boolean D2c_Restrict := email_batch_params.industryclass = ut.IndustryClass.Knowx_IC;  // D2C - filter for consumer
		D2c_Restrict_Src := if(D2c_Restrict, ds_raw_slim(email_src not in D2C.Constants.EmailRestrictedSources), ds_raw_slim);
		
		appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		Suppress.MAC_Suppress(D2c_Restrict_Src,ds_raw_pulled_did,appType,Suppress.Constants.LinkTypes.DID,did);
		Suppress.MAC_Suppress(ds_raw_pulled_did,ds_raw_pulled_ssn,appType,Suppress.Constants.LinkTypes.SSN,best_ssn);
		
		ds_results_grouped := group(sort(ds_raw_pulled_ssn, acctno, -orig_login_date, -process_date, record) , acctno);	

		
		// Royalty Code
		royal_codes := codes.Key_Codes_V3(KEYED(file_name = 'EMAIL_SOURCES'), KEYED(field_name='ROYALTY'));
		_royal_recs := join(ds_results_grouped, royal_codes, left.email_src = right.code, grouped);
		_royal_recs_top    := topn(sort(_royal_recs, field_name2), 1, acctno);
		royal_recs         := ungroup(_royal_recs_top);


		// take the _royal_recs (all Records) and join to the royal_recs(data filtered on first royalty source
		// and that will all us to filter the full set so that we only all records from the same source not just the top 1.
		royal_recs_all := join(_royal_recs,royal_recs,left.acctno = right.acctno and left.email_src = right.email_src);
		nonroyal_recs := join(ds_raw_pulled_ssn, royal_codes, left.email_src = right.code, left only);
		
		_recs := project(royal_recs_all + nonroyal_recs, BatchServices.Layouts.email.rec_results_raw);

		dm_email_recs := _recs(email_src in MDR.sourceTools.set_digital_email_cookie_matching);
		recs_to_use := if(use_dm_email_sources_only, dm_email_recs , _recs);

		EXPORT recs := group(sort(recs_to_use, acctno, -orig_login_date, -process_date, record), acctno);
		
		Boolean detailedRoyalties := email_batch_params.ReturnDetailedRoyalties;
		unsigned8 MAX_EMAIL_PER_ACCTNO := email_batch_params.MAX_EMAIL_PER_ACCTNO;		
		
		EXPORT dRoyalties := Royalty.RoyaltyEmail.GetBatchRoyaltySet(recs, email_src, MAX_EMAIL_PER_ACCTNO, detailedRoyalties);
END;