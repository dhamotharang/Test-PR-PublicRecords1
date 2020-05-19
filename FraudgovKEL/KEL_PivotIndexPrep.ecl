import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;
IMPORT HIPIE_ECL;

EXPORT KEL_PivotIndexPrep := MODULE

	MainEventShell := FraudgovKEL.KEL_EventPivot.EventPivotShell;

	/*BaseIndexPrep := hipie_ecl.macSlimDataset(MainEventShell, 'customerid,industrytype,entitycontextuid,entitytype', 
			'recordid,caseid,eventdate,' +
			'label,islastentityeventflag,eventcount,event30count,event365count,eventafterkrflag,eventafterkrcount,' +
			'riskindx,aotkractflagev,aotsafeactflagev'
			);*/

	NvpRec := RECORD
	 STRING Name;
	 STRING Value;
	END;

	BaseIndexPrepWithNVP := PROJECT(MainEventShell, 
														TRANSFORM({ 
																																LEFT.customerid,LEFT.industrytype,																																	//customer info
																																LEFT.entitycontextuid,LEFT.entitytype, 																										//entity info
																																LEFT.recordid,LEFT.eventdate,
																																LEFT.caseid,
																																LEFT.label, 
																																LEFT.RiskIndx, LEFT.aotkractflagev,LEFT.aotsafeactflagev,		//risk info
																																LEFT.aotcurrprofflag,
																																LEFT.t_personuidecho,
																																LEFT.t_inpclnfirstnmecho, LEFT.t_inpclnlastnmecho,											//name
																																LEFT.t_inpclnssnecho,																																																		//ssn
																																LEFT.t_inpclndobecho,																																																		//DOB
																																LEFT.t_inpclnaddrprimrangeecho,
																																LEFT.t_inpclnaddrpredirecho,
																																LEFT.t_inpclnaddrprimnmecho,
																																LEFT.t_inpclnaddrsuffixecho,
																																LEFT.t_inpclnaddrpostdirecho,
																																LEFT.t_inpclnaddrunitdesigecho,
																																LEFT.t_inpclnaddrsecrangeecho,
																																//LEFT.streetaddress, 
																																LEFT.t_inpclnaddrcityecho, LEFT.t_inpclnaddrstecho, LEFT.t_inpclnaddrzip5echo, //address
																																LEFT.t_inpclnipaddrecho, LEFT.t18_ipaddrispnm, LEFT.t18_ipaddrcountry,		//IP info
																																LEFT.t_inpclnphnecho,																																																		//phone
																																LEFT.t_inpclnemailecho,																																														// email
																																LEFT.t19_bnkacctbnknm, LEFT.t_inpclnbnkacctecho, LEFT.t_inpclnbnkacctrtgecho,		//bank info
																																LEFT.t_inpclndlstecho, LEFT.t_inpclndlecho,																					//DL info
																																LEFT.event30count, LEFT.eventcount, LEFT.personeventcount,	//event counts
														STRING100 deviceid,
														DATASET(NvpRec) Nvp},  
														SELF.deviceid := '',
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