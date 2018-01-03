import doxie, data_services;

entiera_did					:= project(File_Entiera_Base_for_Keys(did>0),Layouts.Base_For_Indexes);
entiera_did_w_fakes	:= project(Key_Payload,Layouts.Base_For_Indexes);

entiera_did_ready		:= entiera_did_w_fakes + entiera_did;

//enter did and get the did and the rest of the record back				   
export key_entiera_did := 
index(entiera_did_ready
      ,{did}
      ,{entiera_did_ready}
			,data_services.data_location.prefix() + 'thor_200::key::entiera::'+doxie.Version_SuperKey+'::did'
	 );