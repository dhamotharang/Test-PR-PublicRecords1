import iesp, BatchServices, BatchShare;
EXPORT getEmailInfo(dataset (MemberPoint.Layouts.BestExtended) dsBestE, 
									MemberPoint.IParam.BatchParams InputParams) := function

		EmailBatchIn := project(dsBestE,transform(BatchServices.Layouts.email.rec_batch_email_input,
						//unsigned8   seq := 0;
							self.acctno 			:= (string) left.seq,
							self.did 					:= left.did, 
							self.ssn 					:= if(left.best_ssn <> '',left.best_ssn,left.ssn), 
							self.name_first 	:= if(left.best_fname <> '',left.best_fname,left.fname ),
							self.name_middle 	:= if(left.best_fname <> '',left.best_mname,left.mname ),
							self.name_last 		:= if(left.best_fname <> '',left.best_lname,left.lname ),
							self.name_suffix 	:= left.best_name_suffix,
							//self.dob 					:= if(left.best_dob <> '', left.best_dob,left.dob),
							self.prim_range		:= left.c_best_prim_range,
							self.predir				:= left.c_best_predir,
							self.prim_name		:= left.c_best_prim_name,
							self.addr_suffix				:= left.c_best_addr_suffix,
							self.postdir			:= left.c_best_postdir,
							self.unit_desig		:= left.c_best_unit_desig,
							self.sec_range		:= left.c_best_sec_range,
							self.p_city_name	:= left.c_best_p_city_name,
							self.st						:= left.c_best_st,
							self.z5						:= left.c_best_z5,
							self.email_addrFull := left.input_email ));
							
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

 // 