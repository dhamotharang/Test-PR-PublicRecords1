//////////////////////////////////////////////////////////////////////////////////////////////
// -- GetSegmentFileName_Base() function
// -- Pass it the segment code(ex, '0010') and it will return the Base filename for that segment
// -- from the segment_codes table
//////////////////////////////////////////////////////////////////////////////////////////////
export GetSegmentFileName_Base(string4 segment_code, string1 BaseType='B') := 
		if (BaseType='B',
					trim(FileName_Base) + trim(segment_code) + '_' + trim(decode_segments(segment_code)),
					trim(FileName_Base) + trim(segment_code) + '_' + trim(decode_segments(segment_code)) + '_AID'
				);