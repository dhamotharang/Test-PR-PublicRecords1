import header;

export NPPES_as_source(dataset(NPPES.layouts.KeyBuild) pNPPES = dataset([],NPPES.layouts.KeyBuild), boolean pForHeaderBuild=false)       
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::NppesHeader_Building',NPPES.layouts.KeyBuild,flat),
					   pNPPES
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 NPPES.layouts.KeyBuild;
	end;
	 
	header.Mac_Set_Header_Source(dSourceData,NPPES.layouts.KeyBuild,src_rec,'NP',withUID)

	dForHeader	:=	withUID	: persist('persist::headerbuild_nppes_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;