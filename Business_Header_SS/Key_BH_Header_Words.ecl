IMPORT Business_Header, data_services;

wf := business_header_ss.File_BH_CompanyNameWords;

Layout_Header_Word_Index_Index := RECORD
	wf.word;
	wf.state;
	wf.seq;
	wf.bh_filepos;
	wf.bdid;
	wf.__filepos;
END;
	
// The index contains all the fields in the file -- the file itself is never
// referenced through the index.
EXPORT Key_BH_Header_Words := INDEX(
	wf, Layout_Header_Word_Index_Index, 
	data_services.data_location.prefix() + 'thor_data400::key::business_header.CoNameWords_' + business_header_ss.key_version, OPT);