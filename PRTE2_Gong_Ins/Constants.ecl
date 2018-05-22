/* *****************************************************************************************
 PRTE2_Gong_Ins.BWR_Despray_Base 
 This is for despraying base data to csv file
***************************************************************************************** */

IMPORT _Control, ut, PRTE, PRTE2, PRTE2_Common;

EXPORT Constants := MODULE

		EXPORT LandingZoneIP					:= PRTE2_Common.Constants.InsLandingZone;
		InsLandingPathPrefix 					:= PRTE2_Common.Constants.InsLandingPathPrefix;
		EXPORT SourcePathForCSV		    := InsLandingPathPrefix;		
		EXPORT CSVSprayFieldSeparator	:= '\\,';
		EXPORT CSVSprayLineSeparator	:= '\\n,\\r\\n';
		EXPORT CSVSprayQuote					:= '"';
		
		EXPORT CSVOutFieldSeparator		:= ',';
		EXPORT CSVOutQuote						:= '"';

		EXPORT EmailTargetFail				:= PRTE2_Common.Email.EmailTargetFail;	 
		EXPORT EmailTargetSuccess			:= PRTE2_Common.Email.EmailTargetSuccess;	 

END;