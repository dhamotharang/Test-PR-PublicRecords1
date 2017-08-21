export Mod_G2_Ip_Search := MODULE

	SHARED ds_srcdest_idx  := dolecki.Mod_G2_Ip_Data.IDX_srcdestip;
	SHARED ds_src_idx      := dolecki.Mod_G2_Ip_Data.IDX_srcip;
	SHARED ds_dest_idx     := dolecki.Mod_G2_Ip_Data.IDX_destip;
	SHARED ds_protocol_idx := dolecki.Mod_G2_Ip_Data.IDX_protocol;

	SHARED L_IP_Search_Results := dolecki.Mod_G2_Ip_Data.L_IP_Search_Results;
	
	SHARED STRING ip_pattern := '^(.*)\\.(.*)\\.(.*)\\.(.*)$';
	SHARED BOOLEAN isWild(STRING s) := s='' OR s='*';
	
	export L_IP_Search_Results F_search_srcip_destip(
			STRING srcip, 
			STRING destip, 
			INTEGER protocolId,
			INTEGER source_port, 
			INTEGER destination_port, 
			INTEGER num_sent_packets, 
			INTEGER num_rcv_packets) := FUNCTION
			
		STRING so1 := REGEXFIND(ip_pattern, srcip, 1);
		STRING so2 := REGEXFIND(ip_pattern, srcip, 2);
		STRING so3 := REGEXFIND(ip_pattern, srcip, 3);
		STRING so4 := REGEXFIND(ip_pattern, srcip, 4);
		
		STRING do1 := REGEXFIND(ip_pattern, destip, 1);
		STRING do2 := REGEXFIND(ip_pattern, destip, 2);
		STRING do3 := REGEXFIND(ip_pattern, destip, 3);
		STRING do4 := REGEXFIND(ip_pattern, destip, 4);

		ds_1 := IF(isWild(so1),	ds_srcdest_idx(srcip_octet1>=0 AND srcip_octet1<=255),ds_srcdest_idx(srcip_octet1 = (UNSIGNED)so1));
		ds_2 := IF(isWild(so2),	ds_1(srcip_octet2>=0 AND srcip_octet2<=255), ds_1(srcip_octet2 = (UNSIGNED)so2));
		ds_3 := IF(isWild(so3),	ds_2(srcip_octet3>=0 AND srcip_octet3<=255), ds_2(srcip_octet3 = (UNSIGNED)so3));
		ds_4 := IF(isWild(so4),	ds_3(srcip_octet4>=0 AND srcip_octet4<=255), ds_3(srcip_octet4 = (UNSIGNED)so4));

		ds_5 := IF(isWild(do1),	ds_4(destip_octet1>=0 AND destip_octet1<=255), ds_4(destip_octet1 = (UNSIGNED)do1));
		ds_6 := IF(isWild(do2),	ds_5(destip_octet2>=0 AND destip_octet2<=255), ds_5(destip_octet2 = (UNSIGNED)do2));
		ds_7 := IF(isWild(do3),	ds_6(destip_octet3>=0 AND destip_octet3<=255), ds_6(destip_octet3 = (UNSIGNED)do3));
		ds_8 := IF(isWild(do4),	ds_7(destip_octet4>=0 AND destip_octet4<=255), ds_7(destip_octet4 = (UNSIGNED)do4));

		ds_t9 := IF(protocolId>=0,	ds_8(protocol_id = protocolId), ds_8(protocol_id>=0 AND protocol_id<=255));

		ds_9 := IF(source_port>=0, ds_t9(srcport=source_port), ds_t9(srcport>=0));
		ds_10 := IF(destination_port>=0, ds_9(destport=destination_port), ds_9(destport>=0));

		ds_11 := IF(num_sent_packets>=0, ds_10(sent_packets=num_sent_packets), ds_10(sent_packets>=0));
		ds_12 := IF(num_rcv_packets>=0, ds_11(rcv_packets=num_rcv_packets), ds_11(rcv_packets>=0));

		L_IP_Search_Results create_result(ds_12 l) := TRANSFORM
			SELF.srcip  := l.srcip_octet1 + '.' + l.srcip_octet2 + '.' + l.srcip_octet3 + '.' + l.srcip_octet4;
			SELF.destip := l.destip_octet1 + '.' + l.destip_octet2 + '.' + l.destip_octet3 + '.' + l.destip_octet4;
			SELF.datetime := dolecki.format_date_ms_since_y2k(l.ms_start);
			SELF := l;
		END;
		
		return PROJECT(ds_12,create_result(LEFT));
	END;

	export L_IP_Search_Results F_search_srcip(
			STRING srcip, 
			INTEGER protocolId,
			INTEGER source_port, 
			INTEGER destination_port, 
			INTEGER num_sent_packets, 
			INTEGER num_rcv_packets) := FUNCTION
			
		STRING so1 := REGEXFIND(ip_pattern, srcip, 1);
		STRING so2 := REGEXFIND(ip_pattern, srcip, 2);
		STRING so3 := REGEXFIND(ip_pattern, srcip, 3);
		STRING so4 := REGEXFIND(ip_pattern, srcip, 4);

		ds_1 := IF(isWild(so1),	ds_src_idx(srcip_octet1>=0 AND srcip_octet1<=255),ds_src_idx(srcip_octet1 = (UNSIGNED)so1));
		ds_2 := IF(isWild(so2),	ds_1(srcip_octet2>=0 AND srcip_octet2<=255),	ds_1(srcip_octet2 = (UNSIGNED)so2));
		ds_3 := IF(isWild(so3),	ds_2(srcip_octet3>=0 AND srcip_octet3<=255),	ds_2(srcip_octet3 = (UNSIGNED)so3));
		ds_4 := IF(isWild(so4),	ds_3(srcip_octet4>=0 AND srcip_octet4<=255),	ds_3(srcip_octet4 = (UNSIGNED)so4));

		ds_t4 := IF(protocolId>=0,	ds_4(protocol_id = protocolId), ds_4(protocol_id>=0 AND protocol_id<=255));

		ds_5 := IF(source_port>=0, ds_t4(srcport=source_port), ds_t4(srcport>=0));
		ds_6 := IF(destination_port>=0, ds_5(destport=destination_port), ds_5(destport>=0));

		ds_7 := IF(num_sent_packets>=0, ds_6(sent_packets=num_sent_packets), ds_6(sent_packets>=0));
		ds_8 := IF(num_rcv_packets>=0, ds_7(rcv_packets=num_rcv_packets), ds_7(rcv_packets>=0));

		L_IP_Search_Results create_result(ds_8 l) := TRANSFORM
			SELF.srcip  := l.srcip_octet1 + '.' + l.srcip_octet2 + '.' + l.srcip_octet3 + '.' + l.srcip_octet4;
			SELF.destip := l.destip_octet1 + '.' + l.destip_octet2 + '.' + l.destip_octet3 + '.' + l.destip_octet4;
			SELF.datetime := dolecki.format_date_ms_since_y2k(l.ms_start);
			SELF := l;
		END;
		
		return PROJECT(ds_8,create_result(LEFT));
	END;

	export L_IP_Search_Results F_search_destip(
			STRING destip, 
			INTEGER protocolId,
			INTEGER source_port, 
			INTEGER destination_port, 
			INTEGER num_sent_packets, 
			INTEGER num_rcv_packets) := FUNCTION
			
		STRING do1 := REGEXFIND(ip_pattern, destip, 1);
		STRING do2 := REGEXFIND(ip_pattern, destip, 2);
		STRING do3 := REGEXFIND(ip_pattern, destip, 3);
		STRING do4 := REGEXFIND(ip_pattern, destip, 4);

		ds_1 := IF(isWild(do1),	ds_dest_idx(destip_octet1>=0 AND destip_octet1<=255),ds_dest_idx(destip_octet1 = (UNSIGNED)do1));
		ds_2 := IF(isWild(do2),	ds_1(destip_octet2>=0 AND destip_octet2<=255),	ds_1(destip_octet2 = (UNSIGNED)do2));
		ds_3 := IF(isWild(do3),	ds_2(destip_octet3>=0 AND destip_octet3<=255),	ds_2(destip_octet3 = (UNSIGNED)do3));
		ds_4 := IF(isWild(do4),	ds_3(destip_octet4>=0 AND destip_octet4<=255),	ds_3(destip_octet4 = (UNSIGNED)do4));

		ds_t4 := IF(protocolId>=0,	ds_4(protocol_id = protocolId), ds_4(protocol_id>=0 AND protocol_id<=255));
		
		ds_5 := IF(source_port>=0, ds_t4(srcport=source_port), ds_t4(srcport>=0));
		ds_6 := IF(destination_port>=0, ds_5(destport=destination_port), ds_5(destport>=0));
		
		ds_7 := IF(num_sent_packets>=0, ds_6(sent_packets=num_sent_packets), ds_6(sent_packets>=0));
		ds_8 := IF(num_rcv_packets>=0, ds_7(rcv_packets=num_rcv_packets), ds_7(rcv_packets>=0));

		L_IP_Search_Results create_result(ds_8 l) := TRANSFORM
			SELF.srcip  := l.srcip_octet1 + '.' + l.srcip_octet2 + '.' + l.srcip_octet3 + '.' + l.srcip_octet4;
			SELF.destip := l.destip_octet1 + '.' + l.destip_octet2 + '.' + l.destip_octet3 + '.' + l.destip_octet4;
			SELF.datetime := dolecki.format_date_ms_since_y2k(l.ms_start);
			SELF := l;
		END;
		
		return PROJECT(ds_8,create_result(LEFT));
	END;

	export L_IP_Search_Results F_search_protocol(
			UNSIGNED1 protocolId,
			INTEGER source_port, 
			INTEGER destination_port, 
			INTEGER num_sent_packets, 
			INTEGER num_rcv_packets) := FUNCTION
			
		ds_1 := ds_protocol_idx(protocol_id = protocolId);
		
		ds_2 := IF(source_port>=0, ds_1(srcport=source_port), ds_1(srcport>=0));
		ds_3 := IF(destination_port>=0, ds_2(destport=destination_port), ds_2(destport>=0));
		
		ds_4 := IF(num_sent_packets>=0, ds_3(sent_packets=num_sent_packets), ds_3(sent_packets>=0));
		ds_5 := IF(num_rcv_packets>=0, ds_4(rcv_packets=num_rcv_packets), ds_4(rcv_packets>=0));

		L_IP_Search_Results create_result(ds_5 l) := TRANSFORM
			SELF.srcip  := l.srcip_octet1 + '.' + l.srcip_octet2 + '.' + l.srcip_octet3 + '.' + l.srcip_octet4;
			SELF.destip := l.destip_octet1 + '.' + l.destip_octet2 + '.' + l.destip_octet3 + '.' + l.destip_octet4;
			SELF.datetime := dolecki.format_date_ms_since_y2k(l.ms_start);
			SELF := l;
		END;
		
		return PROJECT(ds_5,create_result(LEFT));
	END;

	export L_IP_Search_Results F_search(
			STRING srcip, 
			STRING destip, 
			STRING protocol_value,
			INTEGER source_port, 
			INTEGER destination_port, 
			INTEGER num_sent_packets, 
			INTEGER num_rcv_packets) := FUNCTION

		boolean usi := IF(srcip = '', false, true);
		boolean udi := IF(destip = '', false, true);

		INTEGER protocolId := IF(protocol_value = '', -1, dolecki.Mod_G2_Ip_Data.map_protocol_to_int(protocol_value));
		
		ds_results := MAP(
			usi AND udi => F_search_srcip_destip(srcip, destip, protocolId, source_port, destination_port, num_sent_packets, num_rcv_packets),
			usi => F_search_srcip(srcip, protocolId, source_port, destination_port, num_sent_packets, num_rcv_packets),
			udi => F_search_destip(destip, protocolId, source_port, destination_port, num_sent_packets, num_rcv_packets),
			F_search_protocol(protocolId, source_port, destination_port, num_sent_packets, num_rcv_packets)
		);

		return(ds_results);
	END;

	export dolecki.Mod_G2_Ip_Data.Layout_Results search_ddccil(
			STRING srccc,
			STRING destcc,
			STRING srcip,
			STRING destip,
			STRING protocol,
			INTEGER source_port,
			INTEGER destination_port,
			INTEGER num_sent_packets,
			INTEGER num_rcv_packets
		) := FUNCTION

		STRING so1 := REGEXFIND(ip_pattern, srcip, 1);
		STRING so2 := REGEXFIND(ip_pattern, srcip, 2);
		STRING so3 := REGEXFIND(ip_pattern, srcip, 3);
		STRING so4 := REGEXFIND(ip_pattern, srcip, 4);

		STRING do1 := REGEXFIND(ip_pattern, destip, 1);
		STRING do2 := REGEXFIND(ip_pattern, destip, 2);
		STRING do3 := REGEXFIND(ip_pattern, destip, 3);
		STRING do4 := REGEXFIND(ip_pattern, destip, 4);

		UNSIGNED1 protocolId   := dolecki.Mod_G2_Ip_Data.map_protocol_to_int(protocol);

		ds := dolecki.Mod_G2_Ip_Data.DS_DDCCIL;
		
		ds_1 := IF(srccc = '',ds,ds(src_country_code = srccc));
		ds_2 := IF(destcc = '',ds_1,ds_1(dest_country_code = destcc));

		ds_3 := IF(isWild(so1), ds_2,ds_2(srcip_octet1 = (UNSIGNED)so1));
		ds_4 := IF(isWild(so2), ds_3,ds_3(srcip_octet2 = (UNSIGNED)so2));
		ds_5 := IF(isWild(so3), ds_4,ds_4(srcip_octet3 = (UNSIGNED)so3));
		ds_6 := IF(isWild(so4), ds_5,ds_5(srcip_octet4 = (UNSIGNED)so4));

		ds_7  := IF(isWild(do1), ds_6,ds_6(destip_octet1 = (UNSIGNED)do1));
		ds_8  := IF(isWild(do2), ds_7,ds_7(destip_octet2 = (UNSIGNED)do2));
		ds_9  := IF(isWild(do3), ds_8,ds_8(destip_octet3 = (UNSIGNED)do3));
		ds_10 := IF(isWild(do4), ds_9,ds_9(destip_octet4 = (UNSIGNED)do4));

		ds_11 := IF(protocolId>0,ds_10(protocol_id = protocolId),ds_10);
		
		ds_12 := IF(source_port>=0,ds_11(srcport=source_port),ds_11);
		ds_13 := IF(destination_port>=0,ds_12(destport=destination_port),ds_12);

		ds_14 := IF(num_sent_packets>=0,ds_13(sent_packets=num_sent_packets),ds_13);
		ds_15 := IF(num_rcv_packets>=0,ds_14(rcv_packets=num_rcv_packets),ds_14);
		
		ds_filtered := ds_15;
		
		ds_uipl_idx := dolecki.Mod_G2_Ip_Data.IDX_UIPL_id;
		layout_results := dolecki.Mod_G2_Ip_Data.Layout_Results;

		layout_results join_src(dolecki.Mod_G2_Ip_Data.L_DDCCIL l, ds_uipl_idx r) := TRANSFORM
			SELF.srcip  := l.srcip_octet1 + '.' + l.srcip_octet2 + '.' + l.srcip_octet3 + '.' + l.srcip_octet4;
			SELF.destip := l.destip_octet1 + '.' + l.destip_octet2 + '.' + l.destip_octet3 + '.' + l.destip_octet4;
			SELF.datetime := dolecki.format_date_ms_since_y2k(l.ms_start);
			SELF.src_location := r;
			SELF.dest_location := [];
			SELF := l;
		END;

		ds_ddccil_src := JOIN(
			ds_filtered,
			ds_uipl_idx,
			LEFT.src_location_id = RIGHT.id,
			join_src(LEFT,RIGHT)
		);

		Layout_Results join_dest(ds_ddccil_src l,ds_uipl_idx r) := TRANSFORM
			SELF.dest_location := r;
			SELF := l;
		END;

		ds_ddccil_dest := JOIN(
			ds_ddccil_src,
			ds_uipl_idx,
			LEFT.dest_location_id = RIGHT.id,
			join_dest(LEFT,RIGHT)
		);

		return ds_ddccil_dest;
	END;
	
END;