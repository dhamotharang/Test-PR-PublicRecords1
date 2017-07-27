export Layout_MergeWork := RECORD
	Types.Stage  stage;
	Types.PartitionID part;
	Types.SourceID src;
	Types.DocID		 doc;
	Layout_MergeSeg;
END;