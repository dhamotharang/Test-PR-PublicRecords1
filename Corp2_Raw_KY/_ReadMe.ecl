/*
Source 											KY Secretary of State	
						
Update 											Frequency	Monthly	
						
Update Type 							 	Full Replace		
					
Expected Volume of Data			Approximately 870,000 companies; 1.5 million officers		
					
Data Description						Corporation Filings	Corporate Filings - The Secretary of State, 
														Corporations Division, is the state agency that will process a filing for 
														forming a corporation in a state, forming an LLC (limited liability company), and, 
														in most states, for registering trademarks. 	
														
Source Structure						csv, tab delimited	
						
Source Notes								Provides 2 files; company, officers
							
Targets	Target tables: 			corporate base, contacts, stock		
					
Loading Notes								Corp Filings should be sorted by ID, comptype(descending order), 
														compseq (descending order)							
*/