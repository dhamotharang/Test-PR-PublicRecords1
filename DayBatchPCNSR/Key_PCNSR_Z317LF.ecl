import DayBatchPCNSR, doxie, data_services;

in_file := DayBatchPCNSR.prep_key();

export Key_PCNSR_Z317LF :=  
       index(in_file,
             {zip,
							prim_name, 
							prim_range,
							sec_range,
							lname,
							fname
							},
							{in_file},
							data_services.data_location.prefix() + 'thor_data::key::daybatch_pcnsr::'+doxie.Version_SuperKey+'::pcnsr.z137lf');