/*
Source(s):								Maine Corporations provided by Info ME 		
Update Frequency:					Monthly	
Update Type:							Full Append
Expected Volume of Data:	Approximately 423,000 records		
Data Description:					Corporation Filings	Corporate Filings - The Secretary of State, Corporations Division,
													is the state agency that will process a filing for forming a corporation in a state,
													forming an LLC (limited liability company), and, in most states, for registering trademarks. 						 						
Source Structure:					Files are fixed length
Source Notes:							The source provides one file
Targets:									Base, Annual Reports, Events
Loading Notes:						"Note: the Incorp_date; Qual_date; Filing_date - have to be looked at several ways - Even
													Though the IncorpDate is 75% filled - the Qual_Date and Filing_Date have to be considered
													if those fields are filled - - the different scenarios are broken out;
													The data may contain multiple records for the same corporation - sometimes the records are
													exact duplicates sometimes it is because of a name change - the data should be sorted by
													CORP_ID and SORT_FLD - if the records are exact duplicates - use only one; the record with
													NAME_TYPE 'L' - for legal is the main record - subsequent records with NAME_TYPE A or F are
													assumed and former names  - and require only a record with the corporation id and name
													information; The additional name records will have exact information except for the name_seq_no,
													sort_fld, name_type, corp_name and compr_name. If the Name_type = 'R' then only one record will
													exists - and all information in the record should be included in the corp_base record; If the
													name_type <> 'L' or 'F' or 'A' or 'R' and the corp_10[10..10] = 'R' - create one complete record.
													If name_type not in ['L','F','A','R'] and corp_id[10.10] <> 'R' create only a name record
													(there will be no name type description)"							
*/