Import _control;

//Creates SIC Code Lookup Table from DNB_DMI website  
// https://www.dnb.com/utility-pages/dnb-demographic-firmographic-code-tables.html

  pversion 	      := '20200102'								 ;		// modify to current date
	pDirectory			:= '/data/temp/boneill/training/' +pversion;
	pServerIP				:= _control.IPAddress.bctlpedata12;
	pFilename				:= 'DNB_DMI_sic_8_digit_codes.csv';

SICCodes.BWR_Create_SicCode_Lookup_Table(pversion,pDirectory,pServerIP,pFilename); 