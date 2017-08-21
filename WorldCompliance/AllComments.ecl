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
			
   	return ROLLUP(SORT(dsConsolidated, MasterID), LEFT.MasterID=RIGHT.MasterID, xForm(LEFT,RIGHT));
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
			));
			
	GetNotes(dataset(Layouts.rEntity) src) := PROJECT(src(Remarks<>''), TRANSFORM(rComments,
			self.Ent_id := LEFT.Ent_id;
			self.sorter := 7;
			comment := CvtPilcrow(LEFT.Remarks);
			comment1 := IF(LENGTH(comment) > maxlen - LENGTH('Profile Notes: '),
													comment[1..maxlen-16] + '* || ', comment);
			self.cmts := 'Profile Notes: ' + comment1;));

	Age_as_of_date:= ut.GetDate[1..4]+'/'+ut.GetDate[5..6]+'/'+ut.GetDate[7..8];	// previous using current data

	
	GetAge(dataset(Layouts.rEntity) src) := PROJECT(GetDobs(src), TRANSFORM(rComments,
			self.Ent_Id := LEFT.Ent_Id;
			self.sorter := 3;
			self.cmts := IF(LEFT.age>0,'Age: ' + (string)LEFT.age + ' as of ' + LEFT.asof,'')));
	
	rComments GetRelComments(dataset(Layouts.rEntity) src) := FUNCTION	
		dsRel := JOIN(AllRelationships(src), GetConsolidatedRec(src), LEFT.Ent_IdParent = RIGHT.MasterId, FULL OUTER);
		return PROJECT(dsRel, TRANSFORM(rComments,
   			self.Ent_Id := if(LEFT.Ent_IdParent = 0, Left.MasterId, LEFT.Ent_IdParent);
   			self.sorter := 5;
   			self.cmts := if(Left.cmts = '', 'Individual Sources: | ' + Left.comments, if(Left.comments = '', 'Associations: | ' + Left.cmts, 'Individual Sources: | ' + Left.comments + ' || ' + 'Associations: | '+ Left.cmts));));
	end;
	
	GetRelExcessive := PROJECT(ExcessiveRelations, TRANSFORM(rComments,
			self.Ent_Id := LEFT.Ent_IdParent;
			self.sorter := 8;
			self.cmts := notice;));


	GetNameSources(dataset(Layouts.rEntity) src) := JOIN(src, DISTRIBUTE(WorldCompliance.GetSanctions(src),Ent_id),
				LEFT.Ent_Id = RIGHT.Ent_Id,
			TRANSFORM(WorldCompliance.rComments,
				self.Ent_Id := LEFT.Ent_Id;
				self.sorter := 1;
				self.cmts := 'Source: ' + TRIM(Right.Country) + ',' + TRIM(Right.SourceName);), LOCAL, INNER);

	GetReasons(dataset(Layouts.rEntity) src) := PROJECT(src, TRANSFORM(rComments,
			self.Ent_Id := LEFT.Ent_Id;
			self.sorter := 4;
			self.cmts := if(trim(LEFT.EntLevel, left, right) in ['N/A', ''], '', 'Level: ' + LEFT.EntLevel + ' | ') + 'Category: ' + LEFT.EntryCategory + ' | Subcategory:' + if(LEFT.EntrySubCategory = 'N/A', '', ' ' + LEFT.EntrySubCategory);));

	GetModifiedDates(dataset(Layouts.rEntity) src) := PROJECT(src, 
			TRANSFORM(WorldCompliance.rComments,
				self.Ent_Id := LEFT.Ent_Id;
				self.sorter := 6;
				self.cmts := 'Last updated: ' + ut.ConvertDate(TRIM(LEFT.touchdate),'%Y-%m-%d', '%Y-%m-%d');));


EXPORT rComments AllComments(dataset(Layouts.rEntity) infile) := FUNCTION
					
		items := SORT(Distribute(
								//GetConsolidatedRec(infile) &
								GetNameSources(infile) & 
								GetPosition(infile(EntryType<>'Individual' OR infile.EntryCategory<>'PEP'))
								/*& GetAge(infile)*/ //Fix for Bug: 144622 
								& GetReasons(infile) & GetRelComments(infile) & GetRelExcessive &
								GetModifiedDates(infile) & GetNotes(infile),Ent_id),
								Ent_Id, sorter, LOCAL);

			
		rComments RollRecs(rComments L, rComments R) := TRANSFORM
				self.Ent_Id := L.Ent_Id;
				self.cmts := maxchar(TRIM(L.cmts) + ' || ' + TRIM(R.cmts));
		END;
				
		ritems := ROLLUP(items, RollRecs(LEFT,RIGHT), Ent_Id, local);
		
		trimmed := PROJECT(ritems, TRANSFORM(rComments,
						self.cmts := IF(LENGTH(TRIM(LEFT.cmts)) > maxlen,
													LEFT.cmts[1..maxlen-1], LEFT.cmts);
						self := LEFT;));
														
		
		return trimmed;
END;
