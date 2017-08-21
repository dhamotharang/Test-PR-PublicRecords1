import header;

export asl_as_source(dataset(american_student_list.layout_american_student_base_v2) pASL = dataset([],american_student_list.layout_american_student_base_v2), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	project(if(pForHeaderBuild
					   ,dataset('~thor_data400::Base::ASLHeader_Building',american_student_list.layout_american_student_base_v2,flat)
					   ,pASL
					  ),american_student_list.layout_american_student_base);

	src_rec := header.layouts_SeqdSrc.SL_src_rec;
	 
	header.Mac_Set_Header_Source(dSourceData,american_student_list.layout_american_student_base,src_rec,'SL',withUID)

	return withUID;
  end
 ;
