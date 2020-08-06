﻿/*

	Franchisee - IQVIA:
	
		Overview: IQVIA provides the OneKey reference data. 
 							
							https://www.iqvia.com/

							We receive 2 files from IQVIA, and use it to update our OneKey base file on thor.

		The Build:
			
			Quick Documentation to run the thor build:

				Tapeload Dir	: paw/employee_directories/ska_(en)
				Unix/Linux Dir	: bctlpedata11: /data/prod_data_build_10/production_data/business_headers/onekey/data/{versiondate}
				Thor Module	    : OneKey
				Orbit Build		: OneKey
				Frequency		: 
				
				1.	Create a directory in the Unix/Linux directory that represents the {versiondate} (ie. 20200401)
                2.  Transfer the zipped file from tapeload to the newly created unix/linux directory.
                3.  Unzip the file.  The unzipped csv files must be named "OneKey_LexisNexisA.csv" and "OneKey_LexisNexisB.csv".
				4.	Open OneKey._BWR_Build_All in a builder window.  Change the filedate to the {versiondate}. 
				5.  Execute it.
				6.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(OneKey._BWR_Build_All):
						1. Spray the files & add to sprayed superfile
                        2. Check sprayed files using Scrubs
						3. Build the base files
						4. Build Strata
                        5. Produce sample QA records
						
	
	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.

		Rollback steps:
			1. Open OneKey._BWR_Rollback_Build in a builder window.
            2. If the input files are bad and need to be deleted so they are not used again, set "pDeleteInputFiles" to true.
            3. If the build files are bad and need to be deleted, set "pDeleteBuildFiles" to true.
            4. Set the "pversion" to the version of the build you are rolling back
            5. Set "pIsTesting" to false to perform the rollback.  
		Rollback process:
        	The input files used in the build will be rolled back from the "used" or "using" to the "sprayed" superfile
			(which is where they are at the beginning of the build).  It will also rollback the base file from 
			the father to the qa superfile.  This will ensure that other builds that use these base file(s) will not 
			pull in bad data.  Deletion will occur after the rollback.  This should be run on hthor.
		
*/