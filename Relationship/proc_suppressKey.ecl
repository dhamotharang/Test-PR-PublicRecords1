import Relationship;
export proc_suppressKey(dataset(Layout_GetRelationship.interfaceOutputNeutral) inDS) := MODULE
	
  shared suppressKey := proc_getRelationshipSuppressions();
  
	// Suppression applied to Relative file
  shared suppressrec := record
    Layout_GetRelationship.interfaceOutputNeutral;
		boolean isSuppressed;
	end;	
	shared Suppress1 := join(inDS,suppressKey,
	                         left.did1=right.did1 AND left.did2=right.did2,
									         transform(suppressrec,self.isSuppressed := right.did2 > 0,self:=left),
													           left outer,KEYED);
	shared Suppress2 := join(Suppress1,suppressKey,
	                         left.did1=right.did2 AND left.did2=right.did1,
									         transform(suppressrec,
										                 self.isSuppressed := left.isSuppressed OR right.did1 > 0,
															       self:=left),left outer,KEYED);
 
	EXPORT run  := project(Suppress2(NOT isSuppressed),Layout_GetRelationship.interfaceOutputNeutral);	
	
end;