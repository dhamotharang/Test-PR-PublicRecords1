Import STD, MDR, doxie,Gong, Suppress,PhonesPlus_v2;
//CCPA-799 - create a routine to apply optout suppression 

Export fn_Apply_OptOut := MODULE

Export Gong(dataset(recordof(Gong.Key_History_Phone)) ds_in) := FUNCTION;
Shared mod_access := MODULE(doxie.IDataAccess) END; // default mod_access 

//Gong Virtual was used because the history sources are not in the lookup
assign_global_sid := MDR.macGetGlobalSid(ds_in, 'Gong_Virtual', '', 'global_sid');	

opted_out :=  Suppress.MAC_SuppressSource(assign_global_sid, mod_access, , , TRUE); 

Return opted_out;

End;

// Export PPlus(dataset(recordof(PhonesPlus_v2.Key_Phonesplus_Fdid)) ds_in) := FUNCTION;
// Shared mod_access := MODULE(doxie.IDataAccess) END; // default mod_access 


// assign_global_sid := MDR.macGetGlobalSid(ds_in, 'PhonesplusV2_Virtual', '', 'global_sid');	

// opted_out :=  Suppress.MAC_SuppressSource(assign_global_sid, mod_access, , , TRUE); 

// Return opted_out;

// End;

End;