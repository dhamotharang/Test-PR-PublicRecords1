/*	
	Source(s)        		Oklahoma Secretary of State				 							
	Update Frequency		Weekly												
	Update Type		      Updates												
	Data Description		The Oklahoma vendor data consists of nine data files and eight translation tables. 
                      There is a total of 99 tilde-delimited fields.  Each record is preceded by a two-digit
                      number representing the record type.  The first row in each record is a header; 
                      the final record in the file is a trailer.  

	A record is defined as a collection of all vendor files pertaining to a company.  All records for a company are 
	associated by the FILING_NUMBER field which is present on each vendor record.  The FILING_NUMBER is the primary key 
	for each company.  The only exception to this is the Entity Address record, which is related to its corresponding
	records via the ADDRESS_ID field. 

	There will be one vendor Entity Information record, one Agent Information record and the potential for multiples of
	all others.  This data will be used to create one or more CORPORATION records (to accommodate multiple company names
	and associated entities), one ANNUAL-REPORT report and zero-to-many STOCK, CONTACT and EVENT records. 
*/