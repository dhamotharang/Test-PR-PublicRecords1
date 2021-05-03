Import _control, NAICSCodes;

// Creates NAICSCode lookup table for use by builds to validate NAICSCodes.  Creates the 
// table from the following NAIC websites:
//
// Government website - https://www.census.gov/eos/www/naics/downloadables/downloadables.html
//
// DNB DMI Website - https://www.dnb.com/utility-pages/dnb-demographic-firmographic-code-tables.html

  pversion 	      := '20171231'								 ;		// modify to current date
	pDirectory			:= '/data/temp/boneill/training/' +pversion;
	pServerIP				:= _control.IPAddress.bctlpedata11;
	pFilename				:= 'NAICS*Codes.csv'; 
	pDnbDmiFileName := 'naics*dnb_dmi.csv';

NAICSCodes.BWR_Create_NAICSCode_Lookup_Table(pversion,pDirectory,pServerIP,pFileName,pDnbDmiFileName);