
Layout_XGX := RECORD
	Layout_Watchlist.rWatchList;
	string	dob := ''	;
	unsigned8 primarykey := 0	;
END;

Layout_XGX xAssignId(Layout_Watchlist.rWatchList src, integer n) := TRANSFORM
		unsigned8 seed := 1;
		unsigned8	clusters := CLUSTERSIZE;
		self.primarykey := clusters*(n-1) + thorlib.node() + seed;
		self := src;
END;

layout_Flat xformListToFlat(Layout_XGX list) := TRANSFORM

		self := list;
		self := [];

END;

EXPORT Layout_XGX xListToFlat(Layout_Watchlist.rWatchList src) := 
						PROJECT(src, xAssignId(LEFT,COUNTER));


