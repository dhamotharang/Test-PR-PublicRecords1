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
/*
output(FraudgovKEL.KEL_GraphPrep.Edges,,'~fraudgov::rin2::graphedges', overwrite);
output(FraudgovKEL.KEL_GraphPrep.Vertices,,'~fraudgov::rin2::graphpvertices', overwrite);
*/

FraudgovKEL.KEL_GraphPrep.LinksPrep(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450');
FraudgovKEL.KEL_GraphPrep.LinksPrep(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463');
FraudgovKEL.KEL_GraphPrep.Edges(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450');
FraudgovKEL.KEL_GraphPrep.Edges(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463');

/*
FraudgovKEL.KEL_GraphPrep.Edges(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450');
FraudgovKEL.KEL_GraphPrep.Vertices(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450');
FraudgovKEL.KEL_GraphPrep.Edges(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463');
FraudgovKEL.KEL_GraphPrep.Vertices(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463');
*/
//output(FraudgovKEL.KEL_PivotIndexPrep);

