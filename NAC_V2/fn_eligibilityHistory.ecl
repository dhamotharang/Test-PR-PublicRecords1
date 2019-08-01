IMPORT Std;

rEligibilityHistory := RECORD
	string2			ProgramState;
	string1			ProgramCode;
	string20		ClientId;
	Std.Date.Date_t			StartDate;
	Std.Date.Date_t			EndDate;
	string1			eligibility_status_indicator;			// E=Elibible, I=Ineligible Alien, D=Disqualified, N=Not Eligible, A=Applicant
	string1			PeriodType;				// M=Month, D=Date
  string			history := '';
END;

EXPORT fn_eligibilityHistory(DATASET($.Layout_Base2) base = nac_v2.files.Base2) := FUNCTION

	b2 := DISTRIBUTE(base, hash32(programstate, programcode, clientid));

	b3 := SORT(b2, programstate, programcode, clientid, -startdate, local);

	b := PROJECT(b3, TRANSFORM(rEligibilityHistory,
				his := left.eligibility_status_indicator + ':' +
							IF(left.PeriodType = 'M', ((string)left.StartDate)[1..6]+' ', (string)left.StartDate) + '-' +
							IF(left.PeriodType = 'M', ((string)left.EndDate)[1..6], (string)left.EndDate);
				self.history := (string20)his;
				self := left;
			));
			
		rEligibilityHistory	tHistory(rEligibilityHistory l, rEligibilityHistory r)	:= 
				transform
					self.history	:=	l.history + ',' + r.history;
					self := l;
				end;
				
		h		:=	rollup(b, tHistory(left, right), ProgramState,ProgramCode,ClientId, local);

		return h;
		
END;