import ut,header;

export Experian_as_source(dataset(ExperianCred.Layouts.Layout_Out) pExperian = dataset([],ExperianCred.Layouts.Layout_Out), boolean pForHeaderBuild=false, boolean pFastHeader = false)
 :=
  function
	dSourceData0_	:=	if(pForHeaderBuild
					   ,dataset('~thor_data400::Base::ExperianHeader_Building',ExperianCred.Layouts.Layout_Out,flat)
					   ,pExperian
						 )
						 ;
				  
	dSourceData0 := if (pFastHeader, dSourceData0_(ut.DaysApart(ut.GetDate, date_vendor_last_reported[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep) , dSourceData0_);

    ExperianCred.Layouts.Layout_Out_old  ref(dSourceData0 l) := transform 
	self.Orig_Address_date :=  l.Orig_Address_Create_Date ;  
	self:= l; 
	end; 
	
	dSourceData :=  project(dSourceData0 , ref(left)); 
	
	src_rec := record
	 header.Layout_Source_ID;
	 ExperianCred.Layouts.Layout_Out_old;
	end;

	seed:=if(pFastHeader,999999999999,1);
	header.Mac_Set_Header_Source(dSourceData(nametype[1..2]!='SP'),ExperianCred.Layouts.Layout_Out_old,src_rec,'EN',with_id,seed)

	dForHeader	:=	fn_Not_Primary_EN(with_id)	: persist('persist::headerbuild_Experian_src');
	dForOther	:=	with_id;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
 