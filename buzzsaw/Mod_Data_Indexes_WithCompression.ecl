export Mod_Data_Creation_WithCompression := MODULE
	SHARED FN_U4 := Mod_Data.FN_U4;
	SHARED FN_Clusters := Mod_Data.FN_Clusters;
	SHARED FN_Unique_IPs_Location := Mod_Data.FN_Unique_IPs_Location;
	
	SHARED FN_Idx_Clusters_clid := Mod_Data.FN_Idx_Clusters_clid;
	SHARED FN_Idx_Cluster_Plot := Mod_Data.FN_Idx_Cluster_Plot;
	
	SHARED FN_Idx_U4_time_of_day := Mod_Data.FN_Idx_U4_time_of_day;
	SHARED FN_Idx_U4_destip_u4 := Mod_Data.FN_Idx_U4_destip_u4;
	SHARED FN_Idx_U4_ips := Mod_Data.FN_Idx_U4_ips;
	SHARED FN_Idx_U4_DestPort := Mod_Data.FN_Idx_U4_DestPort;
	SHARED FN_Idx_U4_SrcPort := Mod_Data.FN_Idx_U4_SrcPort;
	SHARED FN_IDX_U4_Dest_CC := Mod_Data.FN_IDX_U4_Dest_CC;
	SHARED FN_IDX_U4_Src_CC := Mod_Data.FN_IDX_U4_Src_CC;
	SHARED FN_Idx_U4_Protocol := Mod_Data.FN_Idx_U4_Protocol;
	
	SHARED FN_Idx_UIP_Locations := Mod_Data.FN_Idx_UIP_Locations;
	SHARED FN_Idx_UIP_Locations_CC := Mod_Data.FN_Idx_UIP_Locations_CC;
	
	SHARED FN_Idx_Threat_ip_u4 := Mod_Data.FN_Idx_Threat_ip_u4;
	
	
	SHARED DS_U4_Idx := DATASET(FN_U4, 
			{ Mod_Data.L_Firewall_U4, UNSIGNED8 RecPtr{virtual(fileposition)}}, THOR);
	SHARED L_Unique_Ips_Location := Mod_Data.L_Unique_Ips_Location;

	SHARED log_max_pairs := log(max(Mod_Data.DS_Clusters, pairs));
			
	SHARED L_Cluster_Info := RECORD
			Mod_Data.L_Firewall_Cluster;
			UNSIGNED8 RecPtr {virtual(fileposition)};
	END;
		
	export IDX_Cluster_Plot_Old := INDEX(
			DATASET(FN_Clusters, 
					L_Cluster_Info,
					THOR)
				, {UNSIGNED2 x := Mod_Data_Util.translate_mean_to_x(mean)
//					,INTEGER2 y := buzzsaw.Mod_Data_Util.translate_to_y(mean, stdev)},
					,UNSIGNED2 y := buzzsaw.Mod_Data_Util.translate_stdev_to_y(stdev)},
					{UNSIGNED1 size := 1 + truncate(9.0 * log(pairs) / log_max_pairs)
					,STRING description :=
							'ip pairs=' + pairs + ',' +
							'mean period=' + mean + ',' +
							'mean stdev=' + stdev + ',' +
							'srcip range=' + Mod_Octets.F_UnConvert(min_src_ip) + 
							' to ' + Mod_Octets.F_UnConvert(max_src_ip) + ',' +
							'destip range=' + Mod_Octets.F_UnConvert(min_dest_ip) +
							' to ' + Mod_Octets.F_UnConvert(max_dest_ip) + ',' +
							'min period=' + min_mean + ',' +
							'max period=' + max_mean + ',' +
							'min stdev=' + min_stdev + ',' +
							'max stdev=' + max_stdev
					,RecPtr}
				, Mod_Data.FN_Idx_Cluster_Plot);
				
		SHARED L_Added_Info := RECORD
				UNSIGNED4 num_srcips;
				UNSIGNED4 num_destips;
				UNSIGNED4 max_srcips_to_one_destip;
				UNSIGNED4 max_destips_to_one_srcip;
		END;
		EXPORT L_Cluster_MoreInfo := RECORD
				L_Cluster_Info;
				L_Added_Info;
		END;
		
		
	EXPORT L_Cluster_Plot := RECORD
		UNSIGNED2 cluster;
		UNSIGNED2 x;
		INTEGER2 y;
		REAL8 mean;
		REAL8 stdev;
		UNSIGNED1 size;
		UNSIGNED4 pairs;
		STRING min_srcip;
		STRING max_srcip;
		STRING min_destip;
		STRING max_destip;
		UNSIGNED4 num_srcips;
		UNSIGNED4 num_destips;
		UNSIGNED4 max_srcips_to_one_destip;
		UNSIGNED4 max_destips_to_one_srcip;
		REAL8 min_mean;
		REAL8 max_mean;
		REAL8 min_stdev;
		REAL8 max_stdev;
		UNSIGNED4 min_events;
		UNSIGNED4 max_events;
		UNSIGNED2 min_destport;
		UNSIGNED2 max_destport;
		STRING2 min_src_cc;
		STRING2 max_src_cc;
		STRING2 min_dest_cc;
		STRING2 max_dest_cc;
		STRING min_date;
		STRING max_date;
		UNSIGNED4 min_out_packets;
		UNSIGNED4 max_out_packets;
		UNSIGNED4 min_in_packets;
		UNSIGNED4 max_in_packets;
	END;
	
	SHARED L_Cluster_Extras := RECORD
		UNSIGNED4 pairs;
		STRING min_srcip;
		STRING min_srcip_cc;
		STRING max_srcip;
		STRING max_srcip_cc;
		STRING min_destip;
		STRING min_destip_cc;
		STRING max_destip;
		STRING max_destip_cc;
		UNSIGNED4 num_srcips;
		UNSIGNED4 num_destips;
		UNSIGNED4 max_srcips_to_one_destip;
		UNSIGNED4 max_destips_to_one_srcip;
		REAL8 min_mean;
		REAL8 max_mean;
		REAL8 min_stdev;
		REAL8 max_stdev;
		UNSIGNED4 min_events;
		UNSIGNED4 max_events;
		UNSIGNED2 min_destport;
		UNSIGNED2 max_destport;
		STRING2 min_src_cc;
		STRING2 max_src_cc;
		STRING2 min_dest_cc;
		STRING2 max_dest_cc;
		STRING min_date;
		STRING max_date;
		UNSIGNED4 min_out_packets;
		UNSIGNED4 max_out_packets;
		UNSIGNED4 min_in_packets;
		UNSIGNED4 max_in_packets;
		UNSIGNED8 RecPtr;		
	END;
		
	/* add in some important information about clusters that has been lost through aggregation */	
	EXPORT DATASET C_Cluster_Indexes := FUNCTION
		cluster_ds2 := DATASET(FN_Clusters,
				L_Cluster_Info,
				THOR);

		L_Cluster_Small := RECORD
			UNSIGNED4 pairs;
			UNSIGNED2 cluster;
			REAL8 min_mean;
			REAL8 max_mean;
			REAL8 min_stdev;
			REAL8 max_stdev;
		END;
		
		cluster_ds := PROJECT(cluster_ds2, 
			TRANSFORM(L_Cluster_Small, 
				SELF := LEFT,
		));
				
//		output(cluster_ds);
		
		stddev_ds := Mod_Data.DS_StdDev_Clusterable;

		SHARED L_Cluster_Temp := RECORD
				UNSIGNED2 cluster;		//keep
				UNSIGNED4 srcip_u4;	//keep
				UNSIGNED4 destip_u4;	//keep
				UNSIGNED4 num;
				UNSIGNED4 current;
				UNSIGNED4 max;
		END;

		L_Cluster_Temp join_trans(Mod_Data.L_Firewall_Stats s, L_Cluster_Small i) := TRANSFORM
				SELF.cluster := i.cluster;
				SELF := s;
				SELF := i;
				SELF.num := 1;
				SELF.current := 1;
				SELF.max := 1;
		END;

		joined_ds := JOIN(stddev_ds, cluster_ds,
				(LEFT.mean BETWEEN RIGHT.min_mean AND RIGHT.max_mean)
					AND
				(LEFT.stdev BETWEEN RIGHT.min_stdev AND RIGHT.max_stdev),
				join_trans(LEFT, RIGHT), 
				LEFT OUTER, 
//				LIMIT(1),
				ALL);
				
		joined_ds_distributed := DISTRIBUTE(joined_ds, cluster);
		joined_ds_sorted_srcip := SORT(joined_ds_distributed, cluster, srcip_u4, destip_u4, LOCAL);
		joined_ds_grouped := GROUP(joined_ds_sorted_srcip, cluster, LOCAL);
		joined_ds_sorted_destip := SORT(joined_ds_grouped, destip_u4, srcip_u4);

		ds_rolled_srcip := ROLLUP(joined_ds_grouped, 
				TRANSFORM(L_Cluster_Temp,
					SELF.cluster := RIGHT.cluster,
					SELF.srcip_u4 := RIGHT.srcip_u4;
					SELF.destip_u4 := RIGHT.destip_u4;
					SELF.num := LEFT.num + IF(LEFT.srcip_u4 != RIGHT.srcip_u4, 1, 0),
					SELF.current := IF(LEFT.srcip_u4 != RIGHT.srcip_u4, 1, LEFT.current+RIGHT.current),
					SELF.max := IF( SELF.current > LEFT.max, SELF.current, LEFT.max);
				),
				cluster);//, LOCAL);
		ds_rolled_destip := ROLLUP(joined_ds_sorted_destip, 
				TRANSFORM(L_Cluster_Temp,
					SELF.cluster := RIGHT.cluster,
					SELF.srcip_u4 := RIGHT.srcip_u4;
					SELF.destip_u4 := RIGHT.destip_u4;
					SELF.num := LEFT.num + IF(LEFT.destip_u4 != RIGHT.destip_u4, 1, 0),
					SELF.current := IF(LEFT.destip_u4 != RIGHT.destip_u4, 1, LEFT.current+RIGHT.current),
					SELF.max := IF(SELF.current > LEFT.max, SELF.current, LEFT.max);
				),
				cluster);//, LOCAL);
				
		L_Cluster_Double := RECORD
				UNSIGNED2 cluster;		//keep
				L_Added_Info;
		END;
		
		ds_rolled_joined := JOIN(ds_rolled_srcip, ds_rolled_destip, LEFT.cluster=RIGHT.cluster,
				TRANSFORM(L_Cluster_Double,
					SELF := LEFT,
					SELF.num_srcips := LEFT.num,
					SELF.max_srcips_to_one_destip := LEFT.max,
					SELF.max_destips_to_one_srcip := RIGHT.max,
					SELF.num_destips := RIGHT.num,
					),
				LOCAL);
				
		L_Payload := RECORD
			UNSIGNED4 num_srcips := ds_rolled_joined.num_srcips;
			UNSIGNED4 num_destips := ds_rolled_joined.num_destips;
			UNSIGNED4 max_destips_to_one_srcip := ds_rolled_joined.max_destips_to_one_srcip;
			UNSIGNED4 max_srcips_to_one_destip := ds_rolled_joined.max_srcips_to_one_destip;
		END;
		
		cluster_ds2_distributed := DISTRIBUTE(cluster_ds2, cluster);
				
		j := JOIN(ds_rolled_joined, cluster_ds2_distributed, LEFT.cluster=RIGHT.cluster, LOCAL);
		
		log2 := log(2);
		deno := log_max_pairs - log2;
		
		bubble_size(UNSIGNED4 p) := IF(	//kludge to make size 1 clusters ALWAYS have 1 pair
				p < 2,
				1,
				2 + round(8.49999 * (log(p)-log2) / deno)); 
		
		bld2 := BUILDINDEX(j,
				{	UNSIGNED2 x := buzzsaw.Mod_Data_Util.translate_mean_to_x(mean),
					INTEGER2 y := buzzsaw.Mod_Data_Util.translate_to_y(mean, stdev)
				},{
					mean,
					stdev,
					UNSIGNED1 size := bubble_size(pairs),
					cluster,
					pairs,
					min_srcip := Mod_Octets.F_UnConvert(min_src_ip),
					STRING min_srcip_cc := TRIM(min_srcip_cc),
					max_srcip := Mod_Octets.F_UnConvert(max_src_ip),
					STRING max_srcip_cc := TRIM(max_srcip_cc),
					min_destip := Mod_Octets.F_UnConvert(min_dest_ip),
					STRING min_destip_cc := TRIM(min_destip_cc),
					max_destip := Mod_Octets.F_UnConvert(max_dest_ip),
					STRING max_destip_cc := TRIM(max_destip_cc),
					num_srcips,
					num_destips,
					max_srcips_to_one_destip,
					max_destips_to_one_srcip,
					min_mean,
					max_mean,
					min_stdev,
					max_stdev,
					min_events,
					max_events,
					min_destport,
					max_destport,
					min_src_cc,
					max_src_cc,
					min_dest_cc,
					max_dest_cc,
					STRING min_date := Mod_Y2K.format_date(min_date),
					STRING max_date := Mod_Y2K.format_date(max_date),
					min_out_packets,
					max_out_packets,
					min_in_packets,
					max_in_packets,
					RecPtr		
				},
				FN_Idx_Cluster_Plot,
				OVERWRITE
		);
	
		bld3 := BUILDINDEX(j,
				{	cluster,
				},{
					mean,
					stdev,
					UNSIGNED2 x := Mod_Data_Util.translate_mean_to_x(mean),
					INTEGER2 y := buzzsaw.Mod_Data_Util.translate_to_y(mean, stdev),
					UNSIGNED1 size := bubble_size(pairs),
					pairs,
					min_srcip := Mod_Octets.F_UnConvert(min_src_ip),
					STRING min_srcip_cc := TRIM(min_srcip_cc),
					max_srcip := Mod_Octets.F_UnConvert(max_src_ip),
					STRING max_srcip_cc := TRIM(max_srcip_cc),
					min_destip := Mod_Octets.F_UnConvert(min_dest_ip),
					STRING min_destip_cc := TRIM(min_destip_cc),
					max_destip := Mod_Octets.F_UnConvert(max_dest_ip),
					STRING max_destip_cc := TRIM(max_destip_cc),
					num_srcips,
					num_destips,
					max_srcips_to_one_destip,
					max_destips_to_one_srcip,
					min_mean,
					max_mean,
					min_stdev,
					max_stdev,
					min_events,
					max_events,
					min_destport,
					max_destport,
					min_src_cc,
					max_src_cc,
					min_dest_cc,
					max_dest_cc,
					STRING min_date := Mod_Y2K.format_date(min_date),
					STRING max_date := Mod_Y2K.format_date(max_date),
					min_out_packets,
					max_out_packets,
					min_in_packets,
					max_in_packets,
					RecPtr
				},
				FN_Idx_Clusters_clid,
				OVERWRITE
		);
		
		RETURN PARALLEL(bld2, bld3);
	END;
					
//	ds := get_cluster_info();

	export IDX_Cluster_Plot := INDEX(
			DATASET(FN_Clusters, 
					L_Cluster_Info,
					THOR)
				, {
					UNSIGNED2 x,
					INTEGER2 y
				},{
					REAL8 mean,
					REAL8 stdev,
					UNSIGNED1 size,
					UNSIGNED2 cluster,
					L_Cluster_Extras
				}, FN_Idx_Cluster_Plot);

	export IDX_Clusters_clid := INDEX(
			DATASET(FN_Clusters, 
					L_Cluster_Info,
					THOR)
				, {
					UNSIGNED2 cluster
				},{
					REAL8 mean,
					REAL8 stdev,
					UNSIGNED2 x,
					INTEGER2 y,
					UNSIGNED1 size,
					L_Cluster_Extras
				}, FN_Idx_Clusters_clid);
				
							
	export IDX_UIP_Location_IP                := INDEX(
			DATASET(FN_Unique_Ips_Location,{
				L_Unique_Ips_Location, 
				UNSIGNED8 RecPtr {virtual(fileposition)}},
				THOR
			)
			, {UNSIGNED4 ip_u4 := Mod_Octets.F_Convert(ip)}
			, {country_code, latitude, longitude,
				region, city, isp_name, domain_name, country_name, ip,
				RecPtr}
			, FN_Idx_UIP_Locations);
			
	//FN_Idx_UIP_Locations_CC
	export IDX_UIP_Location_Country_Code      := INDEX(
			DATASET(FN_Unique_Ips_Location,{
				L_Unique_Ips_Location, 
				UNSIGNED8 RecPtr {virtual(fileposition)}},
				THOR
			)
			, {country_code}
			, {ip, country_name, 
					region, city, latitude, longitude, 
					isp_name, domain_name, 
					RecPtr}
			, FN_Idx_UIP_Locations_CC);

	export IDX_Threat_IP_u4 := INDEX(
		DATASET(Mod_Data.FN_Threat_Thor, 
			{Mod_Data.L_Threat, UNSIGNED8 RecPtr{virtual(fileposition)}}, THOR)
		, {ip_u4}
		, {threat, date, RecPtr}
		, FN_Idx_Threat_ip_u4);

	export IDX_U4_destip_u4      := INDEX(
			DS_U4_Idx
			, {destip_u4, destport}
			, {
					src_cc, dest_cc,
					ms_start, records, 
					srcport, INTEGER4 tod := buzzsaw.Mod_Data_Util.f_tod(ms_start),
					sent_packets, rcv_packets, duration, srcip_u4, protocol, firewall,
					RecPtr}
			, FN_Idx_U4_destip_u4);
			
	export IDX_U4_ips      := INDEX(
			DS_U4_Idx
			, {srcip_u4, destip_u4}
			, {ms_start, records, 
					srcport, destport, protocol,
					sent_packets, rcv_packets, duration,
					INTEGER4 tod := buzzsaw.Mod_Data_Util.f_tod(ms_start),
					src_cc, dest_cc, firewall,
					RecPtr}
			, FN_Idx_U4_ips);			
			
	export IDX_U4_Time_Of_Day := INDEX(
			DS_U4_Idx
			, {INTEGER4 tod := buzzsaw.Mod_Data_Util.f_tod(ms_start),
				dest_cc
			},{
				src_cc,
				destport, sent_packets, rcv_packets,
				srcip_u4, destip_u4, srcport,
				ms_start, duration, records, protocol, firewall,
				RecPtr
			}, FN_Idx_U4_Time_Of_Day);
			
	export IDX_U4_destport := INDEX(
			DS_U4_Idx
			, {destport, sent_packets, rcv_packets, INTEGER4 tod := buzzsaw.Mod_Data_Util.f_tod(ms_start),
			},{srcip_u4, destip_u4, srcport, ms_start, duration, records, src_cc, dest_cc, 
				protocol, firewall, RecPtr
			}, FN_Idx_U4_DestPort);
			
	export IDX_U4_dest_cc := INDEX(
			DS_U4_Idx
			, {dest_cc, destport, 
			},{sent_packets, rcv_packets, INTEGER4 tod := buzzsaw.Mod_Data_Util.f_tod(ms_start),
				srcip_u4, destip_u4, srcport, ms_start, duration, records, src_cc, 
				protocol, firewall, RecPtr
			}, FN_Idx_U4_Dest_CC);
			
	export IDX_U4_src_cc := INDEX(
			DS_U4_Idx
			, {src_cc, destport, 
			},{sent_packets, rcv_packets, INTEGER4 tod := buzzsaw.Mod_Data_Util.f_tod(ms_start),
				srcip_u4, destip_u4, srcport, ms_start, duration, records, dest_cc, 
				protocol, firewall, RecPtr
			}, FN_Idx_U4_Src_CC);
			
	export IDX_U4_protocol := INDEX(
			DS_U4_Idx
			, {protocol, destport, 
			},{sent_packets, rcv_packets, INTEGER4 tod := buzzsaw.Mod_Data_Util.f_tod(ms_start),
				srcip_u4, destip_u4, srcport, ms_start, duration, records, 
				firewall, dest_cc, src_cc, RecPtr
			}, FN_Idx_U4_Protocol);
			
END;