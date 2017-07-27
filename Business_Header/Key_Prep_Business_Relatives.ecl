f_br := Business_Header.File_Prep_Business_Relatives_Plus;

layout_business_relative_index := RECORD
	f_br.bdid1;
	f_br.__filepos;
END;

EXPORT Key_Prep_Business_Relatives := INDEX(f_br,
	{f_br.bdid1}, {f_br}, 
	'~thor_data400::key::business_header.BusinessRelatives' + thorlib.wuid());