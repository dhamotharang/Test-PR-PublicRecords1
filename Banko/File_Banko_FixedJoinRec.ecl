/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		Declares a new data table in the supercomputer,
					This is a Fixed Length dataset of the CSV dataset sprayed to thor.
					It uses the BankoJoinRecord layout.
	Requirements:   N/A
*/

export File_Banko_FixedJoinRec(boolean isFCRA = false) := function
	prefix :=  if(isFCRA, 
						DATASET('~thor_data400::banko::fcra::filter::qa::additionalevents',
										{BankoJoinRecord,
											UNSIGNED8 RecPos{virtual(fileposition)}}
										,FLAT), 
						DATASET('~thor_data400::banko::filter::qa::additionalevents',
										{BankoJoinRecord,
											UNSIGNED8 RecPos{virtual(fileposition)}}
										,FLAT));
	return prefix;
end;
