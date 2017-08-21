import data_services;
r	:=Bair_composite.layouts.body_index;
d	:=dataset([],r);
EXPORT Key_Vehicle_Body(string v = 'qa', boolean isDelta = false):= 
									Index(d,{wd_bodystyle,i},{d},'~thor_data400::key::bair_composite::vehicle::' +if(isDelta,'delta::','') +v +'::body',opt);