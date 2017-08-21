import header,ut;

export DLs_as_Source(dataset(drivers.layout_dl) pDLs = dataset([],drivers.layout_dl), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::BASE::DLHeader_Building',drivers.layout_dl,flat,unsorted),
					   pDLs
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 drivers.layout_dl;
	end;

	header.Mac_Set_Header_Source(dSourceData(did<999999000000),drivers.layout_dl,src_rec,header_src(l.source_code,l.orig_state),withUID)

	dForHeader	:=	withUID	: persist('persist::headerbuild_dl_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
