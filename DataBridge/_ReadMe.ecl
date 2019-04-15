/*
	  Vendor:   Database USA, LLC
	
		Overview: DataBridge is a national file of active businesses that offers broad use rights,
              firmographic coverage, and consumers connected to businesses. This file is valuable to enrich 
              our firmographic death and to connect consumers to businesses.
 							
							http://www.databaseusa.com/

				*******			We receive 1 zipped files from Infutor, which contains a pipe (|) delimited text (LN_*_database.txt) file. 
							We use those to update our base file on thor and build LinkID keys.  
							The approximate record count is 25 million.

		The Build:
			
			Quick Documentation to run the thor build:

				*****Tapeload02b Dir	: business\databridge
				*****Unix Directory	: bctlpedata11:/data/hds_180/DataBridge/data/<folder date>
				Thor Module			: DataBridge
				Orbit Build			: DataBridge
				Frequency				: Monthly - Updates 
				
				1.	The folder on tapeload02b and the zip file contents are to be copied into the data directory under
            the DataBridge folder on bctlpedata11. Unzip the LN_*_database.txt file in to the same directory as the zip files.
            After unzipping, the LN_*_database.txt file will be picked up by the spray process and put on thor in 1 file.
				2.	Next, open DataBridge._BWR_Build_All in a builder window.  Change the pversion to the date that 
            matches the folder date on bctlpedata11. 
				3.  Execute it.
				4.	In Orbit, create a build instance of the "DataBridge" build.  Add the update file used in the build.
						When the build finishes, update the roxie production status to "On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(DataBridge._bwr_Build_All):
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
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.
			
*/