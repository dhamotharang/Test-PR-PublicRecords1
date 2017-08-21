/*
	PoesFromEmails:
	
		Overview: Find POEs for email records.

		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: PoesFromEmails
				Orbit Build			: Poe From Email
				Frequency				: Monthly
				
				1.	Open PoesFromEmails._bwr_Build_All in a builder window.  Change the pversion to today's date.
				3.  Execute it.
				4.	In Orbit, create a build instance of the "Poe From Email" build.  Add the file(s) used in the build.
						When the build finishes and goes up into roxie dev, update the roxie production status to 
						"On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(PoesFromEmails._bwr_Build_All):
						1. Pull from Email Base and Whois Base files
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
				PoesFromEmails._BWR_Rollback
			in a builder window.  This provides you with a few options to tailor the rollback to your specific situation.
			Such as, if the build files are bad(the base and key files created by the build),
			set "pDeleteBuildFiles" to true.  Also, set the "pversion" to the version of the build you are rolling back, and
			"pIsTesting" to false to perform the rollback.  
			It will rollback the base file and keys from 
			the father to the qa superfiles.  This will ensure that other builds that use these base file(s) will not 
			pull in bad data.  Deletion will occur after the rollback.  This should be run on hthor.
		
*/