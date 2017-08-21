EXPORT RollupRelationships(dataset(rRelationships) infile) := FUNCTION

		rRelationships RollRecs(rRelationships L, rRelationships R) := TRANSFORM
				self.Ent_IDParent := L.Ent_IDParent;
				self.cmts := L.cmts + ' | ' + R.cmts;
				self := L;
		END;
			
		dComments := SORT(DISTRIBUTE(infile,Ent_IDParent), Ent_IDParent, sorter, name2, LOCAL);
		// limit to top 500 relationships
		WorldCompliance.rRelationships xLimit(WorldCompliance.rRelationships L, integer n) := TRANSFORM, SKIP(n > 500)
								self.rid := n;
								self := L;
		END;		
		dComments1 := PROJECT(SORT(GROUP(dComments, Ent_IDParent), sorter, name2),xLimit(LEFT,COUNTER));
		ritems := ROLLUP(UNGROUP(dComments1), RollRecs(LEFT,RIGHT), Ent_IDParent);

		return PROJECT(ritems, TRANSFORM(rRelationships,
											//SELF.cmts := 'Associations: | ' + LEFT.cmts;
											SELF.cmts := LEFT.cmts;
											//SELF.Ent_IDParent := LEFT.Ent_IDParent;
											self := LEFT;));
END;