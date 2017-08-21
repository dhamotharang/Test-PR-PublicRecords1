EXPORT Layout_XGX xAssignPrimaryKey(Layout_Watchlist.rWatchList src, integer n, unsigned8 seed = 1) := TRANSFORM
		unsigned8	clusters := CLUSTERSIZE;
		//self.primarykey := clusters*(n-1) + thorlib.node() + seed;
		self.primarykey := n + seed;
		self.id := (string)n;
		self := src;
END;