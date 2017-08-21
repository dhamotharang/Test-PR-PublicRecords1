#workunit('protect', 'true');
#workunit('name','Verify Watchdog New Hdr trigger');
Watchdog.proc_Validate_NewHdr.newhdr : when(CRON('30 * * * 0'));