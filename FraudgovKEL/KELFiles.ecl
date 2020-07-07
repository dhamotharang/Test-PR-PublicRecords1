
EXPORT KEL_EventShell := MODULE

	IMPORT FraudgovKEL;
	IMPORT FraudGovPlatform_Analytics;
	IMPORT KEL12 AS KEL;
	IMPORT HIPIE_ECL;

	EXPORT CleanEventShell := KEL.Clean(FraudgovKEL.Q__show_Customer_Person_Event.Res0, TRUE /*Remove __Flags*/, TRUE /*Remove __recordcounts*/, TRUE /*Remove _ from Field Names*/);

	EXPORT OriginalAttr := 'ottoaddressid,deceaseddate,deceaseddateofbirth,deceasedfirst,deceasedmiddle,deceasedlast,phonenumber,ottoemailid,ottoipaddressid,ottodriverslicenseid,currentlyincarceratedflag,' +
		'eventage,contributorsafeflag,' +
		'safeflag,incustomerpopulation,' +
		'deceasedpriortoevent,addressoutofstate,addressispobox,addressoutofstate,addressisvacant,currentlyincarceratedflag,' +
		'unique_number,mac_address,serial_number,device_type,device_identification_provider,' +
		'addreventcount,ssneventcount,personeventcount,phoneeventcount,emaileventcount,ipeventcount,bankaccounteventcount,driverslicenseeventcount,'+
		'addrevent30count,ssnevent30count,personevent30count,phoneevent30count,emailevent30count,ipevent30count,bankaccountevent30count,driverslicenseevent30count,' +
		'addrevent365count,ssnevent365count,personevent365count,phoneevent365count,emailevent365count,ipevent365count,bankaccountevent365count,driverslicenseevent365count';

	EXPORT StructuralAttr := 'addreventafterkrflag,ssneventafterkrflag,personeventafterkrflag,phoneeventafterkrflag,emaileventafterkrflag,ipeventafterkrflag,bankaccounteventafterkrflag,driverslicenseeventafterkrflag,'+
		'addreventafterkrcount,ssneventafterkrcount,personeventafterkrcount,phoneeventafterkrcount,emaileventafterkrcount,ipeventafterkrcount,bankaccounteventafterkrcount,driverslicenseeventafterkrcount,'+
		'kreventafterknownrisk,krpersonprofileflag,kremailprofileflag,kraddressprofileflag,kripprofileflag,krssnprofileflag,krphoneprofileflag,krbankaccountprofileflag,krdriverslicenseprofileflag,' +
		'idislasteventid,emlislasteventid,addrislasteventid,ipislasteventid,bnkislasteventid,dlislasteventid,ssnislasteventid,phislasteventid,' +
		'personlabel,emaillabel,addresslabel,iplabel,bankaccountlabel,driverslicenselabel,ssnlabel,phonelabel,' +
		'addressentitycontextuid,ssnentitycontextuid,personentitycontextuid,phoneentitycontextuid,emailentitycontextuid,ipentitycontextuid,bankaccountentitycontextuid,driverslicenseentitycontextuid,'+ 
		'streetaddress,city,state,zip';


	EXPORT NicoleAttr := 'agencyuid,agencyprogtype,agencyprogjurst,t_srcagencyuid,t_srcagencyprogtype,t_actuid,t_actdtecho,t_srctype,t_srcclasstype,t_personuidecho,' +
		't_inpclntitleecho,t_inpclnfirstnmecho,t_inpclnlastnmecho,t_inpclnnmsuffixecho,t_inpclnaddrprimrangeecho,t_inpclnaddrpredirecho,t_inpclnaddrprimnmecho,t_inpclnaddrsuffixecho,t_inpclnaddrpostdirecho,t_inpclnaddrunitdesigecho,' +
		't_inpclnaddrsecrangeecho,t_inpclnaddrcityecho,t_inpclnaddrstecho,t_inpclnaddrzip5echo,t_inpclnaddrzip4echo,t_inpclnaddrlatecho,t_inpclnaddrlongecho,t_inpclnaddrcountyecho,t_inpclnaddrgeoblkecho,t_inpclnssnecho,' +
		't_inpclndobecho,t_inpclndlecho,t_inpclndlstecho,t_inpclnemailecho,t_inpclnbnkacctecho,t_inpclnbnkacctrtgecho,t_inpclnipaddrecho,t_inpclnphnecho,t1_lexidpopflag,t1_rinidpopflag,' +
		't18_isipmetahitflag,t18_ipaddrcity,t18_ipaddrcountry,t18_ipaddrregion,t18_ipaddrdomain,t18_ipaddrispnm,t18_ipaddrloctype,t18_ipaddrproxytype,t18_ipaddrproxydesc,t18_ipaddrisispflag,' +
		't18_ipaddrasncompnm,t18_ipaddrasn,t18_ipaddrcompnm,t18_ipaddrorgnm,t18_ipaddrhostedflag,t18_ipaddrvpnflag,t18_ipaddrtornodeflag,t18_ipaddrlocnonusflag,t18_ipaddrlocmiamiflag,t19_bnkacctpopflag,' +
		't19_isbnkapphitflag,t19_bnkacctbnknm,t19_bnkaccthrprepdrtgflag,t17_emailpopflag,t17_emaildomain,t17_emaildomaindispflag,t9_addrpopflag,t9_addrtype,t9_addrstatus,t16_phnpopflag,' +
		't15_ssnpopflag,t20_dlpopflag,t18_ipaddrpopflag,t_inagencyflag,t_evttype1krcodeecho,t_evttype2krcodeecho,t_evttype3krcodeecho,t_idkrcodeecho,t_ssnkrcodeecho,t_dlkrcodeecho,' +
		't_addrkrcodeecho,t_phnkrcodeecho,t_emailkrcodeecho,t_ipaddrkrcodeecho,t_bnkacctkrcodeecho,t15_ssniskrflag,t20_dliskrflag,t9_addriskrflag,t16_phniskrflag,t17_emailiskrflag,' +
		't18_ipaddriskrflag,t19_bnkacctiskrflag,t1_idiskrgenfrdflag,t1_idiskrstolidflag,t1_idiskrappfrdflag,t1_idiskrothfrdflag,t1_idiskrflag,t_firstnmpopflag,t_lastnmpopflag,t_dobpopflag,' +
		'p1_aotidcurrprofflag,p9_aotaddrcurrprofflag,p15_aotssncurrprofflag,p20_aotdlcurrprofflag,p16_aotphncurrprofflag,p17_aotemailcurrprofflag,p18_aotipaddrcurrprofflag,p19_aotbnkacctcurrprofflag,p1_aotidkractcntev,p1_aotidkractflagev,' +
		'p1_aotidkractshrdcntev,p1_aotidkractshrdflagev,p1_aotidkractolddtev,p1_aotidkractnewdtev,p1_aotidkractshrdolddtev,p1_aotidkractshrdnewdtev,p1_aotidkrappfrdactcntev,p1_aotidkrappfrdactflagev,p1_aotidkrappfrdactshrdcntev,p1_aotidkrappfrdactshrdflagev,' +
		'p1_aotidkrappfrdactolddtev,p1_aotidkrappfrdactnewdtev,p1_aotidkrappfrdactshrdolddtev,p1_aotidkrappfrdactshrdnewdtev,p1_aotidkrgenfrdactcntev,p1_aotidkrgenfrdactflagev,p1_aotidkrgenfrdactshrdcntev,p1_aotidkrgenfrdactshrdflagev,p1_aotidkrgenfrdactolddtev,p1_aotidkrgenfrdactnewdtev,' +
		'p1_aotidkrgenfrdactshrdolddtev,p1_aotidkrgenfrdactshrdnewdtev,p1_aotidkrothfrdactcntev,p1_aotidkrothfrdactflagev,p1_aotidkrothfrdactshrdcntev,p1_aotidkrothfrdactshrdflagev,p1_aotidkrothfrdactolddtev,p1_aotidkrothfrdactnewdtev,p1_aotidkrothfrdactshrdolddtev,p1_aotidkrothfrdactshrdnewdtev,' +
		'p1_aotidkrstolidactcntev,p1_aotidkrstolidactflagev,p1_aotidkrstolidactshrdcntev,p1_aotidkrstolidactshrdflagev,p1_aotidkrstolidactolddtev,p1_aotidkrstolidactnewdtev,p1_aotidkrstolidactshrdolddtev,p1_aotidkrstolidactshrdnewdtev,p9_aotaddrkractcntev,p9_aotaddrkractflagev,' +
		'p9_aotaddrkractshrdcntev,p9_aotaddrkractshrdflagev,p9_aotaddrkractolddtev,p9_aotaddrkractnewdtev,p9_aotaddrkractshrdolddtev,p9_aotaddrkractshrdnewdtev,p15_aotssnkractcntev,p15_aotssnkractflagev,p15_aotssnkractshrdcntev,p15_aotssnkractshrdflagev,' +
		'p15_aotssnkractolddtev,p15_aotssnkractnewdtev,p15_aotssnkractshrdolddtev,p15_aotssnkractshrdnewdtev,p16_aotphnkractcntev,p16_aotphnkractflagev,p16_aotphnkractshrdcntev,p16_aotphnkractshrdflagev,p16_aotphnkractolddtev,p16_aotphnkractnewdtev,' +
		'p16_aotphnkractshrdolddtev,p16_aotphnkractshrdnewdtev,p17_aotemailkractcntev,p17_aotemailkractflagev,p17_aotemailkractshrdcntev,p17_aotemailkractshrdflagev,p17_aotemailkractolddtev,p17_aotemailkractnewdtev,p17_aotemailkractshrdolddtev,p17_aotemailkractshrdnewdtev,' +
		'p18_aotipaddrkractcntev,p18_aotipaddrkractflagev,p18_aotipaddrkractshrdcntev,p18_aotipaddrkractshrdflagev,p18_aotipaddrkractolddtev,p18_aotipaddrkractnewdtev,p18_aotipaddrkractshrdolddtev,p18_aotipaddrkractshrdnewdtev,p19_aotbnkacctkractcntev,p19_aotbnkacctkractflagev,' +
		'p19_aotbnkacctkractshrdcntev,p19_aotbnkacctkractshrdflagev,p19_aotbnkacctkractolddtev,p19_aotbnkacctkractnewdtev,p19_aotbnkacctkractshrdolddtev,p19_aotbnkacctkractshrdnewdtev,p20_aotdlkractcntev,p20_aotdlkractflagev,p20_aotdlkractshrdcntev,p20_aotdlkractshrdflagev,' +
		'p20_aotdlkractolddtev,p20_aotdlkractnewdtev,p20_aotdlkractshrdolddtev,p20_aotdlkractshrdnewdtev';


	EXPORT UIStats := hipie_ecl.macSlimDataset(CleanEventShell, 'industrytype,customerid,entitycontextuid', 
		'recordid,caseid,eventdate,' +
		OriginalAttr + ',' +
		StructuralAttr + ',' +
		NicoleAttr
		);

	EXPORT ModelingStats := hipie_ecl.macSlimDataset(CleanEventShell((hash(personentitycontextuid) % 2 = 0 OR currentlyincarceratedflag =1 OR deceasedpriortoevent=1) AND industrytype = 1029 /*and customerid =	20995369*/), 'industrytype,customerid,entitycontextuid', 
		'recordid,caseid, eventdate,' +
		NicoleAttr
		);

END;