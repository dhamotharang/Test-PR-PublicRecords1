import strata, ut;
//////////////////////////////////////////////////////////////
//	-- Exported version of Strata.createAsBusinessHeaderStats
//	-- also exported contacts stats
//////////////////////////////////////////////////////////////

export createAsBusinessStats :=
module

	export Header(

		 pDataset
		,pBuildName
		,pBuildSubSet 
		,pVersionName
		,pEmailNotifyList
		,pOutput
	
	)	:= 
	macro

		#uniquename(Layout_pDataset_stat)    
		#uniquename(pDataset_stat				)    
		#uniquename(xmlstatsreturn			)    


		%Layout_pDataset_stat% :=
			record
					unsigned8 CountGroup                              := count(group);
					pDataset.source;
					pDataset.state;
					unsigned8 rcid_CountNonZero                       := sum(group, if(pDataset.rcid                           <> 0   ,1,0));
					unsigned8 bdid_CountNonZero                       := sum(group, if(pDataset.bdid                           <> 0   ,1,0));
					unsigned8 source_group_CountNonBlank              := sum(group, if(pDataset.source_group                   <> ''  ,1,0));
					unsigned8 pflag_CountNonBlank                     := sum(group, if(pDataset.pflag                          <> ''  ,1,0));
					unsigned8 group1_id_CountNonZero                  := sum(group, if(pDataset.group1_id                      <> 0   ,1,0));
					unsigned8 vendor_id_CountNonBlank                 := sum(group, if(pDataset.vendor_id                      <> ''  ,1,0));
					unsigned8 dt_first_seen_CountNonZero              := sum(group, if(pDataset.dt_first_seen                  <> 0   ,1,0));
					unsigned8 dt_last_seen_CountNonZero               := sum(group, if(pDataset.dt_last_seen                   <> 0   ,1,0));
					unsigned8 dt_vendor_first_reported_CountNonZero   := sum(group, if(pDataset.dt_vendor_first_reported       <> 0   ,1,0));
					unsigned8 dt_vendor_last_reported_CountNonZero    := sum(group, if(pDataset.dt_vendor_last_reported        <> 0   ,1,0));
					unsigned8 company_name_CountNonBlank              := sum(group, if(pDataset.company_name                   <> ''  ,1,0));
					unsigned8 prim_range_CountNonBlank                := sum(group, if(pDataset.prim_range                     <> ''  ,1,0));
					unsigned8 predir_CountNonBlank                    := sum(group, if(pDataset.predir                         <> ''  ,1,0));
					unsigned8 prim_name_CountNonBlank                 := sum(group, if(pDataset.prim_name                      <> ''  ,1,0));
					unsigned8 addr_suffix_CountNonBlank               := sum(group, if(pDataset.addr_suffix                    <> ''  ,1,0));
					unsigned8 postdir_CountNonBlank                   := sum(group, if(pDataset.postdir                        <> ''  ,1,0));
					unsigned8 unit_desig_CountNonBlank                := sum(group, if(pDataset.unit_desig                     <> ''  ,1,0));
					unsigned8 sec_range_CountNonBlank                 := sum(group, if(pDataset.sec_range                      <> ''  ,1,0));
					unsigned8 city_CountNonBlank                      := sum(group, if(pDataset.city                           <> ''  ,1,0));
					unsigned8 zip_CountNonZero                        := sum(group, if(pDataset.zip                            <> 0   ,1,0));
					unsigned8 zip4_CountNonZero                       := sum(group, if(pDataset.zip4                           <> 0   ,1,0));
					unsigned8 county_CountNonBlank                    := sum(group, if(pDataset.county                         <> ''  ,1,0));
					unsigned8 msa_CountNonBlank                       := sum(group, if(pDataset.msa                            <> ''  ,1,0));
					unsigned8 geo_lat_CountNonBlank                   := sum(group, if(pDataset.geo_lat                        <> ''  ,1,0));
					unsigned8 geo_long_CountNonBlank                  := sum(group, if(pDataset.geo_long                       <> ''  ,1,0));
					unsigned8 phone_CountNonZero                      := sum(group, if(pDataset.phone                          <> 0   ,1,0));
					unsigned8 phone_score_CountNonZero                := sum(group, if(pDataset.phone_score                    <> 0   ,1,0));
					unsigned8 fein_CountNonZero                       := sum(group, if(pDataset.fein                           <> 0   ,1,0));
					unsigned8 current_CountTrue                       := sum(group, if(pDataset.current                        = true ,1,0));
					unsigned8 dppa_CountTrue                          := sum(group, if(pDataset.dppa                           = true ,1,0));
			end;
			
			

		#uniquename(tstats)    
		%pDataset_stat% := table(pDataset, %Layout_pDataset_stat%, source, state, few);

		strata.createXMLStats(%pDataset_stat%, pBuildName, pBuildSubSet, pVersionName, pEmailNotifyList, %xmlstatsreturn%, 'AsBusinessHeader', 'Population');  

		export pOutput := %xmlstatsreturn%;
		 
	endmacro;

	export Contacts(
		 pDataset
		,pBuildName 
		,pBuildSubSet 
		,pVersionName 
		,pEmailNotifyList
		,pOutput
	) :=
	macro

		#uniquename(Layout_pDataset_stat)    
		#uniquename(pDataset_stat				)    
		#uniquename(xmlstatsreturn			)    

		%Layout_pDataset_stat% :=
		record
			unsigned8 CountGroup                            := count(group);
			pDataset.source;
			pDataset.state;
			pDataset.record_type;
			pDataset.from_hdr;
			unsigned8 bdid_CountNonZero                     := sum(group, if(pDataset.bdid                       <> 0   ,1,0));
			unsigned8 did_CountNonZero                      := sum(group, if(pDataset.did                        <> 0   ,1,0));
			unsigned8 contact_score_CountNonZero            := sum(group, if(pDataset.contact_score              <> 0   ,1,0));
			unsigned8 vendor_id_CountNonBlank               := sum(group, if(pDataset.vendor_id                  <> ''  ,1,0));
			unsigned8 dt_first_seen_CountNonZero            := sum(group, if(pDataset.dt_first_seen              <> 0   ,1,0));
			unsigned8 dt_last_seen_CountNonZero             := sum(group, if(pDataset.dt_last_seen               <> 0   ,1,0));
			unsigned8 glb_CountTrue                         := sum(group, if(pDataset.glb                        =  true,1,0));
			unsigned8 dppa_CountTrue                        := sum(group, if(pDataset.dppa                       =  true,1,0));
			unsigned8 company_title_CountNonBlank           := sum(group, if(pDataset.company_title              <> ''  ,1,0));
			unsigned8 company_department_CountNonBlank      := sum(group, if(pDataset.company_department         <> ''  ,1,0));
			unsigned8 title_CountNonBlank                   := sum(group, if(pDataset.title                      <> ''  ,1,0));
			unsigned8 fname_CountNonBlank                   := sum(group, if(pDataset.fname                      <> ''  ,1,0));
			unsigned8 mname_CountNonBlank                   := sum(group, if(pDataset.mname                      <> ''  ,1,0));
			unsigned8 lname_CountNonBlank                   := sum(group, if(pDataset.lname                      <> ''  ,1,0));
			unsigned8 name_suffix_CountNonBlank             := sum(group, if(pDataset.name_suffix                <> ''  ,1,0));
			unsigned8 name_score_CountNonBlank              := sum(group, if(pDataset.name_score                 <> ''  ,1,0));
			unsigned8 prim_range_CountNonBlank              := sum(group, if(pDataset.prim_range                 <> ''  ,1,0));
			unsigned8 predir_CountNonBlank                  := sum(group, if(pDataset.predir                     <> ''  ,1,0));
			unsigned8 prim_name_CountNonBlank               := sum(group, if(pDataset.prim_name                  <> ''  ,1,0));
			unsigned8 addr_suffix_CountNonBlank             := sum(group, if(pDataset.addr_suffix                <> ''  ,1,0));
			unsigned8 postdir_CountNonBlank                 := sum(group, if(pDataset.postdir                    <> ''  ,1,0));
			unsigned8 unit_desig_CountNonBlank              := sum(group, if(pDataset.unit_desig                 <> ''  ,1,0));
			unsigned8 sec_range_CountNonBlank               := sum(group, if(pDataset.sec_range                  <> ''  ,1,0));
			unsigned8 city_CountNonBlank                    := sum(group, if(pDataset.city                       <> ''  ,1,0));
			unsigned8 zip_CountNonZero                      := sum(group, if(pDataset.zip                        <> 0   ,1,0));
			unsigned8 zip4_CountNonZero                     := sum(group, if(pDataset.zip4                       <> 0   ,1,0));
			unsigned8 county_CountNonBlank                  := sum(group, if(pDataset.county                     <> ''  ,1,0));
			unsigned8 msa_CountNonBlank                     := sum(group, if(pDataset.msa                        <> ''  ,1,0));
			unsigned8 geo_lat_CountNonBlank                 := sum(group, if(pDataset.geo_lat                    <> ''  ,1,0));
			unsigned8 geo_long_CountNonBlank                := sum(group, if(pDataset.geo_long                   <> ''  ,1,0));
			unsigned8 phone_CountNonZero                    := sum(group, if(pDataset.phone                      <> 0   ,1,0));
			unsigned8 email_address_CountNonBlank           := sum(group, if(pDataset.email_address              <> ''  ,1,0));
			unsigned8 ssn_CountNonZero                      := sum(group, if(pDataset.ssn                        <> 0   ,1,0));
			unsigned8 company_source_group_CountNonBlank    := sum(group, if(pDataset.company_source_group       <> ''  ,1,0));
			unsigned8 company_name_CountNonBlank            := sum(group, if(pDataset.company_name               <> ''  ,1,0));
			unsigned8 company_prim_range_CountNonBlank      := sum(group, if(pDataset.company_prim_range         <> ''  ,1,0));
			unsigned8 company_predir_CountNonBlank          := sum(group, if(pDataset.company_predir             <> ''  ,1,0));
			unsigned8 company_prim_name_CountNonBlank       := sum(group, if(pDataset.company_prim_name          <> ''  ,1,0));
			unsigned8 company_addr_suffix_CountNonBlank     := sum(group, if(pDataset.company_addr_suffix        <> ''  ,1,0));
			unsigned8 company_postdir_CountNonBlank         := sum(group, if(pDataset.company_postdir            <> ''  ,1,0));
			unsigned8 company_unit_desig_CountNonBlank      := sum(group, if(pDataset.company_unit_desig         <> ''  ,1,0));
			unsigned8 company_sec_range_CountNonBlank       := sum(group, if(pDataset.company_sec_range          <> ''  ,1,0));
			unsigned8 company_city_CountNonBlank            := sum(group, if(pDataset.company_city               <> ''  ,1,0));
			unsigned8 company_state_CountNonBlank           := sum(group, if(pDataset.company_state              <> ''  ,1,0));
			unsigned8 company_zip_CountNonZero              := sum(group, if(pDataset.company_zip                <> 0   ,1,0));
			unsigned8 company_zip4_CountNonZero             := sum(group, if(pDataset.company_zip4               <> 0   ,1,0));
			unsigned8 company_phone_CountNonZero            := sum(group, if(pDataset.company_phone              <> 0   ,1,0));
			unsigned8 company_fein_CountNonZero             := sum(group, if(pDataset.company_fein               <> 0   ,1,0));
		end;

		%pDataset_stat% := table(pDataset, %Layout_pDataset_stat%, source, state, record_type, from_hdr, few);

		strata.createXMLStats(%pDataset_stat%, pBuildName, pBuildSubSet, pVersionName, pEmailNotifyList, %xmlstatsreturn%, 'AsBusinessContact', 'Population');
		
		export pOutput := %xmlstatsreturn%;

	endmacro;

end;