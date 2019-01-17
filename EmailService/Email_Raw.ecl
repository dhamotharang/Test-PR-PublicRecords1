import ut,doxie,autokeyb2,email_data, EmailService;

export Email_Raw := MODULE

	get_email(string addr1, string addr2) := function
		return trim(addr1) + '@' + trim(addr2);
	end;

	export get_email_records(
		dataset(EmailService.Assorted_Layouts.parsed_email) in_emails,
		unsigned in_limit = ut.limits.default
	) := function
	
    key := Email_Data.Key_Email_Address;
		email :=
		dedup(
			join(
				dedup(sort(in_emails,email_addr1,email_addr2,did),email_addr1,email_addr2,did), key,
		    keyed( get_email(left.email_addr1, left.email_addr2) = right.clean_email) and 
					(left.did=0 or  left.did=right.did),
				transform(EmailService.Assorted_Layouts.did_w_deepdive,self:=right),
				limit(in_limit, FAIL(203,doxie.ErrorCodes(203)))
			),
			did
		);
		// return if(in_limit=0, email, choosen(email,in_limit));
		return email;
	end;
	
	export get_email_search(
		GROUPED dataset(EmailService.Assorted_Layouts.did_w_input) in_dids,
		string3 search_type,
		boolean mult_results=false,
		string32 appType
	) := function
		
		tmp := EmailService.EmailSearchService_Records.val(in_dids,search_type,mult_results,appType);
		// patch did column to remove FakeIDs
		// - We're having a tough time figuring out why FakeIDs are being used outside of autokeys.  It appears
		//   there's a fundamental assumption that DID is unique and fully populated, and perhaps it's being used
		//   in lieu of a unique row identifier throughout this module.  In any event, we can't return FakeIDs!
		results := project(
			tmp,
			transform(EmailService.Assorted_Layouts.layout_search_out, 
					self.emailid:=left.did, 
					self.did:=if(AutokeyB2.isFakeID(left.did),0,left.did), 
					self:=left,
					self:=[])
		);
		
		return results;
	end;

END;