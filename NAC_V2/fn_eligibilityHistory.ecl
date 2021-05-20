IMPORT Std;

rEligibilityHistory := RECORD
	string2			ProgramState;
	string1			ProgramCode;
	string20		ClientId;
	Std.Date.Date_t			StartDate;
	Std.Date.Date_t			EndDate;
	string1			eligibility_status_indicator;			// E=Elibible, I=Ineligible Alien, D=Disqualified, N=Not Eligible, A=Applicant
	string1			PeriodType;				// M=Month, D=Date
	integer			TotalEligiblePeriodsDays := 0;
	integer			TotalEligiblePeriodsMonths := 0;
  string			history := '';
END;

rEligibilityHistorySlim := RECORD
	string2			ProgramState;
	string1			ProgramCode;
	string20		ClientId;
	string1			PeriodType;				// M=Month, D=Date
	integer			TotalEligiblePeriodsDays := 0;
	integer			TotalEligiblePeriodsMonths := 0;
  string			history := '';
END;
// year 2099 is treated as open ended
//	dats and months returned will be 0
integer GetDaysBetween(unsigned4 StartDate, unsigned4 EndDate) := FUNCTION
		EndYear := Std.Date.Year(EndDate);
		return IF(EndYear = 2099, 0,
							STD.Date.DaysBetween(StartDate, EndDate) + 1
						);
END;

integer GetMonthsBetween(unsigned4 StartDate, unsigned4 EndDate) := FUNCTION
		EndYear := Std.Date.Year(EndDate);
		return IF(EndYear = 2099, 0,
							STD.Date.MonthsBetween(StartDate, EndDate) + 1
						);
END;

EXPORT fn_eligibilityHistory(DATASET($.Layout_Base2) base = nac_v2.files.Base2) := FUNCTION

	b0 := DISTRIBUTE(base, HASH32(ProgramState, ProgramCode, ClientId));
	b01 := SORT(b0, 
						ProgramState, ProgramCode, ClientId, eligibility_status_indicator,
						-StartDate, LOCAL);
	b02 := ROLLUP(b01, 
									left.ProgramState=right.ProgramState AND left.ProgramCode=right.ProgramCode AND
											left.ClientId=right.ClientId AND
									left.eligibility_status_indicator=right.eligibility_status_indicator AND 
										STD.Date.MonthsBetween(left.StartDate, right.EndDate) = 0,
								TRANSFORM(Nac_v2.Layout_Base2,
											self.StartDate := right.StartDate;
											self.EndDate := max(left.EndDate,right.EndDate);
											self := left;), LOCAL);

	b2 := DISTRIBUTE(b02, hash32(programstate, programcode, clientid));

	b3 := SORT(b2, programstate, programcode, clientid, -startdate, local);

	b4 := PROJECT(b3, TRANSFORM(rEligibilityHistory,
				his := left.eligibility_status_indicator + ':' +
							IF(left.PeriodType = 'M', ((string)left.StartDate)[1..6]+' ', (string)left.StartDate) + '-' +
							IF(left.PeriodType = 'M', ((string)left.EndDate)[1..6], (string)left.EndDate);
				self.history := (string20)his;
				self.TotalEligiblePeriodsDays := IF(left.eligibility_status_indicator = 'E',
											GetDaysBetween(left.startdate, left.enddate), 0);
				self.TotalEligiblePeriodsMonths := IF(left.eligibility_status_indicator = 'E',
											GetMonthsBetween(left.startdate, left.enddate), 0);
				self := left;
			));
			
  b5 := DEDUP(SORT(b4, programstate, programcode, clientid, history, local), 
							programstate, programcode, clientid, history, local);
							
	b := SORT(b5, programstate, programcode, clientid, -startdate, local);
			
		rEligibilityHistory	tHistory(rEligibilityHistory l, rEligibilityHistory r)	:= 
				transform
					self.history	:=	l.history + ',' + r.history;
					self.TotalEligiblePeriodsDays := l.TotalEligiblePeriodsDays + r.TotalEligiblePeriodsDays;
					self.TotalEligiblePeriodsMonths := l.TotalEligiblePeriodsMonths + r.TotalEligiblePeriodsMonths;
					self := l;
				end;
				
		h		:=	rollup(b, tHistory(left, right), ProgramState, ProgramCode, ClientId, local);

		return PROJECT(h, rEligibilityHistorySlim);
		
END;