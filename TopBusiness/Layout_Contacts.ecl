export Layout_Contacts := module

	export Unlinked := record
		string2  source;
		string50 source_docid;
		string10 source_party;
		unsigned4 date_first_seen;
		unsigned4 date_last_seen;
		string9  ssn;
		string5  name_prefix;
		string20 name_first;
		string20 name_middle;
		string20 name_last;
		string5  name_suffix;
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  addr_suffix;
		string2  postdir;
		string10 unit_desig;
		string8  sec_range;
		string25 city_name;
		string2  state;
		string5  zip;
		string4  zip4;
		string40 position_title;
		string1  position_type;				
		string10 phone;
		string50 email;
	end;
	
	export Linked := record 	
		unsigned6 bid;
		unsigned6 brid;
		unsigned6 blid;
		unsigned1 segment_bid;
		string40 ln_position_title;
		unsigned6 did;
		unsigned2 score;
		Unlinked;
	end;
	
end;
