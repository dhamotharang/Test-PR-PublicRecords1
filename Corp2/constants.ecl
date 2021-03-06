export Constants := module
	
	// boolean search
	export STRING stem		:= '~thor_data400';
	export STRING srcType := 'Corp2';
	export STRING qual		:= 'test';
	export STRING dateSegName			:= 'process-date';
	export UNSIGNED2 alertSWDays	:= 31;

	export RA_desc := 'REGISTERED AGENT';
	
	EXPORT UNSIGNED1 MAXCOUNT_CONTACTS       := 50;
	EXPORT UNSIGNED1 MAXCOUNT_EVENTS         := 50;
	EXPORT UNSIGNED1 MAXCOUNT_STOCKS         := 25;
	EXPORT UNSIGNED1 MAXCOUNT_ANNUAL_REPORTS := 25;
	EXPORT UNSIGNED1 MAXCOUNT_CORP_HIST      := 50;
	EXPORT UNSIGNED1 MAXCOUNT_TRADENAMES     := 25;
	EXPORT UNSIGNED1 MAXCOUNT_TRADEMARKS     := 25;
	
	Export Build_BID_Keys := true;

	EXPORT BATCH_JOIN_LIMIT_LARGE := 10000;
	EXPORT BATCH_JOIN_LIMIT_SMALL := 1000;
	
end;