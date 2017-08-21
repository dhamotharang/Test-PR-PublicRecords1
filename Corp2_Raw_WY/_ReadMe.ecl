/*
Source(s):								Wyoming Secretary of State	
Update Frequency:					Monthly
Update Type:							Full append
Expected Volume of Data:	Approximately 143 thousand filing records
Data Description:					Corporation Filings
													Corporation Filings	Corporate Filing - The Secretary of State, Corporations Division, is the state
													agency that will process a filing for forming a corporation in a state, forming an
													LLC (limited liability company), and, in most states, for registering trademarks. 								
Source Structure:					csv, | delimited
Source Notes:							Source provides 3 files, filing, filing_annual_report, party		
Targets:									Target table names : Common Base; Contacts, AR, Stock
Loading Notes:						Party table contains RA information - the file seems skewed - extraneous carriage
													return/line feed; the filing id (numeric)  is supposed to be in the first field - might be used
													to determine good record; had problem with filing and party files						
*/