IMPORT Std;
/*

Update Logic
There is no special update logic for Case records.  
Because there are no dates, addresses, clients, and there is essentially little to impact other data, 
   they can be sent at any time.  

It is expected that if there are updates to previous Case records, it would be for the purpose of amending allotment amounts, 
  phone number(s), or email address information.

*/

EXPORT fn_MergeCases(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base) := FUNCTION

	cases := DISTRIBUTE(newbase, HASH32(ProgramState, ProgramCode, CaseID)); 
	// only update active cases
	current := DISTRIBUTE(base(StartDate <= std.date.Today(), EndDate >= std.date.Today()),
														HASH32(ProgramState, ProgramCode, CaseId));

	updated := JOIN(current, cases, 
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode and LEFT.CaseId = RIGHT.CaseId,
							TRANSFORM($.Layout_Base2,
								self.case_Monthly_Allotment := IF(RIGHT.ProgramState='',LEFT.case_Monthly_Allotment,RIGHT.case_Monthly_Allotment);
								self.RegionCode := IF(RIGHT.ProgramState='',LEFT.RegionCode,RIGHT.RegionCode);
								self.CountyCode := IF(RIGHT.ProgramState='',LEFT.CountyCode,RIGHT.CountyCode);
								self.CountyName := IF(RIGHT.ProgramState='',LEFT.CountyName,RIGHT.CountyName);
								self.case_Phone1 := IF(RIGHT.ProgramState='',LEFT.case_Phone1,RIGHT.case_Phone1);
								self.case_Phone2 := IF(RIGHT.ProgramState='',LEFT.case_Phone2,RIGHT.case_Phone2);
								self.case_Email := IF(RIGHT.ProgramState='',LEFT.case_Email,RIGHT.case_Email);
								
								self.Created := LEFT.Created;
								self.Updated := IF(RIGHT.ProgramState='',LEFT.Updated,Std.Date.Today());
								self.FileName := IF(RIGHT.FileName='',LEFT.FileName, right.FileName);
								self.GroupId := IF(RIGHT.GroupId='',LEFT.GroupId,RIGHT.GroupId);
								self := left;
						),
							LEFT OUTER, LOCAL);
							
	new := JOIN(current, cases, 
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode and LEFT.CaseId = RIGHT.CaseId,
							TRANSFORM($.Layout_Base2,
								self := right;
						),
						RIGHT ONLY, LOCAL);

							
		notcurrent := base(StartDate > std.date.Today() OR EndDate < std.date.Today());

									
	return updated + notcurrent + new;

END;