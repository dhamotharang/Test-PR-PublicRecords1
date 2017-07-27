f_brg := Business_Header.File_Prep_Business_Relatives_Group_Plus;

layout_business_relative_group_index := RECORD
	f_brg.group_id;
	f_brg.__filepos;
END;

EXPORT Key_Prep_Business_Relatives_Group := INDEX(f_brg,
	{f_brg.group_id}, {f_brg},
	'~thor_data400::key::business_header.Business_Relatives_Group' + thorlib.wuid());