Import data_services;
r	:=Bair_composite.layouts.Make_index;
d	:=dataset([],r);
EXPORT Key_Vehicle_Make(string v = 'qa', boolean isDelta = false):= 
									Index(d,{wd_make},{d},data_services.data_location.prefix() + 'thor_data400::key::bair_composite::vehicle::' +if(isDelta,'delta::','') +v +'::make',opt);