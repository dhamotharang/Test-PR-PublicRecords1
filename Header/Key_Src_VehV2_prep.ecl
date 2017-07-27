import ut,VehicleV2;

export Key_Src_VehV2_prep(boolean pFastHeader = false) := function

dVehicles_as_Source := vehiclev2.Vehicle_as_Source(if(pFastHeader,VehicleV2.Files.Base.Main),if(pFastHeader,VehicleV2.Files.Base.Party_bip),~pFastHeader,pFastHeader);

mac_key_src(dVehicles_as_Source, vehicleV2.layout_vehicle_source, 
						veh_child, 
						ut.Data_Location.Person_header+'thor_data400::key::veh_v2_src_index_'+SF_suffix(pFastHeader)+'_',id)

return id;
end;