
EXPORT KEL_EventShell := MODULE

    IMPORT FraudgovKEL;
    IMPORT FraudGovPlatform_Analytics;
    IMPORT KEL12 AS KEL;
    IMPORT HIPIE_ECL;
    EXPORT CleanEventShell := KEL.Clean(FraudgovKEL.Q__show_Customer_Person_Event.Res0, TRUE /*Remove __Flags*/, TRUE /*Remove __recordcounts*/, TRUE /*Remove _ from Field Names*/);
    EXPORT OriginalAttr := 'ottoaddressid,deceaseddate,deceaseddateofbirth,deceasedfirst,deceasedmiddle,deceasedlast,phonenumber,ottoemailid,ottoipaddressid,ottodriverslicenseid,currentlyincarceratedflag,deceased,' +
        'eventage,contributorsafeflag,personeventcount,' +
        'safeflag';
    EXPORT StructuralAttr := 'rin_sourcelabel,rin_source,' +
        //'addreventafterkrflag,ssneventafterkrflag,personeventafterkrflag,phoneeventafterkrflag,emaileventafterkrflag,ipeventafterkrflag,bankaccounteventafterkrflag,driverslicenseeventafterkrflag,'+
        //'addreventafterkrcount,ssneventafterkrcount,personeventafterkrcount,phoneeventafterkrcount,emaileventafterkrcount,ipeventafterkrcount,bankaccounteventafterkrcount,driverslicenseeventafterkrcount,'+
        //'kreventafterknownrisk,krpersonprofileflag,kremailprofileflag,kraddressprofileflag,kripprofileflag,krssnprofileflag,krphoneprofileflag,krbankaccountprofileflag,krdriverslicenseprofileflag,' +
        'idislasteventid,emlislasteventid,addrislasteventid,ipislasteventid,bnkislasteventid,dlislasteventid,ssnislasteventid,phislasteventid,' +
        'personlabel,emaillabel,addresslabel,iplabel,bankaccountlabel,driverslicenselabel,ssnlabel,phonelabel,' +
        'addressentitycontextuid,ssnentitycontextuid,personentitycontextuid,phoneentitycontextuid,emailentitycontextuid,ipentitycontextuid,bankaccountentitycontextuid,driverslicenseentitycontextuid,'+ 
        'streetaddress,city,state,zip,incustomerpopulation';
    EXPORT NicoleAttr := 'agencyuid,agencyprogtype,agencyprogdesc,agencyprogjurst,t_srcagencyuid,t_srcagencyprogtype,t_actuid,t_actdtecho,t_srctype,t_srcdesc,t_srcclasstype,t_personuidecho,' +
        't_inpclnaddrstreetecho,t_inpclnmiddlenmecho,t_inpcaseidecho,t_inpdvcidecho,' +
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
    't_evttype1statuscodeecho,t_evttype2statuscodeecho,t_evttype3statuscodeecho,t_idstatuscodeecho,t_namestatuscodeecho,t_addrstatuscodeecho,t_bnkacctstatuscodeecho,t_dlstatuscodeecho,t_emailstatuscodeecho,t_ipaddrstatuscodeecho,t_phnstatuscodeecho,t_ssnstatuscodeecho,' +
        'p1_aotidkrstolidactcntev,p1_aotidkrstolidactflagev,p1_aotidkrstolidactshrdcntev,p1_aotidkrstolidactshrdflagev,p1_aotidkrstolidactolddtev,p1_aotidkrstolidactnewdtev,p1_aotidkrstolidactshrdolddtev,p1_aotidkrstolidactshrdnewdtev,p9_aotaddrkractcntev,p9_aotaddrkractflagev,' +
        'p9_aotaddrkractshrdcntev,p9_aotaddrkractshrdflagev,p9_aotaddrkractolddtev,p9_aotaddrkractnewdtev,p9_aotaddrkractshrdolddtev,p9_aotaddrkractshrdnewdtev,p15_aotssnkractcntev,p15_aotssnkractflagev,p15_aotssnkractshrdcntev,p15_aotssnkractshrdflagev,' +
        'p15_aotssnkractolddtev,p15_aotssnkractnewdtev,p15_aotssnkractshrdolddtev,p15_aotssnkractshrdnewdtev,p16_aotphnkractcntev,p16_aotphnkractflagev,p16_aotphnkractshrdcntev,p16_aotphnkractshrdflagev,p16_aotphnkractolddtev,p16_aotphnkractnewdtev,' +
        'p16_aotphnkractshrdolddtev,p16_aotphnkractshrdnewdtev,p17_aotemailkractcntev,p17_aotemailkractflagev,p17_aotemailkractshrdcntev,p17_aotemailkractshrdflagev,p17_aotemailkractolddtev,p17_aotemailkractnewdtev,p17_aotemailkractshrdolddtev,p17_aotemailkractshrdnewdtev,' +
        'p18_aotipaddrkractcntev,p18_aotipaddrkractflagev,p18_aotipaddrkractshrdcntev,p18_aotipaddrkractshrdflagev,p18_aotipaddrkractolddtev,p18_aotipaddrkractnewdtev,p18_aotipaddrkractshrdolddtev,p18_aotipaddrkractshrdnewdtev,p19_aotbnkacctkractcntev,p19_aotbnkacctkractflagev,' +
        'p19_aotbnkacctkractshrdcntev,p19_aotbnkacctkractshrdflagev,p19_aotbnkacctkractolddtev,p19_aotbnkacctkractnewdtev,p19_aotbnkacctkractshrdolddtev,p19_aotbnkacctkractshrdnewdtev,p20_aotdlkractcntev,p20_aotdlkractflagev,p20_aotdlkractshrdcntev,p20_aotdlkractshrdflagev,' +
        'p20_aotdlkractolddtev,p20_aotdlkractnewdtev,p20_aotdlkractshrdolddtev,p20_aotdlkractshrdnewdtev,' +
        't9_addrissafeflag,t16_phnissafeflag,t18_ipaddrissafeflag,p9_aotaddrsafeactcntev,p9_aotaddrsafeactflagev,p9_aotaddrsafeactolddtev,p9_aotaddrsafeactnewdtev,p16_aotphnsafeactcntev,p16_aotphnsafeactflagev,p16_aotphnsafeactolddtev,' +
        'p16_aotphnsafeactnewdtev,p18_aotipaddrsafeactcntev,p18_aotipaddrsafeactflagev,p18_aotipaddrsafeactolddtev,p18_aotipaddrsafeactnewdtev,' +
        't_isbcshllhitflag,t_bcshlllexidecho,t1l_lexidseenflag,t1l_bcshlllexidmatchesinpflag,t1l_idisbcshllhitflag,t1_idage,t1l_dobverindx,t1_napsummary,t1l_iddeceasedflag,' +
        't1l_nassummary,t1_cvi,t1_fp3,t1_fp3_stolenidentityindex,t1_fp3_syntheticidentityindex,t1_fp3_manipidentityindex,t1l_fp_sourcerisklevel,t1_adultidnotseenflag,' +
        't1_minorwlexidflag,t1_ssnpriordobflag,t1_firstnmnotverflag,t1_lastnmnotverflag,t1_addrnotverflag,t1l_ssnnotverflag,t1l_ssnwaltnaverflag,t1l_ssnwaddrnotverflag,' +
        't1_phnnotverflag,t1l_dobnotverflag,t1_hiriskcviflag,t1_medriskcviflag,t1l_hdrsrccatcntlwflag,t1_stolidflag,t1_synthidflag,t1_manipidflag,' +
        't1l_iddtofdeathaftidactcntev,t1l_iddtofdeathaftidactflagev,t_bcshllarchdtecho,t1l_bestfirstnmecho,t1l_bestlastnmecho,t1l_bestfirstnmpopflag,t1l_bestlastnmpopflag,t1l_bestfullnmecho,' +
        't1l_curraddrprimrangeecho,t1l_curraddrpredirecho,t1l_curraddrprimnmecho,t1l_curraddrsuffixecho,t1l_curraddrpostdirecho,t1l_curraddrunitdesigecho,t1l_curraddrsecrangeecho,t1l_curraddrcityecho,' +
        't1l_curraddrstecho,t1l_curraddrzip5echo,t1l_curraddrpopflag,t1l_curraddrfullecho,t1l_curraddrolddt,t1l_curraddrnewdt,t1l_bestssnecho,t1l_bestssnpopflag,' +
        't1l_bestdobecho,t1l_bestdobpopflag,t1l_bestphnecho,t1l_bestphnpopflag,t1l_bestdlecho,t1l_bestdlstecho,t1l_bestdlpopflag,t1l_bestdlexpdt,' +
        't1l_bestfirstnmmatchesinpflag,t1l_bestlastnmmatchesinpflag,t1l_bestfullnmmatchesinpflag,t1l_curraddrmatchesinpflag,t1l_bestssnmatchesinpflag,t1l_bestdobmatchesinpflag,t1l_bestphnmatchesinpflag,t1l_bestdlmatchesinpflag,' +
        't1l_curraddrnotinagcyjurstflag,t1l_bestdlnotinagcyjurstflag,p1_aotidactcntev,p1_aotidactcnt30d,p9_aotidactcntev,p9_aotidactcnt30d,p15_aotidactcntev,p15_aotidactcnt30d,' +
        'p16_aotidactcntev,p16_aotidactcnt30d,p17_aotidactcntev,p17_aotidactcnt30d,p18_aotidactcntev,p18_aotidactcnt30d,p19_aotidactcntev,p19_aotidactcnt30d,' + // k
        'p20_aotidactcntev,p20_aotidactcnt30d,p1_aotaddactcntev,p1_aotaddactcnt30d,p9_aotaddactcntev,p9_aotaddactcnt30d,p15_aotaddactcntev,p15_aotaddactcnt30d,' +
        'p16_aotaddactcntev,p16_aotaddactcnt30d,p17_aotaddactcntev,p17_aotaddactcnt30d,p18_aotaddactcntev,p18_aotaddactcnt30d,p19_aotaddactcntev,p19_aotaddactcnt30d,' +
        'p20_aotaddactcntev,p20_aotaddactcnt30d,p1_aotnonstactcntev,p1_aotnonstactcnt30d,p9_aotnonstactcntev,p9_aotnonstactcnt30d,p15_aotnonstactcntev,p15_aotnonstactcnt30d,' +
        'p16_aotnonstactcntev,p16_aotnonstactcnt30d,p17_aotnonstactcntev,p17_aotnonstactcnt30d,p18_aotnonstactcntev,p18_aotnonstactcnt30d,p19_aotnonstactcntev,p19_aotnonstactcnt30d,' +
        'p20_aotnonstactcntev,p20_aotnonstactcnt30d,p1_aotidnewkraftidactcntev,p9_aotaddrnewkraftidactcntev,p15_aotssnnewkraftidactcntev,p16_aotphnnewkraftidactcntev,p17_aotemlnewkraftidactcntev,p18_aotipnewkraftidactcntev,' +
        'p19_aotbkacnewkraftidactcntev,p20_aotdlnewkraftidactcntev,p1_aotidnewkraftaddactcntev,p9_aotaddrnewkraftaddactcntev,p15_aotssnnewkraftaddactcntev,p16_aotphnnewkraftaddactcntev,p17_aotemlnewkraftaddactcntev,p18_aotipnewkraftaddactcntev,' +
        'p19_aotbkacnewkraftaddactcntev,p20_aotdlnewkraftaddactcntev,p1_aotidnewkraftnonstactcntev,p9_aotaddrnewkraftnonstactcntev,p15_aotssnnewkraftnonstactcntev,p16_aotphnnewkraftnonstactcntev,p17_aotemlnewkraftnonstactcntev,p18_aotipnewkraftnonstactcntev,' +
        'p19_aotbkacnewkraftnonstactcntev,p20_aotdlnewkraftnonstactcntev,p9_aotidcurrprofusngaddrcntev,p15_aotidcurrprofusngssncntev,p16_aotidcurrprofusngphncntev,p17_aotidcurrprofusngemlcntev,p18_aotidcurrprofusngipcntev,p19_aotidcurrprofusngbkaccntev,' +
        'p20_aotidcurrprofusngdlcntev,p9_aotidhistprofusngaddrcntev,p15_aotidhistprofusngssncntev,p16_aotidhistprofusngphncntev,p17_aotidhistprofusngemlcntev,p18_aotidhistprofusngipcntev,p19_aotidhistprofusngbkaccntev,p20_aotidhistprofusngdlcntev,' +
        'p9_aotidusngaddrcntev,p15_aotidusngssncntev,p16_aotidusngphncntev,p17_aotidusngemailcntev,p18_aotidusngipaddrcntev,p19_aotidusngbnkacctcntev,p20_aotidusngdlcntev,p1_aotidnaccollactcntev,' +
        'p1_aotidnaccollflagev,p1_aotidnaccollnewdt,p1_aotidnaccollnewtype,p1_idriskunscrbleflag,p9_addrriskunscrbleflag,p15_ssnriskunscrbleflag,p16_phnriskunscrbleflag,p17_emailriskunscrbleflag,' +
        'p18_ipaddrriskunscrbleflag,p19_bnkacctriskunscrbleflag,p20_dlriskunscrbleflag,t1l_idcurrincarcflag,'+  
        't_inpclnfullnmecho,t_acttmecho,t_inpaddrtypeecho,t_inpclnmailingaddrstreetecho,t_inpclnmailingaddrcityecho,t_inpclnmailingaddrstecho,t_inpclnmailingaddrzipecho,t_inpphncontacttypeecho,'+
        't_inpclncellphnecho,t_inpclnworkphnecho,t_inpclnbnkacct2echo,t_inpclnbnkacctrtg2echo,t_inpethnicityecho,t_inpraceecho,t_inpheadofhhecho,t_inprelationshipecho,t_inpdvcuniquenumecho,t_inpdvcmacaddrecho,t_inpdvcserialnumecho,'+

        't_inpdvctypeecho,t_inpdvcidprovecho,t_inpdvclatecho,t_inpdvclongecho,t_inpinvestigatoridecho,t_inpreferralcaseidecho,'+
        't_inpreferraltypedescecho,t_inpreferralreasondescecho,t_inpreferraldispositionecho,t_inpclearedfraudecho,'+
        't_inpreasondescecho,t_inpclientidecho,t_agencyusernm,t_statusactiondesc,'+
        't_inpclearedreasonecho,t1_idinvupdflag,t1l_iddtofdeath,t1l_idcrimflsdmatchflag,t1l_idcrimhitflag,' +
        't1_minoridflag,t9_idcurrprofusngaddrcntev,t15_idcurrprofusngssncntev,t20_idcurrprofusngdlcntev,t19_idcurrprofusngbnkacctcntev,t9_addrvaltype,t9_addrmaildroptype,' +
        't15_ssnvaltype,t20_dlvaltype,t16_phnvaltype,t16_isphnmetahitflag,t16_phnmetanewvenddt,t16_phnmetaoldvenddt,t9_addrpoboxmultcurridflagev,t9_addrisvacantflag,t9_addrisinvalidflag,' +
        't9_addriscmraflag,t15_ssnmultcurridflagev,t15_ssnisinvalidflag,t20_dlmultcurridflagev,t20_dlisinvalidflag,t16_phnprepdflag,t16_phnisinvalidflag,t19_bnkacctmultcurridflagev,' +
        'p1_idactolddt,p9_idactolddt,p15_idactolddt,p16_idactolddt,p17_idactolddt,p18_idactolddt,p19_idactolddt,p20_idactolddt,' +
        'p1_aotactcntev,p1_aotsrc1actcntev,p1_aotsrc1actonlyflag,p9_aotactcntev,p9_aotsrc1actcntev,p9_aotsrc1actonlyflag,' +
        'p15_aotactcntev,p15_aotsrc1actcntev,p15_aotsrc1actonlyflag,p20_aotactcntev,p20_aotsrc1actcntev,p20_aotsrc1actonlyflag,' +
        'p16_aotactcntev,p16_aotsrc1actcntev,p16_aotsrc1actonlyflag,p17_aotactcntev,p17_aotsrc1actcntev,p17_aotsrc1actonlyflag,' +
        'p18_aotactcntev,p18_aotsrc1actcntev,p18_aotsrc1actonlyflag,p19_aotactcntev,p19_aotsrc1actcntev,p19_aotsrc1actonlyflag,' +
        'p1_aotidkractinagcycntev,p1_aotidkractinagcyflagev,p1_aotidkractinagcyolddtev,p1_aotidkractinagcynewdtev,p1_aotidkrappfrdactinagcycntev,p1_aotidkrappfrdactinagcyflagev,' +
        'p1_aotidkrappfrdactinagcyolddtev,p1_aotidkrappfrdactinagcynewdtev,p1_aotidkrgenfrdactinagcycntev,p1_aotidkrgenfrdactinagcyflagev,p1_aotidkrgenfrdactinagcyolddtev,p1_aotidkrgenfrdactinagcynewdtev,' +
        'p1_aotidkrothfrdactinagcycntev,p1_aotidkrothfrdactinagcyflagev,p1_aotidkrothfrdactinagcyolddtev,p1_aotidkrothfrdactinagcynewdtev,p1_aotidkrstolidactinagcycntev,p1_aotidkrstolidactinagcyflagev,' +
        'p1_aotidkrstolidactinagcyolddtev,p1_aotidkrstolidactinagcynewdtev,p9_aotaddrkractinagcycntev,p9_aotaddrkractinagcyflagev,p9_aotaddrkractinagcyolddtev,p9_aotaddrkractinagcynewdtev,' +
        'p15_aotssnkractinagcycntev,p15_aotssnkractinagcyflagev,p15_aotssnkractinagcyolddtev,p15_aotssnkractinagcynewdtev,p16_aotphnkractinagcycntev,p16_aotphnkractinagcyflagev,' +
        'p16_aotphnkractinagcyolddtev,p16_aotphnkractinagcynewdtev,p17_aotemailkractinagcycntev,p17_aotemailkractinagcyflagev,p17_aotemailkractinagcyolddtev,p17_aotemailkractinagcynewdtev,' +
        'p18_aotipaddrkractinagcycntev,p18_aotipaddrkractinagcyflagev,p18_aotipaddrkractinagcyolddtev,p18_aotipaddrkractinagcynewdtev,p19_aotbnkacctkractinagcycntev,p19_aotbnkacctkractinagcyflagev,' +
        'p19_aotbnkacctkractinagcyolddtev,p19_aotbnkacctkractinagcynewdtev,p20_aotdlkractinagcycntev,p20_aotdlkractinagcyflagev,p20_aotdlkractinagcyolddtev,p20_aotdlkractinagcynewdtev,t_inpclnaddrgeomatchecho,' +
        'p1_aotidkractshrdsrcagencycntev,p1_aotidkractshrdnewsrcagencydescev,p1_aotidkrgenfrdactshrdsrcagencycntev,p1_aotidkrgenfrdactshrdnewsrcagencydescev,p1_aotidkrstolidactshrdsrcagencycntev,' +
        'p1_aotidkrstolidactshrdnewsrcagencydescev,p1_aotidkrappfrdactshrdsrcagencycntev,p1_aotidkrappfrdactshrdnewsrcagencydescev,p1_aotidkrothfrdactshrdsrcagencycntev,p1_aotidkrothfrdactshrdnewsrcagencydescev,' +
        'p9_aotaddrkractshrdsrcagencycntev,p9_aotaddrkractshrdnewsrcagencydescev,p15_aotssnkractshrdsrcagencycntev,p15_aotssnkractshrdnewsrcagencydescev,p16_aotphnkractshrdsrcagencycntev,' +
        'p16_aotphnkractshrdnewsrcagencydescev,p17_aotemailkractshrdsrcagencycntev,p17_aotemailkractshrdnewsrcagencydescev,p18_aotipaddrkractshrdsrcagencycntev,p18_aotipaddrkractshrdnewsrcagencydescev,' +
        'p19_aotbnkacctkractshrdsrcagencycntev,p19_aotbnkacctkractshrdnewsrcagencydescev,p20_aotdlkractshrdsrcagencycntev,p20_aotdlkractshrdnewsrcagencydescev,t18_ipaddrgeoloclat,t18_ipaddrgeoloclong,' +
        't9_addrnotinagcyjurstflag,' +

        't_srcagencydesc,agencydesc,t_srcagencyprogdesc,t_srcagencyprogjurst';

    EXPORT ModelingAttr := 'personentitycontextuid,addressentitycontextuid,ssnentitycontextuid,phoneentitycontextuid,emailentitycontextuid,ipentitycontextuid,bankaccountentitycontextuid,driverslicenseentitycontextuid,agencyuid,' +
        'agencyprogtype,agencyprogdesc,agencyprogjurst,t_actdtecho,t_acttmecho,t_srcagencyuid,t_srcagencyprogtype,t_inagencyflag,t_srctype,t_srcdesc,t_srcclasstype,t_personuidecho,' +
        't_inpclntitleecho,t_inpclnfirstnmecho,t_inpclnmiddlenmecho,t_inpclnlastnmecho,t_inpclnnmsuffixecho,t_inpclnfullnmecho,t_inpaddrtypeecho,t_inpclnaddrstreetecho,t_inpclnaddrprimrangeecho,t_inpclnaddrpredirecho,t_inpclnaddrprimnmecho,t_inpclnaddrsuffixecho,t_inpclnaddrpostdirecho,' +
        't_inpclnaddrunitdesigecho,t_inpclnaddrsecrangeecho,t_inpclnaddrcityecho,t_inpclnaddrstecho,t_inpclnaddrzip5echo,t_inpclnaddrzip4echo,t_inpclnaddrlatecho,t_inpclnaddrlongecho,t_inpclnaddrcountyecho,t_inpclnaddrgeoblkecho,t_inpclnssnecho,t_inpclndobecho,t_inpclndlecho,' +
        't_inpclndlstecho,t_inpphncontacttypeecho,t_inpclnphnecho,t_inpclnemailecho,t_inpclnipaddrecho,t_inpclnbnkacctecho,t_inpclnbnkacctrtgecho,t_inpclnmailingaddrstreetecho,t_inpclnmailingaddrcityecho,t_inpclnmailingaddrstecho,t_inpclnmailingaddrzipecho,t_inpclncellphnecho,t_inpclnworkphnecho,' +
        't_inpclnbnkacct2echo,t_inpclnbnkacctrtg2echo,t_inpdvcidecho,t_inpdvcuniquenumecho,t_inpdvcmacaddrecho,t_inpdvcserialnumecho,t_inpdvctypeecho,t_inpdvcidprovecho,t_inpdvclatecho,t_inpdvclongecho,t_inpethnicityecho,t_inpraceecho,t_inpheadofhhecho,' +
        't_inprelationshipecho,t_inpcaseidecho,t_inpclientidecho,t_inpreasondescecho,t_agencyusernm,t_inpinvestigatoridecho,t_inpreferralcaseidecho,t_inpreferraltypedescecho,t_inpreferralreasondescecho,t_inpreferraldispositionecho,t_inpclearedfraudecho,t_inpclearedreasonecho,t1_lexidpopflag,' +
        't1_rinidpopflag,t_firstnmpopflag,t_lastnmpopflag,t9_addrpopflag,t15_ssnpopflag,t_dobpopflag,t20_dlpopflag,t16_phnpopflag,t18_ipaddrpopflag,t17_emailpopflag,t19_bnkacctpopflag,t_isbcshllhitflag,t_bcshlllexidecho,' +
        't1l_lexidseenflag,t1l_bcshlllexidmatchesinpflag,t1l_idisbcshllhitflag,t_bcshllarchdtecho,t1l_idcrimhitflag,t1l_idcrimflsdmatchflag,t18_isipmetahitflag,t19_isbnkapphitflag,t16_isphnmetahitflag,t16_phnmetanewvenddt,t16_phnmetaoldvenddt,t1_idage,t1_minoridflag,' +
        't1_adultidnotseenflag,t1_minorwlexidflag,t1l_iddeceasedflag,t1l_iddtofdeath,t1l_iddtofdeathaftidactcntev,t1l_iddtofdeathaftidactflagev,t1l_idcurrincarcflag,t1l_dobverindx,t1_napsummary,t1l_nassummary,t1_cvi,t1l_fp_sourcerisklevel,t1_ssnpriordobflag,' +
        't1_firstnmnotverflag,t1_lastnmnotverflag,t1_addrnotverflag,t1l_ssnnotverflag,t1l_ssnwaltnaverflag,t1l_ssnwaddrnotverflag,t1_phnnotverflag,t1l_dobnotverflag,t1_hiriskcviflag,t1_medriskcviflag,t1l_hdrsrccatcntlwflag,t1_fp3,t1_fp3_stolenidentityindex,' +
        't1_fp3_syntheticidentityindex,t1_fp3_manipidentityindex,t1_stolidflag,t1_synthidflag,t1_manipidflag,t1l_bestfirstnmecho,t1l_bestlastnmecho,t1l_bestfirstnmpopflag,t1l_bestlastnmpopflag,t1l_bestfullnmecho,t1l_curraddrprimrangeecho,t1l_curraddrpredirecho,t1l_curraddrprimnmecho,' +
        't1l_curraddrsuffixecho,t1l_curraddrpostdirecho,t1l_curraddrunitdesigecho,t1l_curraddrsecrangeecho,t1l_curraddrcityecho,t1l_curraddrstecho,t1l_curraddrzip5echo,t1l_curraddrpopflag,t1l_curraddrfullecho,t1l_curraddrolddt,t1l_curraddrnewdt,t1l_bestssnecho,t1l_bestssnpopflag,' +
        't1l_bestdobecho,t1l_bestdobpopflag,t1l_bestphnecho,t1l_bestphnpopflag,t1l_bestdlecho,t1l_bestdlstecho,t1l_bestdlpopflag,t1l_bestdlexpdt,t1l_curraddrnotinagcyjurstflag,t1l_bestdlnotinagcyjurstflag,t1l_bestfirstnmmatchesinpflag,t1l_bestlastnmmatchesinpflag,t1l_bestfullnmmatchesinpflag,' +
        't1l_curraddrmatchesinpflag,t1l_bestssnmatchesinpflag,t1l_bestdobmatchesinpflag,t1l_bestphnmatchesinpflag,t1l_bestdlmatchesinpflag,t9_addrstatus,t9_addrtype,t9_addrvaltype,t9_addrmaildroptype,t9_addrisvacantflag,t9_addrisinvalidflag,t9_addriscmraflag,t15_ssnvaltype,' +
        't15_ssnisinvalidflag,t20_dlvaltype,t20_dlisinvalidflag,t16_phnvaltype,t16_phnisinvalidflag,t16_phnprepdflag,t18_ipaddrcity,t18_ipaddrcountry,t18_ipaddrregion,t18_ipaddrdomain,t18_ipaddrispnm,t18_ipaddrloctype,t18_ipaddrproxytype,' +
        't18_ipaddrproxydesc,t18_ipaddrisispflag,t18_ipaddrasncompnm,t18_ipaddrasn,t18_ipaddrcompnm,t18_ipaddrorgnm,t18_ipaddrhostedflag,t18_ipaddrvpnflag,t18_ipaddrtornodeflag,t18_ipaddrlocnonusflag,t18_ipaddrlocmiamiflag,t17_emaildomain,t17_emaildomaindispflag,' +
        't19_bnkacctbnknm,t19_bnkaccthrprepdrtgflag,t9_idcurrprofusngaddrcntev,t9_addrpoboxmultcurridflagev,t15_idcurrprofusngssncntev,t15_ssnmultcurridflagev,t20_idcurrprofusngdlcntev,t20_dlmultcurridflagev,t19_idcurrprofusngbnkacctcntev,t19_bnkacctmultcurridflagev,t_statusactiondesc,t_evttype1statuscodeecho,t_evttype2statuscodeecho,' +
        't_evttype3statuscodeecho,t_namestatuscodeecho,t_idstatuscodeecho,t_ssnstatuscodeecho,t_dlstatuscodeecho,t_addrstatuscodeecho,t_phnstatuscodeecho,t_emailstatuscodeecho,t_ipaddrstatuscodeecho,t_bnkacctstatuscodeecho,t1_idiskrappfrdflag,t1_idiskrgenfrdflag,t1_idiskrstolidflag,' +
        't1_idiskrothfrdflag,t1_idiskrflag,t9_addriskrflag,t15_ssniskrflag,t16_phniskrflag,t17_emailiskrflag,t18_ipaddriskrflag,t19_bnkacctiskrflag,t20_dliskrflag,t9_addrissafeflag,t16_phnissafeflag,t18_ipaddrissafeflag,t1_idinvupdflag,' +
        'p1_aotidcurrprofflag,p9_aotaddrcurrprofflag,p15_aotssncurrprofflag,p16_aotphncurrprofflag,p17_aotemailcurrprofflag,p18_aotipaddrcurrprofflag,p19_aotbnkacctcurrprofflag,p20_aotdlcurrprofflag,p1_aotidkractcntev,p1_aotidkractflagev,p1_aotidkractolddtev,p1_aotidkractnewdtev,p1_aotidkrappfrdactcntev,' +
        'p1_aotidkrappfrdactflagev,p1_aotidkrappfrdactolddtev,p1_aotidkrappfrdactnewdtev,p1_aotidkrgenfrdactcntev,p1_aotidkrgenfrdactflagev,p1_aotidkrgenfrdactolddtev,p1_aotidkrgenfrdactnewdtev,p1_aotidkrothfrdactcntev,p1_aotidkrothfrdactflagev,p1_aotidkrothfrdactolddtev,p1_aotidkrothfrdactnewdtev,p1_aotidkrstolidactcntev,p1_aotidkrstolidactflagev,' +
        'p1_aotidkrstolidactolddtev,p1_aotidkrstolidactnewdtev,p9_aotaddrkractcntev,p9_aotaddrkractflagev,p9_aotaddrkractolddtev,p9_aotaddrkractnewdtev,p15_aotssnkractcntev,p15_aotssnkractflagev,p15_aotssnkractolddtev,p15_aotssnkractnewdtev,p16_aotphnkractcntev,p16_aotphnkractflagev,p16_aotphnkractolddtev,' +
        'p16_aotphnkractnewdtev,p17_aotemailkractcntev,p17_aotemailkractflagev,p17_aotemailkractolddtev,p17_aotemailkractnewdtev,p18_aotipaddrkractcntev,p18_aotipaddrkractflagev,p18_aotipaddrkractolddtev,p18_aotipaddrkractnewdtev,p19_aotbnkacctkractcntev,p19_aotbnkacctkractflagev,p19_aotbnkacctkractolddtev,p19_aotbnkacctkractnewdtev,' +
        'p20_aotdlkractcntev,p20_aotdlkractflagev,p20_aotdlkractolddtev,p20_aotdlkractnewdtev,p9_aotaddrsafeactcntev,p9_aotaddrsafeactflagev,p9_aotaddrsafeactolddtev,p9_aotaddrsafeactnewdtev,p16_aotphnsafeactcntev,p16_aotphnsafeactflagev,p16_aotphnsafeactolddtev,p16_aotphnsafeactnewdtev,p18_aotipaddrsafeactcntev,' +
        'p18_aotipaddrsafeactflagev,p18_aotipaddrsafeactolddtev,p18_aotipaddrsafeactnewdtev,p1_aotidkractshrdcntev,p1_aotidkractshrdflagev,p1_aotidkractshrdolddtev,p1_aotidkractshrdnewdtev,p1_aotidkrappfrdactshrdcntev,p1_aotidkrappfrdactshrdflagev,p1_aotidkrappfrdactshrdolddtev,p1_aotidkrappfrdactshrdnewdtev,p1_aotidkrgenfrdactshrdcntev,p1_aotidkrgenfrdactshrdflagev,' +
        'p1_aotidkrgenfrdactshrdolddtev,p1_aotidkrgenfrdactshrdnewdtev,p1_aotidkrothfrdactshrdcntev,p1_aotidkrothfrdactshrdflagev,p1_aotidkrothfrdactshrdolddtev,p1_aotidkrothfrdactshrdnewdtev,p1_aotidkrstolidactshrdcntev,p1_aotidkrstolidactshrdflagev,p1_aotidkrstolidactshrdolddtev,p1_aotidkrstolidactshrdnewdtev,p9_aotaddrkractshrdcntev,p9_aotaddrkractshrdflagev,p9_aotaddrkractshrdolddtev,' +
        'p9_aotaddrkractshrdnewdtev,p15_aotssnkractshrdcntev,p15_aotssnkractshrdflagev,p15_aotssnkractshrdolddtev,p15_aotssnkractshrdnewdtev,p16_aotphnkractshrdcntev,p16_aotphnkractshrdflagev,p16_aotphnkractshrdolddtev,p16_aotphnkractshrdnewdtev,p17_aotemailkractshrdcntev,p17_aotemailkractshrdflagev,p17_aotemailkractshrdolddtev,p17_aotemailkractshrdnewdtev,' +
        'p18_aotipaddrkractshrdcntev,p18_aotipaddrkractshrdflagev,p18_aotipaddrkractshrdolddtev,p18_aotipaddrkractshrdnewdtev,p19_aotbnkacctkractshrdcntev,p19_aotbnkacctkractshrdflagev,p19_aotbnkacctkractshrdolddtev,p19_aotbnkacctkractshrdnewdtev,p20_aotdlkractshrdcntev,p20_aotdlkractshrdflagev,p20_aotdlkractshrdolddtev,p20_aotdlkractshrdnewdtev,p1_aotidnaccollactcntev,' +
        'p1_aotidnaccollflagev,p1_aotidnaccollnewdt,p1_aotidnaccollnewtype,p1_aotactcntev,p1_aotidactcntev,p1_aotidactcnt30d,p1_idactolddt,p1_aotaddactcntev,p1_aotaddactcnt30d,p1_aotnonstactcntev,p1_aotnonstactcnt30d,p1_aotidnewkraftidactcntev,p1_aotidnewkraftaddactcntev,' +
        'p1_aotidnewkraftnonstactcntev,p9_aotactcntev,p9_aotidactcntev,p9_aotidactcnt30d,p9_idactolddt,p9_aotaddactcntev,p9_aotaddactcnt30d,p9_aotnonstactcntev,p9_aotnonstactcnt30d,p9_aotaddrnewkraftidactcntev,p9_aotaddrnewkraftaddactcntev,p9_aotaddrnewkraftnonstactcntev,p15_aotactcntev,' +
        'p15_aotidactcntev,p15_aotidactcnt30d,p15_idactolddt,p15_aotaddactcntev,p15_aotaddactcnt30d,p15_aotnonstactcntev,p15_aotnonstactcnt30d,p15_aotssnnewkraftidactcntev,p15_aotssnnewkraftaddactcntev,p15_aotssnnewkraftnonstactcntev,p16_aotactcntev,p16_aotidactcntev,p16_aotidactcnt30d,' +
        'p16_idactolddt,p16_aotaddactcntev,p16_aotaddactcnt30d,p16_aotnonstactcntev,p16_aotnonstactcnt30d,p16_aotphnnewkraftidactcntev,p16_aotphnnewkraftaddactcntev,p16_aotphnnewkraftnonstactcntev,p17_aotactcntev,p17_aotidactcntev,p17_aotidactcnt30d,p17_idactolddt,p17_aotaddactcntev,' +
        'p17_aotaddactcnt30d,p17_aotnonstactcntev,p17_aotnonstactcnt30d,p17_aotemlnewkraftidactcntev,p17_aotemlnewkraftaddactcntev,p17_aotemlnewkraftnonstactcntev,p18_aotactcntev,p18_aotidactcntev,p18_aotidactcnt30d,p18_idactolddt,p18_aotaddactcntev,p18_aotaddactcnt30d,p18_aotnonstactcntev,' +
        'p18_aotnonstactcnt30d,p18_aotipnewkraftidactcntev,p18_aotipnewkraftaddactcntev,p18_aotipnewkraftnonstactcntev,p19_aotactcntev,p19_aotidactcntev,p19_aotidactcnt30d,p19_idactolddt,p19_aotaddactcntev,p19_aotaddactcnt30d,p19_aotnonstactcntev,p19_aotnonstactcnt30d,p19_aotbkacnewkraftidactcntev,' +
        'p19_aotbkacnewkraftaddactcntev,p19_aotbkacnewkraftnonstactcntev,p20_aotactcntev,p20_aotidactcntev,p20_aotidactcnt30d,p20_idactolddt,p20_aotaddactcntev,p20_aotaddactcnt30d,p20_aotnonstactcntev,p20_aotnonstactcnt30d,p20_aotdlnewkraftidactcntev,p20_aotdlnewkraftaddactcntev,p20_aotdlnewkraftnonstactcntev,' +
        'p9_aotidcurrprofusngaddrcntev,p15_aotidcurrprofusngssncntev,p16_aotidcurrprofusngphncntev,p17_aotidcurrprofusngemlcntev,p18_aotidcurrprofusngipcntev,p19_aotidcurrprofusngbkaccntev,p20_aotidcurrprofusngdlcntev,p9_aotidhistprofusngaddrcntev,p15_aotidhistprofusngssncntev,p16_aotidhistprofusngphncntev,p17_aotidhistprofusngemlcntev,p18_aotidhistprofusngipcntev,p19_aotidhistprofusngbkaccntev,' +
        'p20_aotidhistprofusngdlcntev,p9_aotidusngaddrcntev,p15_aotidusngssncntev,p16_aotidusngphncntev,p17_aotidusngemailcntev,p18_aotidusngipaddrcntev,p19_aotidusngbnkacctcntev,p20_aotidusngdlcntev,' +
        'p1_idriskunscrbleflag,p9_addrriskunscrbleflag,p15_ssnriskunscrbleflag,p16_phnriskunscrbleflag,p17_emailriskunscrbleflag,p18_ipaddrriskunscrbleflag,p19_bnkacctriskunscrbleflag,p20_dlriskunscrbleflag,' +
        'p1_aotidkractinagcycntev,p1_aotidkractinagcyflagev,p1_aotidkractinagcyolddtev,p1_aotidkractinagcynewdtev,p1_aotidkrappfrdactinagcycntev,p1_aotidkrappfrdactinagcyflagev,' +
        'p1_aotidkrappfrdactinagcyolddtev,p1_aotidkrappfrdactinagcynewdtev,p1_aotidkrgenfrdactinagcycntev,p1_aotidkrgenfrdactinagcyflagev,p1_aotidkrgenfrdactinagcyolddtev,p1_aotidkrgenfrdactinagcynewdtev,' +
        'p1_aotidkrothfrdactinagcycntev,p1_aotidkrothfrdactinagcyflagev,p1_aotidkrothfrdactinagcyolddtev,p1_aotidkrothfrdactinagcynewdtev,p1_aotidkrstolidactinagcycntev,p1_aotidkrstolidactinagcyflagev,' +
        'p1_aotidkrstolidactinagcyolddtev,p1_aotidkrstolidactinagcynewdtev,p9_aotaddrkractinagcycntev,p9_aotaddrkractinagcyflagev,p9_aotaddrkractinagcyolddtev,p9_aotaddrkractinagcynewdtev,' +
        'p15_aotssnkractinagcycntev,p15_aotssnkractinagcyflagev,p15_aotssnkractinagcyolddtev,p15_aotssnkractinagcynewdtev,p16_aotphnkractinagcycntev,p16_aotphnkractinagcyflagev,' +
        'p16_aotphnkractinagcyolddtev,p16_aotphnkractinagcynewdtev,p17_aotemailkractinagcycntev,p17_aotemailkractinagcyflagev,p17_aotemailkractinagcyolddtev,p17_aotemailkractinagcynewdtev,' +
        'p18_aotipaddrkractinagcycntev,p18_aotipaddrkractinagcyflagev,p18_aotipaddrkractinagcyolddtev,p18_aotipaddrkractinagcynewdtev,p19_aotbnkacctkractinagcycntev,p19_aotbnkacctkractinagcyflagev,' +
        'p19_aotbnkacctkractinagcyolddtev,p19_aotbnkacctkractinagcynewdtev,p20_aotdlkractinagcycntev,p20_aotdlkractinagcyflagev,p20_aotdlkractinagcyolddtev,p20_aotdlkractinagcynewdtev,t_inpclnaddrgeomatchecho,' +
        'p1_aotidkrstolidactshrdnewsrcagencydescev,p1_aotidkrappfrdactshrdsrcagencycntev,p1_aotidkrappfrdactshrdnewsrcagencydescev,p1_aotidkrothfrdactshrdsrcagencycntev,p1_aotidkrothfrdactshrdnewsrcagencydescev,' +
        'p9_aotaddrkractshrdsrcagencycntev,p9_aotaddrkractshrdnewsrcagencydescev,p15_aotssnkractshrdsrcagencycntev,p15_aotssnkractshrdnewsrcagencydescev,p16_aotphnkractshrdsrcagencycntev,' +
        'p16_aotphnkractshrdnewsrcagencydescev,p17_aotemailkractshrdsrcagencycntev,p17_aotemailkractshrdnewsrcagencydescev,p18_aotipaddrkractshrdsrcagencycntev,p18_aotipaddrkractshrdnewsrcagencydescev,' +
        'p19_aotbnkacctkractshrdsrcagencycntev,p19_aotbnkacctkractshrdnewsrcagencydescev,p20_aotdlkractshrdsrcagencycntev,p20_aotdlkractshrdnewsrcagencydescev,t18_ipaddrgeoloclat,t18_ipaddrgeoloclong,' +
        'p1_aotidkractshrdsrcagencycntev,p1_aotidkractshrdnewsrcagencydescev,p1_aotidkrgenfrdactshrdsrcagencycntev,p1_aotidkrgenfrdactshrdnewsrcagencydescev,p1_aotidkrstolidactshrdsrcagencycntev,' +
        't9_addrnotinagcyjurstflag,' +

        't_srcagencydesc,agencydesc,t_srcagencyprogdesc,t_srcagencyprogjurst';



    EXPORT UIStats := hipie_ecl.macSlimDataset(CleanEventShell, 'industrytype,customerid,entitycontextuid', 
        'recordid,caseid,eventdate,' +
        OriginalAttr + ',' +
        StructuralAttr + ',' +
        NicoleAttr
        );

    EXPORT ModelingStats := hipie_ecl.macSlimDataset(CleanEventShell/*(industrytype = 1029 and customerid = 20995239))*/, 'entitycontextuid,t_actuid', 
        ModelingAttr
        );

END;