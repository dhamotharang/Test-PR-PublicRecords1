/*
	POE:
	
		Overview: Compile all POE records from all sources.

		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: POE
				Orbit Build			: Place Of Employment
				DOPS package		: POEKeys
				Frequency				: Monthly
				
				1.	Open POE._bwr_Build_All in a builder window.  Change the pversion to today's date.
				3.  Execute it.
				4.	In Orbit, create a build instance of the "Place Of Employment" build.  Add the file(s) used in the build.
						When the build finishes and goes up into roxie dev, update the roxie production status to 
						"On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(POE._bwr_Build_All):
						1. Pull in all mapped sources
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
				POE._BWR_Rollback
			in a builder window.  This provides you with a few options to tailor the rollback to your specific situation.
			Such as, if the build files are bad(the base and key files created by the build),
			set "pDeleteBuildFiles" to true.  Also, set the "pversion" to the version of the build you are rolling back, and
			"pIsTesting" to false to perform the rollback.  
			It will rollback the base file and keys from 
			the father to the qa superfiles.  This will ensure that other builds that use these base file(s) will not 
			pull in bad data.  Deletion will occur after the rollback.  This should be run on hthor.
		
		Rename:
			If key(s) or a base file needs to be renamed, then you can use 
				POE._BWR_Rename_Keys
			to rename them.  This is useful for when one key had to be rebuilt, but the rest of the keys are ok.
			Since the package file requires that all keys be the same version, the other keys would need to be renamed.
			Change the pversion to the destination version of the keys.  You can just rename the keys(the default), or 
			you can include the base file(s) too, if needed.
			This should be run on hthor.

		Adding a source:
			Need to find out from product(currently Emily) what the hierarchy needs to be for this source(in POE.File_Source_Hierarchy)
			Then, need to add this new source code to mdr.sourcetools(if not added already)
			Then, Add the "as_poe" mapping attribute to the source_data attribute
			Then, add the filename(s) for the new file(s) to the source_filenames attribute(so they can be locked and unlocked easily)
			

*/