IMPORT STD; 
/*
 * Encode binary data to base64 string.
 *
 * Every 3 data bytes are encoded to 4 base64 characters. If the length of the input is not divisible 
 * by 3, up to 2 '=' characters are appended to the output. 
 *
 *
 * @param value         The binary data array to process.
 * @return              Base 64 encoded string.
 */
 
/*
 * Decode base64 encoded string to binary data.
 *
 * If the input is not valid base64 encoding (invalid characters, or ends mid-quartet), an empty
 * result is returned. Whitespace in the input is skipped.
 *
 *
 * @param value        The base 64 encoded string.
 * @return             Decoded binary data if the input is valid else zero length data.
 */
 
EXPORT Base64 := MODULE
	EXPORT STRING encode_data(DATA str) := STD.Str.EncodeBase64(str) : DEPRECATED('Use STD.Str.EncodeBase64') ; 

	EXPORT STRING encode(UNICODE str, STRING enc = 'UTF-8') := encode_data(FROMUNICODE(str, enc));

	EXPORT DATA decode_data(STRING str) := STD.Str.DecodeBase64(str): DEPRECATED('Use STD.Str.EncodeBase64') ;  

	EXPORT UNICODE decode(STRING str, STRING enc = 'UTF-8') := TOUNICODE(decode_data(str), enc);
END;