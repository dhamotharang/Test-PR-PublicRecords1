import header,Data_Services;

export APF_As_Source(dataset(layout_apf_in) pAPF = dataset([],layout_apf_in),
					 dataset(layout_apf_pe_in) pAPFPE = dataset([],layout_apf_pe_in),
					 boolean pForHeaderBuild=false
					)
 :=
  function
	dSourceAPF		:=	if(pForHeaderBuild,
						   dataset(Data_Services.Data_location.prefix('AK_Perm_Fund')+'thor_data400::Base::AKHeader_Building',layout_apf_in,flat),
						   pAPF
						  );
	dSourceAPFPE	:=	if(pForHeaderBuild,
						   dataset(Data_Services.Data_location.prefix('AK_Perm_Fund')+'thor_data400::Base::AKPEHeader_Building',layout_apf_pe_in,flat),
						   pAPFPE
						  );

	src_rec := header.layouts_SeqdSrc.AK_src_rec;

	src_rec asSrcAPF(dSourceAPF L) := transform
	 self.src := 'AK';
	 self.uid := 0;
	 self := l;
	end;

	src_rec asSrcPE(dSourceAPFPE L) := transform
	 self.src := 'AK';
	 self.uid := 0;
	 self := l;
	end;

	apf_out := project(dSourceAPF,asSrcAPF(left));
	apf_pe_out := project(dSourceAPFPE,asSrcPE(left));

	all_recs := apf_out+apf_pe_out;

	header.Mac_Set_Header_Source(all_recs,src_rec,src_rec,'AK',withUID)

	return withUID;
  end;