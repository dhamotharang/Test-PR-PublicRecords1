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
/*---------------------------------------- */
// Therefore IF we want initial supported for concept:bagofwords I propose a THIRD type of match function similar to Manish's _initial 
// variant but when only takes in ONE weight. Determining the weight for an initial -> initial match can then be (approximated) as follows:
// 1)	If the SHORTER string has the weight then use the weight of the shorter string
// 2)	If the longer string has the weight then multiply that weight by lengthofshorterstring/lengthoflongerstring
// This essentially asserts that a linear interpolation of weight along string length is correct. This is obviously not QUITE true
// A -> AL -> ALA -> ALAN
// This method would slightly overweight A & AL and underweight ALA but I think it might be a fairly acceptable approximation and 
// it has the advantage of feasibility ?
export fn_concept_wordbag_oneweight_EL := module
export FailedForce := -9999;
export Failed := -1;
shared getInitMatchWeight(StrType L1, unsigned2 lspec1, unsigned2 ispec1, StrType R1, unsigned2 rspec1) := function
	iWeight := map(lspec1 > 0 and rspec1 > 0 => min(lspec1, rspec1), 
	              (length(L1) > length(R1)) and rspec1 > 0 => rspec1, 
	              (length(L1) > length(R1)) and lspec1 > 0 => ((lspec1 - ispec1)/(length(L1) - 1)) * length(R1) + (ispec1* length(L1) - lspec1)/(length(L1) - 1),//lspec1 * length(r1)/length(l1), 
								(length(R1) > length(L1)) and lspec1 > 0 => lspec1,
								(length(R1) > length(L1)) and rspec1 > 0 => rspec1 * length(L1)/length(R1), 
								lspec1 > 0 => lspec1, 
								ispec1);
										
	// output('getInitMatchWeight_Result = ' + iWeight);
	return iWeight;
end;
export  Match1L( StrType L1, unsigned2 lspec1, boolean lnne1, integer lfor1, Boolean linit1, unsigned2 ispec1, StrType R1, unsigned2 rspec1) := FUNCTION
	// Wait based on StrType match
	init_weight := getInitMatchWeight(L1, lspec1, ispec1, R1, rspec1);
													
	weight := if(lspec1 > 0, lspec1, rspec1);
	minWeight := if(lspec1 > 0 and rspec1 > 0, min(lspec1,rspec1), weight);
	
	result1 := map( L1 = R1 => if(weight > lfor1, lspec1, FailedForce), 
								 length(R1) > length(L1) and L1 = R1[1..length(TRIM(L1))] => init_weight,
								 length(L1) > length(R1) and R1 = L1[1..length(TRIM(R1))] => init_weight,
								 Failed);
								 
	result := MAP ( 
							 not linit1 and not lnne1 and L1 = R1 							 	=> if(weight >  lfor1, minWeight, FailedForce),	// boolean linit - initial flag,  boolean lnnel - nulls not allowed flag
							 not linit1 and lnne1 and ( L1 = '' or R1 = '' ) 			=> 0,
							 not linit1 and lnne1 and L1 = R1 										=> if(weight >  lfor1, minWeight, FailedForce),
							 linit1 	and lnne1 and ( L1 = '' or R1 = '' ) 					=> 0,
							 linit1 																						=> result1,
							 lfor1 > 0 => FailedForce,
							 Failed );
	// output('Match1L_Result = ' + result + ', L1 = ' + L1 + ', ' + lspec1 + ', R1 = ' + r1 + ', ' +rspec1);
	return result;
END;
				
export Match2L(StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1, unsigned2 ispec1,
							 StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2, unsigned2 ispec2,
							 StrType R1,unsigned2 rspec1,
							 StrType R2,unsigned2 rspec2) := FUNCTION
							
	weight1 := max(lspec1,rspec1);
	weight2 := max(lspec2,rspec2);
							
   L1BlankCost := IF ( lfor1 > 0, FailedForce, Failed );
	 L2BlankCost := IF ( lfor2 > 0, FailedForce, Failed );
	 
	 L1R1 := Match1L(L1,lspec1,lnne1,lfor1,linit1,ispec1,R1,rspec1);
	 L1R2 := Match1L(L1,lspec1,lnne1,lfor1,linit1,ispec1,R2,rspec2);
	 L2R1 := Match1L(L2,lspec2,lnne2,lfor2,linit2,ispec2,R1,rspec1);
	 L2R2 := Match1L(L2,lspec2,lnne2,lfor2,linit2,ispec2,R2,rspec2);
	 // r0 := if(max(L1R1, L1R2) > 0 and max(L2R1, L2R2) > 0, max(L1R1, L1R2) + max(L2R1, L2R2), FailedForce);
	 r0 := if(min(L1R1, L2R2) > 0,  L1R1 + L2R2, if(min(L1R2, L2R1) > 0, L1R2 + L2R1, FailedForce));
	 
	 result := MAP(not lnne1  and not linit1  and lfor1 > 0 	     => r0,
								L1 = '' 																			=> IF ( lnne1, MAX( L2R1, L2R2 ), L1BlankCost ),
								L2 = '' 																			=> IF ( lnne2, MAX( L1R1, L1R2 ), L2BlankCost ),
								R1 = '' 					 														=> MAX ( IF ( lnne1, L2R2, L1BlankCost ), IF ( lnne2, L1R2, L2BlankCost ) ),
								R2 = '' 					 														=> MAX ( IF ( lnne1, L2R1, L1BlankCost ), IF ( lnne2, L1R1, L2BlankCost ) ),							
								linit1 or linit2                                			=> r0,
								L1 = R1 and L2 = R2  													=> if(weight1+weight2 > lfor1, lspec1 + lspec2, FailedForce), 
								L1 = R2 and L2 = R1 													=> if(weight1+weight2 > lfor1, lspec1 + lspec2, FailedForce), 
								lfor1 > 0 or lfor2 > 0 												=> FailedForce,
								Failed );
   // output('Match2L_Result = ' + result);									
	return result;
END;
// Used when coming in from outside; need to try both left and right being the correct way around
export Match2(StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2,
							StrType R1,
							StrType R2
							) :=
							SALT38.Min0(
								MAX( 
										 Match2L(L1,lspec1,lnne1,lfor1,linit1,ispec1,L2,lspec2,lnne2,lfor2,linit2,ispec2,R1,0,R2,0)
										 ,Match2L(R1,0,lnne1,lfor1,linit1,ispec1,R2,0,lnne2,lfor2,linit2,ispec2,L1,lspec1,L2,lspec2)										 
										 //,Match2L(R1,rspec1,lnne1,lfor1,linit1,R2,rspec2,lnne2,lfor2,linit2,L1,lspec1,L2,lspec2)
										 )
							);
// StringCompare
shared stringCompare(StrType L1, boolean init, boolean nne, StrType R1) := function
	substrR1     := length(R1) > length(L1) and L1 =R1[1..length(TRIM(L1))];
	substrL1     := length(L1) > length(R1) and R1 = L1[1..length(TRIM(R1))];
	
	result := map(not nne and (L1 = '' or R1 = '') => false,
							  L1 = '' or R1 = '' => false,
							  init and (substrL1 or substrR1) => true, 
							  L1 = R1 => true , 
							  false);
		
	// output('StringCompare_Result = ' + result + ',L1 = ' + L1 +  ', R1 = ' + r1 );
	return result;
end;
shared Match3L(StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1,
							 StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2,
							 StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,Boolean linit3,unsigned2 ispec3,
							 StrType R1,unsigned2 rspec1,
							 StrType R2,unsigned2 rspec2,
							 StrType R3,unsigned2 rspec3) := FUNCTION
							
	// Strategy - deal with L1 - and then two fields left, which is a solved problem ...
  L1BlankCost := IF ( lfor1 > 0, FailedForce, Failed );
	L23R12 := Match2L(L2,lspec2,lnne2,lfor2,linit2,ispec2,L3,lspec3,lnne3,lfor3,linit3,ispec3,R1,rspec1,R2,rspec2);
	L23R23 := Match2L(L2,lspec2,lnne2,lfor2,linit2,ispec2,L3,lspec3,lnne3,lfor3,linit3,ispec3,R2,rspec2,R3,rspec3);
	L23R13 := Match2L(L2,lspec2,lnne2,lfor2,linit2,ispec2,L3,lspec3,lnne3,lfor3,linit3,ispec3,R1,rspec1,R3,rspec3);
	 
	iL1R1 := getInitMatchWeight(L1, lspec1, ispec1, R1, rspec1);	 
	iL1R2 := getInitMatchWeight(L1, lspec1, ispec1, R2, rspec2);	 
	iL1R3 := getInitMatchWeight(L1, lspec1, ispec1, R3, rspec3);	 
	
	 
	 result :=	MAP ( L1 = '' => IF ( lnne1, MAX( L23R12, L23R23, L23R13 ), L1BlankCost ),
								stringCompare(L1,linit1,lnne1,R1) => IF ( L23R23 >= 0, L23R23+iL1R1, L23R23 ), // Ifs needed to carry back force and nneq conditions
								stringCompare(L1,linit1,lnne1,R2) => IF ( L23R13 >= 0, L23R13+iL1R2, L23R13 ),
								stringCompare(L1,linit1,lnne1,R3) => IF ( L23R12 >= 0, L23R12+iL1R3, L23R12 ),
								R1 = '' => IF ( lnne1, L23R23, L1BlankCost ), // Didn't like the other fields - so swallow the blank
								lfor1 > 0 => FailedForce,
								Failed );
		// output(result);
		return result;
END;
									 
export Match3(StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2,
							StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,Boolean linit3,unsigned2 ispec3,
							StrType R1,
							StrType R2,
							StrType R3
							) :=
							SALT38.Min0(
								MAX(
									 Match3L(trim(L1),lspec1,lnne1,lfor1,linit1,ispec1,trim(L2),lspec2,lnne2,lfor2,linit2,ispec2,trim(L3),lspec3,lnne3,lfor3,linit3,ispec3,trim(R1),0,trim(R2),0,trim(R3),0)
									 ,Match3L(trim(R1),0,lnne1,lfor1,linit1,ispec1,trim(R2),0,lnne2,lfor2,linit2,ispec2,trim(R3),0,lnne3,lfor3,linit3,ispec3,trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3)									 
									 //,Match3L(trim(R1),rspec1,lnne1,lfor1,linit1,trim(R2),rspec2,lnne2,lfor2,linit2,trim(R3),rspec3,lnne3,lfor3,linit3,trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3)
								)
							);
end;
