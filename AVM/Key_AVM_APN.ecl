import avm, doxie, ut;

f := avm.File_AVM_Base(trim(unformatted_apn)<>'');

export Key_AVM_APN := index(f,{unformatted_apn},{f},
		'~thor_data400::key::avm::' + doxie.Version_SuperKey+'::apn');
