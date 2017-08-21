import data_services;
r	:=Bair_composite.layouts.Phone_Parse;
d	:=dataset([],r);
EXPORT Key_MO_EID(string v = 'qa', boolean isDelta = false):= 
									Index(d,{eid},{d},'~thor_data400::key::bair_composite::mo::v2::' +if(isDelta,'delta::','') +v +'::eid',opt);