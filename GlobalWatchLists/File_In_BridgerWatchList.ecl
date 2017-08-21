import globalwatchlists, ut, Data_Services;

	//Pull FSE Data from Uniqueid File
	currnm 				:= dataset(Data_Services.foreign_prod+'thor::in::uniqueid::entity', Globalwatchlists.Layout_Watchlist.rWatchList, XML('WatchList_List/Entity'));
	ofsi_filter		:= currnm(regexfind('SEMA Iran', reason_listed, 0)<>'' and watchlistname = 'OSFI CONSOLIDATED LIST');
	ofac_filter		:= currnm(watchlistname = 'OFAC NON-SDN ENTITIES');
	
EXPORT File_In_BridgerWatchList := ofsi_filter + ofac_filter; 
