import header,ut;

export ATF_as_Source(dataset(layout_firearms_explosives_out_BIP) pATF = dataset([],atf.layout_firearms_explosives_out_BIP), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::atfHeader_Building',atf.layout_firearms_explosives_out_BIP,flat),
					   pATF
					  );

	src_rec := header.layouts_SeqdSrc.ATF_src_rec;

	header.Mac_Set_Header_Source(dSourceData(record_type='F'),atf.layout_firearms_explosives_out_BIP,src_rec,'FF',withUID1)
	header.Mac_Set_Header_Source(dSourceData(record_type!='F'),atf.layout_firearms_explosives_out_BIP,src_rec,'FE',withUID2)

	return withUID1 + withUID2;
  end
 ;
