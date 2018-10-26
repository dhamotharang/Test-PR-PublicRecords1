EXPORT NameRepositoryV1 := 
	IF(thorlib.nodes() IN [1, 40, 400], 
		DISTRIBUTED(DATASET(Common.filename_NameRepository_Legacy, Layout_Repository, FLAT, OPT),NID),
		DISTRIBUTE(DATASET(Common.filename_NameRepository_Legacy, Layout_Repository, FLAT, OPT),NID)
	);
