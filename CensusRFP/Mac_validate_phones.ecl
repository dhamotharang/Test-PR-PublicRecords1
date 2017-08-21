//****************Macro to eliminate bad phone numbers from a file********************
export Mac_validate_Phones(file_in, phone_field,area_code_check = 0, tfree_phone_check = 1, file_out):= macro
#uniquename(invalid7)
#uniquename(invalid4)
#uniquename(invalidnxx1)
#uniquename(phone_length)
#uniquename(file_out1)
#uniquename(file_out2)

%invalid4% 	:= ['0000', '9999'];
%invalidnxx1%	:= ['0','1'];

%phone_length% := if(area_code_check = 0, 10, 7);

%file_out1% := project(file_in, transform(recordof(file_in),
					//phone is not blank
					self.phone_field := if((string)left.phone_field != '' and 
					//phone has at least 7 numeric digits
					length(stringlib.stringfilter((string)left.phone_field,'0123456789')) >= %phone_length% and 
					//records does not repeat the same digit more than 6 times
					(unsigned)datalib.dedouble(left.phone_field[length(left.phone_field)- 6.. length(left.phone_field)]) > 9 and 
					 //last 4 digits are valid
					 left.phone_field[length(left.phone_field)- 3.. length(left.phone_field)] not in %invalid4% and 
					 //valid first digig of nxx
					 (string)left.phone_field[length((string)left.phone_field)-6.. length((string)left.phone_field)-6] not in %invalidnxx1%
					, left.phone_field, '' ), self := left));
					
%file_out2% := project(%file_out1%, transform(recordof(file_in),
          self.phone_field := if(length((string)left.phone_field) = 10 and 
				    (string)left.phone_field[..3] not in phonesplus_v2.Translation_Codes.toll_free_area_codes,
						left.phone_field, ''), self := left));
					

file_out := if(tfree_phone_check = 1, %file_out2%, %file_out1%);
endmacro;

