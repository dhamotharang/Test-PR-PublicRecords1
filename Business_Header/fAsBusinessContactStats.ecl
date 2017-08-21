import strata, ut;
export fAsBusinessContactStats(
	 dataset(Layout_Business_Contact_Full_new)	pInput
	,string																			pBuildName
	,string																			pVersion
	,string																			pBuildSubset			= ''
	,string																			pBuildView				= ''
	,string																			pBuildType				= 'as_business_contact'
	,string																			pEmailNotifyList	= ''
	,boolean																		pTranslateSource	= true
) :=
function

	Layout_pInput_stat :=
	record
		unsigned8 CountGroup                            := count(group);
		pInput.source;
		pInput.state;
		pInput.record_type;
		pInput.from_hdr;
		unsigned8 bdid_CountNonZero                     := sum(group, if(pInput.bdid                       <> 0   ,1,0));
		unsigned8 did_CountNonZero                      := sum(group, if(pInput.did                        <> 0   ,1,0));
		unsigned8 contact_score_CountNonZero            := sum(group, if(pInput.contact_score              <> 0   ,1,0));
		unsigned8 vendor_id_CountNonBlank               := sum(group, if(pInput.vendor_id                  <> ''  ,1,0));
		unsigned8 dt_first_seen_CountNonZero            := sum(group, if(pInput.dt_first_seen              <> 0   ,1,0));
		unsigned8 dt_last_seen_CountNonZero             := sum(group, if(pInput.dt_last_seen               <> 0   ,1,0));
		unsigned8 glb_CountTrue                         := sum(group, if(pInput.glb                        =  true,1,0));
		unsigned8 dppa_CountTrue                        := sum(group, if(pInput.dppa                       =  true,1,0));
		unsigned8 company_title_CountNonBlank           := sum(group, if(pInput.company_title              <> ''  ,1,0));
		unsigned8 company_department_CountNonBlank      := sum(group, if(pInput.company_department         <> ''  ,1,0));
		unsigned8 title_CountNonBlank                   := sum(group, if(pInput.title                      <> ''  ,1,0));
		unsigned8 fname_CountNonBlank                   := sum(group, if(pInput.fname                      <> ''  ,1,0));
		unsigned8 mname_CountNonBlank                   := sum(group, if(pInput.mname                      <> ''  ,1,0));
		unsigned8 lname_CountNonBlank                   := sum(group, if(pInput.lname                      <> ''  ,1,0));
		unsigned8 name_suffix_CountNonBlank             := sum(group, if(pInput.name_suffix                <> ''  ,1,0));
		unsigned8 name_score_CountNonBlank              := sum(group, if(pInput.name_score                 <> ''  ,1,0));
		unsigned8 prim_range_CountNonBlank              := sum(group, if(pInput.prim_range                 <> ''  ,1,0));
		unsigned8 predir_CountNonBlank                  := sum(group, if(pInput.predir                     <> ''  ,1,0));
		unsigned8 prim_name_CountNonBlank               := sum(group, if(pInput.prim_name                  <> ''  ,1,0));
		unsigned8 addr_suffix_CountNonBlank             := sum(group, if(pInput.addr_suffix                <> ''  ,1,0));
		unsigned8 postdir_CountNonBlank                 := sum(group, if(pInput.postdir                    <> ''  ,1,0));
		unsigned8 unit_desig_CountNonBlank              := sum(group, if(pInput.unit_desig                 <> ''  ,1,0));
		unsigned8 sec_range_CountNonBlank               := sum(group, if(pInput.sec_range                  <> ''  ,1,0));
		unsigned8 city_CountNonBlank                    := sum(group, if(pInput.city                       <> ''  ,1,0));
		unsigned8 zip_CountNonZero                      := sum(group, if(pInput.zip                        <> 0   ,1,0));
		unsigned8 zip4_CountNonZero                     := sum(group, if(pInput.zip4                       <> 0   ,1,0));
		unsigned8 county_CountNonBlank                  := sum(group, if(pInput.county                     <> ''  ,1,0));
		unsigned8 msa_CountNonBlank                     := sum(group, if(pInput.msa                        <> ''  ,1,0));
		unsigned8 geo_lat_CountNonBlank                 := sum(group, if(pInput.geo_lat                    <> ''  ,1,0));
		unsigned8 geo_long_CountNonBlank                := sum(group, if(pInput.geo_long                   <> ''  ,1,0));
		unsigned8 phone_CountNonZero                    := sum(group, if(pInput.phone                      <> 0   ,1,0));
		unsigned8 email_address_CountNonBlank           := sum(group, if(pInput.email_address              <> ''  ,1,0));
		unsigned8 ssn_CountNonZero                      := sum(group, if(pInput.ssn                        <> 0   ,1,0));
		unsigned8 company_source_group_CountNonBlank    := sum(group, if(pInput.company_source_group       <> ''  ,1,0));
		unsigned8 company_name_CountNonBlank            := sum(group, if(pInput.company_name               <> ''  ,1,0));
		unsigned8 company_prim_range_CountNonBlank      := sum(group, if(pInput.company_prim_range         <> ''  ,1,0));
		unsigned8 company_predir_CountNonBlank          := sum(group, if(pInput.company_predir             <> ''  ,1,0));
		unsigned8 company_prim_name_CountNonBlank       := sum(group, if(pInput.company_prim_name          <> ''  ,1,0));
		unsigned8 company_addr_suffix_CountNonBlank     := sum(group, if(pInput.company_addr_suffix        <> ''  ,1,0));
		unsigned8 company_postdir_CountNonBlank         := sum(group, if(pInput.company_postdir            <> ''  ,1,0));
		unsigned8 company_unit_desig_CountNonBlank      := sum(group, if(pInput.company_unit_desig         <> ''  ,1,0));
		unsigned8 company_sec_range_CountNonBlank       := sum(group, if(pInput.company_sec_range          <> ''  ,1,0));
		unsigned8 company_city_CountNonBlank            := sum(group, if(pInput.company_city               <> ''  ,1,0));
		unsigned8 company_state_CountNonBlank           := sum(group, if(pInput.company_state              <> ''  ,1,0));
		unsigned8 company_zip_CountNonZero              := sum(group, if(pInput.company_zip                <> 0   ,1,0));
		unsigned8 company_zip4_CountNonZero             := sum(group, if(pInput.company_zip4               <> 0   ,1,0));
		unsigned8 company_phone_CountNonZero            := sum(group, if(pInput.company_phone              <> 0   ,1,0));
		unsigned8 company_fein_CountNonZero             := sum(group, if(pInput.company_fein               <> 0   ,1,0));
	end;
	
	pInput_stat := table(pInput, Layout_pInput_stat, source, state, record_type, from_hdr, few);

	Source_Description := map(
								pTranslateSource						= false														=> pBuildName,
							  TranslateSource(pBuildName)	= 'Not A Business Header Source'	=> pBuildName,
							  TranslateSource(pBuildName));

	strata.createXMLStats(pInput_stat, Source_Description, pBuildSubset, pVersion, pEmailNotifyList, resultsOut, pBuildView, pBuildType);

	return resultsOut;
end;