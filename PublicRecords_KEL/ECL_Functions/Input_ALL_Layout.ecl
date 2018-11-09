IMPORT PublicRecords_KEL;
//Includes all the cleaned and specified non-cleaned input

EXPORT Input_ALL_Layout := RECORD
	PublicRecords_KEL.ECL_Functions.Input_UnCleaned_Layout;
	PublicRecords_KEL.ECL_Functions.Input_Cleaned_Layout;
	INTEGER RepNumber;
END;