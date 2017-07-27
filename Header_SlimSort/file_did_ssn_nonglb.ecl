slim_rec_plus := 
RECORD
	unsigned6	did;
	qstring9 	ssn;
	QSTRING4 	ssn4;
	unsigned2 	cnt;
	unsigned2 	freq;
	unsigned8 	__fpos {virtual(fileposition)};
END;


export file_did_ssn_nonglb := dataset('~thor_data400::base::did_ssn_nonglb' + header_slimsort.version,slim_rec_plus,flat);