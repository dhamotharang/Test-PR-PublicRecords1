export Layout_FEINs := module

	export Unlinked := record
		string2 source;
		string50 source_docid;
		string10 source_party;
		string9 fein;
	end;
	
	export Linked := record
		unsigned6 bid;
		unsigned6 brid;
		unsigned6 blid;
		Unlinked;
	end;

end;
