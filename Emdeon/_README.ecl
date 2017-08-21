/*
	Enclarity Claims Emdeon:
	
		Overview: Claims Data received from Enclarity.  We currently process a file for each day of the month vendor provided files.

		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: emdeon
				Orbit Build			: Enclarity
				DOPS package		: There are no request for keys at the time 
				Frequency				: Monthly
				Landing Path		: //edata12/enclarity/claims/enclarity_transfer/emdeon/ 
				
				1.  Back up unzipped files to \\tapeload02b\healthcare\enclarity_(ei)\incoming_from_enclarity\from_client\Emdeon\
				2. 	Copy monthly file to //edata12/enclarity/claims/Emdeon/[version]
				3.	Open emdeon._BWR_Build and execute the code in that attribute.  Change the version to the files date (YYYYMM).
						That should the same date used for the folder created in step 1.  
				4.	In Orbit, create a build instance of the "Enclarity" build.  
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.

			

						
	
	