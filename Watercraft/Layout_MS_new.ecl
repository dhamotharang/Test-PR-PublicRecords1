EXPORT Layout_MS_new := 
record
string3		STATEABREV;
string22	REG_NUM;
string23	HULL_ID;
string15	PROP;
string15	VEH_TYPE;
string10	FUEL;
string10	HULL;
string15	USE_1;
string25	MAKE;
string5		TOTAL_INCH;
string8		REG_DATE;
string4		YEAR;
string100	NAME;
string50	FIRST_NAME;
string15	MID;
string50	LAST_NAME;
string75	ADDRESS_1;
string30	CITY;
string2		STATE;
string10	ZIP;
string50	COUNTY;
string5		FIPS;
string8		TRANSACTION_DATE;
string8		EXPIRATION_DATE;
// string18	BOAT_TYPE_CODE;						//DF-19984 - Layout change, deleted
// string6		STATUS;											//DF-19984 - Layout change, deleted
string6		SUFFIX;													//DF-19984 - Layout change, new field
string2		lf;
end;