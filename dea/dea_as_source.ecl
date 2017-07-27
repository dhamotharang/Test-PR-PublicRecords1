import header;

export DEA_as_Source(dataset(DEA.layout_DEA_OUt) pDEA = dataset([],DEA.layout_DEA_Out), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::DeaHeader_Building',DEA.layout_DEA_Out,flat),
					   pDEA
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 DEA.layout_DEA_In;
	end;

	header.Mac_Set_Header_Source(dSourceData,DEA.layout_DEA_Out,src_rec,'DA',withUID)

	dForHeader	:=	withUID	: persist('persist::headerbuild_dea_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
