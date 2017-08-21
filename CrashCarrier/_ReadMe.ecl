/*
	FMCSA SAFER CrashCarrier Data:
	
		Overview: Federal Motor Carrier Safety Administration (FMCSA) Safety and Fitness Electronic Records (SAFER) Census Crash DataBase provides the CrashCarrier data. 
 							
							We receive a file from FMCSA SAFER, and use it to update our base file on thor.

		The Build:
			
			Quick Documentation about the build:

				Tapeload02b Dir		: \\tapeload02b\k\registrations_motor_vehicles\safer_(pn)_cti\file date
				Unix Directory		: //edata12.br.seisint.com/hds_180/CrashCarrier/date/filedate
				Input File Format	:	Text file
				Record Format			:	tab dilimited file.
				Thor Module				: CrashCarrier
				Orbit Build				: CrashCarrier
				Frequency					:	Quartery â€“ full append.

				The "Automated" process:	
				1.	CrashCarrier has been added to the cron where the script named "CrashCarrier.ksh" scans for a new file on tapeload.
				CRONTAB:
				######## Crash Carrier  ############################
				00 01 * * * nohup /hds_180/CrashCarrier/bin/ CrashCarrier.ksh > "/hds_180/ CrashCarrier /logs/ CrashCarrier _"`date +\%Y\%m\%d`.log 2>&1
				2.  If a new file is found on tapeload then the script takes
								a.) the new file and it is ftp'd to unix
								b.) the new file is unzip'd on unix
										PLEASE NOTE:  The vendor sends three files (Carrier; Event; Master)
										however, ONLY CARRIER data is required for the CrashCarrier build.
								c.) the ecl code named "CrashCarrier.Build_All(pversion,directory) is executed on thor
				3.	CrashCarrier.Build_All - thor part
						a. Create the required superfiles
						b. Spray the file & add to sprayed superfile
						c. Build the base files
						d. Build the Roxie keys
						e. Build Strata
						f. Create QA Sample Records
						g. Update DOPS
				4.	In Orbit, create a build instance of the "CrashCarrier" build.  Add the update file(s) used in the build.
						When the build finishes and goes up into roxie dev, update the roxie production status to 
						"On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.
		
*/
 
