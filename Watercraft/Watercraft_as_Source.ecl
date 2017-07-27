import header;

export Watercraft_as_Source(dataset(Watercraft.Layout_Watercraft_Search_Base) pWatercraftSearch = dataset([],Watercraft.Layout_Watercraft_Search_Base),
							dataset(Watercraft.Layout_Watercraft_Main_Base) pWatercraftMain = dataset([],Watercraft.Layout_Watercraft_Main_Base),
							dataset(Watercraft.Layout_Watercraft_CoastGuard_Base) pWatercraftCG = dataset([],Watercraft.Layout_Watercraft_CoastGuard_Base),
							boolean pForHeaderBuild=false
						   )
 :=
  function
	dSourceDataSearch	:=	if(pForHeaderBuild,
							   dataset('~thor_data400::Base::WatercraftSrchHeader_Building',Watercraft.Layout_Watercraft_Search_Base,flat)(lname<>'' and fname<>'' and prim_name<>''),
							   pWatercraftSearch(lname<>'' and fname<>'' and prim_name<>'')
							  );
	dSourceDataMain		:=	if(pForHeaderBuild,
							   dataset('~thor_data400::Base::WatercraftMainHeader_Building',Watercraft.Layout_Watercraft_Main_Base,flat),
							   pWatercraftMain
							  );

	dSourceDataCG		:=	if(pForHeaderBuild,
							   dataset('~thor_data400::Base::WatercraftCGHeader_Building',Watercraft.Layout_Watercraft_CoastGuard_Base,flat),
							   pWatercraftCG
							  );
							  
	dis_srch := distribute(dSourceDataSearch,hash(state_origin,watercraft_key,sequence_key,source_code));
	dis_main := distribute(dSourceDataMain,  hash(state_origin,watercraft_key,sequence_key,source_code));
	dis_cg   := distribute(dSourceDataCG,    hash(state_origin,watercraft_key,sequence_key,source_code));

	src_rec := record
	 header.layout_Source_ID;
	 watercraft.layout_watercraft_source;
	end;
	
    src_rec getall(dis_srch L, dis_main R) := transform
     self := r;
     self := l;
     self := [];
    end;

    j1 := join(dis_srch,dis_main,
				    left.state_origin = right.state_origin 
				and	left.watercraft_key = right.watercraft_key
				and	left.sequence_key = right.sequence_key
				and left.source_code = right.source_code,
				getall(left,right),local);

    watercraft.Layout_Watercraft_Full getall1(j1 L, dis_cg R) := transform
     self.watercraft_key := l.watercraft_key;
     self.sequence_key := l.sequence_key;
     self.state_origin := l.state_origin;
     self := l;
     self := r;
     self := [];
    end;

    j := join(j1,dis_cg,
				    left.state_origin = right.state_origin 
				and	left.watercraft_key = right.watercraft_key
				and	left.sequence_key = right.sequence_key
				and left.source_code = right.source_code,
				getall1(left,right),left outer,local);

	header.Mac_Set_Header_Source(j,watercraft.Layout_Watercraft_Full,watercraft.Layout_Watercraft_Full,watercraft.Header_Source_Code(l.source_code,l.State_Origin),withID)

	dForHeader	:=	withID	: persist('persist::headerbuild_watercraft_src');
	dForOther	:=	withID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
