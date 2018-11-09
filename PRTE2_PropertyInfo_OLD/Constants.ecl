// PRTE2_PropertyInfo.Constants

IMPORT _Control, ut, PRTE, PRTE2, PRTE2_Common;

EXPORT Constants := MODULE

		EXPORT ALPHA_RID_CONSTANT := 880000000;		// This is used to generate a larger RID number, do not
		//  think it has any significance other than trying to keep our records separate from Boca records
		
		EXPORT LandingZoneIP	:= PRTE2_Common.Constants.EDATA11;
																 
		EXPORT SourcePathForPIICSV		    		:= '/load01/prct2/PropertyInfo/';		
		EXPORT CSVSprayFieldSeparator				:= '\\,';
		EXPORT CSVSprayLineSeparator				:= '\\n,\\r\\n';
		EXPORT CSVSprayQuote								:= '';
		
		EXPORT CSVOutFieldSeparator					:= ',';
		EXPORT CSVOutQuote									:= '"';

		EXPORT boolean TRIAL_RUN_ONLY_NO_DOPS := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;
		EXPORT boolean FULL_RUN_WITH_DOPS 		:= PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;

		EXPORT EmailTargetFail				:= PRTE2_Common.Email.EmailTargetFail;	 
		EXPORT EmailTargetSuccess			:= PRTE2_Common.Email.EmailTargetSuccess;	 

END;