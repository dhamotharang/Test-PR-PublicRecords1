import ut;
export Mod_Data := MODULE
	export FN_Prefix								:= '~g2';		// Change to CyberWatch
	export FN_DAILY_STEM						:= FN_Prefix + '::' + WORKUNIT[2..9];
	export FN_F_wall3               := FN_Prefix + '::wall3_all';
	export FN_F_wallsand            := FN_Prefix + '::wallsand_all';
	export FN_F_walltiger           := FN_Prefix + '::walltiger_all';
	export FN_F_wallwhale           := FN_Prefix + '::wallwhale_all';
	
	
	export FN_F_TestInput_SF				:= FN_Prefix + '::Raw::TestInput';
	
	
	export FN_FT_wall3              := FN_Prefix + '::wall3_trans';
	export FN_FT_wallsand           := FN_Prefix + '::wallsand_trans';
	export FN_FT_walltiger          := FN_Prefix + '::walltiger_trans';
	export FN_FT_wallwhale          := FN_Prefix + '::wallwhale_trans';
	export FN_msFirewall            := FN_Prefix + '::firewall_all';
	
	export FN_DD                    := FN_Prefix + '::firewall_deduped';
	export FN_DDC                   := FN_Prefix + '::firewall_deduped_cleaned';
	export FN_IDX_DDC_Srcip_u4			:= FN_Prefix + '::idx::ddc_srcip_u4';
	export FN_IDX_DDC_Destip_u4			:= FN_Prefix + '::idx::ddc_destip_u4';
	export FN_Octets                := FN_Prefix + '::firewall_octets';
	export FN_StDev                 := FN_Prefix + '::firewall_stdev';
	export FN_U4                    := FN_Prefix + '::firewall_u4';
	export FN_IDX_U4                := FN_Prefix + '::IDX::firewall_u4';
	export FN_Clusters              := FN_Prefix + '::firewall_clusters';
	
	// Create list of unique ips from log data
	export FN_Unique_Srcips         := FN_Prefix + '::firewall_all_unique_srcips';
	export FN_Unique_Destips        := FN_Prefix + '::firewall_all_unique_destips';
	export FN_All_Unique_Ips        := FN_Prefix + '::unique_ips_superfile';

	// import ip location data and standarize into a THOR format
	export FN_IpLocation            := FN_Prefix + '::iplocation'; // was '~smd::iplocation';
	export FN_Std_IpLocation        := FN_Prefix + '::std_iplocation';// was '~smd::std_iplocation'; // Creation function does not exists for this yet (was initially done by hand)

	// break the ip location data into equal size groups
	export FN_Ip_Location_Distribution_Groups := FN_Prefix + '::ip_location_distribution_group_info_1k'; // was '~smd::ip_location_distribution_group_info_1k'; // ip location data file divided into groups of 1k
	export FN_Ip_Location_With_Group_Info     := FN_Prefix + '::ip_location_with_group_info'; // was '~smd::ip_location_with_group_info'; // ip location joined with the distribution groups

	// associate group information with the unique ip list and then join with the location data containing the group info
	export FN_Unique_Ips_Location   := FN_Prefix + '::firewall_all_unique_ips_with_location_info';
	export FN_Idx_Unique_Ips_Location := FN_Prefix + '::idx::firewall_all_unique_ips_with_location_info';
	
	// index names
	export FN_Idx_UIP_Locations     := ut.foreign_dataland + 'g2::idx::uip_location::ip'; //my uip location index on ip
	export FN_Idx_UIP_Locations_CC  := FN_Prefix + '::idx::uip_location::country_code'; //my uip location index on country_code
	
//	export FN_Idx_U4_srcip_u4       := FN_Prefix + '::idx::u4::srcip_u4';
	export FN_Idx_U4_destip_u4      := FN_Prefix + '::idx::u4::destip_u4';
	export FN_Idx_U4_ips            := FN_Prefix + '::idx::u4::ips';
	export FN_Idx_U4_time_of_day    := FN_Prefix + '::idx::u4::time';
	export FN_Idx_U4_DestPort       := FN_Prefix + '::idx::u4::destport';
	export FN_Idx_U4_SrcPort        := FN_Prefix + '::idx::u4::srcport';
	export FN_IDX_U4_Dest_CC        := FN_Prefix + '::idx::u4::dest_cc';
	export FN_IDX_U4_Src_CC         := FN_Prefix + '::idx::u4::src_cc';
	export FN_Idx_U4_Protocol       := FN_Prefix + '::idx::u4::protocol';
	
	
	export FN_Idx_Clusters_clid     := FN_Prefix + '::idx::clusters_clid';
	export FN_Idx_Cluster_Plot      := FN_Prefix + '::idx::cluster_plot';
	
	
	//emerging threats files
	export FN_Threat_Compromised_Raw:= ut.foreign_dataland + 'g2::compromisedrules';
	export FN_Threat_BotNets_Raw    := ut.foreign_dataland + 'g2::bleeding-botccrules';
	export FN_Threat_Remote_Raw     := ut.foreign_dataland + 'g2::remoterules';
	export FN_Threats_Found         := FN_Prefix + '::threats_in_firewall';
	export FN_Threat_Thor           := FN_Prefix + '::threats_for_index';
	export FN_Idx_Threat_ip_u4      := FN_Prefix + '::idx::threats::ip_u4';
	/*
	*
	* Raw sprayed data  layout.
	*
	*/
	export L_Firewall_RawMeat := RECORD	//My "working version" of the records
		QSTRING20 date;
		QSTRING15 srcip;
		UNSIGNED2 srcport;
		QSTRING15 destip;
		UNSIGNED2 destport;
		QSTRING16 protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
	END;


	// Needed for fake fabricated records.
	export L_Firewall_RawMeatWithYearEtc := RECORD	//My "working version" of the records
		QSTRING20 date;
		QSTRING15 srcip;
		UNSIGNED2 srcport;
		QSTRING15 destip;
		UNSIGNED2 destport;
		QSTRING16 protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
		INTEGER2	year := 0;
		STRING1 firewall := '';
	END;


	/*
	*
	* Cleaned, standardized version stored first.
	*
	*/ 
	
	EXPORT SourceID					:= UNSIGNED4;
	EXPORT DocID						:= UNSIGNED8;
	
	EXPORT DocRef						:= RECORD
		SourceID	src := 0;
		DocID			doc := 0;
	END;
/*	
	export L_Firewall_Packed := RECORD
		DocRef;
		INTEGER6 ms_start;
		INTEGER6 ms_stop;
		UNSIGNED4 records;
		QSTRING15 srcip;
		UNSIGNED2 srcport;
		QSTRING15 destip;
		UNSIGNED2 destport;
		QSTRING16 protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
		UNSIGNED4 srcip_u4;			// Add to avoid the loops in C_Unique_Srcips and C_Unique_Destips
		UNSIGNED4 destip_u4;
		STRING2 src_cc := '';
		STRING2 dest_cc := '';
		STRING1 firewall;
		UNSIGNED8 fpos{virtual(fileposition)};
	END;
*/

	export L_Firewall_Std := RECORD
		DocRef;
		INTEGER6 ms_start;
		INTEGER6 ms_stop;
		UNSIGNED4 records;
		QSTRING15 srcip;
		UNSIGNED2 srcport;
		QSTRING15 destip;
		UNSIGNED2 destport;
		QSTRING16 protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
		UNSIGNED4 srcip_u4;			// Add to avoid the loops in C_Unique_Srcips and C_Unique_Destips
		UNSIGNED4 destip_u4;
		STRING2 src_cc := '';
		STRING2 dest_cc := '';
		STRING1 firewall;
		END;
	//
	// This is a bit crazy until I understand it but this is the same as the L_Firewall_Packed layout.
	// I think I want to retire L_Firewall_U4
	export L_Firewall_U4 := RECORD	//My "working version" of the records
		L_Firewall_Std;
		//UNSIGNED8 fpos{virtual(fileposition)};
	END;
	//
	// OK this one too looks a lot like the one above too
	export L_Firewall_Threats := RECORD	
		INTEGER6 ms_start;
		UNSIGNED4 records;
		UNSIGNED2 srcport;
		UNSIGNED2 destport;
		QSTRING12 protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
		INTEGER4 tod;
		UNSIGNED4 srcip_u4;
		UNSIGNED4 destip_u4;
		QSTRING src_threat;
		QSTRING dest_threat;
		INTEGER6 src_threat_date;
		INTEGER6 dest_threat_date;
		STRING2 src_cc;
		STRING2 dest_cc;
		STRING1 firewall;
	END;
	
	
	export L_Octets := RECORD
		UNSIGNED2 octet1;
		UNSIGNED2 octet2;
		UNSIGNED2 octet3;
		UNSIGNED2 octet4;
	END;	
	
	export L_Firewall_Octets := RECORD
		/* L_Firewall_Packed; */
		L_Firewall_Std;
		L_Octets src_octets;
		L_Octets dest_octets;
	END;
	
	export L_Firewall_Stats := RECORD
		UNSIGNED4 srcip_u4;
		UNSIGNED4 destip_u4;
		UNSIGNED4 periods;
		REAL8 mean;
		REAL8 stdev;
		REAL8 log_mean;
		REAL8 log_stdev;
		STRING2 src_cc;
		STRING2 dest_cc;
		INTEGER6 min_date;
		INTEGER6 max_date;
		UNSIGNED2 min_destport;
		UNSIGNED2 max_destport;
		UNSIGNED4 min_out_packets;
		UNSIGNED4 max_out_packets;
		UNSIGNED4 min_in_packets;
		UNSIGNED4 max_in_packets;
	END;
	
	export L_Firewall_MoreStats := RECORD //build clusters with this layout
		L_Firewall_Stats;
		REAL8 orig_stdev;
		UNSIGNED2 cluster;
		UNSIGNED1 cl_mean;
		UNSIGNED1 cl_stdev;
	END;
	
	export L_Firewall_Cluster := RECORD
		UNSIGNED4 pairs;
		UNSIGNED1 clusters_mean;
		UNSIGNED1 clusters_stdev;
		UNSIGNED4 min_src_ip;
		UNSIGNED4 max_src_ip;
		UNSIGNED4 min_dest_ip;
		UNSIGNED4 max_dest_ip;
		UNSIGNED2 min_destport;
		UNSIGNED2 max_destport;
		UNSIGNED4 min_events;
		UNSIGNED4 max_events;
		REAL8 mean;
		REAL8 stdev;
		REAL8 min_mean;
		REAL8 orig_mean;
		REAL8 max_mean;
		REAL8 min_stdev;
		REAL8 orig_stdev;
		REAL8 max_stdev;
		UNSIGNED2 cluster;
		UNSIGNED1 cl_mean;
		UNSIGNED1 cl_stdev;
		STRING2 min_srcip_cc;
		STRING2 min_destip_cc;
		STRING2 max_srcip_cc;
		STRING2 max_destip_cc;
		STRING2 min_src_cc;
		STRING2 max_src_cc;
		STRING2 min_dest_cc;
		STRING2 max_dest_cc;
		INTEGER6 min_date;
		INTEGER6 max_date;
		UNSIGNED4 min_out_packets;
		UNSIGNED4 max_out_packets;
		UNSIGNED4 min_in_packets;
		UNSIGNED4 max_in_packets;
	END;
	
	export L_Threat_Raw := RECORD
			QSTRING date
		,	QSTRING threat
		, QSTRING ip
	END;
		
	export L_Threat := RECORD
		INTEGER6 date;
		QSTRING12 threat;
		UNSIGNED4 ip_u4;
//		UNSIGNED1 sider := 32;
	END;
	
	export L_Unique_Ips := RECORD
		UNSIGNED4 ip_u4;
		QSTRING15 ip;
	END;

	export L_Ip_Location := RECORD
		INTEGER ip_from;
		INTEGER ip_to;
		STRING country_code;
		STRING country_name;
		STRING region;
		STRING city;
		STRING latitude;
		STRING longitude;
		STRING isp_name;
		STRING domain_name;
	END;

	export L_Ip_Location_Distribution_Groups := RECORD
		INTEGER groupid;
		INTEGER ip_from;
		INTEGER ip_to;
	END;

	export L_Ip_Location_With_Group_Info := RECORD
		INTEGER groupid;
		L_Ip_Location;
	END;
	
	export L_Unique_Ips_Location := RECORD
		UNSIGNED4 ip_u4 := 0;
		STRING ip;
		STRING2 country_code;
		STRING country_name;
		STRING region;
		STRING city;
		REAL4 latitude;
		REAL4 longitude;
		STRING isp_name;
		STRING domain_name;
	END;
/*	
	export L_UIP_Idx_Payload := RECORD
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
*/
	export L_Firewall_PreUnpack := RECORD
		INTEGER6 ms_start;
		UNSIGNED4 records;
		UNSIGNED4 srcip_u4;
		UNSIGNED2 srcport;
		UNSIGNED4 destip_u4;
		UNSIGNED2 destport;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
	END;

	export L_Firewall_Unpacked := RECORD //How to return data to the client
		INTEGER6 ms_start;
		STRING date;
		UNSIGNED4 records;
		L_Unique_Ips_Location src;
		UNSIGNED2 srcport;
		L_Unique_Ips_Location dest;
		UNSIGNED2 destport;
		QSTRING12 protocol;
		UNSIGNED4 sent_packets;
		UNSIGNED4 rcv_packets;
		REAL4 duration;
		STRING src_threat;
		STRING dest_threat;
		STRING1 firewall;
	END;
	
	export DS_All := DATASET(FN_msFirewall, /* L_Firewall_Packed */ L_Firewall_Std, THOR);
	export DS_Octets := DATASET(FN_octets, L_Firewall_Octets, THOR);
	export DS_DDC := DATASET(FN_ddc, /* L_Firewall_Packed */ L_Firewall_Std, THOR);
	export DS_U4 := DATASET(FN_U4, L_Firewall_U4, THOR);
	export DS_StdDev := DATASET(FN_StDev, L_Firewall_Stats, THOR);
	export DS_StdDev_Clusterable := DS_StdDev(log_mean >= 0, periods >= 3);
	export DS_Clusters := DATASET(FN_Clusters, L_Firewall_Cluster, THOR);
	
	// Create list of unique ips from log data
	export DS_All_Unique_Ips                  := DATASET(FN_All_Unique_Ips,L_Unique_Ips,THOR);

	// import ip location data and standarize into a THOR format
	export DS_Ip_Location                     := DATASET(FN_IpLocation, L_Ip_Location, CSV); // Raw Ip Location data
	export DS_IP_Location_Std                 := DATASET(FN_Std_IpLocation, L_Ip_Location, THOR); // Ip Location data in THOR format

	// break the ip location data into equal size groups
	export DS_Ip_Location_Distribution_Groups := DATASET(FN_Ip_Location_Distribution_Groups,L_Ip_Location_Distribution_Groups,THOR);
	export DS_Ip_Location_With_Group_Info     := DATASET(FN_Ip_Location_With_Group_Info,L_Ip_Location_With_Group_Info,THOR);

	// associate group information with the unique ip list and then join with the location data containing the group info
	export DS_Unique_Ips_Location             := DATASET(FN_Unique_Ips_Location,L_Unique_Ips_Location,THOR);

	//threat datasets
	export DS_Threat_Compromised_Raw          := DATASET(FN_Threat_Compromised_Raw, L_Threat_Raw, CSV);
	export DS_Threat_Compromised_VFP          := DATASET(FN_Threat_Compromised_Raw, {L_Threat_Raw, UNSIGNED8 RecPtr {virtual(fileposition)}}, CSV);
	export DS_Threat_BotNets_Raw              := DATASET(FN_Threat_BotNets_Raw, L_Threat_Raw, CSV);
	export DS_Threat_BotNets_VFP              := DATASET(FN_Threat_BotNets_Raw, {L_Threat_Raw, UNSIGNED8 RecPtr {virtual(fileposition)}}, CSV);
	export DS_Threat_Remote_Raw               := DATASET(FN_Threat_Remote_Raw, L_Threat_Raw, THOR);
	export DS_Threats                         := DATASET(FN_Threat_Thor, L_Threat, THOR);
	export DS_Threat_VFP                      := DATASET(FN_Threat_Thor, {L_Threat, UNSIGNED8 RecPtr {virtual(fileposition)}}, THOR);
	export DS_Threats_Found                   := DATASET(FN_Threats_Found, L_Firewall_Threats, THOR);
	
END;