import ut,std;
/*	maxlen := 8192 - LENGTH(notice);
	maxchar(unicode s) := IF(Length(s) > maxlen,s[1..8191],s);
*/
	maxlen := 1000000000 - LENGTH(notice);
	maxchar(unicode s) := IF(Length(s) > maxlen,s[1..999999999],s);

rConsolidatedAsscoiations := RECORD
			unsigned8 MasterId;
			string comments;
END;

	rConsolidatedAsscoiations GetConsolidatedRec(dataset(Layouts.rEntity) src) := FUNCTION
		dsConsolidatedRec := src(EntryCategory='Sanction List' and NameSource='Sanctions' and MasterID=0);
		dsOtherRec 				:= WorldCompliance.Files.dsMasters - dsConsolidatedRec;	
		dsLinkedToConsolidatedRec := dsOtherRec(MasterID in SET(dsConsolidatedRec, Ent_ID));
		
		dsConsolidated := PROJECT(dsLinkedToConsolidatedRec, TRANSFORM(rConsolidatedAsscoiations,
   																						self.MasterId := left.MasterId;
   																						self.comments := 'Consolidated Record Source: ' + left.NameSource + ', ' + (string)left.Ent_Id;
   																						));
   
   
   	rConsolidatedAsscoiations xForm(dsConsolidated L, dsConsolidated R) := TRANSFORM
				self.comments := L.comments + ' | ' + R.comments;
   			self					:= L;
   	END;
			
   	return ROLLUP(DEDUP(SORT(dsConsolidated, MasterID),MasterID, comments, ALL), LEFT.MasterID=RIGHT.MasterID, xForm(LEFT,RIGHT));
		//return ROLLUP(SORT(dsConsolidated, MasterID), LEFT.MasterID=RIGHT.MasterID, xForm(LEFT,RIGHT));
	END;

	GetPosition(dataset(Layouts.rEntity) src) := PROJECT(src, TRANSFORM(rComments, 
											SKIP(LEFT.EntryType in ['Individual','Organization'] AND LEFT.EntryCategory in Filters.fPep),
			self.Ent_Id := LEFT.Ent_Id;
			self.sorter := 2;
			daterange := 
										IF(LEFT.EffectiveDate='','', ' Starting ' + LEFT.EffectiveDate) +
										IF(LEFT.ExpirationDate='','', ' Ending ' + LEFT.ExpirationDate);
			self.cmts := TRIM('Offense: ' + LEFT.Positions 
								+ IF(LEFT.GovDesignation='','',' (' + TRIM(LEFT.GovDesignation,LEFT,RIGHT) + ') ')
								+ IF(daterange='','',' (' + TRIM(daterange,LEFT,RIGHT) + ')'));
			self.subcmts := '';
			));
			
	GetNotes(dataset(Layouts.rEntity) src) := PROJECT(src(Remarks<>''), TRANSFORM(rComments,
			self.Ent_id := LEFT.Ent_id;
			self.sorter := 7;
			comment := CvtPilcrow(LEFT.Remarks);
			comment1 := IF(LENGTH(comment) > maxlen - LENGTH('Profile Notes: '),
													comment[1..maxlen-16] + '* || ', comment);
			self.cmts := 'Profile Notes: ' + comment1;
			self.subcmts := '';));

	Age_as_of_date:= ut.GetDate[1..4]+'/'+ut.GetDate[5..6]+'/'+ut.GetDate[7..8];	// previous using current data

	
	GetAge(dataset(Layouts.rEntity) src) := PROJECT(GetDobs(src), TRANSFORM(rComments,
			self.Ent_Id := LEFT.Ent_Id;
			self.sorter := 3;
			self.subcmts := '';
			self.cmts := IF(LEFT.age>0,'Age: ' + (string)LEFT.age + ' as of ' + LEFT.asof,'')));
	
	rComments GetRelComments(dataset(Layouts.rEntity) src) := FUNCTION	
		dsRel := JOIN(AllRelationships(src), GetConsolidatedRec(src), LEFT.Ent_IdParent = RIGHT.MasterId, FULL OUTER);
		return PROJECT(dsRel, TRANSFORM(rComments,
   			self.Ent_Id := if(LEFT.Ent_IdParent = 0, Left.MasterId, LEFT.Ent_IdParent);
   			self.sorter := 7;
				self.subcmts := '';
   			self.cmts := if(Left.cmts = '', 'Individual Sources: | ' + Left.comments, if(Left.comments = '', 'Associations: | ' + Left.cmts, 'Individual Sources: | ' + Left.comments + ' || ' + 'Associations: | '+ Left.cmts));));
	end;
	
	GetRelExcessive := PROJECT(ExcessiveRelations, TRANSFORM(rComments,
			self.Ent_Id := LEFT.Ent_IdParent;
			self.sorter := 8;
			self.subcmts := '';
			self.cmts := notice;));
  

	GetNameSources(dataset(Layouts.rEntity) src) := JOIN(src, DISTRIBUTE(WorldCompliance.GetSanctions(src),Ent_id),
				LEFT.Ent_Id = RIGHT.Ent_Id,
			TRANSFORM(WorldCompliance.rComments,
				self.Ent_Id := LEFT.Ent_Id;
				self.sorter := 1;
				self.subcmts := '';
				self.cmts := 'Source: ' + TRIM(Right.Country) + ',' + TRIM(Right.SourceName);), LOCAL, INNER);

	GetReasons(dataset(Layouts.rEntity) src) := PROJECT(src, TRANSFORM(rComments,
			self.Ent_Id := LEFT.Ent_Id;
			self.sorter := 5;
			self.subcmts := '';
			self.cmts := 'Category: ' + LEFT.EntryCategory + ' | Subcategory:' + if(LEFT.EntrySubCategory = 'N/A', '', ' ' + LEFT.EntrySubCategory)));// + ' | ' + 

//Multi Cat/Subcat section
	 GetMultReasons(dataset(Layouts.rWCOCategories) src) := PROJECT(src, TRANSFORM(rComments,
			SKIP(Left.IsActivePEP = 'N'),
			self.Ent_Id := LEFT.EntityID;
			self.sorter := 5;
			self.subcmts := '';
			self.cmts := 'Category: ' + 
									 if(left.SegmentType='AdditionalSegments' or left.SegmentType='Sanction',
										if(left.SubCategoryLabel = 'Associated Entity' or left.SubCategoryLabel ='Ownership Or Control' or left.SubCategoryLabel = 'SWIFT BIC Entity',
											'Associated Entity', 
											if(left.SubCategoryLabel = 'IHS OFAC Vessels' or left.SubCategoryLabel = 'Sanction List','Sanction List','Registrations')),
										left.SegmentType)
									 + ' | Subcategory: ' + 
									 if(left.SubCategoryLabel = 'Primary PEP' or left.SubCategoryLabel = 'Secondary PEP', 
										if (left.SubCategoryDesc = 'Judiciary',
											'Courts',
											if(left.SubCategoryDesc = 'Legislature' or left.SubCategoryDesc = 'Intelligence' or left.SubCategoryDesc = 'Law Enforce Auth' or left.SubCategoryDesc = 'Traditional Leadership',
												'Govt Branch Member',
												if(left.SubCategoryDesc = 'MSOE',
													'Mgmt Govt Corp',
													left.SubCategoryDesc))), 
										if((left.SegmentType='AdditionalSegments' AND (left.SubCategoryLabel = 'Associated Entity')),
											'N/A', 
											if(left.SegmentType='SOE',
												if((left.SubCategoryLabel = 'Minority' or left.SubCategoryLabel = 'Multiple Minority'), 
													'Govt Linked Corp',
													if ((left.SubCategoryLabel = 'Majority' or left.SubCategoryLabel = 'Multiple Majority'),
														'Govt Owned Corp', 
														if ((left.SubCategoryLabel = 'Sanction List' or left.SubCategoryLabel = 'IHS OFAC Vessels'),
															'',
															left.SubCategoryLabel))),															
												if ((left.SubCategoryLabel = 'Sanction List' or left.SubCategoryLabel = 'IHS OFAC Vessels'),
													'',
													left.SubCategoryLabel))));));
													//left.SubCategoryLabel)));));
				

//			self.cmts := 'Category: ' + LEFT.SegmentType + ' | Subcategory:' 
//										+ if(LEFT.SubCategoryLabel = 'Primary PEP' or LEFT.SubCategoryLabel = 'Secondary PEP', ' ' + LEFT.SubCategoryDesc, ' ' + LEFT.SubCategoryLabel) 
//										+ ' | Last Updated: ' + Left.LastUpdated;));


	GetModifiedDates(dataset(Layouts.rEntity) src) := PROJECT(src, 
			TRANSFORM(WorldCompliance.rComments,
				self.Ent_Id := LEFT.Ent_Id;
				self.sorter := 7;
				self.subcmts := '';
				self.cmts := 'Last updated: ' + ut.ConvertDate(TRIM(LEFT.touchdate),'%Y-%m-%d', '%Y-%m-%d');));

	GetLevel(dataset(Layouts.rEntity) src) := Project(src,
	Transform (rComments, SKIP(trim(LEFT.EntLevel, left, right) in ['N/A', '']),
				self.Ent_ID := Left.Ent_Id;
				self.sorter := 4;
				self.subcmts := '';
				self.cmts := if(trim(LEFT.EntLevel, left, right) in ['N/A', ''], '', 'Level: ' + LEFT.EntLevel);
				));
				
						
EXPORT rComments AllComments(dataset(Layouts.rEntity) infile) := FUNCTION
//			oldcat0 := (Files.dsMasters);
		oldcat0 := Distribute((Files.dsMasters), Ent_ID);
		oldcat := DEDUP(SORT(oldcat0, ent_id, EntryCategory, EntrySubcategory, local),
			Ent_ID, EntryCategory, EntrySubcategory, local);
		oldpeps := oldcat(EntryCategory='PEP');
		oldformer := oldcat(EntrySubcategory='Former PEP');
		oldjustformer := JOIN(oldformer, oldpeps, left.ent_id=right.ent_id, TRANSFORM(WorldCompliance.layouts.rEntity,
									self := left), inner, keep(1), local);
		oldnoformer := JOIN(oldpeps, oldjustformer, left.ent_id=right.ent_id, TRANSFORM(WorldCompliance.layouts.rEntity,
									self := left), left only, local);
		oldrestored := oldcat(EntryCategory<>'PEP') + oldjustformer + oldnoformer;

			newcat0 := Distribute((Files.dsWCOCategories),entityid);
			newcat := DEDUP(SORT(newcat0, entityid, segmenttype, subcategorylabel,subcategorydesc, -isactivepep, local),
														entityid, segmenttype, subcategorylabel,subcategorydesc, isactivepep,local);

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
				self := left;),local);
			
			
			restored := newcat(segmenttype<>'PEP') + justformer + noformer + ForceFormer;
			
			Allreasons := (GetMultReasons(restored)); //Original
					
		items := SORT(Distribute(
								//GetConsolidatedRec(infile) &
								GetNameSources(infile) & 
								GetPosition(infile(EntryType<>'Individual' OR infile.EntryCategory<>'PEP'))
								/*& GetAge(infile)*/ //Fix for Bug: 144622 
								//& GetReasons(Main) & GetMultReasons(newcat)
								& GetLevel(infile) 
								& dedup(sort(Allreasons,cmts, local),Ent_ID, cmts,ALL)
								//& Allreasons
								& GetRelComments(infile) & GetRelExcessive &
								GetModifiedDates(infile) & GetNotes(infile),Ent_id),
								Ent_Id, sorter,cmts,  LOCAL);

			
		rComments RollRecs(rComments L, rComments R) := TRANSFORM
				self.Ent_Id := L.Ent_Id;
				self.subcmts := '';
				self.cmts := maxchar(TRIM(L.cmts) + ' || ' + TRIM(R.cmts));
		END;
				
		ritems := ROLLUP(items, RollRecs(LEFT,RIGHT), Ent_Id, local);
		
		trimmed := PROJECT(ritems, TRANSFORM(rComments,
						self.cmts := IF(LENGTH(TRIM(LEFT.cmts)) > maxlen,
													LEFT.cmts[1..maxlen-1], LEFT.cmts);
						self := LEFT;));
														
		
		return trimmed;
END;
