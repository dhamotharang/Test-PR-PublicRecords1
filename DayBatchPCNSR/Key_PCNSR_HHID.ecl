import doxie, data_services;

DayBatchPCNSR.Layout_PCNSR_prekey  reformat(DayBatchPCNSR.File_PCNSR l) := transform 

   self:= l ;
end; 

file_prekey_in:= project(DayBatchPCNSR.File_PCNSR ,reformat(left));  

in_file := file_prekey_in(hhid <> 0);

export Key_PCNSR_HHID := index(in_file,
                               {hhid},
                               {in_file},
                               data_services.data_location.prefix() + 'thor_data::key::daybatch_pcnsr::'+doxie.Version_SuperKey+'::pcnsr.hhid');