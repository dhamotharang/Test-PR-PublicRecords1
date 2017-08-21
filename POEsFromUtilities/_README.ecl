/*
	POEsFromUtilities:
	
		Overview: Find POEs for Utility records.

		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: POEsFromUtilities
				Orbit Build			: Poe From Utility
				Frequency				: Monthly
				
				1.	Open POEsFromUtilities._bwr_Build_All in a builder window.  Change the pversion to today's date.
				3.  Execute it.
				4.	In Orbit, create a build instance of the "Poe From Utility" build.  Add the file(s) used in the build.
						When the build finishes and goes up into roxie dev, update the roxie production status to 
						"On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(POEsFromUtilities._bwr_Build_All):
						1. Pull from utility file, gong and yellowpages base files.
						2. Build the base files
						3. Build the Roxie keys
						4. Build Strata
						5. Output new records for QA
						5. Update DOPS
						
	
	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.

		Rollback:
			If the build is bad, you can rollback the build to the previous one.
			Open 
				POEsFromUtilities._BWR_Rollback
			in a builder window.  This provides you with a few options to tailor the rollback to your specific situation.
			Such as, if the build files are bad(the base and key files created by the build),
			set "pDeleteBuildFiles" to true.  Also, set the "pversion" to the version of the build you are rolling back, and
			"pIsTesting" to false to perform the rollback.  
			It will rollback the base file and keys from 
			the father to the qa superfiles.  This will ensure that other builds that use these base file(s) will not 
			pull in bad data.  Deletion will occur after the rollback.  This should be run on hthor.
		
		Rename:
			If key(s) or a base file needs to be renamed, then you can use 
				POEsFromUtilities._BWR_Rename_Keys
			to rename them.  This is useful for when one key had to be rebuilt, but the rest of the keys are ok.
			Since the package file requires that all keys be the same version, the other keys would need to be renamed.
			Change the pversion to the destination version of the keys.  You can just rename the keys(the default), or 
			you can include the base file(s) too, if needed.
			This should be run on hthor.

*/