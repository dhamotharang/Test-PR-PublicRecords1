import header,infutorCID,MDR,data_services;

export InfutorCID_as_Source(dataset(infutorCID.Layout_InfutorCID_Base) pInfutorCID = dataset([],infutorCID.Layout_InfutorCID_Base), boolean pForFCRAHeaderBuild=false)
 :=
  function

dSourceData	:=	if(pForFCRAHeaderBuild
					   ,dataset(data_services.foreign_prod + 'thor_data400::Base::InfutorCIDFCRAHeader_Building',infutorCID.Layout_InfutorCID_Base,flat)(did != 0)
					   ,pInfutorCID
					  );
						
FixDates := project(dSourceData, transform(infutorCID.Layout_InfutorCID_Base,
									self.dt_first_seen := min(left.dt_first_seen, left.dt_last_seen),
									self.dt_last_seen := max(left.dt_first_seen, left.dt_last_seen),
									self := left));

	src_rec := header.layouts_SeqdSrc.IR_src_rec;
	
	header.Mac_Set_Header_Source(FixDates,infutorCID.Layout_InfutorCID_Base,src_rec,MDR.sourceTools.src_InfutorCID,withUID)

	return withUID;
  end
 ;

