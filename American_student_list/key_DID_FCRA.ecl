Import Data_Services, American_student_list, Doxie;

file_in := American_student_list.File_american_student_DID_PH_Suppressed_v2;

American_student_DID_base	:=	PROJECT(file_in((unsigned8)did<>0), transform(American_student_list.layout_american_student_base_v2,
	self.income_level := '';
	self.income_level_code := '',
	self.new_income_level := '';
	self.new_income_level_code := '',
	self := left));

export key_DID_FCRA := index(American_student_DID_base, 
                            {unsigned6 l_did := (unsigned)did},{American_student_DID_base},
				            Data_Services.Data_location.Prefix('american_student')+'thor_data400::key::fcra::American_Student::' + Doxie.Version_SuperKey+'::DID2');
										
										
								