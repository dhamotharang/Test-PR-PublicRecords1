// WIP
/* *********************************************************************************************
PRTE2_LNProperty_Ins.Constants
??? Keep our 1 file and transform to 3???   or switch to 3 files????

********************************************************************************************* */
IMPORT PRTE2_Common;

EXPORT Constants := MODULE

		EXPORT LandingZoneIP	:= PRTE2_Common.Constants.EDATA11;
																 
		EXPORT SourcePathForLNPCSV		    		:= '/load01/prct2/LNProperty/'; 		
		EXPORT CSVSprayFieldSeparator				:= '\\,';
		EXPORT CSVSprayLineSeparator				:= '\\n,\\r\\n';
		EXPORT CSVSprayQuote								:= '';
		
		EXPORT CSVOutFieldSeparator					:= ',';
		EXPORT CSVOutQuote									:= '"';

END;