IMPORT AccountMonitoring, BIPV2;

EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_sbfe(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.sbfe.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.sbfe.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION

		// For those Portfolio entities having a valid bipids, we'll join those records using a
		// linkid pivot only 
		portfolio_dist_sele := DISTRIBUTE(in_portfolio(seleid != 0),HASH64(seleid)) : INDEPENDENT;
		
		// Business_Credit.Key_LinkIds.key
		Key_Linkids := 
			DISTRIBUTED(
				AccountMonitoring.product_files.sbfe.r_sbfeLinkid_key, 
				HASH64(seleid)
			);
		
		// Tradeline key Business_Credit.key_tradeline
		Key_Tradeline := 
			DISTRIBUTED(
				AccountMonitoring.product_files.sbfe.r_sbfeTrade_key, 
				HASH64(sbfe_contributor_number,contract_account_number)
			);
		
		// Credit Score Key Business_Credit_Scoring.Key_ScoringIndex.Key
		Key_Score := 
			DISTRIBUTED(
				AccountMonitoring.product_files.sbfe.r_sbfeScore_key, 
				HASH64(seleid)
			);
		
		
		// Temporary Join Layout
		temp_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			TYPEOF(in_portfolio.did) did;
			TYPEOF(in_portfolio.bdid) bdid;
			in_documents.ultid;
			in_documents.orgid;
			in_documents.seleid;
			Key_Linkids.Sbfe_Contributor_Number;
			Key_Linkids.Contract_Account_Number;
		END;
	
	
		// Pivot on bip ids (ult/org/sele) for the sbfe linkid key. 
		temp_join_linkid_rcid := JOIN(Key_Linkids,portfolio_dist_sele,
																BIPV2.IDmacros.mac_JoinTop3Linkids(),
																TRANSFORM(temp_layout,
																	SELF.pid  := RIGHT.pid,
																	SELF.rid  := RIGHT.rid,
																	SELF.hid  := 0,
																	SELF.bdid := 0, 
																	SELF.did	:= 0, 
																	SELF.Sbfe_Contributor_Number := LEFT.Sbfe_Contributor_Number;
																	SELF.Contract_Account_Number := LEFT.Contract_Account_Number;
																	SELF      := RIGHT),
																LOCAL);		
	
		// Data layout
		temp_data_layout := RECORD
			temp_layout;
			Key_Tradeline.Account_Closure_Basis;
			Key_Tradeline.Past_Due_Aging_Amount_Bucket_1;
			Key_Tradeline.Past_Due_Aging_Amount_Bucket_2;
			Key_Tradeline.Past_Due_Aging_Amount_Bucket_3;
			Key_Tradeline.Past_Due_Aging_Amount_Bucket_4;
			Key_Tradeline.Past_Due_Aging_Amount_Bucket_5;
			Key_Tradeline.Past_Due_Aging_Amount_Bucket_6;
			Key_Tradeline.Past_Due_Aging_Amount_Bucket_7;
			Key_Tradeline.Amount_Charged_Off_By_Creditor;
			Key_Tradeline.Date_Account_Closed;
			Key_Tradeline.Date_Account_Opened;
			Key_Tradeline.Remaining_Balance;
			Key_Tradeline.Current_Credit_Limit;
			Key_Tradeline.cycle_end_date;
			Key_Tradeline.Account_Status_1;
			Key_Tradeline.Account_Status_2;
			Key_Score.date_scored;
			INTEGER credit_score;
		END;	
		
		// Get Account info
		temp_join_acctinfo := DISTRIBUTE(temp_join_linkid_rcid,HASH64(Sbfe_Contributor_Number,Contract_Account_Number));
		
		temp_data_acctinfo := JOIN(Key_Tradeline,temp_join_acctinfo,
																LEFT.Sbfe_Contributor_Number = RIGHT.Sbfe_Contributor_Number AND
																LEFT.Contract_Account_Number = RIGHT.Contract_Account_Number,
																TRANSFORM(temp_data_layout,
																						SELF.credit_score := 0,
																						SELF.date_scored := '',
																						SELF := LEFT,
																						SELF := RIGHT),LOCAL);
		// Keep only latest account record																				
		temp_data_acctinfo_dedup := DEDUP(
																	SORT(temp_data_acctinfo,
																				pid,rid,hid,ultid,orgid,seleid,Sbfe_Contributor_Number,Contract_Account_Number,-cycle_end_date,LOCAL
																			 ),
																	pid,rid,hid,ultid,orgid,seleid,Sbfe_Contributor_Number,Contract_Account_Number,LOCAL);
		
		// Get Score info
		temp_data_scoreinfo := JOIN(Key_Score,temp_join_linkid_rcid,
																BIPV2.IDmacros.mac_JoinTop3Linkids(),
																TRANSFORM(temp_data_layout,
																						SELF.credit_score := LEFT.scores[1].score,
																						SELF.date_scored := LEFT.date_scored,
																						SELF := RIGHT,
																						SELF := []),
																						LOCAL);
																						

		// Now create a hash value from only the fields we're interested in 
		// (these are the non *id fields in the temp_layout).
		temp_unrolled_hashes := 
			PROJECT(temp_data_scoreinfo+temp_data_acctinfo_dedup,
							TRANSFORM(AccountMonitoring.layouts.history,
								SELF.pid          := LEFT.pid,
								SELF.rid          := LEFT.rid,
								SELF.hid          := LEFT.hid,
								SELF.product_mask := AccountMonitoring.Constants.pm_sbfe,
								SELF.timestamp    := '',
								SELF.hash_value   := HASH64(
											LEFT.ultid,
											LEFT.orgid,
											LEFT.seleid,
											LEFT.Account_Closure_Basis,
											LEFT.Past_Due_Aging_Amount_Bucket_1,
											LEFT.Past_Due_Aging_Amount_Bucket_2,
											LEFT.Past_Due_Aging_Amount_Bucket_3,
											LEFT.Past_Due_Aging_Amount_Bucket_4,
											LEFT.Past_Due_Aging_Amount_Bucket_5,
											LEFT.Past_Due_Aging_Amount_Bucket_6,
											LEFT.Past_Due_Aging_Amount_Bucket_7,
											LEFT.Amount_Charged_Off_By_Creditor,
											LEFT.Date_Account_Closed,
											LEFT.Date_Account_Opened,
											LEFT.Remaining_Balance,
											LEFT.Current_Credit_Limit,
											LEFT.credit_score,
											LEFT.Account_Status_1,
											LEFT.Account_Status_2),
							SELF := LEFT)); 
		
		// Roll up the hashes for all records for a particular pid/rid; and return.
		temp_rolled_hashes := ROLLUP(SORT(DISTRIBUTE(temp_unrolled_hashes,HASH64(pid,rid,hid)),pid,rid,hid,RECORD,LOCAL),
			TRANSFORM(AccountMonitoring.layouts.history,
				SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
				SELF := LEFT),
			pid,rid,LOCAL);
	
		RETURN temp_rolled_hashes;

END;		