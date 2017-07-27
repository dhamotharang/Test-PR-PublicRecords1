import business_header_ss;
f_br := Business_Header.File_Business_Relatives;

EXPORT Key_Business_Relatives := INDEX(f_br,
	{f_br.bdid1}, {f_br}, 
	'~thor_data400::key::business_header.BusinessRelatives_' + business_header_ss.key_version);