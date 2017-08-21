//****************Macro to eliminate bad phone numbers from a file********************
export Mac_Filter_Bad_Phones (file_in, phone_field,area_code_check = 0, tfree_phone_check = 1, file_out):= macro
#uniquename(invalid7)
#uniquename(invalid4)
#uniquename(invalidnxx1)
#uniquename(phone_length)
#uniquename(file_out1)
#uniquename(file_out2)

%invalid4% 	:= ['0000', '9999'];
%invalidnxx1%	:= ['0','1'];

%phone_length% := if(area_code_check = 0, 10, 7);

%file_out1% := file_in(
					//phone is not blank
					(string)phone_field != '' and 
					//phone has at least 7 numeric digits
					length(stringlib.stringfilter((string)phone_field,'0123456789')) >= %phone_length% and 
					//records does not repeat the same digit more than 6 times
					(unsigned)datalib.dedouble(phone_field[length(phone_field)- 6.. length(phone_field)]) > 9 and 
					 //last 4 digits are valid
					 phone_field[length(phone_field)- 3.. length(phone_field)] not in %invalid4% and 
					 //valid first digig of nxx
					 (string)phone_field[length((string)phone_field)-6.. length((string)phone_field)-6] not in %invalidnxx1%
					 )
					;
%file_out2% := %file_out1%(length((string)phone_field) = 10 and 
				    (string)phone_field[..3] not in phonesplus_v2.Translation_Codes.toll_free_area_codes	
					);

file_out := if(tfree_phone_check = 1, %file_out2%, %file_out1%);
endmacro;

