import doxie, Data_Services;

dslayout := record
	unsigned6 did;
	string15 booking_sid;
	//unsigned8 __internal_fpos__; 
END;

export Key_did := index(dataset([],{ unsigned6 did, string15 booking_sid}), 
				{did},{booking_sid}, 
				Data_Services.Data_location.Prefix('Appriss') + 'thor_200::key::appriss::' + doxie.Version_SuperKey + '::did');


