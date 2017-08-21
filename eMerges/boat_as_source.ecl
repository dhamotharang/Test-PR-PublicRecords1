import header;

export Boat_as_Source(dataset(layout_boats_in) peMergesBoats = dataset([],layout_boats_in), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::BoatHeader_Building',layout_boats_in,flat),
					   peMergesBoats
					  );

	src_rec := header.layouts_SeqdSrc.BO_src_rec;

	header.Mac_Set_Header_Source(dSourceData,layout_boats_in,src_rec,'EB',withUID)

	return withUID;
  end
 ;
