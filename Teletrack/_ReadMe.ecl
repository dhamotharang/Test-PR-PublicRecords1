/*
	Teletrack:
	
		Overview: CoreLogic Teletrack provides access to non-traditional consumer credit data and a suite of credit 
							risk and fraud prevention solutions. Teletrack supports the risk assessment needs of consumer finance 
							businesses serving consumers with less than perfect credit histories. 
 
							http://www.teletrack.com/index.html
							We receive a file from Teletrack, and use it to update our base file on thor.

		The Build:
			
			Quick Documentation to run the thor build:

				Tapeload02b Dir	: people\places_of_employment\Teletrack_(ei)
				Unix Directory	: edata12:/data_build_1/teletrack/
				Thor Module			: Teletrack
				Orbit Build			: Teletrack
				Frequency				: Monthly
				
				1.	Once you have transferred the zip file from tapeload02b, unzip it.  It contains a csv file.
				2.	Then, open Teletrack._bwr_Build_All in a builder window.  Change the pversion to today's date
						and change the directory to where the newly transferred file is on unix. 
				3.  Execute it.
				4.	In Orbit, create a build instance of the "Teletrack" build.  Add the update file(s) used in the build.
						When the build finishes and goes up into roxie dev, update the roxie production status to 
						"On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(Teletrack._bwr_Build_All):
						1. Spray the file & add to sprayed superfile
						2. Build the base files
						3. Build the Roxie keys
						4. Build Strata
						5. Update DOPS
						
	
	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.

		Rollback:
			If the build is bad, you can rollback the build to the previous one.
			Open 
				Teletrack._bwr_Rollback_Build
			in a builder window.  This provides you with a few options to tailor the rollback to your specific situation.
			Such as, if the input files are bad and need to be deleted so they are not used again, 
			set "pDeleteInputFiles" to true.  If the build files are bad(the base and key files created by the build),
			set "pDeleteBuildFiles" to true.  Also, set the "pversion" to the version of the build you are rolling back, and
			"pIsTesting" to false to perform the rollback.  
			It will rollback the input files used in the build from the "used" or "using" to the "sprayed" superfile
			(which is where they are at the beginning of the build).  It will also rollback the base file and keys from 
			the father to the qa superfiles.  This will ensure that other builds that use these base file(s) will not 
			pull in bad data.  Deletion will occur after the rollback.  This should be run on hthor.


		Rename:
			If key(s) or a base file needs to be renamed, then you can use 
				Teletrack._BWR_Rename
			to rename them.  This is useful for when one key had to be rebuilt, but the rest of the keys are ok.
			Since the package file requires that all keys be the same version, the other keys would need to be renamed.
			Change the pversion to the destination version of the keys.  You can just rename the keys(the default), or 
			you can include the base file(s) too, if needed.
			This should be run on hthor.
		
*/