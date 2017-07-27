Import Data_Services, doxie, ut;

f := avm_v2.File_AVM_Base(trim(unformatted_apn)<>'');

export Key_AVM_APN := index(f,{unformatted_apn},{f},
		Data_Services.Data_location.Prefix('avm')+'thor_data400::key::avm_v2::' + doxie.Version_SuperKey+'::apn');