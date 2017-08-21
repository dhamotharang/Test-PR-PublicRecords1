import ut;
EXPORT File_External_xADLstudent :=MODULE
	//export file := ut.foreign_prod+'thor_data400::persist::asl_XADL1';	
	export file := '~thor_data400::persist::asl_XADL1_201102_patch';
	export inDataxADL1 := dataset(file,PersonLinkingADL2V2.layout_Person_xADL1,thor);
	
	export studentsADL1 := project(inDataxADL1,
											transform(PersonLinkingADL2V2.Layout_Person_xAdl12,				
											self.sourceid :=0,
											self.UniqueID := counter,
											self.Weight :=0,
											self.score :=left.did_score, //did_score
											self := left));// : persist('studentsADL1');			
	
	export studentsInADL1 := project(studentsADL1,PersonLinkingADL2V2.layout_Person_xADL2);// : persist('studentsInADL1');
	
	export studentsADL1Hits := studentsADL1(score>75) ;//: persist('studentsADL1Hits');									
	export studentsInADL1Hits :=project(studentsADL1Hits,PersonLinkingADL2V2.layout_Person_xADL2);// : persist('studentsInADL1Hits');
	  
	export studentsADL1NotSure := studentsADL1(score<=75 AND score>0);// : persist('studentsADL1NotSure'); 											
	export studentsInADL1NotSure:= project(studentsADL1NotSure, PersonLinkingADL2V2.layout_Person_xADL2);// : persist('studentsInADL1NotSure');

  export studentsADL1NoHits := studentsADL1(score=0);// : persist('studentsADL1NoHits'); 											
	export studentsInADL1NoHits := project(studentsADL1NoHits, PersonLinkingADL2V2.layout_Person_xADL2);// : persist('studentsInADL1NoHits');

END;