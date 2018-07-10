IMPORT FLAccidents_eCrash, ut, riskwise, Accident_Services;	

EXPORT Boca_Shell_Accident (GROUPED DATASET(layout_bocashell_neutral) bs,INTEGER bsversion=3) := FUNCTION

layout_extended := RECORD
	layout_bocashell_neutral;
	STRING40 accident_nbr;
	UNSIGNED accident_date;
	UNSIGNED est_vehicle_damage;
	STRING1  vehicle_fault_code;
	STRING1  alcohol_drug;
	STRING2  first_contrib_cause;
	STRING2  second_contrib_cause;
	STRING2  third_contrib_cause;
END;

// exclude non-accident records examples are auto theft, theft recovery, fire, burglary, vandalism, etc...
accRptCodes := Accident_Services.Constants.FLAccident_source+Accident_Services.Constants.NtlAccident_source+Accident_Services.Constants.eCrashAccident_source;

// get accident numbers by did
recsWithAccNbr := JOIN(bs,FLAccidents_eCrash.Key_eCrashV2_did,
	KEYED(LEFT.did=RIGHT.l_did),TRANSFORM(layout_extended,SELF:=RIGHT,SELF:=LEFT,SELF:=[]),
	LEFT OUTER,ATMOST(Riskwise.max_atmost),KEEP(100));

recsDupAccNbr := DEDUP(SORT(recsWithAccNbr,seq,accident_nbr),seq,accident_nbr);

// add accident date, damage amt and fault
recsWithAccDate := JOIN(recsDupAccNbr,FLAccidents_eCrash.Key_eCrashV2_accnbr,
	KEYED(LEFT.accident_nbr=RIGHT.l_accnbr) AND LEFT.did=(UNSIGNED)RIGHT.did AND
	(UNSIGNED)(RIGHT.accident_date[1..6]) < LEFT.historydate AND // only keep accident numbers that are in the past
	RIGHT.report_code IN accRptCodes, // exclude non-accident records
	TRANSFORM(layout_extended,
		SELF.accident_date:=(UNSIGNED)RIGHT.accident_date,
		SELF.est_vehicle_damage:=(UNSIGNED)RIGHT.est_vehicle_damage,
		SELF.vehicle_fault_code:=RIGHT.vehicle_fault_code,
		SELF:=LEFT,SELF:=[]),
	LEFT OUTER,ATMOST(Riskwise.max_atmost),KEEP(100));

// add alcohol drug flags
recsWithAlcDrug := JOIN(recsWithAccDate,FLAccidents_eCrash.Key_eCrash4,
	KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr) AND LEFT.did=(UNSIGNED)RIGHT.did,
	TRANSFORM(layout_extended,
    SELF.alcohol_drug:=RIGHT.driver_alco_drug_code,
    SELF.first_contrib_cause:=RIGHT.first_contrib_cause,
    SELF.second_contrib_cause:=RIGHT.second_contrib_cause,
    SELF.third_contrib_cause:=RIGHT.third_contrib_cause,
    SELF:=LEFT,SELF:=[]),
	LEFT OUTER,ATMOST(Riskwise.max_atmost),KEEP(100));

layout_extended populateNumAccidents(layout_extended L) := TRANSFORM
	isAccident :=  trim(L.accident_nbr) NOT in ['', '0']; 
	isFault := L.vehicle_fault_code = '1' AND isAccident;
  duiCodes := ['2','3','4','07','08','09'];
	isDA := L.alcohol_drug   IN duiCodes OR
    L.first_contrib_cause  IN duiCodes OR
    L.second_contrib_cause IN duiCodes OR
    L.third_contrib_cause  IN duiCodes AND isFault;

	accidentDate8 := (STRING8)L.accident_date;	// full 8 byte date
	historyDate8 := iid_constants.myGetDate(L.historydate);	// full 8 byte date

	SELF.Accident_Data.acc.num_accidents    := IF(isAccident,1,0);
	SELF.Accident_Data.acc.datelastaccident := IF(isAccident,L.accident_date,0);
	SELF.Accident_Data.acc.dmgamtaccidents  := IF(isAccident,(UNSIGNED)L.est_vehicle_damage,0);
	SELF.Accident_Data.acc.dmgamtlastaccident := IF(isAccident,(UNSIGNED)L.est_vehicle_damage,0);
	SELF.Accident_Data.acc.numaccidents30   := IF(isAccident,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,30,L.historydate),0);
	SELF.Accident_Data.acc.numaccidents90   := IF(isAccident,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,90,L.historydate),0);
	SELF.Accident_Data.acc.numaccidents180  := IF(isAccident,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,180,L.historydate),0);
	SELF.Accident_Data.acc.numaccidents12   := IF(isAccident,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(1),L.historydate),0);
	SELF.Accident_Data.acc.numaccidents24   := IF(isAccident,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(2),L.historydate),0);
	SELF.Accident_Data.acc.numaccidents36   := IF(isAccident,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(3),L.historydate),0);
	SELF.Accident_Data.acc.numaccidents60   := IF(isAccident,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(5),L.historydate),0);

	SELF.Accident_Data.atfault.num_accidents    := IF(isFault,1,0);
	SELF.Accident_Data.atfault.datelastaccident := IF(isFault,L.accident_date,0);
	SELF.Accident_Data.atfault.dmgamtaccidents  := IF(isFault,(UNSIGNED)L.est_vehicle_damage,0);
	SELF.Accident_Data.atfault.dmgamtlastaccident := IF(isFault,(UNSIGNED)L.est_vehicle_damage,0);
	SELF.Accident_Data.atfault.numaccidents30   := IF(isFault,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,30,L.historydate),0);
	SELF.Accident_Data.atfault.numaccidents90   := IF(isFault,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,90,L.historydate),0);
	SELF.Accident_Data.atfault.numaccidents180  := IF(isFault,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,180,L.historydate),0);
	SELF.Accident_Data.atfault.numaccidents12   := IF(isFault,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(1),L.historydate),0);
	SELF.Accident_Data.atfault.numaccidents24   := IF(isFault,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(2),L.historydate),0);
	SELF.Accident_Data.atfault.numaccidents36   := IF(isFault,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(3),L.historydate),0);
	SELF.Accident_Data.atfault.numaccidents60   := IF(isFault,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(5),L.historydate),0);

	SELF.Accident_Data.atfaultda.num_accidents    := IF(isDA,1,0);
	SELF.Accident_Data.atfaultda.datelastaccident := IF(isDA,L.accident_date,0);
	SELF.Accident_Data.atfaultda.dmgamtaccidents  := IF(isDA,(UNSIGNED)L.est_vehicle_damage,0);
	SELF.Accident_Data.atfaultda.dmgamtlastaccident := IF(isDA,(UNSIGNED)L.est_vehicle_damage,0);
	SELF.Accident_Data.atfaultda.numaccidents30   := IF(isDA,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,30,L.historydate),0);
	SELF.Accident_Data.atfaultda.numaccidents90   := IF(isDA,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,90,L.historydate),0);
	SELF.Accident_Data.atfaultda.numaccidents180  := IF(isDA,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,180,L.historydate),0);
	SELF.Accident_Data.atfaultda.numaccidents12   := IF(isDA,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(1),L.historydate),0);
	SELF.Accident_Data.atfaultda.numaccidents24   := IF(isDA,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(2),L.historydate),0);
	SELF.Accident_Data.atfaultda.numaccidents36   := IF(isDA,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(3),L.historydate),0);
	SELF.Accident_Data.atfaultda.numaccidents60   := IF(isDA,(UNSIGNED1)iid_constants.checkdays(historydate8,accidentDate8,ut.DaysInNYears(5),L.historydate),0);

	SELF := L;
END;

// same accidents may be reported by multiple sources, dedup by accident date 
recsDupAccDate := DEDUP(SORT(recsWithAlcDrug,seq,accident_date,-est_vehicle_damage),seq,accident_date);
recsWithNumAcc := PROJECT(recsDupAccDate,populateNumAccidents(LEFT));

layout_extended rollAccidentData(layout_extended L,layout_extended R) := TRANSFORM
	dateLastAccident := MAX(L.Accident_Data.acc.datelastaccident,R.Accident_Data.acc.datelastaccident);
	dmgAmtLastAccident := IF(dateLastAccident=L.Accident_Data.acc.datelastaccident,L.Accident_Data.acc.dmgamtlastaccident,R.Accident_Data.acc.dmgamtlastaccident);

	SELF.Accident_Data.acc.datelastaccident := dateLastAccident;
	SELF.Accident_Data.acc.dmgamtlastaccident := dmgAmtLastAccident;
	SELF.Accident_Data.acc.num_accidents   := L.Accident_Data.acc.num_accidents   + R.Accident_Data.acc.num_accidents;
	SELF.Accident_Data.acc.dmgamtaccidents := L.Accident_Data.acc.dmgamtaccidents + R.Accident_Data.acc.dmgamtaccidents;
	SELF.Accident_Data.acc.numaccidents30  := L.Accident_Data.acc.numaccidents30  + R.Accident_Data.acc.numaccidents30;
	SELF.Accident_Data.acc.numaccidents90  := L.Accident_Data.acc.numaccidents90  + R.Accident_Data.acc.numaccidents90;
	SELF.Accident_Data.acc.numaccidents180 := L.Accident_Data.acc.numaccidents180 + R.Accident_Data.acc.numaccidents180;
	SELF.Accident_Data.acc.numaccidents12  := L.Accident_Data.acc.numaccidents12  + R.Accident_Data.acc.numaccidents12;
	SELF.Accident_Data.acc.numaccidents24  := L.Accident_Data.acc.numaccidents24  + R.Accident_Data.acc.numaccidents24;
	SELF.Accident_Data.acc.numaccidents36  := L.Accident_Data.acc.numaccidents36  + R.Accident_Data.acc.numaccidents36;
	SELF.Accident_Data.acc.numaccidents60  := L.Accident_Data.acc.numaccidents60  + R.Accident_Data.acc.numaccidents60;

	dateLastAccidentAtFault := MAX(L.Accident_Data.atfault.datelastaccident,R.Accident_Data.atfault.datelastaccident);
	dmgAmtLastAccidentAtFault := IF(dateLastAccidentAtFault=L.Accident_Data.atfault.datelastaccident,L.Accident_Data.atfault.dmgamtlastaccident,R.Accident_Data.atfault.dmgamtlastaccident);

	SELF.Accident_Data.atfault.datelastaccident := dateLastAccidentAtFault;
	SELF.Accident_Data.atfault.dmgamtlastaccident := dmgAmtLastAccidentAtFault;
	SELF.Accident_Data.atfault.num_accidents   := L.Accident_Data.atfault.num_accidents   + R.Accident_Data.atfault.num_accidents;
	SELF.Accident_Data.atfault.dmgamtaccidents := L.Accident_Data.atfault.dmgamtaccidents + R.Accident_Data.atfault.dmgamtaccidents;
	SELF.Accident_Data.atfault.numaccidents30  := L.Accident_Data.atfault.numaccidents30  + R.Accident_Data.atfault.numaccidents30;
	SELF.Accident_Data.atfault.numaccidents90  := L.Accident_Data.atfault.numaccidents90  + R.Accident_Data.atfault.numaccidents90;
	SELF.Accident_Data.atfault.numaccidents180 := L.Accident_Data.atfault.numaccidents180 + R.Accident_Data.atfault.numaccidents180;
	SELF.Accident_Data.atfault.numaccidents12  := L.Accident_Data.atfault.numaccidents12  + R.Accident_Data.atfault.numaccidents12;
	SELF.Accident_Data.atfault.numaccidents24  := L.Accident_Data.atfault.numaccidents24  + R.Accident_Data.atfault.numaccidents24;
	SELF.Accident_Data.atfault.numaccidents36  := L.Accident_Data.atfault.numaccidents36  + R.Accident_Data.atfault.numaccidents36;
	SELF.Accident_Data.atfault.numaccidents60  := L.Accident_Data.atfault.numaccidents60  + R.Accident_Data.atfault.numaccidents60;

	dateLastAccidentAtFaultDA := MAX(L.Accident_Data.atfaultda.datelastaccident,R.Accident_Data.atfaultda.datelastaccident);
	dmgAmtLastAccidentAtFaultDA := IF(dateLastAccidentAtFaultDA=L.Accident_Data.atfaultda.datelastaccident,L.Accident_Data.atfaultda.dmgamtlastaccident,R.Accident_Data.atfaultda.dmgamtlastaccident);

	SELF.Accident_Data.atfaultda.datelastaccident := dateLastAccidentAtFaultDA;
	SELF.Accident_Data.atfaultda.dmgamtlastaccident := dmgAmtLastAccidentAtFaultDA;
	SELF.Accident_Data.atfaultda.num_accidents   := L.Accident_Data.atfaultda.num_accidents   + R.Accident_Data.atfaultda.num_accidents;
	SELF.Accident_Data.atfaultda.dmgamtaccidents := L.Accident_Data.atfaultda.dmgamtaccidents + R.Accident_Data.atfaultda.dmgamtaccidents;
	SELF.Accident_Data.atfaultda.numaccidents30  := L.Accident_Data.atfaultda.numaccidents30  + R.Accident_Data.atfaultda.numaccidents30;
	SELF.Accident_Data.atfaultda.numaccidents90  := L.Accident_Data.atfaultda.numaccidents90  + R.Accident_Data.atfaultda.numaccidents90;
	SELF.Accident_Data.atfaultda.numaccidents180 := L.Accident_Data.atfaultda.numaccidents180 + R.Accident_Data.atfaultda.numaccidents180;
	SELF.Accident_Data.atfaultda.numaccidents12  := L.Accident_Data.atfaultda.numaccidents12  + R.Accident_Data.atfaultda.numaccidents12;
	SELF.Accident_Data.atfaultda.numaccidents24  := L.Accident_Data.atfaultda.numaccidents24  + R.Accident_Data.atfaultda.numaccidents24;
	SELF.Accident_Data.atfaultda.numaccidents36  := L.Accident_Data.atfaultda.numaccidents36  + R.Accident_Data.atfaultda.numaccidents36;
	SELF.Accident_Data.atfaultda.numaccidents60  := L.Accident_Data.atfaultda.numaccidents60  + R.Accident_Data.atfaultda.numaccidents60;

	SELF := L;
END;

recsAccRolled := ROLLUP(recsWithNumAcc,TRUE,rollAccidentData(LEFT,RIGHT));

RETURN PROJECT(recsAccRolled,layout_bocashell_neutral);
END;