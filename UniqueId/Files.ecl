import ut;
EXPORT Files := MODULE

currnm := '~thor::in::uniqueid::entity';
//thor_200::in::globalwatchlists::country::20130425

export new := DATASET(currnm, Layout_Watchlist.rWatchList,
															XML('WatchList_List/Entity'));
export country := DATASET('~thor::in::uniqueid::country', Layout_Watchlist.rGeo,
															XML('WatchList_List/Country'));
														
export current := DATASET('~thor::uniqueid::base::current', Layout_Flat,THOR);
export father := DATASET('~thor::uniqueid::base::father', Layout_Flat,THOR);
//export father := PROJECT(DATASET('~thor::uniqueid::base::father', Layout_Flat_Deprecated,THOR),Layout_Flat);
																														
export processed := DATASET('~thor::uniqueid::alldata',Layout_Watchlist.rWatchList,
															XML('WatchList_List/Entity'));


END;