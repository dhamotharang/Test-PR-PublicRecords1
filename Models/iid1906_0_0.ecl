//EXPORT IID1906_0_0 := 'todo';
import Std, risk_indicators, ut, Models;

export IID1906_0_0(dataset(risk_indicators.layout_output) iid_recs) := FUNCTION
									
		IID_DEBUG := FALSE;
		// IID_DEBUG := TRUE;
		
		isFCRA := False;

	#if(IID_DEBUG)
	Layout_Debug := RECORD
  
 /* Model Intermediate Variables */
unsigned seq;
Integer	 sysdate;
Integer	 txinqwemailfirst_dayssince;
Integer	 txinqwemaillast_dayssince;
Integer	 txinqwphonefirst_dayssince;
Integer	 txinqwphonelast_dayssince;
Boolean	 new_email;
Boolean	 new_email_or_phone;
Boolean	 new_email_or_name;
Boolean	 new_email_or_address;
Boolean	 new_email_phone_or_name;
Boolean	 new_email_phone_name_or_address;
Real	 esmartidperemailintxinqcnt;
Real	 esmartidperemailintxinqcnt1y;
Real	 esmartidperemailintxinqcnt6m;
Real	 esmartidperemailintxinqcnt3m;
Real	 esmartidperemailintxinqcnt1m;
Real	 eexactidperemailintxinqcnt;
Real	 eexactidperemailintxinqcnt1y;
Real	 eexactidperemailintxinqcnt6m;
Real	 eexactidperemailintxinqcnt3m;
Real	 eexactidperemailintxinqcnt1m;
Real	 ephoneperemailintxinqcnt1y;
Real	 ephoneperemailintxinqcnt1m;
Real	 ephoneperemailintxinqcnt3m;
Real	 etmxidperemailintxinqcnt;
Real	 etmxidperemailintxinqcnt1y;
Real	 etmxidperemailintxinqcnt6m;
Real	 etmxidperemailintxinqcnt3m;
Real	 etmxidperemailintxinqcnt1m;
Real	 eorgidperemailintxinqcnt;
Real	 etrueipperemailintxinqcnt;
Real	 etrueipgperemailintxinqcnt;
Real	 ednsipperemailintxinqcnt;
Real	 ednsipgperemailintxinqcnt;
Real	 eproxyipperemailintxinqcnt;
Real	 eproxyipgperemailintxinqcnt;
Real	 ebrowserperemailintxinqcnt;
Real	 ebrowserhashperemailintxinqcnt;
Real	 escreenresperemailintxinqcnt;
Real	 etimezoneperemailintxinqcnt;
Real	 ecurrencyperemailintxinqcnt;
Real	 eachperemailintxinqcnt;
Real	 eagentpubkeyperemailintxinqcnt;
Real	 eccardperemailintxinqcnt;
Real	 etxinqcorremailwphonenamecnt;
Real	 etxinqcorremailwphonenamecnt1y;
Real	 etxinqcorremailwphonenamecnt6m;
Real	 etxinqcorremailwphonenamecnt3m;
Real	 etxinqcorremailwphonenamecnt1m;
Real	 etxinqcorremailwpflacnt;
Real	 etxinqcorremailwpflacnt1y;
Real	 etxinqcorremailwpflacnt6m;
Real	 etxinqcorremailwpflacnt3m;
Real	 etxinqcorremailwpflacnt1m;
Real	 etxinqcorremailwphonecnt;
Real	 etxinqcorremailwphonecnt1y;
Real	 etxinqcorremailwphonecnt6m;
Real	 etxinqcorremailwphonecnt3m;
Real	 etxinqcorremailwphonecnt1m;
Real	 etxinqwemailcnt1y;
Real	 etxinqwemailcnt6m;
Real	 etxinqcorremailwaddresscnt;
Real	 etxinqcorremailwaddresscnt1y;
Real	 etxinqcorremailwaddresscnt6m;
Real	 etxinqcorremailwaddresscnt3m;
Real	 etxinqcorremailwaddresscnt1m;
Real	 etxinqcorremailwnamecnt;
Real	 etxinqcorremailwnamecnt1y;
Real	 etxinqcorremailwnamecnt6m;
Real	 etxinqcorremailwnamecnt3m;
Real	 etxinqcorremailwnamecnt1m;
Real	 etxinqwemailfinstatusrejcnt;
Real	 etxinqwemailfinstatusrejcnt1m;
Real	 etxinqwemailfinstatusacccnt;
Real	 etxinqwemailfinstatusacccnt1m;
Real	 edistbtwtrueipwemailavg;
Real	 etimebtwtxinqwemailavg;
Real	 eruleemailtrustedbyuserflag1m;
Real	 eruleemailtrustedbyuserflag3m;
Real	 eruleemailtrustedbyuserflag6m;
Real	 eruleemailtrustedbyuserflag1y;
Real	 eruleemailblistflag;
Real	 eruleemailblistbybankflag;
Real	 eruleemailblistbyfintechflag;
Real	 eruleemailblistbyecommflag;
Real	 eruleexactidblistintxinqweflag1m;
Real	 eruleexactidblistintxinqweflag;
Real	 erulesmartidblistintxinqweflag1m;
Real	 erulesmartidblistintxinqweflag;
Real	 eruleemailhighriskdomainflag;
Real	 eruleemailaliasflag;
Real	 eruleemailmachinegeneratedflag;
Real	 etxinqwemailfirst_dayssince;
Real	 etxinqwemaillast_dayssince;
Real	 enew_email;
Real	 enew_email_or_phone;
Real	 enew_email_or_name;
Real	 enew_email_or_address;
Real	 enew_email_phone_or_name;
Real	 enew_email_phone_name_or_address;
Real	 email_v001;
Real	 email_v002;
Real	 email_v003;
Real	 email_v004;
Real	 email_v005;
Real	 email_v006;
Real	 email_v007;
Real	 email_v008;
Real	 email_v009;
Real	 email_v010;
Real	 email_v011;
Real	 email_v012;
Real	 email_v013;
Real	 email_v014;
Real	 email_v015;
Real	 email_v016;
Real	 email_v017;
Real	 email_v018;
Real	 email_v019;
Real	 email_v020;
Real	 email_v021;
Real	 email_v022;
Real	 email_v023;
Real	 email_v024;
Real	 email_v025;
Real	 email_v026;
Real	 email_v027;
Real	 email_v028;
Real	 email_v029;
Real	 email_v030;
Real	 email_v031;
Real	 email_v032;
Real	 email_v033;
Real	 email_v034;
Real	 email_v035;
Real	 email_v036;
Real	 email_v037;
Real	 email_v038;
Real	 email_v039;
Real	 email_v040;
Real	 email_v041;
Real	 email_v042;
Real	 email_v043;
Real	 email_v044;
Real	 email_v045;
Real	 email_v046;
Real	 email_v047;
Real	 email_v048;
Real	 email_v049;
Real	 email_v050;
Real	 email_v051;
Real	 email_v052;
Real	 email_v053;
Real	 email_v054;
Real	 email_v055;
Real	 email_v056;
Real	 email_v057;
Real	 email_v058;
Real	 email_v059;
Real	 email_v060;
Real	 email_v061;
Real	 email_v062;
Real	 email_v063;
Real	 email_v064;
Real	 email_v065;
Real	 email_v066;
Real	 email_v067;
Real	 email_v068;
Real	 email_v069;
Real	 email_v070;
Real	 email_v071;
Real	 email_v072;
Real	 email_v073;
Real	 email_v074;
Real	 email_v075;
Real	 email_v076;
Real	 email_v077;
Real	 email_v078;
Real	 email_v079;
Real	 email_v080;
Real	 email_v081;
Real	 email_v082;
Real	 email_v083;
Real	 email_v084;
Real	 email_v085;
Real	 email_v086;
Real	 email_v087;
Real	 email_v088;
Real	 email_v089;
Real	 email_pc001;
Real	 email_pc002;
Real	 email_pc003;
Real	 email_distance_001;
Real	 email_distance_002;
Real	 email_distance_003;
Real	 email_distance_004;
Real	 email_distance_005;
Real	 email_mindist;
Real	 email_cluster;
Integer	 iid1906_0_0_emailriskindex;
String	 iid1906_0_0_emailhighriskind;
Boolean	 new_phone;
Boolean	 new_phone_or_email;
Boolean	 new_phone_or_name;
Boolean	 new_phone_email_or_name;
Boolean	 new_phone_email_name_or_address;
Real	 psmartidperphoneintxinqcnt;
Real	 psmartidperphoneintxinqcnt1y;
Real	 psmartidperphoneintxinqcnt6m;
Real	 psmartidperphoneintxinqcnt3m;
Real	 psmartidperphoneintxinqcnt1m;
Real	 pexactidperphoneintxinqcnt;
Real	 pexactidperphoneintxinqcnt1y;
Real	 pexactidperphoneintxinqcnt6m;
Real	 pexactidperphoneintxinqcnt3m;
Real	 pexactidperphoneintxinqcnt1m;
Real	 pemailperphoneintxinqcnt;
Real	 pemailperphoneintxinqcnt1y;
Real	 pemailperphoneintxinqcnt1m;
Real	 pemailperphoneintxinqcnt3m;
Real	 pemailperphoneintxinqcnt6m;
Real	 ptmxidperphoneintxinqcnt;
Real	 ptmxidperphoneintxinqcnt1y;
Real	 ptmxidperphoneintxinqcnt6m;
Real	 ptmxidperphoneintxinqcnt3m;
Real	 ptmxidperphoneintxinqcnt1m;
Real	 ptrueipperphoneintxinqcnt;
Real	 pbrowserhashperphoneintxinqcnt;
Real	 ploginidperphoneintxinqcnt;
Real	 ptxinqcorremailwphonenamecnt;
Real	 ptxinqcorremailwphonenamecnt1y;
Real	 ptxinqcorremailwphonenamecnt6m;
Real	 ptxinqcorremailwphonenamecnt3m;
Real	 ptxinqcorremailwphonenamecnt1m;
Real	 ptxinqcorremailwpflacnt;
Real	 ptxinqcorremailwpflacnt1y;
Real	 ptxinqcorremailwpflacnt6m;
Real	 ptxinqcorremailwpflacnt3m;
Real	 ptxinqcorremailwpflacnt1m;
Real	 ptxinqcorremailwphonecnt;
Real	 ptxinqcorremailwphonecnt1y;
Real	 ptxinqcorremailwphonecnt6m;
Real	 ptxinqcorremailwphonecnt3m;
Real	 ptxinqcorremailwphonecnt1m;
Real	 ptxinqwphonecnt;
Real	 ptxinqwphonecnt1y;
Real	 ptxinqwphonecnt6m;
Real	 ptxinqcorrnamewphonecnt;
Real	 ptxinqcorrnamewphonecnt1y;
Real	 ptxinqcorrnamewphonecnt6m;
Real	 ptxinqcorrnamewphonecnt3m;
Real	 ptxinqcorrnamewphonecnt1m;
Real	 ptxinqwphonefinstatusrejcnt;
Real	 ptxinqwphonefinstatusrejcnt1m;
Real	 ptxinqwphonefinstatusacccnt;
Real	 ptxinqwphonefinstatusacccnt1m;
Real	 pdistbtwtrueipwphoneavg;
Real	 ptimebtwtxinqwphoneavg;
Real	 pruleexactidblistintxinqwpflag1m;
Real	 pruleexactidblistintxinqwpflag1y;
Real	 prulesmartidblistintxinqwpflag1m;
Real	 prulesmartidblistintxinqwpflag1y;
Real	 ptxinqwphonefirst_dayssince;
Real	 ptxinqwphonelast_dayssince;
Real	 pnew_phone;
Real	 pnew_phone_or_email;
Real	 pnew_phone_or_name;
Real	 pnew_phone_email_or_name;
Real	 pnew_phone_email_name_or_address;
Real	 phone_v001;
Real	 phone_v002;
Real	 phone_v003;
Real	 phone_v004;
Real	 phone_v005;
Real	 phone_v006;
Real	 phone_v007;
Real	 phone_v008;
Real	 phone_v009;
Real	 phone_v010;
Real	 phone_v011;
Real	 phone_v012;
Real	 phone_v013;
Real	 phone_v014;
Real	 phone_v015;
Real	 phone_v016;
Real	 phone_v017;
Real	 phone_v018;
Real	 phone_v019;
Real	 phone_v020;
Real	 phone_v021;
Real	 phone_v022;
Real	 phone_v023;
Real	 phone_v024;
Real	 phone_v025;
Real	 phone_v026;
Real	 phone_v027;
Real	 phone_v028;
Real	 phone_v029;
Real	 phone_v030;
Real	 phone_v031;
Real	 phone_v032;
Real	 phone_v033;
Real	 phone_v034;
Real	 phone_v035;
Real	 phone_v036;
Real	 phone_v037;
Real	 phone_v038;
Real	 phone_v039;
Real	 phone_v040;
Real	 phone_v041;
Real	 phone_v042;
Real	 phone_v043;
Real	 phone_v044;
Real	 phone_v045;
Real	 phone_v046;
Real	 phone_v047;
Real	 phone_v048;
Real	 phone_v049;
Real	 phone_v050;
Real	 phone_v051;
Real	 phone_v052;
Real	 phone_v053;
Real	 phone_v054;
Real	 phone_v055;
Real	 phone_v056;
Real	 phone_v057;
Real	 phone_v058;
Real	 phone_v059;
Real	 phone_v060;
Real	 phone_v061;
Real	 phone_v062;
Real	 phone_v063;
Real	 phone_pc001;
Real	 phone_pc002;
Real	 phone_pc003;
Real	 phone_distance_001;
Real	 phone_distance_002;
Real	 phone_distance_003;
Real	 phone_distance_004;
Real	 phone_distance_005;
Real	 phone_distance_006;
Real	 phone_mindist;
Real	 phone_cluster;
Integer	 iid1906_0_0_phoneriskindex;
String	 iid1906_0_0_phonehighriskind;
risk_indicators.layout_output iid_recs;
Models.Layout_IID;
END;

layout_debug doModel(iid_recs le):=TRANSFORM
#else
risk_indicators.Layout_Output doModel (iid_recs le) := TRANSFORM
#end

/* Input Variable Assignments */

  txinqwemailfirst                 := (string)le.threatmetrix.TxinqWEmailFirst;
	txinqwemaillast                  := (string)le.threatmetrix.TxinqWEmailLast;
	txinqwphonefirst                 := (string)le.threatmetrix.TxinqWPhoneFirst;
	txinqwphonelast                  := (string)le.threatmetrix.TxinqWPhoneLast;
	txinqwemailcnt1y                 := (INTEGER)le.threatmetrix.TxinqWEmailCnt1Y;
	txinqcorremailwphonecnt          := (INTEGER)le.threatmetrix.TxinqCorrEmailWPhoneCnt;
	txinqcorremailwnamecnt           := (INTEGER)le.threatmetrix.TxinqCorrEmailWNameCnt;
	txinqcorremailwaddresscnt        := (INTEGER)le.threatmetrix.TxinqCorrEmailWAddressCnt;
	txinqcorremailwphonenamecnt      := (INTEGER)le.threatmetrix.TxinqCorrEmailWPhoneNameCnt;
	txinqcorremailwpflacnt           := (INTEGER)le.threatmetrix.TxinqCorrEmailWPFLACnt;
	smartidperemailintxinqcnt        := (INTEGER)le.threatmetrix.SmartidPerEmailInTxinqCnt;
	smartidperemailintxinqcnt1y      := (INTEGER)le.threatmetrix.SmartidPerEmailInTxinqCnt1Y;
	smartidperemailintxinqcnt6m      := (INTEGER)le.threatmetrix.SmartidPerEmailInTxinqCnt6M;
	smartidperemailintxinqcnt3m      := (INTEGER)le.threatmetrix.SmartidPerEmailInTxinqCnt3M;
	smartidperemailintxinqcnt1m      := (INTEGER)le.threatmetrix.SmartidPerEmailInTxinqCnt1M;
	exactidperemailintxinqcnt        := (INTEGER)le.threatmetrix.ExactidPerEmailInTxinqCnt;
	exactidperemailintxinqcnt1y      := (INTEGER)le.threatmetrix.ExactidPerEmailInTxinqCnt1Y;
	exactidperemailintxinqcnt6m      := (INTEGER)le.threatmetrix.ExactidPerEmailInTxinqCnt6M;
	exactidperemailintxinqcnt3m      := (INTEGER)le.threatmetrix.ExactidPerEmailInTxinqCnt3M;
	exactidperemailintxinqcnt1m      := (INTEGER)le.threatmetrix.ExactidPerEmailInTxinqCnt1M;
	phoneperemailintxinqcnt1y        := (INTEGER)le.threatmetrix.PhonePerEmailInTxinqCnt1Y;
	phoneperemailintxinqcnt1m        := (INTEGER)le.threatmetrix.PhonePerEmailInTxinqCnt1M;
	phoneperemailintxinqcnt3m        := (INTEGER)le.threatmetrix.PhonePerEmailInTxinqCnt3M;
	tmxidperemailintxinqcnt          := (INTEGER)le.threatmetrix.TmxidPerEmailInTxinqCnt;
	tmxidperemailintxinqcnt1y        := (INTEGER)le.threatmetrix.TmxidPerEmailInTxinqCnt1Y;
	tmxidperemailintxinqcnt6m        := (INTEGER)le.threatmetrix.TmxidPerEmailInTxinqCnt6M;
	tmxidperemailintxinqcnt3m        := (INTEGER)le.threatmetrix.TmxidPerEmailInTxinqCnt3M;
	tmxidperemailintxinqcnt1m        := (INTEGER)le.threatmetrix.TmxidPerEmailInTxinqCnt1M;
	orgidperemailintxinqcnt          := (INTEGER)le.threatmetrix.OrgidPerEmailInTxinqCnt;
	trueipperemailintxinqcnt         := (INTEGER)le.threatmetrix.TrueipPerEmailInTxinqCnt;
	trueipgperemailintxinqcnt        := (INTEGER)le.threatmetrix.TrueipgPerEmailInTxinqCnt;
	dnsipperemailintxinqcnt          := (INTEGER)le.threatmetrix.DnsipPerEmailInTxinqCnt;
	dnsipgperemailintxinqcnt         := (INTEGER)le.threatmetrix.DnsipgPerEmailInTxinqCnt;
	proxyipperemailintxinqcnt        := (INTEGER)le.threatmetrix.ProxyipPerEmailInTxinqCnt;
	proxyipgperemailintxinqcnt       := (INTEGER)le.threatmetrix.ProxyipgPerEmailInTxinqCnt;
	browserperemailintxinqcnt        := (INTEGER)le.threatmetrix.BrowserPerEmailInTxinqCnt;
	browserhashperemailintxinqcnt    := (INTEGER)le.threatmetrix.BrowserHashPerEmailInTxinqCnt;
	screenresperemailintxinqcnt      := (INTEGER)le.threatmetrix.ScreenResPerEmailInTxinqCnt;
	timezoneperemailintxinqcnt       := (INTEGER)le.threatmetrix.TimeZonePerEmailInTxinqCnt;
	currencyperemailintxinqcnt       := (INTEGER)le.threatmetrix.CurrencyPerEmailInTxinqCnt;
	achperemailintxinqcnt            := (INTEGER)le.threatmetrix.ACHPerEmailInTXInqCnt;
	agentpubkeyperemailintxinqcnt    := (INTEGER)le.threatmetrix.AgentPubKeyPerEmailInTXInqCnt;
	ccardperemailintxinqcnt          := (INTEGER)le.threatmetrix.CCardPerEmailInTXInqCnt;
	txinqcorremailwphonenamecnt1y    := (INTEGER)le.threatmetrix.TxinqCorrEmailWPhoneNameCnt1Y;
	txinqcorremailwphonenamecnt6m    := (INTEGER)le.threatmetrix.TxinqCorrEmailWPhoneNameCnt6M;
	txinqcorremailwphonenamecnt3m    := (INTEGER)le.threatmetrix.TxinqCorrEmailWPhoneNameCnt3M;
	txinqcorremailwphonenamecnt1m    := (INTEGER)le.threatmetrix.TxinqCorrEmailWPhoneNameCnt1M;
	txinqcorremailwpflacnt1y         := (INTEGER)le.threatmetrix.TxinqCorrEmailWPFLACnt1Y;
	txinqcorremailwpflacnt6m         := (INTEGER)le.threatmetrix.TxinqCorrEmailWPFLACnt6M;
	txinqcorremailwpflacnt3m         := (INTEGER)le.threatmetrix.TxinqCorrEmailWPFLACnt3M;
	txinqcorremailwpflacnt1m         := (INTEGER)le.threatmetrix.TxinqCorrEmailWPFLACnt1M;
	txinqcorremailwphonecnt1y        := (INTEGER)le.threatmetrix.TxinqCorrEmailWPhoneCnt1Y;
	txinqcorremailwphonecnt6m        := (INTEGER)le.threatmetrix.TxinqCorrEmailWPhoneCnt6M;
	txinqcorremailwphonecnt3m        := (INTEGER)le.threatmetrix.TxinqCorrEmailWPhoneCnt3M;
	txinqcorremailwphonecnt1m        := (INTEGER)le.threatmetrix.TxinqCorrEmailWPhoneCnt1M;
	txinqwemailcnt6m                 := (INTEGER)le.threatmetrix.TxinqWEmailCnt6M;
	txinqcorremailwaddresscnt1y      := (INTEGER)le.threatmetrix.TxinqCorrEmailWAddressCnt1Y;
	txinqcorremailwaddresscnt6m      := (INTEGER)le.threatmetrix.TxinqCorrEmailWAddressCnt6M;
	txinqcorremailwaddresscnt3m      := (INTEGER)le.threatmetrix.TxinqCorrEmailWAddressCnt3M;
	txinqcorremailwaddresscnt1m      := (INTEGER)le.threatmetrix.TxinqCorrEmailWAddressCnt1M;
	txinqcorremailwnamecnt1y         := (INTEGER)le.threatmetrix.TxinqCorrEmailWNameCnt1Y;
	txinqcorremailwnamecnt6m         := (INTEGER)le.threatmetrix.TxinqCorrEmailWNameCnt6M;
	txinqcorremailwnamecnt3m         := (INTEGER)le.threatmetrix.TxinqCorrEmailWNameCnt3M;
	txinqcorremailwnamecnt1m         := (INTEGER)le.threatmetrix.TxinqCorrEmailWNameCnt1M;
	txinqwemailfinstatusrejcnt       := (INTEGER)le.threatmetrix.TxinqWEmailFinStatusRejCnt;
	txinqwemailfinstatusrejcnt1m     := (INTEGER)le.threatmetrix.TxinqWEmailFinStatusRejCnt1M;
	txinqwemailfinstatusacccnt       := (INTEGER)le.threatmetrix.TxinqWEmailFinStatusAccCnt;
	txinqwemailfinstatusacccnt1m     := (INTEGER)le.threatmetrix.TxinqWEmailFinStatusAccCnt1M;
	distbtwtrueipwemailavg           := (Real)le.threatmetrix.DistBtwTrueipWEmailAvg;
	timebtwtxinqwemailavg            := (Real)le.threatmetrix.TimeBtwTxinqWEmailAvg;
	ruleemailtrustedbyuserflag1m     := (INTEGER)le.threatmetrix.RuleEmailTrustedByUserFlag1M;
	ruleemailtrustedbyuserflag3m     := (INTEGER)le.threatmetrix.RuleEmailTrustedByUserFlag3M;
	ruleemailtrustedbyuserflag6m     := (INTEGER)le.threatmetrix.RuleEmailTrustedByUserFlag6M;
	ruleemailtrustedbyuserflag1y     := (INTEGER)le.threatmetrix.RuleEmailTrustedByUserFlag1Y;
	ruleemailblistflag               := (INTEGER)le.threatmetrix.RuleEmailBlistFlag;
	ruleemailblistbybankflag         := (INTEGER)le.threatmetrix.RuleEmailBlistByBankFlag;
	ruleemailblistbyfintechflag      := (INTEGER)le.threatmetrix.RuleEmailBlistByFinTechFlag;
	ruleemailblistbyecommflag        := (INTEGER)le.threatmetrix.RuleEmailBlistByEcommFlag;
	ruleexactidblistintxinqweflag1m  := (INTEGER)le.threatmetrix.RuleExactidBlistInTxinqWEFlag1M;
	ruleexactidblistintxinqweflag    := (INTEGER)le.threatmetrix.RuleExactidBlistInTxinqWEFlag;
	rulesmartidblistintxinqweflag1m  := (INTEGER)le.threatmetrix.RuleSmartidBlistInTxinqWEFlag1M;
	rulesmartidblistintxinqweflag    := (INTEGER)le.threatmetrix.RuleSmartidBlistInTxinqWEFlag;
	ruleemailhighriskdomainflag      := (INTEGER)le.threatmetrix.RuleEmailHighRiskDomainFlag;
	ruleemailaliasflag               := (INTEGER)le.threatmetrix.RuleEmailAliasFlag;
	ruleemailmachinegeneratedflag    := (INTEGER)le.threatmetrix.RuleEmailMachineGeneratedFlag;
	txinqwphonecnt                   := (INTEGER)le.threatmetrix.TxinqWPhoneCnt;
	txinqcorrnamewphonecnt           := (INTEGER)le.threatmetrix.TxinqCorrNameWPhoneCnt;
	smartidperphoneintxinqcnt        := (INTEGER)le.threatmetrix.SmartidPerPhoneInTxinqCnt;
	smartidperphoneintxinqcnt1y      := (INTEGER)le.threatmetrix.SmartidPerPhoneInTxinqCnt1Y;
	smartidperphoneintxinqcnt6m      := (INTEGER)le.threatmetrix.SmartidPerPhoneInTxinqCnt6M;
	smartidperphoneintxinqcnt3m      := (INTEGER)le.threatmetrix.SmartidPerPhoneInTxinqCnt3M;
	smartidperphoneintxinqcnt1m      := (INTEGER)le.threatmetrix.SmartidPerPhoneInTxinqCnt1M;
	exactidperphoneintxinqcnt        := (INTEGER)le.threatmetrix.ExactidPerPhoneInTxinqCnt;
	exactidperphoneintxinqcnt1y      := (INTEGER)le.threatmetrix.ExactidPerPhoneInTxinqCnt1Y;
	exactidperphoneintxinqcnt6m      := (INTEGER)le.threatmetrix.ExactidPerPhoneInTxinqCnt6M;
	exactidperphoneintxinqcnt3m      := (INTEGER)le.threatmetrix.ExactidPerPhoneInTxinqCnt3M;
	exactidperphoneintxinqcnt1m      := (INTEGER)le.threatmetrix.ExactidPerPhoneInTxinqCnt1M;
	emailperphoneintxinqcnt          := (INTEGER)le.threatmetrix.EmailPerPhoneInTxinqCnt;
	emailperphoneintxinqcnt1y        := (INTEGER)le.threatmetrix.EmailPerPhoneInTxinqCnt1Y;
	emailperphoneintxinqcnt1m        := (INTEGER)le.threatmetrix.EmailPerPhoneInTxinqCnt1M;
	emailperphoneintxinqcnt3m        := (INTEGER)le.threatmetrix.EmailPerPhoneInTxinqCnt3M;
	emailperphoneintxinqcnt6m        := (INTEGER)le.threatmetrix.EmailPerPhoneInTxinqCnt6M;
	tmxidperphoneintxinqcnt          := (INTEGER)le.threatmetrix.TmxidPerPhoneInTxinqCnt;
	tmxidperphoneintxinqcnt1y        := (INTEGER)le.threatmetrix.TmxidPerPhoneInTxinqCnt1Y;
	tmxidperphoneintxinqcnt6m        := (INTEGER)le.threatmetrix.TmxidPerPhoneInTxinqCnt6M;
	tmxidperphoneintxinqcnt3m        := (INTEGER)le.threatmetrix.TmxidPerPhoneInTxinqCnt3M;
	tmxidperphoneintxinqcnt1m        := (INTEGER)le.threatmetrix.TmxidPerPhoneInTxinqCnt1M;
	trueipperphoneintxinqcnt         := (INTEGER)le.threatmetrix.TrueipPerPhoneInTxinqCnt;
	browserhashperphoneintxinqcnt    := (INTEGER)le.threatmetrix.BrowserHashPerPhoneInTxinqCnt;
	loginidperphoneintxinqcnt        := (INTEGER)le.threatmetrix.LoginidPerPhoneInTxinqCnt;
	txinqwphonecnt1y                 := (INTEGER)le.threatmetrix.TxinqWPhoneCnt1Y;
	txinqwphonecnt6m                 := (INTEGER)le.threatmetrix.TxinqWPhoneCnt6M;
	txinqcorrnamewphonecnt1y         := (INTEGER)le.threatmetrix.TxinqCorrNameWPhoneCnt1Y;
	txinqcorrnamewphonecnt6m         := (INTEGER)le.threatmetrix.TxinqCorrNameWPhoneCnt6M;
	txinqcorrnamewphonecnt3m         := (INTEGER)le.threatmetrix.TxinqCorrNameWPhoneCnt3M;
	txinqcorrnamewphonecnt1m         := (INTEGER)le.threatmetrix.TxinqCorrNameWPhoneCnt1M;
	txinqwphonefinstatusrejcnt       := (INTEGER)le.threatmetrix.TxinqWPhoneFinStatusRejCnt;
	txinqwphonefinstatusrejcnt1m     := (INTEGER)le.threatmetrix.TxinqWPhoneFinStatusRejCnt1M;
	txinqwphonefinstatusacccnt       := (INTEGER)le.threatmetrix.TxinqWPhoneFinStatusAccCnt;
	txinqwphonefinstatusacccnt1m     := (INTEGER)le.threatmetrix.TxinqWPhoneFinStatusAccCnt1M;
	distbtwtrueipwphoneavg           := (Real)le.threatmetrix.DistBtwTrueipWPhoneAvg;
	timebtwtxinqwphoneavg            := (Real)le.threatmetrix.TimeBtwTxinqWPhoneAvg;
	ruleexactidblistintxinqwpflag1m  := (INTEGER)le.threatmetrix.RuleExactidBlistInTxinqWPFlag1M;
	ruleexactidblistintxinqwpflag1y  := (INTEGER)le.threatmetrix.RuleExactidBlistInTxinqWPFlag1Y;
	rulesmartidblistintxinqwpflag1m  := (INTEGER)le.threatmetrix.RuleSmartidBlistInTxinqWPFlag1M;
	rulesmartidblistintxinqwpflag1y  := (INTEGER)le.threatmetrix.RuleSmartidBlistInTxinqWPFlag1Y;

/* Start of the ECL code that was converted from SAS code */

NULL := Models.Common.NULL;

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

txinqwemailfirst_mdy_c1_b2 := (ut.DaysSince1900((trim(TxinqWEmailFirst, LEFT))[1..4], (trim(TxinqWEmailFirst, LEFT))[5..6], (trim(TxinqWEmailFirst, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwemailfirst_dayssince := if((trim(trim(TxinqWEmailFirst, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(sysdate - txinqwemailfirst_mdy_c1_b2, 0));

txinqwemaillast_mdy_c2_b2 := (ut.DaysSince1900((trim(TxinqWEmailLast, LEFT))[1..4], (trim(TxinqWEmailLast, LEFT))[5..6], (trim(TxinqWEmailLast, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwemaillast_dayssince := if((trim(trim(TxinqWEmailLast, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(sysdate - txinqwemaillast_mdy_c2_b2, 0));

txinqwphonefirst_mdy_c3_b2 := (ut.DaysSince1900((trim(TxinqWPhoneFirst, LEFT))[1..4], (trim(TxinqWPhoneFirst, LEFT))[5..6], (trim(TxinqWPhoneFirst, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwphonefirst_dayssince := if((trim(trim(TxinqWPhoneFirst, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(sysdate - txinqwphonefirst_mdy_c3_b2, 0));

txinqwphonelast_mdy_c4_b2 := (ut.DaysSince1900((trim(TxinqWPhoneLast, LEFT))[1..4], (trim(TxinqWPhoneLast, LEFT))[5..6], (trim(TxinqWPhoneLast, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwphonelast_dayssince := if((trim(trim(TxinqWPhoneLast, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(sysdate - txinqwphonelast_mdy_c4_b2, 0));

new_email := (TxinqWEmailCnt1Y in [-99999, -99998, NULL]);

new_email_or_phone := (TxinqCorrEmailWPhoneCnt in [-99999, -99998, NULL]);

new_email_or_name := (TxinqCorrEmailWNameCnt in [-99999, -99998, NULL]);

new_email_or_address := (TxinqCorrEmailWAddressCnt in [-99999, -99998, NULL]);

new_email_phone_or_name := (TxinqCorrEmailWPhoneNameCnt in [-99999, -99998, NULL]);

new_email_phone_name_or_address := (TxinqCorrEmailWPFLACnt in [-99999, -99998, NULL]);

esmartidperemailintxinqcnt := if((SmartidPerEmailInTxinqCnt in [-99999, -99998, NULL]), 5.9356613623, SmartidPerEmailInTxinqCnt);

esmartidperemailintxinqcnt1y := if((SmartidPerEmailInTxinqCnt1Y in [-99999, -99998, NULL]), 3.7623215523, SmartidPerEmailInTxinqCnt1Y);

esmartidperemailintxinqcnt6m := if((SmartidPerEmailInTxinqCnt6M in [-99999, -99998, NULL]), 2.2681910999, SmartidPerEmailInTxinqCnt6M);

esmartidperemailintxinqcnt3m := if((SmartidPerEmailInTxinqCnt3M in [-99999, -99998, NULL]), 1.4562085271, SmartidPerEmailInTxinqCnt3M);

esmartidperemailintxinqcnt1m := if((SmartidPerEmailInTxinqCnt1M in [-99999, -99998, NULL]), 0.7501206893, SmartidPerEmailInTxinqCnt1M);

eexactidperemailintxinqcnt := if((ExactidPerEmailInTxinqCnt in [-99999, -99998, NULL]), 6.2903499540, ExactidPerEmailInTxinqCnt);

eexactidperemailintxinqcnt1y := if((ExactidPerEmailInTxinqCnt1Y in [-99999, -99998, NULL]), 4.0462217505, ExactidPerEmailInTxinqCnt1Y);

eexactidperemailintxinqcnt6m := if((ExactidPerEmailInTxinqCnt6M in [-99999, -99998, NULL]), 2.4330631692, ExactidPerEmailInTxinqCnt6M);

eexactidperemailintxinqcnt3m := if((ExactidPerEmailInTxinqCnt3M in [-99999, -99998, NULL]), 1.5623071595, ExactidPerEmailInTxinqCnt3M);

eexactidperemailintxinqcnt1m := if((ExactidPerEmailInTxinqCnt1M in [-99999, -99998, NULL]), 0.7913889314, ExactidPerEmailInTxinqCnt1M);

ephoneperemailintxinqcnt1y := if((PhonePerEmailInTxinqCnt1Y in [-99999, -99998, NULL]), 0.9539581590, PhonePerEmailInTxinqCnt1Y);

ephoneperemailintxinqcnt1m := if((PhonePerEmailInTxinqCnt1M in [-99999, -99998, NULL]), 0.2822780142, PhonePerEmailInTxinqCnt1M);

ephoneperemailintxinqcnt3m := if((PhonePerEmailInTxinqCnt3M in [-99999, -99998, NULL]), 0.4836537222, PhonePerEmailInTxinqCnt3M);

etmxidperemailintxinqcnt := if((TmxidPerEmailInTxinqCnt in [-99999, -99998, NULL]), 2.6702528628, TmxidPerEmailInTxinqCnt);

etmxidperemailintxinqcnt1y := if((TmxidPerEmailInTxinqCnt1Y in [-99999, -99998, NULL]), 2.4701185304, TmxidPerEmailInTxinqCnt1Y);

etmxidperemailintxinqcnt6m := if((TmxidPerEmailInTxinqCnt6M in [-99999, -99998, NULL]), 1.7375899922, TmxidPerEmailInTxinqCnt6M);

etmxidperemailintxinqcnt3m := if((TmxidPerEmailInTxinqCnt3M in [-99999, -99998, NULL]), 1.1514058429, TmxidPerEmailInTxinqCnt3M);

etmxidperemailintxinqcnt1m := if((TmxidPerEmailInTxinqCnt1M in [-99999, -99998, NULL]), 0.6661539246, TmxidPerEmailInTxinqCnt1M);

eorgidperemailintxinqcnt := if((OrgidPerEmailInTxinqCnt in [-99999, -99998, NULL]), 3.6019981949, OrgidPerEmailInTxinqCnt);

etrueipperemailintxinqcnt := if((TrueipPerEmailInTxinqCnt in [-99999, -99998, NULL]), 14.0450373462, TrueipPerEmailInTxinqCnt);

etrueipgperemailintxinqcnt := if((TrueipgPerEmailInTxinqCnt in [-99999, -99998, NULL]), 0.9921019727, TrueipgPerEmailInTxinqCnt);

ednsipperemailintxinqcnt := if((DnsipPerEmailInTxinqCnt in [-99999, -99998, NULL]), 8.3929373525, DnsipPerEmailInTxinqCnt);

ednsipgperemailintxinqcnt := if((DnsipgPerEmailInTxinqCnt in [-99999, -99998, NULL]), 0.9650645725, DnsipgPerEmailInTxinqCnt);

eproxyipperemailintxinqcnt := if((ProxyipPerEmailInTxinqCnt in [-99999, -99998, NULL]), 0.8867679557, ProxyipPerEmailInTxinqCnt);

eproxyipgperemailintxinqcnt := if((ProxyipgPerEmailInTxinqCnt in [-99999, -99998, NULL]), 0.2828087472, ProxyipgPerEmailInTxinqCnt);

ebrowserperemailintxinqcnt := if((BrowserPerEmailInTxinqCnt in [-99999, -99998, NULL]), 1.5150089505, BrowserPerEmailInTxinqCnt);

ebrowserhashperemailintxinqcnt := if((BrowserHashPerEmailInTxinqCnt in [-99999, -99998, NULL]), 6.3456721269, BrowserHashPerEmailInTxinqCnt);

escreenresperemailintxinqcnt := if((ScreenResPerEmailInTxinqCnt in [-99999, -99998, NULL]), 2.5429638892, ScreenResPerEmailInTxinqCnt);

etimezoneperemailintxinqcnt := if((TimeZonePerEmailInTxinqCnt in [-99999, -99998, NULL]), 1.1842273337, TimeZonePerEmailInTxinqCnt);

ecurrencyperemailintxinqcnt := if((CurrencyPerEmailInTxinqCnt in [-99999, -99998, NULL]), 0.2530816999, CurrencyPerEmailInTxinqCnt);

eachperemailintxinqcnt := if((ACHPerEmailInTXInqCnt in [-99999, -99998, NULL]), 0.1253939269, ACHPerEmailInTXInqCnt);

eagentpubkeyperemailintxinqcnt := if((AgentPubKeyPerEmailInTXInqCnt in [-99999, -99998, NULL]), 0.2374745503, AgentPubKeyPerEmailInTXInqCnt);

eccardperemailintxinqcnt := if((CCardPerEmailInTXInqCnt in [-99999, -99998, NULL]), 0.4592430008, CCardPerEmailInTXInqCnt);

etxinqcorremailwphonenamecnt := if((TxinqCorrEmailWPhoneNameCnt in [-99999, -99998, NULL]), 0.2756935666, TxinqCorrEmailWPhoneNameCnt);

etxinqcorremailwphonenamecnt1y := if((TxinqCorrEmailWPhoneNameCnt1Y in [-99999, -99998, NULL]), 0.2391247385, TxinqCorrEmailWPhoneNameCnt1Y);

etxinqcorremailwphonenamecnt6m := if((TxinqCorrEmailWPhoneNameCnt6M in [-99999, -99998, NULL]), 0.1818465994, TxinqCorrEmailWPhoneNameCnt6M);

etxinqcorremailwphonenamecnt3m := if((TxinqCorrEmailWPhoneNameCnt3M in [-99999, -99998, NULL]), 0.1234697865, TxinqCorrEmailWPhoneNameCnt3M);

etxinqcorremailwphonenamecnt1m := if((TxinqCorrEmailWPhoneNameCnt1M in [-99999, -99998, NULL]), 0.0723377847, TxinqCorrEmailWPhoneNameCnt1M);

etxinqcorremailwpflacnt := if((TxinqCorrEmailWPFLACnt in [-99999, -99998, NULL]), 0.0325459438, TxinqCorrEmailWPFLACnt);

etxinqcorremailwpflacnt1y := if((TxinqCorrEmailWPFLACnt1Y in [-99999, -99998, NULL]), 0.0263185132, TxinqCorrEmailWPFLACnt1Y);

etxinqcorremailwpflacnt6m := if((TxinqCorrEmailWPFLACnt6M in [-99999, -99998, NULL]), 0.0162557214, TxinqCorrEmailWPFLACnt6M);

etxinqcorremailwpflacnt3m := if((TxinqCorrEmailWPFLACnt3M in [-99999, -99998, NULL]), 0.0104193022, TxinqCorrEmailWPFLACnt3M);

etxinqcorremailwpflacnt1m := if((TxinqCorrEmailWPFLACnt1M in [-99999, -99998, NULL]), 0.0055719116, TxinqCorrEmailWPFLACnt1M);

etxinqcorremailwphonecnt := if((TxinqCorrEmailWPhoneCnt in [-99999, -99998, NULL]), 3.2523151745, TxinqCorrEmailWPhoneCnt);

etxinqcorremailwphonecnt1y := if((TxinqCorrEmailWPhoneCnt1Y in [-99999, -99998, NULL]), 2.0933440767, TxinqCorrEmailWPhoneCnt1Y);

etxinqcorremailwphonecnt6m := if((TxinqCorrEmailWPhoneCnt6M in [-99999, -99998, NULL]), 1.3791321754, TxinqCorrEmailWPhoneCnt6M);

etxinqcorremailwphonecnt3m := if((TxinqCorrEmailWPhoneCnt3M in [-99999, -99998, NULL]), 0.9043181662, TxinqCorrEmailWPhoneCnt3M);

etxinqcorremailwphonecnt1m := if((TxinqCorrEmailWPhoneCnt1M in [-99999, -99998, NULL]), 0.4222162805, TxinqCorrEmailWPhoneCnt1M);

etxinqwemailcnt1y := if((TxinqWEmailCnt1Y in [-99999, -99998, NULL]), 21.8570109235, TxinqWEmailCnt1Y);

etxinqwemailcnt6m := if((TxinqWEmailCnt6M in [-99999, -99998, NULL]), 13.5302562811, TxinqWEmailCnt6M);

etxinqcorremailwaddresscnt := if((TxinqCorrEmailWAddressCnt in [-99999, -99998, NULL]), 0.9377564120, TxinqCorrEmailWAddressCnt);

etxinqcorremailwaddresscnt1y := if((TxinqCorrEmailWAddressCnt1Y in [-99999, -99998, NULL]), 0.5441455029, TxinqCorrEmailWAddressCnt1Y);

etxinqcorremailwaddresscnt6m := if((TxinqCorrEmailWAddressCnt6M in [-99999, -99998, NULL]), 0.3699020585, TxinqCorrEmailWAddressCnt6M);

etxinqcorremailwaddresscnt3m := if((TxinqCorrEmailWAddressCnt3M in [-99999, -99998, NULL]), 0.2425556364, TxinqCorrEmailWAddressCnt3M);

etxinqcorremailwaddresscnt1m := if((TxinqCorrEmailWAddressCnt1M in [-99999, -99998, NULL]), 0.1073676084, TxinqCorrEmailWAddressCnt1M);

etxinqcorremailwnamecnt := if((TxinqCorrEmailWNameCnt in [-99999, -99998, NULL]), 0.4431174301, TxinqCorrEmailWNameCnt);

etxinqcorremailwnamecnt1y := if((TxinqCorrEmailWNameCnt1Y in [-99999, -99998, NULL]), 0.3756781302, TxinqCorrEmailWNameCnt1Y);

etxinqcorremailwnamecnt6m := if((TxinqCorrEmailWNameCnt6M in [-99999, -99998, NULL]), 0.2911439203, TxinqCorrEmailWNameCnt6M);

etxinqcorremailwnamecnt3m := if((TxinqCorrEmailWNameCnt3M in [-99999, -99998, NULL]), 0.1922112471, TxinqCorrEmailWNameCnt3M);

etxinqcorremailwnamecnt1m := if((TxinqCorrEmailWNameCnt1M in [-99999, -99998, NULL]), 0.1034495230, TxinqCorrEmailWNameCnt1M);

etxinqwemailfinstatusrejcnt := if((TxinqWEmailFinStatusRejCnt in [-99999, -99998, NULL]), 0.0180569174, TxinqWEmailFinStatusRejCnt);

etxinqwemailfinstatusrejcnt1m := if((TxinqWEmailFinStatusRejCnt1M in [-99999, -99998, NULL]), 0.0018350770, TxinqWEmailFinStatusRejCnt1M);

etxinqwemailfinstatusacccnt := if((TxinqWEmailFinStatusAccCnt in [-99999, -99998, NULL]), 0.0190973940, TxinqWEmailFinStatusAccCnt);

etxinqwemailfinstatusacccnt1m := if((TxinqWEmailFinStatusAccCnt1M in [-99999, -99998, NULL]), 0.0013703107, TxinqWEmailFinStatusAccCnt1M);

edistbtwtrueipwemailavg := if((DistBtwTrueipWEmailAvg in [-99999, -99998, NULL]), 516.9544997753, DistBtwTrueipWEmailAvg);

etimebtwtxinqwemailavg := if((TimeBtwTxinqWEmailAvg in [-99999, -99998, NULL]), 53098.7904306017, TimeBtwTxinqWEmailAvg);

eruleemailtrustedbyuserflag1m := if((RuleEmailTrustedByUserFlag1M in [-99999, -99998, NULL]), 0.0001019487, RuleEmailTrustedByUserFlag1M);

eruleemailtrustedbyuserflag3m := if((RuleEmailTrustedByUserFlag3M in [-99999, -99998, NULL]), 0.0002278854, RuleEmailTrustedByUserFlag3M);

eruleemailtrustedbyuserflag6m := if((RuleEmailTrustedByUserFlag6M in [-99999, -99998, NULL]), 0.0006866546, RuleEmailTrustedByUserFlag6M);

eruleemailtrustedbyuserflag1y := if((RuleEmailTrustedByUserFlag1Y in [-99999, -99998, NULL]), 0.0003688145, RuleEmailTrustedByUserFlag1Y);

eruleemailblistflag := if((RuleEmailBlistFlag in [-99999, -99998, NULL]), 0.0024317768, RuleEmailBlistFlag);

eruleemailblistbybankflag := if((RuleEmailBlistByBankFlag in [-99999, -99998, NULL]), 0.0001019487, RuleEmailBlistByBankFlag);

eruleemailblistbyfintechflag := if((RuleEmailBlistByFinTechFlag in [-99999, -99998, NULL]), 0.0009685128, RuleEmailBlistByFinTechFlag);

eruleemailblistbyecommflag := if((RuleEmailBlistByEcommFlag in [-99999, -99998, NULL]), 0.0008575686, RuleEmailBlistByEcommFlag);

eruleexactidblistintxinqweflag1m := if((RuleExactidBlistInTxinqWEFlag1M in [-99999, -99998, NULL]), 0.0003028477, RuleExactidBlistInTxinqWEFlag1M);

eruleexactidblistintxinqweflag := if((RuleExactidBlistInTxinqWEFlag in [-99999, -99998, NULL]), 0.0008575686,RuleExactidBlistInTxinqWEFlag);

erulesmartidblistintxinqweflag1m := if((RuleSmartidBlistInTxinqWEFlag1M in [-99999, -99998, NULL]), 0.0006806576, RuleSmartidBlistInTxinqWEFlag1M);

erulesmartidblistintxinqweflag := if((RuleSmartidBlistInTxinqWEFlag in [-99999, -99998, NULL]), 0.0016491705, RuleSmartidBlistInTxinqWEFlag);

eruleemailhighriskdomainflag := if((RuleEmailHighRiskDomainFlag in [-99999, -99998, NULL]), 0.0012923499, RuleEmailHighRiskDomainFlag);

eruleemailaliasflag := if((RuleEmailAliasFlag in [-99999, -99998, NULL]), 0.0155321873, RuleEmailAliasFlag);

eruleemailmachinegeneratedflag := if((RuleEmailMachineGeneratedFlag in [-99999, -99998, NULL]), 0.0488634217, RuleEmailMachineGeneratedFlag);

etxinqwemailfirst_dayssince := if((txinqwemailfirst_dayssince in [-99999, -99998, NULL]), 500.1972407879, txinqwemailfirst_dayssince);

etxinqwemaillast_dayssince := if((txinqwemaillast_dayssince in [-99999, -99998, NULL]), 83.9261389602, txinqwemaillast_dayssince);

enew_email := if(((Real)new_email in [-99999, -99998, NULL]), 0.1391412088, (Real)new_email);

enew_email_or_phone := if(((Real)new_email_or_phone in [-99999, -99998, NULL]), 0.2856029220, (Real)new_email_or_phone);

enew_email_or_name := if(((Real)new_email_or_name in [-99999, -99998, NULL]), 0.3576592971, (Real)new_email_or_name);

enew_email_or_address := if(((Real)new_email_or_address in [-99999, -99998, NULL]), 0.4249274016, (Real)new_email_or_address);

enew_email_phone_or_name := if(((Real)new_email_phone_or_name in [-99999, -99998, NULL]), 0.4384816923, (Real)new_email_phone_or_name);

enew_email_phone_name_or_address := if(((Real)new_email_phone_name_or_address in [-99999, -99998, NULL]), 0.5510951072, (Real)new_email_phone_name_or_address);

email_v001 := (esmartidperemailintxinqcnt - 5.9356613623) / 6.2764432675;

email_v002 := (esmartidperemailintxinqcnt1y - 3.7623215523) / 4.0411994337;

email_v003 := (esmartidperemailintxinqcnt6m - 2.2681910999) / 2.7740154602;

email_v004 := (esmartidperemailintxinqcnt3m - 1.4562085271) / 2.0757334217;

email_v005 := (esmartidperemailintxinqcnt1m - 0.7501206893) / 1.3154736008;

email_v006 := (eexactidperemailintxinqcnt - 6.2903499540) / 7.1628558474;

email_v007 := (eexactidperemailintxinqcnt1y - 4.0462217505) / 4.9625172185;

email_v008 := (eexactidperemailintxinqcnt6m - 2.4330631692) / 3.4864581910;

email_v009 := (eexactidperemailintxinqcnt3m - 1.5623071595) / 2.5941793884;

email_v010 := (eexactidperemailintxinqcnt1m - 0.7913889314) / 1.5155324900;

email_v011 := (ephoneperemailintxinqcnt1y - 0.9539581590) / 1.0224352756;

email_v012 := (ephoneperemailintxinqcnt1m - 0.2822780142) / 0.5624708614;

email_v013 := (ephoneperemailintxinqcnt3m - 0.4836537222) / 0.7255924045;

email_v014 := (etmxidperemailintxinqcnt - 2.6702528628) / 2.2807852455;

email_v015 := (etmxidperemailintxinqcnt1y - 2.4701185304) / 2.1625972686;

email_v016 := (etmxidperemailintxinqcnt6m - 1.7375899922) / 1.7104251905;

email_v017 := (etmxidperemailintxinqcnt3m - 1.1514058429) / 1.4014844412;

email_v018 := (etmxidperemailintxinqcnt1m - 0.6661539246) / 1.0575731414;

email_v019 := (eorgidperemailintxinqcnt - 3.6019981949) / 2.9024333924;

email_v020 := (etrueipperemailintxinqcnt - 14.0450373462) / 21.6483790445;

email_v021 := (etrueipgperemailintxinqcnt - 0.9921019727) / 0.6287912684;

email_v022 := (ednsipperemailintxinqcnt - 8.3929373525) / 10.0540865903;

email_v023 := (ednsipgperemailintxinqcnt - 0.9650645725) / 0.6179939060;

email_v024 := (eproxyipperemailintxinqcnt - 0.8867679557) / 2.7215584145;

email_v025 := (eproxyipgperemailintxinqcnt - 0.2828087472) / 0.4552184045;

email_v026 := (ebrowserperemailintxinqcnt - 1.5150089505) / 1.0431102107;

email_v027 := (ebrowserhashperemailintxinqcnt - 6.3456721269) / 6.6999377148;

email_v028 := (escreenresperemailintxinqcnt - 2.5429638892) / 2.1070841268;

email_v029 := (etimezoneperemailintxinqcnt - 1.1842273337) / 0.8476274988;

email_v030 := (ecurrencyperemailintxinqcnt - 0.2530816999) / 0.4152409268;

email_v031 := (eachperemailintxinqcnt - 0.1253939269) / 0.3686914996;

email_v032 := (eagentpubkeyperemailintxinqcnt - 0.2374745503) / 0.5831817960;

email_v033 := (eccardperemailintxinqcnt - 0.4592430008) / 0.9968086479;

email_v034 := (etxinqcorremailwphonenamecnt - 0.2756935666) / 1.5740022282;

email_v035 := (etxinqcorremailwphonenamecnt1y - 0.2391247385) / 1.3506761458;

email_v036 := (etxinqcorremailwphonenamecnt6m - 0.1818465994) / 1.1199411528;

email_v037 := (etxinqcorremailwphonenamecnt3m - 0.1234697865) / 0.9111161786;

email_v038 := (etxinqcorremailwphonenamecnt1m - 0.0723377847) / 0.5750499291;

email_v039 := (etxinqcorremailwpflacnt - 0.0325459438) / 0.5714071698;

email_v040 := (etxinqcorremailwpflacnt1y - 0.0263185132) / 0.4754685103;

email_v041 := (etxinqcorremailwpflacnt6m - 0.0162557214) / 0.3466059512;

email_v042 := (etxinqcorremailwpflacnt3m - 0.0104193022) / 0.2716078873;

email_v043 := (etxinqcorremailwpflacnt1m - 0.0055719116) / 0.1723046885;

email_v044 := (etxinqcorremailwphonecnt - 3.2523151745) / 7.5479475260;

email_v045 := (etxinqcorremailwphonecnt1y - 2.0933440767) / 5.7972102041;

email_v046 := (etxinqcorremailwphonecnt6m - 1.3791321754) / 4.5135474247;

email_v047 := (etxinqcorremailwphonecnt3m - 0.9043181662) / 3.3769847348;

email_v048 := (etxinqcorremailwphonecnt1m - 0.4222162805) / 1.9683441224;

email_v049 := (etxinqwemailcnt1y - 21.8570109235) / 29.7157643332;

email_v050 := (etxinqwemailcnt6m - 13.5302562811) / 22.9997242469;

email_v051 := (etxinqcorremailwaddresscnt - 0.9377564120) / 2.9089149733;

email_v052 := (etxinqcorremailwaddresscnt1y - 0.5441455029) / 1.7702846019;

email_v053 := (etxinqcorremailwaddresscnt6m - 0.3699020585) / 1.2965294778;

email_v054 := (etxinqcorremailwaddresscnt3m - 0.2425556364) / 0.9528252517;

email_v055 := (etxinqcorremailwaddresscnt1m - 0.1073676084) / 0.4714373440;

email_v056 := (etxinqcorremailwnamecnt - 0.4431174301) / 2.4410174238;

email_v057 := (etxinqcorremailwnamecnt1y - 0.3756781302) / 2.1613363884;

email_v058 := (etxinqcorremailwnamecnt6m - 0.2911439203) / 1.9079379748;

email_v059 := (etxinqcorremailwnamecnt3m - 0.1922112471) / 1.4399878190;

email_v060 := (etxinqcorremailwnamecnt1m - 0.1034495230) / 0.9220475328;

email_v061 := (etxinqwemailfinstatusrejcnt - 0.0180569174) / 0.5457066437;

email_v062 := (etxinqwemailfinstatusrejcnt1m - 0.0018350770) / 0.1701130935;

email_v063 := (etxinqwemailfinstatusacccnt - 0.0190973940) / 0.3752982132;

email_v064 := (etxinqwemailfinstatusacccnt1m - 0.0013703107) / 0.1040522592;

email_v065 := (edistbtwtrueipwemailavg - 516.9544997753) / 904.2808975708;

email_v066 := (etimebtwtxinqwemailavg - 53098.7904306017) / 67510.0518282450;

email_v067 := (eruleemailtrustedbyuserflag1m - 0.0001019487) / 0.0093677495;

email_v068 := (eruleemailtrustedbyuserflag3m - 0.0002278854) / 0.0140047466;

email_v069 := (eruleemailtrustedbyuserflag6m - 0.0006866546) / 0.0243044912;

email_v070 := (eruleemailtrustedbyuserflag1y - 0.0003688145) / 0.0178151877;

email_v071 := (eruleemailblistflag - 0.0024317768) / 0.0456982617;

email_v072 := (eruleemailblistbybankflag - 0.0001019487) / 0.0093677495;

email_v073 := (eruleemailblistbyfintechflag - 0.0009685128) / 0.0288608288;

email_v074 := (eruleemailblistbyecommflag - 0.0008575686) / 0.0271590558;

email_v075 := (eruleexactidblistintxinqweflag1m - 0.0003028477) / 0.0161440638;

email_v076 := (eruleexactidblistintxinqweflag - 0.0008575686) / 0.0271590558;

email_v077 := (erulesmartidblistintxinqweflag1m - 0.0006806576) / 0.0241981979;

email_v078 := (erulesmartidblistintxinqweflag - 0.0016491705) / 0.0376479112;

email_v079 := (eruleemailhighriskdomainflag - 0.0012923499) / 0.0333331052;

email_v080 := (eruleemailaliasflag - 0.0155321873) / 0.1147317427;

email_v081 := (eruleemailmachinegeneratedflag - 0.0488634217) / 0.2000229830;

email_v082 := (etxinqwemailfirst_dayssince - 500.1972407879) / 391.2430248045;

email_v083 := (etxinqwemaillast_dayssince - 83.9261389602) / 108.4244914344;

email_v084 := (enew_email - 0.1391412088) / 0.3460942675;

email_v085 := (enew_email_or_phone - 0.2856029220) / 0.4517016932;

email_v086 := (enew_email_or_name - 0.3576592971) / 0.4793117121;

email_v087 := (enew_email_or_address - 0.4249274016) / 0.4943326165;

email_v088 := (enew_email_phone_or_name - 0.4384816923) / 0.4962017063;

email_v089 := (enew_email_phone_name_or_address - 0.5510951072) / 0.4973830803;

email_pc001 := email_v001 * -0.1908788675 +
    email_v002 * -0.2044409951 +
    email_v003 * -0.2007246545 +
    email_v004 * -0.1865771916 +
    email_v005 * -0.1605242835 +
    email_v006 * -0.1881161577 +
    email_v007 * -0.1922826166 +
    email_v008 * -0.1856040952 +
    email_v009 * -0.1733850480 +
    email_v010 * -0.1569056704 +
    email_v011 * -0.1537793316 +
    email_v012 * -0.1268494964 +
    email_v013 * -0.1479703078 +
    email_v014 * -0.1980026058 +
    email_v015 * -0.2001303731 +
    email_v016 * -0.1984599847 +
    email_v017 * -0.1854763664 +
    email_v018 * -0.1595688940 +
    email_v019 * -0.1823330276 +
    email_v020 * -0.1087199059 +
    email_v021 * -0.1161346324 +
    email_v022 * -0.1644570326 +
    email_v023 * -0.1237009934 +
    email_v024 * -0.0730588370 +
    email_v025 * -0.0982552549 +
    email_v026 * -0.1527188472 +
    email_v027 * -0.1780188141 +
    email_v028 * -0.1703346383 +
    email_v029 * -0.1312008137 +
    email_v030 * -0.0950677861 +
    email_v031 * -0.0692705625 +
    email_v032 * -0.0873085521 +
    email_v033 * -0.1037004846 +
    email_v034 * -0.0515734346 +
    email_v035 * -0.0540967928 +
    email_v036 * -0.0523241621 +
    email_v037 * -0.0470619463 +
    email_v038 * -0.0412859809 +
    email_v039 * -0.0239442718 +
    email_v040 * -0.0254901796 +
    email_v041 * -0.0252578399 +
    email_v042 * -0.0228775525 +
    email_v043 * -0.0195256913 +
    email_v044 * -0.1079629182 +
    email_v045 * -0.0977541775 +
    email_v046 * -0.0901660327 +
    email_v047 * -0.0822364675 +
    email_v048 * -0.0659652227 +
    email_v049 * -0.1460743876 +
    email_v050 * -0.1254031060 +
    email_v051 * -0.0709000272 +
    email_v052 * -0.0713595904 +
    email_v053 * -0.0678718687 +
    email_v054 * -0.0629908988 +
    email_v055 * -0.0553007359 +
    email_v056 * -0.0549474875 +
    email_v057 * -0.0559445512 +
    email_v058 * -0.0520139288 +
    email_v059 * -0.0483863848 +
    email_v060 * -0.0403976021 +
    email_v061 * -0.0108417313 +
    email_v062 * -0.0054283309 +
    email_v063 * -0.0141807155 +
    email_v064 * -0.0060587520 +
    email_v065 * 0.0022490017 +
    email_v066 * 0.0668902529 +
    email_v067 * -0.0024272069 +
    email_v068 * -0.0039361199 +
    email_v069 * -0.0057902806 +
    email_v070 * -0.0053872744 +
    email_v071 * -0.0291496336 +
    email_v072 * -0.0078354603 +
    email_v073 * -0.0183724807 +
    email_v074 * -0.0321996351 +
    email_v075 * -0.0085655461 +
    email_v076 * -0.0104364395 +
    email_v077 * -0.0185586662 +
    email_v078 * -0.0102022935 +
    email_v079 * 0.0019087765 +
    email_v080 * 0.0053055809 +
    email_v081 * 0.0055061783 +
    email_v082 * -0.1528420647 +
    email_v083 * 0.1062460722 +
    email_v084 * 0.0005925305 +
    email_v085 * 0.0140798525 +
    email_v086 * -0.0016330920 +
    email_v087 * -0.0002267479 +
    email_v088 * 0.0053152738 +
    email_v089 * -0.0027856953;

email_pc002 := email_v001 * -0.0793803887 +
    email_v002 * -0.0592617982 +
    email_v003 * -0.0344769704 +
    email_v004 * -0.0189113201 +
    email_v005 * -0.0044258478 +
    email_v006 * -0.0760231916 +
    email_v007 * -0.0548465321 +
    email_v008 * -0.0310671492 +
    email_v009 * -0.0169370215 +
    email_v010 * -0.0025462114 +
    email_v011 * -0.0338618642 +
    email_v012 * 0.0162184983 +
    email_v013 * -0.0008569665 +
    email_v014 * -0.0571144241 +
    email_v015 * -0.0541063101 +
    email_v016 * -0.0369257412 +
    email_v017 * -0.0203701172 +
    email_v018 * -0.0070005930 +
    email_v019 * -0.0663163148 +
    email_v020 * -0.0419406879 +
    email_v021 * -0.0619547861 +
    email_v022 * -0.0517720588 +
    email_v023 * -0.0611928566 +
    email_v024 * -0.0171428242 +
    email_v025 * -0.0418452158 +
    email_v026 * -0.0705314206 +
    email_v027 * -0.0755357126 +
    email_v028 * -0.0811905561 +
    email_v029 * -0.0689740849 +
    email_v030 * -0.0401251039 +
    email_v031 * -0.0111891293 +
    email_v032 * 0.0058554649 +
    email_v033 * -0.0449671419 +
    email_v034 * 0.2559158043 +
    email_v035 * 0.2782362058 +
    email_v036 * 0.2847961612 +
    email_v037 * 0.2773505177 +
    email_v038 * 0.2487838797 +
    email_v039 * 0.1636923203 +
    email_v040 * 0.1789662333 +
    email_v041 * 0.1886021520 +
    email_v042 * 0.1802507781 +
    email_v043 * 0.1569702402 +
    email_v044 * 0.0870986755 +
    email_v045 * 0.1124379187 +
    email_v046 * 0.1249620001 +
    email_v047 * 0.1301627308 +
    email_v048 * 0.1227935321 +
    email_v049 * -0.0250364840 +
    email_v050 * -0.0022732787 +
    email_v051 * 0.0628991359 +
    email_v052 * 0.0894943260 +
    email_v053 * 0.0955384817 +
    email_v054 * 0.0970770231 +
    email_v055 * 0.0976635798 +
    email_v056 * 0.2361079224 +
    email_v057 * 0.2524386970 +
    email_v058 * 0.2507293462 +
    email_v059 * 0.2538749345 +
    email_v060 * 0.2235026711 +
    email_v061 * 0.0007927476 +
    email_v062 * 0.0033486305 +
    email_v063 * -0.0037013122 +
    email_v064 * 0.0016830339 +
    email_v065 * -0.0194140348 +
    email_v066 * 0.0097952280 +
    email_v067 * -0.0004047559 +
    email_v068 * -0.0011961738 +
    email_v069 * -0.0013224591 +
    email_v070 * -0.0016531709 +
    email_v071 * -0.0116538349 +
    email_v072 * 0.0001979704 +
    email_v073 * -0.0061698565 +
    email_v074 * -0.0140067851 +
    email_v075 * -0.0000227982 +
    email_v076 * -0.0022145656 +
    email_v077 * 0.0060642571 +
    email_v078 * -0.0050235219 +
    email_v079 * 0.0009843373 +
    email_v080 * 0.0024996666 +
    email_v081 * 0.0025779063 +
    email_v082 * -0.0628720384 +
    email_v083 * 0.0129057733 +
    email_v084 * 0.0015256176 +
    email_v085 * 0.0048344502 +
    email_v086 * 0.0006353532 +
    email_v087 * 0.0075735913 +
    email_v088 * 0.0020730318 +
    email_v089 * 0.0064585288;

email_pc003 := email_v001 * 0.1416702177 +
    email_v002 * 0.0187233548 +
    email_v003 * -0.0824013236 +
    email_v004 * -0.1429082388 +
    email_v005 * -0.1779860145 +
    email_v006 * 0.1135511256 +
    email_v007 * -0.0045150806 +
    email_v008 * -0.0969747523 +
    email_v009 * -0.1493293743 +
    email_v010 * -0.1844855651 +
    email_v011 * -0.0193695330 +
    email_v012 * -0.1745027990 +
    email_v013 * -0.1444191817 +
    email_v014 * 0.0409342981 +
    email_v015 * 0.0196660880 +
    email_v016 * -0.0641729291 +
    email_v017 * -0.1352627383 +
    email_v018 * -0.1745022892 +
    email_v019 * 0.1423573424 +
    email_v020 * 0.0764670077 +
    email_v021 * 0.1984733468 +
    email_v022 * 0.0856374156 +
    email_v023 * 0.1856947187 +
    email_v024 * 0.0385041138 +
    email_v025 * 0.1083264400 +
    email_v026 * 0.1607822547 +
    email_v027 * 0.1512474956 +
    email_v028 * 0.1807902957 +
    email_v029 * 0.1998514531 +
    email_v030 * 0.1117091474 +
    email_v031 * 0.0073492811 +
    email_v032 * -0.0160093419 +
    email_v033 * 0.0783117824 +
    email_v034 * 0.0837770835 +
    email_v035 * 0.0851088453 +
    email_v036 * 0.0809530252 +
    email_v037 * 0.0734121148 +
    email_v038 * 0.0575233815 +
    email_v039 * 0.0295431206 +
    email_v040 * 0.0286077357 +
    email_v041 * 0.0248724549 +
    email_v042 * 0.0200321207 +
    email_v043 * 0.0145878805 +
    email_v044 * -0.0723855538 +
    email_v045 * -0.1105167698 +
    email_v046 * -0.1270529840 +
    email_v047 * -0.1318689379 +
    email_v048 * -0.1220397213 +
    email_v049 * -0.0120078851 +
    email_v050 * -0.0778330172 +
    email_v051 * -0.0590221243 +
    email_v052 * -0.0917203134 +
    email_v053 * -0.1050052472 +
    email_v054 * -0.1118719408 +
    email_v055 * -0.1060361255 +
    email_v056 * 0.0961057348 +
    email_v057 * 0.0952594321 +
    email_v058 * 0.0898228939 +
    email_v059 * 0.0830368155 +
    email_v060 * 0.0643870447 +
    email_v061 * -0.0054259748 +
    email_v062 * -0.0137397620 +
    email_v063 * 0.0097316957 +
    email_v064 * -0.0041604207 +
    email_v065 * 0.1018276393 +
    email_v066 * 0.0207140970 +
    email_v067 * 0.0008927497 +
    email_v068 * 0.0049370619 +
    email_v069 * 0.0045616242 +
    email_v070 * 0.0061057778 +
    email_v071 * -0.0453753038 +
    email_v072 * -0.0071431569 +
    email_v073 * -0.0341332292 +
    email_v074 * -0.0553548345 +
    email_v075 * -0.0242320768 +
    email_v076 * -0.0120094893 +
    email_v077 * -0.0505387073 +
    email_v078 * 0.0068297477 +
    email_v079 * -0.0066144275 +
    email_v080 * -0.0030516330 +
    email_v081 * -0.0171585247 +
    email_v082 * 0.1720937826 +
    email_v083 * 0.0956298848 +
    email_v084 * 0.1486187895 +
    email_v085 * 0.1910810180 +
    email_v086 * 0.1990513268 +
    email_v087 * 0.1833451996 +
    email_v088 * 0.2202222851 +
    email_v089 * 0.2136947068;

email_distance_001 := sqrt(power((email_pc001 - -5.2795279323), 2) +
    power((email_pc002 - -1.1726155982),2) +
    power((email_pc003 - 0.3319116314),2));

email_distance_002 := sqrt(power((email_pc001 - -12.2327627746),2) +
    power((email_pc002 - 2.4852278598),2) +
    power((email_pc003 - -4.1569518335),2));

email_distance_003 := sqrt(power((email_pc001 - -24.1489507490),2) +
    power((email_pc002 - 91.9898791386),2) +
    power((email_pc003 - 16.3057257050),2));

email_distance_004 := sqrt(power((email_pc001 - 3.7110097316),2) +
    power((email_pc002 - 0.4945437824),2) +
    power((email_pc003 - -0.8098529386),2));

email_distance_005 := sqrt(power((email_pc001 - -0.1307684739),2) +
    power((email_pc002 - -0.1966996621),2) +
    power((email_pc003 - 0.7263662191),2));

email_mindist := if(max(email_distance_001, email_distance_002, email_distance_003, email_distance_004, email_distance_005) = NULL, NULL, min(if(email_distance_001 = NULL, -NULL, email_distance_001), if(email_distance_002 = NULL, -NULL, email_distance_002), if(email_distance_003 = NULL, -NULL, email_distance_003), if(email_distance_004 = NULL, -NULL, email_distance_004), if(email_distance_005 = NULL, -NULL, email_distance_005)));

email_cluster := map(
    email_distance_001 = email_mindist => 1,
    email_distance_002 = email_mindist => 2,
    email_distance_003 = email_mindist => 3,
    email_distance_004 = email_mindist => 4,
                                          5);

    iid1906_0_0_emailriskindex := map(
    TxinqWEmailCnt1Y = -99999                                                                                                                                                                                                                                                          => 0,
    TxinqWEmailCnt1Y = -99998                                                                                                                                                                                                                                                          => 1,
    RuleEmailBlistFlag = 1 or RuleEmailBlistByBankFlag = 1 or RuleEmailBlistByFinTechFlag = 1 or RuleEmailBlistByEcommFlag = 1 or RuleExactidBlistInTxinqWEFlag1M = 1 or RuleExactidBlistInTxinqWEFlag = 1 or RuleSmartidBlistInTxinqWEFlag1M = 1 or RuleSmartidBlistInTxinqWEFlag = 1 => 4,
    TxinqWEmailFinStatusRejCnt > 0                                                                                                                                                                                                                                                     => 4,
    (INTEGER)txinqwemailfirst_dayssince <= 30 and TxinqWEmailCnt6M > 5                                                                                                                                                                                                                          => 4,
    txinqwemailfirst_dayssince <= 90 and TxinqWEmailCnt6M > 10                                                                                                                                                                                                                         => 4,
    email_cluster = 3                                                                                                                                                                                                                                                                  => 4,
    RuleEmailHighRiskDomainFlag = 1 or RuleEmailAliasFlag = 1 or RuleEmailMachineGeneratedFlag = 1                                                                                                                                                                                     => 3,
    email_cluster = 2                                                                                                                                                                                                                                                                  => 3,
                                                                                                                                                                                                                                                                                          2);

iid1906_0_0_emailhighriskind := if(iid1906_0_0_emailriskindex = 4, 'ER', '');

new_phone := (TxinqWPhoneCnt in [-99999, -99998, NULL]);

new_phone_or_email := (TxinqCorrEmailWPhoneCnt in [-99999, -99998, NULL]);

new_phone_or_name := (TxinqCorrNameWPhoneCnt in [-99999, -99998, NULL]);

new_phone_email_or_name := (TxinqCorrEmailWPhoneNameCnt in [-99999, -99998, NULL]);

new_phone_email_name_or_address := ((Real)TxinqCorrEmailWPFLACnt in [-99999, -99998, NULL]);

psmartidperphoneintxinqcnt := if((SmartidPerPhoneInTxinqCnt in [-99999, -99998, NULL]), 2.2149746185, SmartidPerPhoneInTxinqCnt);

psmartidperphoneintxinqcnt1y := if((SmartidPerPhoneInTxinqCnt1Y in [-99999, -99998, NULL]), 1.4017558981, SmartidPerPhoneInTxinqCnt1Y);

psmartidperphoneintxinqcnt6m := if((SmartidPerPhoneInTxinqCnt6M in [-99999, -99998, NULL]), 0.9065552872, SmartidPerPhoneInTxinqCnt6M);

psmartidperphoneintxinqcnt3m := if((SmartidPerPhoneInTxinqCnt3M in [-99999, -99998, NULL]), 0.6108119800, SmartidPerPhoneInTxinqCnt3M);

psmartidperphoneintxinqcnt1m := if((SmartidPerPhoneInTxinqCnt1M in [-99999, -99998, NULL]), 0.3131384302, SmartidPerPhoneInTxinqCnt1M);

pexactidperphoneintxinqcnt := if((ExactidPerPhoneInTxinqCnt in [-99999, -99998, NULL]), 2.2472447344, ExactidPerPhoneInTxinqCnt);

pexactidperphoneintxinqcnt1y := if((ExactidPerPhoneInTxinqCnt1Y in [-99999, -99998, NULL]), 1.4235424047, ExactidPerPhoneInTxinqCnt1Y);

pexactidperphoneintxinqcnt6m := if((ExactidPerPhoneInTxinqCnt6M in [-99999, -99998, NULL]), 0.9147088414, ExactidPerPhoneInTxinqCnt6M);

pexactidperphoneintxinqcnt3m := if((ExactidPerPhoneInTxinqCnt3M in [-99999, -99998, NULL]), 0.6173236810, ExactidPerPhoneInTxinqCnt3M);

pexactidperphoneintxinqcnt1m := if((ExactidPerPhoneInTxinqCnt1M in [-99999, -99998, NULL]), 0.3168809378, ExactidPerPhoneInTxinqCnt1M);

pemailperphoneintxinqcnt := if((EmailPerPhoneInTxinqCnt in [-99999, -99998, NULL]), 1.0284325710, EmailPerPhoneInTxinqCnt);

pemailperphoneintxinqcnt1y := if((EmailPerPhoneInTxinqCnt1Y in [-99999, -99998, NULL]), 0.7987304313, EmailPerPhoneInTxinqCnt1Y);

pemailperphoneintxinqcnt1m := if((EmailPerPhoneInTxinqCnt1M in [-99999, -99998, NULL]), 0.2631815247, EmailPerPhoneInTxinqCnt1M);

pemailperphoneintxinqcnt3m := if((EmailPerPhoneInTxinqCnt3M in [-99999, -99998, NULL]), 0.4499005384, EmailPerPhoneInTxinqCnt3M);

pemailperphoneintxinqcnt6m := if((EmailPerPhoneInTxinqCnt6M in [-99999, -99998, NULL]), 0.6024847367, EmailPerPhoneInTxinqCnt6M);

ptmxidperphoneintxinqcnt := if((TmxidPerPhoneInTxinqCnt in [-99999, -99998, NULL]), 1.2262054184, TmxidPerPhoneInTxinqCnt);

ptmxidperphoneintxinqcnt1y := if((TmxidPerPhoneInTxinqCnt1Y in [-99999, -99998, NULL]), 1.1015196154, TmxidPerPhoneInTxinqCnt1Y);

ptmxidperphoneintxinqcnt6m := if((TmxidPerPhoneInTxinqCnt6M in [-99999, -99998, NULL]), 0.7749612477, TmxidPerPhoneInTxinqCnt6M);

ptmxidperphoneintxinqcnt3m := if((TmxidPerPhoneInTxinqCnt3M in [-99999, -99998, NULL]), 0.5524459024, TmxidPerPhoneInTxinqCnt3M);

ptmxidperphoneintxinqcnt1m := if((TmxidPerPhoneInTxinqCnt1M in [-99999, -99998, NULL]), 0.3054141829, TmxidPerPhoneInTxinqCnt1M);

ptrueipperphoneintxinqcnt := if((TrueipPerPhoneInTxinqCnt in [-99999, -99998, NULL]), 2.2518393016, TrueipPerPhoneInTxinqCnt);

pbrowserhashperphoneintxinqcnt := if((BrowserHashPerPhoneInTxinqCnt in [-99999, -99998, NULL]), 2.4100241526, BrowserHashPerPhoneInTxinqCnt);

ploginidperphoneintxinqcnt := if((LoginidPerPhoneInTxinqCnt in [-99999, -99998, NULL]), 0.5526818574, LoginidPerPhoneInTxinqCnt);

ptxinqcorremailwphonenamecnt := if((TxinqCorrEmailWPhoneNameCnt in [-99999, -99998, NULL]), 0.2756935666, TxinqCorrEmailWPhoneNameCnt);

ptxinqcorremailwphonenamecnt1y := if((TxinqCorrEmailWPhoneNameCnt1Y in [-99999, -99998, NULL]), 0.2391247385, TxinqCorrEmailWPhoneNameCnt1Y);

ptxinqcorremailwphonenamecnt6m := if((TxinqCorrEmailWPhoneNameCnt6M in [-99999, -99998, NULL]), 0.1818465994, TxinqCorrEmailWPhoneNameCnt6M);

ptxinqcorremailwphonenamecnt3m := if((TxinqCorrEmailWPhoneNameCnt3M in [-99999, -99998, NULL]), 0.1234697865, TxinqCorrEmailWPhoneNameCnt3M);

ptxinqcorremailwphonenamecnt1m := if((TxinqCorrEmailWPhoneNameCnt1M in [-99999, -99998, NULL]), 0.0723377847, TxinqCorrEmailWPhoneNameCnt1M);

ptxinqcorremailwpflacnt := if((TxinqCorrEmailWPFLACnt in [-99999, -99998, NULL]), 0.0325459438, TxinqCorrEmailWPFLACnt);

ptxinqcorremailwpflacnt1y := if((TxinqCorrEmailWPFLACnt1Y in [-99999, -99998, NULL]), 0.0263185132, TxinqCorrEmailWPFLACnt1Y);

ptxinqcorremailwpflacnt6m := if((TxinqCorrEmailWPFLACnt6M in [-99999, -99998, NULL]), 0.0162557214, TxinqCorrEmailWPFLACnt6M);

ptxinqcorremailwpflacnt3m := if((TxinqCorrEmailWPFLACnt3M in [-99999, -99998, NULL]), 0.0104193022, TxinqCorrEmailWPFLACnt3M);

ptxinqcorremailwpflacnt1m := if((TxinqCorrEmailWPFLACnt1M in [-99999, -99998, NULL]), 0.0055719116, TxinqCorrEmailWPFLACnt1M);

ptxinqcorremailwphonecnt := if((TxinqCorrEmailWPhoneCnt in [-99999, -99998, NULL]), 3.2523151745, TxinqCorrEmailWPhoneCnt);

ptxinqcorremailwphonecnt1y := if((TxinqCorrEmailWPhoneCnt1Y in [-99999, -99998, NULL]), 2.0933440767, TxinqCorrEmailWPhoneCnt1Y);

ptxinqcorremailwphonecnt6m := if((TxinqCorrEmailWPhoneCnt6M in [-99999, -99998, NULL]), 1.3791321754, TxinqCorrEmailWPhoneCnt6M);

ptxinqcorremailwphonecnt3m := if((TxinqCorrEmailWPhoneCnt3M in [-99999, -99998, NULL]), 0.9043181662, TxinqCorrEmailWPhoneCnt3M);

ptxinqcorremailwphonecnt1m := if((TxinqCorrEmailWPhoneCnt1M in [-99999, -99998, NULL]), 0.4222162805, TxinqCorrEmailWPhoneCnt1M);

ptxinqwphonecnt := if((TxinqWPhoneCnt in [-99999, -99998, NULL]), 5.3909347421, TxinqWPhoneCnt);

ptxinqwphonecnt1y := if((TxinqWPhoneCnt1Y in [-99999, -99998, NULL]), 3.4722343295, TxinqWPhoneCnt1Y);

ptxinqwphonecnt6m := if((TxinqWPhoneCnt6M in [-99999, -99998, NULL]), 2.2676056800, TxinqWPhoneCnt6M);

ptxinqcorrnamewphonecnt := if((TxinqCorrNameWPhoneCnt in [-99999, -99998, NULL]), 0.3727665961, TxinqCorrNameWPhoneCnt);

ptxinqcorrnamewphonecnt1y := if((TxinqCorrNameWPhoneCnt1Y in [-99999, -99998, NULL]), 0.3243800433, TxinqCorrNameWPhoneCnt1Y);

ptxinqcorrnamewphonecnt6m := if((TxinqCorrNameWPhoneCnt6M in [-99999, -99998, NULL]), 0.2468274914, TxinqCorrNameWPhoneCnt6M);

ptxinqcorrnamewphonecnt3m := if((TxinqCorrNameWPhoneCnt3M in [-99999, -99998, NULL]), 0.1660750272, TxinqCorrNameWPhoneCnt3M);

ptxinqcorrnamewphonecnt1m := if((TxinqCorrNameWPhoneCnt1M in [-99999, -99998, NULL]), 0.0975361940, TxinqCorrNameWPhoneCnt1M);

ptxinqwphonefinstatusrejcnt := if((TxinqWPhoneFinStatusRejCnt in [-99999, -99998, NULL]), 0.0131282710, TxinqWPhoneFinStatusRejCnt);

ptxinqwphonefinstatusrejcnt1m := if((TxinqWPhoneFinStatusRejCnt1M in [-99999, -99998, NULL]), 0.0015566472, TxinqWPhoneFinStatusRejCnt1M);

ptxinqwphonefinstatusacccnt := if((TxinqWPhoneFinStatusAccCnt in [-99999, -99998, NULL]), 0.0094775237, TxinqWPhoneFinStatusAccCnt);

ptxinqwphonefinstatusacccnt1m := if((TxinqWPhoneFinStatusAccCnt1M in [-99999, -99998, NULL]), 0.0024414783, TxinqWPhoneFinStatusAccCnt1M);

pdistbtwtrueipwphoneavg := if((DistBtwTrueipWPhoneAvg in [-99999, -99998, NULL]), 380.9858796373, DistBtwTrueipWPhoneAvg);

ptimebtwtxinqwphoneavg := if((TimeBtwTxinqWPhoneAvg in [-99999, -99998, NULL]), 116163.1221109054, TimeBtwTxinqWPhoneAvg);

pruleexactidblistintxinqwpflag1m := if((RuleExactidBlistInTxinqWPFlag1M in [-99999, -99998, NULL]), 0.0003211609, RuleExactidBlistInTxinqWPFlag1M);

pruleexactidblistintxinqwpflag1y := if((RuleExactidBlistInTxinqWPFlag1Y in [-99999, -99998, NULL]), 0.0010683516, RuleExactidBlistInTxinqWPFlag1Y);

prulesmartidblistintxinqwpflag1m := if((RuleSmartidBlistInTxinqWPFlag1M in [-99999, -99998, NULL]), 0.0003998125, RuleSmartidBlistInTxinqWPFlag1M);

prulesmartidblistintxinqwpflag1y := if((RuleSmartidBlistInTxinqWPFlag1Y in [-99999, -99998, NULL]), 0.0006783705, RuleSmartidBlistInTxinqWPFlag1Y);

ptxinqwphonefirst_dayssince := if((txinqwphonefirst_dayssince in [-99999, -99998, NULL]), 281.7897018775, txinqwphonefirst_dayssince);

ptxinqwphonelast_dayssince := if((txinqwphonelast_dayssince in [-99999, -99998, NULL]), 149.0212336947, txinqwphonelast_dayssince);

pnew_phone := if(((Real)new_phone in [-99999, -99998, NULL]), 0.2284197857, (Real)new_phone);

pnew_phone_or_email := if(((Real)new_phone_or_email in [-99999, -99998, NULL]), 0.3001861039, (Real)new_phone_or_email);

pnew_phone_or_name := if(((Real)new_phone_or_name in [-99999, -99998, NULL]), 0.4002346527, (Real)new_phone_or_name);

pnew_phone_email_or_name := if(((Real)new_phone_email_or_name in [-99999, -99998, NULL]), 0.4499441183, (Real)new_phone_email_or_name);

pnew_phone_email_name_or_address := if(((Real)new_phone_email_name_or_address in [-99999, -99998, NULL]), 0.5602587249, (Real)new_phone_email_name_or_address);

phone_v001 := (psmartidperphoneintxinqcnt - 2.2149746185) / 2.9856492492;

phone_v002 := (psmartidperphoneintxinqcnt1y - 1.4017558981) / 1.8697045356;

phone_v003 := (psmartidperphoneintxinqcnt6m - 0.9065552872) / 1.3407744088;

phone_v004 := (psmartidperphoneintxinqcnt3m - 0.6108119800) / 1.0185320359;

phone_v005 := (psmartidperphoneintxinqcnt1m - 0.3131384302) / 0.6581454220;

phone_v006 := (pexactidperphoneintxinqcnt - 2.2472447344) / 3.2159186430;

phone_v007 := (pexactidperphoneintxinqcnt1y - 1.4235424047) / 2.0439804297;

phone_v008 := (pexactidperphoneintxinqcnt6m - 0.9147088414) / 1.4593984168;

phone_v009 := (pexactidperphoneintxinqcnt3m - 0.6173236810) / 1.1050253996;

phone_v010 := (pexactidperphoneintxinqcnt1m - 0.3168809378) / 0.6978469967;

phone_v011 := (pemailperphoneintxinqcnt - 1.0284325710) / 1.3850633965;

phone_v012 := (pemailperphoneintxinqcnt1y - 0.7987304313) / 1.1593076752;

phone_v013 := (pemailperphoneintxinqcnt1m - 0.2631815247) / 0.5691741509;

phone_v014 := (pemailperphoneintxinqcnt3m - 0.4499005384) / 0.7932973464;

phone_v015 := (pemailperphoneintxinqcnt6m - 0.6024847367) / 0.9546396873;

phone_v016 := (ptmxidperphoneintxinqcnt - 1.2262054184) / 1.3553857766;

phone_v017 := (ptmxidperphoneintxinqcnt1y - 1.1015196154) / 1.2744245681;

phone_v018 := (ptmxidperphoneintxinqcnt6m - 0.7749612477) / 1.0091756508;

phone_v019 := (ptmxidperphoneintxinqcnt3m - 0.5524459024) / 0.8411428999;

phone_v020 := (ptmxidperphoneintxinqcnt1m - 0.3054141829) / 0.6077968376;

phone_v021 := (ptrueipperphoneintxinqcnt - 2.2518393016) / 3.6042756930;

phone_v022 := (pbrowserhashperphoneintxinqcnt - 2.4100241526) / 3.4849964704;

phone_v023 := (ploginidperphoneintxinqcnt - 0.5526818574) / 0.8135329533;

phone_v024 := (ptxinqcorremailwphonenamecnt - 0.2756935666) / 1.5578540855;

phone_v025 := (ptxinqcorremailwphonenamecnt1y - 0.2391247385) / 1.3368191697;

phone_v026 := (ptxinqcorremailwphonenamecnt6m - 0.1818465994) / 1.1084513536;

phone_v027 := (ptxinqcorremailwphonenamecnt3m - 0.1234697865) / 0.9017687750;

phone_v028 := (ptxinqcorremailwphonenamecnt1m - 0.0723377847) / 0.5691503261;

phone_v029 := (ptxinqcorremailwpflacnt - 0.0325459438) / 0.5655449389;

phone_v030 := (ptxinqcorremailwpflacnt1y - 0.0263185132) / 0.4705905418;

phone_v031 := (ptxinqcorremailwpflacnt6m - 0.0162557214) / 0.3430500208;

phone_v032 := (ptxinqcorremailwpflacnt3m - 0.0104193022) / 0.2688213837;

phone_v033 := (ptxinqcorremailwpflacnt1m - 0.0055719116) / 0.1705369650;

phone_v034 := (ptxinqcorremailwphonecnt - 3.2523151745) / 7.4705109561;

phone_v035 := (ptxinqcorremailwphonecnt1y - 2.0933440767) / 5.7377349531;

phone_v036 := (ptxinqcorremailwphonecnt6m - 1.3791321754) / 4.4672416403;

phone_v037 := (ptxinqcorremailwphonecnt3m - 0.9043181662) / 3.3423392747;

phone_v038 := (ptxinqcorremailwphonecnt1m - 0.4222162805) / 1.9481503125;

phone_v039 := (ptxinqwphonecnt - 5.3909347421) / 10.7866973511;

phone_v040 := (ptxinqwphonecnt1y - 3.4722343295) / 8.0150462248;

phone_v041 := (ptxinqwphonecnt6m - 2.2676056800) / 6.1954056354;

phone_v042 := (ptxinqcorrnamewphonecnt - 0.3727665961) / 1.9165070432;

phone_v043 := (ptxinqcorrnamewphonecnt1y - 0.3243800433) / 1.6458039006;

phone_v044 := (ptxinqcorrnamewphonecnt6m - 0.2468274914) / 1.3588644284;

phone_v045 := (ptxinqcorrnamewphonecnt3m - 0.1660750272) / 1.1096067010;

phone_v046 := (ptxinqcorrnamewphonecnt1m - 0.0975361940) / 0.7361480437;

phone_v047 := (ptxinqwphonefinstatusrejcnt - 0.0131282710) / 0.4045480139;

phone_v048 := (ptxinqwphonefinstatusrejcnt1m - 0.0015566472) / 0.1364039562;

phone_v049 := (ptxinqwphonefinstatusacccnt - 0.0094775237) / 0.2157377106;

phone_v050 := (ptxinqwphonefinstatusacccnt1m - 0.0024414783) / 0.0851762204;

phone_v051 := (pdistbtwtrueipwphoneavg - 380.9858796373) / 521.6489087053;

phone_v052 := (ptimebtwtxinqwphoneavg - 116163.1221109055) / 84884.2321680107;

phone_v053 := (pruleexactidblistintxinqwpflag1m - 0.0003211609) / 0.0157392006;

phone_v054 := (pruleexactidblistintxinqwpflag1y - 0.0010683516) / 0.0286956503;

phone_v055 := (prulesmartidblistintxinqwpflag1m - 0.0003998125) / 0.0175603216;

phone_v056 := (prulesmartidblistintxinqwpflag1y - 0.0006783705) / 0.0228705812;

phone_v057 := (ptxinqwphonefirst_dayssince - 281.7897018775) / 260.7925511282;

phone_v058 := (ptxinqwphonelast_dayssince - 149.0212336947) / 125.5509855785;

phone_v059 := (pnew_phone - 0.2284197857) / 0.4198149983;

phone_v060 := (pnew_phone_or_email - 0.3001861039) / 0.4583393264;

phone_v061 := (pnew_phone_or_name - 0.4002346527) / 0.4899464078;

phone_v062 := (pnew_phone_email_or_name - 0.4499441183) / 0.4974887280;

phone_v063 := (pnew_phone_email_name_or_address - 0.5602587249) / 0.4963562320;

phone_pc001 := phone_v001 * 0.1808918171 +
    phone_v002 * 0.2058016315 +
    phone_v003 * 0.2112783217 +
    phone_v004 * 0.2044540815 +
    phone_v005 * 0.1768376560 +
    phone_v006 * 0.1800067634 +
    phone_v007 * 0.2024822989 +
    phone_v008 * 0.2075629390 +
    phone_v009 * 0.2006958113 +
    phone_v010 * 0.1752192977 +
    phone_v011 * 0.1394625377 +
    phone_v012 * 0.1532533804 +
    phone_v013 * 0.1601182897 +
    phone_v014 * 0.1699960780 +
    phone_v015 * 0.1654828339 +
    phone_v016 * 0.1891702707 +
    phone_v017 * 0.1934196714 +
    phone_v018 * 0.1992948306 +
    phone_v019 * 0.1940070857 +
    phone_v020 * 0.1703748195 +
    phone_v021 * 0.1664960429 +
    phone_v022 * 0.1682135873 +
    phone_v023 * 0.1315745486 +
    phone_v024 * 0.0673672343 +
    phone_v025 * 0.0717803316 +
    phone_v026 * 0.0714160144 +
    phone_v027 * 0.0659884685 +
    phone_v028 * 0.0592595275 +
    phone_v029 * 0.0252456796 +
    phone_v030 * 0.0271943869 +
    phone_v031 * 0.0271445255 +
    phone_v032 * 0.0248021044 +
    phone_v033 * 0.0210214555 +
    phone_v034 * 0.1304736199 +
    phone_v035 * 0.1308942444 +
    phone_v036 * 0.1265808850 +
    phone_v037 * 0.1174056292 +
    phone_v038 * 0.0963068291 +
    phone_v039 * 0.1695037474 +
    phone_v040 * 0.1715005031 +
    phone_v041 * 0.1644643562 +
    phone_v042 * 0.0746533295 +
    phone_v043 * 0.0794812351 +
    phone_v044 * 0.0784515937 +
    phone_v045 * 0.0715406966 +
    phone_v046 * 0.0622079606 +
    phone_v047 * 0.0218614796 +
    phone_v048 * 0.0092793028 +
    phone_v049 * 0.0398919732 +
    phone_v050 * 0.0505701685 +
    phone_v051 * -0.0000868978 +
    phone_v052 * -0.0442783382 +
    phone_v053 * 0.0108038386 +
    phone_v054 * 0.0154066907 +
    phone_v055 * 0.0200473745 +
    phone_v056 * 0.0167433661 +
    phone_v057 * 0.1044607548 +
    phone_v058 * -0.1094612081 +
    phone_v059 * 0.0004779652 +
    phone_v060 * 0.0003147567 +
    phone_v061 * 0.0031284170 +
    phone_v062 * 0.0025906165 +
    phone_v063 * 0.0082624850;

phone_pc002 := phone_v001 * 0.0680771316 +
    phone_v002 * 0.0651328597 +
    phone_v003 * 0.0588466952 +
    phone_v004 * 0.0551313854 +
    phone_v005 * 0.0387315838 +
    phone_v006 * 0.0675553087 +
    phone_v007 * 0.0634832825 +
    phone_v008 * 0.0560070911 +
    phone_v009 * 0.0512343729 +
    phone_v010 * 0.0353086314 +
    phone_v011 * 0.0818699734 +
    phone_v012 * 0.0840663735 +
    phone_v013 * 0.0584632636 +
    phone_v014 * 0.0770689365 +
    phone_v015 * 0.0820767951 +
    phone_v016 * 0.0781529801 +
    phone_v017 * 0.0777571135 +
    phone_v018 * 0.0715966418 +
    phone_v019 * 0.0657297545 +
    phone_v020 * 0.0485559379 +
    phone_v021 * 0.0099906013 +
    phone_v022 * 0.0577444480 +
    phone_v023 * 0.0629393474 +
    phone_v024 * -0.2665849572 +
    phone_v025 * -0.2882770505 +
    phone_v026 * -0.2957265521 +
    phone_v027 * -0.2872519250 +
    phone_v028 * -0.2556207836 +
    phone_v029 * -0.1492699278 +
    phone_v030 * -0.1622944990 +
    phone_v031 * -0.1704831624 +
    phone_v032 * -0.1619674569 +
    phone_v033 * -0.1402080729 +
    phone_v034 * -0.0486604407 +
    phone_v035 * -0.0698627624 +
    phone_v036 * -0.0818270813 +
    phone_v037 * -0.0884747988 +
    phone_v038 * -0.0872356793 +
    phone_v039 * 0.0026865541 +
    phone_v040 * -0.0191381658 +
    phone_v041 * -0.0331588426 +
    phone_v042 * -0.2548322108 +
    phone_v043 * -0.2756588690 +
    phone_v044 * -0.2850417860 +
    phone_v045 * -0.2773337599 +
    phone_v046 * -0.2418786667 +
    phone_v047 * 0.0122370755 +
    phone_v048 * 0.0047367023 +
    phone_v049 * 0.0242609727 +
    phone_v050 * 0.0317923396 +
    phone_v051 * 0.0096983601 +
    phone_v052 * 0.0081243497 +
    phone_v053 * 0.0028708763 +
    phone_v054 * 0.0074936865 +
    phone_v055 * -0.0032899537 +
    phone_v056 * 0.0085057317 +
    phone_v057 * 0.0453489116 +
    phone_v058 * -0.0252513861 +
    phone_v059 * 0.0004117329 +
    phone_v060 * 0.0007013428 +
    phone_v061 * 0.0026673140 +
    phone_v062 * 0.0024980041 +
    phone_v063 * -0.0020788838;

phone_pc003 := phone_v001 * -0.0819451334 +
    phone_v002 * -0.0248604238 +
    phone_v003 * 0.0277452096 +
    phone_v004 * 0.0732306227 +
    phone_v005 * 0.1174523596 +
    phone_v006 * -0.0892776974 +
    phone_v007 * -0.0382701569 +
    phone_v008 * 0.0115892110 +
    phone_v009 * 0.0566693291 +
    phone_v010 * 0.1052186651 +
    phone_v011 * 0.1181697749 +
    phone_v012 * 0.1574502483 +
    phone_v013 * 0.1862361485 +
    phone_v014 * 0.1949162239 +
    phone_v015 * 0.1843461212 +
    phone_v016 * 0.0845067570 +
    phone_v017 * 0.0958387194 +
    phone_v018 * 0.1326359674 +
    phone_v019 * 0.1547468510 +
    phone_v020 * 0.1629948644 +
    phone_v021 * -0.1576565063 +
    phone_v022 * -0.1250437332 +
    phone_v023 * -0.0289837004 +
    phone_v024 * 0.0332964259 +
    phone_v025 * 0.0429942620 +
    phone_v026 * 0.0539404231 +
    phone_v027 * 0.0629221721 +
    phone_v028 * 0.0708567999 +
    phone_v029 * 0.0528214650 +
    phone_v030 * 0.0602770990 +
    phone_v031 * 0.0700050696 +
    phone_v032 * 0.0715579676 +
    phone_v033 * 0.0666790132 +
    phone_v034 * -0.3121785999 +
    phone_v035 * -0.3175251388 +
    phone_v036 * -0.3044576061 +
    phone_v037 * -0.2712537779 +
    phone_v038 * -0.2001990552 +
    phone_v039 * -0.2370493266 +
    phone_v040 * -0.2265320127 +
    phone_v041 * -0.2040476152 +
    phone_v042 * 0.0466268849 +
    phone_v043 * 0.0582562373 +
    phone_v044 * 0.0708148627 +
    phone_v045 * 0.0802137134 +
    phone_v046 * 0.0857364098 +
    phone_v047 * -0.0000996204 +
    phone_v048 * 0.0082792208 +
    phone_v049 * 0.0851403658 +
    phone_v050 * 0.1310867557 +
    phone_v051 * 0.0257567800 +
    phone_v052 * 0.0834788301 +
    phone_v053 * 0.0083945110 +
    phone_v054 * 0.0051254237 +
    phone_v055 * -0.0393343239 +
    phone_v056 * 0.0009869580 +
    phone_v057 * -0.1185582580 +
    phone_v058 * -0.0879768287 +
    phone_v059 * -0.0337712441 +
    phone_v060 * -0.0391086174 +
    phone_v061 * -0.0437993485 +
    phone_v062 * -0.0473300102 +
    phone_v063 * -0.0377667821;

phone_distance_001 := sqrt(Power((phone_pc001 - 6.6042596152),2) +
    power((phone_pc002 - 1.0075061720), 2) +
    power((phone_pc003 - 0.5650149616), 2));

phone_distance_002 := sqrt(Power((phone_pc001 - 92.2051695737),2) +
    power((phone_pc002 - 32.6775713306), 2) +
    power((phone_pc003 - 43.6256580712), 2));

phone_distance_003 := sqrt(power((phone_pc001 - 0.4176519498),2) +
    power((phone_pc002 - 0.1823310108), 2) +
    power((phone_pc003 - 0.2064414403), 2));

phone_distance_004 := sqrt(power((phone_pc001 - -2.8610284226),2) +
    power((phone_pc002 - -0.3664932062), 2) +
    power((phone_pc003 - -0.1267006401), 2));

phone_distance_005 := sqrt(power((phone_pc001 - 39.5247918778),2) +
    power((phone_pc002 - -103.9378015761), 2) +
    power((phone_pc003 - 9.7380785328), 2));

phone_distance_006 := sqrt(power((phone_pc001 - 17.9921387182),2) +
    power((phone_pc002 - -0.0364598649), 2) +
    power((phone_pc003 - -7.8548211399), 2));

phone_mindist := if(max(phone_distance_001, phone_distance_002, phone_distance_003, phone_distance_004, phone_distance_005, phone_distance_006) = NULL, NULL, min(if(phone_distance_001 = NULL, -NULL, phone_distance_001), if(phone_distance_002 = NULL, -NULL, phone_distance_002), if(phone_distance_003 = NULL, -NULL, phone_distance_003), if(phone_distance_004 = NULL, -NULL, phone_distance_004), if(phone_distance_005 = NULL, -NULL, phone_distance_005), if(phone_distance_006 = NULL, -NULL, phone_distance_006)));

phone_cluster := map(
    phone_distance_001 = phone_mindist => 1,
    phone_distance_002 = phone_mindist => 2,
    phone_distance_003 = phone_mindist => 3,
    phone_distance_004 = phone_mindist => 4,
    phone_distance_005 = phone_mindist => 5,
                                          6);

iid1906_0_0_phoneriskindex := map(
    TxinqWPhoneCnt = -99999                                                                                                                                  => 0,
    TxinqWPhoneCnt = -99998                                                                                                                                  => 1,
    RuleExactidBlistInTxinqWPFlag1M = 1 or RuleExactidBlistInTxinqWPFlag1Y = 1 or RuleSmartidBlistInTxinqWPFlag1M = 1 or RuleSmartidBlistInTxinqWPFlag1Y = 1 => 4,
    TxinqWPhoneFinStatusRejCnt > 0                                                                                                                           => 4,
    txinqwphonefirst_dayssince <= 30 and TxinqWPhoneCnt6M > 5                                                                                                => 4,
    txinqwphonefirst_dayssince <= 90 and TxinqWPhoneCnt6M > 10                                                                                               => 4,
    phone_cluster = 2                                                                                                                                        => 4,
    (phone_cluster in [5, 6])                                                                                                                                => 3,
    phone_cluster = 1 and TmxidPerPhoneInTxinqCnt6M > 2                                                                                                      => 3,
                                                                                                                                                                2);

iid1906_0_0_phonehighriskind := if(iid1906_0_0_phoneriskindex = 4, 'PR', '');
//***************
//  End Generated ECL Code
//***************

     #if(IID_DEBUG)
/* Model Input Variables */

/* Finish up the TRANSFORM by populating the results */
                    self.seq                              :=le.seq;
                    self.sysdate                          := sysdate;
                    self.txinqwemailfirst_dayssince       := txinqwemailfirst_dayssince;
                    self.txinqwemaillast_dayssince        := txinqwemaillast_dayssince;
                    self.txinqwphonefirst_dayssince       := txinqwphonefirst_dayssince;
                    self.txinqwphonelast_dayssince        := txinqwphonelast_dayssince;
                    self.new_email                        := new_email;
                    self.new_email_or_phone               := new_email_or_phone;
                    self.new_email_or_name                := new_email_or_name;
                    self.new_email_or_address             := new_email_or_address;
                    self.new_email_phone_or_name          := new_email_phone_or_name;
                    self.new_email_phone_name_or_address  := new_email_phone_name_or_address;
                    self.esmartidperemailintxinqcnt       := esmartidperemailintxinqcnt;
                    self.esmartidperemailintxinqcnt1y     := esmartidperemailintxinqcnt1y;
                    self.esmartidperemailintxinqcnt6m     := esmartidperemailintxinqcnt6m;
                    self.esmartidperemailintxinqcnt3m     := esmartidperemailintxinqcnt3m;
                    self.esmartidperemailintxinqcnt1m     := esmartidperemailintxinqcnt1m;
                    self.eexactidperemailintxinqcnt       := eexactidperemailintxinqcnt;
                    self.eexactidperemailintxinqcnt1y     := eexactidperemailintxinqcnt1y;
                    self.eexactidperemailintxinqcnt6m     := eexactidperemailintxinqcnt6m;
                    self.eexactidperemailintxinqcnt3m     := eexactidperemailintxinqcnt3m;
                    self.eexactidperemailintxinqcnt1m     := eexactidperemailintxinqcnt1m;
                    self.ephoneperemailintxinqcnt1y       := ephoneperemailintxinqcnt1y;
                    self.ephoneperemailintxinqcnt1m       := ephoneperemailintxinqcnt1m;
                    self.ephoneperemailintxinqcnt3m       := ephoneperemailintxinqcnt3m;
                    self.etmxidperemailintxinqcnt         := etmxidperemailintxinqcnt;
                    self.etmxidperemailintxinqcnt1y       := etmxidperemailintxinqcnt1y;
                    self.etmxidperemailintxinqcnt6m       := etmxidperemailintxinqcnt6m;
                    self.etmxidperemailintxinqcnt3m       := etmxidperemailintxinqcnt3m;
                    self.etmxidperemailintxinqcnt1m       := etmxidperemailintxinqcnt1m;
                    self.eorgidperemailintxinqcnt         := eorgidperemailintxinqcnt;
                    self.etrueipperemailintxinqcnt        := etrueipperemailintxinqcnt;
                    self.etrueipgperemailintxinqcnt       := etrueipgperemailintxinqcnt;
                    self.ednsipperemailintxinqcnt         := ednsipperemailintxinqcnt;
                    self.ednsipgperemailintxinqcnt        := ednsipgperemailintxinqcnt;
                    self.eproxyipperemailintxinqcnt       := eproxyipperemailintxinqcnt;
                    self.eproxyipgperemailintxinqcnt      := eproxyipgperemailintxinqcnt;
                    self.ebrowserperemailintxinqcnt       := ebrowserperemailintxinqcnt;
                    self.ebrowserhashperemailintxinqcnt   := ebrowserhashperemailintxinqcnt;
                    self.escreenresperemailintxinqcnt     := escreenresperemailintxinqcnt;
                    self.etimezoneperemailintxinqcnt      := etimezoneperemailintxinqcnt;
                    self.ecurrencyperemailintxinqcnt      := ecurrencyperemailintxinqcnt;
                    self.eachperemailintxinqcnt           := eachperemailintxinqcnt;
                    self.eagentpubkeyperemailintxinqcnt   := eagentpubkeyperemailintxinqcnt;
                    self.eccardperemailintxinqcnt         := eccardperemailintxinqcnt;
                    self.etxinqcorremailwphonenamecnt     := etxinqcorremailwphonenamecnt;
                    self.etxinqcorremailwphonenamecnt1y   := etxinqcorremailwphonenamecnt1y;
                    self.etxinqcorremailwphonenamecnt6m   := etxinqcorremailwphonenamecnt6m;
                    self.etxinqcorremailwphonenamecnt3m   := etxinqcorremailwphonenamecnt3m;
                    self.etxinqcorremailwphonenamecnt1m   := etxinqcorremailwphonenamecnt1m;
                    self.etxinqcorremailwpflacnt          := etxinqcorremailwpflacnt;
                    self.etxinqcorremailwpflacnt1y        := etxinqcorremailwpflacnt1y;
                    self.etxinqcorremailwpflacnt6m        := etxinqcorremailwpflacnt6m;
                    self.etxinqcorremailwpflacnt3m        := etxinqcorremailwpflacnt3m;
                    self.etxinqcorremailwpflacnt1m        := etxinqcorremailwpflacnt1m;
                    self.etxinqcorremailwphonecnt         := etxinqcorremailwphonecnt;
                    self.etxinqcorremailwphonecnt1y       := etxinqcorremailwphonecnt1y;
                    self.etxinqcorremailwphonecnt6m       := etxinqcorremailwphonecnt6m;
                    self.etxinqcorremailwphonecnt3m       := etxinqcorremailwphonecnt3m;
                    self.etxinqcorremailwphonecnt1m       := etxinqcorremailwphonecnt1m;
                    self.etxinqwemailcnt1y                := etxinqwemailcnt1y;
                    self.etxinqwemailcnt6m                := etxinqwemailcnt6m;
                    self.etxinqcorremailwaddresscnt       := etxinqcorremailwaddresscnt;
                    self.etxinqcorremailwaddresscnt1y     := etxinqcorremailwaddresscnt1y;
                    self.etxinqcorremailwaddresscnt6m     := etxinqcorremailwaddresscnt6m;
                    self.etxinqcorremailwaddresscnt3m     := etxinqcorremailwaddresscnt3m;
                    self.etxinqcorremailwaddresscnt1m     := etxinqcorremailwaddresscnt1m;
                    self.etxinqcorremailwnamecnt          := etxinqcorremailwnamecnt;
                    self.etxinqcorremailwnamecnt1y        := etxinqcorremailwnamecnt1y;
                    self.etxinqcorremailwnamecnt6m        := etxinqcorremailwnamecnt6m;
                    self.etxinqcorremailwnamecnt3m        := etxinqcorremailwnamecnt3m;
                    self.etxinqcorremailwnamecnt1m        := etxinqcorremailwnamecnt1m;
                    self.etxinqwemailfinstatusrejcnt      := etxinqwemailfinstatusrejcnt;
                    self.etxinqwemailfinstatusrejcnt1m    := etxinqwemailfinstatusrejcnt1m;
                    self.etxinqwemailfinstatusacccnt      := etxinqwemailfinstatusacccnt;
                    self.etxinqwemailfinstatusacccnt1m    := etxinqwemailfinstatusacccnt1m;
                    self.edistbtwtrueipwemailavg          := edistbtwtrueipwemailavg;
                    self.etimebtwtxinqwemailavg           := etimebtwtxinqwemailavg;
                    self.eruleemailtrustedbyuserflag1m    := eruleemailtrustedbyuserflag1m;
                    self.eruleemailtrustedbyuserflag3m    := eruleemailtrustedbyuserflag3m;
                    self.eruleemailtrustedbyuserflag6m    := eruleemailtrustedbyuserflag6m;
                    self.eruleemailtrustedbyuserflag1y    := eruleemailtrustedbyuserflag1y;
                    self.eruleemailblistflag              := eruleemailblistflag;
                    self.eruleemailblistbybankflag        := eruleemailblistbybankflag;
                    self.eruleemailblistbyfintechflag     := eruleemailblistbyfintechflag;
                    self.eruleemailblistbyecommflag       := eruleemailblistbyecommflag;
                    self.eruleexactidblistintxinqweflag1m := eruleexactidblistintxinqweflag1m;
                    self.eruleexactidblistintxinqweflag   := eruleexactidblistintxinqweflag;
                    self.erulesmartidblistintxinqweflag1m := erulesmartidblistintxinqweflag1m;
                    self.erulesmartidblistintxinqweflag   := erulesmartidblistintxinqweflag;
                    self.eruleemailhighriskdomainflag     := eruleemailhighriskdomainflag;
                    self.eruleemailaliasflag              := eruleemailaliasflag;
                    self.eruleemailmachinegeneratedflag   := eruleemailmachinegeneratedflag;
                    self.etxinqwemailfirst_dayssince      := etxinqwemailfirst_dayssince;
                    self.etxinqwemaillast_dayssince       := etxinqwemaillast_dayssince;
                    self.enew_email                       := enew_email;
                    self.enew_email_or_phone              := enew_email_or_phone;
                    self.enew_email_or_name               := enew_email_or_name;
                    self.enew_email_or_address            := enew_email_or_address;
                    self.enew_email_phone_or_name         := enew_email_phone_or_name;
                    self.enew_email_phone_name_or_address := enew_email_phone_name_or_address;
                    self.email_v001                       := email_v001;
                    self.email_v002                       := email_v002;
                    self.email_v003                       := email_v003;
                    self.email_v004                       := email_v004;
                    self.email_v005                       := email_v005;
                    self.email_v006                       := email_v006;
                    self.email_v007                       := email_v007;
                    self.email_v008                       := email_v008;
                    self.email_v009                       := email_v009;
                    self.email_v010                       := email_v010;
                    self.email_v011                       := email_v011;
                    self.email_v012                       := email_v012;
                    self.email_v013                       := email_v013;
                    self.email_v014                       := email_v014;
                    self.email_v015                       := email_v015;
                    self.email_v016                       := email_v016;
                    self.email_v017                       := email_v017;
                    self.email_v018                       := email_v018;
                    self.email_v019                       := email_v019;
                    self.email_v020                       := email_v020;
                    self.email_v021                       := email_v021;
                    self.email_v022                       := email_v022;
                    self.email_v023                       := email_v023;
                    self.email_v024                       := email_v024;
                    self.email_v025                       := email_v025;
                    self.email_v026                       := email_v026;
                    self.email_v027                       := email_v027;
                    self.email_v028                       := email_v028;
                    self.email_v029                       := email_v029;
                    self.email_v030                       := email_v030;
                    self.email_v031                       := email_v031;
                    self.email_v032                       := email_v032;
                    self.email_v033                       := email_v033;
                    self.email_v034                       := email_v034;
                    self.email_v035                       := email_v035;
                    self.email_v036                       := email_v036;
                    self.email_v037                       := email_v037;
                    self.email_v038                       := email_v038;
                    self.email_v039                       := email_v039;
                    self.email_v040                       := email_v040;
                    self.email_v041                       := email_v041;
                    self.email_v042                       := email_v042;
                    self.email_v043                       := email_v043;
                    self.email_v044                       := email_v044;
                    self.email_v045                       := email_v045;
                    self.email_v046                       := email_v046;
                    self.email_v047                       := email_v047;
                    self.email_v048                       := email_v048;
                    self.email_v049                       := email_v049;
                    self.email_v050                       := email_v050;
                    self.email_v051                       := email_v051;
                    self.email_v052                       := email_v052;
                    self.email_v053                       := email_v053;
                    self.email_v054                       := email_v054;
                    self.email_v055                       := email_v055;
                    self.email_v056                       := email_v056;
                    self.email_v057                       := email_v057;
                    self.email_v058                       := email_v058;
                    self.email_v059                       := email_v059;
                    self.email_v060                       := email_v060;
                    self.email_v061                       := email_v061;
                    self.email_v062                       := email_v062;
                    self.email_v063                       := email_v063;
                    self.email_v064                       := email_v064;
                    self.email_v065                       := email_v065;
                    self.email_v066                       := email_v066;
                    self.email_v067                       := email_v067;
                    self.email_v068                       := email_v068;
                    self.email_v069                       := email_v069;
                    self.email_v070                       := email_v070;
                    self.email_v071                       := email_v071;
                    self.email_v072                       := email_v072;
                    self.email_v073                       := email_v073;
                    self.email_v074                       := email_v074;
                    self.email_v075                       := email_v075;
                    self.email_v076                       := email_v076;
                    self.email_v077                       := email_v077;
                    self.email_v078                       := email_v078;
                    self.email_v079                       := email_v079;
                    self.email_v080                       := email_v080;
                    self.email_v081                       := email_v081;
                    self.email_v082                       := email_v082;
                    self.email_v083                       := email_v083;
                    self.email_v084                       := email_v084;
                    self.email_v085                       := email_v085;
                    self.email_v086                       := email_v086;
                    self.email_v087                       := email_v087;
                    self.email_v088                       := email_v088;
                    self.email_v089                       := email_v089;
                    self.email_pc001                      := email_pc001;
                    self.email_pc002                      := email_pc002;
                    self.email_pc003                      := email_pc003;
                    self.email_distance_001               := email_distance_001;
                    self.email_distance_002               := email_distance_002;
                    self.email_distance_003               := email_distance_003;
                    self.email_distance_004               := email_distance_004;
                    self.email_distance_005               := email_distance_005;
                    self.email_mindist                    := email_mindist;
                    self.email_cluster                    := email_cluster;
                    self.new_phone                        := new_phone;
                    self.new_phone_or_email               := new_phone_or_email;
                    self.new_phone_or_name                := new_phone_or_name;
                    self.new_phone_email_or_name          := new_phone_email_or_name;
                    self.new_phone_email_name_or_address  := new_phone_email_name_or_address;
                    self.psmartidperphoneintxinqcnt       := psmartidperphoneintxinqcnt;
                    self.psmartidperphoneintxinqcnt1y     := psmartidperphoneintxinqcnt1y;
                    self.psmartidperphoneintxinqcnt6m     := psmartidperphoneintxinqcnt6m;
                    self.psmartidperphoneintxinqcnt3m     := psmartidperphoneintxinqcnt3m;
                    self.psmartidperphoneintxinqcnt1m     := psmartidperphoneintxinqcnt1m;
                    self.pexactidperphoneintxinqcnt       := pexactidperphoneintxinqcnt;
                    self.pexactidperphoneintxinqcnt1y     := pexactidperphoneintxinqcnt1y;
                    self.pexactidperphoneintxinqcnt6m     := pexactidperphoneintxinqcnt6m;
                    self.pexactidperphoneintxinqcnt3m     := pexactidperphoneintxinqcnt3m;
                    self.pexactidperphoneintxinqcnt1m     := pexactidperphoneintxinqcnt1m;
                    self.pemailperphoneintxinqcnt         := pemailperphoneintxinqcnt;
                    self.pemailperphoneintxinqcnt1y       := pemailperphoneintxinqcnt1y;
                    self.pemailperphoneintxinqcnt1m       := pemailperphoneintxinqcnt1m;
                    self.pemailperphoneintxinqcnt3m       := pemailperphoneintxinqcnt3m;
                    self.pemailperphoneintxinqcnt6m       := pemailperphoneintxinqcnt6m;
                    self.ptmxidperphoneintxinqcnt         := ptmxidperphoneintxinqcnt;
                    self.ptmxidperphoneintxinqcnt1y       := ptmxidperphoneintxinqcnt1y;
                    self.ptmxidperphoneintxinqcnt6m       := ptmxidperphoneintxinqcnt6m;
                    self.ptmxidperphoneintxinqcnt3m       := ptmxidperphoneintxinqcnt3m;
                    self.ptmxidperphoneintxinqcnt1m       := ptmxidperphoneintxinqcnt1m;
                    self.ptrueipperphoneintxinqcnt        := ptrueipperphoneintxinqcnt;
                    self.pbrowserhashperphoneintxinqcnt   := pbrowserhashperphoneintxinqcnt;
                    self.ploginidperphoneintxinqcnt       := ploginidperphoneintxinqcnt;
                    self.ptxinqcorremailwphonenamecnt     := ptxinqcorremailwphonenamecnt;
                    self.ptxinqcorremailwphonenamecnt1y   := ptxinqcorremailwphonenamecnt1y;
                    self.ptxinqcorremailwphonenamecnt6m   := ptxinqcorremailwphonenamecnt6m;
                    self.ptxinqcorremailwphonenamecnt3m   := ptxinqcorremailwphonenamecnt3m;
                    self.ptxinqcorremailwphonenamecnt1m   := ptxinqcorremailwphonenamecnt1m;
                    self.ptxinqcorremailwpflacnt          := ptxinqcorremailwpflacnt;
                    self.ptxinqcorremailwpflacnt1y        := ptxinqcorremailwpflacnt1y;
                    self.ptxinqcorremailwpflacnt6m        := ptxinqcorremailwpflacnt6m;
                    self.ptxinqcorremailwpflacnt3m        := ptxinqcorremailwpflacnt3m;
                    self.ptxinqcorremailwpflacnt1m        := ptxinqcorremailwpflacnt1m;
                    self.ptxinqcorremailwphonecnt         := ptxinqcorremailwphonecnt;
                    self.ptxinqcorremailwphonecnt1y       := ptxinqcorremailwphonecnt1y;
                    self.ptxinqcorremailwphonecnt6m       := ptxinqcorremailwphonecnt6m;
                    self.ptxinqcorremailwphonecnt3m       := ptxinqcorremailwphonecnt3m;
                    self.ptxinqcorremailwphonecnt1m       := ptxinqcorremailwphonecnt1m;
                    self.ptxinqwphonecnt                  := ptxinqwphonecnt;
                    self.ptxinqwphonecnt1y                := ptxinqwphonecnt1y;
                    self.ptxinqwphonecnt6m                := ptxinqwphonecnt6m;
                    self.ptxinqcorrnamewphonecnt          := ptxinqcorrnamewphonecnt;
                    self.ptxinqcorrnamewphonecnt1y        := ptxinqcorrnamewphonecnt1y;
                    self.ptxinqcorrnamewphonecnt6m        := ptxinqcorrnamewphonecnt6m;
                    self.ptxinqcorrnamewphonecnt3m        := ptxinqcorrnamewphonecnt3m;
                    self.ptxinqcorrnamewphonecnt1m        := ptxinqcorrnamewphonecnt1m;
                    self.ptxinqwphonefinstatusrejcnt      := ptxinqwphonefinstatusrejcnt;
                    self.ptxinqwphonefinstatusrejcnt1m    := ptxinqwphonefinstatusrejcnt1m;
                    self.ptxinqwphonefinstatusacccnt      := ptxinqwphonefinstatusacccnt;
                    self.ptxinqwphonefinstatusacccnt1m    := ptxinqwphonefinstatusacccnt1m;
                    self.pdistbtwtrueipwphoneavg          := pdistbtwtrueipwphoneavg;
                    self.ptimebtwtxinqwphoneavg           := ptimebtwtxinqwphoneavg;
                    self.pruleexactidblistintxinqwpflag1m := pruleexactidblistintxinqwpflag1m;
                    self.pruleexactidblistintxinqwpflag1y := pruleexactidblistintxinqwpflag1y;
                    self.prulesmartidblistintxinqwpflag1m := prulesmartidblistintxinqwpflag1m;
                    self.prulesmartidblistintxinqwpflag1y := prulesmartidblistintxinqwpflag1y;
                    self.ptxinqwphonefirst_dayssince      := ptxinqwphonefirst_dayssince;
                    self.ptxinqwphonelast_dayssince       := ptxinqwphonelast_dayssince;
                    self.pnew_phone                       := pnew_phone;
                    self.pnew_phone_or_email              := pnew_phone_or_email;
                    self.pnew_phone_or_name               := pnew_phone_or_name;
                    self.pnew_phone_email_or_name         := pnew_phone_email_or_name;
                    self.pnew_phone_email_name_or_address := pnew_phone_email_name_or_address;
                    self.phone_v001                       := phone_v001;
                    self.phone_v002                       := phone_v002;
                    self.phone_v003                       := phone_v003;
                    self.phone_v004                       := phone_v004;
                    self.phone_v005                       := phone_v005;
                    self.phone_v006                       := phone_v006;
                    self.phone_v007                       := phone_v007;
                    self.phone_v008                       := phone_v008;
                    self.phone_v009                       := phone_v009;
                    self.phone_v010                       := phone_v010;
                    self.phone_v011                       := phone_v011;
                    self.phone_v012                       := phone_v012;
                    self.phone_v013                       := phone_v013;
                    self.phone_v014                       := phone_v014;
                    self.phone_v015                       := phone_v015;
                    self.phone_v016                       := phone_v016;
                    self.phone_v017                       := phone_v017;
                    self.phone_v018                       := phone_v018;
                    self.phone_v019                       := phone_v019;
                    self.phone_v020                       := phone_v020;
                    self.phone_v021                       := phone_v021;
                    self.phone_v022                       := phone_v022;
                    self.phone_v023                       := phone_v023;
                    self.phone_v024                       := phone_v024;
                    self.phone_v025                       := phone_v025;
                    self.phone_v026                       := phone_v026;
                    self.phone_v027                       := phone_v027;
                    self.phone_v028                       := phone_v028;
                    self.phone_v029                       := phone_v029;
                    self.phone_v030                       := phone_v030;
                    self.phone_v031                       := phone_v031;
                    self.phone_v032                       := phone_v032;
                    self.phone_v033                       := phone_v033;
                    self.phone_v034                       := phone_v034;
                    self.phone_v035                       := phone_v035;
                    self.phone_v036                       := phone_v036;
                    self.phone_v037                       := phone_v037;
                    self.phone_v038                       := phone_v038;
                    self.phone_v039                       := phone_v039;
                    self.phone_v040                       := phone_v040;
                    self.phone_v041                       := phone_v041;
                    self.phone_v042                       := phone_v042;
                    self.phone_v043                       := phone_v043;
                    self.phone_v044                       := phone_v044;
                    self.phone_v045                       := phone_v045;
                    self.phone_v046                       := phone_v046;
                    self.phone_v047                       := phone_v047;
                    self.phone_v048                       := phone_v048;
                    self.phone_v049                       := phone_v049;
                    self.phone_v050                       := phone_v050;
                    self.phone_v051                       := phone_v051;
                    self.phone_v052                       := phone_v052;
                    self.phone_v053                       := phone_v053;
                    self.phone_v054                       := phone_v054;
                    self.phone_v055                       := phone_v055;
                    self.phone_v056                       := phone_v056;
                    self.phone_v057                       := phone_v057;
                    self.phone_v058                       := phone_v058;
                    self.phone_v059                       := phone_v059;
                    self.phone_v060                       := phone_v060;
                    self.phone_v061                       := phone_v061;
                    self.phone_v062                       := phone_v062;
                    self.phone_v063                       := phone_v063;
                    self.phone_pc001                      := phone_pc001;
                    self.phone_pc002                      := phone_pc002;
                    self.phone_pc003                      := phone_pc003;
                    self.phone_distance_001               := phone_distance_001;
                    self.phone_distance_002               := phone_distance_002;
                    self.phone_distance_003               := phone_distance_003;
                    self.phone_distance_004               := phone_distance_004;
                    self.phone_distance_005               := phone_distance_005;
                    self.phone_distance_006               := phone_distance_006;
                    self.phone_mindist                    := phone_mindist;
                    self.phone_cluster                    := phone_cluster;
                    self.iid1906_0_0_phoneriskindex       := iid1906_0_0_phoneriskindex;
                    self.iid1906_0_0_phonehighriskind     := iid1906_0_0_phonehighriskind;
                    self.iid1906_0_0_emailriskindex       := iid1906_0_0_emailriskindex;
                    self.iid1906_0_0_emailhighriskind     := iid1906_0_0_emailhighriskind;                   
                   Self.iid_recs:=le;
                    self:= le;
                   self:=[];
                    
     #else
      			
			// set just these 4 fields in layout_output
      self.iid_tmx.emailriskindex:= iid1906_0_0_emailriskindex;
      self.iid_tmx.phoneriskindex:= iid1906_0_0_phoneriskindex;
      self.iid_tmx.phonehighriskind:=(String)iid1906_0_0_phonehighriskind;
      self.iid_tmx.emailhighriskind:=(String)iid1906_0_0_emailhighriskind;
			
			self := le;
  
#end      
      END;

model:= project(iid_recs,doModel(left));
return model;
END;

