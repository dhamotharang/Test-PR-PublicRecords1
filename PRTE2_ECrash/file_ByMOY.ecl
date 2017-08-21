import FLAccidents_Ecrash;

accidents_by_moy_slim := RECORD
  string11 AgencyID;
	STRING8  accident_date;
  STRING2  MonthOfYear;
	string   report_code;
	string   vehicle_incident_id;
	INTEGER  AccidentCnt;
	INTEGER  InjuryCnt;
	INTEGER  FatalCnt;
	INTEGER  InjuryUnkCnt;
END;

accidents_by_moy_slim slim({files_addl.DedupedKey} L) := TRANSFORM
  SELF.AGENCYID 							:= L.Jurisdiction_nbr;
	SELF.accident_date 					:= L.accident_date;
	SELF.MonthOfYear    				:= IF(L.Accident_date[5..6] BETWEEN '01' AND '12', L.Accident_date[5..6], '13');
	SELF.Report_Code						:= L.Report_Code;
	SELF.Vehicle_Incident_ID		:= L.Vehicle_Incident_ID;
	SELF.AccidentCnt						:= 1;	
			
	CountInjuries := FLAccidents_Ecrash.Functions.CountInjuries(L.Report_Injury_Status);
	SELF.InjuryCnt							:= CountInjuries.InjuryCnt;
	SELF.FatalCnt								:= CountInjuries.FatalCnt;
	SELF.InjuryUnkCnt						:= CountInjuries.InjuryUnkCnt;
END;

dsWithCounts := PROJECT(files_addl.DedupedKey, slim(LEFT));

{dsWithCounts} RollAccidents({dsWithCounts} L, {dsWithCounts} R):=TRANSFORM
  SELF.agencyid 						:= L.agencyid;
	SELF.accident_date 				:= L.accident_date;
	SELF.MonthOfYear					:= L.MonthOfYear;
	SELF.report_code					:= L.report_code;
	SELF.vehicle_incident_id	:= L.vehicle_incident_id;
	SELF.accidentCnt					:= L.accidentCnt;
	SELF.InjuryCnt						:= L.InjuryCnt + R.InjuryCnt;
	SELF.FatalCnt							:= L.FatalCnt + R.FatalCnt;
	SELF.InjuryUnkCnt					:= L.InjuryUnkCnt + R.InjuryUnkCnt;
END;
dsRolled := ROLLUP(dsWithCounts, 
                   LEFT.vehicle_incident_id = RIGHT.vehicle_Incident_id AND
									 LEFT.report_code = RIGHT.report_code,
									 RollAccidents(LEFT,RIGHT));


inter_layout := RECORD
	dsRolled.agencyid;
	dsRolled.accident_date;
	dsRolled.MonthOfYear;
	INTEGER AccidentCnt     := SUM(GROUP, dsRolled.accidentcnt);
	INTEGER InjuryCnt 			:= SUM(GROUP, dsRolled.InjuryCnt);
	INTEGER FatalCnt  			:= SUM(GROUP, dsRolled.FatalCnt);
	INTEGER UnknownCnt			:= SUM(GROUP, dsRolled.InjuryUnkCnt);
END;

by_MOY := TABLE(dsRolled, {inter_layout}, agencyid, Accident_date, MonthOfYear);

EXPORT file_ByMOY := by_MOY;