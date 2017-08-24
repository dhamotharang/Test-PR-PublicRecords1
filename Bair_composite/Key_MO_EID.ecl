import data_services;

r := RECORD
		string23 eid,
		string12 phone,
		boolean	 iscurrent
END;	

d	:=dataset([],r);
EXPORT Key_MO_EID(string v = 'qa', boolean isDelta = false):= 
									Index(d,{eid},{d},data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair_composite::mo::v2::' +if(isDelta,'delta::','') +v +'::eid',opt);