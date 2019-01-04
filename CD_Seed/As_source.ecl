as_source(dataset(base) pCDS = dataset([],base), boolean pForHeaderBuild=false, boolean pFastHeader= false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild
					   ,dataset('~thor_data::base::cd_seed_'+pVersion,base,flat)
					   ,pCDS
					  );

	src_rec := {header.Layout_Source_ID,base};
	 
	header.Mac_Set_Header_Source(dSourceData,base,src_rec,'2R',withUID)

	return withUID;;
  end;