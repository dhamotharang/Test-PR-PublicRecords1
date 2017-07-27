import ut,header;

export as_source(dataset(Layouts.base) pFile = dataset([],Layouts.base), boolean pForHeaderBuild=false,boolean pFastHeader= false)
 :=
  function
	dSourceData_	:=	if(pForHeaderBuild
										,dataset('~thor_data400::base::transunioncredheader_building',Layouts.base,flat)
										,pFile 
										)
										;
	
	dSourceData := if (pFastHeader, dSourceData_(ut.DaysApart(ut.GetDate, dt_vendor_last_reported[..6] + '01') <= 60) , dSourceData_);

	src_rec := record
	 header.Layout_Source_ID;
	 Layouts.base;
	end;

	seed:=if(pFastHeader,999999999999,1);
	header.Mac_Set_Header_Source(dSourceData,Layouts.base,src_rec,'TN',with_id,seed)

	dForHeader  := fn_Not_Primary_TN(with_id)	: persist('~thor_data400::persist::headerbuild_TransunionCred_src');
	dForOther   := with_id;
	ReturnValue	:= if(pForHeaderBuild
									,dForHeader
									,dForOther
									);
	return ReturnValue;
  end
 ;