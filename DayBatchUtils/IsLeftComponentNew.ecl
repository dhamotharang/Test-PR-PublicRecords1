export IsLeftComponentNew(STRING l, STRING r) := FUNCTION
	return (l <> '' AND l <> r);
END;