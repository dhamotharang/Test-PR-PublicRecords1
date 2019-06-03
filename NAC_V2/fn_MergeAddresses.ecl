/*
Update Logic
There is no special update logic for Address Records.  
The latest received set of Address Records for a Case or Client are considered to be the whole truth,
  always treated as an update/replacement for previous Addresses if any exist.  
For example, if a prior submission had separate Physical and Mailing addresses assigned to a Case, 
  and a single Address Record is submitted for that Case, it becomes the lone Address Record for that case.

To ensure each NCF2 can be validated alone, if the Address Record is related to a Case, 
  that Case/Household Record should be submitted, too.  
If related to a Client, then that Client/Individual Record should be submitted.  
Note that submission of a Client/Individual Record similarly requires its Case/Household Record to be submitted, as well.

If easier to process, sending the entire Case data to update an Address—that is, the Case/Household Record, 
  all Client/Individual Records, and all updated Address Records—can be submitted to update the Address(es).


*/
IMPORT Std;
EXPORT fn_MergeAddresses(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base) := FUNCTION
	
	// addresses that apply to cases, not clients
	caseAddr := DISTRIBUTE(newbase(ClientId=''), HASH32(ProgramState, ProgramCode, CaseID));

	addresses := DISTRIBUTE(base,HASH32(ProgramState, ProgramCode, CaseID)); 
	
	/*
		Determine which address records are unchanged
		Do not process records that have previously been replaced
	*/
	unchanged := JOIN(addresses, caseAddr,
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
										and LEFT.CaseId = RIGHT.CaseId,
								TRANSFORM($.Layout_Base2, self := LEFT;),
								LEFT ONLY, LOCAL);
								
	newCaseAddress := JOIN(addresses, caseAddr,
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
										and LEFT.CaseId = RIGHT.CaseId,
								TRANSFORM($.Layout_Base2, self := RIGHT;),
								RIGHT ONLY, LOCAL);

	updatedCaseAddress := JOIN(addresses, caseAddr,
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
										and LEFT.CaseId = RIGHT.CaseId,
								TRANSFORM($.Layout_Base2,
										self.replaced := Std.Date.Today();
										self := LEFT;),
								INNER, LOCAL);


	return unchanged + newCaseAddress + updatedCaseAddress;		// unchanged addresses + replaced + new addresses

END;