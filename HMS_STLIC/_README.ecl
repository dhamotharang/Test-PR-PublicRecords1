/*
	HMS Provider State License:
	
		Overview: Healthcare Provider State Licenses - Data received from Health Market Science.  We currently process 100 vendor provided files.

		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: HMS_STLIC
				Orbit Build			: HMS State License
				DOPS package		: There are no request for keys at the time 
				Frequency				: Daily
				Landing Path		: \\tapeload02b\k\healthcare\hms_lexisnexis_(ei)\HMSSTLIC\
				
				1. 	FTP daily file to //edata12/hms/hms_stl/[version]
				2.	Open HMS_STLIC._BWR_Build and execute the code in that attribute.  Change the version to the files date (YYYYMMDD).
						That should the same date used for the folder created in step 1.  
				3.	In Orbit, create a build instance of the "HMS State License" build.  
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.

			

						
	
	