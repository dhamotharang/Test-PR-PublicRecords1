﻿//--------------------------------------------------------------------
// PRTE2_Bankruptcy.Constants
// Project on hold.
// CT Bankruptcy are done as part of Alpharetta based simulator CompReport
//--------------------------------------------------------------------

IMPORT _Control, ut, PRTE, PRTE2, PRTE2_Common;

EXPORT Constants := MODULE

		EXPORT LandingZoneIP	:= PRTE2_Common.Constants.EDATA11;
																 
		EXPORT SourcePathForCSV		    			:= '/load01/prct2/Bankruptcy/Base/';		
		EXPORT CSVSprayFieldSeparator				:= '\\,';
		EXPORT CSVSprayLineSeparator				:= '\\n,\\r\\n';
		EXPORT CSVSprayQuote								:= '"';
		
		EXPORT CSVOutFieldSeparator					:= ',';
		EXPORT CSVOutQuote									:= '"';

		EXPORT boolean TRIAL_RUN_ONLY_NO_DOPS := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;
		EXPORT boolean FULL_RUN_WITH_DOPS 		:= PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;

		EXPORT EmailTargetFail				:= PRTE2_Common.Email.EmailTargetFail;	 
		EXPORT EmailTargetSuccess			:= PRTE2_Common.Email.EmailTargetSuccess;	 

END;