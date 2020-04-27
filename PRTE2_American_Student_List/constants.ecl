import prte2, american_student_list;

EXPORT constants := module

EXPORT keyname                      := prte2.Constants.prefix + 'key::american_student::'; 
EXPORT keyname_fcra                 := prte2.Constants.prefix + 'key::fcra::american_student::'; 

EXPORT SuperKeyName 						    := keyname +'@version@::';
EXPORT SuperKeyName_FCRA 				    := keyname_FCRA+'@version@::';

export autokey_qa_keyname 					:= prte2.Constants.prefix+ 'autokey::qa::';
EXPORT ak_keyname                   := keyname +'autokey::@version@::'; 
EXPORT ak_logical(string filedate)  := keyname + filedate + '::autokey::'; 
export autokey_typeStr  						:= '/AK/'; 
export autokey_skipSet  						:= ['B','Q','F']; 
export dops_name                    :='AmericanstudentKeys';
export fcra_dops_name               :='FCRA_AmericanstudentKeys';

//DF-21719 define fields to be deprecated in thor_data400::key::avm_v2::fcra::qa::address	
//export fields_to_clear := american_student_list.Constants.fields_to_clear;
Export fields_to_clear := 'county_number,delivery_point_barcode,fips_county,gender,gender_code,head_of_household_first_name,head_of_household_gender,' +
                   'head_of_household_gender_code,income_level,income_level_code,new_income_level,new_income_level_code,telephone,title';								 
 
									 

END;