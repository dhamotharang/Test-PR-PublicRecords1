import American_student_list,Data_Services;

file_in := American_student_list.File_american_student_DID_PH_Suppressed_v2(DID != 0);

ASL_Key_Layout := RECORD
	American_student_list.layout_american_student_base_v2;			//DF-19996
	unsigned1 zero := 0;
	string1		blank	:=	'';
END;

asl_base := PROJECT(file_in, ASL_Key_Layout);
export File_american_student_Autokeys := asl_base;