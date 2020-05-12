import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;
IMPORT HIPIE_ECL;


MainEventShell := FraudgovKEL.KEL_EventPivot.EventPivotShell;

BaseIndexPrep := hipie_ecl.macSlimDataset(MainEventShell, 'customerid,industrytype,entitycontextuid,entitytype', 
		'recordid,caseid,eventdate,' +
		'label,islastentityeventflag,eventcount,event30count,event365count,eventafterkrflag,eventafterkrcount,' +
		'riskindx,aotkractflagev,aotsafeactflagev'
		);

NvpRec := RECORD
 STRING Name;
 STRING Value;
END;

BaseIndexPrepWithNVP := PROJECT(BaseIndexPrep, 
                          TRANSFORM({ 
													LEFT.customerid,LEFT.industrytype,LEFT.entitycontextuid,LEFT.entitytype, 
		                      LEFT.recordid,LEFT.caseid,LEFT.eventdate,
		                      LEFT.label,LEFT.islastentityeventflag,
													DATASET(NvpRec) Nvp},  
                          SELF.nvp := DATASET([
													 {'RiskIndx', (STRING)LEFT.RiskIndx},
													 {'aotkractflagev', (STRING)LEFT.aotkractflagev},
													 {'aotsafeactflagev', (STRING)LEFT.aotsafeactflagev}
													 ], NvpRec),
													 SELF := LEFT));

EXPORT KEL_PivotIndexPrep := BaseIndexPrepWithNVP;