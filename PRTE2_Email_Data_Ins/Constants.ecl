/* ************************************************************************************************
Nov 2017 - re-write to new LZ and base layouts
************************************************************************************************ */
IMPORT _Control, ut, PRTE, PRTE2, PRTE2_Common;

EXPORT Constants := MODULE

		EXPORT LandingZoneIP				:= PRTE2_Common.Constants.InsLandingZone;
		EXPORT SourcePathForCSV 	:= PRTE2_Common.Constants.InsLandingPathPrefix;
		
		EXPORT CSVSprayFieldSeparator				:= '\\,';     
		EXPORT CSVSprayLineSeparator				:= '\\n,\\r\\n';
		EXPORT CSVSprayQuote								:= '';
		EXPORT CSVMaxCount									:= 100000;  
		
		EXPORT CSVOutFieldSeparator					:= ',';
		EXPORT CSVOutQuote									:= '"';

		EXPORT boolean TRIAL_RUN_ONLY_NO_DOPS := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;
		EXPORT boolean FULL_RUN_WITH_DOPS 		:= PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;

END;