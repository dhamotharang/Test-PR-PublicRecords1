/*
Source(s):								The Illinois Secretary of State
Update Frequency:					Monthly
Update Type:							Update - Append
Expected Volume of Data:	
Data Description:					Corporate Filings - The Secretary of State, Corporations Division, is the state agency that will
													process a filing for forming a corporation in a state, forming an LLC (limited liability company),
													and, in most states, for registering trademarks. 						

Source Structure:					Fixed, ascii
			
Source Notes:							One file with Master, Assumed Name, Old Name, Admitting Name and General Partner records will be
													included in the file. Master records, Assumed Name records, Old Name records, Manager Member records,
													Admitting Name records and deleted records.  The Master record contains the agent name and address
													information.  There is no associated state field as all agents must have/use and Illinois address.

Targets:									Corporations base, Annual Report, Contacts
					
Loading Notes:						NOTE: - See worksheet Layouts LP for notes on the way the file is set up.
*/