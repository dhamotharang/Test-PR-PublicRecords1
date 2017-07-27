IMPORT FFD;
EXPORT prepareConsumerStatementsAndDisputesForBatch(dataset(marriage_divorce_v2_Services.layouts.batch_out_pre) batch_out_pre,
																										 dataset(FFD.Layouts.PersonContextBatch) PersonContext) := function
	temp_rec := record
			FFD.Layouts.ConsumerStatementBatch;
			dataset(FFD.Layouts.ConsumerStatementBatch ) Recs;
	end;
	
	//  Inner transform  
		FFD.Layouts.ConsumerStatementBatch xform_inner(
												boolean doDispute,
												FFD.Layouts.StatementIdRec le,
												marriage_divorce_v2_Services.layouts.batch_out_pre ri, 
												string section_id
												) :=  transform
			self.acctno 			:=  ri.acctno;
			self.SequenceNumber := ri.SequenceNumber;
			self.UniqueId 		:= 0; // Note: need to get the search DID here 
			self.DateAdded 		:= 	'';
			self.SectionID 		:= 	section_id;
			self.StatementID	:=	le.statementId;
			self.RecordType   := if(doDispute,FFD.Constants.RecordType.DR,FFD.Constants.RecordType.RS);
			self.DataGroup 		:= if(section_id IN ['party1','party2'],
																	FFD.Constants.DataGroups.MARRIAGE_SEARCH,
																	FFD.Constants.DataGroups.MARRIAGE );
			self.Content   		:=	'';	
		end;
			
			

	temp_rec xform(marriage_divorce_v2_Services.layouts.batch_out_pre l) := transform
   		 main_sids		:= 	project(l.statementids,xform_inner(false,left,l,'main')); 
   		 party1_sids  :=  project(l.party1_statementids ,xform_inner(false,left,l, 'party1')); 
   		 party2_sids  :=  project(l.party2_statementids,xform_inner(false,left,l, 'party2' )); 
			 
   	   main_disputes 		:= 	if(l.isDisputed,row(xform_inner(true,FFD.Constants.BlankStatementid,l,'main')));
			 party1_disputes  :=  if(l.party1_isdisputed,row(xform_inner(true,FFD.Constants.BlankStatementid,l, 'party1'))); 
   		 party2_disputes  :=  if(l.party2_isdisputed,row(xform_inner(true,FFD.Constants.BlankStatementid,l, 'party2' ))); 
			 
   		self.acctno := l.acctno;
			self.SequenceNumber  := l.SequenceNumber;
   		self.Recs 		:= main_sids + party1_sids + party2_sids +
											 main_disputes + party1_disputes + party2_disputes;
			self := [];
   	end;
	
	pre_out := project(batch_out_pre,xform(left)); 
	
	out := normalize(pre_out, LEFT.Recs, transform (FFD.Layouts.ConsumerStatementBatch, 
              												           self := right));
	StatementsAndDisputes := FFD.prepareConsumerStatementsBatch(out,PersonContext);	
	
	//output(batch_out_pre,named('batch_out_pre'));
	return(StatementsAndDisputes);
end;
