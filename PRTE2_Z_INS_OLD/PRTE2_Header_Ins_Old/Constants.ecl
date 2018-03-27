IMPORT PRTE2_Common;

EXPORT Constants := MODULE
	
		EXPORT LandingZoneIP	:= PRTE2_Common.Constants.InsLandingZone;
		InsLandingPathPrefix 	:= PRTE2_Common.Constants.InsLandingPathPrefix;
		EXPORT SourcePathForHDRCSV 			:= InsLandingPathPrefix+'prct2/Header/';		
		EXPORT CSVSprayFieldSeparator		:= '\\,';
		EXPORT CSVSprayLineSeparator		:= '\\n,\\r\\n';
		EXPORT CSVSprayQuote						:= '';
		
		EXPORT CSVOutFieldSeparator			:= ',';
		EXPORT CSVOutQuote							:= '"';



END;