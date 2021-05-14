import Relationship, dx_BestRecords, InsuranceHeader_PostProcess;
// did_ds := dataset([
// 158783930225
// ,2536085855
// ,2443130406
// ,5
// ],Relationship.Layout_GetRelationship.DIDs_layout);

// output(did_ds);

did_ds := project(choosen(pull(InsuranceHeader_PostProcess.segmentation_keys.key_did_ind), 1000000), 
          Relationship.Layout_GetRelationship.DIDs_layout) : independent ; 


result := Relationship.proc_GetRelationshipNeutral(did_ds,
/*RelativeFlag*/,
/*AssociateFlag*/,
/*AllFlag*/,
/*TransactionalOnlyFlag*/,
100,
100,
/*doSkip*/,/*doFail*/,/*doAtmost*/, /*sameLname*/, /*minScore*/, /*recentRelative*/,/*person2*/,
/*excludeTransClosure2*/, /*excludeInactives*/,
true/*doTHOR*/,
/*HighConfidenceRelatives*/,
/*HighConfidenceAssociates*/,
/*RelLookbackMonths*/,
/*txflag*/,
/*RelKeyFlag*/,
true/*addNthDegree*/).result;
output(result);

                                   
