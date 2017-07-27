IMPORT FFD;

EXPORT  prepareConsumerStatementsBatch (DATASET (FFD.layouts.ConsumerStatementBatch) out,
                                        DATASET (FFD.layouts.PersonContextBatch) ds_pc,
																				INTEGER8 inFFDOptionsMask = 0
                                        )  := FUNCTION

  BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
	BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) OR FFD.FFDMask.isShowDisputedBankruptcies(inFFDOptionsMask);
	
	//TODO: if we preserve statement IDs from disputed records in the results,
  //      this code can be significantly simplified 

  // Gather all the DRs , RS  and CS 
  PersonContext_RS := ds_pc (RecordType = FFD.Constants.RecordType.RS);
  PersonContext_DR := ds_pc (RecordType = FFD.Constants.RecordType.DR);
  PersonContext_CS := ds_pc (RecordType = FFD.Constants.RecordType.CS);
  
  // Classify all the out into DR and RS
  out_RS := out(RecordType = FFD.Constants.RecordType.RS);
  out_DR := out(RecordType = FFD.Constants.RecordType.DR); 

  // Figure out which DRs & RS to output & project to output format.
  Rstatements := JOIN (out_RS, PersonContext_RS,
                       LEFT.acctno = RIGHT.acctno AND
                       LEFT.StatementID = RIGHT.StatementID, 
                       TRANSFORM (FFD.layouts.ConsumerStatementBatchFull,
                                  self.acctno := left.acctno,
                                  self.SequenceNumber := left.SequenceNumber,
                                  self.SectionID := left.SectionID,
                                  self.UniqueID :=  (unsigned)right.LexID,
                                  self.RecordType := left.RecordType,
                                  self := right)); // inner
 
  // We need this as a join only and only to get the DID and nothing else. 
  Disputes :=  PROJECT (out_DR,
												TRANSFORM (FFD.layouts.ConsumerStatementBatchFull,
																	self.acctno := left.acctno,
																	self.SectionID := left.SectionID,
																	self.SequenceNumber := left.SequenceNumber,
																	self.UniqueID := (unsigned) PersonContext_DR(acctno = left.acctno)[1].LexID,
																	self.RecordType := left.RecordType,
																	self.Content := '',
																	self := left));

  // Project CS to the output format
  CSstatements := PROJECT (PersonContext_CS,
                           TRANSFORM (FFD.layouts.ConsumerStatementBatchFull,
																	self.acctno := left.acctno ,
																	self.SequenceNumber := 0, // Consumer level statements are for the whole DID, not specefic data rows. 
																	self.UniqueID := (unsigned)left.LexID,
																	self.RecordType := left.RecordType,
																	self.SectionId := ''; // blank for subject level records
																	self := left));
  
  // Combine all into the final output
  // TODO: find out if there are possible duplicates here;
  //       consider using KEEP (1) in joins above, if feasible
	
  StatementsAndDisputes := MAP(showConsumerStatements => Rstatements + Disputes + CSstatements,
																showDisputedRecords => Disputes,
																DATASET([],FFD.layouts.ConsumerStatementBatchFull));  																						 

  RETURN StatementsAndDisputes;
END;
