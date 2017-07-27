IMPORT Business_Header;

f_bh := business_header.File_Prep_Business_Header_Plus;

layout_bdid_index := RECORD
	f_bh.bdid;
	f_bh.__filepos;
END;

EXPORT Key_Prep_BH_BDID := INDEX(
	f_bh, layout_bdid_index, 
	'~thor_data400::key::business_header.BDID' + thorlib.wuid());