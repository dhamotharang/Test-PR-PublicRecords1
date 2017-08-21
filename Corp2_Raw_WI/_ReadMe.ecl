/* Source(s)								: State of Wisconsin Department of Financial Institution		  
   		
   Update Frequency					: Weekly			
   			
   Update Type							: Full-append			
   		
   Expected Volume of Data	: 850 thousand		
   											
   Data Description					: Corporate Filings -  the state agency that will process a filing for forming a corporation in a state, 
														  forming an LLC (limited liability company), and, in most states, for registering trademarks. 	 
   	
   Source Structure					:	Fixed Length txt file with corporation information in line 1 followed by Registered Agent Information in line 2 and  line 3 - 
															information for each corporation consists of 3 lines of information; the data is in page format
   							
	 Source Notes							: The source provides one file
 
	 Targets									: Target table names : Common Base;  AR; Events
																	
   Loading Notes					  :		
*/