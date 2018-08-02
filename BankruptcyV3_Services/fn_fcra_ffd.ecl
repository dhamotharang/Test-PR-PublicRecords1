/* This function gets Full File Disclosure records for BK FCRA search and report services. */

import bankruptcyv3, FFD, BankruptcyV3_Services;

export fn_fcra_ffd(dataset(BankruptcyV3_Services.layouts.layout_rollup) ds_recs, 
									 dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			             integer8 inFFDOptionsMask) := function
									 
  boolean showDisputedRecords := FFD.FFDMask.isShowDisputedBankruptcies(inFFDOptionsMask);
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

	rec_w_tms := record
	 string50   	TMSID ;
	 BankruptcyV3_Services.layouts.layout_party;
	end;
	
	debtors_norm	:= 	normalize(ds_recs, left.debtors, transform(rec_w_tms, self.tmsid := left.tmsid, self := right));
	
	// ffd for debtor records for matched party did
  rec_w_tms xformStatements( rec_w_tms l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
   			skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
   					self.StatementIds := r.StatementIDs;
   					self.IsDisputed   := r.isDisputed;
   					self := l;
  end;

  recs_fcra_debtors := join(debtors_norm, slim_pc_recs,
   														left.tmsid = right.RecID1 and
															BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR = right.RecID2 and  // FFD compliance for debtors
   														(unsigned6)left.did  =  (unsigned6) right.RecId3 and 
   														(right.acctno = FFD.Constants.SingleSearchAcctno) and 
   												    right.DataGroup = FFD.Constants.DataGroups.BANKRUPTCY_SEARCH,
   														xformStatements(left,right), 
   														left outer,
   														keep(1),
   														limit(0));
																 
	BankruptcyV3_Services.layouts.layout_rollup denorm_deb(BankruptcyV3_Services.layouts.layout_rollup l, 
	                                                            dataset(rec_w_tms) r) := transform
																														
	   self.debtors := project(r, BankruptcyV3_Services.layouts.layout_party);
	   self := l;
	end;

	denorm_ds := denormalize(ds_recs, recs_fcra_debtors,
		                     left.tmsid = right.tmsid,
				                 group,
										     denorm_deb(left,rows(right)));
	
	layout_w_did := record
	
	BankruptcyV3_Services.layouts.layout_rollup;
	unsigned6 matched_did;
	
	end;
	
	main_w_did := project(denorm_ds, 
	                  transform(layout_w_did, 
										self.matched_did := (unsigned6)left.matched_party.did, 
										self := left));
	
	// ffd for main records for matched party did
	BankruptcyV3_Services.layouts.layout_rollup xmainStatements( layout_w_did l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
					self.StatementIds := r.StatementIDs;
					self.IsDisputed   := r.isDisputed;
					self := l;
			end;
			
	recs_fcra_ds := join(main_w_did, slim_pc_recs,
											left.tmsid = right.RecID1 and
											left.matched_did  =  (unsigned6) right.lexid and 
											(right.acctno = FFD.Constants.SingleSearchAcctno) and 
											right.DataGroup = FFD.Constants.DataGroups.BANKRUPTCY_MAIN,
											xmainStatements(left,right), 
											left outer,
											keep(1),
											limit(0));
											
	return recs_fcra_ds;
	
end;