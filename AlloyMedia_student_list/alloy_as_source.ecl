import header;

export alloy_as_source(dataset(AlloyMedia_student_list.layouts.layout_base) pAlloy = dataset([],AlloyMedia_student_list.layouts.layout_base), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	project(if(pForHeaderBuild
					   ,dataset('~thor_data400::base::alloymedia_student_list_Header_Building',AlloyMedia_student_list.layouts.layout_base,flat)
					   ,pAlloy
					  ),AlloyMedia_student_list.layouts.layout_base);

	src_rec := header.layouts_SeqdSrc.AY_src_rec;
	 
	header.Mac_Set_Header_Source(dSourceData,AlloyMedia_student_list.layouts.layout_base,src_rec,'AY',withUID)

	return withUID;
  end
 ;
