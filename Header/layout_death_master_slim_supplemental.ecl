EXPORT layout_death_master_slim_supplemental := RECORD
	HEADER.layout_death_master_supplemental AND NOT 
	[
		rawaid, 
		orig_address1, 
		orig_address2, 
		statefn, 
		ScrubsBits1, 
		ScrubsBits2, 
		ScrubsBits3
	];
END;