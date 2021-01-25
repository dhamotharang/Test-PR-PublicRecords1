EXPORT Out_STRATA_Population_Stats_Monthly(
																			 pCarrRef				// Carrier Reference File
																			,pVersion       // Version of Strat Stats
																			,zOut)          // Output of Population Stats
:= MACRO
 
import Strata, PhonesInfo, ut;

	//Carrier Reference File Population Stats	
	#uniquename(rPopulationStats_pCarrRef);
	#uniquename(dPopulationStats_pCarrRef);
	#uniquename(zRunCarrRefStats);
	%rPopulationStats_pCarrRef% := record
			countGroup                           		:= count(group);
			pCarrRef.serv;
			pCarrRef.line;
			dt_first_reported_CountNonBlank 				:= sum(group, if(pCarrRef.dt_first_reported<>'',1,0));
			dt_last_reported_CountNonBlank 					:= sum(group, if(pCarrRef.dt_last_reported<>'',1,0));
			dt_start_CountNonBlank 									:= sum(group, if(pCarrRef.dt_start<>'',1,0));
			dt_end_CountNonBlank 										:= sum(group, if(pCarrRef.dt_end<>'',1,0));
			ocn_CountNonBlank 											:= sum(group, if(pCarrRef.ocn<>'',1,0));
			carrier_name_CountNonBlank 							:= sum(group, if(pCarrRef.carrier_name<>'',1,0));
			name_CountNonBlank 											:= sum(group, if(pCarrRef.name<>'',1,0));
			prepaid_CountNonBlank 									:= sum(group, if(pCarrRef.prepaid<>'',1,0));
			high_risk_indicator_CountNonBlank 			:= sum(group, if(pCarrRef.high_risk_indicator<>'',1,0));
			activation_dt_CountNonZero 							:= sum(group, if(pCarrRef.activation_dt<>0,1,0));
			number_in_service_CountNonBlank 				:= sum(group, if(pCarrRef.number_in_service<>'',1,0));
			spid_CountNonBlank 											:= sum(group, if(pCarrRef.spid<>'',1,0));
			operator_full_name_CountNonBlank 				:= sum(group, if(pCarrRef.operator_full_name<>'',1,0));
			is_current_CountNonFalse								:= sum(group, if(pCarrRef.is_current<>FALSE,1,0));
			override_file_CountNonBlank  := sum(group, if(pCarrRef.override_file<>'',1,0));
			data_type_CountNonBlank  := sum(group, if(pCarrRef.data_type<>'',1,0));
			ocn_state_CountNonBlank  := sum(group, if(pCarrRef.ocn_state<>'',1,0));
			overall_ocn_CountNonBlank  := sum(group, if(pCarrRef.overall_ocn<>'',1,0));
			target_ocn_CountNonBlank  := sum(group, if(pCarrRef.target_ocn<>'',1,0));
			overall_target_ocn_CountNonBlank  := sum(group, if(pCarrRef.overall_target_ocn<>'',1,0));
			ocn_abbr_name_CountNonBlank  := sum(group, if(pCarrRef.ocn_abbr_name<>'',1,0));
			rural_lec_indicator_CountNonBlank  := sum(group, if(pCarrRef.rural_lec_indicator<>'',1,0));
			small_ilec_indicator_CountNonBlank  := sum(group, if(pCarrRef.small_ilec_indicator<>'',1,0));
			category_CountNonBlank  := sum(group, if(pCarrRef.category<>'',1,0));
			carrier_address1_CountNonBlank  := sum(group, if(pCarrRef.carrier_address1<>'',1,0));
			carrier_address2_CountNonBlank  := sum(group, if(pCarrRef.carrier_address2<>'',1,0));
			carrier_floor_CountNonBlank  := sum(group, if(pCarrRef.carrier_floor<>'',1,0));
			carrier_room_CountNonBlank  := sum(group, if(pCarrRef.carrier_room<>'',1,0));
			carrier_city_CountNonBlank  := sum(group, if(pCarrRef.carrier_city<>'',1,0));
			carrier_state_CountNonBlank  := sum(group, if(pCarrRef.carrier_state<>'',1,0));
			carrier_zip_CountNonBlank  := sum(group, if(pCarrRef.carrier_zip<>'',1,0));
			carrier_phone_CountNonBlank  := sum(group, if(pCarrRef.carrier_phone<>'',1,0));
			affiliated_to_CountNonBlank  := sum(group, if(pCarrRef.affiliated_to<>'',1,0));
			overall_company_CountNonBlank  := sum(group, if(pCarrRef.overall_company<>'',1,0));
			contact_function_CountNonBlank  := sum(group, if(pCarrRef.contact_function<>'',1,0));
			contact_name_CountNonBlank  := sum(group, if(pCarrRef.contact_name<>'',1,0));
			contact_title_CountNonBlank  := sum(group, if(pCarrRef.contact_title<>'',1,0));
			contact_address1_CountNonBlank  := sum(group, if(pCarrRef.contact_address1<>'',1,0));
			contact_address2_CountNonBlank  := sum(group, if(pCarrRef.contact_address2<>'',1,0));
			contact_city_CountNonBlank  := sum(group, if(pCarrRef.contact_city<>'',1,0));
			contact_state_CountNonBlank  := sum(group, if(pCarrRef.contact_state<>'',1,0));
			contact_zip_CountNonBlank  := sum(group, if(pCarrRef.contact_zip<>'',1,0));
			contact_phone_CountNonBlank  := sum(group, if(pCarrRef.contact_phone<>'',1,0));
			contact_fax_CountNonBlank  := sum(group, if(pCarrRef.contact_fax<>'',1,0));
			contact_email_CountNonBlank  := sum(group, if(pCarrRef.contact_email<>'',1,0));
			contact_information_CountNonBlank  := sum(group, if(pCarrRef.contact_information<>'',1,0));
			prim_range_CountNonBlank  := sum(group, if(pCarrRef.prim_range<>'',1,0));
			predir_CountNonBlank  := sum(group, if(pCarrRef.predir<>'',1,0));
			prim_name_CountNonBlank  := sum(group, if(pCarrRef.prim_name<>'',1,0));
			addr_suffix_CountNonBlank  := sum(group, if(pCarrRef.addr_suffix<>'',1,0));
			postdir_CountNonBlank  := sum(group, if(pCarrRef.postdir<>'',1,0));
			unit_desig_CountNonBlank  := sum(group, if(pCarrRef.unit_desig<>'',1,0));
			sec_range_CountNonBlank  := sum(group, if(pCarrRef.sec_range<>'',1,0));
			p_city_name_CountNonBlank  := sum(group, if(pCarrRef.p_city_name<>'',1,0));
			v_city_name_CountNonBlank  := sum(group, if(pCarrRef.v_city_name<>'',1,0));
			st_CountNonBlank  := sum(group, if(pCarrRef.st<>'',1,0));
			z5_CountNonBlank  := sum(group, if(pCarrRef.z5<>'',1,0));
			zip4_CountNonBlank  := sum(group, if(pCarrRef.zip4<>'',1,0));
			cart_CountNonBlank  := sum(group, if(pCarrRef.cart<>'',1,0));
			cr_sort_sz_CountNonBlank  := sum(group, if(pCarrRef.cr_sort_sz<>'',1,0));
			lot_CountNonBlank  := sum(group, if(pCarrRef.lot<>'',1,0));
			lot_order_CountNonBlank  := sum(group, if(pCarrRef.lot_order<>'',1,0));
			dpbc_CountNonBlank  := sum(group, if(pCarrRef.dpbc<>'',1,0));
			chk_digit_CountNonBlank  := sum(group, if(pCarrRef.chk_digit<>'',1,0));
			rec_type_CountNonBlank  := sum(group, if(pCarrRef.rec_type<>'',1,0));
			ace_fips_st_CountNonBlank  := sum(group, if(pCarrRef.ace_fips_st<>'',1,0));
			fips_county_CountNonBlank  := sum(group, if(pCarrRef.fips_county<>'',1,0));
			geo_lat_CountNonBlank  := sum(group, if(pCarrRef.geo_lat<>'',1,0));
			geo_long_CountNonBlank  := sum(group, if(pCarrRef.geo_long<>'',1,0));
			msa_CountNonBlank  := sum(group, if(pCarrRef.msa<>'',1,0));
			geo_blk_CountNonBlank  := sum(group, if(pCarrRef.geo_blk<>'',1,0));
			geo_match_CountNonBlank  := sum(group, if(pCarrRef.geo_match<>'',1,0));
			err_stat_CountNonBlank  := sum(group, if(pCarrRef.err_stat<>'',1,0));
			append_rawaid_CountNonZero  := sum(group, if(pCarrRef.append_rawaid<>0,1,0));
			address_type_CountNonBlank  := sum(group, if(pCarrRef.address_type<>'',1,0));
			privacy_indicator_CountNonBlank  := sum(group, if(pCarrRef.privacy_indicator<>'',1,0));
		end;
	 
	%dPopulationStats_pCarrRef% := table(pCarrRef, %rPopulationStats_pCarrRef%, serv, line, few);
	strata.createXMLStats(%dPopulationStats_pCarrRef%, 'PhonesMetadata', 'CarrierReference2', pVersion, '', %zRunCarrRefStats%);

	zOut := parallel(%zRunCarrRefStats%);

ENDMACRO;