// record structure for extracting comments
EXPORT rComments := RECORD
	unsigned8 id;
	integer		sorter := 0;
	unicode 	cmts;
END;