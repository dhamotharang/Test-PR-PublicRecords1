import avm, doxie, ut, data_services;

f := avm.File_AVM_Base(trim(unformatted_apn)<>'');

export Key_AVM_APN := index(f,{unformatted_apn},{f},
		data_services.data_location.prefix() + 'thor_data400::key::avm::' + doxie.Version_SuperKey+'::apn');
