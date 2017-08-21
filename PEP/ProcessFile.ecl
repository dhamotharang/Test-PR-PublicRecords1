IMPORT Accuity, Worldcheck_Bridger;

	rSearchCriteria mergeValue(rSearchCriteria Lft, rSearchCriteria rght) := TRANSFORM
			self.id := Lft.id;
			self.criteria := Lft.criteria + rght.criteria;
	END;

/*
	Country
	Regional Level
	PEP Sub Category
*/
ProcessPepCriteria(DATASET(Accuity.Layouts.input.rEntity) infile) := FUNCTION

	countries := 	GetCountryCriteria(infile);
	regions := SearchConditions.FormatSearchCriteria(infile, dsRegion, 2);
	subcategories := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaPEP.dsPepSubcategories, 3);


	crit := SORT(countries & regions & subcategories, id, local);

	result := ROLLUP(crit, mergeValue(LEFT, RIGHT), id, LOCAL);
	
	return result;

END;

/*
	Country
	Regional Level
	Adverse Media
*/
ProcessEddCriteria(DATASET(Accuity.Layouts.input.rEntity) infile) := FUNCTION

	countries := 	GetCountryCriteria(infile);
	regions := SearchConditions.FormatSearchCriteria(infile, dsRegion, 2);
	AdverseMedia := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsAdverseMedia, 3);
	AssociatedEntity := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsAssociatedEntity, 4);
	CompanyOfInterest := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsCompanyOfInterest, 5);
	EndUseControls := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsEndUseControls, 6);
	Enforcement := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsEnforcement, 7);
	ExcludedParty := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsExcludedParty, 8);
	GovernmentCorp := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsGovernmentCorp, 9);
	GovtLinkedCorp := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsGovtLinkedCorp, 10);
	InfluentialPerson := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsInfluentialPerson, 11);
	Investigation := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsInvestigation, 12);
	SanctionList := SearchConditions.FormatSearchCriteria(infile, SearchCriteriaEDD.dsSanctionList, 13);
	
	
	
	crit := SORT(
				countries & regions & AdverseMedia & AssociatedEntity & CompanyOfInterest & EndUseControls & Enforcement
				& ExcludedParty & GovernmentCorp & GovtLinkedCorp & InfluentialPerson & Investigation & SanctionList
								, id, local);

	result := ROLLUP(crit, mergeValue(LEFT, RIGHT), id, LOCAL);
	
	return result;

END;



EXPORT ProcessFile(DATASET(Accuity.Layouts.input.rEntity) infile, boolean isPEP) := FUNCTION

	preprocessed := Accuity.Reformat.outputs.GenericSources(DISTRIBUTE(infile,(integer)id));
	criteria := IF(isPEP, ProcessPepCriteria(infile), ProcessEddCriteria(infile));

	// now add search criteria
	processed := JOIN(preprocessed, criteria, LEFT.id = RIGHT.id, 
											TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp,
													SELF.search_criteria := RIGHT.criteria;
													SELF := LEFT;), LEFT OUTER);
	return processed;



END;