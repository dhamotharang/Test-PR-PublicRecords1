Import data_services;
r	:=Bair_composite.layouts.veh_wd_hole;
d	:=dataset([],r);
EXPORT Key_Vehicle_Wild(string v = 'qa', boolean isDelta = false):= 
									Index(d,{wd_make_code,wd_model_description,wd_color_code,wd_state_code,wd_zip,wd_body_code},{d},data_services.data_location.prefix() + 'thor_data400::key::bair_composite::vehicle::' +if(isDelta,'delta::','') +v +'::wild',opt);