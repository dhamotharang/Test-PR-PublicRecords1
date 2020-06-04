IMPORT STD, MDR, doxie, Suppress, _Control;
EXPORT Fn_Apply_Opt_Out(dataset(recordof(PhonesPlus_V2.Layout_In_Phonesplus.layout_in_common)) phplus_in) := FUNCTION;
SHARED mod_access := MODULE(doxie.IDataAccess) END; // default mod_access  

assign_global_sid := MDR.macGetGlobalSid(phplus_in, 'PhonesPlusV2', 'source', 'global_sid');	
opt_out :=  Suppress.MAC_SuppressSource(assign_global_sid, mod_access, , , TRUE); 

RETURN opt_out;

END;
