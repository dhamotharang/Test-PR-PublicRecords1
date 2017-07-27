export Layout_Batch_In := RECORD
	unsigned4	seq;
	STRING30  AcctNo;
	STRING9   SSN;
	STRING120 unParsedFullName :='';
	STRING30  Name_First;
	STRING30  Name_Middle;
	STRING30  Name_Last;
	STRING5   Name_Suffix;

	STRING8   DOB;
	STRING65 street_addr := '';
	string10	Prim_Range;
	string2	Predir;
	string28	Prim_Name;
	string4	Suffix;
	string2	Postdir;
	string10	Unit_Desig;
	string8	Sec_Range;
	STRING25  p_City_name;
	STRING2   St;
	STRING5   Z5;
	
	string3	Age;
	STRING20  DL_Number;
	STRING2   DL_State;
	
	STRING10  Home_Phone;
	STRING10  Work_Phone;
	STRING45  ip_addr := '';
	unsigned3 HistoryDateYYYYMM;
END;