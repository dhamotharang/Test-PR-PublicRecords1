import header;

export Consumer_as_Source(dataset(targus.layout_consumer_out) pTargusConsumer = dataset([],targus.layout_consumer_out), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild
					   ,dataset('~thor_data400::base::consumer_targusHeader_Building',layout_consumer_out,flat)
					   ,pTargusConsumer
					  );

	src_rec := header.layouts_SeqdSrc.WP_src_rec;

	header.Mac_Set_Header_Source(dSourceData,targus.layout_consumer_out,src_rec,'WP',withUID)

	return withUID;
  end
 ;
