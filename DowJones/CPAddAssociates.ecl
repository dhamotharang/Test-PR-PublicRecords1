IMPORT Worldcheck_Bridger, STD;
assoc := DISTRIBUTE(DowJones.Associations.PublicFigures, (integer)AssociateId) : PERSIST('~thor::persist::capone::publicfigures');

//p := dataset('~thor::persist::capone::publicfigures', recordof(DowJones.Associations.PublicFigures), thor);
//assoc := DISTRIBUTE(p, (integer)AssociateId);

EXPORT CPAddAssociates(dataset(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp) infile,
												dataset(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp) xg = DowJones.File_XG,
												boolean FilterDeceased = true
										) := FUNCTION
		
		f1 := DISTRIBUTE(infile, (integer)id);
		allassociates	:= JOIN(assoc, f1, left.associateId=right.id, TRANSFORM(recordof(assoc), self := left;), INNER, LOCAL);
		uniqueassociates := JOIN(DISTRIBUTE(allassociates, (integer)id),
								f1, left.id=right.id, TRANSFORM(recordof(assoc), self := left;), LEFT ONLY, LOCAL);
								
		associates1 := JOIN(DISTRIBUTE(xg, (integer)id), uniqueassociates, left.id=right.id,
										TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
												self := left;), INNER, LOCAL);
												
		associates := DEDUP(SORT(DISTRIBUTE(associates1,(integer)id), id, local), id, local);
		
		return IF(FilterDeceased, 
								associates(STD.Uni.Find(comments, U'Deceased:', 1)=0),	// ignore deceased associates
								associates);
END;
