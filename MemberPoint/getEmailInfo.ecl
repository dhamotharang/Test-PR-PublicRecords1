import iesp, BatchServices, BatchShare,EmailV2_Services;
EXPORT getEmailInfo(dataset (MemberPoint.Layouts.BestExtended) dsBestE, 
									MemberPoint.IParam.BatchParams InputParams) := function

							          
		    			Emailv2serviceBatchIn := project(dsBestE,transform(EmailV2_Services.Layouts.batch_email_input,
               self.acctno 			:= (string) left.seq,							
							 self.did 				:= left.did, 
							 self:=[];));
															 
		          Email_v2_ServiceBatchParams := MODULE(project(InputParams, EmailV2_Services.IParams.getBatchParams(), opt))
							 EXPORT STRING    SearchType:=       MemberPoint.Constants.emailv2search.searchtype;
							 EXPORT STRING    SearchTier:=       if(inputparams.useDMEmailSourcesOnly,Memberpoint.Constants.defaults.Emailv2serviceBasic,Memberpoint.Constants.defaults.Emailv2servicePremium);
							 EXPORT STRING    RestrictedUseCase:=if(inputparams.useDMEmailSourcesOnly,Memberpoint.Constants.defaults.NoRoyaltySources,Memberpoint.Constants.defaults.Standard);
               EXPORT BOOLEAN   CheckEmailDeliverable:=if(inputparams.useDMEmailSourcesOnly,false,true);               
							 EXPORT unsigned8 MaxResultsPerAcctno:= 10;							 
							 EXPORT BOOLEAN   IncludeAdditionalInfo := FALSE;
					    END;
	
							
		         
						 
			      Email_v2_batch_service :=	EmailV2_Services.Batch_Records(Emailv2serviceBatchIn,	email_v2_servicebatchparams,false);		
	          Emailv2recs:=project(email_v2_batch_service.Records,
		                              transform(memberpoint.Layouts.EmailRecforv2,
																												SELF.acctno        := LEFT.acctno;
																												self.ln_date_first :=(integer)left.ln_date_first;
																												self.ln_date_last  :=(integer)left.ln_date_last;
																												SELF.did           :=LEFT.did;
																											  SELF               :=LEFT;
																											  Self               :=[];));
					
						dsEmail := dataset([{Emailv2recs ,email_v2_batch_service.Royalties}],MemberPoint.Layouts.EmailRec);
		return dsEmail;
end;

