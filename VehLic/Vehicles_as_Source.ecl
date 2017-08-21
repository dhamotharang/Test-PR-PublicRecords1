import header,ut;

export Vehicles_as_Source(dataset(Vehlic.layout_vehicles) pVehicles = dataset([],Vehlic.layout_vehicles), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::BASE::VehiclesHeader_Building',layout_vehicles,flat,unsorted)(veh_type!='VS'),
					   pVehicles(veh_type!='VS')
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 layout_vehicles;
	end;

	header.Mac_Set_Header_Source(dSourceData,layout_vehicles,src_rec,header_src(l.orig_state,l.source_code),withID)

	dForHeader	:=	withID	: persist('persist::headerbuild_veh_src');
	dForOther	:=	withID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
	