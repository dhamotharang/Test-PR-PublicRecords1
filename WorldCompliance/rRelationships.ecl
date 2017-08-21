EXPORT rRelationships := RECORD
	Layouts.rRelationship;
	string			relation;
	integer			sorter := 99;
	boolean			sameFile := false;
	string 			directId := '';
	unicode			name1 := '';
	unicode			name2 := '';
	unicode			cmts := '';
END;