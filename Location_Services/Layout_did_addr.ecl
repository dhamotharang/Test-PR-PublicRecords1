import doxie, doxie_raw;

export Layout_did_addr := RECORD
	unsigned6 did;
	doxie_raw.Layout_address_input;
END;