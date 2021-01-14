EXPORT Out_STRATA_Population_Stats (//pTCPAPort    		// TCPA Daily Port File
																			 piConectPort   // iConectiv Daily Port File
																			,piConectPortDataValidate //iConectiv PortData Validate File 
																			,pLIDB					// LIDB File
																			,pGHDisc 				//Gong History Disconnect Daily File
																			,pDisc					// Disconnect Daily File
																			,pPhonesMeta 		// PhonesMetadata File	
																			,pVersion       // Version of Strat Stats
																			,zOut)          // Output of Population Stats
:= MACRO
 
import Strata, PhonesInfo, ut;

	//#uniquename(rPopulationStats_pTCPAPort);
	//#uniquename(dPopulationStats_pTCPAPort);
	//#uniquename(zRunTCPAPortStats);
	
	#uniquename(rPopulationStats_piConectPort);
	#uniquename(dPopulationStats_piConectPort);
	#uniquename(zRuniConectPortStats);
	
	#uniquename(rPopulationStats_piConectPortDataValidate);
	#uniquename(dPopulationStats_piConectPortDataValidate);
	#uniquename(zRuniConectPortDataValidateStats);	
	
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
	
	/*
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
	*/
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
	
	//iConectiv Phones PortData Validate Ported File Population Stats
		%rPopulationStats_piConectPortDataValidate% := record
		  string3 grouping												:= 'ALL';																
			countGroup                           		:= count(group);	
			country_code_CountNonBlank 							:= sum(group, if(piConectPortDataValidate.country_code<>'', 1, 0));
			phone_CountNonBlank 										:= sum(group, if(piConectPortDataValidate.phone<>'', 1, 0));
			dial_type_CountNonBlank 								:= sum(group, if(piConectPortDataValidate.dial_type<>'', 1, 0));
			spid_CountNonBlank 											:= sum(group, if(piConectPortDataValidate.spid<>'', 1, 0));
			service_provider_CountNonBlank 					:= sum(group, if(piConectPortDataValidate.service_provider<>'', 1, 0));
			service_type_CountNonBlank 							:= sum(group, if(piConectPortDataValidate.service_type<>'', 1, 0));
			alt_spid_CountNonBlank 									:= sum(group, if(piConectPortDataValidate.alt_spid<>'', 1, 0));
			alt_service_provider_CountNonBlank 			:= sum(group, if(piConectPortDataValidate.alt_service_provider<>'', 1, 0));
			lalt_spid_CountNonBlank 								:= sum(group, if(piConectPortDataValidate.lalt_spid<>'', 1, 0));	
			lalt_service_provider_CountNonBlank 		:= sum(group, if(piConectPortDataValidate.lalt_service_provider<>'', 1, 0));
			line_type_CountNonBlank 								:= sum(group, if(piConectPortDataValidate.line_type<>'', 1, 0));
			routing_code_CountNonBlank 							:= sum(group, if(piConectPortDataValidate.routing_code<>'', 1, 0));
			porting_dt_CountNonBlank 								:= sum(group, if(piConectPortDataValidate.porting_dt<>'', 1, 0));
			country_abbr_CountNonBlank 							:= sum(group, if(piConectPortDataValidate.country_abbr<>'', 1, 0));
			filename_CountNonBlank 									:= sum(group, if(piConectPortDataValidate.filename<>'', 1, 0));
			file_dt_time_CountNonBlank 							:= sum(group, if(piConectPortDataValidate.file_dt_time<>'', 1, 0));
			vendor_first_reported_dt_CountNonBlank 	:= sum(group, if(piConectPortDataValidate.vendor_first_reported_dt<>'', 1, 0));
			vendor_last_reported_dt_CountNonBlank 	:= sum(group, if(piConectPortDataValidate.vendor_last_reported_dt<>'', 1, 0));
			port_start_dt_CountNonBlank 						:= sum(group, if(piConectPortDataValidate.port_start_dt<>'', 1, 0));
			port_end_dt_CountNonBlank 							:= sum(group, if(piConectPortDataValidate.port_end_dt<>'', 1, 0));
			remove_port_dt_CountNonBlank 						:= sum(group, if(piConectPortDataValidate.remove_port_dt<>'', 1, 0));
			is_ported_CountNonFalse 								:= sum(group, if(piConectPortDataValidate.is_ported<>FALSE, 1, 0));
		end;

	%dPopulationStats_piConectPortDataValidate% := table(piConectPortDataValidate, %rPopulationStats_piConectPortDataValidate%, few);
	strata.createXMLStats(%dPopulationStats_piConectPortDataValidate%,'PhonesMetadata', 'iConectivPortDataValidatePortedPhones', pVersion, '', %zRuniConectPortDataValidateStats%);
	
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

	zOut := parallel(/*%zRunTCPAPortStats%,*/ %zRuniConectPortStats%, %zRuniConectPortDataValidateStats%, %zRunLIDBStats%, %zRunDisconnectStats%, %zRunGHDisconnectStats%, %zRunPhoneMetadataStats%);

ENDMACRO;