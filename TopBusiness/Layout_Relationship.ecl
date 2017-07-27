export Layout_Relationship := module

	export Unlinked := record
		string2 source_1;
		string50 source_docid_1;
		string10 source_party_1;
		string25 role_1;
		string2 source_2;
		string50 source_docid_2;
		string10 source_party_2;
		string25 role_2;
	end;
	
	export Linked := record
		unsigned6 bid_1;
		unsigned6 bid_2;
		Unlinked;
	end;

end;
