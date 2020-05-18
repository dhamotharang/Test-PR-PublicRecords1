import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;
IMPORT Std;

#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);
//#option('freezepersists', true);

Set_recordid:=[100042207,98396537,88091596,92371598,103657507,105277042,86770921,93547646,93955623,97576259,100486875,100599348,100599726,103659109,92350043,100874669,93645928,93955623];

//OUTPUT(COUNT(Std.Str.SplitWords(KEL_EventShell.NicoleAttr, ',')), named('AttributeCount'));

/*
ModelingOutput := FraudgovKEL.KEL_EventShell.ModelingStats;
output(ModelingOutput,,'~temp::deleteme_nd', overwrite);	
output(ModelingOutput,,'~temp::deleteme_nd_csv', CSV(QUOTE('"')), overwrite);	
*/
/*
d1 := TABLE(ModelingOutput, {m_T15_SsnIsKrFlag := MAX(GROUP, T15_SsnIsKrFlag),										 
m_T20_DlIsKrFlag := MAX(GROUP,T20_DlIsKrFlag ),
m_T9_AddrIsKrFlag := MAX(GROUP,T9_AddrIsKrFlag),											
m_T16_PhnIsKrFlag := MAX(GROUP,T16_PhnIsKrFlag),
m_T17_EmailIsKrFlag := MAX(GROUP,T17_EmailIsKrFlag),									 
m_T18_IpAddrIsKrFlag := MAX(GROUP,T18_IpAddrIsKrFlag),
m_T19_BnkAcctIsKrFlag := MAX(GROUP,T19_BnkAcctIsKrFlag)});

output(d1);
*/



output(FraudgovKEL.KEL_EventPivot.EventPivotShell,,'~gov::otto::eventpivot', overwrite, compressed);	
output(FraudgovKEL.KEL_EventPivot.EntityProfileRules,,'~gov::otto::entityrules', overwrite, compressed);
output(FraudgovKEL.KEL_EntityStats,, '~gov::otto::pivotentitystatsfilter', overwrite, compressed);


/*
output(FraudgovKEL.KEL_GraphPrep.Edges,,'~fraudgov::rin2::graphedges', overwrite);
output(FraudgovKEL.KEL_GraphPrep.Vertices,,'~fraudgov::rin2::graphpvertices', overwrite);
*/

//output(FraudgovKEL.KEL_GraphPrep.LinksPrep);

/*
t1 := TABLE(FraudgovKEL.KEL_GraphPrep.Vertices, {customerid, industrytype, treeuid, reccount := COUNT(GROUP)}, customerid, industrytype, treeuid, MERGE);
topn(t1, 100, -reccount);
*/
/*
FraudgovKEL.KEL_GraphPrep.LinksPrep(customerid = 21010349 AND industrytype =	1029 and treeuid = '_013550779256');
FraudgovKEL.KEL_GraphPrep.LinksFinal(customerid = 21010349 AND industrytype =	1029 and treeuid = '_013550779256');

FraudgovKEL.KEL_GraphPrep.Vertices(customerid = 21010349 AND industrytype =	1029 and treeuid = '_013550779256');
FraudgovKEL.KEL_GraphPrep.Edges(customerid = 21010349 AND industrytype =	1029 and treeuid = '_013550779256');
*/
/*
FraudgovKEL.KEL_GraphPrep.LinksPrep(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450');
FraudgovKEL.KEL_GraphPrep.Links1(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450');
FraudgovKEL.KEL_GraphPrep.LinksFinal(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450');

FraudgovKEL.KEL_GraphPrep.LinksPrep(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463');
FraudgovKEL.KEL_GraphPrep.Links1(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463');
FraudgovKEL.KEL_GraphPrep.LinksFinal(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463');

FraudgovKEL.KEL_GraphPrep.Edges(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450');
FraudgovKEL.KEL_GraphPrep.Edges(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463');
*/
/*
FraudgovKEL.KEL_GraphPrep.Edges(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450');
FraudgovKEL.KEL_GraphPrep.Vertices(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450');
FraudgovKEL.KEL_GraphPrep.Edges(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463');
FraudgovKEL.KEL_GraphPrep.Vertices(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463');
*/
//output(FraudgovKEL.KEL_PivotIndexPrep);

