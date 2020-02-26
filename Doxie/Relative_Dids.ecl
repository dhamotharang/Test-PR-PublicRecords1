IMPORT ut, Relationship, doxie;

rels(dataset(doxie.layout_references) dids) := function
		relMod:=Relationship.IParams.getParams();
		// Use relationship proc to retrieve relative dids.
		rdid_ds := project(dids(did>0),transform(Relationship.Layout_GetRelationship.DIDs_layout,SELF:=LEFT,SELF := []));
				
		relationships_neutral := Relationship.proc_GetRelationshipNeutral(rdid_ds,
			RelativeFlag:=TRUE,
			AssociateFlag:=TRUE,
			MaxCount:=ut.limits.RELATIVES_PER_PERSON,
			doSkip:=TRUE,
			HighConfidenceRelatives:=relMod.relationship_highConfidenceRelatives,
			HighConfidenceAssociates:=relMod.relationship_highConfidenceAssociates,
			RelLookbackMonths:=relMod.relationship_relLookbackMonths,
			txflag:=Relationship.Functions.getTransAssocFlgs(relMod.relationship_transAssocMask)
		).result;

		relResult := project(relationships_neutral,
												transform (doxie.layout_relative_dids,
																	self.person1 := left.did1,
																	self.person2 := left.did2,
																	self.recent_cohabit := (left.rel_dt_last_seen/100), // Remove day from date since v2 version only had year/month
																	self.same_lname := left.isanylnamematch,
																	self.number_cohabits := left.total_score,
																	self.relative_title := left.title,
																	self := left,
																	self := []));
		
		return(relResult);
end;

export relative_dids(dataset(doxie.layout_references) dids) := rels(dids);
