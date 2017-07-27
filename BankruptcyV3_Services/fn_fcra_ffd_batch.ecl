/* This function gets Full File Disclosure records for BK FCRA batch services. */

import BatchServices, FFD, gateway; 

export fn_fcra_ffd_batch(dataset(BatchServices.layout_BankruptcyV3_Batch_out) ds_batch, integer8 inFFDOptionsMask = 0) := function
		
    gateways := Gateway.Configuration.Get();  	
    boolean showDisputedRecords := FFD.FFDMask.isShowDisputedBankruptcies(inFFDOptionsMask);
	  boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

    layout_w_ffd := record		
		  BatchServices.layout_BankruptcyV3_Batch_out; 
		  // FCRA FFD - differentiated fields for batch flattened layout
		  DATASET(FFD.Layouts.StatementIdRec) StatementIds_deb := DATASET([],FFD.Layouts.StatementIdRec);
			boolean isDisputed_deb := FALSE;
			FFD.Layouts.CommonRawRecordElements;
		end;
		
		dids := project(dedup(sort(ds_batch, debtor_did, acctno), debtor_did, acctno),
		                transform(FFD.Layouts.DidBatch, 
											self.did := (unsigned6) left.debtor_did, 
											self.acctno := left.acctno));
										
		// call person context		
	  pc_recs := FFD.FetchPersonContext(dids, gateways, FFD.Constants.DataGroupSet.Bankruptcy);  
	  slim_pc_recs := FFD.SlimPersonContext(pc_recs);
		
		// ffd for debtor records
		layout_w_ffd xformStatements( BatchServices.layout_BankruptcyV3_Batch_out l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
   		skip(~ShowDisputedRecords and r.isDisputed)   						
   		self.StatementIds_deb := IF(ShowConsumerStatements, r.StatementIDs, FFD.Constants.BlankStatements);
   		self.isDisputed_deb   := r.isDisputed;
   		self := l;
    end;
		
		recs_deb := join(ds_batch, slim_pc_recs,
		                 left.tmsid = right.RecID1 and
										 BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR = right.RecID2 and 
   									 ((unsigned6) left.debtor_did = (unsigned6) right.RecId3) and 
   									 (left.acctno = right.acctno) and 
   										right.DataGroup = FFD.Constants.DataGroups.BANKRUPTCY_SEARCH,
   										xformStatements(left,right), 
   										left outer,
   										keep(1),
   										limit(0));
											
		// ffd for main records
	  layout_w_ffd xmainStatements( layout_w_ffd l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
		  skip(~ShowDisputedRecords and r.isDisputed)						
					self.StatementIds := IF(ShowConsumerStatements,r.StatementIDs, FFD.Constants.BlankStatements);
					self.IsDisputed   := r.isDisputed;
					self := l;
	  end;
			
	  recs_main := join(recs_deb, slim_pc_recs,
											left.tmsid = right.RecID1 and
											((unsigned6)left.debtor_did  =  (unsigned6) right.lexid) and 
											(left.acctno  =  right.acctno) and 
											right.DataGroup = FFD.Constants.DataGroups.BANKRUPTCY_MAIN,
											xmainStatements(left,right), 
											left outer,
											keep(1),
											limit(0));
											
		BatchServices.layout_BankruptcyV3_Batch_FCRA.out_pre formstatements(layout_w_ffd L) := transform
        debtor_statements := PROJECT(L.StatementIds_deb, 
					FFD.InitializeConsumerStatementBatch(LEFT, FFD.Constants.RecordType.RS, 'debtor', FFD.Constants.DataGroups.BANKRUPTCY_SEARCH, 0, L.acctno));
        debtor_dispute  := IF(L.isDisputed_deb, 
         	DATASET(ROW(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid, FFD.Constants.RecordType.DR, 'debtor', FFD.Constants.DataGroups.BANKRUPTCY_SEARCH, 0, L.acctno))));
        main_statements := PROJECT(L.StatementIds, 
      		FFD.InitializeConsumerStatementBatch(LEFT, FFD.Constants.RecordType.RS, 'main', FFD.Constants.DataGroups.BANKRUPTCY_MAIN, 0, L.acctno));
        main_dispute    := IF(L.isDisputed, 
          DATASET(ROW(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid, FFD.Constants.RecordType.DR, 'main', FFD.Constants.DataGroups.BANKRUPTCY_MAIN, 0, L.acctno))));
        SELF.statements := debtor_statements + debtor_dispute + main_statements + main_dispute;
				SELF := L;		
		end;
		
		ds_out := project(recs_main, formstatements(left));
		
		// Sequencing for FCRA FFD
 		ds_out_seq := PROJECT(ds_out, TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_FCRA.out_pre, SELF.SequenceNumber := COUNTER, SELF := LEFT));
   	 
   	// get statements 
   	consumer_statements := NORMALIZE(ds_out_seq, LEFT.Statements, 
			TRANSFORM (FFD.Layouts.ConsumerStatementBatch, 
   							 SELF.Acctno := LEFT.Acctno,
   							 SELF.SequenceNumber := LEFT.SequenceNumber,
								 SELF := RIGHT));
   																						 
   	consumer_statements_prep  := FFD.prepareConsumerStatementsBatch(consumer_statements, pc_recs, inFFDOptionsMask);  																						 
   		
   	pre_result := PROJECT(ds_out_seq, BatchServices.layout_BankruptcyV3_Batch_out);	// project to non ffd layout		
   		
   	FFD.MAC.PrepareResultRecordBatch(pre_result, final_results, consumer_statements_prep, BatchServices.layout_BankruptcyV3_Batch_out); // prepare results and statements 
		
		return final_results;
 
 END;