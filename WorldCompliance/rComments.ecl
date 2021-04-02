// record structure for extracting comments
EXPORT rComments := RECORD
	unsigned8 Ent_id;
	integer		sorter := 0;
	unicode 	cmts;
	unicode		subcmts;
END;