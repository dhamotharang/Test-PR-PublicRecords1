export Layout_URLs := module

	export Unlinked := record
		string2 source;
		string50 source_docid;
		string10 source_party;
		string80 url;
	end;
	
	export Linked := record
		unsigned6 bid;
		unsigned1 segment_bid;
		string80 cleanurl;
		Unlinked;
	end;
end;
