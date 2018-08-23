/*
Update Logic
Only two possibilities, in that “U” and “D” Update Type values define the purpose of the record.
The purpose of this is to allow a state/program to flag a match/collision as already confirmed invalid for some valid reason.
Because of the match criteria for twins in different cases would treat them as possible match/collision, 
  this is the means by which a state/program can flag such a match as already investigated and confirmed allowed or invalid.

*/
import STD;
EXPORT Process_ExceptionRecords(DATASET(Layouts2.rExceptionEx) inrec) := FUNCTION

  deletes := inrec(updateType='D');
	updates := inrec(updateType='U');

	exceptions := Files('').dsExceptionRecords; 
	j1 := IF(EXISTS(deletes),
				JOIN(exceptions, deletes,
						left.SourceProgramState=right.SourceProgramState and left.SourceProgramCode=right.SourceProgramCode 
						and left.SourceClientId=right.SourceClientid
						and left.MatchedState=right.MatchedState and left.MatchedProgramCode=right.MatchedProgramCode
						and left.MatchedClientID=right.MatchedClientId,
						TRANSFORM(Layouts2.rExceptionEx,
							self.UpdateType := IF(right.UpdateType='D', 'D', left.UpdateType);		// mark as deleted
							self.replaced := IF(right.UpdateType='D',Std.Date.Today(), 0);
							self := LEFT;),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						exceptions);

	e1 := j1(UpdateType <> 'D');
	
	// look for updates
		e2 := IF(EXISTS(updates),
				JOIN(e1, updates,
						left.SourceProgramState=right.SourceProgramState and left.SourceProgramCode=right.SourceProgramCode 
						and left.SourceClientId=right.SourceClientid
						and left.MatchedState=right.MatchedState and left.MatchedProgramCode=right.MatchedProgramCode
						and left.MatchedClientID=right.MatchedClientId,
						TRANSFORM(Layouts2.rExceptionEx,
								self.SourceProgramState := IF(RIGHT.SourceProgramState='',LEFT.SourceProgramState,RIGHT.SourceProgramState);
								self.SourceProgramCode := IF(RIGHT.SourceProgramState='',LEFT.SourceProgramCode,RIGHT.SourceProgramCode);
								self.SourceClientId := IF(RIGHT.SourceProgramState='',LEFT.SourceClientId,RIGHT.SourceClientId);
								self.MatchedState := IF(RIGHT.SourceProgramState='',LEFT.MatchedState,RIGHT.MatchedState);
								self.MatchedProgramCode := IF(RIGHT.SourceProgramState='',LEFT.MatchedProgramCode,RIGHT.MatchedProgramCode);
								self.MatchedClientID := IF(RIGHT.SourceProgramState='',LEFT.MatchedClientID,RIGHT.MatchedClientID);
												
								self.ReasonCode := IF(RIGHT.SourceProgramState='',LEFT.ReasonCode,RIGHT.ReasonCode);
								self.Comments := IF(RIGHT.SourceProgramState='',LEFT.Comments,RIGHT.Comments);

								self.UpdateType := 'U';
								
								self.Created := IF(RIGHT.SourceProgramState='',LEFT.Created,
																	IF(LEFT.SourceProgramState='',Std.Date.Today(), left.Created));
								self.Updated := IF(RIGHT.SourceProgramState='',LEFT.Updated,Std.Date.Today());
								
								self.Errors := IF(RIGHT.SourceProgramState='',LEFT.Errors,RIGHT.Errors);
								self.Warnings := IF(RIGHT.SourceProgramState='',LEFT.Warnings,RIGHT.Warnings);
									
							),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						e1);
						
	// now look for new ones
	e3 := IF(EXISTS(updates),
				JOIN(e2, updates,
						left.SourceProgramState=right.SourceProgramState and left.SourceProgramCode=right.SourceProgramCode 
						and left.SourceClientId=right.SourceClientid
						and left.MatchedState=right.MatchedState and left.MatchedProgramCode=right.MatchedProgramCode
						and left.MatchedClientID=right.MatchedClientId,
						TRANSFORM(Layouts2.rExceptionEx,								
								self := RIGHT;
						),
						RIGHT ONLY),
						e2);

	return e2 + e3;

END;