Layout_Business_Contacts_Stats_Plus1 := RECORD
	Layout_Business_Contacts_Stats;
	UNSIGNED8 __thisfilepos {virtual(fileposition)};
END;

export File_Prep_Business_Contacts_Stats_Plus := 
dataset(filenames().base.PeopleAtWorkStats.built, Layout_Business_Contacts_Stats_Plus1, flat);
