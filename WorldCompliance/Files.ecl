EXPORT Files := MODULE

Entities 					:= ['Individual','Organization','Vessel','Bank','Aircraft'];

export dsEntities := 
			DISTRIBUTE(
				DATASET(root+'entity', Layouts.rEntity, CSV(separator('|'),heading(1),quote('\t'),UNICODE))(EntryType in Entities,Ent_Id<>0),
			Ent_id);
export dsCountryEntities := 
				DATASET(root+'entity', Layouts.rEntity, CSV(separator('|'),heading(1),quote('\t'),UNICODE))(EntryType = 'Country',Ent_Id<>0);
export dsAddresses := DISTRIBUTE(
					DATASET(root+'addresses', Layouts.rAddress, CSV(separator('|'),heading(1),quote('\t'),UNICODE)),
					Ent_id);
export dsRelationships := DATASET(root+'relationships', Layouts.rRelationship, CSV(separator('|'),heading(1),quote('\t'),UNICODE))(rid<>0,RelationId<>0);

export dsSanctionsDOB := DISTRIBUTE(
					DATASET(root+'SanctionsDOB', Layouts.rSanctionsDOB, CSV(separator('|'),heading(1),quote('\t'),UNICODE)),
					SanctionsDobId);

WhiteListEntities := ['Branch', 'Lead', 'Member', 'Single', 'Sponsoring Entity'];
export dsWhiteListEntities := 
			DISTRIBUTE(
				DATASET(root+'whitelistentity', Layouts.rEntity, CSV(separator('|'),heading(1),quote('\t'),UNICODE))(EntryType in WhiteListEntities,Ent_Id<>0),
			Ent_id);
			
// these files don't need to be versioned
export dsCountries := DATASET(root+'countries', Layouts.rCountry, CSV(separator('|'),heading(1),quote('\t'),UNICODE));
export dsSources := dsRegistrationsSrc + DATASET(root+'sources', Layouts.rSource, CSV(separator('|'),heading(1),quote('\t'),UNICODE));
export dsCategories := DATASET(root+'categories', Layouts.rCategories, CSV(separator('|'),heading(1),quote('\t'),UNICODE));
export dsSubCategories := DATASET(root+'subcategories', Layouts.rCategories, CSV(separator('|'),heading(1),quote('\t'),UNICODE));
export dsRelDefs := DATASET(root+'reldefs', Layouts.rCategories, CSV(separator('|'),heading(1),quote('\t'),UNICODE));

export dsMasters :=			// master entries
				dsEntities(ParentId=0) + dsWhiteListEntities(ParentId=0);
				
// file partitions
export srcAdverseMedia := dsMasters(EntryCategory in Filters.fAdverseMedia);
export srcGlobalEnforcement := dsMasters(EntryCategory in Filters.fEnforcement);

//Bug: 149009 - WCo: Add new records to WorldCompliance - Expanded Due Diligence file
//srcGlobalEdd1 := dsMasters(EntryCategory in Filters.fEdd1 and Watch = true); //OLD 20160805

srcGlobalEdd1a := dsMasters(EntryCategory in Filters.fEdd1 AND Watch = true);

srcGlobalEdd1b := dsMasters(EntryCategory in ['Enforcement'] and Namesource IN ['US-EPLS','US-HHS-EIE','US-SAM'] and 
								EntrySubcategory NOT IN ['Excluded Party','End Use Control']);
								
srcGlobalEdd1		:= dedup(sort(srcGlobalEdd1a + srcGlobalEdd1b, Ent_ID, local), Ent_ID, local);

//Bug: 196854 - WCo - Bridger: Change to logic for WorldCompliance Expanded Due Diligence
srcGlobalEdd2 := dsMasters(EntryCategory in Filters.fEdd1 and NameSource NOT IN ['WebSite', 'Website', 'Newspaper','Magazine','Broadcast', 'CO-RNDEC', 'AR-LPEPBC']);
srcGlobalEdd3 := dsMasters(EntryCategory in Filters.fEdd2);

//Bug: 196854 - WCo - Bridger: Change to logic for WorldCompliance Expanded Due Diligence
//export srcGlobalEdd := srcGlobalEdd3 + dedup(sort(srcGlobalEdd1 + srcGlobalEdd2, Ent_ID, local), Ent_ID, local); // OLD 20160805
srcGlobalEdd4 := srcGlobalEdd3 + dedup(sort(srcGlobalEdd1 + srcGlobalEdd2, Ent_ID, local), Ent_ID, local); 

export srcGlobalEdd := project(srcGlobalEdd4, transform(Layouts.rEntity, 
		self.EntryTypeId := if(left.NameSource = 'US-EPLS',752, 
				if(left.NameSource = 'US-HHS-EIE',848, 
				if(left.NameSource = 'US-SAM' ,10447, left.EntryTypeId)));
		self.NameSource := if(left.NameSource = 'US-EPLS', 'JPMC Custom - EPLS', 
				if(left.NameSource = 'US-HHS-EIE', 'JPMC Custom - HHS', 
				if(left.NameSource = 'US-SAM' , 'JPMC Custom - SAM', left.NameSource)));
		 self := left;));



export srcGlobalStateOwned 				:= dsMasters(EntryCategory in Filters.fStateOwned);
export srcPep 										:= dsMasters(EntryCategory in Filters.fPep);
export srcSanctionsAndEnforcement := dsMasters(EntryCategory in Filters.fSanctionsAndEnforcement);
export srcSanctions 		:= dsMasters(EntryCategory in Filters.fSanctions);
export srcFull 					:= dsMasters(EntryCategory in Filters.fFull);
export srcRegistrations := project(dsMasters(EntryCategory in Filters.fRegistrations),
															transform(Layouts.rEntity, self.EntryCategory := if(left.EntryCategory = 'High Risk', 'Registrations', left.EntryCategory); self := left;));
				

				
END;