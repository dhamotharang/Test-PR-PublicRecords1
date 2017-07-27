import Relationship;

export layout_relative_dids_v3 := RECORD
  unsigned5 person1;
  unsigned5 person2;
  integer3 recent_cohabit;
	boolean  same_lname;
  unsigned2 number_cohabits;
	unsigned1 relative_title;
	Relationship.layout_GetRelationship.InterfaceOuput -title;
END;