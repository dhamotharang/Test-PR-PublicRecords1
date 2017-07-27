import DayBatchPCNSR, doxie;

in_file := DayBatchPCNSR.prep_key();

sortPhone := SORT(in_file,zip,zip4,prim_name,prim_range,sec_range,area_code,phone_number);

dPhone := DEDUP(sortPhone,zip,zip4,prim_name,prim_range,sec_range,area_code,phone_number);

export Key_PCNSR_Nbr :=  
       index(dPhone,
             {zip,zip4,prim_name,prim_range,sec_range
							},
							{dPhone},
							'~thor_data::key::daybatch_pcnsr::'+doxie.Version_SuperKey+'::pcnsr.zz4317_deduped');
