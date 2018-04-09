Import Data_Services, American_student_list, Doxie, ut;

file_in := American_student_list.File_american_student_DID_PH_Suppressed_v2;

American_student_DID_base	:=	PROJECT(file_in((unsigned8)did<>0), transform(American_student_list.layout_american_student_base_v2,
	self.income_level := '';
	self.income_level_code := '',
	self.new_income_level := '';
	self.new_income_level_code := '',
	Self.collegeupdate :=	'';
	self := left));

//DF-21487 blank out following field in thor_data400::key::avm_v2::fcra::qa::address
fields_to_clear := 'county_number,delivery_point_barcode,fips_county,gender,gender_code,head_of_household_first_name,head_of_household_gender,' +
                   'head_of_household_gender_code,income_level,income_level_code,new_income_level,new_income_level_code,telephone,title';
ut.MAC_CLEAR_FIELDS(American_student_DID_base, American_student_DID_base_cleared, fields_to_clear);

export key_DID_FCRA := index(American_student_DID_base_cleared, 
                            {unsigned6 l_did := (unsigned)did},{American_student_DID_base_cleared},
				            Data_Services.Data_location.Prefix('american_student')+'thor_data400::key::fcra::American_Student::' + Doxie.Version_SuperKey+'::DID2');
										
										
								