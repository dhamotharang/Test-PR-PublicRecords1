import data_services,VehicleV2;

src_rec	:=	record
	header.layout_Source_ID;
	vehicleV2.layout_vehicle_source;
end;

export Key_Src_VehV2_bid(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function
prarty_base:= project(VehicleV2.Files.Base.Party_bid,transform(VehicleV2.Layout_Base.Party_bid,self.append_bdid:=left.bid,self:=left));
dVehicles_as_Source := if(pCombo,pDataset,vehiclev2.Vehicle_as_Source(if(pFastHeader,VehicleV2.Files.Base.Main),if(pFastHeader,prarty_base),~pFastHeader,pFastHeader));

mac_key_src(dVehicles_as_Source, vehicleV2.layout_vehicle_source, 
						veh_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::bid::veh_v2_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id)

return id;
end;