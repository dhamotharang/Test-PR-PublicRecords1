import FLAccidents_Ecrash;


accidents_by_AgencyID_slim := RECORD
  string11 AgencyID;
	string10 accident_date;
  string30 precinct;
  string20 beat;
	string   report_code;
	string   vehicle_incident_id;
	INTEGER  AccidentCnt;
	INTEGER  InjuryCnt;
	INTEGER  FatalCnt;
	INTEGER  InjuryUnkCnt;
END;

accidents_by_AgencyID_slim getCounts({files_addl.DedupedKey} L) := TRANSFORM
  SELF.AgencyID								:= L.Jurisdiction_nbr;
	SELF.accident_date 					:= L.accident_date;
	SELF.precinct  							:= L.precinct; 
	SELF.beat      							:= L.beat;
	SELF.Report_Code						:= L.Report_Code;
	SELF.Vehicle_Incident_ID		:= L.Vehicle_Incident_ID;
	SELF.AccidentCnt						:= 1;	
	
	CountInjuries := FLAccidents_Ecrash.Functions.CountInjuries(L.Report_Injury_Status);
	SELF.InjuryCnt							:= CountInjuries.InjuryCnt;
	SELF.FatalCnt								:= CountInjuries.FatalCnt;
	SELF.InjuryUnkCnt						:= CountInjuries.InjuryUnkCnt;
END;

dsWithCounts := PROJECT(files_addl.DedupedKey, getCounts(LEFT));

{dsWithCounts} RollAccidents({dsWithCounts} L, {dsWithCounts} R):=TRANSFORM
  SELF.agencyid 						:= L.agencyid;
	SELF.accident_date 				:= L.accident_date;
  SELF.precinct							:= L.precinct;
  SELF.beat									:= L.beat;
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
	dsRolled.AgencyID;
	dsRolled.Accident_date;
	dsRolled.Precinct;
	dsRolled.Beat;
	INTEGER  AccidentCnt    := SUM(GROUP, dsRolled.accidentcnt);
	INTEGER  InjuryCnt 			:= SUM(GROUP, dsRolled.InjuryCnt);
	INTEGER  FatalCnt  			:= SUM(GROUP, dsRolled.FatalCnt);
	INTEGER  UnknownCnt			:= SUM(GROUP, dsRolled.InjuryUnkCnt);
END;

by_AgencyID := TABLE(dsRolled, {inter_layout}, AgencyID, accident_date, precinct, beat);


EXPORT file_byAgencyID := by_AgencyID;