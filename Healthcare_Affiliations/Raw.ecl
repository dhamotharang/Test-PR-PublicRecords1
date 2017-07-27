IMPORT iesp, Org_Mast, HMS;

EXPORT Raw := MODULE

	EXPORT getRecords(DATASET(Healthcare_Affiliations.Layouts.Batch_in) inRecs, Healthcare_Affiliations.Layouts.RunTimeConfig cfg) := FUNCTION
	
		// Constants
		
		Relationship1 := Org_Mast.Keys(,Healthcare_Affiliations.Constants.useProd).Affiliates_Key1.qa;
		Relationship2 := Org_Mast.Keys(,Healthcare_Affiliations.Constants.useProd).Affiliates_Key2.qa;
		Provider := HMS.Keys(,Healthcare_Affiliations.Constants.useProd).Provider_PIID.QA;
		Facility := Org_Mast.Keys(,Healthcare_Affiliations.Constants.useProd).Facilities_LNFID.qa;

		// Search for relationships 
		
		SearchResult1 := JOIN(inRecs,Relationship1, Keyed(RIGHT.ID1 = Left.EntityID) AND RIGHT.ID1Type = Left.EntityIDType[3], 
																									TRANSFORM(Healthcare_Affiliations.Layouts.SearchRecs,
																														SELF.acctno := Left.acctno;
																														SELF.EntityID:= Left.EntityID; 
																														SELF.EntityIDType:= Left.EntityIDType; 
																														SELF.ID:= MAP(RIGHT.id1 = Left.EntityID => RIGHT.id2,
																																					RIGHT.id2 = Left.EntityID => RIGHT.id1,
																																					''); 
																														SELF.IDType:= MAP(RIGHT.id1 = Left.EntityID => if(RIGHT.id2type='P',Healthcare_Affiliations.Constants.ProviderIndicator,Healthcare_Affiliations.Constants.FacilityIndicator),
																																							RIGHT.id2 = Left.EntityID => if(RIGHT.id1type='P',Healthcare_Affiliations.Constants.ProviderIndicator,Healthcare_Affiliations.Constants.FacilityIndicator),
																																					''); 
																														SELF.RelationshipType:= RIGHT.RelationshipType; 
																														SELF.Effectivedate:= RIGHT.Effectivedate; 
																														SELF.Expiredate:= RIGHT.Expiredate;),
																										KEEP(Healthcare_Affiliations.Constants.maxSearchIDs), LIMIT(0));
		SearchResult2 := JOIN(inRecs,Relationship2, Keyed(RIGHT.ID2 = Left.EntityID) AND RIGHT.ID2Type = Left.EntityIDType[3], 
																										TRANSFORM(Healthcare_Affiliations.Layouts.SearchRecs,
																															SELF.acctno := Left.acctno;
																															SELF.EntityID:= Left.EntityID; 
																															SELF.EntityIDType:= Left.EntityIDType; 
																															SELF.ID:= MAP(RIGHT.id1 = Left.EntityID => RIGHT.id2,
																																						RIGHT.id2 = Left.EntityID => RIGHT.id1,
																																						''); 
																															SELF.IDType:= MAP(RIGHT.id1 = Left.EntityID => if(RIGHT.id2type='P',Healthcare_Affiliations.Constants.ProviderIndicator,Healthcare_Affiliations.Constants.FacilityIndicator),
																																								RIGHT.id2 = Left.EntityID => if(RIGHT.id1type='P',Healthcare_Affiliations.Constants.ProviderIndicator,Healthcare_Affiliations.Constants.FacilityIndicator),
																																						''); 
																															SELF.RelationshipType:= RIGHT.RelationshipType; 
																															SELF.Effectivedate:= RIGHT.Effectivedate; 
																															SELF.Expiredate:= RIGHT.Expiredate;),		
																										KEEP(Healthcare_Affiliations.Constants.maxSearchIDs), LIMIT(0));

		CleanSearchResult := SearchResult1 + SearchResult2;
	
		FacilityInfo := JOIN(inRecs(EntityIDType=Healthcare_Affiliations.Constants.FacilityIndicator), Facility,  // Because Providers are required to have the Facility address, not the Provider address.
																				KEYED(LEFT.EntityID = (string)RIGHT.LNFID),
																				Healthcare_Affiliations.Transforms.PopulateFacilityAddress(LEFT,RIGHT),	
																				KEEP(cfg.maxAddressesPerMatch), LIMIT(0));																 

		AffiliatedProviders := JOIN(CleanSearchResult(IDType=Healthcare_Affiliations.Constants.ProviderIndicator), Provider, 
																				KEYED(LEFT.ID = RIGHT.HMS_PIID),
																				Healthcare_Affiliations.Transforms.PopulateProvider(LEFT,RIGHT),	
																				KEEP(cfg.maxAddressesPerMatch), Limit(0));
																					 
		AffiliatedProviderWithFacAddress := JOIN(AffiliatedProviders, FacilityInfo,  // Because Providers are required to have the Facility address, not the Provider address.
																				LEFT.SourceID = RIGHT.SourceID,
																				Healthcare_Affiliations.Transforms.PopulateAddress(LEFT,RIGHT),	
																				KEEP(cfg.maxAddressesPerMatch), LIMIT(0));																 
															 
		AffiliatedProviderGroup := GROUP(AffiliatedProviderWithFacAddress, Acctno, ID); 													 
		AffiliatedProviderUnsort := ROLLUP(AffiliatedProviderGroup, GROUP, Healthcare_Affiliations.Transforms.RollUpProvider(LEFT, ROWS(LEFT))); 				
		AffiliatedProviderSorted := SORT(AffiliatedProviderUnsort, LastFirst);
		AffiliatedProvider := PROJECT(AffiliatedProviderSorted, Healthcare_Affiliations.Layouts.ResultRecs);
		
		AffiliatedFacilityUnsort := JOIN(CleanSearchResult(IDType=Healthcare_Affiliations.Constants.FacilityIndicator), Facility, 
															 KEYED(LEFT.ID = (string)RIGHT.LNFID),
															 Healthcare_Affiliations.Transforms.PopulateFacility(LEFT,RIGHT),	
															 KEEP(cfg.maxAddressesPerMatch), LIMIT(0));	
															 
		AffiliatedFacility := SORT(AffiliatedFacilityUnsort, OrganizationName);
		
		PreResult := DEDUP(AffiliatedProvider + AffiliatedFacility, ID); // Some duplications have beeb found in the data.

		Result := CHOOSEN(PreResult, Healthcare_Affiliations.Constants.maxResponseIDs);

		// output(inRecs,named('inRecs'));
		// output(SearchResult1,named('SearchResult1'));
		// output(SearchResult2,named('SearchResult2'));
		// output(CleanSearchResult,named('CleanSearchResult'));
		// output(FacilityInfo,named('FacilityInfo'));
		// output(AffiliatedProviderWithFacAddress,named('AffiliatedProviderWithFacAddress'));
		// output(AffiliatedProviderGroup,named('AffiliatedProviderGroup'));
		// output(AffiliatedProviderUnsort,named('AffiliatedProviderUnsort'));
		// output(AffiliatedProvider,named('AffiliatedProvider'));
		// output(AffiliatedFacilityUnsort,named('AffiliatedFacilityUnsort'));
		// output(AffiliatedFacility,named('AffiliatedFacility'));
		RETURN Result;
		
	END;

END;