export Threshold_Counts := module

		//The max THRESHOLD counts that the input data is validated against.
		//When this count is exceeded, the build will fail.

		Export 	CORP_KEY										 					:=	900;
		Export 	CORP_ORIG_SOS_CHARTER_NBR 	 					:=	900;
		Export 	CORP_LEGAL_NAME 						 					:=	20000;
		Export	CORP_PROCESS_DATE											:=	0;
		Export 	CORP_INC_STATE												:=	100;
		Export	CORP_INC_DATE													:=	2000;
		Export	CORP_STATUS_DATE											:=	3000;
end;
