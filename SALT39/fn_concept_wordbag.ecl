export fn_concept_wordbag := module
export FailedForce := -9999;
export Failed := -1;
shared Match1L( StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1, StrType R1, unsigned2 rspec1 ) := FUNCTION													
	weight := if(lspec1 > 0, lspec1, rspec1);
	minWeight := if(lspec1 > 0 and rspec1 > 0, min(lspec1,rspec1), weight);
		
	return MAP ( 
							 L1 = R1 and L1 <> '' => if(minweight > lfor1*100, minWeight, FailedForce),
							 lfor1 > 0 => FailedForce,
							 lnne1 and ( L1 = '' or R1 = '' ) => 0,
							 Failed );
	END;
				
shared Match2L(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,
							StrType R1, unsigned2 rspec1,
							StrType R2, unsigned2 rspec2) := FUNCTION
	 weight1 := if(lspec1 > 0 and rspec1 > 0, min(lspec1,rspec1), max(lspec1,rspec1));
	 weight2 := if(lspec2 > 0 and rspec2 > 0, min(lspec2,rspec2), max(lspec2,rspec2));
	 
   L1BlankCost := IF ( lfor1 > 0 , FailedForce, Failed );
	 L2BlankCost := IF ( lfor2 > 0 , FailedForce, Failed );
	 
	 L1R1 := Match1L(L1,lspec1,lnne1,lfor1,R1,rspec1);
	 L1R2 := Match1L(L1,lspec1,lnne1,lfor1,R2,rspec2);
	 L2R1 := Match1L(L2,lspec2,lnne2,lfor2,R1,rspec1);
	 L2R2 := Match1L(L2,lspec2,lnne2,lfor2,R2,rspec2);
	 r0 := if(min(L1R1, L2R2) > 0,  L1R1 + L2R2, if(min(L1R2, L2R1) > 0, L1R2 + L2R1, FailedForce));
	 
	 result := 	MAP ( not lnne1  and lfor1 > 0 	     => r0,
								L1 = '' => IF ( lnne1, MAX( L2R1, L2R2 ), L1BlankCost ),
							  L2 = '' => IF ( lnne2, MAX( L1R1, L1R2 ), L2BlankCost ),
								R1 = '' => MAX ( IF ( lnne1, L2R2, L1BlankCost ), IF ( lnne2, L1R2, L2BlankCost ) ),
								R2 = '' => MAX ( IF ( lnne1, L2R1, L1BlankCost ), IF ( lnne2, L1R1, L2BlankCost ) ),
								L1 = R1 and L2 = R2  													=> if(weight1+weight2 > lfor1, min(lspec1, rspec1) + min(lspec2, rspec2), FailedForce), 
								L1 = R2 and L2 = R1 													=> if(weight1+weight2 > lfor1, min(lspec1, rspec2) + min(lspec2, rspec1), FailedForce), 
								lfor1 > 0 or lfor2 > 0 => FailedForce,
								Failed );
			return result;					
		END;
// Used when coming in from outside; need to try both left and right being the correct way around
export Match2(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,
							StrType R1,unsigned2 rspec1,
						  StrType R2,unsigned2 rspec2
							) :=
							SALT39.Min0(
								MAX( 
									 Match2L(L1,lspec1,lnne1,lfor1,L2,lspec2,lnne2,lfor2,R1,rspec1,R2,rspec2), 
									 Match2L(R1,rspec1,lnne1,lfor1,R2,lspec2,lnne2,lfor2,L1,lspec1,L2,lspec2)
									 )
							);
// StringCompare
shared stringCompare(StrType L1, boolean nne, StrType R1) := function
//	substrR1     := length(R1) > length(L1) and L1 =R1[1..length(TRIM(L1))];
//	substrL1     := length(L1) > length(R1) and R1 = L1[1..length(TRIM(R1))];
	
	result := map(not nne and (L1 = '' or R1 = '') => false,
							  L1 = '' or R1 = '' => false,
	//						  substrL1 or substrR1 => true, 
							  L1 = R1 => true , 
							  false);
		
	// output('StringCompare_Result = ' + result + ',L1 = ' + L1 +  ', R1 = ' + r1 );
	return result;
end;							
shared Match3L(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3) := FUNCTION
	// Strategy - deal with L1 - and then two fields left, which is a solved problem ...
   L1BlankCost := IF ( lfor1 > 0 , FailedForce, Failed );
	 L23R12 := Match2L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,R1,rspec1,R2,rspec2);
	 L23R23 := Match2L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,R2,rspec2,R3,rspec3);
	 L23R13 := Match2L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,R1,rspec1,R3,rspec3);
	 	 
	 L1R1 := SALT39.Min0(Match1L(L1,lspec1,lnne1,lfor1,R1, rspec1)); // take force into consideration
	 L1R2 := SALT39.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor2),R2, rspec2));
   L1R3 := SALT39.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),R3, rspec3));
	
	 
	 result := 	MAP ( L1 = '' => IF ( lnne1, MAX( L23R12, L23R23, L23R13 ), L1BlankCost ),
								stringCompare(L1,lnne1,R1) => IF ( L23R23 >= 0, L23R23+L1R1, L23R23 ), // Ifs needed to carry back force and nneq conditions
								stringCompare(L1,lnne1,R2) => IF ( L23R13 >= 0, L23R13+L1R2, L23R13 ),
								stringCompare(L1,lnne1,R3) => IF ( L23R12 >= 0, L23R12+L1R3, L23R12 ),
								R1 = '' => IF ( lnne1, L23R23, L1BlankCost ), // Didn't like the other fields - so swallow the blank
								lfor1 > 0 => FailedForce,
								Failed );
		return result;						
		END;
export Match3(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,
							StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,
							StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3
							) :=
							SALT39.Min0(
								MAX(
									 Match3L(trim(L1),lspec1,lnne1,lfor1,trim(L2),lspec2,lnne2,lfor2,trim(L3),lspec3,lnne3,lfor3,trim(R1),rspec1,trim(R2),rspec2,trim(R3),rspec3),
									 Match3L(trim(R1),rspec1,lnne1,lfor1,trim(R2),rspec2,lnne2,lfor2,trim(R3),rspec3,lnne3,lfor3,trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3)
								)
							);
shared Match4L(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,
						  StrType L4,unsigned2 lspec4,boolean lnne4,integer lfor4,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3,
							StrType R4,unsigned2 rspec4) := FUNCTION
	// Strategy - deal with L1 - and then three fields left, which is a solved problem ...
   L1BlankCost := IF ( lfor1 > 0 , FailedForce, Failed );
	 
	 L234R123 := Match3L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,R1,rspec1,R2,rspec2,R3,rspec3);
	 L234R124 := Match3L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,R1,rspec1,R2,rspec2,R4,rspec4);
	 L234R134 := Match3L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,R1,rspec1,R3,rspec3,R4,rspec4);
	 L234R234 := Match3L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,R2,rspec2,R3,rspec3,R4,rspec4);
	 
	 L1R1 := SALT39.Min0(Match1L(L1,lspec1,lnne1,lfor1,R1, rspec1)); // take force into consideration
	 L1R2 := SALT39.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor2),R2, rspec2));
   L1R3 := SALT39.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),R3, rspec3));
	 L1R4 := SALT39.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),R4, rspec4));
	 
	 result := 	MAP ( L1 = '' => IF ( lnne1, MAX( L234R123, L234R124, L234R134, L234R234 ), L1BlankCost ),
	              stringCompare(L1,lnne1,R1) => IF ( L234R234 > 0, L234R234+L1R1, L234R234 ), // Ifs needed to carry back force and nneq conditions
								stringCompare(L1,lnne1,R2) => IF ( L234R134 > 0, L234R134+L1R2, L234R134 ),
								stringCompare(L1,lnne1,R3) => IF ( L234R124 > 0, L234R124+L1R3, L234R124 ),
								stringCompare(L1,lnne1,R4) => IF ( L234R123 > 0, L234R123+L1R4, L234R123 ),
								R1 = '' => IF ( lnne1, L234R234, L1BlankCost ),
								lfor1  > 0 => FailedForce,
								Failed );
		return result; 						
		END;
									 
export Match4(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,
						  StrType L4,unsigned2 lspec4,boolean lnne4,integer lfor4,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3,
							StrType R4,unsigned2 rspec4
							) :=
							SALT39.Min0(
								MAX(
									 Match4L(trim(L1),lspec1,lnne1,lfor1,trim(L2),lspec2,lnne2,lfor2,
													 trim(L3),lspec3,lnne3,lfor3,trim(L4),lspec4,lnne4,lfor4,
													 trim(R1),rspec1,trim(R2),rspec2,trim(R3),rspec3,trim(R4),rspec4),
									 Match4L(trim(R1),rspec1,lnne1,lfor1,trim(R2),rspec2,lnne2,lfor2,
													 trim(R3),rspec3,lnne3,lfor3,trim(R4),rspec4,lnne4,lfor4,
													 trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3,trim(L4),lspec4)
								)
							);
shared Match5L(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,
						  StrType L4,unsigned2 lspec4,boolean lnne4,integer lfor4,
						  StrType L5,unsigned2 lspec5,boolean lnne5,integer lfor5,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3,
							StrType R4,unsigned2 rspec4,
							StrType R5,unsigned2 rspec5) := FUNCTION
	// Strategy - deal with L1 - and then three fields left, which is a solved problem ...
   L1BlankCost := IF ( lfor1 > 0 , FailedForce, Failed );
	 L2345R1234 := Match4L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R1,rspec1,R2,rspec2,R3,rspec3,R4,rspec4);
	 L2345R1235 := Match4L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R1,rspec1,R2,rspec2,R3,rspec3,R5,rspec5);
	 L2345R1245 := Match4L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R1,rspec1,R2,rspec2,R4,rspec4,R5,rspec5);
	 L2345R1345 := Match4L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R1,rspec1,R3,rspec3,R4,rspec4,R5,rspec5);
	 L2345R2345 := Match4L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R2,rspec2,R3,rspec3,R4,rspec4,R5,rspec5);
	 
	 L1R1 := SALT39.Min0(Match1L(L1,lspec1,lnne1,lfor1,R1, rspec1)); // take force into consideration
	 L1R2 := SALT39.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor2),R2, rspec2));
   L1R3 := SALT39.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),R3, rspec3));
	 L1R4 := SALT39.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),R4, rspec4));
	 L1R5 := SALT39.Min0(Match1L(L1,lspec1,lnne1,MAX(lfor1,lfor3),R5, rspec5));
	 
	 result := 	MAP ( L1 = '' => IF ( lnne1, MAX( L2345R1234, L2345R1235, L2345R1245, L2345R1345, L2345R2345 ), L1BlankCost ),
								stringCompare(L1,lnne1,R1) => IF ( L2345R2345 > 0, L2345R2345+L1R1, L2345R2345 ), // Ifs needed to carry back force and nneq conditions
								stringCompare(L1,lnne1,R2) => IF ( L2345R1345 > 0, L2345R1345+L1R2, L2345R1345 ),
								stringCompare(L1,lnne1,R3) => IF ( L2345R1245 > 0, L2345R1245+L1R3, L2345R1245 ),
								stringCompare(L1,lnne1,R4) => IF ( L2345R1235 > 0, L2345R1235+L1R4, L2345R1235 ),
								stringCompare(L1,lnne1,R5) => IF ( L2345R1234 > 0, L2345R1234+L1R5, L2345R1234 ),
								R1 = '' => IF ( lnne1, L2345R2345, L1BlankCost ),
								lfor1 > 0 => FailedForce,
								Failed );
			return result;
		END;
		
									 
export Match5(
							StrType L1,unsigned2 lspec1,boolean lnne1,integer lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,integer lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,integer lfor3,
						  StrType L4,unsigned2 lspec4,boolean lnne4,integer lfor4,
						  StrType L5,unsigned2 lspec5,boolean lnne5,integer lfor5,
							StrType R1,unsigned2 rspec1,
							StrType R2,unsigned2 rspec2,
							StrType R3,unsigned2 rspec3,
							StrType R4,unsigned2 rspec4,
							StrType R5,unsigned2 rspec5							
							) :=
							SALT39.Min0(
								MAX(
									 Match5L(trim(L1),lspec1,lnne1,lfor1,trim(L2),lspec2,lnne2,lfor2,
													 trim(L3),lspec3,lnne3,lfor3,trim(L4),lspec4,lnne4,lfor4,
													 trim(L5),lspec5,lnne5,lfor5,
													 trim(R1),rspec1,trim(R2),rspec2,trim(R3),rspec3,trim(R4),rspec4,trim(R5),rspec5),
									 Match5L(trim(R1),rspec1,lnne1,lfor1,trim(R2),rspec2,lnne2,lfor2,
													 trim(R3),rspec3,lnne3,lfor3,trim(R4),rspec4,lnne4,lfor4,
													 trim(R5),rspec5,lnne5,lfor5,
													 trim(L1),lspec1,trim(L2),lspec2,trim(L3),lspec3,trim(L4),lspec4,trim(L5),lspec5)
								)
							);							
end;
