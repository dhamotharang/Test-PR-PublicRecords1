/*
	  Vendor:   Database USA, LLC - Execs at Home
	
		Overview: Database_USA is a national file of active businesses with executives at their home address. 
 							
							http://www.databaseusa.com/

							We receive 1 zipped files from Database_USA, which contains a pipe (|) delimited text 
							(Lexis_Nexis_Exec_at_home*.txt) file. We use that to update our base file on thor and 
							build a LinkID key. The approximate record count is 1 million.

		The Build:
			
			Quick Documentation to run the thor build:

				Tapeload02b Dir	: \business\database_usa\<folder date>
				Unix Directory	: bctlpedata11:/data/hds_180/Database_USA/data/<folder date>
				Thor Module			: Database_USA
				Orbit Build			: Database_USA
				Frequency				: Quarterly - Updates 
				
				1.	The folder on tapeload02b and the zip file contents are to be copied into the data directory under
            the Database_USA folder on bctlpedata11. Unzip the LexisNexis_Exec@Home_Database*.txt file in to the same 
						directory as the zip files. After unzipping, the LexisNexis_Exec@Home_Database*.txt file will be picked up 
						by the spray process and put on thor.
				2.	Next, open Database_USA._BWR_Build_All in a builder window.  Change the pversion to the date that 
            matches the folder date on bctlpedata11. 
				3.  Execute it.
				4.	In Orbit, create a build instance of the "Database_USA" build.  Add the update file used in the build.
						When the build finishes, update the roxie production status to "On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(Database_USA._bwr_Build_All):
						1. Sprays the files & adds to sprayed superfiles
					  2. Runs the SALT Ingest process (Full Contiguous Mode, not Incremental and no Delta)
									and builds the base file
						3. Builds LinkID Key
            4. Runs Scrubs Plus on the new base file
						5. Builds Strata
            6. Create QA Samples
						7. Updates DOPS
						
	
	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.
			
*/