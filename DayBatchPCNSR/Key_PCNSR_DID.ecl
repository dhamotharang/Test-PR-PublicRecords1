import doxie;

in_file := DayBatchPCNSR.prep_key();

export Key_PCNSR_DID := index(in_file(did!=0),{did},
															{in_file},'~thor_data::key::daybatch_pcnsr::'+doxie.Version_SuperKey+'::pcnsr.did');