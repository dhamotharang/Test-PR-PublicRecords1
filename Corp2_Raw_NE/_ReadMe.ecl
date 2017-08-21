/* Source(s)								:		Nebraska Secretary of State	
   		
   Update Frequency					:		Monthly
   			
   Update Type							:		Full Append	
   		
   Expected Volume of Data	:		
   											
   Data Description					:	 Corporations/Partnerships/LLCs:  A record is defined as a collection of vendor files pertaining
															 to each corporation, partnership or limited liability company.  â€œCorporation Entityâ€ is the â€œmasterâ€ table, 
															 of which there will be only one.  There is typically one Registered Agent record, however, multiple Corporate
															 Officers and Corporate Actions records may exist. All tables are related using by the AcctNumber field.  

															 Each set of related tables will be used to create one or more CORPORATION records, zero-to-many
															 CONTACT and EVENT records and zero-or-one ANNUAL REPORT record. 

															 Trade Marks/Trade Names/Service Marks/Registered Names/Reserved Names:  A record is defined 
															 as a collection of vendor files pertaining to each trade mark, trade name, service mark, 
															 registered or reserved name.  Again, â€œCorporation Entityâ€ is the â€œmasterâ€ table, of which there
															 will be only one.  There will not be a Registered Agent or Corporate Officer record for these
															 data types, however Corporate Actions (history filings) may exist.  
															 All tables are related using by the AcctNumber field.  
 	
   Source Structure					:	
   							
	 Source Notes							: The state sends four data files (CorporationEntity, CorporateOfficers, RegisteredAgent, CorporateActions) and six tables 
															(CorporationType, ListOfStates, CountryCodes, FarmExemption, PositionHeld and ServiceType).
																	
   Loading Notes					  :		
*/					

