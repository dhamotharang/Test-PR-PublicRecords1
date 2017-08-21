/*
	Experian_FEIN:
	
		Overview: Experian provides FEIN data. 
 							
					We receive 5 monthly zip files of fixed format text data which contains 
					FEIN records and we use it to update our base file on thor.

		The Build:
			
			Quick Documentation to run the thor build:

				Tapeload02b Dir	: business\miscellaneous\fein_(en)\experian\
				Unix Directory	: edata12:/hds_180/experian_fein
				Thor Module			: Experian_FEIN
				Orbit Build			: Experian_FEIN
				Frequency				: Monthly
				
				1.	Once you have transferred the zip files from tapeload02b, unzip them.  
				2.  FTP the text files to the unix directory.csv to file.
				3.	Then, open Experian_FEIN._bwr_Build_All in a builder window.  
				4.  Change the pversion date, then execute it.
				5.	In Orbit, create a build instance of the "Experian_FEIN" build.  Add the 
						update file(s) used in the build.  When the build finishes and goes up 
						into roxie dev, update the roxie production status to "On Development".
				6.	The build will send you an email when it finishes successfully, 
						or a fail email if it fails.
			
				Thor Part(Experian_FEIN._bwr_Build_All):
						1. Spray the file & add to sprayed superfile
						2. Build the base files
						3. Build the LinkID keys
						4. Build Strata 				
	
	Notes:
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.

		Rollback:
			If the build is bad, you can rollback the build to the previous one.
			Open 
				Experian_FEIN._bwr_Rollback_Build
			in a builder window.  This provides you with a few options to tailor the rollback 
			to your specific situation.  Such as, if the input files are bad and need to be 
			deleted so they are not used again, set "pDeleteInputFiles" to true.  If the build
			files are bad(the base and key files created by the build), set "pDeleteBuildFiles"
			to true.  Also, set the "pversion" to the version of the build you are rolling back,
			and "pIsTesting" to false to perform the rollback.  
			It will rollback the input files used in the build from the "used" or "using" to the
			"sprayed" superfile (which is where they are at the beginning of the build).  It will
			also rollback the base file and keys from the father to the qa superfiles.  This will 
			ensure that other builds that use these base file(s) will not pull in bad data.  
			Deletion will occur after the rollback.  This should be run on hthor.
		
*/