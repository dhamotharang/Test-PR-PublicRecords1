/*
Source:										Texas Secretary of state							
Update Frequency:					Daily							
Update Type:							Full Append							
Expected Volume of Data:	Approximately 32,000 records daily and up to 680,000 records at the end of the month							

Data Description:					Corporation Filings	Corporate Filings - The Secretary of State, Corporations Division,
													is the state agency that will process a filing for forming a corporation in a state, 
													forming an LLC (limited liability company), and, in most states, for registering 
													trademarks. 						

Source Structure:					One CSV file, | delimited, with multiple records types - 01 - 12; the following types 
													are used 02,03,05,06,07,08,09,10,11,12 -							

Source Notes:							Record layout code 01 Delete All Command Record 
													Record layout code 02 Master Record 
													Record layout code 03 Master Address Record 
													Record layout code 04 Reserved 
													Record layout code 05 Registered Agent Record - Business Name 
													Record layout code 06 Registered Agent Record - Personal Name 
													Record layout code 07 Charter Officer - Business Name 
													Record layout code 08 Charter Officer - Personal Name 
													Record layout code 09 Charter Names	Record 
													Record layout code 10 Associated Entity Record 
													Record layout code 11 Filing History Record 
													Record layout code 12 Corp Audit Log Record 
													Record layout code 99 Totals Record 							

Targets:									Target Tables: Corp Main; Contacts, Annual Report, Events							

Loading Notes:						TX corporation file is updated for TAX information using the FTACT file - there is 
													a macro used: Corp2.Mac_mark_tx_standing - and should be run when building TX 
													corporations; updates the corp_standing_code and the corp_state_tax_id and 
													corp_status_comment	

*/