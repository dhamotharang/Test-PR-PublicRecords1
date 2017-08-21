EXPORT Associations := MODULE

export rAssociation := RECORD
			string				id						{MAXLENGTH(8)};
			string				AssociateId		{MAXLENGTH(8)};
			string				code					{MAXLENGTH(255)};
			string				relationship 	{MAXLENGTH(255)} := '';
			unicode				associate 		{MAXLENGTH(255)} := '';
			unicode				primary		 		{MAXLENGTH(255)} := '';
			boolean				isPerson;
			boolean				ex;
END;

export PublicFigures := FUNCTION

		rAssociation x(Layouts.rPublicFigure L, Layouts.rAssociate R) := TRANSFORM
				self.id := L.id;
				self.AssociateId := R.AssociateId;
				self.code := R.code;
				self.ex := R.ex = 'Yes';
				self.isPerson := true;
		END;
		
		dFigures1 := NORMALIZE(File_PublicFigures, LEFT.Associates, x(LEFT, RIGHT));
		dFigures2 := JOIN(dFigures1, Lists.RelationshipList, LEFT.code = RIGHT.code, TRANSFORM(rAssociation,
									self.relationship := IF(LEFT.ex, 'Ex-','') + RIGHT.name;
									self := LEFT;), LEFT OUTER, LOOKUP);
		dFigures3 := DISTRIBUTE(dFigures2, (integer)AssociateId);
		dFigures := JOIN(dFigures3, ExtractNames(nameType = 'Primary Name'), LEFT.AssociateId = RIGHT.id, TRANSFORM(rAssociation,
									self.Associate := IF(
													RIGHT.FullName <> '', RIGHT.FullName,
													RIGHT.firstName + ' ' + RIGHT.SurName);
									self := LEFT;), LEFT OUTER, LOCAL);		// ;
		return dFigures;
	END;
	
export SpecialEntities := FUNCTION

		rAssociation x(Layouts.rPublicFigure L, Layouts.rAssociate R) := TRANSFORM
				self.id := L.id;
				self.AssociateId := R.AssociateId;
				self.code := R.code;
				self.ex := R.ex = 'Yes';
				self.isPerson := false;
		END;
		dEntities1 := NORMALIZE(File_SpecialEntity, LEFT.Associates, x(LEFT, RIGHT));
		dEntities2 := JOIN(dEntities1, Lists.RelationshipList, LEFT.code = RIGHT.code, TRANSFORM(rAssociation,
									self.relationship := IF(LEFT.ex, 'Ex-','') + RIGHT.name;
									self := LEFT;), LEFT OUTER, LOOKUP);
		dEntities3 := DISTRIBUTE(dEntities2, (integer)AssociateId);
		dEntities := JOIN(dEntities3, ExtractNames(nameType = 'Primary Name'), LEFT.AssociateId = RIGHT.id, TRANSFORM(rAssociation,
									self.Associate := IF(
													RIGHT.FullName <> '', RIGHT.FullName,
													RIGHT.firstName + ' ' + RIGHT.SurName);
									self := LEFT;), LEFT OUTER, LOCAL);	// ;
		return dEntities;
	END;
	
export AllRelations := FUNCTION
		figures := DISTRIBUTE(PublicFigures&SpecialEntities, (integer)id);
		dFigures := JOIN(figures, DowJones.ExtractNames(nameType = 'Primary Name'), LEFT.id = RIGHT.id, TRANSFORM(rAssociation,
									self.primary := IF(
													RIGHT.FullName <> '', RIGHT.FullName,
													RIGHT.firstName + ' ' + RIGHT.SurName);
									self := LEFT;), LEFT OUTER, LOCAL);		// ;
		return dFigures;
END;

export GetAssociations := FUNCTION

		figures := SORT(DISTRIBUTE(PublicFigures+SpecialEntities, (integer)id), id, code, associate, local);
		
		dComments1 := PROJECT(figures, TRANSFORM(rComments,
										self.id := LEFT.id;
										self.cmts := LEFT.relationship + ': ' + IF(LEFT.Associate='',LEFT.Associateid,LEFT.Associate);
									));
									
		assoc := DISTRIBUTE(AllRelations, (integer)associateid);
		orphans := JOIN(assoc, AllRelations, LEFT.associateid=RIGHT.id, LEFT ONLY, LOCAL);
		dComments2 := PROJECT(orphans, TRANSFORM(rComments,
										self.id := LEFT.associateid;
										self.cmts := LEFT.relationship + ' of ' + LEFT.Primary;
									));

		
		rComments RollRecs(rComments L, rComments R) := TRANSFORM
				self.id := L.id;
				self.cmts := L.cmts + ' | ' + R.cmts;
		END;
				
		dComments := SORT(DISTRIBUTE(dComments1&dComments2,(integer)id), id, LOCAL);
		ritems := ROLLUP(dComments, id, RollRecs(LEFT,RIGHT));
		return PROJECT(ritems, TRANSFORM(DowJones.rComments,
											SELF.cmts := 'Associations: | ' + LEFT.cmts;
											SELF.id := LEFT.id;));
	END;
END;