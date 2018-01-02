import avm, doxie, ut, data_services;

f := avm.File_AVM_Base(trim(prim_name)<>'', trim(zip)<>'');

  
export Key_AVM_Address := index(f,
             {prim_name,
		    st,
		    zip, 
		    prim_range, 
		    sec_range},
		    {f},
			data_services.data_location.prefix() + 'thor_data400::key::avm::' + doxie.Version_SuperKey+'::address');