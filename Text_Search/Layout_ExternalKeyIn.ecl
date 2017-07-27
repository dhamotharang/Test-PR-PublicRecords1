EXPORT Layout_ExternalKeyIn := RECORD
	Types.ExternalKeyHash   HashKey;
  Types.ExternalKey       ExternalKey;
	Types.PartitionID       part;
	Types.DocRef            DocRef;
  Types.DocVersion        ver;
END;