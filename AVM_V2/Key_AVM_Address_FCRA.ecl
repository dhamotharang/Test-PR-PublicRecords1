Import Data_Services, doxie;

f := avm_v2.File_AVM_Base(trim(prim_name)<>'', trim(zip)<>'');

export Key_AVM_Address_FCRA := index(f,
             {prim_name,
		    st,
		    zip, 
		    prim_range, 
		    sec_range},
		    {f},
			Data_Services.Data_location.Prefix('avm')+'thor_data400::key::avm_v2::fcra::' + doxie.Version_SuperKey+'::address');