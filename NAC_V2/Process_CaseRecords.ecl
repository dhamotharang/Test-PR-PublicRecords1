/*

Update Logic
There is no special update logic for Case records.  
Because there are no dates, addresses, clients, and there is essentially little to impact other data, 
   they can be sent at any time.  

It is expected that if there are updates to previous Case records, it would be for the purpose of amending allotment amounts, 
  phone number(s), or email address information.

*/
import		STD;

EXPORT Process_CaseRecords(DATASET(Layouts2.rCaseEx) inrec) := FUNCTION

	cases := DISTRIBUTE(Files('').dsCaseRecords,HASH64(ProgramState, ProgramCode, CaseID)); 

	j := JOIN(cases, DISTRIBUTE(inrec, HASH64(ProgramState, ProgramCode, CaseID)),
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode and LEFT.CaseId = RIGHT.CaseId,
							TRANSFORM(Layouts2.rCaseEx,
								self.MonthlyAllotment := IF(RIGHT.ProgramState='',LEFT.MonthlyAllotment,RIGHT.MonthlyAllotment);
								self.RegionCode := IF(RIGHT.ProgramState='',LEFT.RegionCode,RIGHT.RegionCode);
								self.CountyCode := IF(RIGHT.ProgramState='',LEFT.CountyCode,RIGHT.CountyCode);
								self.CountyName := IF(RIGHT.ProgramState='',LEFT.CountyName,RIGHT.CountyName);
								self.Phone1 := IF(RIGHT.ProgramState='',LEFT.Phone1,RIGHT.Phone1);
								self.Phone2 := IF(RIGHT.ProgramState='',LEFT.Phone2,RIGHT.Phone2);
								self.Email := IF(RIGHT.ProgramState='',LEFT.Email,RIGHT.Email);
								self.ProgramState := Coalesce(LEFT.ProgramState, RIGHT.ProgramState);
								self.ProgramCode := Coalesce(LEFT.ProgramCode, RIGHT.ProgramCode);
								self.CaseId := Coalesce(LEFT.CaseId, RIGHT.CaseId);
								
								self.Created := IF(RIGHT.ProgramState='',LEFT.Created,
																	IF(LEFT.ProgramState='',Std.Date.Today(), left.Created));
								self.Updated := IF(RIGHT.ProgramState='',LEFT.Updated,Std.Date.Today());
								
								self.Errors := IF(RIGHT.ProgramState='',LEFT.Errors,RIGHT.Errors);
								self.Warnings := IF(RIGHT.ProgramState='',LEFT.Warnings,RIGHT.Warnings);
						),
							FULL OUTER, LOCAL);
									
	return j;

END;
