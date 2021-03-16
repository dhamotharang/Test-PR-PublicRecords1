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

	c1 := DISTRIBUTE(newbase, HASH32(CaseID)); 
	// find most recent version of the new case
	newcases := DEDUP(SORT(c1, CaseId,ProgramState,ProgramCode,GroupId,-$.fn_lfnversion(filename), local),
									CaseId,ProgramState,ProgramCode,GroupId, local);

	// only update the most recent case records
	trecent := table(base, {caseid, clientid, GroupId, programState, programCode,
							earliest := MIN(GROUP, startdate), latest := MAX(GROUP, enddate)}, caseid, clientid, GroupId, programState, programCode);
	recent := JOIN(DISTRIBUTE(base, hash32(caseid,clientid)), DISTRIBUTE(trecent, hash32(caseid,clientid)),
						left.caseid=right.caseid AND left.clientid=right.clientid AND left.GroupId=right.GroupId
						AND left.programState=right.programState AND left.programCode=right.programCode 
						AND left.enddate=right.latest,
						TRANSFORM(nac_V2.layout_base2, self := left), INNER, local);

	notrecent := JOIN(DISTRIBUTE(base, hash32(caseid,clientid)), DISTRIBUTE(trecent, hash32(caseid,clientid)),
						left.caseid=right.caseid AND left.clientid=right.clientid AND left.GroupId=right.GroupId
						AND left.programState=right.programState AND left.programCode=right.programCode 
						AND left.enddate<>right.latest,
						TRANSFORM(nac_V2.layout_base2, self := left), INNER, local);

	baseCases := DISTRIBUTE(recent,	HASH32(CaseId));

	updated := JOIN(baseCases, newcases, 
							LEFT.CaseId = right.CaseId AND LEFT.GroupId = RIGHT.GroupId AND
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode, 
							TRANSFORM($.Layout_Base2,
								// update existing cases with new case data
								self.case_Monthly_Allotment := RIGHT.case_Monthly_Allotment;
								self.RegionCode := RIGHT.RegionCode;
								self.CountyCode := RIGHT.CountyCode;
								self.CountyName := RIGHT.CountyName;
								self.case_Phone1 := RIGHT.case_Phone1;
								self.case_Phone2 := RIGHT.case_Phone2;
								self.case_Email := RIGHT.case_Email;
								
								self.Created := LEFT.Created;
								self.Updated := Std.Date.Today();
								self.FileName := IF(LEFT.FileName<>'',LEFT.FileName, right.FileName);	// keep original filename
								self.NCF_FileDate := IF(RIGHT.NCF_FileDate=0,LEFT.NCF_FileDate, right.NCF_FileDate);
								self.NCF_FileTime := IF(RIGHT.NCF_FileTime='',LEFT.NCF_FileTime, right.NCF_FileTime);

								//*** Update addresses
								
								self := left;
						),
							INNER, KEEP(1), LOCAL);
							
//		notcurrent := base(StartDate > std.date.Today() OR EndDate < std.date.Today());
									
	return updated + notrecent;

END;