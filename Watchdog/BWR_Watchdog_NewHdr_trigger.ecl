#workunit('protect', 'true');
#workunit('name','Yogurt:Verify Watchdog New Hdr trigger');
Watchdog.proc_Validate_NewHdr.newhdr : when(CRON('00 * * * 0'));