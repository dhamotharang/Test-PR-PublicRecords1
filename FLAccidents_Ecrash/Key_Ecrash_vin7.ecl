import doxie,FLAccidents, data_services;

ecrash_vin_base := pull(FLAccidents_Ecrash.Key_ecrash_vin);

Layout_eCrash_vin7 := record
	string7  l_vin7,
	string22 l_vin,
	string40 accident_nbr,
	end;

Layout_eCrash_vin7 add_vin7(ecrash_vin_base l):=transform

len:=length(trim(l.l_vin));
self.l_vin7:=l.l_vin[len-6..len];
self:=l;	
end;

ecrash_vin_base_7:=project(ecrash_vin_base,add_vin7(LEFT))(trim(l_vin7)<>'');

export Key_Ecrash_vin7 := index(ecrash_vin_base_7,
                                {l_vin7},
                                {l_vin,accident_nbr},
                                data_services.data_location.prefix() + 'thor_data400::key::ecrash_vin7_' + doxie.Version_SuperKey);