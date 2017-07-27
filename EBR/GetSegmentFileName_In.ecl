//////////////////////////////////////////////////////////////////////////////////////////////
// -- GetSegmentFileName_In() function
// -- Pass it the segment code(ex, '0010') and it will return the input filename for that segment
// -- from the segment_codes table
//////////////////////////////////////////////////////////////////////////////////////////////
export GetSegmentFileName_In(string4 segment_code) :=
	trim(FileName_in) + trim(segment_code) + '_' + trim(decode_segments(segment_code));