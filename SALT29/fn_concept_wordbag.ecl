export fn_concept_wordbag := module
export FailedForce := -9999;
export Failed := -1;
shared Match1L( StrType L1,unsigned2 lspec1,boolean lnne1,boolean lfor1, StrType R1 ) := FUNCTION
	return MAP ( 
							 L1 = R1 and L1 <> '' => lspec1,
							 lfor1 => FailedForce,
							 lnne1 and ( L1 = '' or R1 = '' ) => 0,
							 Failed );
	END;
				
shared Match2L(
							StrType L1,unsigned2 lspec1,boolean lnne1,boolean lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,boolean lfor2,
							StrType R1,StrType R2) := FUNCTION
   L1BlankCost := IF ( lfor1, FailedForce, Failed );
	 L2BlankCost := IF ( lfor2, FailedForce, Failed );
	 L1R1 := Match1L(L1,lspec1,lnne1,lfor1,R1);
	 L1R2 := Match1L(L1,lspec1,lnne1,lfor1,R2);
	 L2R1 := Match1L(L2,lspec2,lnne2,lfor2,R1);
	 L2R2 := Match1L(L2,lspec2,lnne2,lfor2,R2);
	 return	MAP ( L1 = '' => IF ( lnne1, MAX( L2R1, L2R2 ), L1BlankCost ),
							  L2 = '' => IF ( lnne2, MAX( L1R1, L1R2 ), L2BlankCost ),
								R1 = '' => MAX ( IF ( lnne1, L2R2, L1BlankCost ), IF ( lnne2, L1R2, L2BlankCost ) ),
								R2 = '' => MAX ( IF ( lnne1, L2R1, L1BlankCost ), IF ( lnne2, L1R1, L2BlankCost ) ),
								L1 = R1 and L2 = R2 or L1 = R2 AND L2 = R1 => lspec1+lspec2,
								lfor1 or lfor2 => FailedForce,
								Failed );
		END;
// Used when coming in from outside; need to try both left and right being the correct way around
export Match2(
							StrType L1,unsigned2 lspec1,boolean lnne1,boolean lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,boolean lfor2,
							StrType R1,
						  StrType R2
							) :=
							MAX( 
									 Match2L(L1,lspec1,lnne1,lfor1,L2,lspec2,lnne2,lfor2,R1,R2), 
									 Match2L(R1,lspec1,lnne1,lfor1,R2,lspec2,lnne2,lfor2,L1,L2)
									 );
shared Match3L(
							StrType L1,unsigned2 lspec1,boolean lnne1,boolean lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,boolean lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,boolean lfor3,
							StrType R1,StrType R2,StrType R3) := FUNCTION
	// Strategy - deal with L1 - and then two fields left, which is a solved problem ...
   L1BlankCost := IF ( lfor1, FailedForce, Failed );
	 L23R12 := Match2L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,R1,R2);
	 L23R23 := Match2L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,R2,R3);
	 L23R13 := Match2L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,R1,R3);
	 return	MAP ( L1 = '' => IF ( lnne1, MAX( L23R12, L23R23, L23R13 ), L1BlankCost ),
								L1 = R1 => IF ( L23R23 > 0, L23R23+lspec1, L23R23 ), // Ifs needed to carry back force and nneq conditions
								L1 = R2 => IF ( L23R13 > 0, L23R13+lspec1, L23R13 ),
								L1 = R3 => IF ( L23R12 > 0, L23R12+lspec1, L23R12 ),
								R1 = '' => IF ( lnne1, L23R23, L1BlankCost ), // Didn't like the other fields - so swallow the blank
								lfor1 => FailedForce,
								Failed );
		END;
									 
export Match3(
							StrType L1,unsigned2 lspec1,boolean lnne1,boolean lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,boolean lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,boolean lfor3,
							StrType R1,
						  StrType R2,
						  StrType R3
							) :=
							MAX(
								Match3L(L1,lspec1,lnne1,lfor1,L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,R1,R2,R3),
								Match3L(R1,lspec1,lnne1,lfor1,R2,lspec2,lnne2,lfor2,R3,lspec3,lnne3,lfor3,L1,L2,L3)
								);
shared Match4L(
							StrType L1,unsigned2 lspec1,boolean lnne1,boolean lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,boolean lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,boolean lfor3,
						  StrType L4,unsigned2 lspec4,boolean lnne4,boolean lfor4,
							StrType R1,StrType R2,StrType R3,StrType R4) := FUNCTION
	// Strategy - deal with L1 - and then three fields left, which is a solved problem ...
   L1BlankCost := IF ( lfor1, FailedForce, Failed );
	 L234R123 := Match3L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,R1,R2,R3);
	 L234R124 := Match3L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,R1,R2,R4);
	 L234R134 := Match3L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,R1,R3,R4);
	 L234R234 := Match3L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,R2,R3,R4);
	 return	MAP ( L1 = '' => IF ( lnne1, MAX( L234R123, L234R124, L234R134, L234R234 ), L1BlankCost ),
								L1 = R1 => IF ( L234R234 > 0, L234R234+lspec1, L234R234 ),
								L1 = R2 => IF ( L234R134 > 0, L234R134+lspec1, L234R134 ),
								L1 = R3 => IF ( L234R124 > 0, L234R124+lspec1, L234R124 ),
								L1 = R4 => IF ( L234R123 > 0, L234R123+lspec1, L234R123 ),
								R1 = '' => IF ( lnne1, L234R234, L1BlankCost ),
								lfor1 => FailedForce,
								Failed );
		END;
									 
export Match4(
							StrType L1,unsigned2 lspec1,boolean lnne1,boolean lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,boolean lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,boolean lfor3,
						  StrType L4,unsigned2 lspec4,boolean lnne4,boolean lfor4,
							StrType R1,StrType R2,StrType R3,StrType R4
							) :=
							MAX(
								Match4L(L1,lspec1,lnne1,lfor1,L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,R1,R2,R3,R4),
								Match4L(R1,lspec1,lnne1,lfor1,R2,lspec2,lnne2,lfor2,R3,lspec3,lnne3,lfor3,R4,lspec4,lnne4,lfor4,L1,L2,L3,L4)
								);
shared Match5L(
							StrType L1,unsigned2 lspec1,boolean lnne1,boolean lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,boolean lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,boolean lfor3,
						  StrType L4,unsigned2 lspec4,boolean lnne4,boolean lfor4,
						  StrType L5,unsigned2 lspec5,boolean lnne5,boolean lfor5,
							StrType R1,StrType R2,StrType R3,StrType R4,StrType R5) := FUNCTION
	// Strategy - deal with L1 - and then three fields left, which is a solved problem ...
   L1BlankCost := IF ( lfor1, FailedForce, Failed );
	 L2345R1234 := Match4L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R1,R2,R3,R4);
	 L2345R1235 := Match4L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R1,R2,R3,R5);
	 L2345R1245 := Match4L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R1,R2,R4,R5);
	 L2345R1345 := Match4L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R1,R3,R4,R5);
	 L2345R2345 := Match4L(L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R2,R3,R4,R5);
	 return	MAP ( L1 = '' => IF ( lnne1, MAX( L2345R1234, L2345R1235, L2345R1245, L2345R1345, L2345R2345 ), L1BlankCost ),
								L1 = R1 => IF ( L2345R2345 > 0, L2345R2345+lspec1, L2345R2345 ),
								L1 = R2 => IF ( L2345R1345 > 0, L2345R1345+lspec1, L2345R1345 ),
								L1 = R3 => IF ( L2345R1245 > 0, L2345R1245+lspec1, L2345R1245 ),
								L1 = R4 => IF ( L2345R1235 > 0, L2345R1235+lspec1, L2345R1235 ),
								L1 = R5 => IF ( L2345R1234 > 0, L2345R1234+lspec1, L2345R1234 ),
								R1 = '' => IF ( lnne1, L2345R2345, L1BlankCost ),
								lfor1 => FailedForce,
								Failed );
		END;
									 
export Match5(
							StrType L1,unsigned2 lspec1,boolean lnne1,boolean lfor1,
						  StrType L2,unsigned2 lspec2,boolean lnne2,boolean lfor2,
						  StrType L3,unsigned2 lspec3,boolean lnne3,boolean lfor3,
						  StrType L4,unsigned2 lspec4,boolean lnne4,boolean lfor4,
						  StrType L5,unsigned2 lspec5,boolean lnne5,boolean lfor5,
							StrType R1,StrType R2,StrType R3,StrType R4,StrType R5
							) :=
							MAX(
								Match5L(L1,lspec1,lnne1,lfor1,L2,lspec2,lnne2,lfor2,L3,lspec3,lnne3,lfor3,L4,lspec4,lnne4,lfor4,L5,lspec5,lnne5,lfor5,R1,R2,R3,R4,R5),
								Match5L(R1,lspec1,lnne1,lfor1,R2,lspec2,lnne2,lfor2,R3,lspec3,lnne3,lfor3,R4,lspec4,lnne4,lfor4,R5,lspec5,lnne5,lfor5,L1,L2,L3,L4,L5)
								);
  end;
