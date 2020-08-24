// Ecrash Reports key, by Day Of Week

IMPORT FLAccidents_Ecrash, STD, UT,Data_Services,doxie;

Basekey := FLAccidents_Ecrash.File_KeybuildV2.out(report_code = 'EA' AND report_type_id = 'A' AND work_type_id NOT IN['2','3']);

Dedup1 := DEDUP(BaseKey(DID > '0'),DID + Vehicle_Incident_id);
Dedup2 := DEDUP(BaseKey(DID = '0'),Vehicle_Incident_Id + fname + lname + name_suffix);

DedupedKey := SORT(Dedup1 + Dedup2, jurisdiction_nbr + Vehicle_Incident_id + Vehicle_unit_number);


accidents_by_dow_slim := RECORD
  string11 AgencyID;
	STRING8  accident_date;
  INTEGER  DayOfWeek;
	string   report_code;
	string   vehicle_incident_id;
	INTEGER  AccidentCnt;
	INTEGER  InjuryCnt;
	INTEGER  FatalCnt;
	INTEGER  InjuryUnkCnt;
END;

accidents_by_dow_slim slim({DedupedKey} L) := TRANSFORM
  SELF.AGENCYID 			:= L.Jurisdiction_nbr;
	SELF.accident_date 	:= L.accident_date;
  SELF.DayOfWeek			:= FLAccidents_Ecrash.Functions.DayOfWeek(L.accident_date);
	SELF.Report_Code						:= L.Report_Code;
	SELF.Vehicle_Incident_ID		:= L.Vehicle_Incident_ID;
	SELF.AccidentCnt						:= 1;	
			CountInjuries := FLAccidents_Ecrash.Functions.CountInjuries(L.Report_Injury_Status);
	SELF.InjuryCnt							:= CountInjuries.InjuryCnt;
	SELF.FatalCnt								:= CountInjuries.FatalCnt;
	SELF.InjuryUnkCnt						:= CountInjuries.InjuryUnkCnt;
END;

dsWithCounts := PROJECT(DedupedKey, slim(LEFT));

{dsWithCounts} RollAccidents({dsWithCounts} L, {dsWithCounts} R):=TRANSFORM
  SELF.agencyid 						:= L.agencyid;
	SELF.accident_date 				:= L.accident_date;
	SELF.DayOfWeek						:= L.DayOfWeek;
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
	dsRolled.DayOfWeek;
	INTEGER AccidentCnt     := SUM(GROUP, dsRolled.accidentcnt);
	INTEGER InjuryCnt 			:= SUM(GROUP, dsRolled.InjuryCnt);
	INTEGER FatalCnt  			:= SUM(GROUP, dsRolled.FatalCnt);
	INTEGER UnknownCnt			:= SUM(GROUP, dsRolled.InjuryUnkCnt);
END;

by_DOW := TABLE(dsRolled, {inter_layout}, agencyid, Accident_date, DayOfWeek);

EXPORT Key_ecrash_byDOW := INDEX(by_DOW, {agencyid, Accident_date}, {by_DOW}, 
                                 Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2::analytics_byDOW_' + doxie.Version_SuperKey);