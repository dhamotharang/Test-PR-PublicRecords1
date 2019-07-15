Import Data_Services, doxie, ut;

f := avm_v2.File_AVM_Base(trim(prim_name)<>'', trim(zip)<>'');

//DF-21487 blank out specifed fields in thor_data400::key::avm_v2::fcra::qa::address
ut.MAC_CLEAR_FIELDS(f, fcra_f_cleared, AVM_V2.Constants.fields_to_clear);

export Key_AVM_Address_FCRA := index(fcra_f_cleared,
             {prim_name,
		    st,
		    zip, 
		    prim_range, 
		    sec_range},
		    {fcra_f_cleared},
			Data_Services.Data_location.Prefix('avm')+'thor_data400::key::avm_v2::fcra::' + doxie.Version_SuperKey+'::address');