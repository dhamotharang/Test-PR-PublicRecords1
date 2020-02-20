Import Data_Services, doxie, vault, _control;

f := avm_v2.File_AVM_Base(trim(prim_name)<>'', trim(zip)<>'');

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_AVM_Address_FCRA := vault.AVM_V2.Key_AVM_Address_FCRA;
#ELSE
export Key_AVM_Address_FCRA := index(f,
             {prim_name,
		    st,
		    zip, 
		    prim_range, 
		    sec_range},
		    {f},
			Data_Services.Data_location.Prefix('avm')+'thor_data400::key::avm_v2::fcra::' + doxie.Version_SuperKey+'::address');
#END;


