Layout_Business_Contacts_Stats_Plus := RECORD
	Layout_Business_Contacts_Stats;
	UNSIGNED8 __thisfilepos {virtual(fileposition)};
END;

EXPORT File_Business_Contacts_Stats_Plus := DATASET(
	'~thor_data400::BASE::People_At_Work_Stats_built',
	Layout_Business_Contacts_Stats_Plus,
	THOR);