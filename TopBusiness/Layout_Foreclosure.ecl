import iesp;
export Layout_Foreclosure := module

	export Main := module

		export Unlinked := record
			string2  source;
			string50 source_docid;   											  	
			string1  deed_category;
			string120 company_name;
		  string20 name_last;
		  string20 name_first;
		  string20 name_middle;
		  string5 name_suffix;
		  string5 name_title;		
		 	iesp.share.t_Address Address;			// maybe same as siteAddress1 (property address)
		end;
		
		export Linked := record
			unsigned6 bid;
			Unlinked;
		end;
	
	end;
	
	export Party := module
	
		export Unlinked := record
			string50 foreclosure_id;		
			string45 unformatted_apn;
			iesp.share.t_Address siteAddress1; // property address
			iesp.share.t_Address siteAddress2; // mailing address
			string40 documentType;	
			string3  county;
			string2  state_code;
			string8  recordingDate;
			string60	attorney_name;
			string10	attorney_phone_nbr;
			string10	auction_date;
			string30	lender_beneficiary_first_name;
			string30	lender_beneficiary_last_name;
			string30	lender_beneficiary_company_name;
			string30  first_defendant_borrower_owner_first_name;
			string30	first_defendant_borrower_owner_last_name;
			string30  second_defendant_borrower_owner_first_name;
			string30	second_defendant_borrower_owner_last_name;						
		end;
		
		export Linked := record
			unsigned6 bid;
			Unlinked;
		end;
		
	end;
	
end;