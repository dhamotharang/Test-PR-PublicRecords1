IMPORT PRTE2_Common;

EXPORT Constants := MODULE
	
		EXPORT LandingZoneIP	:= PRTE2_Common.Constants.EDATA11;
																 
		EXPORT SourcePathForHDRCSV 			:= '/load01/prct2/Header/';		
		EXPORT CSVSprayFieldSeparator		:= '\\,';
		EXPORT CSVSprayLineSeparator		:= '\\n,\\r\\n';
		EXPORT CSVSprayQuote						:= '';
		
		EXPORT CSVOutFieldSeparator			:= ',';
		EXPORT CSVOutQuote							:= '"';



END;