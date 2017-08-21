
// temporary layout for intermediate files
EXPORT Layout_EPLS_Ex := RECORD,MAXLENGTH(4096)
	Layout_EPLS;
	integer	seqnum := 0;
	string	SAMNumber := '';
END;