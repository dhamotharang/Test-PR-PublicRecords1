import doxie, data_services;

in_file := DayBatchPCNSR.prep_key();

export Key_PCNSR_DID := index(in_file(did!=0),
                              {did},
															{in_file},
															data_services.data_location.prefix() + 'thor_data::key::daybatch_pcnsr::'+doxie.Version_SuperKey+'::pcnsr.did');