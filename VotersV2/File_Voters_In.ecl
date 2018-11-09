import VotersV2;

export File_Voters_In() := function
  //return dataset(VotersV2.cluster+'in::Voters::'+source_state+'::raw_'+ filedate,Layout_Voters_In,thor);
  //Barb O'Neill changed this code for DOPS-461.	
	return dataset(VotersV2.cluster+'in::Voters::using',Layout_Voters_In,thor);
end;