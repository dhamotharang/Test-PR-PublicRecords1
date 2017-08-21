
	maxchar(unicode s) := IF(Length(s) > 8192,s[1..8192],s);

	GetActiveStatus(dataset(Layouts.rEntities) src) := PROJECT(src, TRANSFORM(rComments,
			self.id := LEFT.id;
			self.cmts := 'ActiveStatus: ' + LEFT.ActiveStatus;));
			
	GetNotes(dataset(Layouts.rEntities) src) := PROJECT(src(ProfileNotes<>''), TRANSFORM(rComments,
			self.id := LEFT.id;
			self.cmts := 'Profile Notes: ' + maxchar(LEFT.ProfileNotes);));

	GetRegDate := PROJECT(Functions.GetRegistrationDate, TRANSFORM(rComments,
			self.id := LEFT.id;
			self.cmts := 'Registration Date: ' + LEFT.cmts;));


EXPORT rComments EntityComments(dataset(Layouts.rEntities) infile) := FUNCTION
				
		items := SORT(
				GetActiveStatus(infile) & 
					GetRegDate &
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