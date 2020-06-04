
r := record
	unicode		groupvalue;		// <value id="999" name="No Value or N/A"/>
END;

MakeGroupValues(DATASET(rCriteria) criteria) := FUNCTION

	values := PROJECT(criteria, TRANSFORM(r,
							SELF.groupvalue := U'<value id="' + (string)LEFT.valueid + U'" name="' + LEFT.name + U'"/>';
							));

	return values;

END;
EXPORT MakeGroupHeader(DATASET(rCriteria) criteria, integer groupid, string groupname) := FUNCTION
		r RollupValues(r f1, r f2) := TRANSFORM
			self.groupvalue := f1.groupvalue + U'\r\n' + f2.groupvalue;
		END;

		values := MakeGroupValues(criteria);
		rolledup := ROLLUP(values, true, RollupValues(LEFT, RIGHT));
		
		return U'<group id="' + (unicode)groupid + U'" name="' + groupname + U'">\r\n'
						+ rolledup[1].groupvalue
						+ U'\r\n</group>\r\n';

END;