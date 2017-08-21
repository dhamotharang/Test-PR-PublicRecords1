import header;

export As_source(dataset(layouts.base) pCertegy = dataset([],layouts.base), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::certegyheader_Building',layouts.base,flat),
					   pCertegy
					  );

	src_rec := header.layouts_SeqdSrc.CY_src_rec;
	 
	header.Mac_Set_Header_Source(dSourceData,layouts.base,src_rec,'CY',withUID)//picked CY - not in MDR.sourceTools

	return withUID;
  end
 ;