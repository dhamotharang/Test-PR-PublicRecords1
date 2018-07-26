export Proc_QA_Samples := function

	AccidentBase						:= OSHAIR.Files().Base.Accident.qa;
	HazardousBase						:= OSHAIR.Files().Base.Hazardous.qa;
	InspectionBase					:= OSHAIR.Files().Base.Inspection.qa;
	OptionalInfoBase				:= OSHAIR.Files().Base.OptionalInfo.qa;
	ProgramBase							:= OSHAIR.Files().Base.Program.qa;
	RelatedActivityBase			:= OSHAIR.Files().Base.Related_Activity.qa;
	ViolationsBase					:= OSHAIR.Files().Base.Violations.qa;
	
	Sample_Records  				:=sequential(output(topn(AccidentBase, 500, -dt_first_seen),named('Accident_Samples')),
																			 output(topn(HazardousBase, 500, -dt_first_seen) ,named('Hazardous_Samples')),
																			 output(topn(InspectionBase, 500, -dt_first_seen),named('Inspection_Samples')),
																			 output(topn(OptionalInfoBase, 500, -dt_first_seen),named('OptionalInfo_Samples')),
																			 output(topn(ProgramBase, 500, -dt_first_seen),named('Program_Samples')),
																			 output(topn(RelatedActivityBase, 500, -dt_first_seen),named('RelatedActivity_Samples')),
																			 output(topn(ViolationsBase, 500, -dt_first_seen),named('Violation_Samples'))
																			); 

	return Sample_Records;
	
						  
end;