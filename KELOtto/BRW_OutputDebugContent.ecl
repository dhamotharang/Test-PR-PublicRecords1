import KELOtto;

#option('multiplePersistInstances', false);

//output(KELOtto.BasicScoring.FullEntityStatsPrep,, '~gov::otto::customerscoringdebug', overwrite);
//output(KELOtto.BasicScoring.FullIndicatorList,, '~gov::otto::customerfullindicatorlist', overwrite);

output(KELOtto.BasicScoring.CustomerScoreBreakdownAverages, all);


//sequential(KELOtto.BasicScoring.WeightingChartOutput);