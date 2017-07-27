import emerges, FFD;

export layout_ccw_records := record
	unsigned2 penalt;
	eMerges.layout_ccw_out and not [process_date, unique_id, persistent_record_id];
//	unsigned integer8 __filepos; // this is the only real change, will be removed when proved to be correct.
	unsigned6	did;
	string10	gender_mapped := '';
	string10	race_mapped := '';
	string10	source_state_name := '';
	FFD.Layouts.CommonRawRecordElements;
end;