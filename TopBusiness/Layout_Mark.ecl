export Layout_Mark := module

	export Unlinked := record
		string2   source;
		string50  source_docid;
		string10  source_party;
		unsigned4 date_first_seen;
		unsigned4 date_last_seen;
		//string120 company_name; //???
		string2   mark_type; // i.e. TM=Trademark, TS=Tradestyle, BN=BrandName, SL=Slogan
		string50  mark_description;
	end;
	
	export Linked := record
		unsigned6 bid;
		//unsigned6 brid;
		//unsigned6 blid;
		Unlinked;
	end;
	
end;
