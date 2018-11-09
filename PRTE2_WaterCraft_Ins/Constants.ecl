IMPORT PRTE2_Common;

EXPORT Constants := MODULE

		EXPORT LandingZoneIP	:= PRTE2_Common.Constants.InsLandingZone;
		InsLandingPathPrefix 	:= PRTE2_Common.Constants.InsLandingPathPrefix;
		EXPORT SourcePathForCSV		    			:= InsLandingPathPrefix;		
		EXPORT CSVSprayFieldSeparator				:= '\\,';
		EXPORT CSVSprayLineSeparator				:= '\\n,\\r\\n';
		EXPORT CSVSprayQuote								:= '"';
		
		EXPORT CSVOutFieldSeparator					:= ',';
		EXPORT CSVOutQuote									:= '"';

		EXPORT boolean TRIAL_RUN_ONLY_NO_DOPS := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;
		EXPORT boolean FULL_RUN_WITH_DOPS 		:= PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;

		EXPORT FULL_REBUILD_INDICATOR := TRUE;
		EXPORT ADD_NEW_ONLY_INDICATOR := FALSE;
	
END;