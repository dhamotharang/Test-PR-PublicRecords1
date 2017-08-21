/*
	Garnishments:
	
		Overview: Find Employers for Employees with Garnished wages by finding closest business to 
							person address with same company name

		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: Garnishments
				Orbit Build			: Garnishments
				Frequency				: Monthly
				
				1.	Open Garnishments._bwr_Build_All in a builder window.  Change the pversion to today's date.
				3.  Execute it.
				4.	In Orbit, create a build instance of the "Garnishments" build.  Add the file(s) used in the build.
						When the build finishes and goes up into roxie dev, update the roxie production status to 
						"On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(Garnishments._bwr_Build_All):
						1. Compile new Liens Hogan input files
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
				Garnishments._BWR_Rollback
			in a builder window.  This provides you with a few options to tailor the rollback to your specific situation.
			Such as, if the build files are bad(the base and key files created by the build),
			set "pDeleteBuildFiles" to true.  Also, set the "pversion" to the version of the build you are rolling back, and
			"pIsTesting" to false to perform the rollback.  
			It will rollback the input files used in the build from the "used" or "using" to the "sprayed" superfile
			(which is where they are at the beginning of the build).  It will also rollback the base file and keys from 
			the father to the qa superfiles.  This will ensure that other builds that use these base file(s) will not 
			pull in bad data.  Deletion will occur after the rollback.  This should be run on hthor.
			Note:  There is no option to delete the input files when rolling back(that option exists in other builds).
						 The reason for this is because the input files used in this build are compiled from the Liens build
						 which maintains those files.  So this build should only read them, not modify/delete them at all.

		Rename:
			If key(s) or a base file needs to be renamed, then you can use 
				Garnishments._BWR_Rename
			to rename them.  This is useful for when one key had to be rebuilt, but the rest of the keys are ok.
			Since the package file requires that all keys be the same version, the other keys would need to be renamed.
			Change the pversion to the destination version of the keys.  You can just rename the keys(the default), or 
			you can include the base file(s) too, if needed.
			This should be run on hthor.
		
*/