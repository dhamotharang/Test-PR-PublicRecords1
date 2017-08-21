export File_AutonomyNames := MODULE

export layout := RECORD
  UNSIGNED4 seqNo;
  UNSIGNED4 nameNo;
  STRING60 fname;
  STRING60 mname;
  STRING60 lname;
  STRING10 type;
  STRING120 cname;
END;

export records := 
	dataset(
		'~thor_data400::in::autonomy_names',
		layout,
		csv(
			separator('\t'), 
			terminator('\n'), 
			quote('')
		)
	);
	
	export keyed_records := INDEX(records, 
																{ seqNo }, 
																{ nameNo, type, fname, mname, lname, cname }, 
																'~thor_data400::in::autonomy_names_key');

	export keyed_layout := RECORD
		keyed_records.seqNo;
		keyed_records.nameNo;
		keyed_records.type;
		keyed_records.fname;
		keyed_records.mname;
		keyed_records.lname;
		keyed_records.cname;
	END;
	
END; 