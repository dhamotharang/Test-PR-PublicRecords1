import ut;

EXPORT fn_valid_source(string source) := function
return if(source in 
[
'Bank of England Sanctions',
'Cmmdty. Fut. Trad. Commission Lst. of Reg. & Self-Reg. Auth.',
'Defense Trade Controls (DTC)Debarred Parties',
'European Union Designated Terrorist Groups',
'European Union Designated Terrorist Individuals',
'FBI Fugitives 10 Most Wanted',
'Financial Crimes Enforcement Network Special Alert List',
'Foreign Agents Registration Act',
'Interpol Most Wanted',
'Interpol Most Wanted - Red Notice',
'OFAC - Palestinian Legislative Council',
'OFAC NON-SDN ENTITIES',
'OFAC Sanctioned Countries',
'OSFI - Canada Entities',
'OSFI - Canada Individuals',
'OSFI CONSOLIDATED LIST',
'Office of Foreign Asset Control',
'Office of the Comptroller of the Currency Alerts',
'Politically Exposed Persons',
'State Department Foreign Terrorist Organizations',
'State Department Terrorist Exclusions',
'US Bureau of Industry and Security - Denied Entity List',
'US Bureau of Industry and Security - Denied Person List',
'US Bureau of Industry and Security Unverified Entity List',
'United Nations Named Terrorists',
'World Bank Ineligible Firms'
]
, 1,0);
						
end;