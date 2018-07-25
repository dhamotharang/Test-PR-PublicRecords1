/* This function does the disputes and adds the ststementIDs dataset */
import FFD, LiensV2_Services;

EXPORT  fn_doFcraCompliance ( GROUPED DATASET (LiensV2_Services.layout_lien_party_raw) ds_party_raw_grouped, //join with key_party_id
															 DATASET (LiensV2_Services.layout_liens_case_extended) ds_case_raw,
															 DATASET (LiensV2_Services.layout_liens_history_extended) ds_history_raw, 
   														 DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
   														 integer8 inFFDOptionsMask = 0 )  := function

  boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
												 
	//---------------------------------------------------------------------------------------------------												 
	// party 
	ds_party_raw := ungroup(ds_party_raw_grouped);
	// Remove or mark Disputed party & add StatementIDs
	
	liensv2_services.layout_lien_party_raw xformLienParty
													(LiensV2_Services.layout_lien_party_raw L , FFD.Layouts.PersonContextBatchSlim R ) := transform,
				skip((~ShowDisputedRecords and R.isDisputed) or (~ShowConsumerStatements and exists(R.StatementIDs)))
				self.StatementIDs := R.StatementIds;
				self.IsDisputed   := R.isDisputed;
				self := L;
	end;
	
	ds_party_raw_ffd := join(ds_party_raw,ds_slim_pc,
												((left.acctno = right.acctno) OR (right.acctno = FFD.Constants.SingleSearchAcctno)) and // if the person context's acctno is 	FFD.Constants.SingleSearchAcctno,it's a nonbatch.
												(string) left.persistent_record_id = right.RecID1 and
												right.DataGroup = FFD.Constants.DataGroups.LIEN_PARTY,
												xformLienParty(left, right), left outer, limit(0), 
												KEEP(1));

//---------------------------------------------------------------------------------------------------			
	// case
	LiensV2_Services.layout_liens_case_extended xformLiencase
													(LiensV2_Services.layout_liens_case_extended L, FFD.Layouts.PersonContextBatchSlim R ) := transform,
			skip((~ShowDisputedRecords and R.isDisputed) or (~ShowConsumerStatements and exists(R.StatementIDs)))
				self.StatementIDs :=  R.StatementIds;
				self.IsDisputed   := R.isDisputed;
				self := L;
	end;
	
	ds_case_raw_ffd := join(ds_case_raw,ds_slim_pc,
												 ((left.acctno = right.acctno) OR (right.acctno = FFD.Constants.SingleSearchAcctno)) and // if the person context's acctno is 	FFD.Constants.SingleSearchAcctno,it's a nonbatch.
												(string) left.persistent_record_id = right.RecID1 and
												right.DataGroup = FFD.Constants.DataGroups.LIEN_MAIN,
												xformLienCase(left, right), left outer, limit(0), 
												KEEP(1));
				
				
//---------------------------------------------------------------------------------------------------    
	// history

	// mark the original records so we can correctly unflatten them later
	layout_marked := record
		recordof(ds_history_raw);
		unsigned _mark_id;
	end;

	ds_history_marked := project(ds_history_raw, transform(layout_marked, 
		self._mark_id := counter, 
		self := left));

	// flatten it out ... 
	flat_history_rec :=  record(LiensV2_Services.layout_lien_history_w_bcb)
	 LiensV2_Services.layout_liens_history_extended.acctno;
	 unsigned _mark_id;
	end;

	ds_history_raw_flat := normalize(ds_history_marked, left.filings,
																		transform(flat_history_rec,
																							self.acctno := left.acctno, 
																							self._mark_id := left._mark_id, 
																							self := right));				 
				 
	flat_history_rec xformLienHistory(flat_history_rec L, FFD.Layouts.PersonContextBatchSlim R) := transform,
	skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(R.StatementIDs)))
		self.StatementIDs := R.StatementIds;
		self.IsDisputed   := R.isDisputed;
		self              := L;
	end;
		
	ds_history_raw_ffd_flat := join(ds_history_raw_flat, ds_slim_pc,
																	((left.acctno = right.acctno) OR (right.acctno = FFD.Constants.SingleSearchAcctno)) and // if the person context's acctno is 	FFD.Constants.SingleSearchAcctno,it's a nonbatch.
																	(string) left.persistent_record_id = right.RecID1 and
																	right.DataGroup = FFD.Constants.DataGroups.LIEN_MAIN,
																	xformLienHistory(left, right), left outer, limit(0), 
																	KEEP(1));
													 
	// unflatten the recs back to how they were before
	layout_marked deNormHistory (ds_history_marked l, ds_history_raw_ffd_flat r )  := transform
		filings := dataset([{ r.filing_number, r.filing_type_desc, r.orig_filing_date, r.filing_date, r.filing_time, 
													r.filing_book, r.filing_page, r.agency,r.agency_state, r.agency_city, r.agency_county,			
													r.persistent_record_id, r.StatementIds, r.isDisputed, r.bcbflag, r.case_link_priority
											}], LiensV2_Services.layout_lien_history_w_bcb);
		self.filings := l.filings + filings;
		self := l;
	end;
			
	// clear out original filings and replace with new, marked up versions
	ds_history_temp := project(ds_history_marked, transform(layout_marked, 
		self.filings := dataset([], LiensV2_Services.layout_lien_history_w_bcb), 
		self := left));
	ds_history_denorm := denormalize(ds_history_temp, ds_history_raw_ffd_flat, left._mark_id = right._mark_id, 
		deNormHistory(left,right) );   
	ds_history_raw_ffd := project(ds_history_denorm, LiensV2_Services.layout_liens_history_extended); 
	
	tempRec := record 
	dataset(liensv2_services.layout_lien_party_raw) _party;	
	dataset(LiensV2_Services.layout_liens_case_extended) _case;	
	dataset(LiensV2_Services.layout_liens_history_extended) _history;	
	end;

	// output(ds_slim_pc,named('ds_slim_pc'),EXTEND);	
	// output(ds_party_raw_ffd,named('ds_party_raw_ffd'),EXTEND);
	// output(ds_case_raw_ffd,named('ds_case_raw_ffd'),EXTEND);
	// output(ds_history_raw_flat,named('ds_history_raw_flat'));
	// output(ds_history_raw_ffd_flat,named('ds_history_raw_ffd_flat'));

	//output(ds_history_raw,named('ds_history_raw'),EXTEND);
	//output(ds_history_raw_ffd,named('ds_history_raw_ffd'),EXTEND);
	//output(ShowDisputedRecords);
	
	return dataset([{ds_party_raw_ffd,ds_case_raw_ffd,ds_history_raw_ffd}],tempRec);
end;
