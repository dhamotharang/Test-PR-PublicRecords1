/*2009-10-22T20:16:23Z (Gavin Witz_prod)
changes made to replace CatEvent field with CatEvent_Description and CatEvent_Category
*/
/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		We create a RECORD of a few fields from CategoryEvent Lookup Table, 
					We will use CategoryEventID to join with another table, Cat_Event is the concatenation
					of Category and Event
	Requirements:   Should contain the fields in the dataset.
*/

//NOTE: WE MIGHT HAVE TO ADD FOR FIELDS IS REQUIRED. DO THAT HERE 
export Layout_CategoryEvent := RECORD
STRING10  	CategoryEventID;
STRING200  	Cat_Event;
STRING200  	Description;
STRING200  	Category;
STRING200  	Description_3;
STRING10	Flag;
END;