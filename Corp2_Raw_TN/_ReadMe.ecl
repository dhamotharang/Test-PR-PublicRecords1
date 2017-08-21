/*
Source(s):								Tennessee Secretary of State
Update Frequency:					Monthly
Update Type:							Updates Only
Expected Volume of Data:	
Data Description:					The Secretary of State is responsible for the registration of all Tennessee and out-of-state
													business entities doing business in Tennessee. These business entities include for profit and
													nonprofit corporations, limited liability companies, limited partnerships. limited liability 
													partnerships, general partnerships and for profit benefit corporations. 						
Source Structure:					
Source Notes:							The vendor data consists of 4 data files:  Filing, Party, Filing Name and Filing Annual Report.
Targets:									
Loading Notes:						The primary key is the CONTROL_NO.  Each entity contains a CONTROL_NO that serves as a key to
													the Filing, Party, Filing Name and Filing Annual Report. files.

													Several years ago the state eliminated events in order to provide a smaller download.  All history
													info is available on the stateâ€™s website and searchable by entity name or control number. 
*/