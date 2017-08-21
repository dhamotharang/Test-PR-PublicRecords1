import header;

export MS_Worker_as_Source(dataset(Layout_MS_Workers_Comp_In) pMS_Worker = dataset([],Layout_MS_Workers_Comp_In), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::MSHeader_Building', Layout_MS_Workers_Comp_In, flat),
					   pMS_Worker
					  );

	src_rec := header.layouts_SeqdSrc.WC_src_rec;

	header.Mac_Set_Header_Source(dSourceData(employer_name!='DELETED'),Layout_MS_Workers_Comp_In,src_rec,'MW',withUID)
	
	return withUID;
  end;