GetExclusionState(DATASET($.Layout_Sanctions) infile) := PROJECT(infile(exclusion_state<>''),
			TRANSFORM($.rComments,
				self.id := left.key;
				self.sorter := 1;
				self.cmts :=  'Exclusion State: ' + left.exclusion_state;
		));
		
GetOffense(DATASET($.Layout_Sanctions) infile) := PROJECT(infile(OFFENSE<>'' or OFFENSE_DATE NOT IN ['0',' ']),
			TRANSFORM($.rComments,
				off := IF(left.OFFENSE<>'', 'OFFENSE: ' + left.offense, '');
				offdt := IF(left.OFFENSE_DATE NOT IN ['0',' '], 'OFFENSE DATE: ' + left.OFFENSE_DATE, '');
				self.id := left.key;
				self.sorter := 1;
				self.cmts :=  off + IF(offdt<>'' AND off<>'', ' | ', '') + offdt;
		));
		
GetSpecialty(DATASET($.Layout_Sanctions) infile) := PROJECT(infile(SPECIALTY_DESCRIPTION<>'' or SPECIALTY_CLASS_TYPE<>''),
			TRANSFORM($.rComments,
				class := IF(left.SPECIALTY_CLASS_TYPE<>'', 'SPECIALTY CLASS TYPE: ' + left.SPECIALTY_CLASS_TYPE, '');
				desc := IF(left.SPECIALTY_DESCRIPTION<>'', 'SPECIALTY DESCRIPTION: ' + left.SPECIALTY_DESCRIPTION, '');
				self.id := left.key;
				self.sorter := 2;
				self.cmts := class + IF(desc<>'' AND class<>'', ' | ', '') + desc ;
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
								GetExclusionState(infile) &
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
				
		ritems := ROLLUP(items(cmts<>''), RollRecs(LEFT,RIGHT), id, local);
		
		return ritems;

END;