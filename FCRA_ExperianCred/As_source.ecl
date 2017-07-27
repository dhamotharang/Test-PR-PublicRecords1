import ut,header,FCRA_ExperianCred;

export as_source(dataset(Layouts.base) pFile = dataset([],Layouts.base), boolean pForHeaderBuild=false,boolean pFastHeader= false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild
										,dataset('~thor_data400::base::FCRA::ExperianCredheader_building',Layouts.base,flat)
										,pFile 
										)(~IsDelete)
										;
	
	src_rec := record
	 header.Layout_Source_ID;
	 Layouts.base - src;
	end;

	header.Mac_Set_Header_Source(dSourceData,Layouts.base,src_rec,'EN',with_id);

	dForHeader  := FCRA_ExperianCred.fn_Not_Primary_EN(with_id)	: persist('~thor_data400::persist::headerbuild_FCRA_ExperianCred_src');
	dForOther   := with_id;
	ReturnValue	:= if(pForHeaderBuild
									,dForHeader
									,dForOther
									);
	return ReturnValue;
  end
 ;