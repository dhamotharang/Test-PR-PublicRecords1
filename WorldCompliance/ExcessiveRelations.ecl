EXPORT ExcessiveRelations := FUNCTION
	rels := DISTRIBUTE(WorldCompliance.Files.dsRelationships,Ent_IDParent);
	tab := TABLE(rels, {rels.Ent_IDParent, n := COUNT(GROUP)}, Ent_IDParent, LOCAL);
	return tab(n > 500);
END;