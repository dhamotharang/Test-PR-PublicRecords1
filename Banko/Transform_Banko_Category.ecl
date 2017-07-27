/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		We tranform and translate each record from the input dataset to our defined RECORD
	Requirements:   Each record should contain information.
*/


Layout_CategoryEvent reformat(Layout_CategoryEvent l) := transform
self.CategoryEventID 			:= l.CategoryEventID ;
self.Cat_Event 					:= l.Cat_Event ;
end;

export Transform_Banko_Category := project(File_CategoryEvent,reformat(left));
