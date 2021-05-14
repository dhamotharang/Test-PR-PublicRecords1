/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		To create an INDEX for Court_code and Cat_Event and payload the rest of the info
					from File_Banko_FixedJoinRec.
	Requirements:   N/A
*/
IMPORT dx_Banko;
export Data_Key_Banko_courtcode_casenumber(boolean isFCRA = false) := function

df       := File_Banko_FixedJoinRec(isFCRA);

return  PROJECT(df, dx_Banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber);
												
END;