/*
	PSS:
	
		Overview: Phone Status Service (PSS) data is customers' requests extracted from Work Place Locator (WPL), and then
							sent for dialing to Accutrac.  Accutrac take up to 15 days to return the file with the dialing results.
							The data sent to and received from Accutrac will be joined and used as a source for WPL.  

							The files sent (request) and received (response) to/from Accutrac are automatically placed in edata12 by batch.  
							The request file is place in the directory as soon as the data is extracted from WPL, and within 15 
							days the corresponding response file will also be place in the directory.  Once there is a pair of files
							(request and response), they can be processed in the PSS build.  The build can process only one pair at 
							a time.  A pair of files will have the same jobid.

		The Build: 
			Quick Documentation to run the thor build:

				Landing Path		: //edata12/hds_180/phone_status_service/in_prod
				Request file	  : PhoneStatus_Request_[jobid].csv
				Response file   : PhoneStatus_Response_[jobid].csv.csv
				Thor Module			: PSS
				Orbit Build			: Phone Status Service
				DOPS package		: PssKeys
				Frequency				: Whenever a pair of files (request and response) are available in the landing path	
				Automation			: The /hds_180/phone_status_service/bin/pss_build.ksh script runs daily at 6am in the 
                          hozed cron on Edata12.  The script will look for new files, spray to Thor, and send
				                  email notifications.

			Build instructions:	
				 Updated 3/15/13 - The newly added automation now performs the following:
			   Monitor the landing path and when a pair of files is available:
				1.  Send an email to DataReceiving@lexisnexis.com to request the logging of a receiving instance.  Include the
						file landig path and name and the date received.
				2.	For each pair to be processed:
						Open PSS._BWR_Build and execute the code in that attribute.  Enter the job id for the files to be process
						and the version date in format YYYYMMDD (the date when the response file was received).  
				3.	In Orbit, create a latest build instance of the "Phone Status Service" build for te latest build run in
						a single day.
				4. Move processed files to history //edata12/hds_180/phone_status_service/in_prod/history

			This data is time sensitive, so it needs to be release to production as soon as possible.
*/


			

						
	
	