
  IMPORT KELOtto, FraudGovPlatform_Analytics, FraudGovPlatform, Data_services, Std;

    EXPORT WeightingChart := DATASET('~fraudgov::in::sprayed::configattributes', {INTEGER8 EntityType, STRING200 Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, STRING IndicatorType, STRING IndicatorDescription, INTEGER Weight, STRING UiDescription, UNSIGNED customerid, UNSIGNED industrytype}, CSV(HEADING(1)));    


// Add a column to tag that have {value} so the str.findreplace is only done for those rows that need it (for speed in the join).
    EXPORT WeightingChartPrepped := PROJECT(WeightingChart(customerid=0 and industrytype = 0), TRANSFORM({RECORDOF(WeightingChart), BOOLEAN HasValue}, SELF.HasValue := Std.Str.Find(LEFT.UiDescription, '{value}') > 0, SELF.Indicatortype := Std.Str.ToUpperCase(LEFT.Indicatortype), SELF := LEFT));
    EXPORT CustomWeightingChartPrepped := PROJECT(WeightingChart(customerid !=0 and industrytype != 0), TRANSFORM({RECORDOF(WeightingChart), BOOLEAN HasValue}, SELF.HasValue := Std.Str.Find(LEFT.UiDescription, '{value}') > 0, SELF.Indicatortype := Std.Str.ToUpperCase(LEFT.Indicatortype), SELF := LEFT));

NicoleAttr := 't17_emaildomaindispflag,t18_ipaddrhostedflag,t18_ipaddrvpnflag,t18_ipaddrtornodeflag,t18_ipaddrlocnonusflag,t18_ipaddrlocmiamiflag,t19_bnkaccthrprepdrtgflag,t1l_dobnotverflag,' +
't1_stolidflag,t1_synthidflag,t1_manipidflag,t1_adultidnotseenflag,t1_addrnotverflag,t1l_ssnwaltnaverflag,t1_firstnmnotverflag,t1_hiriskcviflag,t1_medriskcviflag,t1_minorwlexidflag,t1_lastnmnotverflag,' +
't1_phnnotverflag,t1l_ssnwaddrnotverflag,t1_ssnpriordobflag,t1l_ssnnotverflag,t1l_curraddrnotinagcyjurstflag,t1l_bestdlnotinagcyjurstflag,t1l_hdrsrccatcntlwflag,t1l_iddeceasedflag,t1l_idcurrincarcflag,' +
't1l_iddtofdeathaftidactflagev,p1_aotidkrstolidactflagev,p1_aotidkrgenfrdactflagev,p1_aotidkrappfrdactflagev,p1_aotidkrothfrdactflagev,p9_aotaddrkractflagev,p15_aotssnkractflagev,p16_aotphnkractflagev,' +
'p17_aotemailkractflagev,p18_aotipaddrkractflagev,p19_aotbnkacctkractflagev,p20_aotdlkractflagev,p16_aotidcurrprofusngphncntev,' +
't1_minoridflag,p1_idactolddt,t18_ipaddrcity,t18_ipaddrcountry,t18_ipaddrregion,t18_ipaddrdomain,t18_ipaddrispnm,t18_ipaddrloctype,t18_ipaddrproxytype,t18_ipaddrproxydesc,t18_ipaddrisispflag,' + 
't18_ipaddrasncompnm,t18_ipaddrasn,t18_ipaddrcompnm,t18_ipaddrorgnm,t19_bnkacctbnknm,p1_aotidkrappfrdactshrdflagev,p1_aotidkrgenfrdactshrdflagev,p1_aotidkrothfrdactshrdflagev,p1_aotidkrstolidactshrdflagev,' + 
'p9_aotaddrkractshrdflagev,p15_aotssnkractshrdflagev,p16_aotphnkractshrdflagev,p17_aotemailkractshrdflagev,p18_aotipaddrkractshrdflagev,p19_aotbnkacctkractshrdflagev,p20_aotdlkractshrdflagev,' +
'p9_idactolddt,p15_idactolddt,p16_idactolddt,p17_idactolddt,p18_idactolddt,p19_idactolddt,p20_idactolddt,p9_aotaddrsafeactflagev,p16_aotphnsafeactflagev,p18_aotipaddrsafeactflagev,' +
't9_addrisvacantflag,t9_addrisinvalidflag,t9_addriscmraflag,t9_addrpoboxmultcurridflagev,t15_ssnisinvalidflag,t15_ssnmultcurridflagev,t16_phnisinvalidflag,t16_phnprepdflag,t19_bnkacctmultcurridflagev,t20_dlisinvalidflag,t20_dlmultcurridflagev,' +
'p1_aotidkrstolidactinagcyflagev,p1_aotidkrgenfrdactinagcyflagev,p1_aotidkrappfrdactinagcyflagev,p1_aotidkrothfrdactinagcyflagev,p9_aotaddrkractinagcyflagev,' +
'p15_aotssnkractinagcyflagev,p16_aotphnkractinagcyflagev,p17_aotemailkractinagcyflagev,p18_aotipaddrkractinagcyflagev,p19_aotbnkacctkractinagcyflagev,p20_aotdlkractinagcyflagev';

  //EntityEventPivot := FraudgovKEL.KEL_EventPivot.EventPivotShell(AotCurrProfFlag=1); // only create entity stats for the last event per element/identity.
SHARED  EntityEventPivot := FraudgovKEL.KEL_EventPivot.EventPivotShell(AotCurrProfFlag=1); // only create entity stats for the last event per element/identity.
    
  EventStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(EntityEventPivot, 'customerid,industrytype,entitycontextuid,recordid', 
'eventdate,' +
/* Nicole's attributes' */

NicoleAttr

  ) : PERSIST('~fraudgov::temp::deleteme49');

  EntityStatsPrep1 := PROJECT(EventStatsPrep, TRANSFORM({RECORDOF(LEFT) AND NOT [entityhash]}, SELF := LEFT)); 
                                                 
  // This is the final result for entity stats after w
  WeightedResultDefault := JOIN(EntityStatsPrep1(Value != ''), WeightingChartPrepped, 
                         LEFT.Field=RIGHT.Field AND ((INTEGER)LEFT.entitycontextuid[2..3] = RIGHT.EntityType OR (INTEGER)LEFT.entitycontextuid[2..3] = 1) AND
                         (
                           (
                             RIGHT.Value NOT IN ['','0'] AND LEFT.Value = RIGHT.Value
                           )
                           OR
                           (
                             RIGHT.Value IN ['','0'] AND (RIGHT.Low = 0 AND RIGHT.High = 0)
                           )                           
                           OR
                           (
                             (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
                               (
                                 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
                                 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
                               )
                           )
                         ), TRANSFORM({RECORDOF(LEFT), RIGHT.Weight, RIGHT.EntityType}, 
                            SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, 0),
                            SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, -1), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
                            SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => 
                                            MAP(RIGHT.HasValue => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), RIGHT.UiDescription), 
                                              LEFT.Label);
                            SELF.field := LEFT.field,
                            SELF.EntityType := RIGHT.EntityType,
                            SELF.IndicatorType := RIGHT.IndicatorType,
                            SELF.IndicatorDescription := RIGHT.IndicatorDescription,
                            SELF := LEFT), LOOKUP, LEFT OUTER);

WeightedResult := JOIN(WeightedResultDefault(Value != ''), CustomWeightingChartPrepped, 
                           (UNSIGNED)LEFT.customerid = (UNSIGNED)RIGHT.customerid AND (UNSIGNED)LEFT.industrytype= (UNSIGNED)RIGHT.industrytype AND
                         LEFT.Field=RIGHT.Field AND ((INTEGER)LEFT.entitycontextuid[2..3] = RIGHT.EntityType OR (INTEGER)LEFT.entitycontextuid[2..3] = 1) AND
                         (
                           (
                             RIGHT.Value NOT IN ['','0'] AND LEFT.Value = RIGHT.Value
                           )
                           OR
                           (
                             RIGHT.Value IN ['','0'] AND (RIGHT.Low = 0 AND RIGHT.High = 0)
                           )                           
                           OR
                           (
                             (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
                               (
                                 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
                                 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
                               )
                           )
                         ), TRANSFORM(RECORDOF(LEFT),
                            SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, LEFT.Weight),
                            SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, LEFT.RiskLevel), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
                            SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => 
                                            MAP(RIGHT.HasValue => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), RIGHT.UiDescription), 
                                             LEFT.Label);
                            SELF.field := LEFT.field,
                            SELF.EntityType := MAP(RIGHT.Field != '' => RIGHT.EntityType, LEFT.EntityType),
                            SELF.IndicatorType := MAP(RIGHT.IndicatorType != '' => RIGHT.IndicatorType, LEFT.IndicatorType);
                            SELF.IndicatorDescription := MAP(RIGHT.IndicatorDescription != '' => RIGHT.IndicatorDescription, LEFT.IndicatorDescription);
                            SELF := LEFT), LOOKUP, LEFT OUTER);// : PERSIST('~fraudgov::temp::deleteme92', EXPIRE(7));

EntityStats := WeightedResult(RiskLevel in [0,1,2,3] AND Value != '0') : INDEPENDENT;

SuperSpecialEntityStatsForFilter := JOIN(EntityStats, EntityEventPivot, LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND
						  LEFT.entitycontextuid=RIGHT.entitycontextuid AND LEFT.recordid=RIGHT.recordid, 
						  TRANSFORM({RECORDOF(LEFT), 
							RIGHT.aotkractflagev, RIGHT.aotsafeactflagev,RIGHT.aotcurrprofflag,RIGHT.iscurrent,
							RIGHT.t_actdtecho,RIGHT.t18_ipaddrlocmiamiflag,RIGHT.t18_ipaddrlocnonusflag,RIGHT.t18_ipaddrhostedflag,RIGHT.t18_ipaddrvpnflag,RIGHT.t18_ipaddrtornodeflag,RIGHT.t19_bnkaccthrprepdrtgflag,RIGHT.t17_emaildomaindispflag,    
							RIGHT.p1_aotidkrstolidactflagev, RIGHT.p1_aotidkrgenfrdactflagev,RIGHT.p1_aotidkrappfrdactflagev,RIGHT.p1_aotidkrothfrdactflagev,RIGHT.p9_aotaddrkractflagev,RIGHT.p15_aotssnkractflagev,RIGHT.p16_aotphnkractflagev,RIGHT.p17_aotemailkractflagev,RIGHT.p18_aotipaddrkractflagev,RIGHT.p19_aotbnkacctkractflagev,RIGHT.p20_aotdlkractflagev,
							RIGHT.not_aotkractflagev,RIGHT.not_aotsafeactflagev,
							RIGHT.T1l_dobnotverflag, RIGHT.T1_stolidflag,RIGHT.T1_synthidflag,RIGHT.T1_manipidflag,
							RIGHT.t1_adultidnotseenflag,RIGHT.t1_addrnotverflag,RIGHT.t1l_ssnwaltnaverflag,RIGHT.t1_firstnmnotverflag,RIGHT.T1_hiriskcviflag,RIGHT.t1_medriskcviflag,RIGHT.t1_minorwlexidflag,RIGHT.t1_lastnmnotverflag,RIGHT.t1_phnnotverflag,RIGHT.t1l_ssnwaddrnotverflag,RIGHT.t1_ssnpriordobflag,RIGHT.t1l_ssnnotverflag,
							RIGHT.t1l_curraddrnotinagcyjurstflag,RIGHT.t1l_bestdlnotinagcyjurstflag,RIGHT.t1L_hdrsrccatcntlwflag,RIGHT.t1l_iddeceasedflag,RIGHT.t1l_idcurrincarcflag,RIGHT.t1l_iddtofdeathaftidactflagev,RIGHT.aotidcurrprofusngcntev,
							RIGHT.t9_addrisvacantflag,RIGHT.t9_addrisinvalidflag,RIGHT.t9_addriscmraflag,RIGHT.t9_addrpoboxmultcurridflagev,RIGHT.t15_ssnisinvalidflag,RIGHT.t15_ssnmultcurridflagev,RIGHT.t16_phnisinvalidflag,RIGHT.t16_phnprepdflag,RIGHT.t19_bnkacctmultcurridflagev,RIGHT.t20_dlisinvalidflag,RIGHT.t20_dlmultcurridflagev,
							RIGHT.incustomerpopulation,RIGHT.t_inagencyflag,RIGHT.RiskIndx,RIGHT.p1_aotidkrappfrdactshrdflagev,RIGHT.p1_aotidkrgenfrdactshrdflagev,RIGHT.p1_aotidkrothfrdactshrdflagev,RIGHT.p1_aotidkrstolidactshrdflagev,RIGHT.p9_aotaddrkractshrdflagev,RIGHT.p15_aotssnkractshrdflagev,
							RIGHT.p16_aotphnkractshrdflagev,RIGHT.p17_aotemailkractshrdflagev,RIGHT.p18_aotipaddrkractshrdflagev,RIGHT.p19_aotbnkacctkractshrdflagev,RIGHT.p20_aotdlkractshrdflagev,
							RIGHT.p1_aotidkrstolidactinagcyflagev,RIGHT.p1_aotidkrgenfrdactinagcyflagev,RIGHT.p1_aotidkrappfrdactinagcyflagev,RIGHT.p1_aotidkrothfrdactinagcyflagev,RIGHT.p9_aotaddrkractinagcyflagev,
							RIGHT.p15_aotssnkractinagcyflagev,RIGHT.p16_aotphnkractinagcyflagev,RIGHT.p17_aotemailkractinagcyflagev,RIGHT.p18_aotipaddrkractinagcyflagev,RIGHT.p19_aotbnkacctkractinagcyflagev,RIGHT.p20_aotdlkractinagcyflagev
							},
							SELF := LEFT, SELF := RIGHT), KEEP(1), HASH);

EXPORT KEL_EntityStats := SuperSpecialEntityStatsForFilter;