IMPORT ut, PromoteSupers, _control, VersionControl;
EXPORT Proc_build_suppression(STRING filedate, STRING filename='AS*SUPP*.TXT') := FUNCTION

	server_dir := '/data/data_build_1/american_student/data/';
	server_group := VersionControl.GroupName('44');
	//Spray the new input file
	American_student_list.Mac_Spray_american_student_suppression(filedate,filename,server_dir,
																															 _control.IPAddress.bctlpedata11,server_group,'Y',SpraySuppressed);

	new := American_student_list.File_american_student_suppression.raw;
	
	//Clean/setup input fields
	American_student_list.Layout_american_student_suppression.base txPrepNewData(new L) := TRANSFORM
		SELF.DATE_FIRST_SEEN	:= (UNSIGNED4) filedate;
		SELF.DATE_LAST_SEEN	:= (UNSIGNED4) filedate;
		SELF.DATE_VENDOR_FIRST_REPORTED	:= (UNSIGNED4) filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= (UNSIGNED4) filedate;
		SELF.RCID := 0;
		SELF.FULL_NAME := ut.CleanSpacesAndUpper(L.FULL_NAME);
		SELF.ADDRESS_1 := ut.CleanSpacesAndUpper(L.ADDRESS_1);
		SELF.ADDRESS_2 := '';
		SELF.CITY := ut.CleanSpacesAndUpper(L.CITY);;
		SELF.STATE := ut.CleanSpacesAndUpper(L.STATE);;
		SELF := L;
	END;
	
	new_prepped	:= PROJECT(new,txPrepNewData(LEFT));
	
	base := American_student_list.File_american_student_suppression.base;

	new_base				:= American_student_list.Ingest_ASL_Suppression(,,base,new_prepped).AllRecords_NoTag;
	base_file_name := '~thor_data400::base::american_student_list_suppression';
	PromoteSupers.Mac_SF_BuildProcess(new_base,base_file_name,build_base,2,,true);
	

/*
	//Append new suppressed records to the existing one and dedup
	new := American_student_list.File_american_student_suppression.raw;
	
	ut.CleanSpacesAndUpper
	
	base := American_student_list.File_american_student_suppression.base;

	American_student_list.Layout_american_student_suppression.base txPrepNewData(new L) := TRANSFORM
		SELF.DATE_FIRST_SEEN	:= (UNSIGNED4) filedate;
		SELF.DATE_LAST_SEEN	:= (UNSIGNED4) filedate;
		SELF.DATE_VENDOR_FIRST_REPORTED	:= (UNSIGNED4) filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= (UNSIGNED4) filedate;
		SELF.RCID := 0;
		SELF.FULL_NAME := ut.CleanSpacesAndUpper(L.FULL_NAME);
		SELF.ADDRESS_1 := ut.CleanSpacesAndUpper(L.ADDRESS_1);
		SELF.ADDRESS_2 := '';
		SELF.CITY := ut.CleanSpacesAndUpper(L.ADDRESS_1);;
		SELF.STATE := ut.CleanSpacesAndUpper(L.STATE);;
		SELF := L;
	END;
	
	base_new	:= base + PROJECT(new,txPrepNewData(LEFT));
*/
		
	
	RETURN SEQUENTIAL(SpraySuppressed, build_base);
	
END;