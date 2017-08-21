EXPORT LAYOUT_WI_new := MODULE
EXPORT raw := 
  record
STRING3	STATEABREV;
STRING22	REG_NUM;
STRING23	HULL_ID;
STRING15	PROP;
STRING15	VEH_TYPE;
STRING10	FUEL;
STRING10	HULL;
STRING15	USE_1;
STRING25	MAKE;
STRING5	TOTAL_INCH;
STRING8	REG_DATE;
STRING4	YEAR;
STRING100	NAME;
STRING50	FIRST_NAME;
STRING15	MID;
STRING50	LAST_NAME;
STRING75	ADDRESS_1;
STRING30	CITY;
STRING2	  STATE;
STRING10	ZIP;
STRING50	COUNTY;
STRING5	FIPS;
STRING7	REG_STATUS;
STRING34	REG_TYPE_CODE;
STRING4	EXPIRE_YEAR;
STRING8	EXPIRATION_DATE;
STRING14	COUNTY_KEPT;
STRING7	  CGID;
STRING32	VERIFIED;// HULL_ID_VERIFY_METHOD
STRING20	MODEL;
STRING10	ENGINE_TYPE;//ENGINE_DRIVE_TYPE
STRING17	BOATNAME;
STRING19	PORTNAME;
STRING8	  PUR_DATE;
STRING3	  NODISCLOSURE;
STRING4	  DOB;
STRING52	BUSINESS;
STRING4	  SUFFIX;
STRING13	COUNTRY_NAME;
STRING8	  LAST_TRANSACTION_DATE;//TXN_TIMESTAMP
STRING2	LF;
END;


EXPORT common := 
  record
STRING3	  STATEABREV;
STRING22	REG_NUM;
STRING23	HULL_ID;
STRING15	PROP;
STRING15	VEH_TYPE;
STRING10	FUEL;
STRING10	HULL;
STRING15	USE_1;
STRING25	MAKE;
STRING5	TOTAL_INCH;
STRING8	REG_DATE;
STRING4	YEAR;
STRING100	NAME;
STRING50	FIRST_NAME;
STRING15	MID;
STRING50	LAST_NAME;
STRING75	ADDRESS_1;
STRING30	CITY;
STRING2	  STATE;
STRING10	ZIP;
STRING50	COUNTY;
STRING5	FIPS;
STRING7	REG_STATUS;
STRING34	REG_TYPE_CODE;
STRING4	EXPIRE_YEAR;
STRING8	EXPIRATION_DATE;
STRING14	COUNTY_KEPT;
STRING7	  CGID;
STRING4	  FLEETID;
STRING32	VERIFIED;// HULL_ID_VERIFY_METHOD
STRING20	MODEL;
STRING10	ENGINE_TYPE;//ENGINE_DRIVE_TYPE
STRING17	BOATNAME;
STRING19	PORTNAME;
STRING8	  PUR_DATE;
STRING3	  NODISCLOSURE;
STRING4	  DOB;
STRING52	BUSINESS;
STRING4	  SUFFIX;
STRING13	COUNTRY_NAME;
string34	CONTACT;
string40	ADDRESS2;
STRING8	  LAST_TRANSACTION_DATE;//TXN_TIMESTAMP
STRING2	  LF;
end;

END;