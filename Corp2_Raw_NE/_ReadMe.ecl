/* Source(s)								:		Nebraska Secretary of State	
   		
   Update Frequency					:		Monthly
   			
   Update Type							:		Full Append	
   		
   Expected Volume of Data	:	  Data Files
                                ----------
																CorporationEntity approx 400,000 recs
																CorporateActions approx 2.6 million recs
															  CorporateOfficers approx 1.1 million recs
                                RegisteredAgent approx 178,000 recs

																Lookup Tables
																-------------
																CountryCodes approx 226 recs
																ListOfStates approx 69 recs
                                CorporationType approx 51 recs

   											
   Data Description					:	  Corporations/Partnerships/LLCs:  A record is defined as a collection of vendor files pertaining
															  to each corporation, partnership or limited liability company.  “Corporation Entity” is the “master” table, 
															  of which there will be only one.  There is typically one Registered Agent record, however, multiple Corporate
															  Officers and Corporate Actions records may exist. All tables are related using by the AcctNumber field.  

															  Each set of related tables will be used to create one or more CORPORATION records, zero-to-many
															  CONTACT and EVENT records and zero-or-one ANNUAL REPORT record. 

															  Trade Marks/Trade Names/Service Marks/Registered Names/Reserved Names:  A record is defined 
															  as a collection of vendor files pertaining to each trade mark, trade name, service mark, 
															  registered or reserved name.  Again, “Corporation Entity” is the “master” table, of which there
															  will be only one.  There will not be a Registered Agent or Corporate Officer record for these
															  data types, however Corporate Actions (history filings) may exist.  
															  All tables are related using by the AcctNumber field.  
 	
	 Source Notes							:   The state sends the files in JSON format which is similar to XML tagging. 
 
																They send four data files:
																  1.  CorporationEntity (about 5 files sprayed into 1 file)
																	2.  CorporateOfficers (about 16 files sprayed into 1 file)
																	3.  RegisteredAgent (1 file)
																  4.  CorporateActions (about 27 files sprayed into 1 file)

																And five lookup tables, but we only use these three: 
																  1.  CorporationType
															    2.  ListOfStates
                                  3.  CountryCodes

																The files need to be sprayed as 'VARIABLE' with field separator as '' and record separator as
																'},{,]' for the Data files and '\\]' for the lookup tables.  Then the files need to be read on 
																thor like this: CSV(SEPARATOR(['']),TERMINATOR(['},{'])).  In the Corp2_Raw_NE.Files attribute, 
																the files are parsted into the correct layouts and the FROMJSON function is used to convert the 
																json tagging into fixed layouts.
                               																
*/					

