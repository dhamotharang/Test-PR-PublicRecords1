EXPORT AllRelationships(dataset(Layouts.rEntity) infile) := 
			SORT(DISTRIBUTE(
				RollupRelationships(
					GetRelationships(infile, Files.dsRelationships)),
				Ent_IDChild),
				Ent_IDChild, relationId, LOCAL);
//				: PERSIST('~thor::persist::WorldCompliance::relationships');

