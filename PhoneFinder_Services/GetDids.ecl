IMPORT Autokey_batch, BatchServices, Didville, Header;
// Obtain a set of dids for each batch input record. Return only acctno and did. ( 1 acctno --> M dids )
 EXPORT GetDIDs(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) dBatchIn, boolean UseADL = false) :=
	FUNCTION
		
		lBatchInDID := PhoneFinder_Services.Layouts.BatchInAppendDID;
		//Auto header get dids for phone search
		dDidsAcctno_pre 	:= BatchServices.Functions.fn_find_dids_and_append_to_acctno(dBatchIn, PhoneFinder_Services.Constants.MaxDIDs,  false); // to prune oldssns
		
		dDidsAcctno_header       := dDidsAcctno_pre(did > 0, did < header.constants.QH_start_rid); 
		
		dDids_header := JOIN(dBatchIn, dDidsAcctno_header,
		 LEFT.acctno = RIGHT.acctno,
			TRANSFORM(lBatchInDID,
				SELF.orig_did 	:= RIGHT.did,
				SELF.did				:= RIGHT.did,
				SELF						:= LEFT),
			LEFT OUTER,ALL);	
	
	// ADL process to get dids for pii search
	 didville.Layout_Did_OutBatch into(Autokey_batch.Layouts.rec_inBatchMaster l) := TRANSFORM   
	 
     SELF.seq        := l.seq;
     SELF.phone10    := l.homephone;
     SELF.fname      := l.name_first;
     SELF.mname      := l.name_middle;
     SELF.lname      := l.name_last;
     SELF.suffix     := l.name_suffix;
     SELF            := l;
		   SELF            := [];
     
   end;
		
		file_in := PROJECT(dBatchIn , into(LEFT));
	 //append did
  Didville.MAC_DidAppend(file_in, file_w_did, true, '');
	
	 dDids_adl := JOIN(dBatchIn, file_w_did,
			LEFT.seq = RIGHT.seq,
			TRANSFORM(lBatchInDID,
				SELF.acctno		:= LEFT.acctno,
				SELF.orig_did 	:= RIGHT.did,
				SELF.did				:= RIGHT.did,
				SELF						:= LEFT),
			LEFT OUTER,ALL);	
	 
	 // Use ADL for a PII search
	 dDidsAcctno := IF(UseADL, dDids_adl, dDids_header);
		
		// Rollup the dids dataset returned with each acctno to count the dids
		lBatchInDID tRollDids(lBatchInDID le, dataset(lBatchInDID) allRows) :=
		TRANSFORM
			SELF.did_count := COUNT(allRows(did <> 0));
			SELF           := le;
		END;
		dCounts := ROLLUP(GROUP(SORT(dDidsAcctno, acctno), acctno),
			GROUP,
			tRollDids(LEFT, ROWS(LEFT)));
		
		dWithDIDs			:= JOIN(dDidsAcctno, dCounts,
			LEFT.acctno = RIGHT.acctno,
			TRANSFORM(lBatchInDID,
				SELF.did_count 	:= RIGHT.did_count,
				SELF						:= LEFT),
			LEFT OUTER,ALL);
			
		RETURN dWithDIDs;
END;