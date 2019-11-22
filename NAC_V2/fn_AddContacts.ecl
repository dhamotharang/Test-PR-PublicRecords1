IMPORT Std;

Layout_Base2 xContact($.Layout_Base2 src, $.Layouts2.rStateContactEx contact) := TRANSFORM
		// fill in contact fields, but do not overwrite if there is a more specific contact
		boolean ignore := src.ContactName <> '';
		self.ContactName := if(ignore, src.ContactName, contact.ContactName);
		self.ContactPhone := if(ignore, src.ContactPhone, contact.ContactPhone);
		self.ContactExt := if(ignore, src.ContactExt, contact.ContactExt);
		self.ContactEmail := if(ignore, src.ContactEmail, contact.ContactEmail);
		
		self := src;
		
END;

EXPORT fn_AddContacts(DATASET($.layout_Base2) base, 
			DATASET($.Layouts2.rStateContactEx) contacts = $.Files2.dsContactRecords)
		:= FUNCTION
		b1 := DISTRIBUTE(base);	//, HASH64(ProgramState, ProgramCode));
		c1 := contacts(UpdateType<>'D');	//, HASH64(ProgramState, ProgramCode));
		// add client specific contacts
		b2 := IF(EXISTS(c1(clientId<>'')),		
						JOIN(b1, c1(clientId<>''),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.ClientId=right.ClientId,
							xContact(LEFT,RIGHT),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						b1);
	// add case specific contacts
		b3 := IF(EXISTS(c1(CaseId<>'')),		
						JOIN(b2, c1(CaseId<>''),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.CaseId=right.CaseId,
							xContact(LEFT,RIGHT),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						b2);
	// add county contacts
		b4 := IF(EXISTS(c1(ProgramCounty<>'')),		
						JOIN(b3, c1(ProgramCounty<>''),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.CountyName=right.ProgramCounty,
							xContact(LEFT,RIGHT),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						b3);
	// add regional contacts
		b5 := IF(EXISTS(c1(ProgramRegion<>'')),		
						JOIN(b4, c1(ProgramRegion<>''),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.RegionCode=right.ProgramRegion,
							xContact(LEFT,RIGHT),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						b4);
	// add default contact
		b6 := JOIN(b5, c1(ClientId='',CaseId='',ProgramCounty='',ProgramRegion=''),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode,
							xContact(LEFT,RIGHT),
							LEFT OUTER, KEEP(1), MANY LOOKUP);

	return b6;
END;