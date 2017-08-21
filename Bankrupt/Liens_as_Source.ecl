import header;

export Liens_as_Source(dataset(bankrupt.Layout_Liens) pLiens = dataset([],bankrupt.Layout_Liens), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::base::LiensHeader_Building',bankrupt.Layout_Liens,flat)((integer)did <= 999999001000),
					   pLiens((integer)did <= 999999001000)
					  );

	src_rec := header.layouts_SeqdSrc.LI_src_rec;

	header.Mac_Set_Header_Source(dSourceData(~(indivbusun='B' or aka_yn = 'B')),bankrupt.Layout_Liens,src_rec,'LI',withUID)

	return withUID;
  end
 ;
