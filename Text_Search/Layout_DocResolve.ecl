// Used in final part of resolve to hold onto partition number
EXPORT Layout_DocResolve := RECORD(Layout_DocHits)
		Types.PartitionID part;
END;