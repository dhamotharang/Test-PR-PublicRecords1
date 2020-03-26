import header,business_header,business_header_ss,ut,did_add;

export Foreclosure_as_Source(dataset(Property.Layout_Fares_Foreclosure_v2) pForeclosure = dataset([],Property.Layout_Fares_Foreclosure_v2), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	project(if(pForHeaderBuild,
					   dataset('~thor_data400::Base::ForeclosureHeader_Building',Property.Layout_Fares_Foreclosure_v2, flat),
					   pForeclosure
					  ),Property.Layout_Fares_Foreclosure);

	src_rec := header.layouts_SeqdSrc.FR_src_rec;

	//Core Logic Records - FR
	header.Mac_Set_Header_Source(dSourceData(trim(deed_category) in ['U','Q','F','T','G'] and source = 'FR'),Property.Layout_Fares_Foreclosure,src_rec,'FR',withUID1_fr);
    
    //BlackKnight Records - FR
	header.Mac_Set_Header_Source(dSourceData(trim(deed_category) in ['U','Q','F','T','G'] and source = 'I5'),Property.Layout_Fares_Foreclosure,src_rec,'I5',withUID2_fr);
    
    withUID := withUID1_fr + withUID2_fr;

	return withUID;
  end
 ;
