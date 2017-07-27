import header;

export As_source(dataset(layouts.base) pCertegy = dataset([],layouts.base), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::certegyheader_Building',layouts.base,flat),
					   pCertegy
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 layouts.base;
	end;
	 
	header.Mac_Set_Header_Source(dSourceData,layouts.base,src_rec,'CY',withUID)//picked CY - not in MDR.sourceTools

	dForHeader	:=	withUID	: persist('persist::headerbuild_certegy_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;