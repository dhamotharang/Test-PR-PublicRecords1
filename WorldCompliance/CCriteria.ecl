import ut,std;
	rSearchCriteria mergeValue(rSearchCriteria Lft, rSearchCriteria rght) := TRANSFORM
			self.id := Lft.id;
			self.criteria := Lft.criteria + rght.criteria;
	END;


WCompCategories(dataset(Layouts.rEntity) origcat) := FUNCTION
								
		dsCategory := PROJECT(AllCategories,rCriteria);
		cats := PROJECT(origcat, TRANSFORM(rCriteriaRollup,
											self.id := LEFT.Ent_id;
											self.criteria := LEFT.EntryCategory+'-'+LEFT.EntrySubcategory;
											self.criteriaClass := 3;
											self.criteriaValue := 999;));
	
		catsAndValues := JOIN(cats, dsCategory, LEFT.criteria=RIGHT.name,
												TRANSFORM(rSearchCriteria,
														self.criteria := U',' + (unicode)Right.ValueId;
														self := LEFT;), LOOKUP, LEFT OUTER);
														
		return catsAndValues;
END;

WCOCategories(dataset(Layouts.rWCOCategories) restored) := FUNCTION
								
		dsCategory := PROJECT(AllCategories,rCriteria);
		Mcats := PROJECT(restored, TRANSFORM (rCriteriaRollup,
											SKIP(left.IsActivePEP = 'N'),
											self.id := LEFT.EntityID;
											self.criteria := if(left.SegmentType='AdditionalSegments' or left.SegmentType='Sanction',
										if(left.SubCategoryLabel = 'Associated Entity' or left.SubCategoryLabel ='Ownership Or Control' or left.SubCategoryLabel = 'SWIFT BIC Entity',
											'Associated Entity', 
											if(left.SubCategoryLabel = 'IHS OFAC Vessels' or left.SubCategoryLabel = 'Sanction List','Sanction List','Registrations')),
										left.SegmentType) 
												+'-'+
									 if(left.SubCategoryLabel = 'Primary PEP' or left.SubCategoryLabel = 'Secondary PEP', 
										if (left.SubCategoryDesc = 'Judiciary','Courts',
											if(left.SubCategoryDesc = 'Legislature' or left.SubCategoryDesc = 'Intelligence' or left.SubCategoryDesc = 'Law Enforce Auth' or left.SubCategoryDesc = 'Traditional Leadership',
												'Govt Branch Member',if(left.SubCategoryDesc = 'MSOE','Mgmt Govt Corp',left.SubCategoryDesc))), 
													if((left.SegmentType='AdditionalSegments' AND (left.SubCategoryLabel = 'Associated Entity' or left.SubCategoryLabel = 'IHS OFAC Vessels')),
														'N/A', 
														if(left.SegmentType='SOE',
															if((left.SubCategoryLabel = 'Minority' or left.SubCategoryLabel = 'Multiple Minority'), 
															'Govt Linked Corp',
															if ((left.SubCategoryLabel = 'Majority' or left.SubCategoryLabel = 'Multiple Majority'),'Govt Owned Corp', if ((left.SubCategoryLabel = 'Sanction List'),'N/A',left.SubCategoryLabel))),															
															if ((left.SubCategoryLabel = 'Sanction List'),
													'N/A',
													left.SubCategoryLabel))));		
															//left.SubCategoryLabel)));		


/*											self.criteria := if (LEFT.SegmentType != 'AdditionalSegments',if (Left.SegmentType = 'Sanction','Sanction List',LEFT.SegmentType),
												if(LEFT.SubCategoryLabel = 'Associated Entity'or LEFT.SubCategoryLabel ='Ownership Or Control' or LEFT.SubCategoryLabel = 'SWIFT BIC Entity','Associated Entity',
													if(LEFT.SubCategoryLabel = 'IHS OFAC Vessels' or LEFT.SubCategoryLabel = 'Sanction List','Sanction List','Registrations')))+'-'+
												if (LEFT.SubCategoryLabel = 'Primary PEP' or LEFT.SubCategoryLabel = 'Secondary PEP',LEFT.SubCategoryDesc,
													if(Left.SegmentType = 'Sanction' or (LEFT.SegmentType = 'AdditionalSegments' and (LEFT.SubCategoryLabel = 'Associated Entity' or LEFT.SubCategoryLabel = 'IHS OFAC Vessels')),
														'N/A',LEFT.SubCategoryLabel));
*/												
											self.criteriaClass := 3;
											self.criteriaValue := 999;));
	
		McatsAndValues := JOIN(sort(Mcats,id), dsCategory, LEFT.criteria=RIGHT.name,
												TRANSFORM(rSearchCriteria,
													self.criteria := U',' + (unicode)Right.ValueId;
													self := LEFT;), LOOKUP, LEFT OUTER);
														
		return McatsAndValues;
END;

GetCategories(dataset(Layouts.rEntity) oldcat) := FUNCTION

		cats := SORT(DISTRIBUTE(WCompCategories(oldcat),id), id, local);

		missing := JOIN(oldcat, cats, LEFT.Ent_id=RIGHT.id,
										TRANSFORM(rSearchCriteria,
												self.id := LEFT.Ent_id;
												self.criteria := U'999';), LEFT ONLY);
		
		return cats & missing;
END;

GetMultCategories(dataset(Layouts.rWCOCategories) restored) := FUNCTION

		Mcats := SORT(DISTRIBUTE(WCOCategories(restored), id), id, local);

		return Mcats;

END;
EXPORT CCriteria := FUNCTION

		oldcat0 := distribute((Files.dsMasters),Ent_ID);
		oldcat := DEDUP(SORT(oldcat0, ent_id, EntryCategory, EntrySubcategory, local),
			Ent_ID, EntryCategory, EntrySubcategory, local);
		oldpeps := oldcat(EntryCategory='PEP');
		oldformer := oldcat(EntrySubcategory='Former PEP');
		oldjustformer := JOIN(oldformer, oldpeps, left.ent_id=right.ent_id, TRANSFORM(WorldCompliance.layouts.rEntity,
									self := left), inner, keep(1), local);
		oldnoformer := JOIN(oldpeps, oldjustformer, left.ent_id=right.ent_id, TRANSFORM(WorldCompliance.layouts.rEntity,
									self := left), left only, local);
		oldrestored := oldcat(EntryCategory<>'PEP') + oldjustformer + oldnoformer;
	
	newcat0 := distribute((Files.dsWCOCategories), entityid);
	newcat := DEDUP(SORT(newcat0, entityid, segmenttype, subcategorylabel, subcategorydesc, -isactivepep, local),
		entityid, segmenttype, subcategorylabel, subcategorydesc, isactivepep, local);
	peps := newcat(segmenttype='PEP');
	former := newcat(subcategorydesc='Former PEP');
	NotAct := newcat(isactivepep='N' and segmenttype = 'PEP');
	Act := newcat(isactivepep IN ['Y',''] and segmenttype='PEP');

	justformer0 := JOIN(former, peps, left.entityid=right.entityid, TRANSFORM(WorldCompliance.layouts.rWCOCategories,
									self := left), inner, keep(1), local);
	justformer := DEDUP(SORT(justformer0, entityid, segmenttype, subcategorydesc, -isactivepep, local),
									entityid, segmenttype, subcategorydesc, local);								
	noformer0 := JOIN(peps, justformer, left.entityid=right.entityid, TRANSFORM(WorldCompliance.layouts.rWCOCategories,
									self := left), left only, local);
	noformer := DEDUP(SORT(noformer0, entityid, segmenttype,  subcategorydesc, -isactivepep, local),
								entityid, segmenttype, subcategorydesc, local);

	NotActive0 := JOIN(NotAct, justformer, left.entityid=right.entityid, TRANSFORM(WorldCompliance.layouts.rWCOCategories,
										self := left), left only, local);
	notActive := DEDUP(SORT(NotActive0, entityid, segmenttype,  subcategorydesc, -isactivepep, local),
										entityid, segmenttype, subcategorydesc, local);
	Active0 := JOIN(Act, justformer, left.entityid=right.entityid, TRANSFORM(WorldCompliance.layouts.rWCOCategories,
										self := left), left only, local);							
	Active := DEDUP(SORT(Active0, entityid, segmenttype,  subcategorydesc, -isactivepep, local),
										entityid, segmenttype, subcategorydesc, local);

	onlyNo0 := JOIN(NotActive, Active, left.entityid=right.entityid, TRANSFORM(WorldCompliance.layouts.rWCOCategories,
										self := left), left only, local);							
	onlyNo := DEDUP(SORT(onlyno0, entityid, segmenttype,  subcategorydesc, -isactivepep, local),
										entityid, segmenttype, subcategorydesc, local);
       
// Only Inactive PEP set:
	export ForceFormer := Join(distribute(onlyno, EntityID),onlyno,Left.EntityID=Right.EntityID,
		TRANSFORM(Layouts.rWCOCategories,
				self.SegmentType := 'PEP';
				self.SubCategoryLabel := 'Primary PEP';
				self.SubCategoryDesc := 'Former PEP';
				self.IsActivePEP := 'Y';
				self := left;));
			
	restored := newcat(segmenttype<>'PEP') + justformer + noformer + ForceFormer;

//GetCategories(oldcat) + 

//maincat := GetCategories(oldcat);
//addcat := GetMultCategories(restored);

//Allreasons := sort((GetReasons(infile) & GetMultReasons(restored)), Ent_ID, cmts, local);
//finalcat := DEDUP(SORT(DISTRIBUTE(SORT(GetCategories(oldcat) + GetMultCategories(restored),id,criteria,Local),id), id, criteria, LOCAL),id, criteria, LOCAL);
finalcat := DEDUP(SORT(GetMultCategories(restored),id,criteria,Local),id, criteria, LOCAL); // Pre IsActivePEP
//finalcat := DEDUP(SORT(GetCategories(oldrestored),id,criteria,Local),id, criteria, LOCAL); // This is last run
//finalcat := DEDUP(SORT(GetMultCategories(restored),id,criteria,Local),id, criteria, LOCAL); // This is last run

Group_3 := ROLLUP(finalcat, mergeValue(LEFT, RIGHT), id, LOCAL);
return Group_3;
END;