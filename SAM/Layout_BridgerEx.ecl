// need sequence number
EXPORT Layout_BridgerEx := RECORD
	Layout_Bridger;
	integer	seqnum := 0;
	string	SAMNumber := '';
END;