EXPORT Constants := MODULE
	EXPORT LandingZoneIP            := '10.173.10.159';
	EXPORT CSVSprayFieldSeparator   := '\\,';
	EXPORT CSVSprayLineSeparator	:= '\\n,\\r\\n';
	EXPORT CSVSprayQuote			:= '\"';
	EXPORT CSVOutFieldSeparator		:= ',';
	EXPORT CSVOutQuote				:= '"';
	EXPORT CSVOutTerminator			:= ['\n','\r\n'];
	EXPORT maxRecLength				:= 1000000000;
END;
