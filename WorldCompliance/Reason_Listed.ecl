import ut,std;

	maxlen := 8192 - LENGTH(notice);
	maxchar(unicode s) := IF(Length(s) > maxlen,s[1..8191],s);


mreason := RECORD
	unsigned8 Ent_Id;
	integer sorter;
	unicode cmts;
	unicode subcmts;
	end;
	

	
	GetReasons(dataset(Layouts.rEntity) src) := PROJECT(src, TRANSFORM(rComments,
			self.Ent_Id := LEFT.Ent_Id;
			self.sorter := 1;
			self.cmts := if(trim(LEFT.EntLevel, left, right) in ['N/A', ''] or Left.EntryCategory != 'PEP', '', LEFT.EntLevel + ':') + 
			LEFT.EntryCategory + if(trim(Left.EntrySubCategory, left, right) in ['N/A', ''], '', ':' + Left.EntrySubCategory);
			self.subcmts := LEFT.EntryCategory + ':' + if(LEFT.EntrySubCategory = 'N/A', '',  LEFT.EntrySubCategory);
			));


//Multi Cat/Subcat section
mreason xform (Layouts.rWCOCategories restored, integer n) := TRANSFORM,
			SKIP(n < 2) //New for Mult to remove extras
			self.Ent_Id := restored.EntityID;			
			self.sorter := 2;
			//temphead := if(n in ['N/A', ''] or newcat.SegmentType != 'PEP', '', n + ':');
			/*self.subcmts := if(newcat.SegmentType='AdditionalSegments' or newcat.SegmentType='Sanction',
												if(newcat.SubCategoryLabel = 'Associated Entity' or newcat.SubCategoryLabel ='Ownership Or Control' or newcat.SubCategoryLabel = 'SWIFT BIC Entity',
													'Associated Entity', 
													if(newcat.SubCategoryLabel = 'IHS OFAC Vessels' or newcat.SubCategoryLabel = 'Sanction List','Sanction List','Registrations')),
														newcat.SegmentType) 
												+':'+
												if(newcat.SubCategoryLabel = 'Primary PEP' or newcat.SubCategoryLabel = 'Secondary PEP', 
													if (newcat.SubCategoryDesc = 'Judiciary','Courts',
														if(newcat.SubCategoryDesc = 'Legislature' or newcat.SubCategoryDesc = 'Intelligence' or newcat.SubCategoryDesc = 'Law Enforce Auth' or newcat.SubCategoryDesc = 'Traditional Leadership',
															'Govt Branch Member',if(newcat.SubCategoryDesc = 'MSOE','Mgmt Govt Corp',newcat.SubCategoryDesc))), 
															if(newcat.SegmentType='Sanction' or (newcat.SegmentType='AdditionalSegments' AND (newcat.SubCategoryLabel = 'Associated Entity' or newcat.SubCategoryLabel = 'IHS OFAC Vessels')),
															'N/A',
															if(newcat.SegmentType='SOE',
																if((newcat.SubCategoryLabel = 'Minority' or newcat.SubCategoryLabel = 'Multiple Minority'), 
																	'Govt Linked Corp',
																	if((newcat.SubCategoryLabel = 'Majority' or newcat.SubCategoryLabel = 'Multiple Majority'),'Govt Owned Corp', newcat.SubCategoryLabel)),
															newcat.SubCategoryLabel)));		
*/    self.subcmts := '';
			self.cmts 	:= ' - See comments for addtl';
										
					
	END;

EXPORT rComments Reason_listed(dataset(Layouts.rEntity) infile) := FUNCTION
			Main := (Files.dsMasters);

			newcat0 := (WorldCompliance.Files.dsWCOCategories);
			
			newcat := DEDUP(SORT(newcat0, entityid, segmenttype,subcategorylabel,subcategorydesc, -isactivepep, local),
														entityid, segmenttype,subcategorylabel,subcategorydesc, isactivepep, local);
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
			
			restored := Distribute(newcat(segmenttype<>'PEP') + justformer + Active + ForceFormer,EntityID);

			X := GROUP(SORT(restored, entityid, local), entityid, local);
			Y := Project(X, xForm(LEFT,Counter));
			Z := DEDUP(SORT(UNGROUP(Y), Ent_id, cmts, local), ent_id, cmts, local);
			//W := SORT(DISTRIBUTE(GetReasons(infile) & Z, Ent_id), ent_id, sorter, local);
			


			items := (GetReasons(infile)); //BD-185
			

//			items := DEDUP(SORT(Distribute(W, Ent_id), ent_id, sorter, local), 
//			Ent_id,cmts, local);
			
		rComments RollRecs(rComments L, rComments R) := TRANSFORM
				self.Ent_Id := L.Ent_Id;
				//extra := DEDUP(R.cmts,Ent_ID,All);
				self.cmts := TRIM(L.cmts) + TRIM(R.cmts);
				self.subcmts := TRIM(L.subcmts);// + TRIM(R.subcmts);
				//self.cmts := TRIM(L.cmts) + ' - See comments for addtl';
		END;
				
		ritems := ROLLUP(items, RollRecs(LEFT,RIGHT), Ent_Id, local);
	//	fitems := if(trim(infile.EntLevel, left, right) in ['N/A', ''] or infile.EntryCategory != 'PEP', ritems, infile.EntLevel + ':' + ritems);
		
		/*trimmed := PROJECT(ritems, TRANSFORM(rComments,
						self.cmts := IF(LENGTH(TRIM(LEFT.cmts)) > maxlen,
													LEFT.cmts[1..maxlen-1], LEFT.cmts);
						self := LEFT;));
														
		
		*/return ritems;
END;
