export NameRepository := 
	IF(thorlib.nodes() IN [1, 40, 400], 
		DISTRIBUTED(DATASET(Common.filename_NameRepository, Layout_Repository, FLAT),NID),
		DISTRIBUTE(DATASET(Common.filename_NameRepository, Layout_Repository, FLAT),NID)
	);
