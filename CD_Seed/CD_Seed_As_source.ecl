import header, $;
r := $.layouts;

export CD_Seed_as_source(dataset(r.base) pCDS = dataset([],r.base), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild
					   ,dataset('~thor_data::base::cd_seed_building', r.base, flat)
					   ,pCDS
					  );

	src_rec := {header.Layout_Source_ID,r.base};
	 
	header.Mac_Set_Header_Source(dSourceData,layouts.base,src_rec,'2R',withUID);

	return withUID;
    
 end;