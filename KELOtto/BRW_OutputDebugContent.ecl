import KELOtto;

#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);
#option('freezepersists', true);

output(KELOtto.BasicScoring.FullEntityStatsPrep,, '~gov::otto::customerscoringdebug', overwrite);
output(KELOtto.BasicScoring.FullIndicatorList,, '~gov::otto::customerfullindicatorlist', overwrite);
output(KELOtto.BasicScoring.WeightingChart,,'~gov::otto::configrisklevel', overwrite);
//output(KELOtto.BasicScoring.CustomerScoreBreakdownAverages, all);


//sequential(KELOtto.BasicScoring.WeightingChartOutput);

j1 := DEDUP(SORT(JOIN(KELOtto.sharingrules, KELOtto.sharingrules, LEFT.SourceCustomerHash = RIGHT.TargetCustomerHash, 
               TRANSFORM({UNSIGNED TargetCustomerId, UNSIGNED TargetIndustryType, UNSIGNED SourceCustomerId, UNSIGNED SourceIndustryType}, 
               SELF.TargetCustomerId := LEFT.inclusion_id, SELF.TargetIndustryType := LEFT.Ind_type,
               SELF.SourceCustomerId := RIGHT.inclusion_id, SELF.SourceIndustryType := RIGHT.Ind_type, SELF := LEFT), LOOKUP), TargetCustomerId, SourceCustomerId), TargetCustomerId, SourceCustomerId);
output(j1,, '~gov::otto::sharing', overwrite);               

