Import Data_Services, American_student_list, Doxie, ut;

file_in := American_student_list.File_american_student_DID_PH_Suppressed_v2;

American_student_DID_base	:=	PROJECT(file_in((unsigned8)did<>0), transform(American_student_list.layout_american_student_base_v2,
	self.income_level := '';
	self.income_level_code := '',
	self.new_income_level := '';
	self.new_income_level_code := '',
	Self.collegeupdate :=	'';
	self := left));

//DF-21719 blank out specified fields in thor_data400::key::avm_v2::fcra::qa::address
ut.MAC_CLEAR_FIELDS(American_student_DID_base, American_student_DID_base_cleared, American_Student_List.Constants.fields_to_clear);

export key_DID_FCRA := index(American_student_DID_base_cleared, 
                            {unsigned6 l_did := (unsigned)did},{American_student_DID_base_cleared},
				            Data_Services.Data_location.Prefix('american_student')+'thor_data400::key::fcra::American_Student::' + Doxie.Version_SuperKey+'::DID2');
										
										
								