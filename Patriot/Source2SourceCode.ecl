export Source2SourceCode(STRING str) :=
CASE(Stringlib.StringToUpperCase(str),

'US BUREAU OF INDUSTRY AND SECURITY - DENIED ENTITY LIST'	=> 'BXA',
'US BUREAU OF INDUSTRY AND SECURITY UNVERIFIED ENTITY LIST'	=> 'BXA',
'US BUREAU OF INDUSTRY AND SECURITY - DENIED PERSON LIST' 	=> 'BXA',
'BANK OF ENGLAND SANCTIONS'							=> 'ENGLAND',
'OFFICE OF FOREIGN ASSET CONTROL'						=> 'OFAC',
'WORLD BANK INELIGIBLE FIRMS'							=> 'WBNK',
'WORLD BANK REPRIMAND LIST'							=> 'WBNK', // DOES THIS BELONG IN SAME HEADING?
'UNITED NATIONS NAMED TERRORISTS'						=> 'UNSL',
'DEFENSE TRADE CONTROLS (DTC) DEBARRED PARTIES'			=> '',
'OSFI - CANADA'									=> 'OSFI',
'OSFI - CANADA ENTITIES'								=> 'OSFI',
'OSFI - CANADA INDIVIDUALS'							=> 'OSFI',
'INTERPOL MOST WANTED'								=> 'INTERPOL',
'');


/*


	where does this go?
// Statewatch UK - Terrorist Individuals Outside Europe        
// Statewatch UK - Terrorist Individuals Inside Europe         
// Statewatch UK - Terrorist Organizations Outside Europe      
// Statewatch UK - Terrorist Organizations Inside Europe       
Foreign Agents Registration Act                   // Is this FOREIGN or USDOS

*/