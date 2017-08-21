/*mapping of the possible DMFVALUE settings:

00=No permissible purpose
01=Business permissible purpose
10=Fraud Prevention permissible purpose
11=Both
*/

IMPORT Address, Compliance, ut;


string ToCaps(string s) := stringlib.stringToUpperCase(s);
string CleanSpaces(string s) := stringlib.StringCleanSpaces(s);

EXPORT Compliance.Layout_Details_from_ACTION_field ExtractDetailsFromActionField(Compliance.Layout_In srch) := 
	TRANSFORM
		SELF.ACTION_DPPA := MAP(REGEXFIND('\\(DPPA=',srch.action, nocase)	=> REGEXFIND('\\(DPPA=([0-9A-Z* ,#./-_]+)\\)', ToCaps(srch.action), 1)
													 ,''
													 );
		SELF.ACTION_GLBA := MAP(REGEXFIND('\\(GLBA=',srch.action, nocase)	=> REGEXFIND('\\(GLBA=([0-9A-Z* ,#./-_]+)\\)', ToCaps(srch.action), 1)
													 ,''
													 );
		SELF.ACTION_DMF_Desc := MAP(REGEXFIND('\\(DMFDESC=',srch.action, nocase)	=> REGEXFIND('\\(DMFDESC=DMP. BIT 1: ([0-9A-Z* ,#./-_]+)\\)', ToCaps(srch.action), 1)
													 ,''
													 );
		SELF.ACTION_DMF_Value := MAP(REGEXFIND('\\(DMFVALUE=',srch.action, nocase)	=> REGEXFIND('\\(DMFVALUE=([0-9A-Z* ,#./-_]+)\\)', ToCaps(srch.action), 1)
													 ,''
													 );
													 
		SELF.ACTION_FuncName := MAP(REGEXFIND('\\(FUNCNAME=',srch.action, nocase)	=> REGEXFIND('\\(FUNCNAME=([0-9A-Z* ,#./-_()]+)\\)\\(', ToCaps(srch.action), 1)
													 ,''
													 );
													 
		SELF := srch;
	END;
	