import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;
IMPORT HIPIE_ECL;

EXPORT KEL_PivotIndexPrep := MODULE

	MainEventShell := FraudgovKEL.KEL_EventPivot.EventPivotShell(aotcurrprofflag = 1);

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
														SELF.event30count := LEFT.aotnonstactcnt30d,
														SELF.eventcount := LEFT.aotnonstactcntev,
														SELF.deviceid := LEFT.t_inpcaseidecho,
														SELF.nvp := DATASET([
														 {'personentitycontextuid', (STRING)LEFT.personentitycontextuid},
															{'phoneentitycontextuid', (STRING)LEFT.phoneentitycontextuid},
															{'emailentitycontextuid', (STRING)LEFT.emailentitycontextuid},
															{'addressentitycontextuid', (STRING)LEFT.addressentitycontextuid},
															{'ssnentitycontextuid', (STRING)LEFT.ssnentitycontextuid},
															{'ipentitycontextuid', (STRING)LEFT.ipentitycontextuid},
															{'bankaccountentitycontextuid', (STRING)LEFT.bankaccountentitycontextuid},
															{'driverslicenseentitycontextuid', (STRING)LEFT.driverslicenseentitycontextuid},
															{'t_inagencyflag', (STRING)LEFT.t_inagencyflag}
														 ], NvpRec),
														 SELF := LEFT));

	EXPORT ds_KEL_PivotIndexPrep := BaseIndexPrepWithNVP;
END;