import data_services;
r	:=Bair_composite.layouts.Phone_Parse;
d	:=dataset([],r);
EXPORT Key_MO_PHONE(string v = 'qa', boolean isDelta = false):= 
										Index(d,{phone},{d},'~thor_data400::key::bair_composite::mo::v2::' +if(isDelta,'delta::','') +v +'::phone',opt);