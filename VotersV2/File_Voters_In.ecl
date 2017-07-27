import VotersV2;

export File_Voters_In(string source_state, string filedate) := function
	return dataset(VotersV2.cluster+'in::Voters::'+source_state+'::raw_'+ filedate,Layout_Voters_In,thor);
end;