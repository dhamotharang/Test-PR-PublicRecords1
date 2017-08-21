import DEA, header;

export DEA_as_Source(dataset(DEA.layout_DEA_OUt_baseV2) pDEA = dataset([],DEA.layout_DEA_Out_baseV2), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::DeaHeader_Building',DEA.layout_DEA_Out_baseV2,flat),
					   pDEA
					  );

	src_rec := header.layouts_SeqdSrc.DEA_src_rec;

	header.Mac_Set_Header_Source(dSourceData,DEA.layout_DEA_Out_baseV2,src_rec,'DA',withUID)

	return withUID;
  end
 ;
