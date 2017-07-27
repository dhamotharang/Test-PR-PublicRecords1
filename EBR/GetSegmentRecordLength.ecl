//////////////////////////////////////////////////////////////////////////////////////////////
// -- GetSegmentRecordLength() function
// -- Pass it the segment code(ex, '0010') and it will return the segment input record length
// -- from the segment_codes table
//////////////////////////////////////////////////////////////////////////////////////////////
export GetSegmentRecordLength(string4 segment_code) := FUNCTION
	return Segment_Codes(code = segment_code)[1].input_record_length;
end;
