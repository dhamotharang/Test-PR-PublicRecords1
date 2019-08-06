
GetOffense(DATASET($.Layout_Sanctions) infile) := PROJECT(infile(OFFENSE<>'' or OFFENSE_DATE<>''),
			TRANSFORM($.rComments,
				self.id := left.key;
				self.sorter := 1;
				self.cmts := 'OFFENSE: ' + left.offense + ' | ' + 'OFFENSE DATE: ' + left.OFFENSE_DATE;
		));
		
GetSpecialty(DATASET($.Layout_Sanctions) infile) := PROJECT(infile(SPECIALTY_DESCRIPTION<>'' or SPECIALTY_CLASS_TYPE<>''),
			TRANSFORM($.rComments,
				self.id := left.key;
				self.sorter := 2;
				self.cmts := 'SPECIALTY DESCRIPTION: ' + left.SPECIALTY_DESCRIPTION + ' | ' + 'SPECIALTY CLASS TYPE: ' + left.SPECIALTY_CLASS_TYPE;
		));
		
GetBoard(DATASET($.Layout_Sanctions) infile) := PROJECT(infile(BOARD<>''),
			TRANSFORM($.rComments,
				self.id := left.key;
				self.sorter := 3;
				self.cmts := 'BOARD: ' + left.BOARD;
		));
		
GetCounty(DATASET($.Layout_Sanctions) infile) := PROJECT(infile(COUNTY<>''),
			TRANSFORM($.rComments,
				self.id := left.key;
				self.sorter := 4;
				self.cmts := 'COUNTY: ' + left.COUNTY;
		));

EXPORT AllComments(DATASET($.Layout_Sanctions) infile) := FUNCTION

		items := SORT(Distribute(
								GetOffense(infile) & 
								GetSpecialty(infile) &
								GetBoard(infile) &
								GetCounty(infile)
						,id),
								id, sorter, LOCAL);

		$.rComments RollRecs($.rComments L, $.rComments R) := TRANSFORM
				self.id := L.id;
				self.cmts := TRIM(L.cmts) + ' || ' + TRIM(R.cmts);
		END;
				
		ritems := ROLLUP(items, RollRecs(LEFT,RIGHT), id, local);
		
		return ritems;

END;