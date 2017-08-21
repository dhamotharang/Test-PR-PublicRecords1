//Alpharetta Scrape
export Layout_LA_Jefferson := module

export Defendant := record

String	DEF_ID;
String	DEF_NAME;
String	CASE_NUM;
String	COUNTY;
String	DOB;
String	HAIR;
String	EYE;
String	SEX;
String	RACE;
String	SKIN;
String	WEIGHT;
String	HEIGHT;
String	STREET;
String	CITY;
String	STATE;
String	ZIP;
String	FILE_DT;
String	CASE_CLOSED_DT;
String	JUDGE_NAME;
String	UNIFORM_CASE_NUM;
String	CASE_TYPE;
String	CASE_STATUS;
String	CASE_STATUS_DT;
String	TICKET_NUM;
String	LICENSE_NUM;
String	LIC_ST_CD;
String	SPEED_LIMIT;
String	SPEED;
String	TOTAL_FEES_OWED;
String	TOTAL_FEES_PAID;
String	TOTAL_FEES_DISMISSED;
String	TOTAL_FEES_DUE;
String	JURISDICTION;
end;
export Charge := record
String	DEF_ID;
String	COUNTY;
String	C_CASE_NUM;
String	COUNTS;
String	COUNT_NBR;
String	COUNT_AS_DISPOSED;
String	COUNT_AS_FILED;
String	OFFENSE_DT;
String	C_CASE_TYPE;
String	STATUTE;
String	STATUTE_DESCR;
String	DISPOSITION_DT;
String	DISPO_DETAIL;
String	COMMENTS;
String	CHG_LEVEL;
String	CHG_DEGREE;
String	INDICT_CHG;
String	AMENDED_CHG;
String	C_LICENSE_NUM;
String	LIC_STATE_CD;
String	STATUS;
String	CHARGE_ID;
end;
export Alias := record
String	DEF_ID;
String	ALIAS;
end;
export Sentence := record
String	CHARGE_ID;
String	DEF_ID;
String	SENTENCE_TYPE;
String	SENTENCE_DESCRIPTION;
String	TOTAL_OWED;
String	TOTAL_PAID;
String	TOTAL_DISMISSED;
String	TOTAL_DUE;
String	BOND_AMOUNT;
String	BOND_TYPE;
end;
end;
