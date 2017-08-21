IMPORT STD ; 

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
 
EXPORT STRING Decode64(STRING input) := (STRING)Std.Str.DecodeBase64(input) : DEPRECATED ('Use Std.Str.DecodeBase64 instead.') ; 
