EXPORT dsConsolidatedSanctions := FUNCTION
		ent := $.Files.dsEntities;
				//usefileA := Distribute(($.Files.dsEntities),Ent_ID);
				//ent := DEDUP(SORT($.Files.dsMasters_base, ent_id, EntryCategory, EntrySubcategory, local),
				//				Ent_ID, EntryCategory, EntrySubcategory,ALL);

		dsConsolidatedRec := ent(EntryCategory='Sanction List' and NameSource='Sanctions' and MasterID=0);
		dsOtherRec 				:= $.Files.dsMasters - dsConsolidatedRec;	
		dsLinkedToConsolidatedRec := dsOtherRec(MasterID in SET(dsConsolidatedRec, Ent_ID));
		dsConsolidated := PROJECT(dsLinkedToConsolidatedRec, TRANSFORM($.rConsolidatedAsscoiations,
   																						self.MasterId := left.MasterId;
   																						self.comments :=  left.NameSource ;
   																						));
		return dsConsolidated;

END;
