/*
	Debt Settlement:
	
		Overview: Debt Settlement provides a listing of companys and individuals Risk has identified as consumer 
							credit agencies which aide individuals or companies in dealing with their debt.
							The content for this file comes from 3 differnt sources.
							1) The build will pull all companies/addresses from the business header file (thor_data400::base::business_header::qa::best)
									that have a SIC code of 72991001.
							2) TASC (The Assocaition of Settlement Companies) is a non-profit org which contains a file of
									debt settlement companies. http://www.tascsite.org/
							3) RSIH (Rausch, Sturm, Isreal and Hornick) file is a properitary source which is a list of lawyers and
									firm names who handle debt settlement issues.


		The Build:
			
			Quick Documentation to run the build:

				Unix Directory	: edata10:/prod_data_build_13/eval_data/debt_settlement
				Thor Module			: Debt_Settlement
				Tapeload02b Dir	: ???
				Orbit Build			: ???
				Frequency				: Quarterly?
				
				1.	Check for new directory on tapeload02b.
				2.	In the unix directory above, execute:

								process.sh <process_date> <tapeload02b directory> [<dataland or prod>]
				
						The first two parameters are self-explanatory.
						The last parameter is optional, with the default being prod.
						So if you want to test on dataland, put dataland as
						the last parameter, and the process will run, but spray and build on dataland(and not rename the 
						tapeload02b directory).
				
						So, for example, if today is 20080123 and I want to use the 20080122 directory on tapeload02b:
							process.sh 20080123 20080122
							
						Of course you can use nohup and redirect the output to a log file.
				3.	In Orbit, create a build instance of the Zoom build.  Add the update file used in the build.
						When the build finishes, update the status to "build available for use" so that it can be 
						included as an input in the business header build.
				4.	That's it! 	You will receive an email stating that the build has finished.
			
			Build details:
				
				Unix part(process.sh):
						1. Create the tapeload02b directory on unix
						2. Download the zip file from tapeload02b to it
						3. Unzip the file
						4. Concatenate the unzipped files into one csv file
						5. Prepend an underscore to the tapeload02b directory
						6. Kick off the thor build process which includes the spray
						7. Zip up the csv file.
				
				Thor Part(Debt_Settlement._bwr_Build_All):
						1. Spray the file & add to sprayed superfile
						2. Create base files
						3. Create Roxie keys
						4. Output sample records for QA
						5. Strata

						Filenames: The input files names expected by the Spray attribute are:
								1) TASC => 	DebtSettlementCreditCounsel.csv
								2) RSIh =>	attroney_file_did_stats.csv
						
	
	Notes:
		All of the passwords for this process are stored in files with strict permissions so that
		only the owner can read them(chmod 400).
		if you do not already have these files, create them in your home directory:
		~/pwds/tapeload02b
		~/pwds/dataland_thor
		~/pwds/production_thor

		The usernames for tapeload02b and dataland thor are assumed to be the same
		as your unix username (whoami).  The production username adds "_prod" to 
		your unix username.  So you will need to change the username defaults if your unix username
		does not match your thor username.
		
		To run the thor build process manually, open in a builder window:
			Debt_Settlement._bwr_Build_All
			
		Modify pversion to the current date
		Modify the directory to the one created for the new update file.
		Execute it.
		
		The thor process uses the following attribute's email address to send emails:
			Debt_Settlement.Email_Notification_Lists 
		
		Please sandbox this attribute with your email address.  Do not check it in.
		
*/