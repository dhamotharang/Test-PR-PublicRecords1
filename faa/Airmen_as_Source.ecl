import header;

export Airmen_as_Source(dataset(faa.layout_airmen_data_out) pAirmen = dataset([],faa.layout_airmen_data_out), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::AirmenHeader_Building',faa.layout_airmen_data_out,flat),
					   pAirmen
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 faa.layout_airmen_data_out;
	end;
	 
	header.Mac_Set_Header_Source(dSourceData,faa.layout_airmen_data_out,src_rec,'AM',withUID)

	dForHeader	:=	withUID	: persist('persist::headerbuild_airmen_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
