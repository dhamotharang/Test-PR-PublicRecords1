/* Source(s)								:		North Carolina Secretary of State	
   		
   Update Frequency					:		Weekly
   			
   Update Type							:		Full Append	
   		
   Expected Volume of Data	:		
   											
   Data Description					:	The vendor data is organized in a relational database consisting of names, 
															corporations - LLCs; LPs and LLPs.  The primary key is EntityID.  PItemID is the only unique identifier for a 
															corporation.  The state emphasizes not to use the CorpNum as an identifier because of the mingling of LP's 
															and Corporations in the same databases.
 	
   Source Structure					:	
   							
	 Source Notes							: The vendor data consists of  multiple textual (.txt) files in a relational table format that are comma-delimited. 
															There multiple  data files (Names.txt; Addresses.txt; Corporations.txt; CorpStatus, Filings.txt,  CorpOfficers, 
															Stock, NameReservations and accompanying reference data files (NameTypes.txt; AddressTypes.txt; EntityTypes.txt; 
															CorpTypes.txt; DocTypes.txt, CitizenTypes, PartyType and StockClass) that will serve as explosion code tables. 
															The primary key is the EntityID.

   Loading Notes					  :	As of August 2016 ,Officers, Partners and Directors input files are no longer being used as inputs in the mapper code!!
                              input file CorpOfficers contains all the Officers, Partners and Directors info and it is a replacement for these three files.

                              
*/					

