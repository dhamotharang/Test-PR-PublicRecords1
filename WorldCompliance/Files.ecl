
FillEnt := RECORD
	unsigned8		Ent_ID;
	unicode			name {maxlength(255)};
	unicode			FirstName {maxlength(50)};
	unicode			LastName {maxlength(50)};
	string			Prefix {maxlength(30)};
	unicode			Suffix {maxlength(10)};
	unicode			Aka {maxlength(8192)};
	string			NameSource {maxlength(20)};
	unsigned8		ParentId;
	string			GovDesignation {maxlength(25)};
	string			EntryType {maxlength(20)};
	string			EntryCategory {maxlength(20)};
	string			EntrySubcategory {maxlength(20)};
	string			Organization {maxlength(100)};
	unicode			Positions {maxlength(8192)};
	unicode			Remarks {maxlength(32000)};
	string			Dob {maxlength(75)};
	string			Pob {maxlength(75)};
	unicode			Country {maxlength(100)};
	string			ExpirationDate {maxlength(20)};
	string			EffectiveDate {maxlength(20)};
	string			PictureFile {maxlength(200)};
	string			LinkedTo {maxlength(250)};
	unsigned8		Related_ID;
	string			SourceWebLink {maxlength(8192)};
	string			TouchDate {maxlength(16)};
	string			DirectId {maxlength(50)};
	string			PassportId {maxlength(20)};
	string			NationalId {maxlength(20)};
	string			OtherId {maxlength(20)};
	string			Dob2 {maxlength(20)};
	unicode			EntLevel {maxlength(30)};
	unsigned8		MasterId;
	boolean			Watch;
	boolean			Relationships;
	unicode			PrimaryName {maxlength(255)};
	unicode			OriginalName2  {maxlength(255)} := '';
	string			DateEntered 	{maxlength(16)} := '';
// fields added on 2013-11-01
	string			DobOriginal;
	boolean			PictureFileOnly;
	unicode			OriginalName3;
	string			OriginalLanguage;
	string			DateUpdated;
	string			EnteredBy;
	string			UpdatedBy;
	string			JurisdictionId;
	string			Relationships2;
	string			CriminalAmount;
	string			TermStartDate;
	string			TermEndDate;
	string			StatusEndDate;
	string			SpecialCollections;
	string			EntitiesLevelsId;
	integer			EntryCategoryID;
	integer			EntrySubCategoryID;
	integer			EntitiesSourceID;
	integer			EntryTypeId;
	integer			CountryId;
	integer			PepCode;
	string			Gender;
END;
EXPORT Files := MODULE

Entities 					:= ['Individual','Organization','Vessel','Bank','Aircraft'];

export dsEntities :=Distribute( 
				DATASET(root+'entity', Layouts.rEntity, CSV(separator('|'),heading(1),quote('\t'),UNICODE))(EntryType in Entities,Ent_Id<>0),Ent_ID);
export dsCountryEntities := 
				DATASET(root+'entity', Layouts.rEntity, CSV(separator('|'),heading(1),quote('\t'),UNICODE))(EntryType = 'Country',Ent_Id<>0);
export dsAddresses := DISTRIBUTE(
					DATASET(root+'addresses', Layouts.rAddress, CSV(separator('|'),heading(1),quote('\t'),UNICODE)),
					Ent_id);
export dsRelationships := DATASET(root+'relationships', Layouts.rRelationship, CSV(separator('|'),heading(1),quote('\t'),UNICODE))(rid<>0,RelationId<>0);

export dsSanctionsDOB := DISTRIBUTE(
					DATASET(root+'SanctionsDOB', Layouts.rSanctionsDOB, CSV(separator('|'),heading(1),quote('\t'),UNICODE)),
					SanctionsDobId);

export MdsWCOCategories := Distribute(DATASET(root+'WCOCategories', Layouts.rWCOCategories, CSV(separator('|'),heading(1),quote('\t'),UNICODE)),EntityID);

//export dsWCOCategories :=sort(DATASET(root+'WCOCategories', Layouts.rWCOCategories, CSV(separator('|'),heading(1),quote('\t'),UNICODE)),Ent_ID);
WhiteListEntities := ['Branch', 'Lead', 'Member', 'Single', 'Sponsoring Entity'];
export dsWhiteListEntities := Distribute(
															DATASET(root+'whitelistentity', Layouts.rEntity, CSV(separator('|'),heading(1),quote('\t'),UNICODE))(EntryType in WhiteListEntities,Ent_Id<>0),Ent_ID);	
// these files don't need to be versioned
export dsCountries := DATASET(root+'countries', Layouts.rCountry, CSV(separator('|'),heading(1),quote('\t'),UNICODE));
export dsSources := dsRegistrationsSrc + DATASET(root+'sources', Layouts.rSource, CSV(separator('|'),heading(1),quote('\t'),UNICODE));
export dsCategories := DATASET(root+'categories', Layouts.rCategories, CSV(separator('|'),heading(1),quote('\t'),UNICODE));
export dsSubCategories := DATASET(root+'subcategories', Layouts.rCategories, CSV(separator('|'),heading(1),quote('\t'),UNICODE));
export dsRelDefs := DATASET(root+'reldefs', Layouts.rCategories, CSV(separator('|'),heading(1),quote('\t'),UNICODE));


					
export dsMasters_base := 			// master entries
				dsEntities(ParentId=0) + dsWhiteListEntities(ParentId=0);
export dsMainCats := Join(distribute(dsMasters_base, Ent_ID),MdsWcoCategories,Left.Ent_ID=Right.EntityID,
//Export dsMainCats := PROJECT(dsEntities, 
							Transform(Layouts.rWCOCategories,
											self.EntityID := Left.Ent_ID;
											self.SegmentType := if (left.Entrycategory = 'Sanction List','Sanction', if (left.Entrycategory = 'Registrations' or left.Entrycategory = 'Associated Entity','AdditionalSegments',left.Entrycategory));
											self.SubCategoryLabel := if(left.Entrycategory='PEP','Primary PEP',
																									if(left.Entrycategory = 'Sanction List' or (left.Entrycategory = 'Associated Entity' and left.EntrySubcategory = 'N/A') ,left.Entrycategory,left.EntrySubcategory));
											self.SubCategoryDesc := if (left.Entrycategory='PEP',left.EntrySubcategory,
																									if (left.Entrycategory = 'Sanction List' and left.EntrySubcategory <> 'N/A',left.EntrySubcategory,''));
											self.isActivePEP := if(left.Entrycategory = 'PEP','Y','');
											self.lastupdated := left.DateUpdated;//));
											self := right;
										),Left Outer, local);
				
export dsMult :=   Join(distribute(MdsWCOCategories, EntityID),dsMasters_base, Left.EntityID=Right.Ent_ID,	
									TRANSFORM(Layouts.rEntity,								
										self.Ent_ID := Left.EntityID;
										self.Entrycategory := if(left.SegmentType='AdditionalSegments' or left.SegmentType='Sanction',
											if(left.SubCategoryLabel = 'Associated Entity' or left.SubCategoryLabel ='Ownership Or Control' or left.SubCategoryLabel = 'SWIFT BIC Entity',
												'Associated Entity', 
												if(left.SubCategoryLabel = 'IHS OFAC Vessels' or left.SubCategoryLabel = 'Sanction List','Sanction List','Registrations')),
													left.SegmentType);
										self.EntrySubcategory := if(left.SubCategoryLabel = 'Primary PEP' or left.SubCategoryLabel = 'Secondary PEP', 
											if (left.SubCategoryDesc = 'Judiciary','Courts',
												if(left.SubCategoryDesc = 'Legislature' or left.SubCategoryDesc = 'Intelligence' or left.SubCategoryDesc = 'Law Enforce Auth' or left.SubCategoryDesc = 'Traditional Leadership',
													'Govt Branch Member',if(left.SubCategoryDesc = 'MSOE','Mgmt Govt Corp',left.SubCategoryDesc))), 
												if(left.SegmentType='Sanction' or (left.SegmentType='AdditionalSegments' AND (left.SubCategoryLabel = 'Associated Entity' or left.SubCategoryLabel = 'IHS OFAC Vessels')),
													'N/A', 
													if(left.SegmentType='SOE',
														if((left.SubCategoryLabel = 'Minority' or left.SubCategoryLabel = 'Multiple Minority'),
															'Govt Linked Corp',
															if ((left.SubCategoryLabel = 'Majority' or left.SubCategoryLabel = 'Multiple Majority'),'Govt Owned Corp', left.SubCategoryLabel)),
													left.SubCategoryLabel)));
	
											self := right;
									),Inner, local);

export FMdsWCOCategories := Join(distribute(MdsWCOCategories, EntityID),MdsWcoCategories,Left.EntityID=Right.EntityID,
										Transform(Layouts.rWCOCategories,
											self.SegmentType := if (left.SegmentType='AdditionalSegments' AND left.SubCategoryLabel = 'IHS OFAC Vessels','Sanction',left.SegmentType);
											self.SubCategoryLabel := if((left.SegmentType='AdditionalSegments' AND left.SubCategoryLabel = 'IHS OFAC Vessels'),
																										'Sanction List', 
																									if(left.SegmentType='SOE',
																										if((left.SubCategoryLabel = 'Minority' or left.SubCategoryLabel = 'Multiple Minority'), 
																												'Govt Linked Corp',
																												if ((left.SubCategoryLabel = 'Majority' or left.SubCategoryLabel = 'Multiple Majority'),'Govt Owned Corp', if ((left.SubCategoryLabel = 'Sanction List'),left.SubCategoryLabel,left.SubCategoryLabel))),
																												left.SubCategoryLabel));
											self.SubCategoryDesc := if(left.SubCategoryLabel = 'Primary PEP' or left.SubCategoryLabel = 'Secondary PEP', 
																								if (left.SubCategoryDesc = 'Judiciary','Courts',
																									if(left.SubCategoryDesc = 'Legislature' or left.SubCategoryDesc = 'Intelligence' or left.SubCategoryDesc = 'Law Enforce Auth' or left.SubCategoryDesc = 'Traditional Leadership',
																										'Govt Branch Member',if(left.SubCategoryDesc = 'MSOE','Mgmt Govt Corp',left.SubCategoryDesc))),left.SubCategoryDesc); 
																									
											self.IsActivePEP := left.IsActivePEP;
											self := right;
										), Inner, local);

export dsMasters := dsMasters_base + dsMult;

export dsWCOCategories := dsMainCats + FMdsWCOCategories;
//export dsWCOCategories := dsMainCats + MdsWCOCategories;
export srcAdverseMedia := dedup(SORT(dsMasters(EntryCategory in Filters.fAdverseMedia),Ent_ID,Entrycategory,EntrySubcategory,LOCAL),Ent_ID,ALL);
export srcGlobalEnforcement := dedup(SORT(dsMasters(EntryCategory in Filters.fEnforcement),Ent_ID,Entrycategory,EntrySubcategory,LOCAL),Ent_ID,ALL);

//Bug: 149009 - WCo: Add new records to WorldCompliance - Expanded Due Diligence file
//srcGlobalEdd1 := dsMasters(EntryCategory in Filters.fEdd1 and Watch = true); //OLD 20160805

srcGlobalEdd1a := dsMasters(EntryCategory in Filters.fEdd1 AND Watch = true);

srcGlobalEdd1b := dsMasters(EntryCategory in ['Enforcement'] and Namesource IN ['US-EPLS','US-HHS-EIE','US-SAM'] and 
								EntrySubcategory NOT IN ['Excluded Party','End Use Control']);
								
srcGlobalEdd1		:= (srcGlobalEdd1a + srcGlobalEdd1b);

//Bug: 196854 - WCo - Bridger: Change to logic for WorldCompliance Expanded Due Diligence
srcGlobalEdd2 := dsMasters(EntryCategory in Filters.fEdd1 and NameSource NOT IN ['WebSite', 'Website', 'Newspaper','Magazine','Broadcast', 'CO-RNDEC', 'AR-LPEPBC']);
srcGlobalEdd3 := dsMasters(EntryCategory in Filters.fEdd2);

//Bug: 196854 - WCo - Bridger: Change to logic for WorldCompliance Expanded Due Diligence
//export srcGlobalEdd := srcGlobalEdd3 + dedup(sort(srcGlobalEdd1 + srcGlobalEdd2, Ent_ID, local), Ent_ID, local); // OLD 20160805
srcGlobalEdd4 :=  (srcGlobalEdd3 + srcGlobalEdd1 + srcGlobalEdd2); 

srcGlobalEdd5 := project(srcGlobalEdd4, transform(Layouts.rEntity, 
		self.EntryTypeId := if(left.NameSource = 'US-EPLS',752, 
				if(left.NameSource = 'US-HHS-EIE',848, 
				if(left.NameSource = 'US-SAM' ,10447, left.EntryTypeId)));
		self.NameSource := if(left.NameSource = 'US-EPLS', 'JPMC Custom - EPLS', 
				if(left.NameSource = 'US-HHS-EIE', 'JPMC Custom - HHS', 
				if(left.NameSource = 'US-SAM' , 'JPMC Custom - SAM', left.NameSource)));
		 self := left;));

export srcGlobalEdd								:= dedup(SORT(srcGlobalEdd5,Ent_ID,Entrycategory,EntrySubcategory,LOCAL),Ent_ID,ALL);
//export srcGlobalEdd								:= dedup(srcGlobalEdd5,Ent_ID,ALL);

export srcGlobalStateOwned 				:= dedup(SORT(dsMasters(EntryCategory in Filters.fStateOwned),Ent_ID,Entrycategory,EntrySubcategory,LOCAL),Ent_ID,ALL);
export srcPep 										:= dedup(SORT(dsMasters(EntryCategory in Filters.fPep),Ent_ID,Entrycategory,EntrySubcategory,LOCAL),Ent_ID,ALL);
export srcSanctionsAndEnforcement := dedup(SORT(dsMasters(EntryCategory in Filters.fSanctionsAndEnforcement),Ent_ID,Entrycategory,EntrySubcategory,LOCAL),Ent_ID,ALL);
export srcSanctions 							:= dedup(SORT(dsMasters(EntryCategory in Filters.fSanctions),Ent_ID,Entrycategory,EntrySubcategory,LOCAL),Ent_ID,ALL);
export srcFull 										:= dsMasters_base(EntryCategory in Filters.fFull);
export srcRegistrations := dedup(SORT(project(dsMasters(EntryCategory in Filters.fRegistrations),
															transform(Layouts.rEntity, self.EntryCategory := if(left.EntryCategory = 'High Risk', 'Registrations', left.EntryCategory); self := left;)),Ent_ID,Entrycategory,EntrySubcategory,LOCAL),Ent_ID,ALL);
				
				
END;