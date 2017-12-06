IMPORT BatchServices,ut;
EXPORT PossibleLitigiousDebtor_BatchService_Functions := MODULE

	EXPORT BatchServices.Layouts.PLD.rec_batch_PLD_input file_inPLDBatchMaster(BOOLEAN useCannedRecs = FALSE,BOOLEAN forceSeq = FALSE) := FUNCTION 
			//
			// generic layout with Possible Litigious debtor information added
			// see BatchServices.Layouts.PLD.rec_batch_pld_input
			//
			rec := BatchServices.Layouts.PLD.rec_batch_PLD_input;

			raw1 := DATASET([], rec) : STORED('batch_in', FEW);
			raw0 := raw1 : GLOBAL;

			rec tra(rec l) := TRANSFORM
				SELF.max_results := if( (UNSIGNED8) l.max_results > 0, l.max_results, (string4) BatchServices.Constants.PLD.SEQ_MAX_LIMIT);
				SELF := l;
			end;

			raw := PROJECT(raw0, tra(LEFT));

			ut.MAC_Sequence_Records(raw, seq, raw_seq)

			PLD_file := IF(NOT forceSeq AND EXISTS(raw(seq > 0)), raw, raw_seq);	
			
			sample_PLD_set := BatchServices._Sample_inBatchMaster('POSSIBLELITIGIOUSDEBTOR');
			
			// just use other inputs for testing.
			 test_PLD_recs := PROJECT(sample_PLD_set, TRANSFORM(
																							 BatchServices.Layouts.PLD.rec_batch_PLD_input,	
																											self.acctno := left.acctno;
																											SELF.name_first := left.name_first;
																											Self.name_last  := left.name_last;																						        
																											SELF.CourtJurisdiction :=  left.st;		
																											self.CaseTypeSearch_FDCPA := left.sic_code;
																											self.CaseTypeSearch_FCRA  := left.fein;
																											self.CaseTypeSearch_TCPA  := left.ssn;
																											SELF := []
																											));
																																																																										
			ds_batch_in_pld :=  IF( NOT useCannedRecs, PLD_file, test_PLD_recs);			
			
			return ds_batch_in_pld;
	
end;	



END;