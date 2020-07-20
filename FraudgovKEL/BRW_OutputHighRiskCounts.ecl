import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;
IMPORT Std;

#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);
#option('resourceMaxHeavy', 2);

d1 := FraudgovKEL.KEL_EventPivot.PivotToEntitiesWithHRICounts;

// this needs to be switched to the pre-clean version before sending to ND

HighRiskCountsPrep := TABLE(d1, 
                    {customerid, industrytype, t_actuid, entitycontextuid,  
                     INTEGER p15_aothiidcurrprofusngcntev := MAP(entitytype = 15 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p16_aothiidcurrprofusngcntev := MAP(entitytype = 16 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p18_aothiidcurrprofusngcntev := MAP(entitytype = 18 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p17_aothiidcurrprofusngcntev := MAP(entitytype = 17 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p19_aothiidcurrprofusngcntev := MAP(entitytype = 19 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p20_aothiidcurrprofusngcntev := MAP(entitytype = 20 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p9_aothiidcurrprofusngcntev := MAP(entitytype = 9 => aothiidcurrprofusngcntev, -99999)}, 
                     customerid, industrytype, t_actuid, entitycontextuid, MERGE);
										 
HighRiskCounts := TABLE(HighRiskCountsPrep, 
                    {customerid, industrytype, t_actuid,
                     INTEGER p15_aothiidcurrprofusngcntev := MAX(GROUP, p15_aothiidcurrprofusngcntev),
                     INTEGER p16_aothiidcurrprofusngcntev := MAX(GROUP, p16_aothiidcurrprofusngcntev),
                     INTEGER p17_aothiidcurrprofusngcntev := MAX(GROUP, p17_aothiidcurrprofusngcntev),
                     INTEGER p18_aothiidcurrprofusngcntev := MAX(GROUP, p18_aothiidcurrprofusngcntev),
                     INTEGER p19_aothiidcurrprofusngcntev := MAX(GROUP, p19_aothiidcurrprofusngcntev),
                     INTEGER p20_aothiidcurrprofusngcntev := MAX(GROUP, p20_aothiidcurrprofusngcntev),
                     INTEGER p9_aothiidcurrprofusngcntev := MAX(GROUP, p9_aothiidcurrprofusngcntev),
                     }, 
                     customerid, industrytype, t_actuid, MERGE);        
										 
output(HighRiskCounts);

output(HighRiskCounts,,'~fraudgov::temp::highriskcounts.csv', CSV, OVERWRITE);                    