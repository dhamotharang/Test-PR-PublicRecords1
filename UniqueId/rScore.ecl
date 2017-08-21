EXPORT rScore := RECORD
	unsigned8		newkey := 0;
	unsigned8		prevkey := 0;
	string			Entity_Unique_ID := '';
	integer			score := 0;
	string			flags {maxlength(12)} := '';
	string			WatchListName := '';
END;