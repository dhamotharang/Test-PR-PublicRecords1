
r := record
	string		groupvalue;		// <value id="999" name="No Value or N/A"/>
END;

MakeGroupValues(DATASET(PEP.rCriteria) criteria) := FUNCTION

	values := PROJECT(criteria, TRANSFORM(r,
							SELF.groupvalue := '<value id="' + (string)LEFT.valueid + '" name="' + LEFT.name + '"/>';
							));

	return values;

END;
EXPORT MakeGroupHeader(DATASET(rCriteria) criteria, integer groupid, string groupname) := FUNCTION
		r RollupValues(r f1, r f2) := TRANSFORM
			self.groupvalue := f1.groupvalue + '\r\n' + f2.groupvalue;
		END;

		values := MakeGroupValues(criteria);
		rolledup := ROLLUP(values, true, RollupValues(LEFT, RIGHT));
		
		return '<group id="' + (string)groupid + '" name="' + groupname + '">\r\n'
						+ rolledup[1].groupvalue
						+ '\r\n</group>\r\n';

END;