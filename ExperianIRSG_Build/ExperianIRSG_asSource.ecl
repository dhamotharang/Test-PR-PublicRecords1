import ut,header,ExperianIRSG_Build;

export ExperianIRSG_asSource(dataset(ExperianIRSG_Build.Layouts.Layout_Out) pExperian = dataset([],ExperianIRSG_Build.Layouts.Layout_Out), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::base::exprnphheader_building',ExperianIRSG_Build.Layouts.Layout_Out,flat),
					   pExperian 
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 ExperianIRSG_Build.Layouts.Layout_Out;
	end;

	header.Mac_Set_Header_Source(dSourceData(nametype[1..2]='C1' and phone_type = 'P1'),ExperianIRSG_Build.Layouts.Layout_Out,src_rec,'EL',with_id)

	dForHeader	:=	with_id	: persist('~thor_data400::persist::headerbuild_ExperianIRSG_src');
	dForOther	:=	with_id;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end;