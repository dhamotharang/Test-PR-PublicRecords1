/*
	Setup for Process:
		Need to start backwards, on the production thor, since if a file shows up on the logs thor and the processes are not in place on the production 
		thor, then events will not be triggered.  So you need to start at the end:
			1.	Execute tin_matching._bwr_Build_All_Prod_Thor on production thor.  This will put it in the scheduler, waiting for the event _Constants().Name
					to happen.  When that event gets triggered, it will process the file (it will already be in the sprayed superfile).
			2.	Execute tin_matching._bwr_Build_All_Logs_Thor on the logs thor.  This will also put this workunit in the scheduler, waiting for the event 
					_Constants().Name.  When that event is triggered, it will process the file from Victor and then copy the result file to production thor.
					Then, once the file has been copied to production thor, it will trigger the above production process with a soapcall.
			3.	Execute tin_matching._bwr_monitor_filename on the logs thor.  This will place a monitor on the incoming filename from Victor so that
					once a file shows up with that pattern, it will trigger the _Constants().Name event, which will kick off the above #2 process.
			



	probably need to:
		1.  apply filtering to file victor sprays to logs thor, however this filtering works.  Make sure ask about extra flag.
		2.  After filtering that file, blank out probably these fields: jobid, acctno, account_number, gcid
		3.  Write out the filtered file, add to a superfile
		3.  Remote copy the file.  To do this, will need to have a cron job on production thor looking for a file on the logs thor.
				If it finds a file in that superfile, then copy it to prod thor and begin build.

	for logs thor process:
		have cron job look for file with specific pattern that is not in a superfile,maybe every 15 minutes.
		if found, kick off job:
			place file in sprayed superfile, and root superfile
			move to using
			process file, applying filters and blanking out fields
			output file, add to superfile
			move to used superfile.
			remotepull(copy) this file to production thor.

	for production thor process:
		have cron job looking for file with specific pattern that is not in a superfile, probably can do like in garnishments where figure out latest date in base file,
			and look for date later than that for the input file.
		if found, kick off job:
			place file in sprayed superfile(should replace the spray portion of build, kinda like in garnishments)
			execute process

tin match code description:
	0	TIN and Name match
	1	TIN was missing or was entered incorrectly
	2	TIN entered is not currently issued
	3	TIN and Name do not match
	4	Invalid TIN matching request
	5	Duplicate TIN matching request
	6	TIN Match found only on SSN, when the TIN type is (3 - Unknown)
	7	TIN Match found only on EIN, when the TIN type is (3 - Unknown)
	8	TIN Match found on both the SSN and EIN format, when the TIN type is (3 - Unknown) 

tin type  :
	"1" represents an Employer Identification Number (EIN) 
	"2" represents a Social Security Number (SSN), 
	"3" represents an "unknown" TIN type (Always use this option (3) for ease of use)

*/