import Business_Header;

Layout_Business_Contacts_Stats_Plus1 := RECORD
	Business_Header.Layout_Business_Contacts_Stats;
	UNSIGNED8 __thisfilepos {virtual(fileposition)};
END;

export File_Prep_Bus_Contacts_Stats_Plus := 
dataset(filenames().base.PeopleAtWorkStats.built, Layout_Business_Contacts_Stats_Plus1, flat);
