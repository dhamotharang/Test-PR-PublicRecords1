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
import STD;
EXPORT Process_ClientRecords(DATASET(Layouts2.rClientEx) inrec) := FUNCTION

	clnClient := PROJECT(DISTRIBUTE(Nac_V2.proc_cleanClients(inrec), HASH64(ProgramState, ProgramCode, CaseID, ClientId)),
									TRANSFORM(Layouts2.rClientEx,
											self.Created := Std.Date.Today();
											self.Updated := Std.Date.Today();
											self := LEFT;));
	
	clients := DISTRIBUTE(Files('').dsClientRecords,HASH64(ProgramState, ProgramCode, CaseId, ClientId)); 
	// find unchanged records
	unchanged := JOIN(clients, clnClient,
					left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId and left.ClientId=right.ClientId,
					TRANSFORM(Layouts2.rClientEx,
						self := left;), left only, local);

	newClients := JOIN(clients, clnClient,
					left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId and left.ClientId=right.ClientId,
					TRANSFORM(Layouts2.rClientEx,
							self := right;
						), right only, local);
						
	// find records with possible changes
	candidates := clients - unchanged;
	updates := clnClient - newClients;

	// do direct updates first with no change to eligibility
	// TO DO: add historical record for a name change
	directUpdates := JOIN(candidates, updates,
					left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId and left.ClientId=right.ClientId
					and left.StartDate=right.StartDate and left.EndDate=right.EndDate
					and left.Eligibility=right.Eligibility,
					TRANSFORM(Layouts2.rClientEx,
						self := right;), inner, local);
						
	// handle change to eligibility status
	// handle change to start date
	// handle change to end date
	remaining := JOIN(candidates, updates,		// temp for testing direct updates first
					left.ProgramState=right.ProgramState and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId and left.ClientId=right.ClientId
					and (left.StartDate<>right.StartDate OR left.EndDate<>right.EndDate
					or left.Eligibility<>right.Eligibility),
					TRANSFORM(Layouts2.rClientEx,
						self := right;), inner, local);

	result := unchanged + directUpdates + remaining + newClients;
OUTPUT(COUNT(candidates));
OUTPUT(updates);
	return result;
END;