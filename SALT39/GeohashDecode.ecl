/*
  Decode a hash string into pair of latitude and longitude. A single record dataset is returned.
*/
DecodedHash := RECORD
	REAL latitude;
	REAL longitude;
	REAL latitude_err;
	REAL longitude_err;
END;
EXPORT DATASET(DecodedHash) GeohashDecode(STRING hash_string) := 
	saltlib.GeohashDecode(hash_string);
