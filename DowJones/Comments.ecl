
	maxchar(unicode s) := IF(Length(s) > 8192,s[1..8192],s);

	rComments GetDeceased(dataset(Layouts.rPersons) src) := FUNCTION
			ddate := PROJECT(Functions.GetDod(src), TRANSFORM(rComments,
									self.id := LEFT.id;
									self.cmts := 'Deceased: ' + LEFT.cmts;));
			deceased := src(Deceased='Yes');
			
			rComments mrge(Layouts.rPersons L, rComments R) := TRANSFORM
					self.id := L.id;
					self.cmts := 'Deceased: Yes';
			END;
			nodate := JOIN(deceased, ddate, LEFT.id=RIGHT.id, mrge(LEFT,RIGHT), LOCAL, LEFT ONLY);
			return nodate + ddate;

	END;
	GetActiveStatus(dataset(Layouts.rPersons) src) := PROJECT(src, TRANSFORM(rComments,
			self.id := LEFT.id;
			self.cmts := 'ActiveStatus: ' + LEFT.ActiveStatus;));
			
	GetNotes(dataset(Layouts.rPersons) src) := PROJECT(src(ProfileNotes<>''), TRANSFORM(rComments,
			self.id := LEFT.id;
			self.cmts := 'Profile Notes: ' + maxchar(LEFT.ProfileNotes);));
/*	GetImages(dataset(Layouts.rPersons) src) := 
			PROJECT(Functions.GetImages(src), TRANSFORM(rComments,
				self.id := LEFT.id;
				self.cmts := 'Images and Photos: ' + LEFT.cmts;));
*/				


EXPORT rComments Comments(dataset(Layouts.rPersons) infile) := FUNCTION
				
		items := SORT(
				GetDeceased(infile) & GetActiveStatus(infile) & 			
					Associations.GetAssociations 
					& Functions.GetCountryNotes
					& GetNotes(infile) 
				,id, local);
				
		rComments RollRecs(rComments L, rComments R) := TRANSFORM
				self.id := L.id;
				self.cmts := maxchar(L.cmts + ' | ' + R.cmts);
		END;
				
		ritems := ROLLUP(items, id, RollRecs(LEFT,RIGHT));
		return ritems;
END;


