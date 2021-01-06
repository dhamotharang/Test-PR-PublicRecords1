import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;
IMPORT HIPIE_ECL;

EXPORT KEL_PivotIndexPrep := MODULE

	MainEventShell := FraudgovKEL.KEL_EventPivot.EventPivotShell(aotcurrprofflag = 1 and t_inagencyflag=1);

	/*BaseIndexPrep := hipie_ecl.macSlimDataset(MainEventShell, 'customerid,industrytype,entitycontextuid,entitytype', 
			'recordid,caseid,eventdate,' +
			'label,islastentityeventflag,eventcount,event30count,event365count,eventafterkrflag,eventafterkrcount,' +
			'riskindx,aotkractflagev,aotsafeactflagev'
			);*/

	NvpRec := RECORD
	 STRING Name;
	 STRING Value;
	END;
	
	profileRec := RECORD
  integer8 customerid;
  integer8 industrytype;
  string entitycontextuid;
  integer1 entitytype;
  integer8 recordid;
  unsigned4 eventdate;
  string caseid;
  string label;
  integer1 riskindx;
  integer1 aotkractflagev;
  integer1 aotsafeactflagev;
  integer1 aotcurrprofflag;
  integer8 t_personuidecho;
  string t_inpclnfirstnmecho;
  string t_inpclnlastnmecho;
  string t_inpclnssnecho;
  integer8 t_inpclndobecho;
  string t_inpclnaddrprimrangeecho;
  string t_inpclnaddrpredirecho;
  string t_inpclnaddrprimnmecho;
  string t_inpclnaddrsuffixecho;
  string t_inpclnaddrpostdirecho;
  string t_inpclnaddrunitdesigecho;
  string t_inpclnaddrsecrangeecho;
  string t_inpclnaddrcityecho;
  string t_inpclnaddrstecho;
  string t_inpclnaddrzip5echo;
  string t_inpclnipaddrecho;
  string t18_ipaddrispnm;
  string t18_ipaddrcountry;
  string t_inpclnphnecho;
  string t_inpclnemailecho;
  string t19_bnkacctbnknm;
  string t_inpclnbnkacctecho;
  string t_inpclnbnkacctrtgecho;
  string t_inpclndlstecho;
  string t_inpclndlecho;
  unsigned8 event30count;
  unsigned8 eventcount;
  integer8 personeventcount;
  string100 deviceid;
  DATASET(nvprec) nvp;
 END;

	BaseIndexPrepWithNVP := PROJECT(MainEventShell, 
														TRANSFORM(profileRec,
														SELF.personeventcount := LEFT.aotidcurrprofusngcntev,
														SELF.event30count := LEFT.aotnonstactcnt30d,
														SELF.eventcount := LEFT.aotnonstactcntev,
														SELF.deviceid := LEFT.t_inpdvcidecho,
														SELF.nvp := DATASET([
														 {'personentitycontextuid', (STRING)LEFT.personentitycontextuid},
															{'phoneentitycontextuid', (STRING)LEFT.phoneentitycontextuid},
															{'emailentitycontextuid', (STRING)LEFT.emailentitycontextuid},
															{'addressentitycontextuid', (STRING)LEFT.addressentitycontextuid},
															{'ssnentitycontextuid', (STRING)LEFT.ssnentitycontextuid},
															{'ipentitycontextuid', (STRING)LEFT.ipentitycontextuid},
															{'bankaccountentitycontextuid', (STRING)LEFT.bankaccountentitycontextuid},
															{'driverslicenseentitycontextuid', (STRING)LEFT.driverslicenseentitycontextuid},
															{'t_inagencyflag', (STRING)LEFT.t_inagencyflag},
															{'t_inpclnmiddlenmecho',(STRING)LEFT.t_inpclnmiddlenmecho},
															{'aotidactcntev', (STRING)LEFT.aotidactcntev},
															{'t9_addrpoboxmultcurridflagev', (STRING)LEFT.t9_addrpoboxmultcurridflagev},
															{'t15_ssnmultcurridflagev', (STRING)LEFT.t15_ssnmultcurridflagev},
															{'t20_dlmultcurridflagev', (STRING)LEFT.t20_dlmultcurridflagev},
															{'t19_bnkacctmultcurridflagev', (STRING)LEFT.t19_bnkacctmultcurridflagev},
															{'p1_aotidkrappfrdactinagcyflagev', (STRING)LEFT.p1_aotidkrappfrdactinagcyflagev},
															{'p1_aotidkrgenfrdactinagcyflagev', (STRING)LEFT.p1_aotidkrgenfrdactinagcyflagev},
															{'p1_aotidkrothfrdactinagcyflagev', (STRING)LEFT.p1_aotidkrothfrdactinagcyflagev},
															{'p1_aotidkrstolidactinagcyflagev', (STRING)LEFT.p1_aotidkrstolidactinagcyflagev},
															{'p1_aotidkrappfrdactshrdflagev', (STRING)LEFT.p1_aotidkrappfrdactshrdflagev},
															{'p1_aotidkrgenfrdactshrdflagev', (STRING)LEFT.p1_aotidkrgenfrdactshrdflagev},
															{'p1_aotidkrothfrdactshrdflagev', (STRING)LEFT.p1_aotidkrothfrdactshrdflagev},
															{'p1_aotidkrstolidactshrdflagev', (STRING)LEFT.p1_aotidkrstolidactshrdflagev},
															{'p1_aotidkractshrdnewsrcagencydescev', (STRING)LEFT.p1_aotidkractshrdnewsrcagencydescev},
															{'p1_aotidkrgenfrdactshrdnewsrcagencydescev', (STRING)LEFT.p1_aotidkrgenfrdactshrdnewsrcagencydescev},
															{'p1_aotidkrstolidactshrdnewsrcagencydescev', (STRING)LEFT.p1_aotidkrstolidactshrdnewsrcagencydescev},
															{'p1_aotidkrappfrdactshrdnewsrcagencydescev', (STRING)LEFT.p1_aotidkrappfrdactshrdnewsrcagencydescev},
															{'p1_aotidkrothfrdactshrdnewsrcagencydescev', (STRING)LEFT.p1_aotidkrothfrdactshrdnewsrcagencydescev},
															{'p9_aotaddrkractshrdnewsrcagencydescev', (STRING)LEFT.p9_aotaddrkractshrdnewsrcagencydescev},
															{'p15_aotssnkractshrdnewsrcagencydescev', (STRING)LEFT.p15_aotssnkractshrdnewsrcagencydescev},
															{'p16_aotphnkractshrdnewsrcagencydescev', (STRING)LEFT.p16_aotphnkractshrdnewsrcagencydescev},
															{'p17_aotemailkractshrdnewsrcagencydescev', (STRING)LEFT.p17_aotemailkractshrdnewsrcagencydescev},
															{'p18_aotipaddrkractshrdnewsrcagencydescev', (STRING)LEFT.p18_aotipaddrkractshrdnewsrcagencydescev},
															{'p19_aotbnkacctkractshrdnewsrcagencydescev', (STRING)LEFT.p19_aotbnkacctkractshrdnewsrcagencydescev},
															{'p20_aotdlkractshrdnewsrcagencydescev', (STRING)LEFT.p20_aotdlkractshrdnewsrcagencydescev}
														 ], NvpRec),
														 SELF := LEFT));

	EXPORT ds_KEL_PivotIndexPrep := BaseIndexPrepWithNVP;
END;