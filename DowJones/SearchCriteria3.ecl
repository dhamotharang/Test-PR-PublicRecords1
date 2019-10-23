import Std;

class := U'Sanctions Control and Ownership - ';

EXPORT SearchCriteria3 := MODULE

	export SanctionsControlAndOwnership := 34;
	
	d3 := dowJones.Lists.Description3List;

	export SanctionCodes := SORT(d3(description2id=SanctionsControlAndOwnership),Name);

	rCriteriaLine := RECORD
		unicode		criterion;
	END;

	rCriteriaLine xCriteria(SanctionCodes criteria) := TRANSFORM
		self.criterion := '<value id="' + (string)criteria.description3id + '" name="' +
						class+Std.Uni.CleanAccents(criteria.name) + '" '
						+ '/>\r\n';
	END;

	searchOptions := PROJECT(SanctionCodes, xCriteria(left));
	
	export Sanctions := ROLLUP(searchOptions, true, TRANSFORM(rCriteriaLine,
									SELF.criterion := LEFT.criterion + RIGHT.criterion;));
		
	export Ownership := $.Functions.GetRawDescriptions(description2=SanctionsControlAndOwnership);


END;