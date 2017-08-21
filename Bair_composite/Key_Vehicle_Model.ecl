Import data_services;
r	:=Bair_composite.layouts.Model_index;
d	:=dataset([],r);
EXPORT Key_Vehicle_Model(string v = 'qa', boolean isDelta = false):= 
									Index(d,{wd_model},{d},'~thor_data400::key::bair_composite::vehicle::' +if(isDelta,'delta::','') +v +'::model',opt);