import data_services;
f_br := Business_Header.File_Prep_Business_Relatives_Plus;

layout_business_relative_index := RECORD
	f_br.bdid1;
	f_br.__filepos;
END;

EXPORT Key_Prep_Business_Relatives := INDEX(f_br,
	{f_br.bdid1}, {f_br}, 
	data_services.data_location.prefix() + 'thor_data400::key::business_header.BusinessRelatives' + thorlib.wuid());