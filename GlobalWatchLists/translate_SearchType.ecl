export translate_SearchType(STRING20 st) := CASE(st,
'INDIVIDUAL'=>constants.individual_code,
'NON-INDIVIDUAL'=>constants.non_individual_code,
'BOTH'=>constants.both_code,st);