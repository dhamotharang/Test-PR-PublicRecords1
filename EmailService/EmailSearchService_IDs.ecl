import doxie,doxie_raw,AutoStandardI,ut;

export EmailSearchService_IDs := module
	
	export params := interface(AutoKey_IDs.params,
	AutoStandardI.InterfaceTranslator.noDeepDive.params,
	AutoStandardI.InterfaceTranslator.did_value.params,
	AutoStandardI.InterfaceTranslator.ssn_mask_value.params)
	export string120 email;
	end;
	
	export val(params in_mod) := module

		
		emails_srch := if(in_mod.email<>'@',  project(dataset([{'','',false,0}],EmailService.Assorted_Layouts.parsed_email),
									transform(EmailService.Assorted_Layouts.parsed_email,
		self.email_addr1 :=in_mod.email[1..(stringlib.stringfind(in_mod.email,'@',1))-1],
		self.email_addr2 :=in_mod.email[(stringlib.stringfind(in_mod.email,'@',1))+1..],
		self.isdeepdive := False,
		self.did := 0)));
		
		email_dids :=if(in_mod.email <>'@', EmailService.Email_Raw.get_email_records(emails_srch));

		shared by_email_dids := if(exists(email_dids),project(email_dids,transform(EmailService.Assorted_Layouts.did_w_deepdive,
			self.isdeepdive := FALSE,self.did:=left.did)));

		// autokeys
		shared by_auto_dids	:= AutoKey_IDs.val(in_mod).ids;
 
		// Only use get_Dids if by_auto_dids doesn't exist because we want max 1 record in the output
		deep_dids0 := if(~exists(by_auto_dids), doxie.Get_Dids(,true));
		
		shared by_deep_dids := if(not in_mod.noDeepDive,project(deep_dids0,transform(EmailService.Assorted_Layouts.did_w_deepdive,
			self.isdeepdive := TRUE,self.did:=left.did)));
 
		// lookup by DID
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		shared by_did := if((unsigned)in_mod.DID > 0,project(dids,transform(EmailService.Assorted_Layouts.did_w_deepdive,
			self.isdeepdive := FALSE,self.did:=left.did)));
		
		all_dids_found := by_did+by_auto_dids+by_deep_dids;
		
		shared all_dids:= if(exists(all_dids_found),all_dids_found,dataset([{0}],EmailService.Assorted_Layouts.did_w_deepdive));
		emails := if(in_mod.email<>'@',  project(all_dids,transform(EmailService.Assorted_Layouts.parsed_email,
		self.email_addr1 :=in_mod.email[1..(stringlib.stringfind(in_mod.email,'@',1))-1],
		self.email_addr2 :=in_mod.email[(stringlib.stringfind(in_mod.email,'@',1))+1..],
		self.isdeepdive := left.isdeepdive,
		self.did := left.did)));

		by_emails := if(in_mod.email <>'@', EmailService.Email_Raw.get_email_records(emails));
		
		

		// combine...
		ids0 := map((unsigned)in_mod.DID <> 0=> by_did, 
								in_mod.email<>'@'=> by_emails,
								by_auto_dids + by_deep_dids);
		
		// ...and shifting deep-dive-only to the end
		ids_d := dedup(sort(ids0, did, isDeepDive), did);

		// output(in_mod);
		// output(emails_srch,named('essids_emails_srch'));
		// output(email_dids,named('essids_email_dids'));
		// output(by_email_dids,named('essids_by_email_dids'));
		// output(emails,named('essids_emails'));
		// output(all_dids_found,named('essids_all_dids_found'));
		//output(ids_d,named('essids_ids_d'));
	
		export ids :=ids_d;
		export by_email_key := all_dids[1].did=0;
		export by_email_val := by_email_dids;
	end;
end;
