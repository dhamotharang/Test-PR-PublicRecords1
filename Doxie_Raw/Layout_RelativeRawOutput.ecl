import Relationship;

export Layout_RelativeRawOutput := record
	unsigned8 seq := 0;
	unsigned6 srcDID;
	unsigned1 depth;
	unsigned2 p2_sort := 0;
	unsigned2 p3_sort := 0;
	unsigned2 p4_sort := 0;
	unsigned5 person1;
	unsigned5 person2;
	boolean  same_lname;
	integer3 	recent_cohabit;
	unsigned2 number_cohabits;
	integer2  rel_prim_range;
	unsigned1 TitleNo := 0;
	Relationship.layout_GetRelationship.InterfaceOutput_new -title;
end;




