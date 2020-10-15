IMPORT VotersV2;

export In_Reg_In_Voters := function
	return dataset(VotersV2.cluster+'in::Voters::sprayed',VotersV2.Layout_Voters_In,thor);
end;