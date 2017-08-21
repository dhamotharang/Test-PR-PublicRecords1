import header, strata;

export createAsBusinessHeaderStats(ds, 
                                   pBuildName, 
								   pBuildSubSet, 
								   pVersionName, 
								   pEmailNotifyList, 
								   rOut
                                  ) := macro

#uniquename(businessHeaderLayout)    


%businessHeaderLayout% :=
	record
			unsigned8 CountGroup                              := count(group);
			ds.source;
			ds.state;
			unsigned8 rcid_CountNonZero                       := sum(group, if(ds.rcid                           <> 0   ,1,0));
			unsigned8 bdid_CountNonZero                       := sum(group, if(ds.bdid                           <> 0   ,1,0));
			unsigned8 source_group_CountNonBlank              := sum(group, if(ds.source_group                   <> ''  ,1,0));
			unsigned8 pflag_CountNonBlank                     := sum(group, if(ds.pflag                          <> ''  ,1,0));
			unsigned8 group1_id_CountNonZero                  := sum(group, if(ds.group1_id                      <> 0   ,1,0));
			unsigned8 vendor_id_CountNonBlank                 := sum(group, if(ds.vendor_id                      <> ''  ,1,0));
			unsigned8 dt_first_seen_CountNonZero              := sum(group, if(ds.dt_first_seen                  <> 0   ,1,0));
			unsigned8 dt_last_seen_CountNonZero               := sum(group, if(ds.dt_last_seen                   <> 0   ,1,0));
			unsigned8 dt_vendor_first_reported_CountNonZero   := sum(group, if(ds.dt_vendor_first_reported       <> 0   ,1,0));
			unsigned8 dt_vendor_last_reported_CountNonZero    := sum(group, if(ds.dt_vendor_last_reported        <> 0   ,1,0));
			unsigned8 company_name_CountNonBlank              := sum(group, if(ds.company_name                   <> ''  ,1,0));
			unsigned8 prim_range_CountNonBlank                := sum(group, if(ds.prim_range                     <> ''  ,1,0));
			unsigned8 predir_CountNonBlank                    := sum(group, if(ds.predir                         <> ''  ,1,0));
			unsigned8 prim_name_CountNonBlank                 := sum(group, if(ds.prim_name                      <> ''  ,1,0));
			unsigned8 addr_suffix_CountNonBlank               := sum(group, if(ds.addr_suffix                    <> ''  ,1,0));
			unsigned8 postdir_CountNonBlank                   := sum(group, if(ds.postdir                        <> ''  ,1,0));
			unsigned8 unit_desig_CountNonBlank                := sum(group, if(ds.unit_desig                     <> ''  ,1,0));
			unsigned8 sec_range_CountNonBlank                 := sum(group, if(ds.sec_range                      <> ''  ,1,0));
			unsigned8 city_CountNonBlank                      := sum(group, if(ds.city                           <> ''  ,1,0));
			unsigned8 zip_CountNonZero                        := sum(group, if(ds.zip                            <> 0   ,1,0));
			unsigned8 zip4_CountNonZero                       := sum(group, if(ds.zip4                           <> 0   ,1,0));
			unsigned8 county_CountNonBlank                    := sum(group, if(ds.county                         <> ''  ,1,0));
			unsigned8 msa_CountNonBlank                       := sum(group, if(ds.msa                            <> ''  ,1,0));
			unsigned8 geo_lat_CountNonBlank                   := sum(group, if(ds.geo_lat                        <> ''  ,1,0));
			unsigned8 geo_long_CountNonBlank                  := sum(group, if(ds.geo_long                       <> ''  ,1,0));
			unsigned8 phone_CountNonZero                      := sum(group, if(ds.phone                          <> 0   ,1,0));
			unsigned8 phone_score_CountNonZero                := sum(group, if(ds.phone_score                    <> 0   ,1,0));
			unsigned8 fein_CountNonZero                       := sum(group, if(ds.fein                           <> 0   ,1,0));
			unsigned8 current_CountTrue                       := sum(group, if(ds.current                        = true ,1,0));
			unsigned8 dppa_CountTrue                          := sum(group, if(ds.dppa                           = true ,1,0));
	end;
	
	

#uniquename(tstats)    
%tStats% := table(ds, %businessHeaderLayout%, source, state, few);

strata.createXMLStats(%tStats%, pBuildName, pBuildSubSet, pVersionName, pEmailNotifyList, rOut, 'AsBusinessHeader', 'Population');  

	 
endmacro;