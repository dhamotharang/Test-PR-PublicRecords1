export Proc_Preprocess(string filedate) := function

	// read the csv file
	codesv3csv := dataset('~thor_data400::base::codes_v3_csv',codes.layout_codes_csv,csv(separator('\t'), quote([]), maxlength(8192)));
	
	// convert to fixed length for records that have desc length < 121
	codes.Layout_Codes_V3 proj_codes(codesv3csv l) := transform
		self.file_name := Stringlib.StringToUpperCase(trim(l.file_name,left,right));
		self.field_name := Stringlib.StringToUpperCase(trim(l.field_name2,left,right));
		self.field_name2 := trim(l.field_name,left,right);
		self.code := trim(l.code,left,right);
		self.long_flag := 'N';
		self.long_desc := trim(l.desc,left,right);
		
	end;

	proj_codes_lt_121 := project(codesv3csv(length(trim(desc,left,right)) < 121),proj_codes(left));
	
	// convert to fixed length for records that have desc length > 121
	codes.Layout_Codes_V3 proj_codes_121(codesv3csv l) := transform
		self.file_name := Stringlib.StringToUpperCase(trim(l.file_name,left,right));
		self.field_name := Stringlib.StringToUpperCase(trim(l.field_name2,left,right));
		self.field_name2 := trim(l.field_name,left,right);
		self.code := trim(l.code,left,right);
		self.long_flag := 'Y';
		self.long_desc := trim(l.desc,left,right);
	end;

	proj_codes_gt_121 := project(codesv3csv(length(trim(desc,left,right)) >= 121),proj_codes_121(left));

	// Concate both
	proj_codes_full := proj_codes_lt_121 + proj_codes_gt_121;
	
	return proj_codes_full;
	
end;