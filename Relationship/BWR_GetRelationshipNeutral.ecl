did_ds := dataset([
158783930225
,2536085855
,2443130406
,5
],Relationship.Layout_GetRelationship.DIDs_layout);

result := Relationship.proc_GetRelationshipNeutral(did_ds,
/*RelativeFlag*/,
/*AssociateFlag*/,
/*AllFlag*/,
/*TransactionalOnlyFlag*/,
100,
100,
/*doSkip*/,/*doFail*/,/*doAtmost*/, /*sameLname*/, /*minScore*/, /*recentRelative*/,/*person2*/,
/*excludeTransClosure2*/, /*excludeInactives*/,
false/*doTHOR*/,
/*HighConfidenceRelatives*/,
/*HighConfidenceAssociates*/,
/*RelLookbackMonths*/,
/*txflag*/,
/*RelKeyFlag*/,
true/*addNthDegree*/).result;
output(result);

                                   
