import header;

export alloy_as_source(dataset(AlloyMedia_student_list.layouts.layout_base) pAlloy = dataset([],AlloyMedia_student_list.layouts.layout_base), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	project(if(pForHeaderBuild
					   ,dataset('~thor_data400::base::alloymedia_student_list',AlloyMedia_student_list.layouts.layout_base,flat)
					   ,pAlloy
					  ),AlloyMedia_student_list.layouts.layout_base);

	src_rec := record
	 header.Layout_Source_ID;
	 AlloyMedia_student_list.layouts.layout_base;
	end;
	 
	header.Mac_Set_Header_Source(dSourceData,AlloyMedia_student_list.layouts.layout_base,src_rec,'AY',withUID)

	dForHeader	:=	withUID	: persist('persist::headerbuild_alloymedia_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
