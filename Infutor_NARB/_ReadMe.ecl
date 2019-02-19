/*
	  Vendor:   Infutor NARB
	
		Overview: Infutor NARB contains Name and Address Resource Business data. 
 							
							http://www.infutor.com/

							We receive 52 zipped files from Infutor, which each contain 1 tab-delimited text (*.txt) file. 
							We use those to update our base file on thor and build LinkID keys.  
							The 52 files are one per each US state plus DC and PR.  
							The approximate record count is 25 million.

		The Build:
			
			Quick Documentation to run the thor build:

				Tapeload02b Dir	: business\infutor_business_data
				Unix Directory	: bctlpedata11:/data/hds_180/Infutor_NARB/data/<folder date>
				Thor Module			: Infutor_NARB
				Orbit Build			: Infutor_NARB
				Frequency				: Monthly - Full Unload 
				
				1.	The folder on tapeload02b and the zip files contents are to be copied into the data directory under
            the Infutor_NARB folder on bctlpedata11. Unzip the 52 *.txt files in to the same directory as the zip files.
            After unzipping, the 52 *.txt files will be picked up by the spray process and put on thor in 1 file.
				2.	Next, open Infutor_NARB._BWR_Build_All in a builder window.  Change the pversion to to the date that 
            matches the folder date on bctlpedata11. 
				3.  Execute it.
				4.	In Orbit, create a build instance of the "Infutor_NARB" build.  Add the update file used in the build.
						When the build finishes, update the roxie production status to "On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(Infutor_NARB._bwr_Build_All):
						1. Sprays the files & adds to sprayed superfiles
					  2. Runs the SALT Ingest process (Full Contiguous Mode, not Incremental and no Delta)
									and builds the base file
						3. Builds LinkID Keys
            4. Runs Scrubs Plus on the new base file
						5. Builds Strata
						6. Runs BIPStats -- This step is commented out until the BIP team puts the macro into Production
            7. Create QA Samples
						8. Updates DOPS
						
	
	Notes:
		Rollback:
			If there is an issue with the build, you can rollback the build to the previous one.
			Open 
				Infutor_NARB._bwr_Rollback_Build
			in a builder window.  This provides you with a few options to tailor the rollback to your specific situation.
			Such as, if the input file is bad and needs to be deleted so it is not used again, 
			set "pDeleteInputFiles" to true.  If the build files are bad(the base and key files created by the build),
			set "pDeleteBuildFiles" to true.  Also, set the "pversion" to the version of the build you are rolling back, and
			"pIsTesting" to false to perform the rollback.  
			It will rollback the input file used in the build from the "used" or "using" to the "sprayed" superfile
			(which is where they are at the beginning of the build).  It will also rollback the base file and keys from 
			the father to the qa superfiles.  This will ensure that other builds that use these base file(s) will not 
			pull in bad data.  Deletion will occur after the rollback.  

		
    The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.
			
*/