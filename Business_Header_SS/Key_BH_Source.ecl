IMPORT Business_Header, data_services;

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
	data_services.data_location.prefix() + 'thor_data400::key::business_header.src_' + business_header_ss.key_version);