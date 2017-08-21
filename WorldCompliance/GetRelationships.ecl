
//url := 'https://members.worldcompliance.com/signin.aspx?auth=2d5f10c7-07fe-421c-ad05-a6513ac496d9&amp;ent=';	//[Entities.Ent_ID]'
url :=  'https://members.worldcompliance.com/metawatch2.aspx?id=';	//[DirectID or LookUpID]



EXPORT GetRelationships(dataset(Layouts.rEntity) infileraw,
												dataset(Layouts.rRelationship) relations) := FUNCTION

	infile := DISTRIBUTE(infileraw, Ent_id);
	allEntities := Files.dsEntities;
	rel1 := JOIN(DISTRIBUTE(relations(RelationId<>0),Ent_IDChild), allEntities,  LEFT.Ent_IDChild=RIGHT.Ent_Id, TRANSFORM(rRelationships,
							self.relation := CodeToRelationship(LEFT.RelationID);
							self.sorter := RelationshipSortOrder(LEFT.RelationID);
							self.name2 := RIGHT.name;
							self.DirectId := RIGHT.DirectId;
							self.cmts := TRIM(self.relation) + ' (' + RIGHT.EntryCategory + ':' + RIGHT.EntrySubCategory
												+ '): ' + TRIM(self.name2);
							self := LEFT;
							), INNER, LOCAL);
							
	rel1a := JOIN(rel1, infile, LEFT.Ent_IDChild=RIGHT.Ent_Id, TRANSFORM(rRelationships,
							self.sameFile := RIGHT.Ent_id <> 0;
							self.cmts := LEFT.cmts + IF(self.sameFile, ', ' + (string)LEFT.Ent_IDChild,
										//'(' + url + (string)LEFT.Ent_IDChild + ')');
										' (' + url + Left.DirectID + ')');
							self := LEFT;), LEFT OUTER, LOCAL);
							
	rel2 := SORT(Distribute(rel1a,Ent_IDParent), Ent_IDParent, RelationID, name2, local);
							
	rel3 := JOIN(infile, rel2, LEFT.Ent_ID=RIGHT.Ent_IDParent, TRANSFORM(rRelationships,
							self.name1 := LEFT.name;
							self := RIGHT;
							), INNER, LOCAL);
	
	return rel3;
END;
