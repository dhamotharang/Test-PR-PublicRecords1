/*
	Thrive:
	
		Overview: Thrive Marketing provides transactional mortgage (LT) and payday (PD)lending information 
							on approximately 35 million individuals.  Shall not contain information from other consumer 
							reporting agencies or credit account information.  Shall be from editable database that can 
							be corrected if information is found to be inaccurate.
							
							The data is delivered monthtly in 2 files.  One referred to as LT with transactional mortgage
							lending data and another referred to as PD with Payday lending information.  Both files 
							come in different formats, but in the build they are converted to a common layout and 
							each is identified by the src field.  The base file of this build is used by the POE or WPL build.


		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: Thrive
				Orbit Build			: Thrive
				DOPS package		: ThriveKeys
				Frequency				: Monthly
				
				1. 	FTP monthly file to //edata12/hds_2/thrive/[version]
				2.	Open thrive._BWR_Build and execute the code in that attribute.  Change the version to the files date (YYYYMMDD).
						That should the same date used for the folder created in step 1.  
				3.	In Orbit, create a build instance of the "Thrive" build.  Add the file(s) used in the build.
						When the build finishes and goes up into roxie dev, update the roxie production status to 
						"On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.

			

						
	
	