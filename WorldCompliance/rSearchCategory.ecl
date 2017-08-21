EXPORT rSearchCategory := RECORD
	integer				valueid;
	string				category;
	string				subcategory;
	unicode				name {MAXLENGTH(50)};
END;
