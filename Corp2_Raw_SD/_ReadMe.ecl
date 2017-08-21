/* Source(s)								:	South Dakota Secretary of State	  
   		
   Update Frequency					:	Monthly		
   			
   Update Type							:	Unload		
   		
   Expected Volume of Data	: 148,000 plus corporation filings as of 3/2015		
   											
   Data Description					:	We receive a full monthly unload.  A record is defined as a collection of various vendor records with the same ENTITY_TYPE and ORIGINAL_CORPORATE_ID. The vendor provides two data files,
															they are: st02d88.asc (Main) and st02d89.asc (Events). A record must contain a Master (main) record. 
   	
   Source Structure					: CSV File	
   							
	 Source Notes							: LN uses two files:  Main (st02d88.asc) and Events (st02d89.asc).  
																	
   Loading Notes					  :		
*/