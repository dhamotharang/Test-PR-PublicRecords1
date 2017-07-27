import DayBatchPCNSR, doxie;

in_file := DayBatchPCNSR.prep_key();

sortPhone := SORT(in_file,lname,zip,area_code,phone_number);

dPhone := DEDUP(sortPhone,lname,zip,area_code,phone_number);

export Key_PCNSR_Surnames :=  
       index(dPhone,
             {lname,
							zip,
							prim_name
							},
							{dPhone},
							'~thor_data::key::daybatch_pcnsr::'+doxie.Version_SuperKey+'::pcnsr.lz3_deduped');
