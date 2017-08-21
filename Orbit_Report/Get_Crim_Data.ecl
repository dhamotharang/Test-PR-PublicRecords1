export Get_Crim_Data(myds,in_field_name,statefield,dtype='\'none\'',retval,countyfield='\'none\'',isstatecode='true') := macro

#uniquename(combo_rec)
%combo_rec% := record
	string instate := '';
	string filing_date := '';
	string county_name := countyfield;
	string date_type := dtype;
end;

#uniquename(proj_combo)
#if (countyfield = 'none')
	%combo_rec% %proj_combo%(myds l) := transform
		self.instate := l.statefield;
		self.county_name := 'none';
		self.filing_date := l.in_field_name;
		self := l;
	end;
#else
	%combo_rec% %proj_combo%(myds l) := transform
		self.instate := l.statefield;
		self.county_name := l.county_name;
		self.filing_date := l.in_field_name;
		self := l;
	end;
#end

#uniquename(retval_pre)
%retval_pre% := project(myds,%proj_combo%(left));

#uniquename(codesds)
%codesds% := Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG');


#uniquename(get_st_code)
%combo_rec% %get_st_code%(%retval_pre% l, %codesds% r) := transform
	self.instate := r.code;
	self := l;
end;

retval := if (isstatecode,%retval_pre%,
								join(%retval_pre%,%codesds%,
											trim(left.instate,left,right) = trim(right.long_desc,left,right),
											%get_st_code%(left,right),
											left outer,
											lookup
											)
									);



endmacro;

