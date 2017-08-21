fn_NibbleToHexString(UNSIGNED1 n) := FUNCTION
	return MAP (n = 0 => '0',
						n = 1 => '1',
						n = 2 => '2',
						n = 3 => '3',
						n = 4 => '4',
						n = 5 => '5',
						n = 6 => '6',
						n = 7 => '7',
						n = 8 => '8',
						n = 9 => '9',
						n = 10 => 'A',
						n = 11 => 'B',
						n = 12 => 'C',
						n = 13 => 'D',
						n = 14 => 'E',
						n = 15 => 'F',
						' ');
END;

STRING2 fn_ByteToHexString(UNSIGNED1 b) := FUNCTION
	UNSIGNED1 lowNibble := b % 16;
	UNSIGNED1 highNibble := (UNSIGNED1) (b / 16);

	lowNibbleHex := fn_NibbleToHexString(lowNibble);
	highNibbleHex := fn_NibbleToHexString(highNibble);
	resp := (STRING2) (highNibbleHex + lowNibbleHex);

// output(DATASET( [ {b, lowNibble, highNibble, lowNibbleHex, highNibbleHex, resp} ],
									// { UNSIGNED1 b, UNSIGNED1 low, UNSIGNED1 high, STRING1 lowHex, STRING1 highHex, STRING2 response } ), 
									// named('ByteToHex'), extend);

	return resp;
END;

export STRING4 fn_UNSIGNED2toHex(UNSIGNED2 val) := FUNCTION

	UNSIGNED1 lowByte := val % 256;
	UNSIGNED1 highByte := val / 256;
	
	lowByteHex := fn_ByteToHexString(lowByte);	
	highByteHex := fn_ByteToHexString(highByte);

	STRING4 rval := (STRING4) (highByteHex + lowByteHex);

	return rval;
END;

