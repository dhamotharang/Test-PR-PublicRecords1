import InfoUSA, doxie;

in_file := DayBatchPCNSR.prep_key();

export Key_PCNSR_Phone :=  
       index(in_file,
             {phone_number,
							area_code, 
							st},
							{in_file},
							'~thor_data::key::daybatch_pcnsr::'+doxie.Version_SuperKey+'::pcnsr.phone.area_code.st');
							
