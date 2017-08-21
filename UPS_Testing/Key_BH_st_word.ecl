IMPORT Business_Header_SS;

wf := business_header_ss.File_BH_CompanyNameWords;

layout := RECORD
	wf.state;
	wf.word;
	// wf.seq;
	// wf.bh_filepos;
	wf.bdid;
	// wf.__filepos;
END;
	
// The index contains all the fields in the file -- the file itself is never
// referenced through the index.
EXPORT Key_BH_st_word := INDEX( wf, layout, 
																'~thor400_88_staging::jcwtemp::key::business_header.st_word_' + business_header_ss.key_version, OPT);