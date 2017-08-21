Import Data_Services, Doxie;

file_in := American_student_list.File_american_student_DID_PH_Suppressed;

ASL_Key_Layout	
	:=
		RECORD
			American_student_list.layout_american_student_base and not [HISTORICAL_FLAG,source];
		END;
		
American_student_DID_base	:=	PROJECT(file_in((unsigned8)did<>0 AND HISTORICAL_FLAG = 'C'), transform(ASL_Key_Layout,
	self.income_level := '';
	self.income_level_code := '',
	self := left));
	
export key_stu_DID_FCRA := index(American_student_DID_base, 
							{unsigned6 l_did := (unsigned)did},{American_student_DID_base},
							Data_Services.Data_location.Prefix('american_student')+'thor_data400::key::fcra::American_Student::' + Doxie.Version_SuperKey+'::DID');