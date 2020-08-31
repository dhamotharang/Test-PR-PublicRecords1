import iesp, BatchServices, BatchShare;
EXPORT getEmailInfo(dataset (MemberPoint.Layouts.BestExtended) dsBestE, 
									MemberPoint.IParam.BatchParams InputParams) := function

									
	EmailBatchIn := project(dsBestE,
	                         transform(BatchServices.Layouts.email.rec_batch_email_input,
                                     self.acctno 			:= (string) left.seq,							
							                       self.did 				:= left.did, 
							                       self:=[];));
							
		EmailBatchParams := MODULE(project(InputParams, BatchServices.Email_BatchService_Interfaces.BatchParams, opt))
				EXPORT unsigned8 MAX_EMAIL_PER_ACCTNO := 5; // implicitly defined by flat output layout.
				// EXPORT boolean useDMEmailSourcesOnly := false	: stored('UseDMEmailSourcesOnly'); // Added this to Batch Input Parameters instead.
		END;
	
	//Added flag to identify call from Memberpoint service
	 	modEmail := BatchServices.Email_BatchService_Records(EmailBatchParams,EmailBatchIn,false,emailforMemberpoint := True);
		sortedRecs:= SORT(modEmail.Recs, acctno, orig_email);
		dedupedRecs:= DEDUP(sortedRecs,acctno,orig_email);
		EmailRecs := dedupedRecs;
		EmailRoyalties := modEmail.dRoyalties;
	dsEmail := dataset([{EmailRecs ,EmailRoyalties}],MemberPoint.Layouts.EmailRec);
return dsEmail;
end;
