export Layout_Linking := module

	export Match := record
		unsigned6 beid_low;
		unsigned6 beid_high;
		unsigned4 matchcode;
	end;

	export Match_BID := record
		Match;
		unsigned6 bid_low;
		unsigned6 bid_high;
	end;

	export Unlinked := record
		string2 source;
		string50 source_docid;
		string10 source_party;
		unsigned4 date_first_seen;
		unsigned4 date_last_seen;
		string120 company_name;
		unsigned1 company_name_type;
		unsigned1 address_type;
		unsigned1 phone_type;
		unsigned8 aid;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 city_name;
		string2 state;
		string5 zip;
		string3 county_fips;
		string4 msa;
		string10 phone;
		string9 fein;
		string80 url;
		string9 duns;
		string9 experian;
		string9 zoom;
		string2 incorp_state;
		string25 incorp_number;
	end;
	
	export Linked := record
		unsigned6 bid;
		unsigned6 brid;
		unsigned6 blid;
		unsigned6 beid;
		unsigned1 segment_bid;
		Unlinked;
		string18 county_name;
		string5 cbsa_number;
	end;
	
	export Working := record
		Linked;
		string120 clean_company_name;
		string1 residential_or_business_ind;
		boolean highrise_ind;
		string2 telco_st;
	end;
	
end;
