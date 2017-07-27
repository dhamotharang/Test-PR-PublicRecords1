export Layout_License := module

	export Unlinked := record
		string2 source;
		string50 source_docid;	
		string10 source_party;
		string2 license_state;
		string60 license_board;
		string25 license_number; // the license number issued
		string60 license_type;   // the type of license (pharmacy? md? hairsylist?)
		string45 license_status;
		string8 issue_date;
		string8 last_renewal_date;
		string8 expiration_date;
		string120 company_name;
	end;
	
	export Linked := record
		unsigned6 bid;
		Unlinked;
	end;

end;
