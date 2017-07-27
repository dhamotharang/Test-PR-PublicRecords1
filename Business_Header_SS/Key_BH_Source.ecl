IMPORT Business_Header;

bh := Business_Header.File_Business_Header_Plus;

layout_src_seq := RECORD
	bh.source;
	UNSIGNED6 seq;
	bh.state;
	bh.__filepos;
END;

EXPORT Key_BH_Source := INDEX(
	bh,
	layout_src_seq,
	'~thor_data400::key::business_header.src_' + business_header_ss.key_version);