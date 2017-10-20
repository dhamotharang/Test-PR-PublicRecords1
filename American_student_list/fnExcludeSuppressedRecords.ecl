IMPORT ut;
EXPORT fnExcludeSuppressedRecords(DATASET(American_Student_List.Layout_American_Student_Base_v2) dBase) := FUNCTION
	
	asl_suppression := American_student_list.File_american_student_suppression.base;
	
	dBase_filtered	:= JOIN(DISTRIBUTE(dBase,HASH(z5, FULL_NAME)),
													DISTRIBUTE(asl_suppression,HASH(z5, FULL_NAME)),
													LEFT.FULL_NAME=RIGHT.FULL_NAME AND
													(ut.CleanSpacesAndUpper(TRIM(LEFT.ADDRESS_1)+' '+TRIM(LEFT.ADDRESS_2))=ut.CleanSpacesAndUpper(TRIM(RIGHT.ADDRESS_1)+' '+TRIM(RIGHT.ADDRESS_2)) OR
													 ut.CleanSpacesAndUpper(TRIM(LEFT.ADDRESS_1)+' '+TRIM(LEFT.ADDRESS_2))=ut.CleanSpacesAndUpper(TRIM(RIGHT.ADDRESS_2)+' '+TRIM(RIGHT.ADDRESS_1))) AND
													LEFT.CITY=RIGHT.CITY AND
													LEFT.STATE=RIGHT.STATE AND
													LEFT.Z5=RIGHT.Z5 AND
													LEFT.ZIP_4=RIGHT.ZIP_4,
													LEFT ONLY, LOCAL);
	RETURN dBase_filtered;
			
END;