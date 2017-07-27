EXPORT Layout_ExternalKeyOut := RECORD
	Types.DocRef            DocRef;
  Types.ExternalKey       ExternalKey;
  Types.PartitionID       part;
  Types.DocVersion        ver;
END;