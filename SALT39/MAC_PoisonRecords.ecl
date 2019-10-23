// Macro to create appropriately dated records from "before" and "after" datasets
// "poison" refers to the end-dating of old ("before only") records, but this macro also begin-dates the new ("after only") records
// The output will contain 2 types of records:
// - "before" records that are no longer in "after" with an updated dt_last (these are "poison")
//    OR current dt_last value is retained if it's already an earlier date (0 means forever)
// - "after" records that are not in "before" with an updated dt_first (these are the new versions of poisoned records)
// in the date updates above, dt_first on new "after" records will be NOW (local server time),
// and dt_last on old "before" records will be NOW minus 1 day/second (depending on dt_resolution)
//
// Input Parameters:
// dsBefore/dsAfter are input "before" and "after" datasets
// fieldList is a comma-delimited list of field names to be compared (expects a string, will be expanded to a join condition)
// dt_early and dt_late are the first/last date fields for which values are modified
// dt_resolution should be either YYYYMMDD or YYYYMMDDHHMMS, depending upon desired date resolution
EXPORT MAC_PoisonRecords(dsBefore, dsAfter, fieldList, dt_early, dt_late, dt_resolution) := FUNCTIONMACRO
	IMPORT STD, SALT39;
	nowDate 		 := STD.Date.CurrentDate(TRUE);
	nowTime 		 := STD.Date.CurrentTime(TRUE);
	
	nowDateYr 		 := nowDate DIV 10000;
	nowDateMonth   := (nowDate DIV 100 ) % 100;
	nowDateDay   	 := nowDate % 100;
	nowTimeHr   	 := nowTime DIV 10000;
	nowTimeMin	 	 := (nowTime DIV 100 ) % 100;
	nowTimeSec	 	 := nowTime % 100;
		
	dateSecs := STD.Date.SecondsFromParts(nowDateYr, nowDateMonth, nowDateDay, nowTimeHr, nowTimeMin, nowTimeSec) : INDEPENDENT; // ensure date/time is only computed once for this set of records
	dateYYYYMMDDHHMMSS 					:= DATASET([STD.Date.CreateDateTimeFromSeconds(dateSecs)])[1];
	dateYYYYMMDDHHMMSSMinusSec 	:= DATASET([STD.Date.CreateDateTimeFromSeconds(dateSecs - 1)])[1];
	dateYYYYMMDD 								:= DATASET([STD.Date.CreateDateTimeFromSeconds(dateSecs)])[1];
	dateYYYYMMDDMinusDay 				:= DATASET([STD.Date.CreateDateTimeFromSeconds(dateSecs - 86400)])[1];
	
	isYYYYMMDDHHMMSS := dt_resolution = 'YYYYMMDDHHMMSS';
	isYYYYMMDD       := dt_resolution = 'YYYYMMDD';
	newDateMinus 	:= MAP(isYYYYMMDDHHMMSS => (UNSIGNED6)(dateYYYYMMDDHHMMSSMinusSec.year*10000000000 + dateYYYYMMDDHHMMSSMinusSec.month*100000000 + dateYYYYMMDDHHMMSSMinusSec.day*1000000 + dateYYYYMMDDHHMMSSMinusSec.hour*10000 + dateYYYYMMDDHHMMSSMinusSec.minute*100 + dateYYYYMMDDHHMMSSMinusSec.second),
											 isYYYYMMDD 			=> (UNSIGNED4)(dateYYYYMMDDMinusDay.year*10000 + dateYYYYMMDDMinusDay.month*100 + dateYYYYMMDDMinusDay.day),
											 0);
	newDate 			:= MAP(isYYYYMMDDHHMMSS => (UNSIGNED6)(dateYYYYMMDDHHMMSS.year*10000000000 + dateYYYYMMDDHHMMSS.month*100000000 + dateYYYYMMDDHHMMSS.day*1000000 + dateYYYYMMDDHHMMSS.hour*10000 + dateYYYYMMDDHHMMSS.minute*100 + dateYYYYMMDDHHMMSS.second),
											 isYYYYMMDD 			=> (UNSIGNED4)(dateYYYYMMDD.year*10000 + dateYYYYMMDD.month*100 + dateYYYYMMDD.day),
											 0);
	
	joinCondition := SALT39.fn_CSVToJoinCondition(fieldList);
	beforeOnlyRecs := JOIN(dsBefore, dsAfter, #EXPAND(joinCondition), TRANSFORM(LEFT), LEFT ONLY, HASH);
	afterOnlyRecs  := JOIN(dsBefore, dsAfter, #EXPAND(joinCondition), TRANSFORM(RIGHT), RIGHT ONLY, HASH);
	
	beforeOnlyRecs_endDate := PROJECT(beforeOnlyRecs,
	                                  TRANSFORM(RECORDOF(beforeOnlyRecs),
																		          // if record was previously end-dated, keep that date
																		          SELF.dt_late := IF(LEFT.dt_late > 0 AND newDateMinus > LEFT.dt_late, LEFT.dt_late, newDateMinus),
																							SELF := LEFT));
	afterOnlyRecs_startDate := PROJECT(afterOnlyRecs,
	                                   TRANSFORM(RECORDOF(beforeOnlyRecs),
																							 // new record always gets new date
																							 SELF.dt_early := newDate,
																							 SELF := LEFT));
																							
	RETURN beforeOnlyRecs_endDate & afterOnlyRecs_startDate;
	
ENDMACRO;
