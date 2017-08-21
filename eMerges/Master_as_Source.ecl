import header,Data_Services;

export Master_as_Source(dataset(emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout) peMerges = dataset([],emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData   :=  if(pForHeaderBuild,
					   dataset(Data_Services.Data_location.prefix('eMerges')+'thor_data400::base::emergesHeader_Building',emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout,flat),
					   peMerges
					  );

	src_rec := header.layouts_SeqdSrc.EM_src_rec;

// emerges.header_source_code (see eMerges.make_hvc_output for insight)
	header.Mac_Set_Header_Source(dSourceData(trim(file_id)='HUNT' and (StringLib.StringToUpperCase(hunt)='Y' or StringLib.StringToUpperCase(combosuper)='Y')),emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout,src_rec,'E1',withUID1);

	d:=	dSourceData(trim(file_id)='HUNT' and (StringLib.StringToUpperCase(fish)='Y' or StringLib.StringToUpperCase(combosuper)='Y'))
		+ dSourceData(trim(file_id)='FISH');
	header.Mac_Set_Header_Source(d,emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout,src_rec,'E2',withUID2);

	header.Mac_Set_Header_Source(dSourceData(trim(file_id)='HUNT',hunt='',fish='',combosuper=''),emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout,src_rec,'EM',withUID7);
	header.Mac_Set_Header_Source(dSourceData(trim(file_id)='CCW' and source_code <> 'E7'),emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout,src_rec,'E3',withUID3);
	header.Mac_Set_Header_Source(dSourceData(trim(file_id)='CCW' and source_code = 'E7'),emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout,src_rec,'E7',withUID8);
		header.Mac_Set_Header_Source(dSourceData(trim(file_id)='CENS'),emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout,src_rec,'E4',withUID4);
	header.Mac_Set_Header_Source(dSourceData(trim(file_id) not in ['HUNT','FISH','CCW','CENS'])
																,emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout,src_rec,'',withUID5
															);
    withuid:=withuid1+withuid2+withuid3+withuid4+withuid5+withuid7+withuid8;
	// 'HUNT' => 'E1',
	// 'FISH' => 'E2',
	// 'CCW'  => 'E3',
	// 'CENS' => 'E4',
	//this should drop voters
	drop_no_src := withuid(src<>'');

	return drop_no_src;
  end
 ;