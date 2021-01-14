import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;
IMPORT Std;

#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);
#option('resourceMaxHeavy', 2);
//#option('freezepersists', true);
#OPTION('expandSelectCreateRow', TRUE)

Set_entitycontextuid:=['_1814789556728917185197','_1817705727575360173926','_1813477488177115018873'];

FraudgovKEL.KEL_EventPivot.EventPivotShell;

//FraudGovKEL.b_event.__EE3557558_1(T___Act_Uid_.v = 105889499);
//Aot_Id_Act_Cnt30_D__7_
// p9___aotidactcnt30d);

//p9___aot_id_act_cnt30_d
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


//OUTPUT(COUNT(Std.Str.SplitWords(KEL_EventShell.NicoleAttr, ',')), named('AttributeCount'));

//ModelingOutput := FraudgovKEL.KEL_EventShell.ModelingStats;
//output(ModelingOutput,,'~fraudgov::deleteme_nd', overwrite);	
//output(ModelingOutput,,'~fraudgov::deleteme_nd_csv', CSV(QUOTE('"')), overwrite);

/*
ScoringOutput := FraudgovKEL.KEL_EventPivot.InputWithRules(industrytype = 1029 and customerid = 20995239);
output(ScoringOutput,,'~fraudgov::deleteme_rules_nd_csv', CSV(QUOTE('"')), overwrite);	
*/

output(FraudgovKEL.KEL_EventPivot.EventPivotShell,,'~fraudgov::eventpivot', overwrite, compressed);
output(FraudgovKEL.KEL_EventPivot.EntityProfileRules,,'~fraudgov::entityrules', overwrite, compressed);
output(FraudgovKEL.KEL_EntityStats,, '~fraudgov::pivotentitystatsfilter', overwrite, compressed);
output(FraudgovKEL.KEL_GraphPrep.Edges,,'~fraudgov::rin2::graphedges', overwrite);
output(FraudgovKEL.KEL_GraphPrep.Vertices,,'~fraudgov::rin2::graphpvertices', overwrite);


//output(FraudgovKEL.KEL_GraphPrep.LinksPrep);
