/* Source(s)								: Secretary of State Source - Rhode Island

   Update Frequency					:	Monthly		
   			
   Update Type							:	Full-Append				
   		
   Expected Volume of Data	:	

   Data Description					:	Corporate Filings - The Secretary of State,  Corporations Division,  is the state agency that will process a filing for forming a corporation
														  in a state,  forming an LLC (limited liability company),  and,  in most states,  for registering trademarks. 
   Source Structure					:	csv,  tab delimited
   							
	 Source Notes							: The source provides 12 files -  Amendments (Active,  Inactive), Mergers(Active,  Inactive), Stock(Active,  Inactive), 
															Entities(Active,  Inactive), Names(Active,  Inactive), Officers(Active,  Inactive)

	 Targets                  : Base, Contacts, Stock, Events
																	
   Loading Notes					  : Please note: the entity_id's are numbers - in order to link the various files segments together the field has to be considered an integer;  Also note: the current code refers to the entity_id's in some records as FEIN's - these are not FEIN's,  the field is a unique number assigned by the state.
															For the Merger Records - there are three types of records in the files,  mergers(M),  conversions(V) and consolidations(C) - does not look like it is taken into consideration in production code - but the website indicates the type
	 Per CI 								  : Inactive_Merger vendor raw file is not been used in the mapping code!
*/