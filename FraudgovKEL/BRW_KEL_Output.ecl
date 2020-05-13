import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;

#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);
//#option('freezepersists', true);

/*
ModelingOutput := FraudgovKEL.KEL_EventShell.ModelingStats;
output(ModelingOutput,,'~temp::deleteme_nd', overwrite);	
output(ModelingOutput,,'~temp::deleteme_nd_csv', CSV(QUOTE('"')), overwrite);	
*/
/*
output(FraudgovKEL.KEL_EventPivot.EventPivotShell,,'~gov::otto::eventpivot', overwrite, compressed);	
output(FraudgovKEL.KEL_EventPivot.EntityProfileRules,,'~gov::otto::entityrules', overwrite, compressed);
output(FraudgovKEL.KEL_EntityStats,, '~gov::otto::pivotentitystatsfilter', overwrite, compressed);
*/

output(FraudgovKEL.KEL_GraphPrep,,'~fraudgov::rin2::graphprep', overwrite);


//output(FraudgovKEL.KEL_PivotIndexPrep);

