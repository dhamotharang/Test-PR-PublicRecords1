//////////////////////////////////////////////////////////////////////////////////////////////
// -- GetSegmentKeyName_BDID() function
// -- Pass it the segment code(ex, '0010') and it will return the BDID Keyname for that segment
// -- from the segment_codes table
//////////////////////////////////////////////////////////////////////////////////////////////
export GetSegmentKeyName_BDID(string4 segment_code) := 
	trim(KeyName_root) + trim(segment_code) + '_' + trim(decode_segments(segment_code)) + '.bdid';
