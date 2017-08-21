IMPORT AccountMonitoring;

// Interface used to allow the user to run the monitoring job against the daily file. When monitor_daily_file
// is true, the history file are not written. 
EXPORT i_Job_Config := 
	INTERFACE
	
		EXPORT BOOLEAN monitor_daily_file := FALSE;
		
	END;