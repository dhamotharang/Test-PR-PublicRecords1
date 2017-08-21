/*
	Experian Index Phones:
	
		Overview: Every month, Experian provides a file containing up to 3 phones (3 last digits of the phone only) 
							per record.  The data is normalized to have 1 phone per record. Then using the Experian Credit file, 
							a DID is appended by matching the Experian Encrypted pin in both files.  Also a score for each phone is 
							calculated.  The base file keeps both current and historical data, but only current data is included in 
							the key(s).

		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: Experian_Phones
				Orbit Build			: Experian Index Phones
				DOPS package		: ExperianPhonesKeys
				Frequency				: Monthly
				
				1. 	FTP monthly file to //edata12//edata12/hds_180/experian_index_phone[YYYYMMDD] from \\tapeload02b\k\eval\experian_one_gateway_phone
				2.	Open Experian_Phones.BWR_Build_Experian_Phones in a builder window.  Change the version to the files date (YYYYMMDD).
						That should be the same date used for the folder created in step 1.  Also enter the parameter for the the type of update (incr_update)
						true = incremental update, false = full file update
						Experian_Phones.BWR_Build_Experian_Phones(version, incr_update)
				3.  Execute it.
				4.	In Orbit, create a build instance of the "Experian Index Phones" build.  Add the file(s) used in the build.
						When the build finishes and goes up into roxie dev, update the roxie production status to 
						"On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.

			

						
	
	