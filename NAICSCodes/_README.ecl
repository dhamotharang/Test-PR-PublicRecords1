/*
	  Vendor:   NAICSCodes from North American Industry Classification website

	
		Overview: Creates NAICSCode lookup table for use by builds to validate NAICSCodes.  Creates the 
              table from the following NAIC website:

              https://www.census.gov/eos/www/naics/downloadables/downloadables.html

		          Needs to be run at least every 5 years when the NAICSCodes are updated 
              in order to have a current version of the NAICSCodes.  The current table 
							was created from the 2017 version.  They are scheduled to be updated on the above 
              website in 2022. At leaset every 5 years the current version excel spreadsheet needs 
              to be saved as a csv file and loaded to tapeload by Data Receiving.  Then Data Ops 
              needs to copy the data to edata11 and follow the directions below.

		To Run The Build:
			
      1. Edit NAICSCodes._BWR_Create_NAICSCode_Lookup_Table. Parameters defined below.

				pversion	  : date in Unix directory
				pDirectory  : /data/hds_180/NAICSCodes/build/<pversion>
				pServerIP	  : _control.IPAddress.bctlpedata11
				pFileName		: '*NAICS*.csv';

      2. Submit NAICSCodes._BWR_Create_NAICSCode_Lookup_Table
     
      3. Example of edited NAICSCodes._BWR_Create_NAICSCode_Lookup_Table.

Import _control;

pversion 	:= '20171231'								 ;		// modify to current date
	pDirectory			:= '/data/temp/boneill/training/' +pversion;
	pServerIP				:= _control.IPAddress.bctlpedata11;
	pFilename				:= 'NAICS2017Codes.csv';

NAICSCodes.BWR_Create_NAICSCode_Lookup_Table(pversion,pDirectory,pServerIP,pFilename); 
			
*/