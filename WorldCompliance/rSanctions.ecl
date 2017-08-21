EXPORT rSanctions := RECORD
	unsigned8		Ent_Id;
	Layouts.rSource;
	string			EffectiveDate {maxlength(20)};
	string			ExpirationDate {maxlength(20)};
	unicode			comment := '';
END;