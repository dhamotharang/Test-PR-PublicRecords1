export layout_AR := 

record
string3	  STATEABREV;
string22	REG_NUM;
string23	HULL_ID;
string15	PROP;
string15	VEH_TYPE;
string10	FUEL;
string10	HULL;
string15	USE_1;
string25	MAKE;
string5	  TOTAL_INCH;
string8	  REG_DATE;
string4	  YEAR;
string100	NAME;
string50	FIRST_NAME;
string15	MID;
string50	LAST_NAME;
string75	ADDRESS_1;
string30	CITY;
string2	  STATE;
string10	ZIP;
string50	COUNTY;
string5	  FIPS;
string20	CONVLENGTH;
string20	MOTOR;
string4	  HP;
string13	SERIAL;
//New fields as of 7/2016
string21	SecondOwner_LastName;
string19	SecondOwner_FirstName;
string1		SecondOwner_MidName;
string8		ExpireDate;
//string30	Add2; Removed as of 7/2016
string2	  lf;
end;

