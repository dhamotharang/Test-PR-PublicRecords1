EXPORT Constants := MODULE

  // Maxcount limits for certain fields, records, datasets, etc.
	export MAXCOUNT_ASSIGNEES      := 25;
	export MAXCOUNT_ASSIGNEES2     := 10;
	export MAXCOUNT_COLLATERAL     := 15;	
	export MAXCOUNT_CREDITORS      := 25;
	export MAXCOUNT_CREDITORS2     := 10;
	export MAXCOUNT_DEBTORS        := 25;
	export MAXCOUNT_DEBTORS2       := 25;
	export MAXCOUNT_RAW            := 2500;
	export MAXCOUNT_FILINGS        := 15;
	export MAXCOUNT_FILING_OFFICES := 15;
	export MAXCOUNT_FILING_PARTIES := 50;
	export MAXCOUNT_PARTIES        := 25;
	export MAXCOUNT_SECUREDS       := 25;
	export MAXCOUNT_SECUREDS2      := 10;
	export MAXCOUNT_SIGNERS        := 15;
	export MAIN_JOIN_LIMIT	       := 1350;
	
END;