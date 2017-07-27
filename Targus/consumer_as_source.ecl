import header;

export Consumer_as_Source(dataset(targus.layout_consumer_out) pTargusConsumer = dataset([],targus.layout_consumer_out), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   file_consumer_base,
					   pTargusConsumer
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 targus.layout_consumer_out;
	end;

	header.Mac_Set_Header_Source(dSourceData,targus.layout_consumer_out,src_rec,'WP',withUID)

	dForHeader	:=	withUID	: persist('persist::headerbuild_consumer_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
