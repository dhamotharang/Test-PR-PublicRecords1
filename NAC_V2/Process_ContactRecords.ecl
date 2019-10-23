import STD;
/*

Update Logic
The goal of the State Contact Record is to allow this data to be managed easily by the managers and contributors of the program data.  To that end, the Update Type field directs the NAC system how the information in the SC01 record to be handled.
There are three possible values for Update Type, and it must be populated with one of these:
--	U = Update
--	D = Delete
--	O = Override

The Update value is the most straightforward Update Type.
It simply means that for the assignment values provided (Program, Region, County, etc), 
  the data provided is to replace any that previously exists for that assignment.
If no prior data exists, the record will be added.

The Delete value allows for the removal of a particular contact assignment.
It is an instruction to remove any previous state contact record for the assignment values provided (Program, Region, County, etc).  In this record type, the State Contact fields (Name, Phone, Email) are ignored.  Note, however, that at least one default State Contact record must exist for each program in each state.

The Override value allows for a resetting at that assignment level (Program, Region, County, etc).
It is a combination of Update for that assignment level and a cascade delete of all State Contact records for assignments below that in the hierarchy.
In other words, if an Override comes in for a state and program with no Region/County/Case/Client values, 
  then a single State Contact record for the entire program is all that will remain.  
Any prior State Contact records assigned to Region/County/Case/Client within that State/Program would be removed, 
  overridden by this new record.

*/
import	STD, ut;

boolean nonblank(string s1, string s2) := (TRIM(s1)<>'') and (TRIM(s2)<>'');

EXPORT Process_ContactRecords(DATASET($.Layouts2.rStateContactEx) inrec) := FUNCTION

	contacts := DISTRIBUTE($.Files2.dsContactRecords); 

	deletions := inrec(UpdateType='D');
	j1 := IF(EXISTS(deletions),
				JOIN(contacts, deletions,
						left.ProgramState = Right.ProgramState and left.ProgramCode=right.ProgramCode
						and left.ProgramRegion = Right.ProgramRegion and left.ProgramCounty=right.ProgramCounty
						and left.CaseId = Right.CaseId and left.ClientId=right.ClientId,
						TRANSFORM(Layouts2.rStateContactEx,
							self.UpdateType := IF(right.UpdateType='D', 'D', left.UpdateType);		// mark as deleted
							self.replaced := IF(right.UpdateType='D',Std.Date.Today(), 0);
							self := LEFT;),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						contacts);

	c1 := j1(UpdateType <> 'D');
	overrides := inrec(UpdateType='O');
	c2 := IF(EXISTS(overrides),
				JOIN(c1, overrides,
						left.ProgramState = Right.ProgramState and left.ProgramCode=right.ProgramCode,
						TRANSFORM(Layouts2.rStateContactEx,
							self.UpdateType := MAP(
									right.ProgramState = '' => left.UpdateType,			// no override
									//nonblank(left.ProgramRegion,right.ProgramRegion) => 'D',
									nonblank(right.ProgramRegion,left.ProgramCounty) => 'D',		// region overrides county
									nonblank(right.ProgramRegion+right.ProgramCounty,left.CaseId) => 'D', // region or county overrides case
									nonblank(right.ProgramRegion+right.ProgramCounty+right.CaseId,left.ClientId) => 'D', // region,county,case over clientid
									left.UpdateType);

								self.Created := IF(RIGHT.ProgramState='',LEFT.Created,
																	IF(LEFT.ProgramState='',Std.Date.Today(), left.Created));
								self.Updated := IF(RIGHT.ProgramState='',LEFT.Updated,Std.Date.Today());
								
								self.Errors := IF(RIGHT.ProgramState='',LEFT.Errors,RIGHT.Errors);
								self.Warnings := IF(RIGHT.ProgramState='',LEFT.Warnings,RIGHT.Warnings);
									
								self := IF(RIGHT.ProgramState='',LEFT, RIGHT);),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						c1);

	updates := inrec(UpdateType='U');
	c3 := IF(EXISTS(updates),
				JOIN(c2, updates,
						left.ProgramState = Right.ProgramState and left.ProgramCode=right.ProgramCode
						and left.ProgramRegion = Right.ProgramRegion and left.ProgramCounty=right.ProgramCounty
						and left.CaseId = Right.CaseId and left.ClientId=right.ClientId,
						TRANSFORM(Layouts2.rStateContactEx,
								self.ProgramState := IF(RIGHT.ProgramState='',LEFT.ProgramState,RIGHT.ProgramState);
								self.ProgramCode := IF(RIGHT.ProgramState='',LEFT.ProgramCode,RIGHT.ProgramCode);
								self.ProgramRegion := IF(RIGHT.ProgramState='',LEFT.ProgramRegion,RIGHT.ProgramRegion);
								self.ProgramCounty := IF(RIGHT.ProgramState='',LEFT.ProgramCounty,RIGHT.ProgramCounty);
								self.CaseId := IF(RIGHT.ProgramState='',LEFT.CaseId,RIGHT.CaseId);
								self.ClientId := IF(RIGHT.ClientId='',LEFT.ClientId,RIGHT.ClientId);
						
								self.ContactName := IF(RIGHT.ProgramState='',LEFT.ContactName,RIGHT.ContactName);
								self.ContactPhone := IF(RIGHT.ProgramState='',LEFT.ContactPhone,RIGHT.ContactPhone);
								self.ContactExt := IF(RIGHT.ProgramState='',LEFT.ContactExt,RIGHT.ContactExt);
								self.ContactEmail := IF(RIGHT.ProgramState='',LEFT.ContactEmail,RIGHT.ContactEmail);

								self.UpdateType := 'U';
								
								self.Created := IF(RIGHT.ProgramState='',LEFT.Created,
																	IF(LEFT.ProgramState='',Std.Date.Today(), left.Created));
								self.Updated := IF(RIGHT.ProgramState='',LEFT.Updated,Std.Date.Today());
								
								self.Errors := IF(RIGHT.ProgramState='',LEFT.Errors,RIGHT.Errors);
								self.Warnings := IF(RIGHT.ProgramState='',LEFT.Warnings,RIGHT.Warnings);
									
								self := LEFT;
							),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						c2);
						
	// now look for new ones
	c4 := IF(EXISTS(updates),
				JOIN(c3, updates,
						left.ProgramState = Right.ProgramState and left.ProgramCode=right.ProgramCode
						and left.ProgramRegion = Right.ProgramRegion and left.ProgramCounty=right.ProgramCounty
						and left.CaseId = Right.CaseId and left.ClientId=right.ClientId,
						TRANSFORM(Layouts2.rStateContactEx,								
								self := RIGHT;
						),
						RIGHT ONLY),
						c3);

	return c3 + c4;

END;