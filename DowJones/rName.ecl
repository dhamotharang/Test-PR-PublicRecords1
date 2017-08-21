EXPORT rName := RECORD
	string			id;
	string			nameType;
	string			TitleHonorific;
	unicode			FirstName;
	unicode			MiddleName;
	unicode			SurName;
	unicode			Suffix;
	unicode			MaidenName;
	unicode			FullName;
	integer			primary;
	integer			fullNameType;	// 1=Derived,2=Latin characters; 3=non-latin; 4=blank
END;