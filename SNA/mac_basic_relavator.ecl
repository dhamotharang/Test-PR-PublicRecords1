import Address, AlertList;

EXPORT mac_basic_relavator(InData, pdidfield, distance_threshold=2, UseIndexThreshold=4000000) := FUNCTIONMACRO

  relavated_rec := RECORD
		RECORDOF(InData);
		RECORDOF(SNA.Key_Person_Cluster);
  END;
	RelavatedClusters := JOIN(DISTRIBUTE(InData,SKEW(0.1)), SNA.Key_Person_Cluster_Degree, 
	                         left.pdidfield=right.cluster_id and right.degree_key <= distance_threshold*100,
																				TRANSFORM(relavated_rec, 
															          SELF.cluster_id := right.associated_did, SELF.associated_did := right.cluster_id,
																				SELF := RIGHT, SELF := LEFT),
																				KEYED, SKEW(1), LIMIT(10000, SKIP));

	RETURN RelavatedClusters;
	
ENDMACRO;	