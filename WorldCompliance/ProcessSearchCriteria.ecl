import std;
	rSearchCriteria mergeValue(rSearchCriteria Lft, rSearchCriteria rght) := TRANSFORM
			self.id := Lft.id;
			self.criteria := Lft.criteria + rght.criteria;
	END;

/*
	Country
	Regional Level
	PEP Sub Category
*/
/*
PepCategories(DATASET(Layouts.rEntity) infile) := FUNCTION

//	categories := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaPEP.dsPepSubcategories, 3);
		cats := PROJECT(infile, TRANSFORM(rCriteriaRollup,
											self.id := LEFT.Ent_id;
											self.criteria := LEFT.EntrySubcategory;
											self.criteriaClass := 3;
											self.criteriaValue := 999;));
											
		catsAndValues := JOIN(cats, SearchCriteriaPEP.dsPepSubcategories, LEFT.criteria=RIGHT.name,
												TRANSFORM(rSearchCriteria,
														self.criteria := U'3,' + (unicode)Right.ValueId + U';';
														self := LEFT;), LEFT OUTER);
							
		return catsAndValues;
END;

EddCategories(DATASET(Layouts.rEntity) infile) := FUNCTION
								
		cats := PROJECT(infile, TRANSFORM(rCriteriaRollup,
											self.id := LEFT.Ent_id;
											self.criteria := LEFT.EntryCategory+'-'+LEFT.EntrySubcategory;
											self.criteriaClass := 3;
											self.criteriaValue := 999;));
	
		catsAndValues := JOIN(cats, SearchCriteriaEDD.dsCategory, LEFT.criteria=RIGHT.name,
												TRANSFORM(rSearchCriteria,
														self.criteria := U'3,' + (unicode)Right.ValueId + U';';
														self := LEFT;), LEFT OUTER);
														
		return catsAndValues;
END;
*/

/*WCompCategories(DATASET(Layouts.rEntity) infile) := FUNCTION
								
		dsCategory := PROJECT(AllCategories,rCriteria);
		cats := PROJECT(infile, TRANSFORM(rCriteriaRollup,
											self.id := LEFT.Ent_id;
											self.criteria := LEFT.EntryCategory+'-'+LEFT.EntrySubcategory;
											self.criteriaClass := 3;
											self.criteriaValue := 999;));
	
		catsAndValues := JOIN(cats, dsCategory, LEFT.criteria=RIGHT.name,
												TRANSFORM(rSearchCriteria,
														self.criteria := U'3,' + (unicode)Right.ValueId + U'';
														self := LEFT;), LOOKUP, LEFT OUTER);
														
		return catsAndValues;
END;

WCOCategories(DATASET(Layouts.rWCOCategories) infile) := FUNCTION
								
		dsCategory := PROJECT(AllCategories,rCriteria);
		cats := PROJECT(infile, TRANSFORM(rCriteriaRollup,
											self.id := LEFT.Ent_id;
											self.criteria := LEFT.SegmentType+'-'+if (LEFT.SubCategoryLabel = 'Primary PEP' or LEFT.SubCategoryLabel = 'Secondary PEP',LEFT.SubCategoryDesc,LEFT.SubCategoryLabel);
											self.criteriaClass := 3;
											self.criteriaValue := 999;));
	
		catsAndValues := JOIN(cats, dsCategory, LEFT.criteria=RIGHT.name,
												TRANSFORM(rSearchCriteria,
														self.criteria := self.criteria + (unicode)Right.ValueId + U'';
														self := LEFT;), LOOKUP, LEFT OUTER);
														
		return catsAndValues;
END;

GetCategories(DATASET(Layouts.rEntity) infile) := FUNCTION

		cats := SORT(DISTRIBUTE(WCompCategories(infile), id), id, local);

		missing := JOIN(infile, cats, LEFT.Ent_id=RIGHT.id,
										TRANSFORM(rSearchCriteria,
												self.id := LEFT.Ent_id;
												self.criteria := U'3,999;';), LEFT ONLY);
		
		return cats & missing;

END;
GetMultCategories(DATASET(Layouts.rWCOCategories) infile) := FUNCTION

		cats := SORT(DISTRIBUTE(WCOCategories(infile), id), id, local);

		missing := JOIN(infile, cats, LEFT.Ent_id=RIGHT.id,
										TRANSFORM(rSearchCriteria,
												self.id := LEFT.Ent_id;
												self.criteria := U'3,999;';), LEFT ONLY);
		//criteria := criteria+';';
												
		return cats & missing;

END;
*/
GetSourceCriteria(DATASET(Layouts.rEntity) infile) := FUNCTION

		srcs := DISTRIBUTE(
							JOIN(infile, Files.dsSources, STD.Str.ToUpperCase(LEFT.nameSource)=STD.Str.ToUpperCase(RIGHT.SourceAbbrev),
												TRANSFORM(rSearchCriteria,
														self.id := LEFT.Ent_id;
														self.criteria := U'5,' + (unicode)Right.SourceId + U';';
														self := LEFT;), LOOKUP, LEFT OUTER),
								id);
														
		missing := JOIN(infile, srcs, LEFT.Ent_id=RIGHT.id,
										TRANSFORM(rSearchCriteria,
												self.id := LEFT.Ent_id;
												self.criteria := U'5,999;';), LEFT ONLY, LOCAL);
												
		return SORT(DISTRIBUTE(srcs & missing,id), id, LOCAL);

END;

/*
	Country
	Regional Level
	Adverse Media
*/
EXPORT ProcessSearchCriteria(DATASET(Layouts.rEntity) infile, boolean IncludeSanctionsCriteria) := FUNCTION

	countries := 	GetCountryCriteria(infile);
	regions := GetRegionCriteria(infile);
	//Categories := GetCategories(infile)+GetMultCategories(Layouts.rWCOCategories);

	deceased := GetDeceasedCriteria(infile);
	sources := GetSourceCriteria(infile);
	sanctions := IF (IncludeSanctionsCriteria,$.GetConsolidatedCriteria(infile));

//	crit := SORT(DISTRIBUTE(countries & regions & categories & deceased & sources,id), id, criteria, LOCAL);
		crit := SORT(DISTRIBUTE(countries & regions & deceased & sources & sanctions,id), id, criteria, LOCAL);

	result := ROLLUP(crit, mergeValue(LEFT, RIGHT), id, LOCAL);
	
	return result;

END;
