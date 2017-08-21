import header;

export Aircraft_as_Source(dataset(faa.layout_aircraft_registration_out) pAircraft = dataset([],faa.layout_aircraft_registration_out), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::AircraftHeader_Building',faa.layout_aircraft_registration_out,flat),
					   pAircraft
					  );
	src_rec := header.layouts_SeqdSrc.AC_src_rec;

	header.Mac_Set_Header_Source(dSourceData,faa.layout_aircraft_registration_out,src_rec,'AR',withUID)

	return withUID;
  end
 ;
