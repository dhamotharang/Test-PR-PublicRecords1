import header,CNLD_Practitioner,MDR,data_services;

export CNLD_Practitioner_as_Source(dataset(CNLD_Practitioner.layouts.keybuild) pCNLDPractitioner = dataset([],CNLD_Practitioner.layouts.keybuild), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForFCRAHeaderBuild
					   ,dataset(data_services.foreign_prod + 'thor_data400::Base::CNLDPractitionerFCRAHeader_Building',CNLD_Practitioner.layouts.keybuild,flat)(did != 0)
					   ,pCNLDPractitioner
					  );

	src_rec := header.layouts_SeqdSrc.PT_src_rec;
	
	header.Mac_Set_Header_Source(dSourceData,CNLD_Practitioner.layouts.keybuild,src_rec,MDR.sourceTools.src_CNLD_Practitioner,withUID)

	return withUID;
  end
 ;

