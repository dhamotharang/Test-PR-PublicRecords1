import header;

export didRules(dataset(header.Layout_Header) head) :=
	FUNCTION
		
	//***** A LITTLE BIT OF WORK ON THE FILE BEFORE ADL2 IS READY FOR IT
	prep := NGADL.fn_PrepHeader(head);
		
	//***** THIS DOES ALL THE ADL2 HEAVY LIFTING	
	am := NGADL.matches(prep).All_Matches;
	
	//***** THIS KEEPS OUT SOME MATCHES THAT ARE CURRENTLY BELEIVED TO BE TOO AMBIGUOUS	
	fa := NGADL.fn_FilterAmbiguous(am);
	
	//***** CALL THE MACRO THAT AVOIDS TRANSITIVE CLOSURE AND THAT EXPECTS A DISTRIBUTED DATASET	
	di := distribute(fa, hash(did1));
	ngadl.mac_avoid_transitives(fa,DID1,DID2,Conf,Rule,notran)				
	
	//***** GET THIS INTO THE LAYOUT THAT IS EXPECTED BY HEADER.Did_Rules0	
	out := 
			project(
				notran(conf >= NGADL.constants.ConfThreshold),  
				transform(
					Header.Layout_PairMatch, 
					self.new_rid := left.DID2,
					self.old_rid := left.DID1,
					self.pflag := 16
				)
			);
	
	//***** DEBUGGING TOOLS - BUILD KEYS AND OUTPUT STATS
	mod := NGADL.Proc_Iterate('1',prep);
	deb := parallel(/*mod.OutputSamples,*/mod.ExecutionStats,mod.ValidityStats,mod.DebugKeys,mod.OutputCandidates);
	outsuc := out : success(deb);
	
	
	
	//start temp code
	// m := NGADL.matches(prep).Matches;
	// output(count(m), named('count_m'));
	// output(m,,'cemtemp::m',overwrite);
	// output(am,,'cemtemp::am',overwrite);
	//end temp code
	return outsuc;
			
	END;