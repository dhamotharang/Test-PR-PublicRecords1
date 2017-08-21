import header;

export Airmen_as_Source(dataset(faa.layout_airmen_data_out) pAirmen = dataset([],faa.layout_airmen_data_out), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::AirmenHeader_Building',faa.layout_airmen_data_out,flat),
					   pAirmen
					  );

	src_rec := header.layouts_SeqdSrc.AM_src_rec;
	 
	header.Mac_Set_Header_Source(dSourceData,faa.layout_airmen_data_out,src_rec,'AM',withUID)

	return withUID;
  end
 ;
