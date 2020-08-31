Import Data_Services, doxie,FLAccidents;

ecrash_vin_base := pull(FLAccidents_Ecrash.Key_EcrashV2_vin);

Layout_eCrash_vin7 := record
	string7  l_vin7,
	string30 l_vin,
	string40 accident_nbr,
	string40 orig_accnbr, 
	end;

Layout_eCrash_vin7 add_vin7(ecrash_vin_base l):=transform

len:=length(trim(l.l_vin));
self.l_vin7:=l.l_vin[len-6..len];
self:=l;	
end;

ecrash_vin_base_7:=project(ecrash_vin_base,add_vin7(LEFT))(trim(l_vin7)<>'');

export Key_EcrashV2_vin7 := index(ecrash_vin_base_7
							,{l_vin7}
							,{l_vin,accident_nbr,orig_accnbr}
							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_vin7_' + doxie.Version_SuperKey);