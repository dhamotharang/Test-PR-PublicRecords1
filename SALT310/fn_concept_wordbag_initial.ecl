/*2011-05-13T12:52:06Z (Manish Shah)
Updated logic for init match.
*/
// a)	We have to provide specificities for both left and right strings (we cannot assume they will be identical)
// b)	The 'force' now has to be an integer; not a Boolean (they will need to be able to specify a degree of forcing)
// c)	We will need to provide a Boolean to show whether a given position can be initial or not
// The way the scoring needs to work is:
// a)	If linit is false (no initial) and lnne1 (nulls not allowed) is false then the fields must match score is the spec for the field
// b)	If linit is false (no initial) and lnne1 is true then the fields must match or one side by blank score is zero
// c)	If linit is true and lnne1 is false then the shorter side must be the leading component of the longer; the score is then the spec of the shorter side
// d)	If linit is true and lnne1 is true and one side is null then score is 0
// e)	In all cases the eventual score for the field must be >= to the lfor for the given field
// a)	Any that do not allow nulls or initials and have a force
// b)	Do not allow nulls or initials but have no force (ie null=null is ok)
// c)	Any with a force but allow nulls no initials
// d)	Any with a force and allow initials
export fn_concept_wordbag_initial := module
export FailedForce := -9999;
export Failed := -1;
export  Match1L( StrType L1, unsigned2 lspec1, boolean lnne1, integer lfor1, Boolean linit1, StrType R1, unsigned2 rspec1) := FUNCTION
	
	result1 := map( L1 = R1 => if(lspec1 >  lfor1, min(lspec1,rspec1), FailedForce), 
								 length(R1) > length(L1) and L1 = R1[1..length(TRIM(L1))] => if(lspec1 >  lfor1, min(lspec1,rspec1), FailedForce),
								 length(L1) > length(R1) and R1 = L1[1..length(TRIM(R1))] => if(lspec1 >  lfor1, min(lspec1,rspec1), FailedForce),
								 Failed);
								 
	result := MAP ( 
							 not linit1 and not lnne1 and L1 = R1 							 	=> if(lspec1 >  lfor1, min(lspec1,rspec1), FailedForce),	// boolean linit - initial flag,  boolean lnnel - nulls not allowed flag
							 not linit1 and lnne1 and ( L1 = '' or R1 = '' ) 			=> 0,
							 not linit1 and lnne1 and L1 = R1 										=> if(lspec1 >  lfor1, min(lspec1,rspec1), FailedForce),
							 linit1 	and lnne1 and ( L1 = '' or R1 = '' ) 				=> 0,
							 linit1 																						=> result1,
							 lfor1 > 0 => FailedForce,
							 Failed );
	// output(result + ',L1 = ' + L1 + ',' + lspec1 + ', R1 = ' + r1 + ',' +rspec1);
	return result;
END;
				
export Match2L(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2) := FUNCTION
							
    L1BlankCost := IF ( lfor1 > 0, FailedForce, Failed );
	 L2BlankCost := IF ( lfor2 > 0, FailedForce, Failed );
	 
	 L1R1 := Match1L(L1,lspec1,lnne1,lfor1,linit1,R1, rspec1);
	 L1R2 := Match1L(L1,lspec1,lnne1,lfor1,linit1,R2, rspec2);
	 L2R1 := Match1L(L2,lspec2,lnne2,lfor2,linit2,R1, rspec1);
	 L2R2 := Match1L(L2,lspec2,lnne2,lfor2,linit2,R2, rspec2);
	 // r0 := if(max(L1R1, L1R2) > 0 and max(L2R1, L2R2) > 0, max(L1R1, L1R2) + max(L2R1, L2R2), FailedForce);
	 r0 := if(min(L1R1, L2R2) > 0,  L1R1 + L2R2, if(min(L1R2, L2R1) > 0, L1R2 + L2R1, FailedForce));
	 
	 result := MAP(not lnne1  and not linit1  and lfor1 > 0 	     => r0,
								L1 = '' 																			=> IF ( lnne1, MAX( L2R1, L2R2 ), L1BlankCost ),
								L2 = '' 																			=> IF ( lnne2, MAX( L1R1, L1R2 ), L2BlankCost ),
								R1 = '' 					 														=> MAX ( IF ( lnne1, L2R2, L1BlankCost ), IF ( lnne2, L1R2, L2BlankCost ) ),
								R2 = '' 					 														=> MAX ( IF ( lnne1, L2R1, L1BlankCost ), IF ( lnne2, L1R1, L2BlankCost ) ),							
								linit1 or linit2                                => r0,
								L1 = R1 and L2 = R2  												=> if(lspec1+lspec2 > lfor1, min(lspec1, rspec1) + min(lspec2, rspec2), FailedForce), 
								L1 = R2 AND L2 = R1 													=> if(lspec1+lspec2 > lfor1, min(lspec1, rspec2) + min(lspec2, rspec1), FailedForce), 
								lfor1 > 0 or lfor2 > 0 											=> FailedForce,
								Failed );
   // output(r0);									
   // output(result);									
	return result;
END;
// Used when coming in from outside; need to try both left and right being the correct way around
export Match2(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2
							) :=
							MAX( 
									 Match2L(L1,lspec1,lnne1,lfor1,linit1,L2,lspec2,lnne2,lfor2,linit2,R1,rspec1,R2,rspec2),
									 Match2L(R1,rspec1,lnne1,lfor1,linit1,R2,rspec2,lnne2,lfor2,linit2,L1,lspec1,L2,lspec2)
									 );
shared stringCompare(StrType L1, boolean init, boolean nne, StrType R1) := function
	substrR1     := length(R1) > length(L1) and L1 =R1[1..length(TRIM(L1))];
	substrL1     := length(L1) > length(R1) and R1 = L1[1..length(TRIM(R1))];
	
	result := map(not nne and (L1 = '' or R1 = '') => false,
							  L1 = '' or R1 = '' => false,
							  init and (substrL1 or substrR1) => true, 
							  L1 = R1 => true , 
							  false);
		
	// output(result + ',L1 = ' + L1 +  ', R1 = ' + r1 );
	return result;
end;
shared Match3L(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,
							StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,Boolean linit3,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3) := FUNCTION
	// Strategy - deal with L1 - and then two fields left, which is a solved problem ...
   L1BlankCost := IF ( lfor1 > 0, FailedForce, Failed );
	 L23R12 := Match2L(L2,lspec2,lnne2,lfor2,linit2,L3,lspec3,lnne3,lfor3,linit3,R1,rspec1,R2,rspec2);
	 L23R23 := Match2L(L2,lspec2,lnne2,lfor2,linit2,L3,lspec3,lnne3,lfor3,linit3,R2,rspec2,R3,rspec3);
	 L23R13 := Match2L(L2,lspec2,lnne2,lfor2,linit2,L3,lspec3,lnne3,lfor3,linit3,R1,rspec1,R3,rspec3);
	 
	 result :=	MAP ( L1 = '' => IF ( lnne1, MAX( L23R12, L23R23, L23R13 ), L1BlankCost ),
								stringCompare(L1,linit1,lnne1,R1) => IF ( L23R23 >= 0, L23R23+min(lspec1,rspec1), L23R23 ), // Ifs needed to carry back force and nneq conditions
								stringCompare(L1,linit1,lnne1,R2) => IF ( L23R13 >= 0, L23R13+min(lspec1,rspec2), L23R13 ),
								stringCompare(L1,linit1,lnne1,R3) => IF ( L23R12 >= 0, L23R12+min(lspec1,rspec3), L23R12 ),
								R1 = '' => IF ( lnne1, L23R23, L1BlankCost ), // Didn't like the other fields - so swallow the blank
								lfor1 > 0 => FailedForce,
								Failed );
	   // output(result);
		return result;
		END;
									 
export Match3(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,
							StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,Boolean linit3,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3
							) :=
							MAX(
									 Match3L(L1,lspec1,lnne1,lfor1,linit1,L2,lspec2,lnne2,lfor2,linit2,L3,lspec3,lnne3,lfor3,linit3,R1,rspec1,R2,rspec2,R3,rspec3),
									 Match3L(R1,rspec1,lnne1,lfor1,linit1,R2,rspec2,lnne2,lfor2,linit2,R3,rspec3,lnne3,lfor3,linit3,L1,lspec1,L2,lspec2,L3,lspec3)
								);
end;
