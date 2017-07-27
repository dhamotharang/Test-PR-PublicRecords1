import ut,header;

export Transunion_as_source(dataset(Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut) pTransunion = dataset([],Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::TucsHeader_Building',Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut,flat),
					   pTransunion 
					  );

	src_rec := record
	 header.Layout_Source_ID;
	 Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut;
	end;

	header.Mac_Set_Header_Source(dSourceData,Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut,src_rec,'TS',with_id)

	dForHeader	:=	with_id	: persist('persist::headerbuild_Tucs_src');
	dForOther	:=	with_id;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;