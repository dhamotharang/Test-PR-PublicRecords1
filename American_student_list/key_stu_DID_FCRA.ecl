import Doxie;

file_in := American_student_list.File_american_student_DID_PH_Suppressed;

ASL_Key_Layout	
	:=
		RECORD
			American_student_list.layout_american_student_base and not [HISTORICAL_FLAG];
		END;
		
American_student_DID_base	:=	PROJECT(file_in((unsigned8)did<>0 AND HISTORICAL_FLAG = 'C'), ASL_Key_Layout);

export key_stu_DID_FCRA := index(American_student_DID_base, 
							{unsigned6 l_did := (unsigned)did},{American_student_DID_base},
							'~thor_data400::key::fcra::American_Student::' + Doxie.Version_SuperKey+'::DID');