IMPORT Std;
/*

Update Logic
In the original NAC NCF, for which a record per Client per month could be expected, 
  update logic was straightforward because of the one-record/ one-month nature of the data.  
Typically, provided to the NAC would be Clients with a Client Eligibility Indicator of “E” (Eligible) 
 along with those of “I” (Ineligible Alien) especially for the purpose of including an ineligible Head of Household
 in the case along with eligible dependent children.

The typical update for NCF, if any, was an update to the address/phone/email, 
 or to send corrected/updated Client DOB and Client SSN values when the actual values were not initially available (i.e. Pseudo).  
Additional updates would be provided to reverse eligibility from “E” to “N” (Not Eligible) 
  for a specific benefit month if such a correction was needed after the “E” record was already contributed to the NAC.

The NC2NCF2 must accommodate different types of updates to accomplish two of the goals of its layout versus the NCF:

1.	Multiple program types with different benefit period types, months and dates
2.	Use of future/anticipated benefit period end, subject to change over time
We must accommodate the ability to amend and extend eligibility over time, 
  while allowing editing or reversing previously sent timeframes.  
  For these possibilities, rules and expectations must be defined and documented, 
  all with the intent that all involved understand what to expect and how to arrive at desired results.

Client Record Fields That Impact Updates
========================================
The Client Record CL01 has fields that must be populated properly to affect an update to a previously sent record for that client.
Program State, Code, Case Id, and Clent Id are required Key Field that must match if change desired

Client Eligibility Indicator					May be edited to change previously sent record
Client Eligibility Period Type				If editing previous, must match previous
Client Eligibility Start Date/Month		If editing previous, must match previous
Client Eligibility End Date/Month			If editing previous, may be different to affect change

Not surprisingly, the first four fields are required if the contributed Client Record is intended to update a previously sent record.
  If there is no match it will be considered a new record, inserted into the NAC data.

The other fields play different roles, depending upon their values and the intent of the contributor.
  For example, the Client Eligibility Indicator may be changed, but the Client 
   Eligibility Start Date/Month and Client Eligibility End Date/Month may be same or different,
   depending upon the purpose of the update.

Consider the NAC has received and processed a record with the following values:
	Eligibility Indicator			E
	StartDate									201501
	EndDate										201506

Indirect Update/Overwrite
Let’s say that in March of 2015 it is determined that eligibility should end that month.
  One option is to actively submit a change to the Client Eligibility Indicator for the months that need to be changed:
	Eligibility Indicator			N
	StartDate									201504
	EndDate										201506

[NOTE: This option is in dispute. Also, It would require a new client record and an update to the current one.]
	Eligibility Indicator			E					N
	StartDate									201501		201504
	EndDate										201503		201506


Direct Update to Prior Record
Another option would be to send an update to the original record.
  However, to do so, the rule is the key fields and the Client Eligibility Start Date/Month field
   must equal the previous record sent:
	Eligibility Indicator			E
	StartDate									201501
	EndDate										201503

What if the Fields Do Not Match?
If all values are the same but the start/end dates are different, it’s considered new and not an update to the previous data.
Consider we start with the original one from above, with 201501 – 201506 presented as the start/end month.
Let’s say there’s some case reorganization or something else that causes a new period or recertification,
 generating a new record for a new eligibility period that does not undo the original.
	Eligibility Indicator			E
	StartDate									201505			// notice the overlap
	EndDate										201510


*/
// update with new client fields
$.Layout_Base2 xForm($.Layout_Base2 newbase, $.Layout_Base2 base)	 :=	TRANSFORM
//**** Case fields
	self.case_Monthly_Allotment := newbase.case_Monthly_Allotment;
	self.RegionCode := newbase.RegionCode;
	self.CountyCode := newbase.CountyCode;
	self.CountyName := newbase.CountyName;
	self.case_Phone1 := newbase.case_Phone1;
	self.case_Phone2 := newbase.case_Phone2;
	self.case_Email := newbase.case_Email;
								
//**** Client fields
	self.StartDate 	:=	newbase.StartDate;
	self.EndDate		:=	newbase.EndDate;
	self.StartDate_Raw		:=	newbase.StartDate_Raw;
	self.EndDate_Raw		:=	newbase.EndDate_Raw;
	self.LastName		:=	newbase.LastName;
	self.FirstName		:=	newbase.FirstName;
	self.MiddleName		:=	newbase.MiddleName;
	self.NameSuffix		:=	newbase.NameSuffix;
	self.Gender		:=	newbase.Gender;
	self.Race		:=	newbase.Race;
	self.Ethnicity		:=	newbase.Ethnicity;
	
	self.ssn		:=	newbase.ssn;
	self.ssn_Type_indicator		:=	newbase.ssn_Type_indicator;
	self.dob		:=	newbase.dob;
	self.dob_Type_indicator		:=	newbase.dob_Type_indicator;
	self.Certificate_id_type		:=	newbase.Certificate_id_type;
	
	self.Relationship		:=	newbase.Relationship;
	self.ABAWDIndicator		:=	newbase.ABAWDIndicator;
	self.MonthlyAllotment		:=	newbase.MonthlyAllotment;
	self.eligibility_status_indicator		:=	newbase.eligibility_status_indicator;
	self.eligibility_status_date		:=	newbase.eligibility_status_date;

	self.PeriodType		:=	newbase.PeriodType;
	self.HistoricalBenefitCount		:=	newbase.HistoricalBenefitCount;
	self.client_Phone		:=	newbase.client_Phone;
	self.client_Email		:=	newbase.client_Email;
	// derived fields
	self.clean_ssn		:=	newbase.clean_ssn;
	self.best_ssn		:=	newbase.best_ssn;
	self.clean_dob		:=	newbase.clean_dob;
	self.age		:=	newbase.age;
	self.best_dob		:=	newbase.best_dob;
	self.title		:=	newbase.title;
	self.prefname		:=	newbase.prefname;
	self.fname		:=	newbase.fname;
	self.mname		:=	newbase.mname;
	self.lname		:=	newbase.lname;
	self.name_suffix		:=	newbase.name_suffix;
	
	self.updated := newbase.created;
	self.filename := base.filename;		// keep original filename
	self.NCF_FileDate := newbase.NCF_FileDate;
	self.NCF_FileTime := newbase.NCF_FileTime;

	self := base;

END;

ver1_MergeClients(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base) := FUNCTION
	c1 := DISTRIBUTE(newbase, HASH32(ClientId)); 
	clients := DEDUP(SORT(c1, ClientId,CaseId,ProgramState,ProgramCode,GroupId,StartDate,EndDate,-$.fn_lfnversion(filename), local),
									ClientId,CaseId,ProgramState,ProgramCode,GroupId,StartDate,EndDate, local);
	
	current := DISTRIBUTE(base,HASH32(ClientId));
	
	// find unchanged records
	unchanged := JOIN(current, clients,
					left.ClientId=right.ClientId and left.caseId=right.CaseId 
					and left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and left.GroupId=right.GroupId,
					TRANSFORM($.Layout_Base2,
						self := left;), left only, local);

	newClients := JOIN(current, clients,
					left.ClientId=right.ClientId and left.caseId=right.CaseId 
					and left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and left.GroupId=right.GroupId,
					TRANSFORM($.Layout_Base2,
							self.Created := RIGHT.Created;
							self := right;
						), right only, local);
						
	// find records with possible changes
	candidates := current - unchanged;		// base files that could be updated
	updates := clients - newClients;			// new files to update base file

	// do direct updates first with no change to eligibility
	// TO DO: add historical record for a name change
	directUpdates := JOIN(candidates, updates,
					left.ClientId=right.ClientId and left.caseId=right.CaseId 
					and left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and left.GroupId=right.GroupId
					and left.StartDate=right.StartDate and left.EndDate=right.EndDate
					and left.eligibility_status_indicator=right.eligibility_status_indicator,
					xForm(RIGHT, LEFT),
					inner, local);
						
	// handle change to eligibility status
	// handle change to start date
	// handle change to end date
	remaining := JOIN(candidates, updates,		// temp for testing direct updates first
					left.ClientId=right.ClientId and left.caseId=right.CaseId 
					and left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and left.GroupId=right.GroupId
					and (left.StartDate<>right.StartDate OR left.EndDate<>right.EndDate
					or left.eligibility_status_indicator<>right.eligibility_status_indicator),
					xForm(RIGHT, LEFT),
					inner, local);

	result := unchanged + directUpdates + remaining + newClients;

	return result;
END;

/**
	set the case name from the HOH indicator
**/
SetCaseName(DATASET(nac_V2.Layout_Base2) base) := FUNCTION
	hoh := DISTRIBUTE(base(hoh_indicator='Y'),hash32(groupid,caseid));
	nothoh := DISTRIBUTE(base(hoh_indicator<>'Y'),hash32(groupid,caseid));

	j := JOIN(nothoh, hoh, left.groupid=right.groupid AND left.caseid=right.caseid AND left.programcode=right.programcode AND
							left.startdate=right.startdate and left.enddate=right.enddate,
						TRANSFORM(nac_V2.Layout_Base2,
							self.case_Last_Name := right.LastName;
							self.case_First_Name := right.FirstName;
							self.case_Middle_Name := right.MiddleName;
							self.case_Name_Suffix := right.NameSuffix;
							self := left;),
							LEFT OUTER, KEEP(1), LOCAL);
		return hoh + j;
END;

EXPORT fn_MergeClients(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base) := FUNCTION
	clients := DISTRIBUTE(SetCaseName(newbase), HASH32(GroupId, CaseId, ClientId)); // new client records
	
	current := DISTRIBUTE(base(clientid<>''),HASH32(GroupId, CaseId, ClientId)); // in current base file
	
	// find unchanged records
	unchanged := JOIN(current, clients,
					left.GroupId=right.GroupId AND
					left.caseId=right.caseId and left.ClientId=right.ClientId 
					and left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode,
					TRANSFORM(nac_v2.Layout_Base2,
						self := left;), left only, local);

// new client, case 
	newClients := JOIN(current, clients,
					left.GroupId=right.GroupId AND
					left.caseId=right.caseId and left.ClientId=right.ClientId 
					and left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode,
					TRANSFORM(nac_v2.Layout_Base2,
							self.Created := RIGHT.Created;
							self := right;
						), right only, local);
						
	// find records with possible changes
//	candidates := DISTRIBUTE(current - unchanged,HASH32(GroupId, CaseId, ClientId));		// base files that could be updated
		candidates := 
				JOIN(current, clients,
					left.GroupId=right.GroupId AND
					left.caseId=right.caseId and left.ClientId=right.ClientId 
					and left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode,
					TRANSFORM(nac_v2.Layout_Base2,
						self := left;), inner, local);
		
	updates := DISTRIBUTE(clients - newClients,HASH32(GroupId, CaseId, ClientId));			// new files to update base file

// only update if timeframe overlaps
	directUpdates := JOIN(candidates, updates,
					left.GroupId=right.GroupId AND
					left.caseId=right.caseId and left.ClientId=right.ClientId 
					and left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and	left.StartDate <= right.EndDate and left.EndDate >= right.StartDate,
					xForm(RIGHT, LEFT),
					inner, local);
// different timeframe, so new base records
	remaining := JOIN(updates, directUpdates,
					left.GroupId=right.GroupId AND
					left.caseId=right.caseId and left.ClientId=right.ClientId 
					and left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and	left.StartDate <= right.EndDate and left.EndDate >= right.StartDate,
					TRANSFORM(nac_v2.Layout_Base2,
						self := left;), left only, local);
// did not get modified
asis := JOIN(candidates,updates,
					left.GroupId=right.GroupId AND
					left.caseId=right.caseId and left.ClientId=right.ClientId 
					and left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and	left.StartDate <= right.EndDate and left.EndDate >= right.StartDate,
					TRANSFORM(nac_v2.Layout_Base2,
						self := left;), left only, local);
	result := unchanged + directUpdates + remaining + asis + newClients;
/*OUTPUT(SORT(current(caseid='000967126'),clientid,startdate_raw), named('oldbasein'));
OUTPUT(SORT(newbase(caseid='000967126'),clientid,startdate_raw), named('newbasein'));
OUTPUT(SORT(clients(caseid='000967126'),clientid,startdate_raw), named('clientsin'));
OUTPUT(SORT(candidates(caseid='000967126'),clientid,startdate_raw), named('candidates'));
OUTPUT(SORT(updates(caseid='000967126'),clientid,startdate_raw), named('updates'));
OUTPUT(SORT(unchanged(caseid='000967126',startdate_raw='202012'),clientid,startdate_raw), named('unchanged'));
OUTPUT(SORT(directUpdates(caseid='000967126',startdate_raw='202012'),clientid,startdate_raw), named('directUpdates'));
OUTPUT(SORT(remaining(caseid='000967126',startdate_raw='202012'),clientid,startdate_raw), named('remaining'));
OUTPUT(SORT(asis(caseid='000967126',startdate_raw='202012'),clientid,startdate_raw), named('asis'));
OUTPUT(SORT(newClients(caseid='000967126',startdate_raw='202012'),clientid,startdate_raw), named('newClients'));
*/
	return result(clientId<>'');
END;