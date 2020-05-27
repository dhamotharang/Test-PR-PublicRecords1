import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;
IMPORT Std;

#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);
//#option('freezepersists', true);


//Set_entitycontextuid:=['_1814789556728917185197','_1817705727575360173926','_1813477488177115018873'];
//output(FraudgovKEL.KEL_EventShell.UIStats(ipentitycontextuid in Set_entitycontextuid));


/*
OUTPUT(COUNT(Std.Str.SplitWords(KEL_EventShell.NicoleAttr, ',')), named('AttributeCount'));
ModelingOutput := FraudgovKEL.KEL_EventShell.ModelingStats;
output(ModelingOutput,,'~temp::deleteme_nd', overwrite);	
output(ModelingOutput,,'~temp::deleteme_nd_csv', CSV(QUOTE('"')), overwrite);	
*/


//output(FraudgovKEL.KEL_EventPivot.EventPivotShell,,'~gov::otto::eventpivot', overwrite, compressed);	
//output(FraudgovKEL.KEL_EventPivot.EntityProfileRules,,'~gov::otto::entityrules', overwrite, compressed);
//output(FraudgovKEL.KEL_EntityStats,, '~gov::otto::pivotentitystatsfilter', overwrite, compressed);


/*
output(FraudgovKEL.KEL_GraphPrep.Edges,,'~fraudgov::rin2::graphedges', overwrite);
output(FraudgovKEL.KEL_GraphPrep.Vertices,,'~fraudgov::rin2::graphpvertices', overwrite);
*/

//output(FraudgovKEL.KEL_GraphPrep.LinksPrep);


