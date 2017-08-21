import ut;

export State_Death_as_Source(dataset(header.layout_state_death) pState_Death_Master = dataset([],header.layout_state_death), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   header.file_state_death,				// no header_building superfile here?
					   pState_Death_Master
					  );

	src_rec := header.layouts_SeqdSrc.DS_src_rec;

	src_rec clean(dSourceData le) := transform
	  self := le;
	  self := [];
	end;

	no_id := project(dSourceData, clean(left));

	header.Mac_Set_Header_Source(no_id, src_rec, src_rec, 'DS', with_id)

	return with_id;
  end
 ;
