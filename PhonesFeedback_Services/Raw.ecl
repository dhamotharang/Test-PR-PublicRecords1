import PhonesFeedback_services, PhonesFeedback, ut;

export Raw := module
	
		export Layouts.Layout_PhonesFeedback_base byPhoneNumber(dataset(Layouts.rec_in_request) in_PhoneNumber) := function
			deduped := dedup(sort(in_PhoneNumber,Phone_number,in_DID),Phone_number,in_DID);
			joinup := join(deduped,PhonesFeedback.Key_PhonesFeedback_phone,
											((left.Phone_number =  right.Phone_number) and ((unsigned) left.in_did= (unsigned) right.did  or (unsigned) left.in_did=0)),
												 transform(Layouts.Layout_PhonesFeedback_base,														 
												 self := right), limit(ut.limits.FEEDBACK_PER_PHONE, skip));
			deduped_recs := dedup(sort(joinup, record), record);
			
			return deduped_recs;
		end;
	 
	 
	 export feedback_rpt (dataset(Layouts.rec_in_request) in_rec):=function
 		  deduped := dedup(sort(in_rec,Phone_number,in_DID),Phone_number,in_DID);
				
			skip_set:=['7','8'];

			joinup := join(deduped,PhonesFeedback.Key_PhonesFeedback_phone,
											((left.Phone_number =  right.Phone_number) and 
											((unsigned) left.in_did= (unsigned) right.did  or (unsigned) left.in_did=0)) and
											(right.phone_contact_type not in skip_set),
												 transform(Layouts.Layout_PhonesFeedback_base,														 
												 self := right), limit(ut.limits.FEEDBACK_PER_PHONE, skip));
			deduped_recs := dedup(sort(joinup, record), record);
			
			result_tmp:=if(exists(deduped_recs),
											PhonesFeedback_Services.Functions.GetReport(deduped_recs),
											dataset([],PhonesFeedback_Services.Layouts.feedback_report));
			result:=choosen(result_tmp,1);
			return result;
	 
	 end;
	 
end;