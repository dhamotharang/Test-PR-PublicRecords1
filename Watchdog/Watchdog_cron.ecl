//#Steps to run Watchdog Cron schedule

1. Each week both old header and new header trigger jobs check to verify if we have new or old header in thor_data400::base::header_prod
     
2.  Verify Watchdog Old Hdr trigger ( Watchdog.BWR_Watchdog_OldHdrtrig_cron)  --> Start Watchdog build with Old Header ( Watchdog.BWR_Watchdog_Old_Header_cron)
    Verify Watchdog New Hdr trigger (Watchdog.BWR_Watchdog_NewHdr_trigger) -- > Start Watchdog build with New Header ( Watchdog.BWR_Watchdog_NewHeader_cron)
		
		