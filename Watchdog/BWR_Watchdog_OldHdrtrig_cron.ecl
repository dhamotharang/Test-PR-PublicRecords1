#workunit('protect', 'true');
#workunit('name','Yogurt:Verify Watchdog Old Hdr trigger');
Watchdog.proc_Validate_NewHdr.oldhdr : when(CRON('00 * * * 0'));