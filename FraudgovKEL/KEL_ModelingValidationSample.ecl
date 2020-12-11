import FraudgovKEL;
import FraudGovPlatform_Analytics;
//import FraudGovPlatform_Analytics;
//IMPORT KEL12 AS KEL;
IMPORT Std;

ModelingAttributeOutput := FraudgovKEL.KEL_EventShell.ModelingStats;//(t_srcagencyuid = 20995239);
//ModelingAttributeOutput := DATASET('~fraudgov::temp::modelingstats', RECORDOF(FraudgovKEL.KEL_EventShell.ModelingStats), THOR)(t_srcagencyuid = 20995239 and t_srcagencyprogtype = 1029);
//output(ModelingAttributeOutput,,'~fraudgov::temp::modelingstats', overwrite);

ModelingAttributeOutputCount := COUNT(ModelingAttributeOutput);

//output(ModelingAttributeOutputCount, named('modelingrowcount'));

EventStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(ModelingAttributeOutput, 'entitycontextuid,personentitycontextuid,agencyuid,t_actuid', 

// Need the list of the rules attributes here to limit the pivot to only attributes used in rules.
'agencyprogtype,agencyprogdesc,agencyprogjurst,t_srcagencyuid,t_srcagencyprogtype,t_inagencyflag,t_srctype,t_srcdesc,t_srcclasstype,t1_lexidpopflag,t1_rinidpopflag,t_firstnmpopflag,' +
't_lastnmpopflag,t9_addrpopflag,t15_ssnpopflag,t_dobpopflag,t20_dlpopflag,t16_phnpopflag,t18_ipaddrpopflag,t17_emailpopflag,t19_bnkacctpopflag,t_isbcshllhitflag,t1l_lexidseenflag,t1l_bcshlllexidmatchesinpflag,' +
't1l_idisbcshllhitflag,t1l_idcrimhitflag,t1l_idcrimflsdmatchflag,t18_isipmetahitflag,t19_isbnkapphitflag,t16_isphnmetahitflag,t1_idage,t1_minoridflag,t1_adultidnotseenflag,t1_minorwlexidflag,t1l_iddeceasedflag,t1l_idcurrincarcflag,' +
't1l_dobverindx,t1_napsummary,t1l_nassummary,t1_cvi,t1l_fp_sourcerisklevel,t1_ssnpriordobflag,t1_firstnmnotverflag,t1_lastnmnotverflag,t1_addrnotverflag,t1l_ssnnotverflag,t1l_ssnwaltnaverflag,t1l_ssnwaddrnotverflag,' +
't1_phnnotverflag,t1l_dobnotverflag,t1_hiriskcviflag,t1_medriskcviflag,t1l_hdrsrccatcntlwflag,t1_fp3,t1_fp3_stolenidentityindex,t1_fp3_syntheticidentityindex,t1_fp3_manipidentityindex,t1_stolidflag,t1_synthidflag,t1_manipidflag,' +
't1l_bestfirstnmpopflag,t1l_bestlastnmpopflag,t1l_curraddrpopflag,t1l_bestssnpopflag,t1l_bestdobpopflag,t1l_bestphnpopflag,t1l_bestdlpopflag,t1l_curraddrnotinagcyjurstflag,t1l_bestdlnotinagcyjurstflag,t1l_bestfirstnmmatchesinpflag,t1l_bestlastnmmatchesinpflag,t1l_bestfullnmmatchesinpflag,' +
't1l_curraddrmatchesinpflag,t1l_bestssnmatchesinpflag,t1l_bestdobmatchesinpflag,t1l_bestphnmatchesinpflag,t1l_bestdlmatchesinpflag,t9_addrstatus,t9_addrtype,t9_addrvaltype,t9_addrmaildroptype,t9_addrisvacantflag,t9_addrisinvalidflag,t9_addriscmraflag,' +
't15_ssnvaltype,t15_ssnisinvalidflag,t20_dlvaltype,t20_dlisinvalidflag,t16_phnvaltype,t16_phnisinvalidflag,t16_phnprepdflag,t18_ipaddrcity,t18_ipaddrcountry,t18_ipaddrregion,t18_ipaddrdomain,t18_ipaddrispnm,' +
't18_ipaddrloctype,t18_ipaddrproxytype,t18_ipaddrproxydesc,t18_ipaddrisispflag,t18_ipaddrasncompnm,t18_ipaddrasn,t18_ipaddrcompnm,t18_ipaddrorgnm,t18_ipaddrhostedflag,t18_ipaddrvpnflag,t18_ipaddrtornodeflag,t18_ipaddrlocnonusflag,' +
't18_ipaddrlocmiamiflag,t17_emaildomain,t17_emaildomaindispflag,t19_bnkacctbnknm,t19_bnkaccthrprepdrtgflag,t9_idcurrprofusngaddrcntev,t9_addrpoboxmultcurridflagev,t15_idcurrprofusngssncntev,t15_ssnmultcurridflagev,t20_idcurrprofusngdlcntev,t20_dlmultcurridflagev,t19_idcurrprofusngbnkacctcntev,' +
't19_bnkacctmultcurridflagev,t_statusactiondesc,t1_idiskrappfrdflag,t1_idiskrgenfrdflag,t1_idiskrstolidflag,t1_idiskrothfrdflag,t1_idiskrflag,t9_addriskrflag,t15_ssniskrflag,t16_phniskrflag,t17_emailiskrflag,t18_ipaddriskrflag,' +
't19_bnkacctiskrflag,t20_dliskrflag,t9_addrissafeflag,t16_phnissafeflag,t18_ipaddrissafeflag,t1_idinvupdflag,p1_aotidcurrprofflag,p9_aotaddrcurrprofflag,p15_aotssncurrprofflag,p16_aotphncurrprofflag,p17_aotemailcurrprofflag,p18_aotipaddrcurrprofflag,' +
'p19_aotbnkacctcurrprofflag,p20_aotdlcurrprofflag,p1_aotidkractcntev,p1_aotidkractflagev,p1_aotidkrappfrdactcntev,p1_aotidkrappfrdactflagev,p1_aotidkrgenfrdactcntev,p1_aotidkrgenfrdactflagev,p1_aotidkrothfrdactcntev,p1_aotidkrothfrdactflagev,p1_aotidkrstolidactcntev,p1_aotidkrstolidactflagev,' +
'p9_aotaddrkractcntev,p9_aotaddrkractflagev,p15_aotssnkractcntev,p15_aotssnkractflagev,p16_aotphnkractcntev,p16_aotphnkractflagev,p17_aotemailkractcntev,p17_aotemailkractflagev,p18_aotipaddrkractcntev,p18_aotipaddrkractflagev,p19_aotbnkacctkractcntev,p19_aotbnkacctkractflagev,' +
'p20_aotdlkractcntev,p20_aotdlkractflagev,p9_aotaddrsafeactcntev,p9_aotaddrsafeactflagev,p16_aotphnsafeactcntev,p16_aotphnsafeactflagev,p18_aotipaddrsafeactcntev,p18_aotipaddrsafeactflagev,p1_aotidkractshrdcntev,p1_aotidkractshrdflagev,p1_aotidkrappfrdactshrdcntev,p1_aotidkrappfrdactshrdflagev,' +
'p1_aotidkrgenfrdactshrdcntev,p1_aotidkrgenfrdactshrdflagev,p1_aotidkrothfrdactshrdcntev,p1_aotidkrothfrdactshrdflagev,p1_aotidkrstolidactshrdcntev,p1_aotidkrstolidactshrdflagev,p9_aotaddrkractshrdcntev,p9_aotaddrkractshrdflagev,p15_aotssnkractshrdcntev,p15_aotssnkractshrdflagev,p16_aotphnkractshrdcntev,p16_aotphnkractshrdflagev,' +
'p17_aotemailkractshrdcntev,p17_aotemailkractshrdflagev,p18_aotipaddrkractshrdcntev,p18_aotipaddrkractshrdflagev,p19_aotbnkacctkractshrdcntev,p19_aotbnkacctkractshrdflagev,p20_aotdlkractshrdcntev,p20_aotdlkractshrdflagev,p1_aotidnaccollactcntev,p1_aotidnaccollflagev,p1_aotidnaccollnewtype,p1_aotactcntev,' +
'p1_aotidactcntev,p1_aotidactcnt30d,p1_aotaddactcntev,p1_aotaddactcnt30d,p1_aotnonstactcntev,p1_aotnonstactcnt30d,p1_aotidnewkraftidactcntev,p1_aotidnewkraftaddactcntev,p1_aotidnewkraftnonstactcntev,p9_aotactcntev,p9_aotidactcntev,p9_aotidactcnt30d,' +
'p9_aotaddactcntev,p9_aotaddactcnt30d,p9_aotnonstactcntev,p9_aotnonstactcnt30d,p9_aotaddrnewkraftidactcntev,p9_aotaddrnewkraftaddactcntev,p9_aotaddrnewkraftnonstactcntev,p15_aotactcntev,p15_aotidactcntev,p15_aotidactcnt30d,p15_aotaddactcntev,p15_aotaddactcnt30d,' +
'p15_aotnonstactcntev,p15_aotnonstactcnt30d,p15_aotssnnewkraftidactcntev,p15_aotssnnewkraftaddactcntev,p15_aotssnnewkraftnonstactcntev,p16_aotactcntev,p16_aotidactcntev,p16_aotidactcnt30d,p16_aotaddactcntev,p16_aotaddactcnt30d,p16_aotnonstactcntev,p16_aotnonstactcnt30d,' +
'p16_aotphnnewkraftidactcntev,p16_aotphnnewkraftaddactcntev,p16_aotphnnewkraftnonstactcntev,p17_aotactcntev,p17_aotidactcntev,p17_aotidactcnt30d,p17_aotaddactcntev,p17_aotaddactcnt30d,p17_aotnonstactcntev,p17_aotnonstactcnt30d,p17_aotemlnewkraftidactcntev,p17_aotemlnewkraftaddactcntev,' +
'p17_aotemlnewkraftnonstactcntev,p18_aotactcntev,p18_aotidactcntev,p18_aotidactcnt30d,p18_aotaddactcntev,p18_aotaddactcnt30d,p18_aotnonstactcntev,p18_aotnonstactcnt30d,p18_aotipnewkraftidactcntev,p18_aotipnewkraftaddactcntev,p18_aotipnewkraftnonstactcntev,p19_aotactcntev,' +
'p19_aotidactcntev,p19_aotidactcnt30d,p19_aotaddactcntev,p19_aotaddactcnt30d,p19_aotnonstactcntev,p19_aotnonstactcnt30d,p19_aotbkacnewkraftidactcntev,p19_aotbkacnewkraftaddactcntev,p19_aotbkacnewkraftnonstactcntev,p20_aotactcntev,p20_aotidactcntev,p20_aotidactcnt30d,' +
'p20_aotaddactcntev,p20_aotaddactcnt30d,p20_aotnonstactcntev,p20_aotnonstactcnt30d,p20_aotdlnewkraftidactcntev,p20_aotdlnewkraftaddactcntev,p20_aotdlnewkraftnonstactcntev,p9_aotidcurrprofusngaddrcntev,p15_aotidcurrprofusngssncntev,p16_aotidcurrprofusngphncntev,p17_aotidcurrprofusngemlcntev,p18_aotidcurrprofusngipcntev,' +
'p19_aotidcurrprofusngbkaccntev,p20_aotidcurrprofusngdlcntev,p9_aotidhistprofusngaddrcntev,p15_aotidhistprofusngssncntev,p16_aotidhistprofusngphncntev,p17_aotidhistprofusngemlcntev,p18_aotidhistprofusngipcntev,p19_aotidhistprofusngbkaccntev,p20_aotidhistprofusngdlcntev,p9_aotidusngaddrcntev,p15_aotidusngssncntev,p16_aotidusngphncntev,' +
'p17_aotidusngemailcntev,p18_aotidusngipaddrcntev,p19_aotidusngbnkacctcntev,p20_aotidusngdlcntev,p1_idriskunscrbleflag,p9_addrriskunscrbleflag,p15_ssnriskunscrbleflag,p16_phnriskunscrbleflag,p17_emailriskunscrbleflag,p18_ipaddrriskunscrbleflag,p19_bnkacctriskunscrbleflag,p20_dlriskunscrbleflag,' +
'p1_aotidkractinagcycntev,p1_aotidkractinagcyflagev,p1_aotidkrappfrdactinagcycntev,p1_aotidkrappfrdactinagcyflagev,p1_aotidkrgenfrdactinagcycntev,p1_aotidkrgenfrdactinagcyflagev,p1_aotidkrothfrdactinagcycntev,p1_aotidkrothfrdactinagcyflagev,p1_aotidkrstolidactinagcycntev,p1_aotidkrstolidactinagcyflagev,p9_aotaddrkractinagcycntev,p9_aotaddrkractinagcyflagev,' +
'p15_aotssnkractinagcycntev,p15_aotssnkractinagcyflagev,p16_aotphnkractinagcycntev,p16_aotphnkractinagcyflagev,p17_aotemailkractinagcycntev,p17_aotemailkractinagcyflagev,p18_aotipaddrkractinagcycntev,p18_aotipaddrkractinagcyflagev,p19_aotbnkacctkractinagcycntev,p19_aotbnkacctkractinagcyflagev,p20_aotdlkractinagcycntev,p20_aotdlkractinagcyflagev,' +
't_evttype1statuscodeecho,t_evttype2statuscodeecho,t_evttype3statuscodeecho,t_namestatuscodeecho,t_idstatuscodeecho,t_ssnstatuscodeecho,t_dlstatuscodeecho,t_addrstatuscodeecho,t_phnstatuscodeecho,t_emailstatuscodeecho,t_ipaddrstatuscodeecho,t_bnkacctstatuscodeecho,' +
'p1_aotidkractshrdsrcagencycntev,p1_aotidkractshrdnewsrcagencydescev,p1_aotidkrgenfrdactshrdsrcagencycntev,p1_aotidkrgenfrdactshrdnewsrcagencydescev,p1_aotidkrstolidactshrdsrcagencycntev,' +
'p1_aotidkrstolidactshrdnewsrcagencydescev,p1_aotidkrappfrdactshrdsrcagencycntev,p1_aotidkrappfrdactshrdnewsrcagencydescev,p1_aotidkrothfrdactshrdsrcagencycntev,p1_aotidkrothfrdactshrdnewsrcagencydescev,p9_aotaddrkractshrdsrcagencycntev,' +
'p9_aotaddrkractshrdnewsrcagencydescev,p15_aotssnkractshrdsrcagencycntev,p15_aotssnkractshrdnewsrcagencydescev,p16_aotphnkractshrdsrcagencycntev,p16_aotphnkractshrdnewsrcagencydescev,p17_aotemailkractshrdsrcagencycntev,' +
'p17_aotemailkractshrdnewsrcagencydescev,p18_aotipaddrkractshrdsrcagencycntev,p18_aotipaddrkractshrdnewsrcagencydescev,p19_aotbnkacctkractshrdsrcagencycntev,p19_aotbnkacctkractshrdnewsrcagencydescev,p20_aotdlkractshrdsrcagencycntev,p20_aotdlkractshrdnewsrcagencydescev'
);




//EventStatsPrep;

FieldGrouped := GROUP(SORT(DISTRIBUTE(EventStatsPrep, HASH(field)), field, LOCAL),field, LOCAL); 
// Dedupe to get one value per field per person entity context uid

FieldGroupedValues := DEDUP(UNGROUP(FieldGrouped), personentitycontextuid, field, value);
FieldCardinalityPrep := TABLE(FieldGroupedValues, {field,value, unsigned reccount := COUNT(GROUP)}, field, value, MERGE);
//output(FieldCardinalityPrep, named('FieldCardinalityPrep'), all);

FieldCardinality := TABLE(FieldCardinalityPrep, {field, unsigned reccount := COUNT(GROUP)}, field, MERGE);
//output(FieldCardinality, named('FieldCardinality'), all);

//output(FieldGroupedValues, named('FieldGroupedValues'));
// for each lexid count the number of values for a field they have observed 
// we will use this to prioritize lexid selection so that one lexid that covers more values will be the default
PersonFieldGroupedValues := TABLE(FieldGroupedValues, {field,personentitycontextuid,fieldvaluecount := COUNT(GROUP)},field,personentitycontextuid, MERGE);
//output(topn(PersonFieldGroupedValues, 600, -fieldvaluecount), named('PersonFieldGroupedValues'), all);
// 
FieldGroupedValuesWithFieldValueObservations := 
     JOIN(FieldGroupedValues, PersonFieldGroupedValues, 
       LEFT.field=RIGHT.Field AND LEFT.personentitycontextuid = RIGHT.personentitycontextuid,
       LOCAL);
//output(topn(FieldGroupedValuesWithFieldValueObservations, 100, -fieldvaluecount) , named('FieldGroupedValuesWithFieldValueObservations'));

// Sort the field values so that the high observation lexidis are first and then
// dedupe to keep (n) number of rows per field/value combination
FieldGroupedValuesPrep := UNGROUP(DEDUP(SORT(FieldGroupedValuesWithFieldValueObservations,field,value,-fieldvaluecount, LOCAL),field,value, KEEP(10), LOCAL));

//output(FieldGroupedValuesPrep, named('FieldGroupedValuesPrep'));

FieldGroupedValuesPrep1 := TABLE(FieldGroupedValuesPrep, {field, value}, field, value, MERGE);
//output(FieldGroupedValuesPrep1(field = 'p15_aotidactcntev'), named('FieldGroupedValuesPrep1'), all);
FieldGroupedValuesCardinality := TABLE(FieldGroupedValuesPrep1, {field, reccount := COUNT(GROUP)}, field, MERGE);
//output(FieldGroupedValuesCardinality, named('FieldGroupedValuesCardinality'), all);

CardinalityCheck := JOIN(FieldGroupedValuesCardinality, FieldCardinality, LEFT.field=RIGHT.field AND LEFT.reccount = RIGHT.reccount, LOOKUP);
//output(CardinalityCheck, named('CardinalityCheck'), all);
// Pull the person entity context uids that we think will cover all the field values
TargetPersonEntityContextUids := 
       TABLE(FieldGroupedValuesPrep, 
         {
         personentitycontextuid,
         UNSIGNED2 fieldvaluecount := COUNT(GROUP)}, 
          personentitycontextuid, MERGE);

//output(TargetPersonEntityContextUids,, '~fraudgov::sampleentitycontextuids');
EXPORT KEL_ModelingValidationSample := TargetPersonEntityContextUids;
          