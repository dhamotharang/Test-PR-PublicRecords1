import header,Impulse_Email,MDR,data_services;

export Impulse_Email_as_Source(dataset(Impulse_Email.layouts.layout_Impulse_Email_final) pImpulseEmail = dataset([],Impulse_Email.layouts.layout_Impulse_Email_final), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForFCRAHeaderBuild
					   ,dataset(data_services.foreign_prod + 'thor_data400::Base::ImpulseEmailFCRAHeader_Building',Impulse_Email.layouts.layout_Impulse_Email_final,flat)(did != 0 AND length(trim(siteid))<5 AND record_type != 'I')
					   ,pImpulseEmail
					  );

	src_rec := header.layouts_SeqdSrc.IM_src_rec;
	
	header.Mac_Set_Header_Source(dSourceData,Impulse_Email.layouts.layout_Impulse_Email_final,src_rec,MDR.sourceTools.src_Impulse,withUID)

	return withUID;
  end
 ;

