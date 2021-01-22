import Relationship, _Control;
export proc_suppressKey(dataset(Layout_GetRelationship.interfaceOutputNeutral) inDS) := MODULE
	
  shared suppressKey := proc_getRelationshipSuppressions();
  
	// Suppression applied to Relative file
  shared suppressrec := record
    Layout_GetRelationship.interfaceOutputNeutral;
		boolean isSuppressed;
	end;	

	boolean asIndex := IF(thorlib.nodes() < 400 OR COUNT(inDS) < 13000000, TRUE, FALSE);

	Suppress1 := join(inDS,suppressKey,
	                         left.did1=right.did1 AND left.did2=right.did2,
									         transform(suppressrec,self.isSuppressed := right.did2 > 0,self:=left),
													           left outer,KEYED, Limit(10000));
	Suppress2 := join(Suppress1,suppressKey,
	                         left.did1=right.did2 AND left.did2=right.did1,
									         transform(suppressrec,
										                 self.isSuppressed := left.isSuppressed OR right.did1 > 0,
															       self:=left),left outer,KEYED, limit(10000));

	// #IF(__TARGET_PLATFORM__ in ['thor', 'thorlcr'])
	#IF(_Control.ThisEnvironment.IsPlatformThor)
		/* local join implementation for larger inputs */
		inDist := DISTRIBUTE(inDS, hash(did1, did2));
		keyDist := DISTRIBUTE(suppressKey, hash(did1, did2));
		Suppress1Local := join(inDist,keyDist,
														left.did1=right.did1 AND left.did2=right.did2,
														transform(suppressrec,self.isSuppressed := right.did2 > 0,self:=left),
																			left outer, LIMIT(10000), LOCAL);
		Suppress2Local := join(Suppress1Local,keyDist,
														left.did1=right.did2 AND left.did2=right.did1,
														transform(suppressrec,
																			self.isSuppressed := left.isSuppressed OR right.did1 > 0,
																			self:=left),left outer, LIMIT(10000), LOCAL);
																		
		suppress := IF(asIndex, suppress2, suppress2local);
	#ELSE 
			suppress := suppress2;
	#END;
	EXPORT run  := project(suppress(NOT isSuppressed),Layout_GetRelationship.interfaceOutputNeutral);	
	
end;