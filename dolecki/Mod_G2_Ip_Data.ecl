export Mod_G2_Ip_Data := MODULE

	export FN_DDC                     := '~g2::firewall_deduped_cleaned';
	export FN_DDCC                    := '~g2::ddc'; //further cleaned to remove records with invalid ip addresses
	export FN_DDCCI                   := '~g2::ddci'; //added id to the ddc dataset
	export FN_DDCCIL                  := '~g2::ddccil'; // joined with location data to create single dataset for creating indexes
	export FN_DDC_SrcDestIp_Octet_Idx := '~g2::ddc::key::srcip.destip.srcport.destport.sntpckt.rcvpckt';
	export FN_DDC_SrcIp_Octet_Idx     := '~g2::ddc::key::srcip.srcport.destport.sntpckt.rcvpckt';
	export FN_DDC_DestIp_Octet_Idx    := '~g2::ddc::key::destip.srcport.destport.sntpckt.rcvpckt';
	export FN_DDC_Protocol_Octet_Idx  := '~g2::ddc::key::protocol.srcport.destport.sntpckt.rcvpckt';

	export FN_UIPL                    := '~g2::firewall_all_unique_ips_with_location_info';
	export FN_UIPL_ID                 := '~g2::uipl';
	export FN_UIPL_ID_Idx_id          := '~g2::uipl::key::id';
	export FN_UIPL_ID_Idx_ip          := '~g2::uipl::key::ip';
	
	export STRING ip_pattern := '^(.*)\\.(.*)\\.(.*)\\.(.*)$';

	export L_UIPL := RECORD
		STRING ip;
		STRING country_code;
		STRING country_name;
		STRING region;
		STRING city;
		STRING latitude;
		STRING longitude;
		STRING isp_name;
		STRING domain_name;
	END;
	
	export L_UIPL_ID := RECORD
		UNSIGNED4 id;
		STRING15 ip;
		STRING2 country_code;
		STRING country_name;
		STRING region;
		STRING city;
		STRING latitude;
		STRING longitude;
		STRING isp_name;
		STRING domain_name;
	END;
	
	export L_IP_Search_Results := RECORD
		QSTRING datetime;
		//INTEGER6 ms_start;
		//INTEGER6 ms_stop;
		STRING15 srcip;
		STRING15 destip;
		UNSIGNED2 srcport;
		UNSIGNED2 destport;
		QSTRING protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
	END;
		
	// This is really just a copy from the buzzsaw Mod_Data module.  I copied it to keep everything
	// local in order to more quicly and easily understand the dataset
	export L_Firewall_Packed := RECORD	//My "working version" of the records
		INTEGER6 ms_start;
		INTEGER6 ms_stop;
		UNSIGNED4 records;
		QSTRING srcip;
		UNSIGNED2 srcport;
		QSTRING destip;
		UNSIGNED2 destport;
		QSTRING protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
	END;

	export L_Firewall_Packed_Id := RECORD	//My "working version" of the records
		UNSIGNED4 id;
		UNSIGNED1 srcip_octet1;
		UNSIGNED1 srcip_octet2;
		UNSIGNED1 srcip_octet3;
		UNSIGNED1 srcip_octet4;
		UNSIGNED1 destip_octet1;
		UNSIGNED1 destip_octet2;
		UNSIGNED1 destip_octet3;
		UNSIGNED1 destip_octet4;
		INTEGER6 ms_start;
		INTEGER6 ms_stop;
		UNSIGNED4 records;
		UNSIGNED2 srcport;
		UNSIGNED2 destport;
		QSTRING protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
	END;

	export L_DDCCIL := RECORD
		UNSIGNED4 id;
		UNSIGNED1 srcip_octet1;
		UNSIGNED1 srcip_octet2;
		UNSIGNED1 srcip_octet3;
		UNSIGNED1 srcip_octet4;
		UNSIGNED1 destip_octet1;
		UNSIGNED1 destip_octet2;
		UNSIGNED1 destip_octet3;
		UNSIGNED1 destip_octet4;
		INTEGER6 ms_start;
		INTEGER6 ms_stop;
		UNSIGNED4 records;
		UNSIGNED2 srcport;
		STRING2 src_country_code;
		UNSIGNED4 src_location_id;
		UNSIGNED2 destport;
		STRING2 dest_country_code;
		UNSIGNED4 dest_location_id;
		UNSIGNED1 protocol_id;
		QSTRING protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
	END;

	// the following 2 layouts are used for results returned
	export Layout_location_temp := RECORD
		STRING country_code;
		STRING country_name;
		STRING region;
		STRING city;
		STRING latitude;
		STRING longitude;
		STRING isp_name;
		STRING domain_name;
	END;

	export Layout_Results := RECORD
		UNSIGNED4 id;
		STRING datetime;
		STRING srcip;
		STRING destip;
		UNSIGNED2 srcport;
		UNSIGNED2 destport;
		QSTRING protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
		UNSIGNED4 src_location_id;
		UNSIGNED4 dest_location_id;
		Layout_location_temp src_location;
		Layout_location_temp dest_location;
	END;

	export UNSIGNED1 map_protocol_to_int(STRING protocol) := FUNCTION
		return MAP(
			protocol = 'CIFS'       => 1,
			protocol = 'FTP'        => 2,
			protocol = 'FTP-DATA'   => 3,
			protocol = 'GWPROXY'    => 4,
			protocol = 'H323'       => 5,
			protocol = 'H245'       => 27, // found this straggler later
			protocol = 'H323.AUDIO' => 6,
			protocol = 'H323.VIDEO' => 7,
			protocol = 'HTTP'       => 8,
			protocol = 'HTTP-FTP'   => 9,
			protocol = 'HTTP-HTTPS' => 10,
			protocol = 'NNTP'       => 11,
			protocol = 'PING'       => 12,
			protocol = 'RDT-REAL'   => 13,
			protocol = 'READHAWK'   => 14,
			protocol = 'REALAUDIO'  => 15,
			protocol = 'REMOTELOG'  => 16,
			protocol = 'RTP/AVP'    => 17,
			protocol = 'RTSP'       => 18,
			protocol = 'SMTP'       => 19,
			protocol = 'SQLNET'     => 20,
			protocol = 'SRL'        => 21,
			protocol = 'STATS'      => 22,
			protocol = 'TELNET'     => 23,

			protocol = 'IP'         => 24,
			protocol = 'TCP'        => 25,
			protocol = 'UDP'        => 26,

			REGEXFIND('^[0-9]+/IP', protocol) => 24,
			REGEXFIND('^[0-9]+/TCP', protocol) => 25,
			REGEXFIND('^[0-9]+/UDP', protocol) => 26,
			0
		);
	END;

	export IDX_UIPL_id := INDEX(
		DATASET(FN_UIPL_ID, { L_UIPL_ID, UNSIGNED8 RecPtr {virtual(fileposition)}},THOR),
		{
			id,
		},
		{
			ip,
			country_code,
			country_name,
			region,
			city,
			latitude,
			longitude,
			isp_name,
			domain_name,
			RecPtr
		},
		FN_UIPL_ID_Idx_id
	);
	
	export IDX_UIPL_ip := INDEX(
		DATASET(FN_UIPL_ID, { L_UIPL_ID, UNSIGNED8 RecPtr {virtual(fileposition)}},THOR),
		{
			UNSIGNED1 ip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, ip, 1),
			UNSIGNED1 ip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, ip, 2),
			UNSIGNED1 ip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, ip, 3),
			UNSIGNED1 ip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, ip, 4),
		},
		{
			id,
			country_code,
			country_name,
			region,
			city,
			latitude,
			longitude,
			isp_name,
			domain_name,
			RecPtr
		},
		FN_UIPL_ID_Idx_ip
	);

	export IDX_srcdestip := INDEX(
		DATASET(FN_DDCC, { L_Firewall_Packed, UNSIGNED8 RecPtr {virtual(fileposition)}},THOR),
		{
			UNSIGNED1 srcip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 1),
			UNSIGNED1 srcip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 2),
			UNSIGNED1 srcip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 3),
			UNSIGNED1 srcip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 4),
			UNSIGNED1 destip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 1),
			UNSIGNED1 destip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 2),
			UNSIGNED1 destip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 3),
			UNSIGNED1 destip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 4),
			UNSIGNED1 protocol_id   := map_protocol_to_int(protocol),
			srcport,
			destport,
			sent_packets,
			rcv_packets
		},
		{
			ms_start,
			ms_stop,
			duration,
			protocol,
			RecPtr
		},
		FN_DDC_SrcDestIp_Octet_Idx
	);

	export IDX_srcip := INDEX(
		DATASET(FN_DDCC, { L_Firewall_Packed, UNSIGNED8 RecPtr {virtual(fileposition)}},THOR),
		{
			UNSIGNED1 srcip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 1),
			UNSIGNED1 srcip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 2),
			UNSIGNED1 srcip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 3),
			UNSIGNED1 srcip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 4),
			UNSIGNED1 protocol_id  := map_protocol_to_int(protocol),
			srcport,
			destport,
			sent_packets,
			rcv_packets
		},
		{
			UNSIGNED1 destip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 1),
			UNSIGNED1 destip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 2),
			UNSIGNED1 destip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 3),
			UNSIGNED1 destip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 4),
			ms_start,
			ms_stop,
			duration,
			protocol,
			RecPtr
		},
		FN_DDC_SrcIp_Octet_Idx
	);

	export IDX_destip := INDEX(
		DATASET(FN_DDCC, { L_Firewall_Packed, UNSIGNED8 RecPtr {virtual(fileposition)}},THOR),
		{
			UNSIGNED1 destip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 1),
			UNSIGNED1 destip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 2),
			UNSIGNED1 destip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 3),
			UNSIGNED1 destip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 4),
			UNSIGNED1 protocol_id   := map_protocol_to_int(protocol),
			srcport,
			destport,
			sent_packets,
			rcv_packets
		},
		{
			UNSIGNED1 srcip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 1),
			UNSIGNED1 srcip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 2),
			UNSIGNED1 srcip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 3),
			UNSIGNED1 srcip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 4),
			ms_start,
			ms_stop,
			duration,
			protocol,
			RecPtr
		},
		FN_DDC_DestIp_Octet_Idx
	);

	export IDX_protocol := INDEX(
		DATASET(FN_DDCC, { L_Firewall_Packed, UNSIGNED8 RecPtr {virtual(fileposition)}},THOR),
		{
			UNSIGNED1 protocol_id   := map_protocol_to_int(protocol),
			srcport,
			destport,
			sent_packets,
			rcv_packets
		},
		{
			UNSIGNED1 srcip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 1),
			UNSIGNED1 srcip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 2),
			UNSIGNED1 srcip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 3),
			UNSIGNED1 srcip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, srcip, 4),
			UNSIGNED1 destip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 1),
			UNSIGNED1 destip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 2),
			UNSIGNED1 destip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 3),
			UNSIGNED1 destip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, destip, 4),
			ms_start,
			ms_stop,
			duration,
			protocol,
			RecPtr
		},
		FN_DDC_Protocol_Octet_Idx
	);
	
	export DS_DDC     := DATASET(FN_DDC,L_Firewall_Packed,THOR);
	export DS_DDCC    := DATASET(FN_DDCC,L_Firewall_Packed,THOR);
	export DS_DDCCI   := DATASET(FN_DDCCI,L_Firewall_Packed_Id,THOR);
	export DS_DDCCIL  := DATASET(FN_DDCCIL,L_DDCCIL,THOR);
	export DS_UIPL    := DATASET(FN_UIPL,L_UIPL,THOR);
	export DS_UIPL_ID := DATASET(FN_UIPL_ID,L_UIPL_ID,THOR);
	
END;