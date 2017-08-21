/*
Source(s):								The Illinois Secretary of State
Update Frequency:					Weekly
Update Type:							Update - Append
Expected Volume of Data:	
Data Description:					Corporate Filings - The Secretary of State, Corporations Division, is the state agency that will
													process a filing for forming a corporation in a state, forming an LLC (limited liability company)
													and, in most states, for registering trademarks.
Source Structure:					Fixed, ascii
			
Source Notes:							"One file with four record types: Master; Assumed Name; Old Name; Member Manager record; All of
													the record types will be transmitted in fixed-length four hundred and twenty (420) character
													records.  All fields therein, character or numeric, are in display format (i.e. no packed fields).
													There will be one (1) Master and any number of Assumed Name Old Name and Manager Member records
													(as have the same file number as the Master) - ASCII;
													
													The first record of every group of records, will be the Master record.  There will be only one (1)
													Master record per grouping, but there has to be one.  The first position of the record will 
													contain a ""M"".  The next record type will be the Assumed Names.  If any are available, an ""A""
													will be in the first character of that record.  All Assumed Names, regardless of how many, will be
													transmitted.  The next record type to be included will be Old Names.  The first character of this 
													record will contain an ""O"", if any Old Names are available, all Old Names will be transmitted.  
													The fourth record type will be Manager Member records.  The first position of this record will contain
													a ""P"".  All Manager Members on file will be transmitted. The first position of the record will
													contain a ""D"" if the record .is to be deleted from the database. "	

Targets:									Corporations base, Corp contacts
					
Loading Notes:						NOTE: - See Layouts LLC worksheet for the way the file is set up.			
*/