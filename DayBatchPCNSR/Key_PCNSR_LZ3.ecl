import DayBatchPCNSR, doxie, data_services;

in_file := DayBatchPCNSR.prep_key();

export Key_PCNSR_LZ3 :=  
       index(in_file,
             {lname,
							zip,
							prim_name
							},
							{in_file},
							data_services.data_location.prefix() + 'thor_data::key::daybatch_pcnsr::'+doxie.Version_SuperKey+'::pcnsr.lz3');