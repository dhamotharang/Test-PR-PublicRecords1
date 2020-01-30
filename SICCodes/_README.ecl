/*
	  Vendor:   SICCodes from DNB_DMI
	
		Overview: Creates SicCode lookup table for use by builds to validate SicCodes.  Creates the 
              table from the following DNB_DMI website:

              https://www.dnb.com/utility-pages/dnb-demographic-firmographic-code-tables.html

		          Needs to be run any time the SicCodes are updated if known or at least a couple 
              times a year in order to have a current version of the SicCodes from DNB_DMI.  The 
              DNB_DMI 8 digit code excel spreadsheet needs to be saved as a csv file and loaded to
              tapeload by Data Receiving.  Then Data Ops needs to copy the data to edata11 and 
              follow the directions below.

		To Run The Build:
			
      1. Edit SICCodes._BWR_Create_SicCode_Lookup_Table. Parameters defined below.

				pversion	  : date in Unix directory
				pDirectory  : /data/hds_180/SicCodes/build/<pversion>
				pServerIP	  : _control.IPAddress.bctlpedata11
				pFileName		: '*sic*.csv';

      2. Submit SICCodes._BWR_Create_SicCode_Lookup_Table
     
      3. Example of edited BWR.

pversion 	:= '20200102'								 ;		// modify to current date
	pDirectory			:= '/data/temp/boneill/training/' +pversion;
	pServerIP				:= _control.IPAddress.bctlpedata11;
	pFilename				:= 'DNB_DMI_sic_8_digit_codes.csv';

SICCodes.BWR_Create_SicCode_Lookup_Table(pversion,pDirectory,pServerIP,pFilename); 
			
*/