EXPORT NameRepositoryV1 := 
	IF(thorlib.nodes() IN [1, 40, 400], 
		DISTRIBUTED(DATASET(Common.filename_NameRepository_Legacy, Layout_Repository, FLAT),NID),
		DISTRIBUTE(DATASET(Common.filename_NameRepository_Legacy, Layout_Repository, FLAT),NID)
	) : DEPRECATED('V1 is deprecated. Please specify useV2 := true');
