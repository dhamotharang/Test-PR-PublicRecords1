import header;

Layout_in := VotersV2.Layouts_Voters.Layout_Voters_Base_new - [raw_aid,ace_aid];

export Voters_As_Source(dataset(Layout_in) pVoters = dataset([],Layout_in), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::base::Voters_Header_Building',Layout_in,flat),
					   pVoters
					  );

	src_rec := header.layouts_SeqdSrc.VO_src_rec;

	header.Mac_Set_Header_Source(dSourceData,Layout_in,src_rec,'VO',withUID)

	return withUID;
  end
 ;
