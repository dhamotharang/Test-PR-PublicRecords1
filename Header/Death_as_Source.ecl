import ut;

export Death_as_Source(dataset(header.Layout_Did_Death_MasterV2) pDeath_Master = dataset([],header.Layout_Did_Death_MasterV2), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::DeathHeader_Building',header.Layout_Did_Death_MasterV2,flat),
					   pDeath_Master
					  )(state_death_id[1]<>'T');
	src_rec := record
	 
	 Layout_Source_ID;
	 header.Layout_Did_Death_MasterV2 - [state_death_flag,death_rec_src];
	end;

    //crlf='SA' flags Direct records where the SSN was overlaid w/ one from the SSA
	header.Mac_Set_Header_Source(dSourceData(crlf<>'SA'),header.Layout_Did_Death_MasterV2,src_rec,'DE',with_id)

	dForHeader	:=	with_id	: persist('persist::headerbuild_death_src');
	dForOther	:=	with_id;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;