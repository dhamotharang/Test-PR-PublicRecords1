EXPORT Out_STRATA_Population_Stats (pTCPAPort    			// TCPA Daily Port File
																			,piConectPort   // iConectiv Daily Port File
																			,pLIDB					// LIDB File
																			,pGHDisc 	//Gong History Disconnect Daily File
																			,pDisc		// Disconnect Daily File
																			,pPhonesMeta 		// PhonesMetadata File	
																			,pCarrRef				// Carrier Reference File
																			,pVersion       // Version of Strat Stats
																			,zOut)          // Output of Population Stats
:= MACRO
 
import Strata, PhonesInfo, ut;

	#uniquename(rPopulationStats_pTCPAPort);
	#uniquename(dPopulationStats_pTCPAPort);
	#uniquename(zRunTCPAPortStats);
	
	#uniquename(rPopulationStats_piConectPort);
	#uniquename(dPopulationStats_piConectPort);
	#uniquename(zRuniConectPortStats);
	
	#uniquename(rPopulationStats_pLIDB);
	#uniquename(dPopulationStats_pLIDB);
	#uniquename(zRunLIDBStats);
	
	#uniquename(rPopulationStats_piDisconnect);
	#uniquename(dPopulationStats_piDisconnect);
	#uniquename(zRunDisconnectStats);
	
	#uniquename(dPopulationStats_pGHDisc);
	#uniquename(zRunGHDisconnectStats);

	#uniquename(rPopulationStats_pPhonesMeta);
	#uniquename(dPopulationStats_pPhonesMeta);
	#uniquename(zRunPhoneMetadataStats);
	
	#uniquename(rPopulationStats_pCarrRef);
	#uniquename(dPopulationStats_pCarrRef);
	#uniquename(zRunCarrRefStats);
	
	//TCPA Phones Ported File Population Stats
		%rPopulationStats_pTCPAPort% := record
		  countGroup														:= count(group);
			pTCPAPort.phonetype;
			phone_CountNonBlank 									:= sum(group, if(pTCPAPort.phone<>'', 1, 0));
			is_ported_CountNonFALSE 							:= sum(group, if(pTCPAPort.is_ported<>FALSE, 1, 0));
			vendor_first_reported_dt_CountNonZero := sum(group, if(pTCPAPort.vendor_first_reported_dt<>0, 1, 0));
			vendor_last_reported_dt_CountNonZero 	:= sum(group, if(pTCPAPort.vendor_last_reported_dt<>0, 1, 0));
			port_start_dt_CountNonZero 						:= sum(group, if(pTCPAPort.port_start_dt<>0, 1, 0));
			port_end_dt_CountNonZero 							:= sum(group, if(pTCPAPort.port_end_dt<>0, 1, 0));
		end;
		
	%dPopulationStats_pTCPAPort% := table(pTCPAPort, %rPopulationStats_pTCPAPort%, phonetype, few);
	strata.createXMLStats(%dPopulationStats_pTCPAPort%,'PhonesMetadata', 'TCPAPortedPhones', pVersion, '', %zRunTCPAPortStats%);
	
	//iConectiv Phones Ported File Population Stats
		%rPopulationStats_piConectPort% := record
		  string3 grouping												:= 'ALL';																
			countGroup                           		:= count(group);	
			country_code_CountNonBlank 							:= sum(group, if(piConectPort.country_code<>'', 1, 0));
			phone_CountNonBlank 										:= sum(group, if(piConectPort.phone<>'', 1, 0));
			dial_type_CountNonBlank 								:= sum(group, if(piConectPort.dial_type<>'', 1, 0));
			spid_CountNonBlank 											:= sum(group, if(piConectPort.spid<>'', 1, 0));
			service_provider_CountNonBlank 					:= sum(group, if(piConectPort.service_provider<>'', 1, 0));
			service_type_CountNonBlank 							:= sum(group, if(piConectPort.service_type<>'', 1, 0));
			routing_code_CountNonBlank 							:= sum(group, if(piConectPort.routing_code<>'', 1, 0));
			porting_dt_CountNonBlank 								:= sum(group, if(piConectPort.porting_dt<>'', 1, 0));
			country_abbr_CountNonBlank 							:= sum(group, if(piConectPort.country_abbr<>'', 1, 0));
			filename_CountNonBlank 									:= sum(group, if(piConectPort.filename<>'', 1, 0));
			file_dt_time_CountNonBlank 							:= sum(group, if(piConectPort.file_dt_time<>'', 1, 0));
			vendor_first_reported_dt_CountNonBlank 	:= sum(group, if(piConectPort.vendor_first_reported_dt<>'', 1, 0));
			vendor_last_reported_dt_CountNonBlank 	:= sum(group, if(piConectPort.vendor_last_reported_dt<>'', 1, 0));
			port_start_dt_CountNonBlank 						:= sum(group, if(piConectPort.port_start_dt<>'', 1, 0));
			port_end_dt_CountNonBlank 							:= sum(group, if(piConectPort.port_end_dt<>'', 1, 0));
			remove_port_dt_CountNonBlank 						:= sum(group, if(piConectPort.remove_port_dt<>'', 1, 0));
			is_ported_CountNonFalse 								:= sum(group, if(piConectPort.is_ported<>FALSE, 1, 0));
		end;

	%dPopulationStats_piConectPort% := table(piConectPort, %rPopulationStats_piConectPort%, few);
	strata.createXMLStats(%dPopulationStats_piConectPort%,'PhonesMetadata', 'iConectivPortedPhones', pVersion, '', %zRuniConectPortStats%);
	
	//LIDB File Population Stats
		%rPopulationStats_pLIDB% := record															
			countGroup                           		:= count(group);
			pLIDB.carrier_category;
			reference_id_CountNonBlank 							:= sum(group, if(pLIDB.reference_id<>'', 1, 0));
			dt_first_reported_CountNonZero 					:= sum(group, if(pLIDB.dt_first_reported<>0, 1, 0));
			dt_last_reported_CountNonZero 					:= sum(group, if(pLIDB.dt_last_reported<>0, 1, 0));
			phone_CountNonBlank 										:= sum(group, if(pLIDB.phone<>'', 1, 0));
			reply_code_CountNonBlank 								:= sum(group, if(pLIDB.reply_code<>'', 1, 0));
			local_routing_number_CountNonBlank 			:= sum(group, if(pLIDB.local_routing_number<>'', 1, 0));
			account_owner_CountNonBlank 						:= sum(group, if(pLIDB.account_owner<>'', 1, 0));
			carrier_name_CountNonBlank 							:= sum(group, if(pLIDB.carrier_name<>'', 1, 0));
			local_area_transport_area_CountNonBlank := sum(group, if(pLIDB.local_area_transport_area<>'', 1, 0));
			point_code_CountNonBlank 								:= sum(group, if(pLIDB.point_code<>'', 1, 0));
			serv_CountNonBlank 											:= sum(group, if(pLIDB.serv<>'', 1, 0));
			line_CountNonBlank 											:= sum(group, if(pLIDB.line<>'', 1, 0));
			spid_CountNonBlank 											:= sum(group, if(pLIDB.spid<>'', 1, 0));
			operator_fullname_CountNonBlank 				:= sum(group, if(pLIDB.operator_fullname<>'', 1, 0));
			activation_dt_CountNonZero 							:= sum(group, if(pLIDB.activation_dt<>0, 1, 0));
			number_in_service_CountNonBlank 				:= sum(group, if(pLIDB.number_in_service<>'', 1, 0));
			high_risk_indicator_CountNonBlank 			:= sum(group, if(pLIDB.high_risk_indicator<>'', 1, 0));
			prepaid_CountNonBlank 									:= sum(group, if(pLIDB.prepaid<>'', 1, 0));
		end;

	%dPopulationStats_pLIDB% := table(pLIDB, %rPopulationStats_pLIDB%, carrier_category, few);
	strata.createXMLStats(%dPopulationStats_pLIDB%,'PhonesMetadata', 'LIDBPhones', pVersion, '', %zRunLIDBStats%);
	
	//Disconnect File Population Stats
		pDisc fTr(pDisc l):= transform
			self.carrier_name := if(trim(l.carrier_name, left, right)='', 'BLANK', PhonesInfo._Functions.fn_carrierName(l.carrier_name));
			self := l; 
		end;
		
		pDisconnect := project(pDisc, fTr(left));
		
		%rPopulationStats_piDisconnect% := record												
			countGroup                           		:= count(group);
			pDisconnect.carrier_name;
			vendor_first_reported_dt_CountNonZero 	:= sum(group, if(pDisconnect.vendor_first_reported_dt<>0, 1, 0));
			vendor_last_reported_dt_CountNonZero 		:= sum(group, if(pDisconnect.vendor_last_reported_dt<>0, 1, 0));
			action_code_CountNonBlank 							:= sum(group, if(pDisconnect.action_code<>'', 1, 0));
			timestamp_CountNonBlank 								:= sum(group, if(pDisconnect.timestamp<>'', 1, 0));
			phone_CountNonBlank 										:= sum(group, if(pDisconnect.phone<>'', 1, 0));
			phone_swap_CountNonBlank 								:= sum(group, if(pDisconnect.phone_swap<>'', 1, 0));
			filename_CountNonBlank 									:= sum(group, if(pDisconnect.filename<>'', 1, 0));
			filedate_CountNonBlank 									:= sum(group, if(pDisconnect.filedate<>'', 1, 0));
			swap_start_dt_CountNonZero 							:= sum(group, if(pDisconnect.swap_start_dt<>0, 1, 0));
			swap_end_dt_CountNonZero 								:= sum(group, if(pDisconnect.swap_end_dt<>0, 1, 0));
			deact_code_CountNonBlank 								:= sum(group, if(pDisconnect.deact_code<>'', 1, 0));
			deact_start_dt_CountNonZero 						:= sum(group, if(pDisconnect.deact_start_dt<>0, 1, 0));
			deact_end_dt_CountNonZero 							:= sum(group, if(pDisconnect.deact_end_dt<>0, 1, 0));
			react_start_dt_CountNonZero 						:= sum(group, if(pDisconnect.react_start_dt<>0, 1, 0));
			react_end_dt_CountNonZero 							:= sum(group, if(pDisconnect.react_end_dt<>0, 1, 0));
			is_react_CountNonNP 										:= sum(group, if(pDisconnect.is_react not in ['N','P'], 1, 0));
			is_deact_CountNonNP 										:= sum(group, if(pDisconnect.is_deact not in ['N','P'], 1, 0));
			porting_dt_CountNonZero 								:= sum(group, if(pDisconnect.porting_dt<>0, 1, 0));
		end;

	%dPopulationStats_piDisconnect% := table(pDisconnect, %rPopulationStats_piDisconnect%, carrier_name, few);
	strata.createXMLStats(%dPopulationStats_piDisconnect%,'PhonesMetadata', 'Disconnect2Phones', pVersion, '', %zRunDisconnectStats%);	

	//Gong History Disconnect File Population Stats	
	%dPopulationStats_pGHDisc% := strata.macf_pops(pGHDisc,
																																																		'is_deact',//group by
																																																		,
																																																		,
																																																		,
																																																		,
																																																		TRUE,
																																																		['groupid','phone_swap','carrier_name','swap_start_dt','swap_end_dt','is_deact','is_react','pk_carrier_name','days_apart']);	// remove these fields from population stats
																												
	strata.createXMLStats(%dPopulationStats_pGHDisc%, 'PhonesMetadata', 'GHDisconnect2Phones', pVersion, 'Population', %zRunGHDisconnectStats%);
	
	//PhonesMetadata File Population Stats
		%rPopulationStats_pPhonesMeta% := record
			countGroup                           		:= count(group);
			pPhonesMeta.source;
			reference_id_CountNonBlank 							:= sum(group, if(pPhonesMeta.reference_id<>'', 1, 0));
			source_CountNonBlank 										:= sum(group, if(pPhonesMeta.source<>'', 1, 0));
			dt_first_reported_CountNonZero 					:= sum(group, if(pPhonesMeta.dt_first_reported<>0, 1, 0));
			dt_last_reported_CountNonZero 					:= sum(group, if(pPhonesMeta.dt_last_reported<>0, 1, 0));
			phone_CountNonBlank 										:= sum(group, if(pPhonesMeta.phone<>'', 1, 0));
			phonetype_CountNonBlank 								:= sum(group, if(pPhonesMeta.phonetype<>'', 1, 0));
			reply_code_CountNonBlank 								:= sum(group, if(pPhonesMeta.reply_code<>'', 1, 0));
			local_routing_number_CountNonBlank 			:= sum(group, if(pPhonesMeta.local_routing_number<>'', 1, 0));
			account_owner_CountNonBlank 						:= sum(group, if(pPhonesMeta.account_owner<>'', 1, 0));
			carrier_name_CountNonBlank 							:= sum(group, if(pPhonesMeta.carrier_name<>'', 1, 0));
			carrier_category_CountNonBlank 					:= sum(group, if(pPhonesMeta.carrier_category<>'', 1, 0));
			local_area_transport_area_CountNonBlank := sum(group, if(pPhonesMeta.local_area_transport_area<>'', 1, 0));
			point_code_CountNonBlank 								:= sum(group, if(pPhonesMeta.point_code<>'', 1, 0));
			country_code_CountNonBlank 							:= sum(group, if(pPhonesMeta.country_code<>'', 1, 0));
			dial_type_CountNonBlank 								:= sum(group, if(pPhonesMeta.dial_type<>'', 1, 0));
			routing_code_CountNonBlank 							:= sum(group, if(pPhonesMeta.routing_code<>'', 1, 0));
			porting_dt_CountNonZero 								:= sum(group, if(pPhonesMeta.porting_dt<>0, 1, 0));
			porting_time_CountNonBlank 							:= sum(group, if(pPhonesMeta.porting_time<>'', 1, 0));
			country_abbr_CountNonBlank 							:= sum(group, if(pPhonesMeta.country_abbr<>'', 1, 0));
			vendor_first_reported_dt_CountNonZero 	:= sum(group, if(pPhonesMeta.vendor_first_reported_dt<>0, 1, 0));
			vendor_first_reported_time_CountNonBlank:= sum(group, if(pPhonesMeta.vendor_first_reported_time<>'', 1, 0));
			vendor_last_reported_dt_CountNonZero 		:= sum(group, if(pPhonesMeta.vendor_last_reported_dt<>0, 1, 0));
			vendor_last_reported_time_CountNonBlank := sum(group, if(pPhonesMeta.vendor_last_reported_time<>'', 1, 0));	
			port_start_dt_CountNonZero 							:= sum(group, if(pPhonesMeta.port_start_dt<>0, 1, 0));
			port_start_time_CountNonBlank 					:= sum(group, if(pPhonesMeta.port_start_time<>'', 1, 0));
			port_end_dt_CountNonZero 								:= sum(group, if(pPhonesMeta.port_end_dt<>0, 1, 0));
			port_end_time_CountNonBlank 						:= sum(group, if(pPhonesMeta.port_end_time<>'', 1, 0));
			remove_port_dt_CountNonZero 						:= sum(group, if(pPhonesMeta.remove_port_dt<>0, 1, 0));
			is_ported_CountNonFalse 								:= sum(group, if(pPhonesMeta.is_ported<>FALSE, 1, 0));
			serv_CountNonBlank 											:= sum(group, if(pPhonesMeta.serv<>'', 1, 0));
			line_CountNonBlank 											:= sum(group, if(pPhonesMeta.line<>'', 1, 0));
			spid_CountNonBlank 											:= sum(group, if(pPhonesMeta.spid<>'', 1, 0));
			operator_fullname_CountNonBlank 				:= sum(group, if(pPhonesMeta.operator_fullname<>'', 1, 0));
			number_in_service_CountNonBlank 				:= sum(group, if(pPhonesMeta.number_in_service<>'', 1, 0));
			high_risk_indicator_CountNonBlank 			:= sum(group, if(pPhonesMeta.high_risk_indicator<>'', 1, 0));
			prepaid_CountNonBlank 									:= sum(group, if(pPhonesMeta.prepaid<>'', 1, 0));
			phone_swap_CountNonBlank								:= sum(group, if(pPhonesMeta.phone_swap<>'', 1, 0));
			swap_start_dt_CountNonZero							:= sum(group, if(pPhonesMeta.swap_start_dt<>0, 1, 0));
			swap_start_time_CountNonBlank						:= sum(group, if(pPhonesMeta.swap_start_time<>'', 1, 0));
			swap_end_dt_CountNonZero								:= sum(group, if(pPhonesMeta.swap_end_dt<>0, 1, 0));
			swap_end_time_CountNonBlank							:= sum(group, if(pPhonesMeta.swap_end_time<>'', 1, 0));
			deact_code_CountNonBlank								:= sum(group, if(pPhonesMeta.deact_code<>'', 1, 0));
			deact_start_dt_CountNonZero							:= sum(group, if(pPhonesMeta.deact_start_dt<>0, 1, 0));
			deact_start_time_CountNonBlank					:= sum(group, if(pPhonesMeta.deact_start_time<>'', 1, 0));
			deact_end_dt_CountNonZero								:= sum(group, if(pPhonesMeta.deact_end_dt<>0, 1, 0));
			deact_end_time_CountNonBlank						:= sum(group, if(pPhonesMeta.deact_end_time<>'', 1, 0));
			react_start_dt_CountNonZero							:= sum(group, if(pPhonesMeta.react_start_dt<>0, 1, 0));
			react_start_time_CountNonBlank					:= sum(group, if(pPhonesMeta.react_start_time<>'', 1, 0));
			react_end_dt_CountNonZero								:= sum(group, if(pPhonesMeta.react_end_dt<>0, 1, 0));
			react_end_time_CountNonBlank						:= sum(group, if(pPhonesMeta.react_end_time<>'', 1, 0));
			is_deact_CountNonBlank 									:= sum(group, if(pPhonesMeta.is_deact<>'', 1, 0));
			is_react_CountNonBlank 									:= sum(group, if(pPhonesMeta.is_react<>'', 1, 0));
			call_forward_dt_CountNonZero 						:= sum(group, if(pPhonesMeta.call_forward_dt<>0, 1, 0));
			caller_id_CountNonBlank 								:= sum(group, if(pPhonesMeta.caller_id<>'', 1, 0));
		end;
			
	%dPopulationStats_pPhonesMeta% := table(pPhonesMeta, %rPopulationStats_pPhonesMeta%, source, few);
	strata.createXMLStats(%dPopulationStats_pPhonesMeta%, 'PhonesMetadata', 'PhonesMetadata2File', pVersion, '', %zRunPhoneMetadataStats%);

	//Carrier Reference File Population Stats	
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
	
	zOut := parallel(%zRunTCPAPortStats%, %zRuniConectPortStats%, %zRunLIDBStats%, %zRunDisconnectStats%, %zRunGHDisconnectStats%, %zRunPhoneMetadataStats%, %zRunCarrRefStats%);

ENDMACRO;