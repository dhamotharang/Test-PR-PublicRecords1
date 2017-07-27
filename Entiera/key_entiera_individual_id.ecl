import doxie,ut;
//orig_indivdual_id is variable length. so have to first convert to fixed length. 
//index does not like variable length fields.
temp_ds := project(File_Entiera_Base_for_Keys(did>0),Layouts.Base_For_Indexes);

entiera.All_Entiera_Layouts.Entiera_individual_id_fixed tFix_individualID(temp_ds l) := transform
self.individual_id := l.orig_pmgindividual_id;
self:=l;
end;

entiera_individual_id := project(temp_ds, tFix_individualID(left));



//enter houseold_id and get the rest of the record back				   
export key_entiera_individual_id := 
index(entiera_individual_id
      ,{individual_id}
			,{entiera_individual_id}
			,'~thor_200::key::entiera::'+doxie.Version_SuperKey+'::individual_id'
	 );
