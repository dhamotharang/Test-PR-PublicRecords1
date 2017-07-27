/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		Declares a new data table in the supercomputer,
					This dataset is the CategoryEvent Lookup Table that was provided.
	Requirements:   The CSV file must have a heading, each record my be seperated by ','
					The last record in the file must have a EOF terminator.
*/

EXPORT File_CategoryEvent := dataset('~thor_data400::in::banko::categoryevent',Layout_CategoryEvent,
					CSV(HEADING(0), SEPARATOR('|~|'), TERMINATOR(['\n', '\r\n']),MAXLENGTH(100000)));