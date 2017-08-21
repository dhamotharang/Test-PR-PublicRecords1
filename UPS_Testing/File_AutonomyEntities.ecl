export File_AutonomyEntities := MODULE

export layout := RECORD
  UNSIGNED4 seqNo;
  UNSIGNED4 respNo;
  UNSIGNED4 queryNo;
  DECIMAL3_2 score;
END;

export records := 
	dataset(
		'~thor_data400::in::autonomy_entities', 
		layout,
		csv(
			separator('\t'), 
			terminator('\n'), 
			quote('')
		)
	);
	
	export keyed_records := INDEX(records, 
																{ queryNo }, 
																{seqNo, respNo, Score}, 
																'~thor_data400::in::autonomy_entities_key');
	export keyed_layout := RECORD
		keyed_records.queryNo;
		keyed_records.seqNo;
		keyed_records.respNo;
		keyed_records.Score;
	END;
END; 