import KELOtto;

#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);

output(KELOtto.KelFiles.CustomerAddress,, '~gov::otto::customeraddress', overwrite);
output(KELOtto.KelFiles.PersonStats,, '~gov::otto::personstats', overwrite);
output(KELOtto.KelFiles.PersonEvents,, '~gov::otto::personevents', overwrite);
output(KELOtto.KelFiles.CustomerStats,, '~gov::otto::customerstats', overwrite);
output(KELOtto.KelFiles.CustomerStatsPivot,, '~gov::otto::customerstats_pivot', overwrite);


output(KELOtto.KelFiles.FullCluster,,'~gov::otto::fullgraph', overwrite);
output(KELOtto.KelFiles.EntityStats,, '~gov::otto::entitystats', overwrite);


// Association Details
output(KELOtto.KelFiles.PersonAssociationsStats,, '~gov::otto::person_associations_stats', overwrite);
output(KELOtto.KelFiles.PersonAssociationsDetails,, '~gov::otto::person_associations_details', overwrite);

// Score Breakdown...
output(KELOtto.KelFiles.ScoreBreakdown,,'~gov::otto::entity_scorebreakdown', overwrite);

// Optimized Customer Dashboard Content.
output(KELOtto.CustomerDash.TopEntityStats,, '~gov::otto::customerdashtopentitystats', overwrite);
output(KELOtto.CustomerDash.TopClustersAndElements,, '~gov::otto::customerdashtopclusters', overwrite);
