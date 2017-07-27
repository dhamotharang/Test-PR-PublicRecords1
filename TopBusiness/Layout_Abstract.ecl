export Layout_Abstract := module

	export Unlinked := record
		string2 source;
		string50 source_docid;	
		string10 source_party;
		string1502 business_description;
		//    ^--- 1502 on DCA, 40 on DEADCO, unlimited on Sheila_Greco, unlimited on Spoke
	end;
	
	export Linked := record
		unsigned6 bid;
		Unlinked;
	end;

end;

