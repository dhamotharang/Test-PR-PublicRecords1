/*
	  Vendor:   Equifax Business Data - MDS
	
		Overview: Equifax Business Data contains Marketing Data Solutions. 

              We receive 1 zipped file from Equifax each month, which each contain a 
              tab-delimited text (*.txt) file.  The files are used to update a base file 
              on thor and to create LinkID keys. The record count is approximately 42
              million.  

		The Build:
			
			Quick Documentation to run the thor build:

				Tapeload Dir	: business\equifax_business_data
				Unix Directory	: /data/equifax_business_data/<folder date>
				Thor Module			: Equifax_Business_Data
				Orbit Build			: Equifax_Business_Data
				Frequency				: Monthly Unload.
				
				1.	The folder on tapeload and the zipped file contents are to be copied into 
            the data directory under the equifax_business_data unix directory folder. Unzip
            the *.txt file in to the same directory as the zip file.
            After unzipping, the *.txt file will be picked up by the spray process and put 
            on thor.
				2.	Next, open Equifax_Business_Data._BWR_Build_All in a builder window.  Change 
            the pversion to to the date that matches the folder date. 
				3.  Execute it.
				4.	In Orbit, create a build instance of the "Equifax_Business_Data" build.  Add the
            update file used in the build.  When the build finishes, update the production 
            status to "On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email 
            if it fails.
			
				Thor Part(Equifax_Business_Data._BWR_Build_All):
						1. Sprays the files & adds to sprayed superfiles
            2. Standardized the input.
					  3. Runs the SALT Ingest process (Full Contiguous Mode, not Incremental and no 
               Delta) and builds the base file.
            4. Standardizes/Normalizes Names and Addresses. (Not using NID on names since 
                  they are company names not contact names.)
						3. Builds LinkID Keys
            4. Runs Scrubs Plus/Orbit on the new base file
						5. Builds Strata
						6. Runs BIPStats
            7. Create QA Samples
						8. Updates DOPS via email.
						
	Notes:
		
		Normalization is as follows – 

			Create up to 4 records out of one if the EFX_LEGAL_NAME field is populated & both 
      addresses are also populated.

				1)      The EFX_NAME  and the EFX_ADDRESS.  Company Type = DBA if EFX_NAME not 
                equal to EFX_LEGAL_NAME.  Otherwise Company Type = LEGAL and record 3 below 
                will not be created.  Address Type = Physical unless it contains a PO BOX.
				2)      The EFX_NAME  and the non blank EFX_SECADDR.  Company Type = DBA if EFX_NAME
                not equal to EFX_LEGAL_NAME.  Otherwise Company Type = LEGAL and record 4 
                below will not be created.  Address Type = Mailing.
				3)      The EFX_LEGAL_NAME (non blank and not the same as EFX_NAME) and the 
                EFX_ADDRESS.  Company Type = Legal, Address Type = Physical unless it 
                contains a PO BOX.
				4)      The EFX_LEGAL_NAME (non blank and not the same as EFX_NAME) and a non blank 
                EFX_SECADDR.  Company Type = Legal, Address Type = Mailing.


		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.
			
*/