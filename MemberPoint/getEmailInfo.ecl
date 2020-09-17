import iesp, BatchServices, BatchShare,EmailV2_Services;
EXPORT getEmailInfo(dataset (MemberPoint.Layouts.BestExtended) dsBestE, 
									MemberPoint.IParam.BatchParams InputParams) := function

							EmailBatchIn := project(dsBestE,transform(BatchServices.Layouts.email.rec_batch_email_input,
               self.acctno 			:= (string) left.seq,							
							 self.did 				:= left.did, 
							 self:=[];));
          
		    			Emailv2serviceBatchIn := project(dsBestE,transform(EmailV2_Services.Layouts.batch_email_input,
               self.acctno 			:= (string) left.seq,							
							 self.did 				:= left.did, 
							 self:=[];));
															 
		          Email_v2_ServiceBatchParams := MODULE(project(InputParams, EmailV2_Services.IParams.BatchParams, opt))
							 EXPORT STRING  SearchType:=MemberPoint.Constants.emailv2search.searchtype;
							 EXPORT STRING  SearchTier:=Memberpoint.Constants.defaults.Emailv2serviceBasic;
							 EXPORT unsigned8 MaxResultsPerAcctno := 10;
							 EXPORT BOOLEAN   IncludeAdditionalInfo := FALSE;
					    END;
	
							
		         EmailBatchParams := MODULE(project(InputParams, BatchServices.Email_BatchService_Interfaces.BatchParams, opt))
			      	 EXPORT unsigned8 MAX_EMAIL_PER_ACCTNO := 5; // implicitly defined by flat output layout.
				     END;
						 
			      Email_v2_batch_service :=	EmailV2_Services.Batch_Records(Emailv2serviceBatchIn,	email_v2_servicebatchparams,false);		
			      Batch_email_service    :=BatchServices.Email_BatchService_Records(EmailBatchParams,EmailBatchIn,false,emailforMemberpoint := True);
	          Emailv2recs:=project(email_v2_batch_service.Records,
		                              transform(memberpoint.Layouts.EmailRecforv2,
																												SELF.acctno        := LEFT.acctno;
																												self.ln_date_first :=(integer)left.ln_date_first;
																												self.ln_date_last  :=(integer)left.ln_date_last;
																												SELF.did           :=LEFT.did;
																											  SELF               :=LEFT;
																											  Self               :=[];));
						batchemailrecs:=project(batch_email_service.Recs,
		                                transform(memberpoint.Layouts.EmailRecforv2,
																						                SELF.acctno := LEFT.acctno,
																														SELF.did    :=LEFT.did;
																													  SELF        :=LEFT;
																													  Self        :=[]; ));
						
						BatchemailrecssortedRecs:= SORT(batchemailrecs, acctno, orig_email);
						Batchemailrecsdeduped:= DEDUP(batchemailrecssortedRecs,acctno,orig_email);
						dsEmail := if(InputParams.UseDMEmailSourcesOnly,dataset([{Emailv2recs ,email_v2_batch_service.Royalties}],MemberPoint.Layouts.EmailRec),dataset([{Batchemailrecsdeduped,batch_email_service.dRoyalties}],MemberPoint.Layouts.EmailRec));
		return dsEmail;
end;

