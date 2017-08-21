import ut;
//file_crim_header_full:= dataset(ut.foreign_prod +'~thor_data400::base::crim_header',crim_header.layout_crim_header,flat);
file_crim_header_full:= dataset('~thor_data400::base::crim_header',crim_header.layout_crim_header,flat);

export file_crim_header := 
	file_crim_header_full(vendor not in bad_vendors and  (lname<>'' or fname<>'' or mname<>''));
