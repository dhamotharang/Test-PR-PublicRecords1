/*
Fixed the force-specific issues outlined in the https://github.com/hpcc-systems/SALT/issues/974
1/ the force test is used only for EditN matches, and not for the INIT matches. 
   So, in this specific case when ANNE matches A based on init match, the force is not enforced
2/ the force value is associated with specificity, and lspec1,rspec1... parameters of the fn_concept_wordbag_EditN represent weights (specificty*100); 
   Comparisons between those to enforce the FORCE will be invalid
3/ When the force test is applied, the force is compared against the lspec1 (if lspec1>0), and not against the min(lspec1,rspec1) as it should. 
   Therefore, a rare forname with high specificty will always fail the force test (ie the match will be accepted).
*/
// a)	We have to provide specificities for both left and right strings (we cannot assume they will be identical)
// b)	The Â‘forceÂ’ now has to be an integer; not a Boolean (they will need to be able to specify a degree of forcing)
// c)	We will need to provide a Boolean to show whether a given position can be initial or not
// The way the scoring needs to work is:
// a)	If linit is false (no initial) and lnne1 (nulls not allowed) is false then the fields must match Â– score is the spec for the field
// b)	If linit is false (no initial) and lnne1 is true then the fields must match Â– or one side by blank Â– score is zero
// c)	If linit is true and lnne1 is false then the shorter side must be the leading component of the longer; the score is then the spec of the shorter side
// d)	If linit is true and lnne1 is true and one side is null then score is 0
// e)	In all cases the eventual score for the field must be >= to the lfor for the given field
// a)	Any that do not allow nulls or initials and have a force
// b)	Do not allow nulls or initials but have no force (ie null=null is ok)
// c)	Any with a force but allow nulls Â– no initials
// d)	Any with a force and allow initials
/*---------------------------------------- */
// Therefore Â– IF we want initial supported for concept:bagofwords I propose a THIRD type of match function similar to ManishÂ’s _initial 
// variant but when only takes in ONE weight. Determining the weight for an initial -> initial match can then be (approximated) as follows:
// 1)	If the SHORTER string has the weight then use the weight of the shorter string
// 2)	If the longer string has the weight then multiply that weight by lengthofshorterstring/lengthoflongerstring
// This essentially asserts that a linear interpolation of weight along string length is correct. This is obviously not QUITE true
// A -> AL -> ALA -> ALAN
// This method would slightly overweight A & AL and underweight ALA Â– but I think it might be a fairly acceptable approximation Â– and 
// it has the advantage of feasibility ?
export fn_concept_wordbag_EditN_EL := module
export FailedForce := -9999;
export Failed := -1;
shared getInitMatchWeight(StrType L1, unsigned2 lspec1, unsigned2 ispec1, StrType R1, unsigned2 rspec1) := function
	iWeight := map(lspec1 > 0 and rspec1 > 0 => min(lspec1, rspec1),
	              (length(L1) > length(R1)) and rspec1 > 0 => rspec1,  
	              (length(L1) > length(R1)) and lspec1 > 0 => ((lspec1 - ispec1)/(length(L1) - 1)) * length(R1) + (ispec1* length(L1) - lspec1)/(length(L1) - 1), //equation of a line between points (1, initial_weight) and (length(d), full_weight)   // previously lspec1 * length(r1)/length(l1), 
								(length(R1) > length(L1)) and lspec1 > 0 => lspec1, 
	              (length(R1) > length(L1)) and rspec1 > 0 => rspec1 * length(L1)/length(R1), 
								lspec1 > 0 => lspec1, 
								ispec1);
										
	// output('getInitMatchWeight_Result = ' + iWeight);
	return iWeight;
end;
export  Match1L( StrType L1, unsigned2 lspec1, boolean lnne1, integer lfor1, Boolean linit1, unsigned2 ispec1, integer edit1, StrType R1, unsigned2 rspec1) := FUNCTION
	// Wait based on StrType match
	init_weight := getInitMatchWeight(L1, lspec1, ispec1, R1, rspec1);
													
	weight := if(lspec1 > 0, lspec1, rspec1);
	minWeight := if(lspec1 > 0 and rspec1 > 0, min(lspec1,rspec1), weight);
	
	result1 := map(L1 = R1  => if(minWeight > lfor1*100, minWeight, FailedForce),  
	               SALT33.WithinEditN(L1,R1,edit1)  => if(minWeight*(1-edit1*0.1) > lfor1*100, minWeight*(1-edit1*0.1), FailedForce), 
								 length(R1) > length(L1) and L1 = R1[1..length(TRIM(L1))] => if(init_weight > lfor1*100,init_weight,FailedForce),
								 length(L1) > length(R1) and R1 = L1[1..length(TRIM(R1))] => if(init_weight > lfor1*100,init_weight,FailedForce),
								 Failed);
								 
	result := MAP ( 
							 not linit1 and not lnne1 and L1 = R1 => if(minWeight > lfor1*100, minWeight, FailedForce),	// boolean linit - initial flag,  boolean lnnel - nulls not allowed flag
							 not linit1 and not lnne1 and SALT33.WithinEditN(L1,R1,edit1) => if(minWeight*(1-edit1*0.1) > lfor1*100, minWeight*(1-edit1*0.1), FailedForce),	// boolean linit - initial flag,  boolean lnnel - nulls not allowed flag
							 not linit1 and lnne1 and ( L1 = '' or R1 = '' ) 			=> 0,
    					 not linit1 and lnne1 and L1 = R1 => if(minWeight > lfor1*100, minWeight, FailedForce),					 
							 not linit1 and lnne1 and SALT33.WithinEditN(L1,R1,edit1) => if(minWeight*(1-edit1*0.1) > lfor1*100, minWeight*(1-edit1*0.1), FailedForce),
							 linit1 	and lnne1 and ( L1 = '' or R1 = '' ) 					=> 0,
							 linit1 																						=> result1,
							 lfor1 > 0 => FailedForce,
							 Failed );
	// output('Match1L_Result = ' + result + ', L1 = ' + L1 + ', ' + lspec1 + ', R1 = ' + r1 + ', ' +rspec1);
	return result;
END;
				
export Match2L(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1,integer edit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2,integer edit2,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2) := FUNCTION
							
	weight1 := max(lspec1,rspec1);
	weight2 := max(lspec2,rspec2);
							
   L1BlankCost := IF ( lfor1 > 0, FailedForce, Failed );
	 L2BlankCost := IF ( lfor2 > 0, FailedForce, Failed );
	 
	 L1R1 := Match1L(L1,lspec1,lnne1,lfor1,linit1,ispec1,edit1,R1,rspec1);
	 L1R2 := Match1L(L1,lspec1,lnne1,lfor1,linit1,ispec1,edit1,R2,rspec2);
	 L2R1 := Match1L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,R1,rspec1);
	 L2R2 := Match1L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,R2,rspec2);
	 // r0 := if(max(L1R1, L1R2) > 0 and max(L2R1, L2R2) > 0, max(L1R1, L1R2) + max(L2R1, L2R2), FailedForce);
	 r0 := if(min(L1R1, L2R2) > 0,  L1R1 + L2R2, if(min(L1R2, L2R1) > 0, L1R2 + L2R1, FailedForce));
	 
	 result := MAP(not lnne1  and not linit1  and lfor1 > 0 	     => r0,
								L1 = '' 																			=> IF ( lnne1, MAX( L2R1, L2R2 ), L1BlankCost ),
								L2 = '' 																			=> IF ( lnne2, MAX( L1R1, L1R2 ), L2BlankCost ),
								R1 = '' 					 														=> MAX ( IF ( lnne1, L2R2, L1BlankCost ), IF ( lnne2, L1R2, L2BlankCost ) ),
								R2 = '' 					 														=> MAX ( IF ( lnne1, L2R1, L1BlankCost ), IF ( lnne2, L1R1, L2BlankCost ) ),							
								linit1 or linit2                                			=> r0,
								L1 = R1 and L2 = R2 => if(weight1+weight2 > lfor1*100, weight1+weight2, FailedForce), 
								L1 = R2 and L2 = R1 => if(weight1+weight2 > lfor1*100, weight1+weight2, FailedForce), 								
								SALT33.WithinEditN(L1,R1,edit1) and SALT33.WithinEditN(L2,R2,edit2) => if(weight1*(1-edit1*0.1)+weight2*(1-edit2*0.1) > lfor1*100, weight1*(1-edit1*0.1)+weight2*(1-edit2*0.1), FailedForce), 
								SALT33.WithinEditN(L1,R2,edit1) and SALT33.WithinEditN(L2,R1,edit2) => if(weight1*(1-edit1*0.1)+weight2*(1-edit2*0.1) > lfor1*100, weight1*(1-edit1*0.1)+weight2*(1-edit2*0.1), FailedForce), 
								lfor1 > 0 or lfor2 > 0 												=> FailedForce,
								Failed );
													
  //  output('Match2L_Result = ' + result);									
	return result;
END;
// Used when coming in from outside; need to try both left and right being the correct way around
export Match2(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1,integer edit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2,integer edit2,
							StrType R1,
							StrType R2
							) :=
							SALT33.Min0(
								MAX( 
										 Match2L(L1,lspec1,lnne1,lfor1,linit1,ispec1,edit1,L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,R1,0,R2,0)
 										 ,Match2L(R1,0,lnne1,lfor1,linit1,0,edit1,R2,0,lnne2,lfor2,linit2,0,edit2,L1,lspec1,L2,lspec2)
										 //,Match2L(R1,rspec1,lnne1,lfor1,linit1,edit1,R2,rspec2,lnne2,lfor2,linit2,edit2,L1,lspec1,L2,lspec2)
										 )
							);
/* ----------------------------------------- Three Words -------------------------------------------------*/							
// StringCompare
shared stringCompare(StrType L1, boolean init, boolean nne, integer edit, StrType R1) := function
	substrR1     := length(R1) > length(L1) and L1 =R1[1..length(TRIM(L1))];
	substrL1     := length(L1) > length(R1) and R1 = L1[1..length(TRIM(R1))];
	
	result := map(not nne and (L1 = '' or R1 = '') => false,
							  L1 = '' or R1 = '' => false,
							  init and (substrL1 or substrR1) => true, 
							  SALT33.WithinEditN(L1,R1,edit) => true , 
							  false);
		
	// output('StringCompare_Result = ' + result + ',L1 = ' + L1 +  ', R1 = ' + r1 );
	return result;
end;
shared Match3L(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1, integer edit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2, integer edit2,
							StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,Boolean linit3,unsigned2 ispec3, integer edit3,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3) := FUNCTION
							
	// Strategy - deal with L1 - and then two fields left, which is a solved problem ...
   L1BlankCost := IF ( lfor1 > 0, FailedForce, Failed );
	L23R12 := Match2L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,R1,rspec1,R2,rspec2);
	L23R23 := Match2L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,R2,rspec2,R3,rspec3);
	L23R13 := Match2L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,R1,rspec1,R3,rspec3);
/*	 
	iL1R1 := getInitMatchWeight(L1, lspec1, R1, rspec1);	 
	iL1R2 := getInitMatchWeight(L1, lspec1, R2, rspec2);	 
	iL1R3 := getInitMatchWeight(L1, lspec1, R3, rspec3);	 
	*/
	 L1R1 := SALT33.Min0(Match1L(L1,lspec1,lnne1,lfor1,linit1,ispec1,edit1,R1,rspec1)); // take force into consideration
	 L1R2 := SALT33.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor2),linit1,ispec1,edit1,R2,rspec2));
   L1R3 := SALT33.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),linit1,ispec1,edit1,R3,rspec3));

	 result :=	MAP ( L1 = '' => IF ( lnne1, MAX( L23R12, L23R23, L23R13 ), L1BlankCost ),
								stringCompare(L1,linit1,lnne1,edit1,R1) => IF ( L23R23 > 0, L23R23+L1R1, L23R23 ), // Ifs needed to carry back force and nneq conditions
								stringCompare(L1,linit1,lnne1,edit1,R2) => IF ( L23R13 > 0, L23R13+L1R2, L23R13 ),
								stringCompare(L1,linit1,lnne1,edit1,R3) => IF ( L23R12 > 0, L23R12+L1R3, L23R12 ),
								R1 = '' => IF ( lnne1, L23R23, L1BlankCost ), // Didn't like the other fields - so swallow the blank
								lfor1 > 0 => FailedForce,
								Failed );
		
		// output(result);
		return result;
END;
									 
export Match3(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1, integer edit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2, integer edit2,
							StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,Boolean linit3,unsigned2 ispec3, integer edit3,
							StrType R1,
							StrType R2,
							StrType R3
							) :=
							SALT33.Min0(
								MAX(
									 Match3L(trim(L1),lspec1,lnne1,lfor1,linit1,ispec1,edit1,trim(L2),lspec2,lnne2,lfor2,linit2,ispec2,edit2,trim(L3),lspec3,lnne3,lfor3,linit3,ispec3,edit3,trim(R1),0,trim(R2),0,trim(R3),0)
									 ,Match3L(trim(R1),0,lnne1,lfor1,linit1,0,edit1,trim(R2),0,lnne2,lfor2,linit2,0,edit2,trim(R3),0,lnne3,lfor3,linit3,0,edit3,trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3)
 									 //,Match3L(trim(R1),rspec1,lnne1,lfor1,linit1,edit1,trim(R2),rspec2,lnne2,lfor2,linit2,edit2,trim(R3),rspec3,lnne3,lfor3,linit3,edit3,trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3)
								)
							);
/* ----------------------------------------- Four Words -------------------------------------------------*/							
shared Match4L(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1, integer edit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2, integer edit2,
							StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,Boolean linit3,unsigned2 ispec3, integer edit3,
							StrType L4,unsigned2 lspec4,boolean lnne4,integer lfor4,Boolean linit4,unsigned2 ispec4, integer edit4,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3,
							StrType R4,unsigned2 rspec4) := FUNCTION
	// Strategy - deal with L1 - and then three fields left, which is a solved problem ...
   L1BlankCost := IF ( lfor1 > 0, FailedForce, Failed );
						 
	 L234R123 := Match3L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,L4,lspec4,lnne4,lfor4,linit4,ispec4,edit4,R1,rspec1,R2,rspec2,R3,rspec3);
	 L234R124 := Match3L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,L4,lspec4,lnne4,lfor4,linit4,ispec4,edit4,R1,rspec1,R2,rspec2,R4,rspec4);
	 L234R134 := Match3L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,L4,lspec4,lnne4,lfor4,linit4,ispec4,edit4,R1,rspec1,R3,rspec3,R4,rspec4);
	 L234R234 := Match3L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,L4,lspec4,lnne4,lfor4,linit4,ispec4,edit4,R2,rspec2,R3,rspec3,R4,rspec4);
	 /*
   iL1R1 := getInitMatchWeight(L1, lspec1, R1, rspec1);	 
	 iL1R2 := getInitMatchWeight(L1, lspec1, R2, rspec2);	 
	 iL1R3 := getInitMatchWeight(L1, lspec1, R3, rspec3);	 
	 iL1R4 := getInitMatchWeight(L1, lspec1, R4, rspec4);	 
	 */
	 L1R1 := SALT33.Min0(Match1L(L1,lspec1,lnne1,lfor1,linit1,ispec1,edit1,R1,rspec1)); // take force into consideration
	 L1R2 := SALT33.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor2),linit1,ispec1,edit1,R2,rspec2));
   L1R3 := SALT33.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),linit1,ispec1,edit1,R3,rspec3));
	 L1R4 := SALT33.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),linit1,ispec1,edit1,R4,rspec4));
	 
	 result :=	MAP ( L1 = '' => IF ( lnne1, MAX( L234R123, L234R124, L234R134, L234R234), L1BlankCost ),
								stringCompare(L1,linit1,lnne1,edit1,R1) => IF ( L234R234 > 0, L234R234+L1R1, L234R234 ), // Ifs needed to carry back force and nneq conditions
								stringCompare(L1,linit1,lnne1,edit1,R2) => IF ( L234R134 > 0, L234R134+L1R2, L234R134 ),
								stringCompare(L1,linit1,lnne1,edit1,R3) => IF ( L234R124 > 0, L234R124+L1R3, L234R124 ),
								stringCompare(L1,linit1,lnne1,edit1,R4) => IF ( L234R123 > 0, L234R123+L1R4, L234R123 ),
								R1 = '' => IF ( lnne1, L234R234, L1BlankCost ), // Didn't like the other fields - so swallow the blank
								lfor1 > 0 => FailedForce,
								Failed );
		// output(result);
		return result;
END;
									 
export Match4(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1, integer edit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2, integer edit2,
							StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,Boolean linit3,unsigned2 ispec3, integer edit3,
							StrType L4,unsigned2 lspec4,boolean lnne4,integer lfor4,Boolean linit4,unsigned2 ispec4, integer edit4,
							StrType R1,
							StrType R2,
							StrType R3,
							StrType R4
							) :=
							SALT33.Min0(
								MAX(
									 Match4L(trim(L1),lspec1,lnne1,lfor1,linit1,ispec1,edit1,trim(L2),lspec2,lnne2,lfor2,linit2,ispec2,edit2,
													 trim(L3),lspec3,lnne3,lfor3,linit3,ispec3,edit3,trim(L4),lspec4,lnne4,lfor4,linit4,ispec4,edit4,
													 trim(R1),0,trim(R2),0,trim(R3),0,trim(R4),0)
									 ,Match4L(trim(R1),0,lnne1,lfor1,linit1,0,edit1,trim(R2),0,lnne2,lfor2,linit2,0,edit2,
													 trim(R3),0,lnne3,lfor3,linit3,0,edit3,trim(R4),0,lnne4,lfor4,linit4,0,edit4,
													 trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3,trim(L4),lspec4)
									 /*,Match4L(trim(R1),rspec1,lnne1,lfor1,linit1,edit1,trim(R2),rspec2,lnne2,lfor2,linit2,edit2,
													 trim(R3),rspec3,lnne3,lfor3,linit3,edit3,trim(R4),rspec4,lnne4,lfor4,linit4,edit4,
													 trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3,trim(L4),lspec4)*/
								)
							);
							
/* ----------------------------------------- Five Words -------------------------------------------------*/							
shared Match5L(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1, integer edit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2, integer edit2,
							StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,Boolean linit3,unsigned2 ispec3, integer edit3,
							StrType L4,unsigned2 lspec4,boolean lnne4,integer lfor4,Boolean linit4,unsigned2 ispec4, integer edit4,
							StrType L5,unsigned2 lspec5,boolean lnne5,integer lfor5,Boolean linit5,unsigned2 ispec5, integer edit5,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3,
							StrType R4,unsigned2 rspec4,
							StrType R5,unsigned2 rspec5) := FUNCTION
	// Strategy - deal with L1 - and then three fields left, which is a solved problem ...
   L1BlankCost := IF ( lfor1 > 0, FailedForce, Failed );
							 
	 L2345R1234 := Match4L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,L4,lspec4,lnne4,lfor4,linit4,ispec4,edit4,L5,lspec5,lnne5,lfor5,linit5,ispec5,edit5,R1,rspec1,R2,rspec2,R3,rspec3,R4,rspec4);
	 L2345R1235 := Match4L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,L4,lspec4,lnne4,lfor4,linit4,ispec4,edit4,L5,lspec5,lnne5,lfor5,linit5,ispec5,edit5,R1,rspec1,R2,rspec2,R3,rspec3,R5,rspec5);
	 L2345R1245 := Match4L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,L4,lspec4,lnne4,lfor4,linit4,ispec4,edit4,L5,lspec5,lnne5,lfor5,linit5,ispec5,edit5,R1,rspec1,R2,rspec2,R4,rspec4,R5,rspec5);
	 L2345R1345 := Match4L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,L4,lspec4,lnne4,lfor4,linit4,ispec4,edit4,L5,lspec5,lnne5,lfor5,linit5,ispec5,edit5,R1,rspec1,R3,rspec3,R4,rspec4,R5,rspec5);
	 L2345R2345 := Match4L(L2,lspec2,lnne2,lfor2,linit2,ispec2,edit2,L3,lspec3,lnne3,lfor3,linit3,ispec3,edit3,L4,lspec4,lnne4,lfor4,linit4,ispec4,edit4,L5,lspec5,lnne5,lfor5,linit5,ispec5,edit5,R2,rspec2,R3,rspec3,R4,rspec4,R5,rspec5);
	 /*
    iL1R1 := getInitMatchWeight(L1, lspec1, R1, rspec1);	 
	 iL1R2 := getInitMatchWeight(L1, lspec1, R2, rspec2);	 
	 iL1R3 := getInitMatchWeight(L1, lspec1, R3, rspec3);	 
	 iL1R4 := getInitMatchWeight(L1, lspec1, R4, rspec4);	 
	 iL1R5 := getInitMatchWeight(L1, lspec1, R5, rspec5);	 
*/
	 L1R1 := SALT33.Min0(Match1L(L1,lspec1,lnne1,lfor1,linit1,ispec1,edit1,R1,rspec1)); // take force into consideration
	 L1R2 := SALT33.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor2),linit1,ispec1,edit1,R2,rspec2));
   L1R3 := SALT33.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),linit1,ispec1,edit1,R3,rspec3));
	 L1R4 := SALT33.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),linit1,ispec1,edit1,R4,rspec4));
	 L1R5 := SALT33.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),linit1,ispec1,edit1,R5,rspec5));
	 
	 result :=	MAP ( L1 = '' => IF ( lnne1, MAX( L2345R1234, L2345R1235, L2345R1245, L2345R1345, L2345R2345), L1BlankCost ),
								stringCompare(L1,linit1,lnne1,edit1,R1) => IF ( L2345R2345 > 0, L2345R2345+L1R1, L2345R2345 ), // Ifs needed to carry back force and nneq conditions
								stringCompare(L1,linit1,lnne1,edit1,R2) => IF ( L2345R1345 > 0, L2345R1345+L1R2, L2345R1345 ),
								stringCompare(L1,linit1,lnne1,edit1,R3) => IF ( L2345R1245 > 0, L2345R1245+L1R3, L2345R1245 ),
								stringCompare(L1,linit1,lnne1,edit1,R4) => IF ( L2345R1235 > 0, L2345R1235+L1R4, L2345R1235 ),
								stringCompare(L1,linit1,lnne1,edit1,R5) => IF ( L2345R1234 > 0, L2345R1234+L1R5, L2345R1234 ),
								R1 = '' => IF ( lnne1, L2345R2345, L1BlankCost ), // Didn't like the other fields - so swallow the blank
								lfor1 > 0 => FailedForce,
								Failed );
		// output(result);
		return result;
END;
									 
export Match5(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,Boolean linit1,unsigned2 ispec1, integer edit1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,Boolean linit2,unsigned2 ispec2, integer edit2,
							StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,Boolean linit3,unsigned2 ispec3, integer edit3,
							StrType L4,unsigned2 lspec4,boolean lnne4,integer lfor4,Boolean linit4,unsigned2 ispec4, integer edit4,
							StrType L5,unsigned2 lspec5,boolean lnne5,integer lfor5,Boolean linit5,unsigned2 ispec5, integer edit5,
							StrType R1,
							StrType R2,
							StrType R3,
							StrType R4,
							StrType R5
							) :=
							SALT33.Min0(
								MAX(
									 Match5L(trim(L1),lspec1,lnne1,lfor1,linit1,ispec1,edit1,trim(L2),lspec2,lnne2,lfor2,linit2,ispec2,edit2,
													 trim(L3),lspec3,lnne3,lfor3,linit3,ispec3,edit3,trim(L4),lspec4,lnne4,lfor4,linit4,ispec4,edit4,
													 trim(L5),lspec5,lnne5,lfor5,linit5,ispec5,edit5,
													 trim(R1),0,trim(R2),0,trim(R3),0,trim(R4),0,trim(R5),0)
									 ,Match5L(trim(R1),0,lnne1,lfor1,linit1,0,edit1,trim(R2),0,lnne2,lfor2,linit2,0,edit2,
													 trim(R3),0,lnne3,lfor3,linit3,0,edit3,trim(R4),0,lnne4,lfor4,linit4,0,edit4,
													 trim(R5),0,lnne5,lfor5,linit5,0,edit5,
													 trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3,trim(L4),lspec4,trim(L5),lspec5)
									/*,Match5L(trim(R1),rspec1,lnne1,lfor1,linit1,edit1,trim(R2),rspec2,lnne2,lfor2,linit2,edit2,
													 trim(R3),rspec3,lnne3,lfor3,linit3,edit3,trim(R4),rspec4,lnne4,lfor4,linit4,edit4,
													 trim(R5),rspec5,lnne5,lfor5,linit5,edit5,
													 trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3,trim(L4),lspec4,trim(L5),lspec5)*/
								)
							);
end;
