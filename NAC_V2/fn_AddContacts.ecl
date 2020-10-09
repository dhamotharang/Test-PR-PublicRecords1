IMPORT Std;

Layout_Base2 xContact($.Layout_Base2 src, $.Layouts2.rStateContactEx contact) := TRANSFORM
		// fill in contact fields, but do not overwrite if there is a more specific contact
		boolean ignore := contact.ContactName='' AND contact.ContactPhone='' AND contact.ContactEmail='';
		self.ContactName := IF(ignore, src.ContactName, contact.ContactName);
		self.ContactPhone := IF(ignore, src.ContactPhone, contact.ContactPhone);
		self.ContactExt := IF(ignore, src.ContactExt, contact.ContactExt);
		self.ContactEmail := IF(ignore, src.ContactEmail, contact.ContactEmail);
		
		self := src;
		
END;

EXPORT fn_AddContacts(DATASET($.layout_Base2) base, 
			DATASET($.Layouts2.rStateContactEx) contacts = $.Files2.dsContactRecords)
		:= FUNCTION
		
		//b1 := DISTRIBUTE(base, hash32(GroupId));
		//c1 := DISTRIBUTE(contacts(UpdateType<>'D'), hash32(GroupId));
		c1 := contacts(UpdateType<>'D');
		
	// add default contact
		b2 := IF(EXISTS(c1(ClientId='',CaseId='',ProgramCounty='',ProgramRegion='')),
			JOIN(base, c1(ClientId='',CaseId='',ProgramCounty='',ProgramRegion=''),
								left.GroupId=right.GroupId
								and left.ProgramState=right.ProgramState
								and left.ProgramCode=right.ProgramCode,
								xContact(LEFT,RIGHT),
								LEFT OUTER, LOOKUP),
						base);
							
	// add regional contacts
		b3 := IF(EXISTS(c1(ProgramRegion<>'')),		
						JOIN(b2, c1(ProgramRegion<>''),
							left.GroupId=right.GroupId
							and left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.RegionCode=right.ProgramRegion,
							xContact(LEFT,RIGHT),
							LEFT OUTER, LOOKUP),
						b2);

	// add county contacts
		b4 := IF(EXISTS(c1(ProgramCounty<>'')),		
						JOIN(b3, c1(ProgramCounty<>''),
							left.GroupId=right.GroupId
							and left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.CountyName=right.ProgramCounty,
							xContact(LEFT,RIGHT),
							LEFT OUTER, LOOKUP),
						b3);
						
	// add case specific contacts
		b5 := IF(EXISTS(c1(CaseId<>'')),		
						JOIN(b4, c1(CaseId<>''),
							left.GroupId=right.GroupId
							and left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.CaseId=right.CaseId,
							xContact(LEFT,RIGHT),
							LEFT OUTER, LOOKUP),
						b4);
		
		// add client specific contacts
		b6 := IF(EXISTS(c1(clientId<>'')),		
						JOIN(b5, c1(clientId<>''),
							left.GroupId=right.GroupId
							and left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.ClientId=right.ClientId,
							xContact(LEFT,RIGHT),
							LEFT OUTER, LOOKUP),
						b5);

	return b6;
END;