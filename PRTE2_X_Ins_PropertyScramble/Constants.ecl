/* ****************************************************************************************
PRTE2_X_Ins_PropertyScramble.Constants
Sep 2017, new landing zone we don't have sub-directories so we had to do remove that.
**************************************************************************************** */
IMPORT _Control, ut, PRTE2_Common, address;

EXPORT Constants := MODULE


	EXPORT LandingZoneIP						:= PRTE2_Common.Constants.InsLandingZone;
	InsLandingPathPrefix 						:= PRTE2_Common.Constants.InsLandingPathPrefix;														 
  EXPORT SourcePathForXRefCSV		  := InsLandingPathPrefix;
	
	EXPORT CSVSprayFieldSeparator		:= '\\,';
	EXPORT CSVSprayLineSeparator		:= '\\n,\\r\\n';
	EXPORT CSVSprayQuote						:= '';
	
	EXPORT CSVOutFieldSeparator			:= ',';
	EXPORT CSVOutQuote							:= '"';

	EXPORT INTEGER MAX_GROUP_SIZE := 2000;
	

END;