EXPORT JPEG_V2(integer8 len) := TYPE
	 EXPORT data load(data dd) := dd[1..len];
	 EXPORT integer8 physicallength(data dd) := len;
	 EXPORT data store(data dd) := dd[1..len];
	END;
