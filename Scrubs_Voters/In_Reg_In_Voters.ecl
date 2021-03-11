IMPORT VotersV2, data_services;

export In_Reg_In_Voters 
  := dataset(VotersV2.cluster+'in::Voters::used',VotersV2.Layout_Voters_In,thor);