import header;

export Aircraft_as_Source(dataset(faa.layout_aircraft_registration_out) pAircraft = dataset([],faa.layout_aircraft_registration_out), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::AircraftHeader_Building',faa.layout_aircraft_registration_out,flat),
					   pAircraft
					  );
	src_rec := record
	 header.Layout_Source_ID;
	 faa.layout_aircraft_registration_out;
	end;

	header.Mac_Set_Header_Source(dSourceData,faa.layout_aircraft_registration_out,src_rec,'AR',withUID)

	dForHeader	:=	withUID	: persist('persist::headerbuild_aircraft_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
