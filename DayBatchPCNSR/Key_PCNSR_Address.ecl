import doxie, data_services;

DayBatchPCNSR.Layout_PCNSR_prekey  reformat(DayBatchPCNSR.File_PCNSR l) := transform 

   self:= l ;
end; 

file_prekey_in:= project(DayBatchPCNSR.File_PCNSR ,reformat(left));  
valid_addresses := file_prekey_in(zip<>'' and prim_name<>'');

export Key_PCNSR_Address := index(valid_addresses,
							{zip, prim_name, prim_range, sec_range},
							{valid_addresses}, 
							data_services.data_location.prefix() + 'thor_data400::key::daybatch_pcnsr::pcnsr.address_qa');