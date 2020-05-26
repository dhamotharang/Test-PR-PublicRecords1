
  IMPORT KELOtto, FraudGovPlatform_Analytics, FraudGovPlatform, Data_services, Std;


//	EXPORT WeightingChart := DATASET('~fraudgov::in::sprayed::configrisklevel:newweighting.csv', {INTEGER8 EntityType, STRING200 Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, INTEGER Weight, STRING Indicatortype,	STRING IndicatorDescription, STRING UiDescription}, CSV(HEADING(1)));
	EXPORT WeightingChart := DATASET('~fraudgov::in::sprayed::configattributes', {INTEGER8 EntityType, STRING200 Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, STRING IndicatorType, STRING IndicatorDescription, INTEGER Weight, STRING UiDescription, UNSIGNED customerid, UNSIGNED industrytype}, CSV(HEADING(1)));	

// Add a column to tag that have {value} so the str.findreplace is only done for those rows that need it (for speed in the join).
	EXPORT WeightingChartPrepped := PROJECT(WeightingChart(customerid=0 and industrytype = 0), TRANSFORM({RECORDOF(WeightingChart), BOOLEAN HasValue}, SELF.HasValue := Std.Str.Find(LEFT.UiDescription, '{value}') > 0, SELF.Indicatortype := Std.Str.ToUpperCase(LEFT.Indicatortype), SELF := LEFT));
	EXPORT CustomWeightingChartPrepped := PROJECT(WeightingChart(customerid !=0 and industrytype != 0), TRANSFORM({RECORDOF(WeightingChart), BOOLEAN HasValue}, SELF.HasValue := Std.Str.Find(LEFT.UiDescription, '{value}') > 0, SELF.Indicatortype := Std.Str.ToUpperCase(LEFT.Indicatortype), SELF := LEFT));


NicoleAttr := 'agencyuid,agencyprogtype,agencyprogjurst,t_srcagencyuid,t_srcagencyprogtype,t_actuid,t_actdtecho,t_srctype,t_srcclasstype,t_personuidecho,' +
't_inpclntitleecho,t_inpclnfirstnmecho,t_inpclnlastnmecho,t_inpclnnmsuffixecho,t_inpclnaddrprimrangeecho,t_inpclnaddrpredirecho,t_inpclnaddrprimnmecho,t_inpclnaddrsuffixecho,t_inpclnaddrpostdirecho,t_inpclnaddrunitdesigecho,' +
't_inpclnaddrsecrangeecho,t_inpclnaddrcityecho,t_inpclnaddrstecho,t_inpclnaddrzip5echo,t_inpclnaddrzip4echo,t_inpclnaddrlatecho,t_inpclnaddrlongecho,t_inpclnaddrcountyecho,t_inpclnaddrgeoblkecho,t_inpclnssnecho,' +
't_inpclndobecho,t_inpclndlecho,t_inpclndlstecho,t_inpclnemailecho,t_inpclnbnkacctecho,t_inpclnbnkacctrtgecho,t_inpclnipaddrecho,t_inpclnphnecho,t1_lexidpopflag,t1_rinidpopflag,' +
't18_isipmetahitflag,t18_ipaddrcity,t18_ipaddrcountry,t18_ipaddrregion,t18_ipaddrdomain,t18_ipaddrispnm,t18_ipaddrloctype,t18_ipaddrproxytype,t18_ipaddrproxydesc,t18_ipaddrisispflag,' +
't18_ipaddrasncompnm,t18_ipaddrasn,t18_ipaddrcompnm,t18_ipaddrorgnm,t18_ipaddrhostedflag,t18_ipaddrvpnflag,t18_ipaddrtornodeflag,t18_ipaddrlocnonusflag,t18_ipaddrlocmiamiflag,t19_bnkacctpopflag,' +
't19_isbnkapphitflag,t19_bnkacctbnknm,t19_bnkaccthrprepdrtgflag,t17_emailpopflag,t17_emaildomain,t17_emaildomaindispflag,t9_addrpopflag,t9_addrtype,t9_addrstatus,t16_phnpopflag,' +
't15_ssnpopflag,t20_dlpopflag,t18_ipaddrpopflag,t_inagencyflag,' +
't15_ssniskrflag,t20_dliskrflag,t9_addriskrflag,t16_phniskrflag,t17_emailiskrflag,' +
't18_ipaddriskrflag,t19_bnkacctiskrflag,t1_idiskrgenfrdflag,t1_idiskrstolidflag,t1_idiskrappfrdflag,t1_idiskrothfrdflag,t1_idiskrflag,t_firstnmpopflag,t_lastnmpopflag,t_dobpopflag,' +
'p1_aotidcurrprofflag,p9_aotaddrcurrprofflag,p15_aotssncurrprofflag,p20_aotdlcurrprofflag,p16_aotphncurrprofflag,p17_aotemailcurrprofflag,p18_aotipaddrcurrprofflag,p19_aotbnkacctcurrprofflag,p1_aotidkractcntev,p1_aotidkractflagev,' +
'p1_aotidkractshrdcntev,p1_aotidkractshrdflagev,p1_aotidkractolddtev,p1_aotidkractnewdtev,p1_aotidkractshrdolddtev,p1_aotidkractshrdnewdtev,p1_aotidkrappfrdactcntev,p1_aotidkrappfrdactflagev,p1_aotidkrappfrdactshrdcntev,p1_aotidkrappfrdactshrdflagev,' +
'p1_aotidkrappfrdactolddtev,p1_aotidkrappfrdactnewdtev,p1_aotidkrappfrdactshrdolddtev,p1_aotidkrappfrdactshrdnewdtev,p1_aotidkrgenfrdactcntev,p1_aotidkrgenfrdactflagev,p1_aotidkrgenfrdactshrdcntev,p1_aotidkrgenfrdactshrdflagev,p1_aotidkrgenfrdactolddtev,p1_aotidkrgenfrdactnewdtev,' +
'p1_aotidkrgenfrdactshrdolddtev,p1_aotidkrgenfrdactshrdnewdtev,p1_aotidkrothfrdactcntev,p1_aotidkrothfrdactflagev,p1_aotidkrothfrdactshrdcntev,p1_aotidkrothfrdactshrdflagev,p1_aotidkrothfrdactolddtev,p1_aotidkrothfrdactnewdtev,p1_aotidkrothfrdactshrdolddtev,p1_aotidkrothfrdactshrdnewdtev,' +
'p1_aotidkrstolidactcntev,p1_aotidkrstolidactflagev,p1_aotidkrstolidactshrdcntev,p1_aotidkrstolidactshrdflagev,p1_aotidkrstolidactolddtev,p1_aotidkrstolidactnewdtev,p1_aotidkrstolidactshrdolddtev,p1_aotidkrstolidactshrdnewdtev,p9_aotaddrkractcntev,p9_aotaddrkractflagev,' +
'p9_aotaddrkractshrdcntev,p9_aotaddrkractshrdflagev,p9_aotaddrkractolddtev,p9_aotaddrkractnewdtev,p9_aotaddrkractshrdolddtev,p9_aotaddrkractshrdnewdtev,p15_aotssnkractcntev,p15_aotssnkractflagev,p15_aotssnkractshrdcntev,p15_aotssnkractshrdflagev,' +
'p15_aotssnkractolddtev,p15_aotssnkractnewdtev,p15_aotssnkractshrdolddtev,p15_aotssnkractshrdnewdtev,p16_aotphnkractcntev,p16_aotphnkractflagev,p16_aotphnkractshrdcntev,p16_aotphnkractshrdflagev,p16_aotphnkractolddtev,p16_aotphnkractnewdtev,' +
't_evttype1statuscodeecho,t_evttype2statuscodeecho,t_evttype3statuscodeecho,t_idstatuscodeecho,t_namestatuscodeecho,t_addrstatuscodeecho,t_bnkacctstatuscodeecho,t_dlstatuscodeecho,t_emailstatuscodeecho,t_ipaddrstatuscodeecho,t_phnstatuscodeecho,t_ssnstatuscodeecho,' +
'p16_aotphnkractshrdolddtev,p16_aotphnkractshrdnewdtev,p17_aotemailkractcntev,p17_aotemailkractflagev,p17_aotemailkractshrdcntev,p17_aotemailkractshrdflagev,p17_aotemailkractolddtev,p17_aotemailkractnewdtev,p17_aotemailkractshrdolddtev,p17_aotemailkractshrdnewdtev,' +
'p18_aotipaddrkractcntev,p18_aotipaddrkractflagev,p18_aotipaddrkractshrdcntev,p18_aotipaddrkractshrdflagev,p18_aotipaddrkractolddtev,p18_aotipaddrkractnewdtev,p18_aotipaddrkractshrdolddtev,p18_aotipaddrkractshrdnewdtev,p19_aotbnkacctkractcntev,p19_aotbnkacctkractflagev,' +
'p19_aotbnkacctkractshrdcntev,p19_aotbnkacctkractshrdflagev,p19_aotbnkacctkractolddtev,p19_aotbnkacctkractnewdtev,p19_aotbnkacctkractshrdolddtev,p19_aotbnkacctkractshrdnewdtev,p20_aotdlkractcntev,p20_aotdlkractflagev,p20_aotdlkractshrdcntev,p20_aotdlkractshrdflagev,' +
'p20_aotdlkractolddtev,p20_aotdlkractnewdtev,p20_aotdlkractshrdolddtev,p20_aotdlkractshrdnewdtev,' +

't9_addrissafeflag,t16_phnissafeflag,t18_ipaddrissafeflag,p9_aotaddrsafeactcntev,p9_aotaddrsafeactflagev,p9_aotaddrsafeactolddtev,p9_aotaddrsafeactnewdtev,p16_aotphnsafeactcntev,p16_aotphnsafeactflagev,p16_aotphnsafeactolddtev,' +
		'p16_aotphnsafeactnewdtev,p18_aotipaddrsafeactcntev,p18_aotipaddrsafeactflagev,p18_aotipaddrsafeactolddtev,p18_aotipaddrsafeactnewdtev,' +
		't_isbcshllhitflag,t_bcshlllexidecho,t1l_lexidseenflag,t1l_bcshlllexidmatchesinpflag,t1l_idisbcshllhitflag,t1_idage,t1l_dobverindx,t1_napsummary,t1l_nassummary,t1_cvi,t1_fp3_stolenidentityindex,' +
		't1_fp3_syntheticidentityindex,t1_fp3_manipidentityindex,t1l_fp_sourcerisklevel,t1_adultidnotseenflag,t1l_ssnnotverflag,t1l_ssnwaltnaverflag,t1l_ssnwaddrnotverflag,t1_phnnotverflag,t1l_dobnotverflag,t1l_hiriskcviflag,t1l_medriskcviflag,' +
		't1_hdrsrccatcntlwflag,t1_stolidflag,t1_synthidflag,t1_manipidflag,t_bcshllarchdtecho,t1l_bestfirstnmecho,t1l_bestlastnmecho,t1l_bestfirstnmpopflag,t1l_bestlastnmpopflag,t1l_bestfullnmecho,t1l_curraddrprimrangeecho,' +
		't1l_curraddrpredirecho,t1l_curraddrprimnmecho,t1l_curraddrsuffixecho,t1l_curraddrpostdirecho,t1l_curraddrunitdesigecho,t1l_curraddrsecrangeecho,t1l_curraddrcityecho,t1l_curraddrstecho,t1l_curraddrzip5echo,t1l_curraddrpopflag,t1l_curraddrfullecho,' +
		't1l_curraddrolddt,t1l_curraddrnewdt,t1l_bestssnecho,t1l_bestssnpopflag,t1l_bestdobecho,t1l_bestdobpopflag,t1l_bestphnecho,t1l_bestphnpopflag,t1l_bestdlecho,t1l_bestdlstecho,t1l_bestdlpopflag,' +
		't1l_bestdlexpdt,t1l_bestfirstnmmatchesinpflag,t1l_bestlastnmmatchesinpflag,t1l_bestfullnmmatchesinpflag,t1l_curraddrmatchesinpflag,t1l_bestssnmatchesinpflag,t1l_bestdobmatchesinpflag,t1l_bestphnmatchesinpflag,t1l_bestdlmatchesinpflag,t1l_bestdlnotinagcyjurstflag,t_acttmecho,' +
		't_inpaddrtypeecho,t_inpclnaddrstreetecho,t_inpclnmailingaddrstreetecho,t_inpclnmailingaddrcityecho,t_inpclnmailingaddrstecho,t_inpclnmailingaddrzipecho,t_inpphncontacttypeecho,t_inpclncellphnecho,t_inpclnworkphnecho,t_inpclnbnkacct2echo,t_inpclnbnkacctrtg2echo,' +
		't_inpethnicityecho,t_inpraceecho,t_inpheadofhhecho,t_inprelationshipecho,t_inpdvcidecho,t_inpdvcuniquenumecho,t_inpdvcmacaddrecho,t_inpdvcserialnumecho,t_inpdvctypeecho,t_inpdvcidprovecho,t_inpdvclatecho,' +
		't_inpdvclongecho,t_inpinvestigatoridecho,t_inpreferralcaseidecho,t_inpreferraltypedescecho,t_inpreferralreasondescecho,t_inpreferraldispositionecho,t_inpclearedfraudecho,t_inpclearedreasonecho,t_inpcaseidecho,t_inpclientidecho,t_inpreasondescecho,' +
		't_agencyusernm,t1_idinvupdflag,t1l_iddeceasedflag,t1l_iddtofdeath,t1l_idcrimflsdmatchflag,t1l_idcrimhitflag,t1l_idcurrincarcflag,p1_aotidactcntev,p1_aotidactcnt30d,p9_aotidactcntev,p9_aotidactcnt30d,' +
		'p15_aotidactcntev,p15_aotidactcnt30d,p16_aotidactcntev,p16_aotidactcnt30d,p17_aotidactcntev,p17_aotidactcnt30d,p18_aotidactcntev,p18_aotidactcnt30d,p19_aotidactcntev,p19_aotidactcnt30d,p20_aotidactcntev,' +
		'p20_aotidactcnt30d,p1_aotaddactcntev,p1_aotaddactcnt30d,p9_aotaddactcntev,p9_aotaddactcnt30d,p15_aotaddactcntev,p15_aotaddactcnt30d,p16_aotaddactcntev,p16_aotaddactcnt30d,p17_aotaddactcntev,p17_aotaddactcnt30d,' +
		'p18_aotaddactcntev,p18_aotaddactcnt30d,p19_aotaddactcntev,p19_aotaddactcnt30d,p20_aotaddactcntev,p20_aotaddactcnt30d,p1_aotnonstactcntev,p1_aotnonstactcnt30d,p9_aotnonstactcntev,p9_aotnonstactcnt30d,p15_aotnonstactcntev,' +
		'p15_aotnonstactcnt30d,p16_aotnonstactcntev,p16_aotnonstactcnt30d,p17_aotnonstactcntev,p17_aotnonstactcnt30d,p18_aotnonstactcntev,p18_aotnonstactcnt30d,p19_aotnonstactcntev,p19_aotnonstactcnt30d,p20_aotnonstactcntev,p20_aotnonstactcnt30d,' +
		'p1_aotidnewkraftidactcntev,p9_aotaddrnewkraftidactcntev,p15_aotssnnewkraftidactcntev,p16_aotphnnewkraftidactcntev,p17_aotemlnewkraftidactcntev,p18_aotipnewkraftidactcntev,p19_aotbkacnewkraftidactcntev,p20_aotdlnewkraftidactcntev,p1_aotidnewkraftaddactcntev,p9_aotaddrnewkraftaddactcntev,p15_aotssnnewkraftaddactcntev,' +
		'p16_aotphnnewkraftaddactcntev,p17_aotemlnewkraftaddactcntev,p18_aotipnewkraftaddactcntev,p19_aotbkacnewkraftaddactcntev,p20_aotdlnewkraftaddactcntev,p1_aotidnewkraftnonstactcntev,p9_aotaddrnewkraftnonstactcntev,p15_aotssnnewkraftnonstactcntev,p16_aotphnnewkraftnonstactcntev,p17_aotemlnewkraftnonstactcntev,p18_aotipnewkraftnonstactcntev,' +
		'p19_aotbkacnewkraftnonstactcntev,p20_aotdlnewkraftnonstactcntev,p9_aotidcurrprofusngaddrcntev,p15_aotidcurrprofusngssncntev,p16_aotidcurrprofusngphncntev,p17_aotidcurrprofusngemlcntev,p18_aotidcurrprofusngipcntev,p19_aotidcurrprofusngbkaccntev,p20_aotidcurrprofusngdlcntev,p9_aotidhistprofusngaddrcntev,p15_aotidhistprofusngssncntev,' +
		'p16_aotidhistprofusngphncntev,p17_aotidhistprofusngemlcntev,p18_aotidhistprofusngipcntev,p19_aotidhistprofusngbkaccntev,p20_aotidhistprofusngdlcntev,p9_aotidusngaddrcntev,p15_aotidusngssncntev,p16_aotidusngphncntev,p17_aotidusngemailcntev,p18_aotidusngipaddrcntev,p19_aotidusngbnkacctcntev,' +
		'p20_aotidusngdlcntev,p9_aothiidcurrprofusngaddrcntev,p15_aothiidcurrprofusngssncntev,p16_aothiidcurrprofusngphncntev,p17_aothiidcurrprofusngemlcntev,p18_aothiidcurrprofusngipcntev,p19_aothiidcurrprofusngbkaccntev,p20_aothiidcurrprofusngdlcntev,p1_aotidnaclvl1flag,p2_aotidnaclvl2flag';
	

  EntityEventPivot := FraudgovKEL.KEL_EventPivot.EventPivotShell(AotCurrProfFlag=1); // only create entity stats for the last event per element/identity.
	
  EventStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(EntityEventPivot, 'customerid,industrytype,entitycontextuid,recordid', 
'eventdate,' +
/* Nicole's attributes' */

NicoleAttr

  ) : PERSIST('~temp::deleteme49');

  EntityStatsPrep1 := PROJECT(EventStatsPrep, TRANSFORM({RECORDOF(LEFT) AND NOT [entityhash]}, SELF := LEFT)); 
                             					
  // This is the final result for entity stats after w
  WeightedResultDefault := JOIN(EntityStatsPrep1(Value != ''), WeightingChartPrepped, 
                         LEFT.Field=RIGHT.Field AND ((INTEGER)LEFT.entitycontextuid[2..3] = RIGHT.EntityType OR (INTEGER)LEFT.entitycontextuid[2..3] = 1 AND RIGHT.EntityType = 11) AND
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
                         ), TRANSFORM({RECORDOF(LEFT), RIGHT.Weight}, 
                            SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, 0),
                            SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, -1), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
                            SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => 
														               MAP(RIGHT.HasValue => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), RIGHT.UiDescription), 
																					 LEFT.Label);
                            SELF.field := LEFT.field;
														SELF.IndicatorType := RIGHT.IndicatorType;
														SELF.IndicatorDescription := RIGHT.IndicatorDescription;
                            SELF := LEFT), LOOKUP, LEFT OUTER);
														
  WeightedResult := JOIN(WeightedResultDefault(Value != ''), CustomWeightingChartPrepped, 
	                       (UNSIGNED)LEFT.customerid = (UNSIGNED)RIGHT.customerid AND (UNSIGNED)LEFT.industrytype= (UNSIGNED)RIGHT.industrytype AND
                         LEFT.Field=RIGHT.Field AND ((INTEGER)LEFT.entitycontextuid[2..3] = RIGHT.EntityType OR (INTEGER)LEFT.entitycontextuid[2..3] = 1 AND RIGHT.EntityType = 11) AND
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
                         ), TRANSFORM({RECORDOF(LEFT), RIGHT.EntityType},
                            SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, LEFT.Weight),
                            SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, LEFT.RiskLevel), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
                            SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => 
														               MAP(RIGHT.HasValue => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), RIGHT.UiDescription), 
																					 LEFT.Label);
                            SELF.field := LEFT.field,
														SELF.EntityType := (INTEGER)LEFT.entitycontextuid[2..3],
														SELF.IndicatorType := MAP(RIGHT.IndicatorType != '' => RIGHT.IndicatorType, LEFT.IndicatorType);
														SELF.IndicatorDescription := MAP(RIGHT.IndicatorDescription != '' => RIGHT.IndicatorDescription, LEFT.IndicatorDescription);
                            SELF := LEFT), LOOKUP, LEFT OUTER);// : PERSIST('~temp::deleteme92', EXPIRE(7));
														
  
EntityStats := WeightedResult(RiskLevel in [0,1,2,3] AND Value != '0') : INDEPENDENT;

output(EntityStats,, '~gov::otto::pivotentitystats', overwrite, compressed);


SuperSpecialEntityStatsForFilter := JOIN(EntityStats, EntityEventPivot, LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND
                                      LEFT.entitycontextuid=RIGHT.entitycontextuid AND LEFT.recordid=RIGHT.recordid, 
                                      TRANSFORM({RECORDOF(LEFT), 
                                        RIGHT.aotkractflagev, RIGHT.aotsafeactflagev,
																				RIGHT.t_actdtecho, RIGHT.t9_addriskrflag,RIGHT.t18_ipaddrlocmiamiflag,RIGHT.t18_ipaddrlocnonusflag,RIGHT.t18_ipaddrhostedflag,RIGHT.t18_ipaddrvpnflag,RIGHT.t18_ipaddrtornodeflag,RIGHT.t18_ipaddriskrflag,RIGHT.t19_bnkaccthrprepdrtgflag,RIGHT.t19_bnkacctiskrflag,RIGHT.t17_emaildomaindispflag,
																				RIGHT.t17_emailiskrflag,RIGHT.t15_ssniskrflag,RIGHT.t20_dliskrflag,RIGHT.t16_phniskrflag,RIGHT.t1_idiskrflag,RIGHT.t1_idiskrgenfrdflag,RIGHT.t1_idiskrappfrdflag,RIGHT.t1_idiskrothfrdflag,		
																				RIGHT.p1_aotidkrstolidactflagev, RIGHT.p1_aotidkrgenfrdactflagev,RIGHT.p1_aotidkrappfrdactflagev,RIGHT.p1_aotidkrothfrdactflagev,RIGHT.p9_aotaddrkractflagev,RIGHT.p15_aotssnkractflagev,RIGHT.p16_aotphnkractflagev,RIGHT.p17_aotemailkractflagev,RIGHT.p18_aotipaddrkractflagev,RIGHT.p19_aotbnkacctkractflagev,RIGHT.p20_aotdlkractflagev,
																				RIGHT.eventdate,RIGHT.incustomerpopulation,RIGHT.kreventafterknownrisk,RIGHT.RiskIndx
																				},
                                        SELF := LEFT, SELF := RIGHT), KEEP(1), HASH);
																				
EXPORT KEL_EntityStats := SuperSpecialEntityStatsForFilter;