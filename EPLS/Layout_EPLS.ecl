
Layout_Address := RECORD
	string	Street1{xpath('Street1')};
	string	Street2{xpath('Street2')};
	string	City{xpath('City')};
	string	ZipCode{xpath('ZIP')};
	string	Province{xpath('Province')} := '';	
	string	State{xpath('State')};
	string	Country{xpath('Country')};
	string	DUNS{xpath('DUNS')};
END;


EXPORT Layout_EPLS := RECORD,MAXLENGTH(4096)
	string	Name{xpath('Name')};
	string	Prefix{xpath('Prefix')};
	string	FirstName{xpath('First')};
	string	MiddleName{xpath('Middle')};
	string	LastName{xpath('Last')};
	string	Suffix{xpath('Suffix')};
	string	Classification{xpath('Classification')};
	string	CTType{xpath('CTType')};
	Layout_Address	Addresses{xpath('Addresses/Address')};
//	DATASET(rReference)	CrossReference{xpath('References/Reference')};
	SET OF STRING	CrossReference{xpath('References/Reference')};
	dataset(Layout_Action)		Actions{xpath('Actions/Action')};
	string	Description{xpath('Description')} := '';
	string	AgencyIdentifiers{xpath('AgencyIdentifiers')} := '';
END;