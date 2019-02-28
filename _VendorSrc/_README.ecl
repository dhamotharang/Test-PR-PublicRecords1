/*
	AlloyMediaConsumer:
	
		Overview: Alloy Media's "Alloy Directory" file is an unrelated and a separate data feed to the 
							"College Directory" file.

							Alloy Media, LLC is a subsidiary of Alloy Media + Marketing, Inc., which is a marketing company 
							that specializes in the youth/young adult population of consumers.

							Under the Alloy corporate umbrella are three divisions: Alloy Entertainment, Alloy Digital 
							and Alloy Education.  According to Alloy, the Alloy Digital division " ... controls the top 
							ranked and largest media and advertising network of youth targeted websites, according to 
							comScore Media Metrix ... Alloy Digital reaches over 70 million young consumers every month 
							through its network of premium, highly trafficked and monitored websites"; while 
							Alloy Education "... offers the most comprehensive youth database."
							
							Alloy owns a network of college and scholarship search sites where consumers "opt-in" in order 
							to receive information related to colleges and college admission procedures, as well as ordering 
							merchandise or catalogs/magazines. These sites include: 
										- FindYourEducation.com
										- FindTuition.com
										- CareersAndColleges.com
										- CollegExpress.com
										- Delias.com

							Alloy collects personal information, as well as other related demographical and search information, 
							on a consumer who registers (opts-in) to use  one of their sites.

							Th file contains â€œnon-directoryâ€ data (i.e., it is not a student list) and is collected from 
							the websites owned by Alloy (described above).  The Alloy Directory is more of a ""person"" 
							file that only contains personal data such as, name, address, date of birth, phone number, 
							and email address, but does not contain school-related information (unless the email address 
							is an indicator of which school the individual attends). The Alloy Directory reflects 
							the subset of the population that is, at a minimum, interested in attending an institution 
							of higher education; i.e., the â€˜core studentâ€™ population, where the persons in the file typically 
							have ages ranging from 18-30.
							
							The Alloy Directory data is updated at Alloy on a monthly basis but LN will receive updates 
							on a quarterly basis. 					


							The Alloy Directory data has the following restrictions:
							LN is prohibited from selling, sublicensing or leasing, transferring or otherwise providing 
							the Alloy data in its  raw form to any third party.
							Product restriction: Cannot use the Alloy data on a standalone basis.
							Bulk data is part of the existing Alloy Media contract. 
							FCRA Use is allowed.

		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: AlloyMediaConsumer
				Orbit Build			: Alloy Media Consumer
				DOPS package		: There are no request for keys at the time 
				Frequency				: Quarterly
				Landing Path		: \\tapeload02b\k\people\miscellaneous_people\alloy_media_(ei)\alloy_directory\
				
				1. 	FTP monthly file to //edata12/hds_180/alloy_consumer/[version]
				2.	Open AlloyMediaConsumer._BWR_Build and execute the code in that attribute.  Change the version to the files date (YYYYMMDD).
						That should the same date used for the folder created in step 1.  
				3.	In Orbit, create a build instance of the "Alloy Media Consumer" build.  
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.

			

						
	
	