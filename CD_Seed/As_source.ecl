import header;

export as_source(dataset(layouts.base) pCDS = dataset([],layouts.base), boolean pForHeaderBuild=false, boolean pFastHeader= false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild
					   ,dataset('~thor_data::base::cd_seed_building', layouts.base, flat)
					   ,pCDS
					  );

	src_rec := {header.Layout_Source_ID,layouts.base};
	 
	header.Mac_Set_Header_Source(dSourceData,layouts.base,src_rec,'2R',withUID);

	return withUID;
    
 end;