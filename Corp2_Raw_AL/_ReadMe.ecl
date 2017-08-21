/*
	Source(s)	Alabama Secretary of State Source - 							
	Update Frequency	Monthly							
	Update Type	Full Append							
	Expected Volume of Data	E.g. 10,000 records							
	Data Description	Corporation Filings	Corporate Filings - The Secretary of State, Corporations Division, is the state agency that will process a filing for forming a corporation in a state, forming an LLC (limited liability company), and, in most states, for registering trademarks. 						
	Source Structure	E.g. Fixed Length, EBCIDIC files - 							
	Source Notes	The source provides nine files;Master:CRMSTPF; Annual Reports: CRANLPF; History:CRHSTPF; BUSINESS NAME: CRBUSPF; INCORPORATERS: CRINCPF; NAME CHANGES: CRNAMPF; OFFICE ADDRESS: CROFFPF; Place of Incorporation (Code Table): CRPLCPF; SERVICE OF PROCESS ADDRESS: CRSERPF							
	Targets	Target table names : Common Base; Common Contacts; Common AR; Common EV;  Common Stock;							
	Loading Notes	Data is in EBCIDIC format with decimal numbers for dates, etc.  SEE TRANSFORMATION NOTES AT THE END OF THE MAPPING							
*/