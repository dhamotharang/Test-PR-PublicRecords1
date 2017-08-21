import std;

sanctions := Dedup(SORT(Lists.SanctionsList,(integer)code),name);
Criteria := DowJones.dsSourceCriteria;

rx := RECORD
	integer		DJCode;
	integer		XGCode := 0;
	unicode		name;
	string		status;
END;

rx xMatchup(DowJones.Lists.SanctionsList s, Criteria c) := TRANSFORM
	self.DJCode := (integer)s.code;
	self.XGCode := (integer)c.id;
	self.name := IF(s.name='',c.name,s.name);
	self := s;
END;

mappedSanctions := JOIN(sanctions, Criteria, left.name = right.name, xMatchup(LEFT,RIGHT), Inner);


rCriteriaLine := RECORD
	unicode		criterion;
END;

rCriteriaLine xCriteria(rx criteria) := TRANSFORM
	self.criterion := '<value id="' + (string)criteria.XGCode + '" name="' +
						criteria.name + '" '
						+ if(criteria.status='Suspended','x="1" ','')
						+ '/>\r\n';
END;

NoValue := DATASET([{'<value id="999" name="No Value" />\r\n'}],rCriteriaLine);

searchOptions := NoValue &
		PROJECT(mappedSanctions,xCriteria(LEFT));

scriteria := ROLLUP(searchOptions, true, TRANSFORM(rCriteriaLine,
									SELF.criterion := LEFT.criterion + RIGHT.criterion;));

EXPORT BuildSourceCriteria :=
	Std.Uni.CleanAccents(
			STD.Uni.FindReplace(
		    '<group id="7" name="Source">\r\n'
				+ scriteria[1].criterion
				+ '</group>\r\n',
				' & ',' &amp; ')
		);
