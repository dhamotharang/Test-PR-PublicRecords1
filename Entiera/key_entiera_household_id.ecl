import doxie, data_services;

//orig_houseold_id is variable length. so have to first convert to fixed length. 
//index does not like variable length fields.
temp_ds := project(File_Entiera_Base_for_Keys(did>0),Layouts.Base_For_Indexes);

entiera.All_Entiera_Layouts.Entiera_household_id_fixed tFix_houseoldID(temp_ds l) := transform
self.household_id := l.orig_pmghousehold_id;
self.individual_id := l.orig_pmgindividual_id;
self:=l;
end;

entiera_household_id := project(temp_ds, tFix_houseoldID(left));



//enter houseold_id and get the rest of the record back				   
export key_entiera_household_id := 
index(entiera_household_id
      ,{household_id,individual_id}
			,{entiera_household_id}
			,data_services.data_location.prefix() + 'thor_200::key::entiera::'+doxie.Version_SuperKey+'::household_id'
	 );