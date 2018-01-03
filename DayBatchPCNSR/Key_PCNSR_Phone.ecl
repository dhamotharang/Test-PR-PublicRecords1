import InfoUSA, doxie, data_services;

in_file := DayBatchPCNSR.prep_key();

export Key_PCNSR_Phone :=  
       index(in_file,
             {phone_number,
							area_code, 
							st},
							{in_file},
							data_services.data_location.prefix() + 'thor_data::key::daybatch_pcnsr::'+doxie.Version_SuperKey+'::pcnsr.phone.area_code.st');