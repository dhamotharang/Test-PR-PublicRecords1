import doxie, data_services;

ntlcrash_vin_base := pull(FLAccidents.Key_ntlcrash_vin);

FLAccidents.Layout_NtlCrash_vin7 add_vin7(ntlcrash_vin_base l):=transform

len:=length(trim(l.l_vin));
self.l_vin7:=l.l_vin[len-6..len];
self:=l;	
end;

ntlcrash_vin_base_7:=project(ntlcrash_vin_base,add_vin7(LEFT))(trim(l_vin7)<>'');

export Key_ntlcrash_vin7 := index(ntlcrash_vin_base_7,
                                  {l_vin7},
                                  {l_vin,accident_nbr},
                                  data_services.data_location.prefix() + 'thor_data400::key::ntlcrash_vin7_' + doxie.Version_SuperKey);