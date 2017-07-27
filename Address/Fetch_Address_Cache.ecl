i := key_addresscache;

STRING120 ca(STRING s) := 
	stringlib.StringToUpperCase(stringlib.StringCleanSpaces(trim(s, left)));

address.Layout_Address_Cache StdLayout(i l) := TRANSFORM
	SELF.addr1 := l.s_addr1;
	SELF.addr2 := l.s_addr2;
	SELF := l;
END;

export Fetch_Address_Cache(string120 addr1_in, string120 addr2_in) := 
       PROJECT(i(s_addr1 = ca(addr1_in), s_addr2 = ca(addr2_in)), StdLayout(LEFT));