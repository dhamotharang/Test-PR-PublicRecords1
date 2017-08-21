sanctions := Dedup(SORT(DowJones.Lists.SanctionsList,(integer)code),name);

Criteria := DowJones.dsSourceCriteria;
rx := RECORD
	integer		DJCode;
	integer		XGCode := 0;
	unicode		name;
	string		status;
END;

rx x(DowJones.Lists.SanctionsList s, Criteria c) := TRANSFORM
	self.DJCode := (integer)s.code;
	self.XGCode := (integer)c.id;
	self.name := IF(s.name='',c.name,s.name);
	self := s;
END;

current := sanctions(status='Current');

djonly := JOIN(current, Criteria, left.name = right.name, x(LEFT,RIGHT), left only);
xgonly := JOIN(sanctions, Criteria, left.name = right.name, x(LEFT,RIGHT), right only);


EXPORT SanctionsReport := djonly & xgonly;