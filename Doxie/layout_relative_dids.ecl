IMPORT Relationship;

EXPORT layout_relative_dids := RECORD
  UNSIGNED5 person1;
  UNSIGNED5 person2;
  INTEGER3 recent_cohabit;
  BOOLEAN  same_lname;
  UNSIGNED2 number_cohabits;
  UNSIGNED1 relative_title;
  Relationship.layout_GetRelationship.InterfaceOutput_new.type;
  Relationship.layout_GetRelationship.InterfaceOutput_new.confidence;
  Relationship.layout_GetRelationship.InterfaceOutput_new.isRelative;
  Relationship.layout_GetRelationship.InterfaceOutput_new.isAssociate;
  Relationship.layout_GetRelationship.InterfaceOutput_new.isBusiness;
END;
