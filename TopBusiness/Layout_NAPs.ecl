export Layout_NAPs := module

	export Unlinked := record
		string2 source;
		string30 source_docid;
		string10 source_party;
		unsigned4 date_first_seen;
		unsigned4 date_last_seen;
		string120 company_name;
		unsigned1 company_name_type;
		unsigned1 address_type;
		unsigned1 phone_type;
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
		string4 msa;
		string10 phone;
		string9 fein;
	end;
	
	export Linked := record
		unsigned6 bid;
		unsigned6 brid;
		unsigned6 blid;
		unsigned6 beid;
		Unlinked;
	end;

end;
