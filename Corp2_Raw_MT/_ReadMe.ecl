/*
Source(s):								Montana Secretary of State	
Update Frequency:					Monthly	
Update Type:							Full Append - Actives Only	
Expected Volume of Data:				
Data Description:					"The Montana Corporate Records Data File contains  data extracted from the Montana Secretary
													of State's Corporations System. The Corporations System maintains information about the following
													registered business entities: foreign and domestic corporations , foreign and domestic limited
													liability companies, limited partnerships, limited liability partnerships, assumed business names,
													and trademarks. 

													Mapping is based on the Montana Corporate Records Data File - Technical Guide dated 1/20/2010 found
													on the state's web site.  See tab Vendor Layout Web Site."	
Source Structure:			
Source Notes:				 			Every business entity in active status, with its associated database records, is extracted from
													the Corporations System database, reformatted into fixed length records, written to an extract file.
													Each extract file record contains a business entity ID (positions 1-7), a record type (position 8)
													and data (positions 9-200). The data portion of the extract file record is essentially the entire
													contents of an applicable record from the Corporations System database. There are multiple extract
													file records for each unique business entity:

													1 SSC-BUSN
													2 SSC-BUSNM
													3 SSC-OFCPT
													4 SSC-SHARE
													5 SSC-RLT
													6 SSC-AGOWN
													7 SSC-ABN
													8 8SSC-FRGN
													9 SSC-TM

Loading Notes:
*/