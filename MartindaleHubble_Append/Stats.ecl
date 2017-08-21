import strata,_control;
export Stats(string pversion) :=
module

//Do stats on input files
//population stats
	export Sprayed :=
	module
		//////////////////////////////////////////////////////////////
		// -- AK Input Population Stats
		//////////////////////////////////////////////////////////////
		pInput_AK := files(pversion).input.AK.sprayed;
		Layout_pInput_AK_stat :=
		record
			unsigned8 CountGroup                                                                  := count(group);
			pInput_AK.state;
			unsigned8 indiv_id_CountNonBlank                                                      := sum(group, if(pInput_AK.indiv_id                                                          <> ''  ,1,0));
			unsigned8 listing_id_CountNonBlank                                                    := sum(group, if(pInput_AK.listing_id                                                        <> ''  ,1,0));
			unsigned8 version_id_CountNonBlank                                                    := sum(group, if(pInput_AK.version_id                                                        <> ''  ,1,0));
			unsigned8 last_name_CountNonBlank                                                     := sum(group, if(pInput_AK.last_name                                                         <> ''  ,1,0));
			unsigned8 first_name_CountNonBlank                                                    := sum(group, if(pInput_AK.first_name                                                        <> ''  ,1,0));
			unsigned8 suffix_CountNonBlank                                                        := sum(group, if(pInput_AK.suffix                                                            <> ''  ,1,0));
			unsigned8 year_born_CountNonBlank                                                     := sum(group, if(pInput_AK.year_born                                                         <> ''  ,1,0));
			unsigned8 year_admitted_CountNonBlank                                                 := sum(group, if(pInput_AK.year_admitted                                                     <> ''  ,1,0));
			unsigned8 building_CountNonBlank                                                      := sum(group, if(pInput_AK.building                                                          <> ''  ,1,0));
			unsigned8 street_CountNonBlank                                                        := sum(group, if(pInput_AK.street                                                            <> ''  ,1,0));
			unsigned8 po_box_CountNonBlank                                                        := sum(group, if(pInput_AK.po_box                                                            <> ''  ,1,0));
			unsigned8 city_CountNonBlank                                                          := sum(group, if(pInput_AK.city                                                              <> ''  ,1,0));
			unsigned8 zip_CountNonBlank                                                           := sum(group, if(pInput_AK.zip                                                               <> ''  ,1,0));
			unsigned8 born_text_CountNonBlank                                                     := sum(group, if(pInput_AK.born_text                                                         <> ''  ,1,0));
			unsigned8 lf_CountNonBlank                                                            := sum(group, if(pInput_AK.lf                                                                <> ''  ,1,0));
		end;
		pInput_AK_stat := table(pInput_AK, Layout_pInput_AK_stat, state  , few);
		strata.createXMLStats(pInput_AK_stat, 'MartinDale_Hubble_AK', 'input', pversion, _control.myinfo.emailaddressnotify, Input_stat_AK, 'View', 'Population');

		//////////////////////////////////////////////////////////////
		// -- AL Input Population Stats
		//////////////////////////////////////////////////////////////
		pInput_AL := files(pversion).input.AL.sprayed;
		Layout_pInput_AL_stat :=
		record
			unsigned8 CountGroup                                                                  := count(group);
			pInput_AL.state;
			unsigned8 indiv_id_CountNonBlank                                                      := sum(group, if(pInput_AL.indiv_id                                                          <> ''  ,1,0));
			unsigned8 listing_id_CountNonBlank                                                    := sum(group, if(pInput_AL.listing_id                                                        <> ''  ,1,0));
			unsigned8 version_id_CountNonBlank                                                    := sum(group, if(pInput_AL.version_id                                                        <> ''  ,1,0));
			unsigned8 last_name_CountNonBlank                                                     := sum(group, if(pInput_AL.last_name                                                         <> ''  ,1,0));
			unsigned8 first_name_CountNonBlank                                                    := sum(group, if(pInput_AL.first_name                                                        <> ''  ,1,0));
			unsigned8 suffix_CountNonBlank                                                        := sum(group, if(pInput_AL.suffix                                                            <> ''  ,1,0));
			unsigned8 year_born_CountNonBlank                                                     := sum(group, if(pInput_AL.year_born                                                         <> ''  ,1,0));
			unsigned8 year_admitted_CountNonBlank                                                 := sum(group, if(pInput_AL.year_admitted                                                     <> ''  ,1,0));
			unsigned8 building_CountNonBlank                                                      := sum(group, if(pInput_AL.building                                                          <> ''  ,1,0));
			unsigned8 street_CountNonBlank                                                        := sum(group, if(pInput_AL.street                                                            <> ''  ,1,0));
			unsigned8 po_box_CountNonBlank                                                        := sum(group, if(pInput_AL.po_box                                                            <> ''  ,1,0));
			unsigned8 city_CountNonBlank                                                          := sum(group, if(pInput_AL.city                                                              <> ''  ,1,0));
			unsigned8 zip_CountNonBlank                                                           := sum(group, if(pInput_AL.zip                                                               <> ''  ,1,0));
			unsigned8 born_text_CountNonBlank                                                     := sum(group, if(pInput_AL.born_text                                                         <> ''  ,1,0));
			unsigned8 lf_CountNonBlank                                                            := sum(group, if(pInput_AL.lf                                                                <> ''  ,1,0));
		end;
		pInput_AL_stat := table(pInput_AL, Layout_pInput_AL_stat, state  , few);
		strata.createXMLStats(pInput_AL_stat, 'MartinDale_Hubble_AL', 'input', pversion, _control.myinfo.emailaddressnotify, Input_stat_AL, 'View', 'Population');

		//////////////////////////////////////////////////////////////
		// -- AR Input Population Stats
		//////////////////////////////////////////////////////////////
		pInput_AR := files(pversion).input.AR.sprayed;
		Layout_pInput_AR_stat :=
		record
			unsigned8 CountGroup                                                                  := count(group);
			pInput_AR.state;
			unsigned8 indiv_id_CountNonBlank                                                      := sum(group, if(pInput_AR.indiv_id                                                          <> ''  ,1,0));
			unsigned8 listing_id_CountNonBlank                                                    := sum(group, if(pInput_AR.listing_id                                                        <> ''  ,1,0));
			unsigned8 version_id_CountNonBlank                                                    := sum(group, if(pInput_AR.version_id                                                        <> ''  ,1,0));
			unsigned8 last_name_CountNonBlank                                                     := sum(group, if(pInput_AR.last_name                                                         <> ''  ,1,0));
			unsigned8 first_name_CountNonBlank                                                    := sum(group, if(pInput_AR.first_name                                                        <> ''  ,1,0));
			unsigned8 suffix_CountNonBlank                                                        := sum(group, if(pInput_AR.suffix                                                            <> ''  ,1,0));
			unsigned8 year_born_CountNonBlank                                                     := sum(group, if(pInput_AR.year_born                                                         <> ''  ,1,0));
			unsigned8 year_admitted_CountNonBlank                                                 := sum(group, if(pInput_AR.year_admitted                                                     <> ''  ,1,0));
			unsigned8 building_CountNonBlank                                                      := sum(group, if(pInput_AR.building                                                          <> ''  ,1,0));
			unsigned8 street_CountNonBlank                                                        := sum(group, if(pInput_AR.street                                                            <> ''  ,1,0));
			unsigned8 po_box_CountNonBlank                                                        := sum(group, if(pInput_AR.po_box                                                            <> ''  ,1,0));
			unsigned8 city_CountNonBlank                                                          := sum(group, if(pInput_AR.city                                                              <> ''  ,1,0));
			unsigned8 zip_CountNonBlank                                                           := sum(group, if(pInput_AR.zip                                                               <> ''  ,1,0));
			unsigned8 born_text_CountNonBlank                                                     := sum(group, if(pInput_AR.born_text                                                         <> ''  ,1,0));
			unsigned8 lf_CountNonBlank                                                            := sum(group, if(pInput_AR.lf                                                                <> ''  ,1,0));
		end;
		pInput_AR_stat := table(pInput_AR, Layout_pInput_AR_stat, state  , few);
		strata.createXMLStats(pInput_AR_stat, 'MartinDale_Hubble_AR', 'input', pversion, _control.myinfo.emailaddressnotify, Input_stat_AR, 'View', 'Population');

		//////////////////////////////////////////////////////////////
		// -- AZ Input Population Stats
		//////////////////////////////////////////////////////////////
		pInput_AZ := files(pversion).input.AZ.sprayed;
		Layout_pInput_AZ_stat :=
		record
			unsigned8 CountGroup                                                                  := count(group);
			pInput_AZ.state;
			unsigned8 indiv_id_CountNonBlank                                                      := sum(group, if(pInput_AZ.indiv_id                                                          <> ''  ,1,0));
			unsigned8 listing_id_CountNonBlank                                                    := sum(group, if(pInput_AZ.listing_id                                                        <> ''  ,1,0));
			unsigned8 version_id_CountNonBlank                                                    := sum(group, if(pInput_AZ.version_id                                                        <> ''  ,1,0));
			unsigned8 last_name_CountNonBlank                                                     := sum(group, if(pInput_AZ.last_name                                                         <> ''  ,1,0));
			unsigned8 first_name_CountNonBlank                                                    := sum(group, if(pInput_AZ.first_name                                                        <> ''  ,1,0));
			unsigned8 suffix_CountNonBlank                                                        := sum(group, if(pInput_AZ.suffix                                                            <> ''  ,1,0));
			unsigned8 year_born_CountNonBlank                                                     := sum(group, if(pInput_AZ.year_born                                                         <> ''  ,1,0));
			unsigned8 year_admitted_CountNonBlank                                                 := sum(group, if(pInput_AZ.year_admitted                                                     <> ''  ,1,0));
			unsigned8 building_CountNonBlank                                                      := sum(group, if(pInput_AZ.building                                                          <> ''  ,1,0));
			unsigned8 street_CountNonBlank                                                        := sum(group, if(pInput_AZ.street                                                            <> ''  ,1,0));
			unsigned8 po_box_CountNonBlank                                                        := sum(group, if(pInput_AZ.po_box                                                            <> ''  ,1,0));
			unsigned8 city_CountNonBlank                                                          := sum(group, if(pInput_AZ.city                                                              <> ''  ,1,0));
			unsigned8 zip_CountNonBlank                                                           := sum(group, if(pInput_AZ.zip                                                               <> ''  ,1,0));
			unsigned8 born_text_CountNonBlank                                                     := sum(group, if(pInput_AZ.born_text                                                         <> ''  ,1,0));
			unsigned8 lf_CountNonBlank                                                            := sum(group, if(pInput_AZ.lf                                                                <> ''  ,1,0));
		end;
		pInput_AZ_stat := table(pInput_AZ, Layout_pInput_AZ_stat, state  , few);
		strata.createXMLStats(pInput_AZ_stat, 'MartinDale_Hubble_AZ', 'input', pversion, _control.myinfo.emailaddressnotify, Input_stat_AZ, 'View', 'Population');

		export all :=
		parallel(

			 Input_stat_AK
			,Input_stat_AL
			,Input_stat_AR
			,Input_stat_AZ
		
		);

	end;

//Do stats on base files
//population stats
	export Base :=
	module
		pBase_AK := files(pversion).base.AK.new;
		Layout_pBase_AK_stat :=
		record
			unsigned8 CountGroup                                                                  := count(group);
			pBase_AK.rawfields.state;
			unsigned8 did_CountNonZero                                                            := sum(group, if(pBase_AK.did                                                                <> 0   ,1,0));
			unsigned8 did_score_CountNonZero                                                      := sum(group, if(pBase_AK.did_score                                                          <> 0   ,1,0));
			unsigned8 rawfields_indiv_id_CountNonBlank                                            := sum(group, if(pBase_AK.rawfields.indiv_id                                                 <> ''  ,1,0));
			unsigned8 rawfields_listing_id_CountNonBlank                                          := sum(group, if(pBase_AK.rawfields.listing_id                                               <> ''  ,1,0));
			unsigned8 rawfields_version_id_CountNonBlank                                          := sum(group, if(pBase_AK.rawfields.version_id                                               <> ''  ,1,0));
			unsigned8 rawfields_last_name_CountNonBlank                                           := sum(group, if(pBase_AK.rawfields.last_name                                                <> ''  ,1,0));
			unsigned8 rawfields_first_name_CountNonBlank                                          := sum(group, if(pBase_AK.rawfields.first_name                                               <> ''  ,1,0));
			unsigned8 rawfields_suffix_CountNonBlank                                              := sum(group, if(pBase_AK.rawfields.suffix                                                   <> ''  ,1,0));
			unsigned8 rawfields_year_born_CountNonBlank                                           := sum(group, if(pBase_AK.rawfields.year_born                                                <> ''  ,1,0));
			unsigned8 rawfields_year_admitted_CountNonBlank                                       := sum(group, if(pBase_AK.rawfields.year_admitted                                            <> ''  ,1,0));
			unsigned8 rawfields_building_CountNonBlank                                            := sum(group, if(pBase_AK.rawfields.building                                                 <> ''  ,1,0));
			unsigned8 rawfields_street_CountNonBlank                                              := sum(group, if(pBase_AK.rawfields.street                                                   <> ''  ,1,0));
			unsigned8 rawfields_po_box_CountNonBlank                                              := sum(group, if(pBase_AK.rawfields.po_box                                                   <> ''  ,1,0));
			unsigned8 rawfields_city_CountNonBlank                                                := sum(group, if(pBase_AK.rawfields.city                                                     <> ''  ,1,0));
			unsigned8 rawfields_zip_CountNonBlank                                                 := sum(group, if(pBase_AK.rawfields.zip                                                      <> ''  ,1,0));
			unsigned8 rawfields_born_text_CountNonBlank                                           := sum(group, if(pBase_AK.rawfields.born_text                                                <> ''  ,1,0));
			unsigned8 rawfields_lf_CountNonBlank                                                  := sum(group, if(pBase_AK.rawfields.lf                                                       <> ''  ,1,0));
			unsigned8 title_CountNonBlank                                                         := sum(group, if(pBase_AK.title                                                              <> ''  ,1,0));
			unsigned8 fname_CountNonBlank                                                         := sum(group, if(pBase_AK.fname                                                              <> ''  ,1,0));
			unsigned8 mname_CountNonBlank                                                         := sum(group, if(pBase_AK.mname                                                              <> ''  ,1,0));
			unsigned8 lname_CountNonBlank                                                         := sum(group, if(pBase_AK.lname                                                              <> ''  ,1,0));
			unsigned8 name_suffix_CountNonBlank                                                   := sum(group, if(pBase_AK.name_suffix                                                        <> ''  ,1,0));
			unsigned8 name_score_CountNonBlank                                                    := sum(group, if(pBase_AK.name_score                                                         <> ''  ,1,0));
			unsigned8 dob_CountNonBlank                                                           := sum(group, if(pBase_AK.dob                                                                <> ''  ,1,0));
			unsigned8 prim_range_CountNonBlank                                                    := sum(group, if(pBase_AK.prim_range                                                         <> ''  ,1,0));
			unsigned8 predir_CountNonBlank                                                        := sum(group, if(pBase_AK.predir                                                             <> ''  ,1,0));
			unsigned8 prim_name_CountNonBlank                                                     := sum(group, if(pBase_AK.prim_name                                                          <> ''  ,1,0));
			unsigned8 addr_suffix_CountNonBlank                                                   := sum(group, if(pBase_AK.addr_suffix                                                        <> ''  ,1,0));
			unsigned8 postdir_CountNonBlank                                                       := sum(group, if(pBase_AK.postdir                                                            <> ''  ,1,0));
			unsigned8 unit_desig_CountNonBlank                                                    := sum(group, if(pBase_AK.unit_desig                                                         <> ''  ,1,0));
			unsigned8 sec_range_CountNonBlank                                                     := sum(group, if(pBase_AK.sec_range                                                          <> ''  ,1,0));
			unsigned8 p_city_name_CountNonBlank                                                   := sum(group, if(pBase_AK.p_city_name                                                        <> ''  ,1,0));
			unsigned8 v_city_name_CountNonBlank                                                   := sum(group, if(pBase_AK.v_city_name                                                        <> ''  ,1,0));
			unsigned8 st_CountNonBlank                                                            := sum(group, if(pBase_AK.st                                                                 <> ''  ,1,0));
			unsigned8 zip_CountNonBlank                                                           := sum(group, if(pBase_AK.zip                                                                <> ''  ,1,0));
			unsigned8 zip4_CountNonBlank                                                          := sum(group, if(pBase_AK.zip4                                                               <> ''  ,1,0));
			unsigned8 cart_CountNonBlank                                                          := sum(group, if(pBase_AK.cart                                                               <> ''  ,1,0));
			unsigned8 cr_sort_sz_CountNonBlank                                                    := sum(group, if(pBase_AK.cr_sort_sz                                                         <> ''  ,1,0));
			unsigned8 lot_CountNonBlank                                                           := sum(group, if(pBase_AK.lot                                                                <> ''  ,1,0));
			unsigned8 lot_order_CountNonBlank                                                     := sum(group, if(pBase_AK.lot_order                                                          <> ''  ,1,0));
			unsigned8 dbpc_CountNonBlank                                                          := sum(group, if(pBase_AK.dbpc                                                               <> ''  ,1,0));
			unsigned8 chk_digit_CountNonBlank                                                     := sum(group, if(pBase_AK.chk_digit                                                          <> ''  ,1,0));
			unsigned8 rec_type_CountNonBlank                                                      := sum(group, if(pBase_AK.rec_type                                                           <> ''  ,1,0));
			unsigned8 fips_state_CountNonBlank                                                    := sum(group, if(pBase_AK.fips_state                                                         <> ''  ,1,0));
			unsigned8 fips_county_CountNonBlank                                                   := sum(group, if(pBase_AK.fips_county                                                        <> ''  ,1,0));
			unsigned8 geo_lat_CountNonBlank                                                       := sum(group, if(pBase_AK.geo_lat                                                            <> ''  ,1,0));
			unsigned8 geo_long_CountNonBlank                                                      := sum(group, if(pBase_AK.geo_long                                                           <> ''  ,1,0));
			unsigned8 msa_CountNonBlank                                                           := sum(group, if(pBase_AK.msa                                                                <> ''  ,1,0));
			unsigned8 geo_blk_CountNonBlank                                                       := sum(group, if(pBase_AK.geo_blk                                                            <> ''  ,1,0));
			unsigned8 geo_match_CountNonBlank                                                     := sum(group, if(pBase_AK.geo_match                                                          <> ''  ,1,0));
			unsigned8 err_stat_CountNonBlank                                                      := sum(group, if(pBase_AK.err_stat                                                           <> ''  ,1,0));
			unsigned8 best_person_info_phone_CountNonBlank                                        := sum(group, if(pBase_AK.best_person_info.phone                                             <> ''  ,1,0));
			unsigned8 best_person_info_dob_CountNonZero                                           := sum(group, if(pBase_AK.best_person_info.dob                                               <> 0   ,1,0));
			unsigned8 best_person_info_prim_range_CountNonBlank                                   := sum(group, if(pBase_AK.best_person_info.prim_range                                        <> ''  ,1,0));
			unsigned8 best_person_info_predir_CountNonBlank                                       := sum(group, if(pBase_AK.best_person_info.predir                                            <> ''  ,1,0));
			unsigned8 best_person_info_prim_name_CountNonBlank                                    := sum(group, if(pBase_AK.best_person_info.prim_name                                         <> ''  ,1,0));
			unsigned8 best_person_info_suffix_CountNonBlank                                       := sum(group, if(pBase_AK.best_person_info.suffix                                            <> ''  ,1,0));
			unsigned8 best_person_info_postdir_CountNonBlank                                      := sum(group, if(pBase_AK.best_person_info.postdir                                           <> ''  ,1,0));
			unsigned8 best_person_info_unit_desig_CountNonBlank                                   := sum(group, if(pBase_AK.best_person_info.unit_desig                                        <> ''  ,1,0));
			unsigned8 best_person_info_sec_range_CountNonBlank                                    := sum(group, if(pBase_AK.best_person_info.sec_range                                         <> ''  ,1,0));
			unsigned8 best_person_info_city_name_CountNonBlank                                    := sum(group, if(pBase_AK.best_person_info.city_name                                         <> ''  ,1,0));
			unsigned8 best_person_info_st_CountNonBlank                                           := sum(group, if(pBase_AK.best_person_info.st                                                <> ''  ,1,0));
			unsigned8 best_person_info_zip_CountNonBlank                                          := sum(group, if(pBase_AK.best_person_info.zip                                               <> ''  ,1,0));
			unsigned8 best_person_info_zip4_CountNonBlank                                         := sum(group, if(pBase_AK.best_person_info.zip4                                              <> ''  ,1,0));
			unsigned8 best_person_info_addr_dt_last_seen_CountNonZero                             := sum(group, if(pBase_AK.best_person_info.addr_dt_last_seen                                 <> 0   ,1,0));
			unsigned8 best_person_info_DOD_CountNonBlank                                          := sum(group, if(pBase_AK.best_person_info.DOD                                               <> ''  ,1,0));
			unsigned8 best_business_info_dt_last_seen_CountNonZero                                := sum(group, if(pBase_AK.best_business_info.dt_last_seen                                    <> 0   ,1,0));
			unsigned8 best_business_info_company_name_CountNonBlank                               := sum(group, if(pBase_AK.best_business_info.company_name                                    <> ''  ,1,0));
			unsigned8 best_business_info_prim_range_CountNonBlank                                 := sum(group, if(pBase_AK.best_business_info.prim_range                                      <> ''  ,1,0));
			unsigned8 best_business_info_predir_CountNonBlank                                     := sum(group, if(pBase_AK.best_business_info.predir                                          <> ''  ,1,0));
			unsigned8 best_business_info_prim_name_CountNonBlank                                  := sum(group, if(pBase_AK.best_business_info.prim_name                                       <> ''  ,1,0));
			unsigned8 best_business_info_addr_suffix_CountNonBlank                                := sum(group, if(pBase_AK.best_business_info.addr_suffix                                     <> ''  ,1,0));
			unsigned8 best_business_info_postdir_CountNonBlank                                    := sum(group, if(pBase_AK.best_business_info.postdir                                         <> ''  ,1,0));
			unsigned8 best_business_info_unit_desig_CountNonBlank                                 := sum(group, if(pBase_AK.best_business_info.unit_desig                                      <> ''  ,1,0));
			unsigned8 best_business_info_sec_range_CountNonBlank                                  := sum(group, if(pBase_AK.best_business_info.sec_range                                       <> ''  ,1,0));
			unsigned8 best_business_info_city_CountNonBlank                                       := sum(group, if(pBase_AK.best_business_info.city                                            <> ''  ,1,0));
			unsigned8 best_business_info_state_CountNonBlank                                      := sum(group, if(pBase_AK.best_business_info.state                                           <> ''  ,1,0));
			unsigned8 best_business_info_zip_CountNonZero                                         := sum(group, if(pBase_AK.best_business_info.zip                                             <> 0   ,1,0));
			unsigned8 best_business_info_zip4_CountNonZero                                        := sum(group, if(pBase_AK.best_business_info.zip4                                            <> 0   ,1,0));
			unsigned8 best_business_info_phone_CountNonZero                                       := sum(group, if(pBase_AK.best_business_info.phone                                           <> 0   ,1,0));
		end;                          
		pBase_AK_stat := table(pBase_AK, Layout_pBase_AK_stat, rawfields.state  , few);
		strata.createXMLStats(pBase_AK_stat, 'MartinDale_Hubble_AK', 'base', pversion, _control.myinfo.emailaddressnotify, base_stat_AK, 'View', 'Population');
		pBase_AL := files(pversion).base.AL.new;
		Layout_pBase_AL_stat :=
		record
			unsigned8 CountGroup                                                                  := count(group);
			pBase_AL.rawfields.state;
			unsigned8 did_CountNonZero                                                            := sum(group, if(pBase_AL.did                                                                <> 0   ,1,0));
			unsigned8 did_score_CountNonZero                                                      := sum(group, if(pBase_AL.did_score                                                          <> 0   ,1,0));
			unsigned8 rawfields_indiv_id_CountNonBlank                                            := sum(group, if(pBase_AL.rawfields.indiv_id                                                 <> ''  ,1,0));
			unsigned8 rawfields_listing_id_CountNonBlank                                          := sum(group, if(pBase_AL.rawfields.listing_id                                               <> ''  ,1,0));
			unsigned8 rawfields_version_id_CountNonBlank                                          := sum(group, if(pBase_AL.rawfields.version_id                                               <> ''  ,1,0));
			unsigned8 rawfields_last_name_CountNonBlank                                           := sum(group, if(pBase_AL.rawfields.last_name                                                <> ''  ,1,0));
			unsigned8 rawfields_first_name_CountNonBlank                                          := sum(group, if(pBase_AL.rawfields.first_name                                               <> ''  ,1,0));
			unsigned8 rawfields_suffix_CountNonBlank                                              := sum(group, if(pBase_AL.rawfields.suffix                                                   <> ''  ,1,0));
			unsigned8 rawfields_year_born_CountNonBlank                                           := sum(group, if(pBase_AL.rawfields.year_born                                                <> ''  ,1,0));
			unsigned8 rawfields_year_admitted_CountNonBlank                                       := sum(group, if(pBase_AL.rawfields.year_admitted                                            <> ''  ,1,0));
			unsigned8 rawfields_building_CountNonBlank                                            := sum(group, if(pBase_AL.rawfields.building                                                 <> ''  ,1,0));
			unsigned8 rawfields_street_CountNonBlank                                              := sum(group, if(pBase_AL.rawfields.street                                                   <> ''  ,1,0));
			unsigned8 rawfields_po_box_CountNonBlank                                              := sum(group, if(pBase_AL.rawfields.po_box                                                   <> ''  ,1,0));
			unsigned8 rawfields_city_CountNonBlank                                                := sum(group, if(pBase_AL.rawfields.city                                                     <> ''  ,1,0));
			unsigned8 rawfields_zip_CountNonBlank                                                 := sum(group, if(pBase_AL.rawfields.zip                                                      <> ''  ,1,0));
			unsigned8 rawfields_born_text_CountNonBlank                                           := sum(group, if(pBase_AL.rawfields.born_text                                                <> ''  ,1,0));
			unsigned8 rawfields_lf_CountNonBlank                                                  := sum(group, if(pBase_AL.rawfields.lf                                                       <> ''  ,1,0));
			unsigned8 title_CountNonBlank                                                         := sum(group, if(pBase_AL.title                                                              <> ''  ,1,0));
			unsigned8 fname_CountNonBlank                                                         := sum(group, if(pBase_AL.fname                                                              <> ''  ,1,0));
			unsigned8 mname_CountNonBlank                                                         := sum(group, if(pBase_AL.mname                                                              <> ''  ,1,0));
			unsigned8 lname_CountNonBlank                                                         := sum(group, if(pBase_AL.lname                                                              <> ''  ,1,0));
			unsigned8 name_suffix_CountNonBlank                                                   := sum(group, if(pBase_AL.name_suffix                                                        <> ''  ,1,0));
			unsigned8 name_score_CountNonBlank                                                    := sum(group, if(pBase_AL.name_score                                                         <> ''  ,1,0));
			unsigned8 dob_CountNonBlank                                                           := sum(group, if(pBase_AL.dob                                                                <> ''  ,1,0));
			unsigned8 prim_range_CountNonBlank                                                    := sum(group, if(pBase_AL.prim_range                                                         <> ''  ,1,0));
			unsigned8 predir_CountNonBlank                                                        := sum(group, if(pBase_AL.predir                                                             <> ''  ,1,0));
			unsigned8 prim_name_CountNonBlank                                                     := sum(group, if(pBase_AL.prim_name                                                          <> ''  ,1,0));
			unsigned8 addr_suffix_CountNonBlank                                                   := sum(group, if(pBase_AL.addr_suffix                                                        <> ''  ,1,0));
			unsigned8 postdir_CountNonBlank                                                       := sum(group, if(pBase_AL.postdir                                                            <> ''  ,1,0));
			unsigned8 unit_desig_CountNonBlank                                                    := sum(group, if(pBase_AL.unit_desig                                                         <> ''  ,1,0));
			unsigned8 sec_range_CountNonBlank                                                     := sum(group, if(pBase_AL.sec_range                                                          <> ''  ,1,0));
			unsigned8 p_city_name_CountNonBlank                                                   := sum(group, if(pBase_AL.p_city_name                                                        <> ''  ,1,0));
			unsigned8 v_city_name_CountNonBlank                                                   := sum(group, if(pBase_AL.v_city_name                                                        <> ''  ,1,0));
			unsigned8 st_CountNonBlank                                                            := sum(group, if(pBase_AL.st                                                                 <> ''  ,1,0));
			unsigned8 zip_CountNonBlank                                                           := sum(group, if(pBase_AL.zip                                                                <> ''  ,1,0));
			unsigned8 zip4_CountNonBlank                                                          := sum(group, if(pBase_AL.zip4                                                               <> ''  ,1,0));
			unsigned8 cart_CountNonBlank                                                          := sum(group, if(pBase_AL.cart                                                               <> ''  ,1,0));
			unsigned8 cr_sort_sz_CountNonBlank                                                    := sum(group, if(pBase_AL.cr_sort_sz                                                         <> ''  ,1,0));
			unsigned8 lot_CountNonBlank                                                           := sum(group, if(pBase_AL.lot                                                                <> ''  ,1,0));
			unsigned8 lot_order_CountNonBlank                                                     := sum(group, if(pBase_AL.lot_order                                                          <> ''  ,1,0));
			unsigned8 dbpc_CountNonBlank                                                          := sum(group, if(pBase_AL.dbpc                                                               <> ''  ,1,0));
			unsigned8 chk_digit_CountNonBlank                                                     := sum(group, if(pBase_AL.chk_digit                                                          <> ''  ,1,0));
			unsigned8 rec_type_CountNonBlank                                                      := sum(group, if(pBase_AL.rec_type                                                           <> ''  ,1,0));
			unsigned8 fips_state_CountNonBlank                                                    := sum(group, if(pBase_AL.fips_state                                                         <> ''  ,1,0));
			unsigned8 fips_county_CountNonBlank                                                   := sum(group, if(pBase_AL.fips_county                                                        <> ''  ,1,0));
			unsigned8 geo_lat_CountNonBlank                                                       := sum(group, if(pBase_AL.geo_lat                                                            <> ''  ,1,0));
			unsigned8 geo_long_CountNonBlank                                                      := sum(group, if(pBase_AL.geo_long                                                           <> ''  ,1,0));
			unsigned8 msa_CountNonBlank                                                           := sum(group, if(pBase_AL.msa                                                                <> ''  ,1,0));
			unsigned8 geo_blk_CountNonBlank                                                       := sum(group, if(pBase_AL.geo_blk                                                            <> ''  ,1,0));
			unsigned8 geo_match_CountNonBlank                                                     := sum(group, if(pBase_AL.geo_match                                                          <> ''  ,1,0));
			unsigned8 err_stat_CountNonBlank                                                      := sum(group, if(pBase_AL.err_stat                                                           <> ''  ,1,0));
			unsigned8 best_person_info_phone_CountNonBlank                                        := sum(group, if(pBase_AL.best_person_info.phone                                             <> ''  ,1,0));
			unsigned8 best_person_info_dob_CountNonZero                                           := sum(group, if(pBase_AL.best_person_info.dob                                               <> 0   ,1,0));
			unsigned8 best_person_info_prim_range_CountNonBlank                                   := sum(group, if(pBase_AL.best_person_info.prim_range                                        <> ''  ,1,0));
			unsigned8 best_person_info_predir_CountNonBlank                                       := sum(group, if(pBase_AL.best_person_info.predir                                            <> ''  ,1,0));
			unsigned8 best_person_info_prim_name_CountNonBlank                                    := sum(group, if(pBase_AL.best_person_info.prim_name                                         <> ''  ,1,0));
			unsigned8 best_person_info_suffix_CountNonBlank                                       := sum(group, if(pBase_AL.best_person_info.suffix                                            <> ''  ,1,0));
			unsigned8 best_person_info_postdir_CountNonBlank                                      := sum(group, if(pBase_AL.best_person_info.postdir                                           <> ''  ,1,0));
			unsigned8 best_person_info_unit_desig_CountNonBlank                                   := sum(group, if(pBase_AL.best_person_info.unit_desig                                        <> ''  ,1,0));
			unsigned8 best_person_info_sec_range_CountNonBlank                                    := sum(group, if(pBase_AL.best_person_info.sec_range                                         <> ''  ,1,0));
			unsigned8 best_person_info_city_name_CountNonBlank                                    := sum(group, if(pBase_AL.best_person_info.city_name                                         <> ''  ,1,0));
			unsigned8 best_person_info_st_CountNonBlank                                           := sum(group, if(pBase_AL.best_person_info.st                                                <> ''  ,1,0));
			unsigned8 best_person_info_zip_CountNonBlank                                          := sum(group, if(pBase_AL.best_person_info.zip                                               <> ''  ,1,0));
			unsigned8 best_person_info_zip4_CountNonBlank                                         := sum(group, if(pBase_AL.best_person_info.zip4                                              <> ''  ,1,0));
			unsigned8 best_person_info_addr_dt_last_seen_CountNonZero                             := sum(group, if(pBase_AL.best_person_info.addr_dt_last_seen                                 <> 0   ,1,0));
			unsigned8 best_person_info_DOD_CountNonBlank                                          := sum(group, if(pBase_AL.best_person_info.DOD                                               <> ''  ,1,0));
			unsigned8 best_business_info_dt_last_seen_CountNonZero                                := sum(group, if(pBase_AL.best_business_info.dt_last_seen                                    <> 0   ,1,0));
			unsigned8 best_business_info_company_name_CountNonBlank                               := sum(group, if(pBase_AL.best_business_info.company_name                                    <> ''  ,1,0));
			unsigned8 best_business_info_prim_range_CountNonBlank                                 := sum(group, if(pBase_AL.best_business_info.prim_range                                      <> ''  ,1,0));
			unsigned8 best_business_info_predir_CountNonBlank                                     := sum(group, if(pBase_AL.best_business_info.predir                                          <> ''  ,1,0));
			unsigned8 best_business_info_prim_name_CountNonBlank                                  := sum(group, if(pBase_AL.best_business_info.prim_name                                       <> ''  ,1,0));
			unsigned8 best_business_info_addr_suffix_CountNonBlank                                := sum(group, if(pBase_AL.best_business_info.addr_suffix                                     <> ''  ,1,0));
			unsigned8 best_business_info_postdir_CountNonBlank                                    := sum(group, if(pBase_AL.best_business_info.postdir                                         <> ''  ,1,0));
			unsigned8 best_business_info_unit_desig_CountNonBlank                                 := sum(group, if(pBase_AL.best_business_info.unit_desig                                      <> ''  ,1,0));
			unsigned8 best_business_info_sec_range_CountNonBlank                                  := sum(group, if(pBase_AL.best_business_info.sec_range                                       <> ''  ,1,0));
			unsigned8 best_business_info_city_CountNonBlank                                       := sum(group, if(pBase_AL.best_business_info.city                                            <> ''  ,1,0));
			unsigned8 best_business_info_state_CountNonBlank                                      := sum(group, if(pBase_AL.best_business_info.state                                           <> ''  ,1,0));
			unsigned8 best_business_info_zip_CountNonZero                                         := sum(group, if(pBase_AL.best_business_info.zip                                             <> 0   ,1,0));
			unsigned8 best_business_info_zip4_CountNonZero                                        := sum(group, if(pBase_AL.best_business_info.zip4                                            <> 0   ,1,0));
			unsigned8 best_business_info_phone_CountNonZero                                       := sum(group, if(pBase_AL.best_business_info.phone                                           <> 0   ,1,0));
		end;                          
		pBase_AL_stat := table(pBase_AL, Layout_pBase_AL_stat, rawfields.state  , few);
		strata.createXMLStats(pBase_AL_stat, 'MartinDale_Hubble_AL', 'base', pversion, _control.myinfo.emailaddressnotify, base_stat_AL, 'View', 'Population');
		pBase_AR := files(pversion).base.AR.new;
		Layout_pBase_AR_stat :=
		record
			unsigned8 CountGroup                                                                  := count(group);
			pBase_AR.rawfields.state;
			unsigned8 did_CountNonZero                                                            := sum(group, if(pBase_AR.did                                                                <> 0   ,1,0));
			unsigned8 did_score_CountNonZero                                                      := sum(group, if(pBase_AR.did_score                                                          <> 0   ,1,0));
			unsigned8 rawfields_indiv_id_CountNonBlank                                            := sum(group, if(pBase_AR.rawfields.indiv_id                                                 <> ''  ,1,0));
			unsigned8 rawfields_listing_id_CountNonBlank                                          := sum(group, if(pBase_AR.rawfields.listing_id                                               <> ''  ,1,0));
			unsigned8 rawfields_version_id_CountNonBlank                                          := sum(group, if(pBase_AR.rawfields.version_id                                               <> ''  ,1,0));
			unsigned8 rawfields_last_name_CountNonBlank                                           := sum(group, if(pBase_AR.rawfields.last_name                                                <> ''  ,1,0));
			unsigned8 rawfields_first_name_CountNonBlank                                          := sum(group, if(pBase_AR.rawfields.first_name                                               <> ''  ,1,0));
			unsigned8 rawfields_suffix_CountNonBlank                                              := sum(group, if(pBase_AR.rawfields.suffix                                                   <> ''  ,1,0));
			unsigned8 rawfields_year_born_CountNonBlank                                           := sum(group, if(pBase_AR.rawfields.year_born                                                <> ''  ,1,0));
			unsigned8 rawfields_year_admitted_CountNonBlank                                       := sum(group, if(pBase_AR.rawfields.year_admitted                                            <> ''  ,1,0));
			unsigned8 rawfields_building_CountNonBlank                                            := sum(group, if(pBase_AR.rawfields.building                                                 <> ''  ,1,0));
			unsigned8 rawfields_street_CountNonBlank                                              := sum(group, if(pBase_AR.rawfields.street                                                   <> ''  ,1,0));
			unsigned8 rawfields_po_box_CountNonBlank                                              := sum(group, if(pBase_AR.rawfields.po_box                                                   <> ''  ,1,0));
			unsigned8 rawfields_city_CountNonBlank                                                := sum(group, if(pBase_AR.rawfields.city                                                     <> ''  ,1,0));
			unsigned8 rawfields_zip_CountNonBlank                                                 := sum(group, if(pBase_AR.rawfields.zip                                                      <> ''  ,1,0));
			unsigned8 rawfields_born_text_CountNonBlank                                           := sum(group, if(pBase_AR.rawfields.born_text                                                <> ''  ,1,0));
			unsigned8 rawfields_lf_CountNonBlank                                                  := sum(group, if(pBase_AR.rawfields.lf                                                       <> ''  ,1,0));
			unsigned8 title_CountNonBlank                                                         := sum(group, if(pBase_AR.title                                                              <> ''  ,1,0));
			unsigned8 fname_CountNonBlank                                                         := sum(group, if(pBase_AR.fname                                                              <> ''  ,1,0));
			unsigned8 mname_CountNonBlank                                                         := sum(group, if(pBase_AR.mname                                                              <> ''  ,1,0));
			unsigned8 lname_CountNonBlank                                                         := sum(group, if(pBase_AR.lname                                                              <> ''  ,1,0));
			unsigned8 name_suffix_CountNonBlank                                                   := sum(group, if(pBase_AR.name_suffix                                                        <> ''  ,1,0));
			unsigned8 name_score_CountNonBlank                                                    := sum(group, if(pBase_AR.name_score                                                         <> ''  ,1,0));
			unsigned8 dob_CountNonBlank                                                           := sum(group, if(pBase_AR.dob                                                                <> ''  ,1,0));
			unsigned8 prim_range_CountNonBlank                                                    := sum(group, if(pBase_AR.prim_range                                                         <> ''  ,1,0));
			unsigned8 predir_CountNonBlank                                                        := sum(group, if(pBase_AR.predir                                                             <> ''  ,1,0));
			unsigned8 prim_name_CountNonBlank                                                     := sum(group, if(pBase_AR.prim_name                                                          <> ''  ,1,0));
			unsigned8 addr_suffix_CountNonBlank                                                   := sum(group, if(pBase_AR.addr_suffix                                                        <> ''  ,1,0));
			unsigned8 postdir_CountNonBlank                                                       := sum(group, if(pBase_AR.postdir                                                            <> ''  ,1,0));
			unsigned8 unit_desig_CountNonBlank                                                    := sum(group, if(pBase_AR.unit_desig                                                         <> ''  ,1,0));
			unsigned8 sec_range_CountNonBlank                                                     := sum(group, if(pBase_AR.sec_range                                                          <> ''  ,1,0));
			unsigned8 p_city_name_CountNonBlank                                                   := sum(group, if(pBase_AR.p_city_name                                                        <> ''  ,1,0));
			unsigned8 v_city_name_CountNonBlank                                                   := sum(group, if(pBase_AR.v_city_name                                                        <> ''  ,1,0));
			unsigned8 st_CountNonBlank                                                            := sum(group, if(pBase_AR.st                                                                 <> ''  ,1,0));
			unsigned8 zip_CountNonBlank                                                           := sum(group, if(pBase_AR.zip                                                                <> ''  ,1,0));
			unsigned8 zip4_CountNonBlank                                                          := sum(group, if(pBase_AR.zip4                                                               <> ''  ,1,0));
			unsigned8 cart_CountNonBlank                                                          := sum(group, if(pBase_AR.cart                                                               <> ''  ,1,0));
			unsigned8 cr_sort_sz_CountNonBlank                                                    := sum(group, if(pBase_AR.cr_sort_sz                                                         <> ''  ,1,0));
			unsigned8 lot_CountNonBlank                                                           := sum(group, if(pBase_AR.lot                                                                <> ''  ,1,0));
			unsigned8 lot_order_CountNonBlank                                                     := sum(group, if(pBase_AR.lot_order                                                          <> ''  ,1,0));
			unsigned8 dbpc_CountNonBlank                                                          := sum(group, if(pBase_AR.dbpc                                                               <> ''  ,1,0));
			unsigned8 chk_digit_CountNonBlank                                                     := sum(group, if(pBase_AR.chk_digit                                                          <> ''  ,1,0));
			unsigned8 rec_type_CountNonBlank                                                      := sum(group, if(pBase_AR.rec_type                                                           <> ''  ,1,0));
			unsigned8 fips_state_CountNonBlank                                                    := sum(group, if(pBase_AR.fips_state                                                         <> ''  ,1,0));
			unsigned8 fips_county_CountNonBlank                                                   := sum(group, if(pBase_AR.fips_county                                                        <> ''  ,1,0));
			unsigned8 geo_lat_CountNonBlank                                                       := sum(group, if(pBase_AR.geo_lat                                                            <> ''  ,1,0));
			unsigned8 geo_long_CountNonBlank                                                      := sum(group, if(pBase_AR.geo_long                                                           <> ''  ,1,0));
			unsigned8 msa_CountNonBlank                                                           := sum(group, if(pBase_AR.msa                                                                <> ''  ,1,0));
			unsigned8 geo_blk_CountNonBlank                                                       := sum(group, if(pBase_AR.geo_blk                                                            <> ''  ,1,0));
			unsigned8 geo_match_CountNonBlank                                                     := sum(group, if(pBase_AR.geo_match                                                          <> ''  ,1,0));
			unsigned8 err_stat_CountNonBlank                                                      := sum(group, if(pBase_AR.err_stat                                                           <> ''  ,1,0));
			unsigned8 best_person_info_phone_CountNonBlank                                        := sum(group, if(pBase_AR.best_person_info.phone                                             <> ''  ,1,0));
			unsigned8 best_person_info_dob_CountNonZero                                           := sum(group, if(pBase_AR.best_person_info.dob                                               <> 0   ,1,0));
			unsigned8 best_person_info_prim_range_CountNonBlank                                   := sum(group, if(pBase_AR.best_person_info.prim_range                                        <> ''  ,1,0));
			unsigned8 best_person_info_predir_CountNonBlank                                       := sum(group, if(pBase_AR.best_person_info.predir                                            <> ''  ,1,0));
			unsigned8 best_person_info_prim_name_CountNonBlank                                    := sum(group, if(pBase_AR.best_person_info.prim_name                                         <> ''  ,1,0));
			unsigned8 best_person_info_suffix_CountNonBlank                                       := sum(group, if(pBase_AR.best_person_info.suffix                                            <> ''  ,1,0));
			unsigned8 best_person_info_postdir_CountNonBlank                                      := sum(group, if(pBase_AR.best_person_info.postdir                                           <> ''  ,1,0));
			unsigned8 best_person_info_unit_desig_CountNonBlank                                   := sum(group, if(pBase_AR.best_person_info.unit_desig                                        <> ''  ,1,0));
			unsigned8 best_person_info_sec_range_CountNonBlank                                    := sum(group, if(pBase_AR.best_person_info.sec_range                                         <> ''  ,1,0));
			unsigned8 best_person_info_city_name_CountNonBlank                                    := sum(group, if(pBase_AR.best_person_info.city_name                                         <> ''  ,1,0));
			unsigned8 best_person_info_st_CountNonBlank                                           := sum(group, if(pBase_AR.best_person_info.st                                                <> ''  ,1,0));
			unsigned8 best_person_info_zip_CountNonBlank                                          := sum(group, if(pBase_AR.best_person_info.zip                                               <> ''  ,1,0));
			unsigned8 best_person_info_zip4_CountNonBlank                                         := sum(group, if(pBase_AR.best_person_info.zip4                                              <> ''  ,1,0));
			unsigned8 best_person_info_addr_dt_last_seen_CountNonZero                             := sum(group, if(pBase_AR.best_person_info.addr_dt_last_seen                                 <> 0   ,1,0));
			unsigned8 best_person_info_DOD_CountNonBlank                                          := sum(group, if(pBase_AR.best_person_info.DOD                                               <> ''  ,1,0));
			unsigned8 best_business_info_dt_last_seen_CountNonZero                                := sum(group, if(pBase_AR.best_business_info.dt_last_seen                                    <> 0   ,1,0));
			unsigned8 best_business_info_company_name_CountNonBlank                               := sum(group, if(pBase_AR.best_business_info.company_name                                    <> ''  ,1,0));
			unsigned8 best_business_info_prim_range_CountNonBlank                                 := sum(group, if(pBase_AR.best_business_info.prim_range                                      <> ''  ,1,0));
			unsigned8 best_business_info_predir_CountNonBlank                                     := sum(group, if(pBase_AR.best_business_info.predir                                          <> ''  ,1,0));
			unsigned8 best_business_info_prim_name_CountNonBlank                                  := sum(group, if(pBase_AR.best_business_info.prim_name                                       <> ''  ,1,0));
			unsigned8 best_business_info_addr_suffix_CountNonBlank                                := sum(group, if(pBase_AR.best_business_info.addr_suffix                                     <> ''  ,1,0));
			unsigned8 best_business_info_postdir_CountNonBlank                                    := sum(group, if(pBase_AR.best_business_info.postdir                                         <> ''  ,1,0));
			unsigned8 best_business_info_unit_desig_CountNonBlank                                 := sum(group, if(pBase_AR.best_business_info.unit_desig                                      <> ''  ,1,0));
			unsigned8 best_business_info_sec_range_CountNonBlank                                  := sum(group, if(pBase_AR.best_business_info.sec_range                                       <> ''  ,1,0));
			unsigned8 best_business_info_city_CountNonBlank                                       := sum(group, if(pBase_AR.best_business_info.city                                            <> ''  ,1,0));
			unsigned8 best_business_info_state_CountNonBlank                                      := sum(group, if(pBase_AR.best_business_info.state                                           <> ''  ,1,0));
			unsigned8 best_business_info_zip_CountNonZero                                         := sum(group, if(pBase_AR.best_business_info.zip                                             <> 0   ,1,0));
			unsigned8 best_business_info_zip4_CountNonZero                                        := sum(group, if(pBase_AR.best_business_info.zip4                                            <> 0   ,1,0));
			unsigned8 best_business_info_phone_CountNonZero                                       := sum(group, if(pBase_AR.best_business_info.phone                                           <> 0   ,1,0));
		end;                          
		pBase_AR_stat := table(pBase_AR, Layout_pBase_AR_stat, rawfields.state  , few);
		strata.createXMLStats(pBase_AR_stat, 'MartinDale_Hubble_AR', 'base', pversion, _control.myinfo.emailaddressnotify, base_stat_AR, 'View', 'Population');
		pBase_AZ := files(pversion).base.AZ.new;
		Layout_pBase_AZ_stat :=
		record
			unsigned8 CountGroup                                                                  := count(group);
			pBase_AZ.rawfields.state;
			unsigned8 did_CountNonZero                                                            := sum(group, if(pBase_AZ.did                                                                <> 0   ,1,0));
			unsigned8 did_score_CountNonZero                                                      := sum(group, if(pBase_AZ.did_score                                                          <> 0   ,1,0));
			unsigned8 rawfields_indiv_id_CountNonBlank                                            := sum(group, if(pBase_AZ.rawfields.indiv_id                                                 <> ''  ,1,0));
			unsigned8 rawfields_listing_id_CountNonBlank                                          := sum(group, if(pBase_AZ.rawfields.listing_id                                               <> ''  ,1,0));
			unsigned8 rawfields_version_id_CountNonBlank                                          := sum(group, if(pBase_AZ.rawfields.version_id                                               <> ''  ,1,0));
			unsigned8 rawfields_last_name_CountNonBlank                                           := sum(group, if(pBase_AZ.rawfields.last_name                                                <> ''  ,1,0));
			unsigned8 rawfields_first_name_CountNonBlank                                          := sum(group, if(pBase_AZ.rawfields.first_name                                               <> ''  ,1,0));
			unsigned8 rawfields_suffix_CountNonBlank                                              := sum(group, if(pBase_AZ.rawfields.suffix                                                   <> ''  ,1,0));
			unsigned8 rawfields_year_born_CountNonBlank                                           := sum(group, if(pBase_AZ.rawfields.year_born                                                <> ''  ,1,0));
			unsigned8 rawfields_year_admitted_CountNonBlank                                       := sum(group, if(pBase_AZ.rawfields.year_admitted                                            <> ''  ,1,0));
			unsigned8 rawfields_building_CountNonBlank                                            := sum(group, if(pBase_AZ.rawfields.building                                                 <> ''  ,1,0));
			unsigned8 rawfields_street_CountNonBlank                                              := sum(group, if(pBase_AZ.rawfields.street                                                   <> ''  ,1,0));
			unsigned8 rawfields_po_box_CountNonBlank                                              := sum(group, if(pBase_AZ.rawfields.po_box                                                   <> ''  ,1,0));
			unsigned8 rawfields_city_CountNonBlank                                                := sum(group, if(pBase_AZ.rawfields.city                                                     <> ''  ,1,0));
			unsigned8 rawfields_zip_CountNonBlank                                                 := sum(group, if(pBase_AZ.rawfields.zip                                                      <> ''  ,1,0));
			unsigned8 rawfields_born_text_CountNonBlank                                           := sum(group, if(pBase_AZ.rawfields.born_text                                                <> ''  ,1,0));
			unsigned8 rawfields_lf_CountNonBlank                                                  := sum(group, if(pBase_AZ.rawfields.lf                                                       <> ''  ,1,0));
			unsigned8 title_CountNonBlank                                                         := sum(group, if(pBase_AZ.title                                                              <> ''  ,1,0));
			unsigned8 fname_CountNonBlank                                                         := sum(group, if(pBase_AZ.fname                                                              <> ''  ,1,0));
			unsigned8 mname_CountNonBlank                                                         := sum(group, if(pBase_AZ.mname                                                              <> ''  ,1,0));
			unsigned8 lname_CountNonBlank                                                         := sum(group, if(pBase_AZ.lname                                                              <> ''  ,1,0));
			unsigned8 name_suffix_CountNonBlank                                                   := sum(group, if(pBase_AZ.name_suffix                                                        <> ''  ,1,0));
			unsigned8 name_score_CountNonBlank                                                    := sum(group, if(pBase_AZ.name_score                                                         <> ''  ,1,0));
			unsigned8 dob_CountNonBlank                                                           := sum(group, if(pBase_AZ.dob                                                                <> ''  ,1,0));
			unsigned8 prim_range_CountNonBlank                                                    := sum(group, if(pBase_AZ.prim_range                                                         <> ''  ,1,0));
			unsigned8 predir_CountNonBlank                                                        := sum(group, if(pBase_AZ.predir                                                             <> ''  ,1,0));
			unsigned8 prim_name_CountNonBlank                                                     := sum(group, if(pBase_AZ.prim_name                                                          <> ''  ,1,0));
			unsigned8 addr_suffix_CountNonBlank                                                   := sum(group, if(pBase_AZ.addr_suffix                                                        <> ''  ,1,0));
			unsigned8 postdir_CountNonBlank                                                       := sum(group, if(pBase_AZ.postdir                                                            <> ''  ,1,0));
			unsigned8 unit_desig_CountNonBlank                                                    := sum(group, if(pBase_AZ.unit_desig                                                         <> ''  ,1,0));
			unsigned8 sec_range_CountNonBlank                                                     := sum(group, if(pBase_AZ.sec_range                                                          <> ''  ,1,0));
			unsigned8 p_city_name_CountNonBlank                                                   := sum(group, if(pBase_AZ.p_city_name                                                        <> ''  ,1,0));
			unsigned8 v_city_name_CountNonBlank                                                   := sum(group, if(pBase_AZ.v_city_name                                                        <> ''  ,1,0));
			unsigned8 st_CountNonBlank                                                            := sum(group, if(pBase_AZ.st                                                                 <> ''  ,1,0));
			unsigned8 zip_CountNonBlank                                                           := sum(group, if(pBase_AZ.zip                                                                <> ''  ,1,0));
			unsigned8 zip4_CountNonBlank                                                          := sum(group, if(pBase_AZ.zip4                                                               <> ''  ,1,0));
			unsigned8 cart_CountNonBlank                                                          := sum(group, if(pBase_AZ.cart                                                               <> ''  ,1,0));
			unsigned8 cr_sort_sz_CountNonBlank                                                    := sum(group, if(pBase_AZ.cr_sort_sz                                                         <> ''  ,1,0));
			unsigned8 lot_CountNonBlank                                                           := sum(group, if(pBase_AZ.lot                                                                <> ''  ,1,0));
			unsigned8 lot_order_CountNonBlank                                                     := sum(group, if(pBase_AZ.lot_order                                                          <> ''  ,1,0));
			unsigned8 dbpc_CountNonBlank                                                          := sum(group, if(pBase_AZ.dbpc                                                               <> ''  ,1,0));
			unsigned8 chk_digit_CountNonBlank                                                     := sum(group, if(pBase_AZ.chk_digit                                                          <> ''  ,1,0));
			unsigned8 rec_type_CountNonBlank                                                      := sum(group, if(pBase_AZ.rec_type                                                           <> ''  ,1,0));
			unsigned8 fips_state_CountNonBlank                                                    := sum(group, if(pBase_AZ.fips_state                                                         <> ''  ,1,0));
			unsigned8 fips_county_CountNonBlank                                                   := sum(group, if(pBase_AZ.fips_county                                                        <> ''  ,1,0));
			unsigned8 geo_lat_CountNonBlank                                                       := sum(group, if(pBase_AZ.geo_lat                                                            <> ''  ,1,0));
			unsigned8 geo_long_CountNonBlank                                                      := sum(group, if(pBase_AZ.geo_long                                                           <> ''  ,1,0));
			unsigned8 msa_CountNonBlank                                                           := sum(group, if(pBase_AZ.msa                                                                <> ''  ,1,0));
			unsigned8 geo_blk_CountNonBlank                                                       := sum(group, if(pBase_AZ.geo_blk                                                            <> ''  ,1,0));
			unsigned8 geo_match_CountNonBlank                                                     := sum(group, if(pBase_AZ.geo_match                                                          <> ''  ,1,0));
			unsigned8 err_stat_CountNonBlank                                                      := sum(group, if(pBase_AZ.err_stat                                                           <> ''  ,1,0));
			unsigned8 best_person_info_phone_CountNonBlank                                        := sum(group, if(pBase_AZ.best_person_info.phone                                             <> ''  ,1,0));
			unsigned8 best_person_info_dob_CountNonZero                                           := sum(group, if(pBase_AZ.best_person_info.dob                                               <> 0   ,1,0));
			unsigned8 best_person_info_prim_range_CountNonBlank                                   := sum(group, if(pBase_AZ.best_person_info.prim_range                                        <> ''  ,1,0));
			unsigned8 best_person_info_predir_CountNonBlank                                       := sum(group, if(pBase_AZ.best_person_info.predir                                            <> ''  ,1,0));
			unsigned8 best_person_info_prim_name_CountNonBlank                                    := sum(group, if(pBase_AZ.best_person_info.prim_name                                         <> ''  ,1,0));
			unsigned8 best_person_info_suffix_CountNonBlank                                       := sum(group, if(pBase_AZ.best_person_info.suffix                                            <> ''  ,1,0));
			unsigned8 best_person_info_postdir_CountNonBlank                                      := sum(group, if(pBase_AZ.best_person_info.postdir                                           <> ''  ,1,0));
			unsigned8 best_person_info_unit_desig_CountNonBlank                                   := sum(group, if(pBase_AZ.best_person_info.unit_desig                                        <> ''  ,1,0));
			unsigned8 best_person_info_sec_range_CountNonBlank                                    := sum(group, if(pBase_AZ.best_person_info.sec_range                                         <> ''  ,1,0));
			unsigned8 best_person_info_city_name_CountNonBlank                                    := sum(group, if(pBase_AZ.best_person_info.city_name                                         <> ''  ,1,0));
			unsigned8 best_person_info_st_CountNonBlank                                           := sum(group, if(pBase_AZ.best_person_info.st                                                <> ''  ,1,0));
			unsigned8 best_person_info_zip_CountNonBlank                                          := sum(group, if(pBase_AZ.best_person_info.zip                                               <> ''  ,1,0));
			unsigned8 best_person_info_zip4_CountNonBlank                                         := sum(group, if(pBase_AZ.best_person_info.zip4                                              <> ''  ,1,0));
			unsigned8 best_person_info_addr_dt_last_seen_CountNonZero                             := sum(group, if(pBase_AZ.best_person_info.addr_dt_last_seen                                 <> 0   ,1,0));
			unsigned8 best_person_info_DOD_CountNonBlank                                          := sum(group, if(pBase_AZ.best_person_info.DOD                                               <> ''  ,1,0));
			unsigned8 best_business_info_dt_last_seen_CountNonZero                                := sum(group, if(pBase_AZ.best_business_info.dt_last_seen                                    <> 0   ,1,0));
			unsigned8 best_business_info_company_name_CountNonBlank                               := sum(group, if(pBase_AZ.best_business_info.company_name                                    <> ''  ,1,0));
			unsigned8 best_business_info_prim_range_CountNonBlank                                 := sum(group, if(pBase_AZ.best_business_info.prim_range                                      <> ''  ,1,0));
			unsigned8 best_business_info_predir_CountNonBlank                                     := sum(group, if(pBase_AZ.best_business_info.predir                                          <> ''  ,1,0));
			unsigned8 best_business_info_prim_name_CountNonBlank                                  := sum(group, if(pBase_AZ.best_business_info.prim_name                                       <> ''  ,1,0));
			unsigned8 best_business_info_addr_suffix_CountNonBlank                                := sum(group, if(pBase_AZ.best_business_info.addr_suffix                                     <> ''  ,1,0));
			unsigned8 best_business_info_postdir_CountNonBlank                                    := sum(group, if(pBase_AZ.best_business_info.postdir                                         <> ''  ,1,0));
			unsigned8 best_business_info_unit_desig_CountNonBlank                                 := sum(group, if(pBase_AZ.best_business_info.unit_desig                                      <> ''  ,1,0));
			unsigned8 best_business_info_sec_range_CountNonBlank                                  := sum(group, if(pBase_AZ.best_business_info.sec_range                                       <> ''  ,1,0));
			unsigned8 best_business_info_city_CountNonBlank                                       := sum(group, if(pBase_AZ.best_business_info.city                                            <> ''  ,1,0));
			unsigned8 best_business_info_state_CountNonBlank                                      := sum(group, if(pBase_AZ.best_business_info.state                                           <> ''  ,1,0));
			unsigned8 best_business_info_zip_CountNonZero                                         := sum(group, if(pBase_AZ.best_business_info.zip                                             <> 0   ,1,0));
			unsigned8 best_business_info_zip4_CountNonZero                                        := sum(group, if(pBase_AZ.best_business_info.zip4                                            <> 0   ,1,0));
			unsigned8 best_business_info_phone_CountNonZero                                       := sum(group, if(pBase_AZ.best_business_info.phone                                           <> 0   ,1,0));
		end;                          
		pBase_AZ_stat := table(pBase_AZ, Layout_pBase_AZ_stat, rawfields.state  , few);
		strata.createXMLStats(pBase_AZ_stat, 'MartinDale_Hubble_AZ', 'base', pversion, _control.myinfo.emailaddressnotify, base_stat_AZ, 'View', 'Population');

		export all :=
		parallel(

			 Base_stat_AK
			,Base_stat_AL
			,Base_stat_AR
			,Base_stat_AZ
		
		);

	end;

	export all :=
	parallel(
	
		 sprayed.all
		,base.all
	
	);
end;