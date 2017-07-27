import header;

Layout_in := VotersV2.Layouts_Voters.Layout_Voters_Base;

export Voters_As_Source(dataset(Layout_in) pVoters = dataset([],Layout_in), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::base::Voters_Header_Building',Layout_in,flat),
					   pVoters
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 Layout_in;
	end;

	header.Mac_Set_Header_Source(dSourceData,Layout_in,src_rec,'VO',withUID)

	dForHeader	:=	withUID	: persist('persist::headerbuild_voters_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
