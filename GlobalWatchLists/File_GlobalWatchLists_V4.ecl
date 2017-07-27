import	ut;

export	File_GlobalWatchLists_V4	:=
module
	
	export	In	:=
	module
		export	entity	:=	dataset('~thor_200::in::globalwatchlists::masterlist',GlobalWatchLists.Layouts.In.Entity,XML('WatchList_List/Entity'));	
		export	country	:=	dataset('~thor_200::in::globalwatchlists::masterlist',GlobalWatchLists.Layouts.In.Country,XML('WatchList_List/Country'));
	end;
	
	export	Base	:=
	module
		export	Entity	:=	dataset(GlobalWatchLists.constants.Cluster	+	'base::globalwatchlistsV2::entity',GlobalWatchLists.Layouts.Base.rEntity_Layout,thor);
		export	Country	:=	dataset(GlobalWatchLists.constants.Cluster	+	'base::globalwatchlistsV2::country',GlobalWatchLists.Layouts.Base.rCountry_Layout,thor);
	end;
	
end;

