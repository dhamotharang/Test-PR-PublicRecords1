import header,ut;

export DeaV2_as_Source(
											dataset(DeaV2_Services.assorted_Layouts.Layout_Output) pDEA 
											= dataset([],DeaV2_Services.assorted_Layouts.Layout_Output)
											, boolean pForHeaderBuild=false
											):= function
											
	dSourceData	:=	if(pForHeaderBuild,
					   dataset(ut.foreign_prod+'thor_data400::Base::DeaHeader_Building',DEA.layout_DEA_Out,flat),
					   pDEA
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 DEA.layout_DEA_Out;
	end;

  header.Mac_Set_Header_Source(dSourceData
															 ,DEA.layout_DEA_Out
															 ,src_rec
															 ,'DA'
															 ,withUID
															 )

	
	 
	dForHeader	:=	withUID	: persist('persist::headerbuild_DeaV2_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
