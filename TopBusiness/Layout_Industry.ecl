export Layout_Industry := module

	export Unlinked := record
		string2 source;
		string50 source_docid;	
		string10 source_party;
		string8  SicCode;
		string6  NAICS;
		string128 industry_description;
		// ^--- 100 for Calbus, 128 for DNB, 40 for EBR(0010 rec), 100 for FBN, 350 for incorp, 
		//      111 for IRS990,	unlimited on Sheila_Greco, unlimited on Zoom
	end;
	
	export Linked := record
		unsigned6 bid;
		Unlinked;
	end;

end;
