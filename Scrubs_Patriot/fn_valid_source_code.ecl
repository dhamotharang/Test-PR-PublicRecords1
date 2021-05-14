import STD;

EXPORT fn_valid_source_code(string source_code) := function
return if(trim(std.str.filterout(source_code[1..5],'0123456789-'),left,right)  in
[
	'AQI',	 //United Nations Named Terrorists
	'AQO',	 //United Nations Named Terrorists
	'BES',   //Bank of England Sanctions
	'BROW',  //United Nations Named Terrorists
	'CFT',   //Cmmdty. Fut. Trad. Commission Lst. of Reg. & Self-Reg. Auth.
	'DEL',   //US Bureau of Industry and Security - Denied Entity List
	'DPL',   //US Bureau of Industry and Security - Denied Entity List
	'DTC',   //Defense Trade Controls (DTC)Debarred Parties
	'EUG',	 //European Union Designated Terrorist Groups
	'EUI',	 //European Union Designated Terrorist Individuals
	'FARA',  //Foreign Agents Registration Act
	'FBI',	 //FBI Fugitives 10 Most Wanted
	'IMW',   //Interpol Most Wanted
	'INT',	 //Interpol Most Wanted - Red Notice
	'OCC', 	 //Office of the Comptroller of the Currency Alerts
	'OCE',   //OSFI - Canada Entities
	'OCI',   //OSFI - Canada Individuals
	'OFAC',  //Office of Foreign Asset Control/OFAC - Palestinian Legislative Council
	'OSC',   //OFAC Sanctioned Countries
	'PEP',   //Politically Exposed Persons
	'REGI',	//United Nations Named Terrorists
	'SDFTO', //State Department Foreign Terrorist Organizations 
	'SDTE',  //State Department Terrorist Exclusions
	'UVE',	 ////US Bureau of Industry and Security Unverified Entity List
	'SPECL', //Financial Crimes Enforcement Network Special Alert List     
	'WBI'  	 //World Bank Ineligible Firms
	]
,1,0);
						
end;