Import _control;

//Creates NAICS Code Lookup Table from North American Industry Classification website 
// https://www.census.gov/eos/www/naics/downloadables/downloadables.html

  pversion 	      := '20171231'								 ;		// modify to current date
	pDirectory			:= '/data/temp/boneill/training/' +pversion;
	pServerIP				:= _control.IPAddress.bctlpedata12;
	pFilename				:= '*NAICS*.csv'; 

NAICSCodes.BWR_Create_NAICSCode_Lookup_Table(pversion,pDirectory,pServerIP,pFilename);