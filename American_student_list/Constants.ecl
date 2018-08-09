import Data_Services;

export Constants := module
	// export thor_cluster            := Data_Services.Data_location.Prefix('american_student') + thor_cluster;
	export autokey_qa_keyname 							:= thor_cluster + 'key::american_student::autokey::qa::';
	export autokey_keyname									:= thor_cluster + 'key::american_student::autokey::@version@::';
	export autokey_logical(string filedate) := thor_cluster + 'key::american_student::' + filedate + '::autokey::';
	export autokey_typeStr  								:= '/AK/'; 
	export autokey_skipSet  								:= ['B','Q','F']; 

	// DF-21719 define fields to be deprecated in thor_data400::key::avm_v2::fcra::qa::address	
	export fields_to_clear := 'county_number,delivery_point_barcode,fips_county,gender,gender_code,head_of_household_first_name,head_of_household_gender,' +
                   'head_of_household_gender_code,income_level,income_level_code,new_income_level,new_income_level_code,telephone,title';
									 

end;