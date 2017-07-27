/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		Declares a new data table in the supercomputer,
					this form is used to read an ASCII CSV file into the Data Refinery
	Requirements:   The CSV file must have a heading, each record my be seperated by |~|
					The last record in the file must have a EOF terminator.
*/

EXPORT Banko_FileDataset := dataset('~thor_data400::in::bankoadditionalevents',Layout_BankoFile,
					CSV(HEADING(0),SEPARATOR('|~|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'),MAXLENGTH(100000)));
