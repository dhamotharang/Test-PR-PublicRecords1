export Layout_Finance := module;

	export Unlinked := record	 
	
	  string2  source;
		string50 source_docid;
		string10 source_party;
		
		string10 exchange;
		string10 ticker;
		
	  unsigned4  FiscalYearEnding;	
		integer  Sales;
		integer  Revenue;
		
		integer  ProfitsLoss;		
		
		integer  NetWorth;
		
		integer  LongTermAssets;	
		integer  CurrentAssets;
		integer  TotalAssets;
			
		integer  LongTermLiabilities;
		integer  CurrentLiabilities;		
		integer  TotalLiabilities;
						
		real     TotalLiabilitiesToNetWorth;
		real     SalesToNetWorkingCapitalRatio;	
		real     CurrentRatio;
		real     QuickRatio;
			
		string8  AnnualSalesRevisionDate;							
	end;

  export Linked := record	
		unsigned6 bid;
		Unlinked;
  end;
	
end;