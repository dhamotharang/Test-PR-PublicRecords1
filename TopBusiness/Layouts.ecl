export Layouts := module

	shared Source := record
		Types.source       source;
		Types.source_docid source_docid;
		Types.source_party source_party;
	end;
	
	shared IDs := record
		unsigned6 bid;
		unsigned6 brid;
		unsigned6 blid;
	end;

	export Linking := module
	
		export Unlinked := record
			Source;
			Types.date          date_first_seen;
			Types.date          date_last_seen;
			Types.company_name  company_name;
			Types.prim_range    prim_range;
			Types.directional   predir;
			Types.prim_name     prim_name;
			Types.addr_suffix   addr_suffix;
			Types.directional   postdir;
			Types.unit_desig    unit_desig;
			Types.sec_range     sec_range;
			Types.city          city_name;
			Types.state         state;
			Types.zip           zip;
			Types.phone         phone;
			Types.fein          fein;
			Types.url           url;
			Types.duns          duns;
			Types.state         incorp_state;
			Types.incorp_number incorp_number;
		end;
		
		export Linked := record
			unsigned6 bid;
			unsigned6 brid;
			unsigned6 blid;
			unsigned6 beid;
			unsigned1 segment_bid;
			Unlinked;
		end;
	
	end;
	
	export URLs := module
	
		export Linked := record
			unsigned6 bid;
			Source;
			Types.url url;
		end;
	
	end;

end;
