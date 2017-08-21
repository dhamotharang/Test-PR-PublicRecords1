/* Source(s)								: West Virginia Secretary of State

   Update Frequency					:	Weekly		
   			
   Update Type							:	Update - append, daily, weekly, monthly update				
   		
   Expected Volume of Data	:	10,000 corp records monthly, 76 thousand addresses and contacts, 
															10,000 annual reports, also dba, mergers, amendments, dissolutions, name changes, subsidiaries	
   											
   Data Description					:	Corporate Filings - The Secretary of State, Corporations Division, is the state agency that will process a filing for forming a corporation in a state, 
															forming an LLC (limited liability company), and, in most states, for registering trademarks.  
   	
   Source Structure					:	csv, ~ delimited
   							
	 Source Notes							:The source provides nine files in 3 zipped files for weekly, daily, monthly

	 Targets                  :Target table names: Corp Main, Contacts, Stock, Annual Reports; events 
																	
   Loading Notes					  : RA and Corporation address in file addresses		
*/