/*
Source(s):								Colorado Dept. of State		
Update Frequency:					Weekly
Update Type:							Full append
Expected Volume of Data:	Approximately 1.5 million corporation records, 200k tradenames, 550 trademarks
Data Description:					Corporation Filings
Source Structure:					The files are tab delimited in the latest files; the trademark file was | delimited
													but in the next delivery may be tab delimited
Source Notes:							The source provides 7 files - the mstr(corp record), hist(events and AR), hist2(events and AR),
													trnm(tradename) contain data; the other 3 are layout, date and notes

													Also supplies tradmark data in 7 files - those files are | delimited in the June data
Targets:									Target table names : Common Base; AR, Events, Contacts
Loading Notes:										
*/