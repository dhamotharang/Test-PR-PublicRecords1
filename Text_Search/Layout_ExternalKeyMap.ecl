// External keymap record
EXPORT Layout_ExternalKeyMap := RECORD
	Types.DocRef            DocRef;
  Types.ExternalKey       ExternalKey;											 
	Types.ExternalKeyHash   HashKey;
	Types.PartitionID       part;
  Types.DocVersion        ver;
END;
