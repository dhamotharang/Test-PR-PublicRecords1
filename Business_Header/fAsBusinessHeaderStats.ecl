import strata, ut;

export fAsBusinessHeaderStats(
	 dataset(Layout_Business_Header_new)	pInput
	,string																pBuildName
	,string																pVersion
	,string																pBuildSubset			= ''
	,string																pBuildView				= ''
	,string																pBuildType				= 'as_business_header'
	,string																pEmailNotifyList	= ''
	,boolean															pTranslateSource	= true
) :=
function

	Layout_pInput_stat :=
	record
			unsigned8 CountGroup                              := count(group);
			pInput.source;
			pInput.state;
			unsigned8 rcid_CountNonZero                       := sum(group, if(pInput.rcid                           <> 0   ,1,0));
			unsigned8 bdid_CountNonZero                       := sum(group, if(pInput.bdid                           <> 0   ,1,0));
			unsigned8 source_group_CountNonBlank              := sum(group, if(pInput.source_group                   <> ''  ,1,0));
			unsigned8 pflag_CountNonBlank                     := sum(group, if(pInput.pflag                          <> ''  ,1,0));
			unsigned8 group1_id_CountNonZero                  := sum(group, if(pInput.group1_id                      <> 0   ,1,0));
			unsigned8 vendor_id_CountNonBlank                 := sum(group, if(pInput.vendor_id                      <> ''  ,1,0));
			unsigned8 dt_first_seen_CountNonZero              := sum(group, if(pInput.dt_first_seen                  <> 0   ,1,0));
			unsigned8 dt_last_seen_CountNonZero               := sum(group, if(pInput.dt_last_seen                   <> 0   ,1,0));
			unsigned8 dt_vendor_first_reported_CountNonZero   := sum(group, if(pInput.dt_vendor_first_reported       <> 0   ,1,0));
			unsigned8 dt_vendor_last_reported_CountNonZero    := sum(group, if(pInput.dt_vendor_last_reported        <> 0   ,1,0));
			unsigned8 company_name_CountNonBlank              := sum(group, if(pInput.company_name                   <> ''  ,1,0));
			unsigned8 prim_range_CountNonBlank                := sum(group, if(pInput.prim_range                     <> ''  ,1,0));
			unsigned8 predir_CountNonBlank                    := sum(group, if(pInput.predir                         <> ''  ,1,0));
			unsigned8 prim_name_CountNonBlank                 := sum(group, if(pInput.prim_name                      <> ''  ,1,0));
			unsigned8 addr_suffix_CountNonBlank               := sum(group, if(pInput.addr_suffix                    <> ''  ,1,0));
			unsigned8 postdir_CountNonBlank                   := sum(group, if(pInput.postdir                        <> ''  ,1,0));
			unsigned8 unit_desig_CountNonBlank                := sum(group, if(pInput.unit_desig                     <> ''  ,1,0));
			unsigned8 sec_range_CountNonBlank                 := sum(group, if(pInput.sec_range                      <> ''  ,1,0));
			unsigned8 city_CountNonBlank                      := sum(group, if(pInput.city                           <> ''  ,1,0));
			unsigned8 zip_CountNonZero                        := sum(group, if(pInput.zip                            <> 0   ,1,0));
			unsigned8 zip4_CountNonZero                       := sum(group, if(pInput.zip4                           <> 0   ,1,0));
			unsigned8 county_CountNonBlank                    := sum(group, if(pInput.county                         <> ''  ,1,0));
			unsigned8 msa_CountNonBlank                       := sum(group, if(pInput.msa                            <> ''  ,1,0));
			unsigned8 geo_lat_CountNonBlank                   := sum(group, if(pInput.geo_lat                        <> ''  ,1,0));
			unsigned8 geo_long_CountNonBlank                  := sum(group, if(pInput.geo_long                       <> ''  ,1,0));
			unsigned8 phone_CountNonZero                      := sum(group, if(pInput.phone                          <> 0   ,1,0));
			unsigned8 phone_score_CountNonZero                := sum(group, if(pInput.phone_score                    <> 0   ,1,0));
			unsigned8 fein_CountNonZero                       := sum(group, if(pInput.fein                           <> 0   ,1,0));
			unsigned8 current_CountTrue                       := sum(group, if(pInput.current                        = true ,1,0));
			unsigned8 dppa_CountTrue                          := sum(group, if(pInput.dppa                           = true ,1,0));
	end;
	
	pInput_stat := table(pInput, Layout_pInput_stat, source, state, few);

	Source_Description := map(pTranslateSource		= false								=> pBuildName,
							  TranslateSource(pBuildName)	= 'Not A Business Header Source'	=> pBuildName,
							  TranslateSource(pBuildName));


	strata.createXMLStats(pInput_stat, Source_Description, pBuildSubset, pVersion, pEmailNotifyList, resultsOut, pBuildView, pBuildType);

	return resultsOut;
end;