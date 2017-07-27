export Layout_TradeLines := module

	export Unlinked := record
		string2 source;
		string50 source_docid;
		string10 source_party;
		unsigned3 asof_date;
		string25 business_category;
		unsigned4 account_balance;
		unsigned1 current_pct;
		unsigned1 days_01_30_pct;
		unsigned1 days_31_60_pct;
		unsigned1 days_61_90_pct;
		unsigned1 days_91_plus_pct;
	end;
	
	export Linked := record
		unsigned6 bid;
		Unlinked;
	end;
	
end;
