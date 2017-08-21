/*
Source(s):								The Illinois Secretary of State
Update Frequency:					Daily,Monthly
Update Type:							Daily/Monthly, Update Append
Expected Volume of Data:	
Data Description:					Corporate Filings - The Secretary of State, Corporations Division, is the state agency
													that will process a filing for forming a corporation in a state, forming an LLC (limited
													liability company), and, in most states, for registering trademarks. 						

													CORPORATION FILE DUMP INFORMATION
													The Illinois Secretary of State creates a file that is comprised of three (3) different
													record types: Master (736 characters), Assumed Old Name (233 characters), and Stock
													(100 characters).

													The file is transmitted via the File Transfer Protocol.  Every time an update to a 
													record occurs, all three (3) record types will be transmitted, regardless of which
													record was updated; e.g. if an Old Assumed Name record was modified, the Master, all
													Old Assumed Name and all corresponding Stock Information records will be transmitted.

													Three files with differnt record sizes will be included on the transmitted file.  A
													one (1) character transition indicator will be included in the first character of all
													daily records.  Each complete corporate record will be separated by an eighty character
													record consisting of dollar signs ($). 
													
													Note:  The transition indicators are as follows:
													1)The first record of the daily file will consist of the phrase â€œDATE = â€œ in the initial
														positions of the record immediately followed by the date the file was created.
													2)The last record of the daily file will consist of the phrase â€œCOUNT = â€œ and a six (6)
														position digit containing a count of all eighty (80) character records included on the
														file. 									

													The first record type on the file will contain the Master (737 character) records.  Only
													one (1) Master record per file number is possible.  The first position of the record will
													contain a transaction indicator (see the attached Transaction Indicator Code Descriptions
													for an explanation of these codes).

													After all Master records have been processed, the Old Assumed Name (233 characters) record(s),
													if any are available.  Multiple Name records are possible for the same file number.  The
													Secretary of State will transmit all Name records on file regardless of how many, if any,
													Name records were modified, deleted or stored.  If a Name record is deleted, all remaining
													Name records associated with that (unique) file number (excluding the deleted record) would
													be transmitted. 

													Stock Information (101 characters) records will be the last record type in order of
													occurrence on the file.  It is possible to have no Stock records, or to have multiple
													Stock records.  The Stock records will be processed the same as the Name records; i.e.
													if an update occurs, all Stock Information records associated with the file number will
													be transmitted. 

													TRANSITION INDICATOR DESCRIPTION 
													The Transition Indicator will signify which type transaction has occurred.  This indicator
													is in the first position of every record transmitted when the File Transfer is utilized.
													The indicator will not be included on the records for complete file dumps.  Following are
													the applicable codes and their action descriptions: 
													
													Code Protocol     
													1) Stored a new record 
													2) Modified an existing record 
													3) Deleted an existing record 
													4) An associated Stock record 
													5) An associated Name record 

Source Structure:					Fixed, ascii
			
Source Notes:							The source provides one file - Daily - Master, Old Name and Stock - all contained in the
													same file with $$ as record separator and code indicating type of file ; 3 files Monthly
												  (Master, Stock, Old Name) 
													Master 736 chars; Assumed Old Name, 233 Chars, Stock 100 Chars - ASCII - there is a transaction
												  code that is not used.

Targets:									Corporations base, AR, stock, contacts
					
Loading Notes:						NOTE: - the production layout did not follow the state layout (e.g. used a filler to load a
																	fein - and also used some dates to pick up a "minority and female owned IND' - that
																	data is not in the file; See description of Incoming file in the Master Layout Work
																	Sheet - Daily and Monthly have the same 3 files and layouts -  Data has a field for
																	deletes/modifications/adds, etc. not used						
*/
