IMPORT ut;
EXPORT fnStandardizeMajor(DATASET(Layout_Base.base) ds) := FUNCTION

	//Map OKC major to ASL college_major and new_college_major
	okc_college_major 		:= OKC_Student_List.File_College_Major_Mapping_In;

	OKC_Student_List.Layout_Base.base fnPopulateCollegeMajor(ds L, okc_college_major R) := TRANSFORM
		SELF.COLLEGE_MAJOR 	:= R.MAJOR_CODE;
		SELF.NEW_COLLEGE_MAJOR := R.NEW_MAJOR_CODE;
		SELF := L;
	END;
	new_ds:= JOIN(ds, okc_college_major,
								TRIM(LEFT.Major)=ut.CleanSpacesAndUpper(RIGHT.MAJOR),
								fnPopulateCollegeMajor(LEFT,RIGHT),
								LEFT OUTER, LOOKUP);
	RETURN new_ds;
	
END;