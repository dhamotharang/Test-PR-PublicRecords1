IMPORT CNLD_Practitioner, Strata;

EXPORT out_STRATA_population_stats(string pversion) := FUNCTION

  base_qa := CNLD_Practitioner.Files().Base.QA;

  rPopulationStats_CNLD_Practitioner := RECORD
    STRING3 NoGrouping                           := 'ALL'; // field to GROUP by -- all values are "ALL"
    CountGroup                                   := COUNT(GROUP);
    gennum_CountPopulated           						 := SUM(GROUP, IF(base_qa.gennum <> '', 1, 0));
	end;

  dPopulationStats_CNLD_Practitioner := TABLE(base_qa, rPopulationStats_CNLD_Practitioner, FEW);

  STRATA.createXMLStats(dPopulationStats_CNLD_Practitioner,
	                      'CNLD_Practitioner', 'base', pversion,
						            '', resultsOut, 'view', 'population');

  RETURN resultsOut;

END;