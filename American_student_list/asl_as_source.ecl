import header;

export asl_as_source(dataset(american_student_list.layout_american_student_base) pASL = dataset([],american_student_list.layout_american_student_base), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::ASLHeader_Building',american_student_list.layout_american_student_base,flat),
					   pASL
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 american_student_list.layout_american_student_base;
	end;
	 
	header.Mac_Set_Header_Source(dSourceData,american_student_list.layout_american_student_base,src_rec,'SL',withUID)

	dForHeader	:=	withUID	: persist('persist::headerbuild_asl_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
