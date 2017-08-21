/*_README
	DCAV2:
	
		Overview: DCAV2 
							Business Data we receive from LNCA
							We receive files from LNCA, and use it to update our base file on thor.
		The Build:
			
			Quick Documentation to run the thor build:
				Tapeload02b Dir	: business\dca_(en)\
				Unix Directory	: edata10:/prod_data_build_13/eval_data/dca/
				Thor Module			: DCAV2
				Orbit Build			: DCA
				Frequency				: Monthly
				Vendor Docs			: 
				
				1.	Transfer the txt files from the dated directory on tapeload02b.  Also look in the deletes and mergers_and_acquisitions subdirectories 
            for matching dated directories and transfer the files in those dated directories to unix(These files, if not already, should be saved
            as tab delimited txt files).
				2.	Then, open 
							DCAV2._bwr_Build
						in a builder window.  Change the pversion to today's date
						and change the directory to where the newly transferred files are on unix. 
				3.  Execute it.
				4.	In Orbit, create a build instance of the "DCA" build.  Add the update file(s) used in the build.
						When the build finishes and the stats are ok, status to "Build available for use"
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(DCAV2._bwr_Build_All):
						1. Spray the files & add to sprayed superfile
						2. Build the base files
            3. Build the keys
						4. Build Strata
						5. Send Email
						
	
	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.
		Rollback:
			If the build is bad, you can rollback the build to the previous one.
			Open 
				DCAV2._BWR_Rollback
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
				DCAV2._bwr_RenameKeys
			to rename them.  This is useful for when one key had to be rebuilt, but the rest of the keys are ok.
			Since the package file requires that all keys be the same version, the other keys would need to be renamed.
			Change the pversion to the destination version of the keys.  You can just rename the keys(the default), or 
			you can include the base file(s) too, if needed.
			This should be run on hthor.
		Spray Only:
			If you would like to just spray the files to thor without running the build yet, open:
				DCAV2._bwr_Spray
			in a builder window and modify the parameters to coorespond to your source file.  Then execute it.
			Since this is only does spraying and superfile manipulation, it should be run on hthor.
		
*/
