import codes ; 
/*export fn_codesv3_desc(infile,inlayout,outfile,filename_val,fieldname_incodesv3,desc_field,code_field) := macro
	
	#uniquename(file_codes)
	// filter filename
	%file_codes% := Codes.File_Codes_V3_In(file_name = filename_val);
	
	#uniquename(get_codes)
	inlayout %get_codes%(infile l,%file_codes% r) := transform
		self.desc_field := r.long_desc;
		self := l;
	end;
	
	outfile := join(infile,%file_codes% ,fieldname_incodesv3 = right.field_name 
	                                    and left.vendor_source_flag = right.field_name2[1]
										and left.code_field = right.code,
										%get_codes%(left,right),
										left outer,
										lookup
										
										);
	
endmacro; */

export fn_codesv3_desc(string field_namecv3,string code_field, string file_name_val,string vendor) := function 

file_in  := Codes.File_Codes_V3_In(file_name = file_name_val);
file_desc := file_in(field_name = field_namecv3 ,code = code_field, field_name2[1]=vendor); 

return  file_desc[1].long_desc;
END ;


