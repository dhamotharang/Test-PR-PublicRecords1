/********************************************************************************************************** 
	Name: 			_LandingZoneConfig
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			All configurations pertaining to landing zone, file types, names, separators etc
***********************************************************************************************************/

IMPORT _Control, PRTE2;

EXPORT _LandingZoneConfig := MODULE
	// Environment - Need to get this cleared. We need to know the landing zones for prod and dev later on.
	EXPORT IP				 									:= PRTE2.Constants.EDATA11;
	EXPORt BaseDir										:= '/load01/prct2/watercraft/';
	
	// Location for All Data - For full data revamp
	EXPORT AllData						:= MODULE
			EXPORT Dir										:= BaseDir + 'base/';
			EXPORT File										:= 'Base.csv';
			EXPORT FullPath								:= Dir + File;
	END;
	
	// Location for delta updates - For adding to existing base data
	EXPORT NewData						:= MODULE
			EXPORT Dir										:= BaseDir + 'additions/';
			EXPORT File										:= 'Add.csv';
			EXPORT FullPath								:= Dir + File;
	END;
	
	EXPORT CSVSprayFieldSeparator			:= '\\,';
	EXPORT CSVSprayLineSeparator			:= '\\n,\\r\\n';
	EXPORT CSVSprayQuote							:= '';
END;