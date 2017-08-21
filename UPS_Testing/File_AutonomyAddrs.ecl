export File_AutonomyAddrs := MODULE

	export layout := RECORD
		UNSIGNED4 seqNo;
		UNSIGNED4 addrNo;
		STRING120 street;
		STRING60 city;
		STRING2 state;
		STRING12 zip;
		STRING16 reported_date;
	END;

	export records := dataset('~thor_data400::in::autonomy_addrs',
														layout,
														csv(separator('\t'), terminator('\n'), quote('')));
													
	export keyed_records := INDEX(records,
																{seqNo},
																{addrNo, street, city, state, zip, reported_date},
																'~thor_data400::in::autonomy_addrs_key');
	export keyed_layout := RECORD
		keyed_records.seqNo;
		keyed_records.addrNo;
		keyed_records.street;
		keyed_records.city;
		keyed_records.state;
		keyed_records.zip;
		keyed_records.reported_date;
	END;
END; 