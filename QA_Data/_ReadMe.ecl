/*
	  Vendor:   QA Data Info
	
		Overview: QADI (QA Data Info) collects shipping logistics company data.  The data records are 
							from multiple shipment tracking/logistics companies, and includes ship-to Addresses as 
							well as individual and business ship-to Names.  Transactions are from U.S. shippers for
							U.S. recipients; with only a few random Canadian 
 							
							http://www.qadatainfo.com/

							We receive a zipped file from QADI, which contains 2 csv (*.txt) files (Address and 
							Transactions) and we use those to update our base file on thor.

		The Build:
			
			Quick Documentation to run the thor build:

				Tapeload02b Dir	: business\qa_data_info
				Unix Directory	: bctlpedata12:/data/hds_180/qa_data/data/<folder date>
				Thor Module			: QA_Data
				Orbit Build			: QA_Data
				Frequency				: Monthly - Updates 
				
				1.	The folder on tapeload02b and the zip file contents are to be copied in to the data directory under
            the qa_data folder on edata12. Unzip the 2 *.txt files in to the same directory as the zip file.
            The naming convention for the 2 files cannot contain spaces, so spaces in the file names will
            be converted to "_".  Also the Addresses file must contain the word "Address" as part of the file
            name.  Likewise, the Transaction file must contain "Trans" as part of the file name.  These 2
            files will be picked up by the spray process.
				2.	Next, open QA_Data._BWR_Build_All in a builder window.  Change the pversion to today's date. 
				3.  Execute it.
				4.	In Orbit, create a build instance of the "QA_Data" build.  Add the update file(s) used in the build.
						When the build finishes, update the roxie production status to "On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(QA_Data._bwr_Build_All):
						1. Spray the files & add to sprayed superfiles
						2. Build the base files
						3. Build Strata
            4. Run Scrubs Plus on the base files
						5. Update DOPS
						
	
	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.

		Rollback:
			If the build is bad, you can rollback the build to the previous one.  Start by opening
      QA_Data._bwr_Rollback_Build in a builder window.  This provides you with a few options to tailor the 
      rollback to your specific situation. Such as, if the input files are bad and need to be deleted so they are 
      not used again, set "pDeleteInputFiles" to true.
      If the build file is bad(the base file created by the build),
			set "pDeleteBuildFiles" to true.  Also, set the "pversion" to the version of the build you are rolling back, and
			"pIsTesting" to false to perform the rollback.  
			It will rollback the input files used in the build from the "used" or "using" to the "sprayed" superfiles
			(which is where they are at the beginning of the build).  It will also rollback the base file from 
			the father to the qa superfiles.  This will ensure that other builds that use these base file(s) will not 
			pull in bad data.  Deletion will occur after the rollback.  This should be run on hthor.

		
*/