EXPORT dsConsolidatedSanctions := FUNCTION
		ent := $.Files.dsEntities;

		dsConsolidatedRec := ent(EntryCategory='Sanction List' and NameSource='Sanctions' and MasterID=0);
		dsOtherRec 				:= $.Files.dsMasters - dsConsolidatedRec;	
		dsLinkedToConsolidatedRec := dsOtherRec(MasterID in SET(dsConsolidatedRec, Ent_ID));
		dsConsolidated := PROJECT(dsLinkedToConsolidatedRec, TRANSFORM($.rConsolidatedAsscoiations,
   																						self.MasterId := left.MasterId;
   																						self.comments :=  left.NameSource ;
   																						));
		return dsConsolidated;

END;
