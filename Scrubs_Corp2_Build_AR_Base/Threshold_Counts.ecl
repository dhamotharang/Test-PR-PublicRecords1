export Threshold_Counts := module

		//The max THRESHOLD counts that the input data is validated against.
		//When this count is exceeded, the build will fail.

		Export 	CORP_KEY										 					:=	10;
		Export	CORP_STATE_ORIGIN											:=	10;
		Export	CORP_VENDOR														:=	10;
		Export	CORP_PROCESS_DATE											:=	0;
		Export	ar_mailed_dt													:=	50;
		Export	ar_due_dt															:=	50;
		Export	ar_report_dt													:=	50;
		Export	ar_franchise_tax_paid_dt							:=	50;
		Export 	ar_delinquent_dt 						 					:=	50;
end;