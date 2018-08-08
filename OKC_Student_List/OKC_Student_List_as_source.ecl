import header;

export OKC_Student_List_as_source(dataset(OKC_Student_List.Layout_Base.base) pASL = dataset([],OKC_Student_List.Layout_Base.base), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	dataset('~thor_data400::Base::OKC_SLHeader_Building',OKC_Student_List.Layout_Base.base,flat);
					   
	src_rec := Header.layouts_SeqdSrc.S1_src_rec;
	 
	header.Mac_Set_Header_Source(dSourceData,OKC_Student_List.Layout_Base.base,src_rec,'S1',withUID)

	return withUID;
  end
 ;