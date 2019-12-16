		
	  Vendor:Office of Personnel Management or OPM - Federal Public Employee's Data    
	
		Overview: Office of Personnel Management Build ,A file that contains the names of government employees
 						  This data is being built in support of the Workplace Locator Enhancements Project
							Workplace Locator is just the batch name for Place of Employment (POE). 
							This source is non-FCRA and will be updated monthly. 

							We receive Load(4 text files from OPM), which contains a pipe (|) delimited text 
							file with one header recoed . We use that to update our base file on thor .
							The approximate record count is to start off with  (4M) 4,072,079


		The Build:
			
			Quick Documentation to run the thor build:

				Tapeload02b Dir	:(\\tapeload02b.br.seisint.com)\eval\federal_goverment_public_employees(pi)
				Unix Directory	: bctlpedata11:/data/Builds/builds/OPM/data/<folder date>
				Thor Module			: OPM
				Orbit Build			: OPM
				Frequency				: Monthly - Updates 
				
				1.	The folder on tapeload02b and the text file contents are to be copied into the data directory under
            the OPM folder on bctlpedata11. *NonDOD*.txt files will be picked up 
						by the spray process and put on thor.
				2.	Next, open OPM._BWR_Build_All in a builder window.  Change the pversion to the date that 
            matches the folder date on bctlpedata11. 
				3.  Execute it.
				4.	In Orbit, create a build instance of the "OPM" build.  Add the update file used in the build.
						When the build finishes, update the roxie production status to "On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(OPM._bwr_Build_All):
						1. Sprays the files & adds to sprayed superfiles
					  2. Runs the SALT Ingest process (Full Contiguous Mode, not Incremental and no Delta)
									and builds the base file
						
						
	
	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.
			
