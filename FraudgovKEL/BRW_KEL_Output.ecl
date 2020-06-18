import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;
IMPORT Std;

//#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);
//#option('freezepersists', true);


Set_entitycontextuid:=['_1814789556728917185197','_1817705727575360173926','_1813477488177115018873'];

/*
t1 := TABLE(FraudGovKEL.KEL_EventShell.CleanEventShell(customerid=20995239 and industrytype = 1029), {t1_napsummary, reccount := COUNT(GROUP)}, t1_napsummary, MERGE);
TOPN(t1, 100, -reccount); 

t2 := TABLE(FraudGovKEL.KEL_EventShell.CleanEventShell(customerid=20995239 and industrytype = 1029), {t1l_nassummary, reccount := COUNT(GROUP)}, t1l_nassummary, MERGE);
TOPN(t2, 100, -reccount); 

t3 := TABLE(FraudGovKEL.KEL_EventShell.CleanEventShell(customerid=20995239 and industrytype = 1029), {t1_cvi, reccount := COUNT(GROUP)}, t1_cvi, MERGE);
TOPN(t3, 100, -reccount); 
*/



//output(FraudgovKEL.KEL_EventShell.UIStats(ipentitycontextuid in Set_entitycontextuid));

//output(FraudgovKEL.KEL_EventPivot.EventPivotShell);

/*
OUTPUT(COUNT(Std.Str.SplitWords(KEL_EventShell.NicoleAttr, ',')), named('AttributeCount'));
ModelingOutput := FraudgovKEL.KEL_EventShell.ModelingStats;
output(ModelingOutput,,'~temp::deleteme_nd', overwrite);	
output(ModelingOutput,,'~temp::deleteme_nd_csv', CSV(QUOTE('"')), overwrite);	
*/


output(FraudgovKEL.KEL_EventPivot.EventPivotShell,,'~gov::otto::eventpivot', overwrite, compressed);	
//output(FraudgovKEL.KEL_EventPivot.EntityProfileRules,,'~gov::otto::entityrules', overwrite, compressed);
//output(FraudgovKEL.KEL_EntityStats,, '~gov::otto::pivotentitystatsfilter', overwrite, compressed);
/*
output(FraudgovKEL.KEL_GraphPrep.Edges,,'~temp::fraudgov::rin2::graphedges', overwrite);
output(FraudgovKEL.KEL_GraphPrep.Vertices,,'~temp::fraudgov::rin2::graphpvertices', overwrite);
*/

//output(FraudgovKEL.KEL_GraphPrep.LinksPrep);


