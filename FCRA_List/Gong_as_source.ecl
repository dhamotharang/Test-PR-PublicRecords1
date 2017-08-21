import header,gong_neustar,MDR,data_services;

export Gong_as_Source(dataset(gong_neustar.Layout_History) pGonghistory = dataset([],gong_neustar.Layout_History), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForFCRAHeaderBuild
					   ,dataset(data_services.foreign_prod + 'thor_data400::Base::GongFCRAHeader_Building',gong_neustar.Layout_History,flat)(DID != 0)
					   ,pGonghistory
					  );

	src_rec := header.layouts_SeqdSrc.GN_src_rec;
	
	header.Mac_Set_Header_Source(dSourceData,gong_neustar.Layout_History,src_rec,MDR.sourceTools.src_Gong_Neustar,withUID)

	return withUID;
  end
 ;

