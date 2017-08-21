import dolecki;

export Mod_Basic_Filters := MODULE
	SHARED L_F_U4 := Mod_Data.L_Firewall_U4;	
	SHARED L_F_Threats := Mod_Data.L_Firewall_Threats;
	
	EXPORT UNSIGNED4 ms_narrow := 1 /* minutes */ * 60 * 1000;
	EXPORT UNSIGNED4 ms_2hours := Mod_Y2K.ms_per_day / 12;
	EXPORT INTEGER6 week_in_ms := dolecki.ms_since_y2k(2000, 0, 7, 0, 0, 0, 0);
	

	/* This macro will create a function that takes in a dataset and an (int)-byte integer.
		It will search an unsigned integer field using (uint)-bytes of the (int)-byte integer,
		unless the (int)-byte integer is negative, signalling wildcard */	
	EXPORT DATASET filter_u_i(fun_name, L, field, uint, int) := MACRO
		EXPORT DATASET(L) fun_name (DATASET(L) ds, #EXPAND('INTEGER'+int) val) := 
				IF(val < 0, ds, ds(field = (#EXPAND('UNSIGNED'+uint))val));
	ENDMACRO;	
	
	EXPORT DATASET do_wild(fun_name, L, wild_field) := MACRO
		EXPORT DATASET(L) fun_name(DATASET(L) ds, UNSIGNED4 ip, UNSIGNED4 mask) :=
			CASE(mask,
				buzzsaw.Mod_Octets.MASK0 => ds,
				buzzsaw.Mod_Octets.MASKALL => ds(wild_field = ip),
				ds(ip = (wild_field & mask))
			);
	ENDMACRO;
	
	EXPORT DATASET double_wild(fun_wrapper, inner_wild_man, L, wild_field) := MACRO
		do_wild(inner_wild_man, L, wild_field);
		EXPORT DATASET(L) fun_wrapper(DATASET(L) ds, STRING ip) := 
			inner_wild_man(ds, 
					buzzsaw.Mod_Octets.F_C_Blanks(ip), 
					buzzsaw.Mod_Octets.F_C_Mask(ip)
				);
	ENDMACRO;
	
	EXPORT DATASET range_filter(rangy_name, L, range_field, range_type) := MACRO
		EXPORT DATASET(L) rangy_name(DATASET(L) ds, #EXPAND(range_type) mn, #EXPAND(range_type) mx) :=
			IF( mx >= mn, ds(range_field BETWEEN mn AND mx), ds);
	ENDMACRO;
	
	EXPORT DATASET string_filter(stringy_name, L, string_field) := MACRO
		EXPORT DATASET(L) stringy_name(DATASET(L) ds, String input) :=
			IF( input <> '', ds(string_field = input), ds);
//			IF( input <> '', ds(#EXPAND(string_field) = input), ds);
	ENDMACRO;
		
	EXPORT DATASET threat_filter(foreboding_name, L, string_field) := MACRO
		EXPORT DATASET(L) foreboding_name(DATASET(L) ds, QSTRING input) :=
			MAP(	input = '' => ds,
					input = 'ALL' => ds(string_field <> ''),
					ds(string_field = input)
			);
	ENDMACRO;
	
	EXPORT DATASET standard_filters(name, L) := MACRO
		double_wild(#EXPAND('wild_'+name+'_srcip'), #EXPAND('wild_'+name+'_srcip_u4'), L, srcip_u4);
		double_wild(#EXPAND('wild_'+name+'_destip'), #EXPAND('wild_'+name+'_destip_u4'), L, destip_u4);
		filter_u_i(#EXPAND(name+'_srcport'), L, srcport, '2', '3');
		filter_u_i(#EXPAND(name+'_destport'), L, destport, '2', '3');	
		filter_u_i(#EXPAND(name+'_snt_pckts'), L, sent_packets, '4', '5');
		filter_u_i(#EXPAND(name+'_rcv_pckts'), L, rcv_packets, '4', '5');
		filter_u_i(#EXPAND(name+'_records'), L, records, '4', '5');
		range_filter(#EXPAND(name+'_date'), L, ms_start, 'INTEGER6');
		range_filter(#EXPAND(name+'_duration'), L, duration, 'REAL4');
		string_filter(#EXPAND(name+'_src_cc'), L, src_cc);
		string_filter(#EXPAND(name+'_dest_cc'), L, dest_cc);
		string_filter(#EXPAND(name+'_protocol'), L, protocol);
	ENDMACRO;
	
	EXPORT DATASET u4_index_filters(name, L) := MACRO
		standard_filters(name, L);
		range_filter(#EXPAND(name+'_time_of_day'), L, tod, 'INTEGER4');
	ENDMACRO;
		
	
	EXPORT unpack(trendy_name, L_Input, L_Output) := MACRO
	
		#UNIQUENAME(L_UIP_Payload);
		#UNIQUENAME(L_Temp);
		#UNIQUENAME(IDX);
		#UNIQUENAME(ds1);
		
		SHARED %IDX% := buzzsaw.Mod_Data_Indexes.IDX_UIP_Location_IP;		
		SHARED %L_UIP_Payload% := RECORDOF(%IDX%);
		SHARED %L_Temp% := RECORD
			L_Input;
			%L_UIP_Payload% src;
		END;
		
		EXPORT L_Output := RECORD
			%L_Temp%;
			%L_UIP_Payload% dest;
		END;
		EXPORT DATASET(L_Output) trendy_name(DATASET(L_Input) ds) := FUNCTION
			%L_Temp% join1(L_Input x, %IDX% loc) := TRANSFORM
				SELF.src := loc;
				SELF := x;
				SELF := [];
			END;
			L_Output join2(%L_Temp% x, %IDX% loc) := TRANSFORM
				SELF.dest := loc;
				SELF := x;
			END;
			
			%ds1% := JOIN(ds, %IDX%,	LEFT.srcip_u4 = RIGHT.ip_u4, join1(LEFT, RIGHT));
			RETURN JOIN(%ds1%, %IDX%, LEFT.destip_u4 = RIGHT.ip_u4, join2(LEFT, RIGHT));
		END;
	ENDMACRO;
/*	
	double_wild(threats_srcip, threats_srcip_u4, 
			buzzsaw.Mod_Data.L_Firewall_Threats, srcip_u4);
	double_wild(threats_destip, threats_destip_u4, 
			buzzsaw.Mod_Data.L_Firewall_Threats, destip_u4);
			
	filter_u2_i3(threats_srcport, buzzsaw.Mod_Data.L_Firewall_Threats, srcport);
	filter_u2_i3(threats_destport, buzzsaw.Mod_Data.L_Firewall_Threats, destport);
	
	filter_u4_i5(threats_snt_pckts, buzzsaw.Mod_Data.L_Firewall_Threats, sent_packets);
	filter_u4_i5(threats_rcv_pckts, buzzsaw.Mod_Data.L_Firewall_Threats, rcv_packets);
*/			


	standard_filters('u4', buzzsaw.Mod_Data.L_Firewall_U4);
	u4_index_filters('threats', buzzsaw.Mod_Data.L_Firewall_Threats);
	u4_index_filters('u4_ips', RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_IPs));
	u4_index_filters('u4_destIP', RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_destIP_u4));
	u4_index_filters('u4_destPort', RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_DestPort));
	u4_index_filters('u4_tod', RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_Time_Of_Day));
	u4_index_filters('u4_dest_cc', RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_dest_cc));
	u4_index_filters('u4_src_cc', RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_src_cc));
	u4_index_filters('u4_protocol', RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_protocol));
	
	threat_filter(threats_src, buzzsaw.Mod_Data.L_Firewall_Threats, src_threat);
	threat_filter(threats_dest, buzzsaw.Mod_Data.L_Firewall_Threats, dest_threat);
	
//	string_filter('u4_src_cc', buzzsaw.Mod_Data.L_Firewall_U4, src_cc);
//	string_filter('u4_dest_cc', buzzsaw.Mod_Data.L_Firewall_U4, dest_cc);

	unpack(F_Unpack_U4, buzzsaw.Mod_Data.L_Firewall_U4, L_Unpacked_U4);
	unpack(F_Unpack_Threats, buzzsaw.Mod_Data.L_Firewall_Threats, L_Unpacked_Threats);
	
//	unpack(F_Unpack_U4_idx, buzzsaw.Mod_Data.L_Firewall_PreUnpack, L_Unpacked_U4_idx);
	unpack(F_Unpack_U4_idx_IPs, RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_IPs), L_U_U4_IPs);
	unpack(F_Unpack_U4_destIP, RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_DestIP_U4), L_U_U4_DestIP);
	unpack(F_Unpack_U4_destport, RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_DestPort), L_U_U4_DestPort);
	unpack(F_Unpack_U4_tod, RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_Time_Of_Day), L_U_U4_TOD);
	unpack(F_Unpack_U4_src_cc, RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_Src_CC), L_U_U4_Src_CC);
	unpack(F_Unpack_U4_dest_cc, RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_Dest_CC), L_U_U4_Dest_CC);
	unpack(F_Unpack_U4_protocol, RECORDOF(buzzsaw.Mod_Data_Indexes.IDX_U4_protocol), L_U_U4_Protocol);
	
	
	EXPORT DATASET get_pt_output(L, pt_output) := MACRO
		EXPORT DATASET(Mod_Data.L_Firewall_Unpacked) pt_output(DATASET(L) ds) := FUNCTION
			#UNIQUENAME(ds1);
			#UNIQUENAME(ds2);

			%ds1% := JOIN(ds, buzzsaw.Mod_Data_Indexes.IDX_Threat_IP_u4,
				LEFT.srcip_u4 = RIGHT.ip_u4,
				TRANSFORM({L, STRING1 src_threat},
					SELF.src_threat := trim(RIGHT.threat[1]),
					SELF := LEFT
				), LEFT OUTER);
			%ds2% := JOIN(%ds1%, buzzsaw.Mod_Data_Indexes.IDX_Threat_IP_u4,
				LEFT.destip_u4 = RIGHT.ip_u4,
				TRANSFORM({L, STRING1 src_threat, STRING1 dest_threat},
					SELF.dest_threat := trim(RIGHT.threat[1]),
					SELF := LEFT
				), LEFT OUTER);
//			output(%ds2%);
			RETURN PROJECT(%ds2%, TRANSFORM(Mod_Data.L_Firewall_Unpacked, 
				SELF.date := Mod_Y2K.format_date(LEFT.ms_start),
				SELF := LEFT));
		END;
	ENDMACRO;

	export DATASET(Mod_Data.L_Firewall_Unpacked) ds_idx_ips(
			UNSIGNED4 s, UNSIGNED4 s_mask,
			INTEGER3 srcport,
			UNSIGNED4 d, UNSIGNED4 d_mask,
			INTEGER3 destport,
			STRING protocol,
			STRING src_cc, STRING dest_cc,
			INTEGER5 received,
			INTEGER5 records,
			INTEGER5 sent,
			INTEGER6 mn_date, INTEGER6 mx_date,
			INTEGER4 mn_tod, INTEGER4 mx_tod,
			REAL4 mn_duration, REAL4 mx_duration,
			INTEGER2 rec_limit) := FUNCTION
		idx := Mod_Data_Indexes.IDX_U4_ips(srcip_u4=s);
		idx1 := wild_u4_ips_destip_u4(idx, d, d_mask);
		idx2 := u4_ips_date(idx1, mn_date, mx_date);
		idx3 := u4_ips_records(idx2, records);
		idx4 := u4_ips_srcport(idx3, srcport);
		idx5 := u4_ips_destport(idx4, destport);
		idx6 := u4_ips_snt_pckts(idx5, sent);
		idx7 := u4_ips_rcv_pckts(idx6, received);
		idx8 := u4_ips_duration(idx7, mn_duration, mx_duration);
		idx9 := u4_ips_time_of_day(idx8, mn_tod, mx_tod);
		idxa := u4_ips_src_cc(idx9, src_cc);
		idxb := u4_ips_dest_cc(idxa, dest_cc);
		idxc := u4_ips_protocol(idxb, protocol);
		idxn := CHOOSEN(idxc, rec_limit);
		idx_j := F_Unpack_U4_idx_IPs(idxn);
		get_pt_output(RECORDOF(idx_j), my_trans);
		RETURN my_trans(idx_j);
	END;
			
	export DATASET(Mod_Data.L_Firewall_Unpacked) ds_idx_destip(
			UNSIGNED4 s, UNSIGNED4 s_mask,
			INTEGER3 srcport,
			UNSIGNED4 d, UNSIGNED4 d_mask,
			INTEGER3 destport,
			STRING protocol,
			STRING src_cc, STRING dest_cc,
			INTEGER5 received,
			INTEGER5 records,
			INTEGER5 sent,
			INTEGER6 mn_date, INTEGER6 mx_date,
			INTEGER4 mn_tod, INTEGER4 mx_tod,
			REAL4 mn_duration, REAL4 mx_duration,
			INTEGER2 rec_limit) := FUNCTION
		idx := Mod_Data_Indexes.IDX_U4_destip_u4(destip_u4=d);
		idx1 := u4_destip_destport(idx, destport);
		idxa := u4_destip_src_cc(idx1, src_cc);
		idxb := u4_destip_dest_cc(idxa, dest_cc);
		idxc := u4_destip_protocol(idxb, protocol);
		idx2 := wild_u4_destip_srcip_u4(idxc, s, s_mask);
		idx3 := u4_destip_date(idx2, mn_date, mx_date);
		idx4 := u4_destip_records(idx3, records);
		idx5 := u4_destip_srcport(idx4, srcport);
		idx6 := u4_destip_snt_pckts(idx5, sent);
		idx7 := u4_destip_rcv_pckts(idx6, received);
		idx8 := u4_destip_duration(idx7, mn_duration, mx_duration);
		idx9 := u4_destip_time_of_day(idx8, mn_tod, mx_tod);
		idxn := CHOOSEN(idx9, rec_limit);
		idx_j := F_Unpack_U4_destIP(idxn);
		get_pt_output(RECORDOF(idx_j), my_trans);
		RETURN my_trans(idx_j);
	END;
	
	export DATASET(Mod_Data.L_Firewall_Unpacked) ds_idx_destport(
			UNSIGNED4 s, UNSIGNED4 s_mask,
			INTEGER3 srcport,
			UNSIGNED4 d, UNSIGNED4 d_mask,
			INTEGER3 dest_port,
			STRING protocol,
			STRING src_cc, STRING dest_cc,
			INTEGER5 received,
			INTEGER5 records,
			INTEGER5 sent,
			INTEGER6 mn_date, INTEGER6 mx_date,
			INTEGER4 mn_tod, INTEGER4 mx_tod,
			REAL4 mn_duration, REAL4 mx_duration,
			INTEGER2 rec_limit) := FUNCTION
		idx := Mod_Data_Indexes.IDX_U4_destport;
		idxa := idx(destport=dest_port);
		idxb := u4_destport_snt_pckts(idxa, sent);
		idxc := u4_destport_rcv_pckts(idxb, received);
		idxd := u4_destport_time_of_day(idxc, mn_tod, mx_tod);
		idxe := wild_u4_destport_destip_u4(idxd, d, d_mask);
		idxf := wild_u4_destport_srcip_u4(idxe, s, s_mask);
		idxg := u4_destport_date(idxf, mn_date, mx_date);
		idxh := u4_destport_records(idxg, records);
		idxi := u4_destport_srcport(idxh, srcport);
		idxj := u4_destport_duration(idxi, mn_duration, mx_duration);
		idxk := u4_destport_src_cc(idxj, src_cc);
		idxl := u4_destport_dest_cc(idxk, dest_cc);
		idxm := u4_destport_protocol(idxl, protocol);
		idxn := CHOOSEN(idxm, rec_limit);
		idx_j := F_Unpack_U4_destPort(idxn);
		get_pt_output(RECORDOF(idx_j), my_trans);
		RETURN my_trans(idx_j);
	END;
	
	export DATASET(Mod_Data.L_Firewall_Unpacked) ds_idx_tod(
			UNSIGNED4 s, UNSIGNED4 s_mask,
			INTEGER3 srcport,
			UNSIGNED4 d, UNSIGNED4 d_mask,
			INTEGER3 destport,
			STRING protocol,
			STRING src_cc, STRING dest_cc,
			INTEGER5 received,
			INTEGER5 records,
			INTEGER5 sent,
			INTEGER6 mn_date, INTEGER6 mx_date,
			INTEGER4 mn_tod, INTEGER4 mx_tod,
			REAL4 mn_duration, REAL4 mx_duration,
			INTEGER2 rec_limit, BOOLEAN force = false) := FUNCTION
		idx := Mod_Data_Indexes.IDX_U4_Time_Of_Day;
		idxa := idx(tod BETWEEN mn_tod AND mx_tod OR force);
		idxz := u4_tod_dest_cc(idxa, dest_cc);
		idxy := u4_tod_src_cc(idxz, src_cc);
		idxb := u4_tod_destport(idxy, destport);
		idxc := u4_tod_duration(idxb, mn_duration, mx_duration);
		idxd := u4_tod_snt_pckts(idxc, sent);
		idxe := u4_tod_rcv_pckts(idxd, received);
		idxf := wild_u4_tod_destip_u4(idxe, d, d_mask);
		idxg := wild_u4_tod_srcip_u4(idxf, s, s_mask);
		idxh := u4_tod_date(idxg, mn_date, mx_date);
		idxi := u4_tod_records(idxh, records);
		idxj := u4_tod_srcport(idxi, srcport);
		idxk := u4_tod_protocol(idxj, protocol);
		idxn := CHOOSEN(idxk, rec_limit);
		idx_j := F_Unpack_U4_tod(idxn);
		get_pt_output(L_U_U4_TOD, my_trans);
		RETURN my_trans(idx_j);
	END;
	
	export DATASET(Mod_Data.L_Firewall_Unpacked) ds_idx_src_cc(
			UNSIGNED4 s, UNSIGNED4 s_mask,
			INTEGER3 srcport,
			UNSIGNED4 d, UNSIGNED4 d_mask,
			INTEGER3 destport,
			STRING protocol,
			STRING src_country, STRING dest_country,
			INTEGER5 received,
			INTEGER5 records,
			INTEGER5 sent,
			INTEGER6 mn_date, INTEGER6 mx_date,
			INTEGER4 mn_tod, INTEGER4 mx_tod,
			REAL4 mn_duration, REAL4 mx_duration,
			INTEGER2 rec_limit) := FUNCTION
		idx := Mod_Data_Indexes.IDX_U4_Src_CC;
		idxa := idx(src_cc=src_country);
		idxc := u4_src_cc_destport(idxa, destport);
		idxd := u4_src_cc_dest_cc(idxc, dest_country);
		idxe := u4_src_cc_time_of_day(idxd, mn_tod, mx_tod);
		idxi := u4_src_cc_duration(idxe, mn_duration, mx_duration);
		idxk := u4_src_cc_snt_pckts(idxi, sent);
		idxm := u4_src_cc_rcv_pckts(idxk, received);
		idxo := wild_u4_src_cc_destip_u4(idxm, d, d_mask);
		idxq := wild_u4_src_cc_srcip_u4(idxo, s, s_mask);
		idxs := u4_src_cc_date(idxq, mn_date, mx_date);
		idxu := u4_src_cc_records(idxs, records);
		idxw := u4_src_cc_srcport(idxu, srcport);
		idxx := u4_src_cc_protocol(idxw, protocol);
		idxy := CHOOSEN(idxx, rec_limit);
		idx_j := F_Unpack_U4_src_cc(idxy);
		get_pt_output(L_U_U4_Src_CC, my_trans);
		RETURN my_trans(idx_j);
	END;
	
	export DATASET(Mod_Data.L_Firewall_Unpacked) ds_idx_dest_cc(
			UNSIGNED4 s, UNSIGNED4 s_mask,
			INTEGER3 srcport,
			UNSIGNED4 d, UNSIGNED4 d_mask,
			INTEGER3 destport,
			STRING protocol,
			STRING src_country, STRING dest_country,
			INTEGER5 received,
			INTEGER5 records,
			INTEGER5 sent,
			INTEGER6 mn_date, INTEGER6 mx_date,
			INTEGER4 mn_tod, INTEGER4 mx_tod,
			REAL4 mn_duration, REAL4 mx_duration,
			INTEGER2 rec_limit) := FUNCTION
		idx := Mod_Data_Indexes.IDX_U4_Dest_CC;
		idx_i := idx(dest_cc=dest_country);
		idx_ii := u4_dest_cc_destport(idx_i, destport);
		idx_iii := u4_dest_cc_snt_pckts(idx_ii, sent);
		idx_iv := u4_dest_cc_rcv_pckts(idx_iii, received);
		idx_v := u4_dest_cc_time_of_day(idx_iv, mn_tod, mx_tod);
		idx_vi := wild_u4_dest_cc_srcip_u4(idx_v, s, s_mask);
		idx_vii := wild_u4_dest_cc_destip_u4(idx_vi, d, d_mask);
		idx_viii := u4_dest_cc_srcport(idx_vii, srcport);
		idx_ix := u4_dest_cc_date(idx_viii, mn_date, mx_date);
		idx_x := u4_dest_cc_duration(idx_ix, mn_duration, mx_duration);
		idx_xi := u4_dest_cc_records(idx_x, records);
		idx_xii := u4_dest_cc_src_cc(idx_xi, src_country);
		idx_xiii := u4_dest_cc_protocol(idx_xii, protocol);
		idx_xiv := CHOOSEN(idx_xiiI, rec_limit);
		idx_xv := F_Unpack_U4_dest_cc(idx_xiv);
		get_pt_output(L_U_U4_dest_cc, my_trans);
		RETURN my_trans(idx_xv);
	END;
	
	export DATASET(Mod_Data.L_Firewall_Unpacked) ds_idx_protocol(
			UNSIGNED4 s, UNSIGNED4 s_mask,
			INTEGER3 srcport,
			UNSIGNED4 d, UNSIGNED4 d_mask,
			INTEGER3 destport,
			STRING p,
			STRING src_country, STRING dest_country,
			INTEGER5 received,
			INTEGER5 records,
			INTEGER5 sent,
			INTEGER6 mn_date, INTEGER6 mx_date,
			INTEGER4 mn_tod, INTEGER4 mx_tod,
			REAL4 mn_duration, REAL4 mx_duration,
			INTEGER2 rec_limit) := FUNCTION
		idx := Mod_Data_Indexes.IDX_U4_Protocol;
		idx_i := idx(p = protocol);
		idx_ii := u4_protocol_destport(idx_i, destport);
		idx_iii := u4_protocol_snt_pckts(idx_ii, sent);
		idx_iv := u4_protocol_rcv_pckts(idx_iii, received);
		idx_v := u4_protocol_time_of_day(idx_iv, mn_tod, mx_tod);
		idx_vi := wild_u4_protocol_srcip_u4(idx_v, s, s_mask);
		idx_vii := wild_u4_protocol_destip_u4(idx_vi, d, d_mask);
		idx_viii := u4_protocol_srcport(idx_vii, srcport);
		idx_ix := u4_protocol_date(idx_viii, mn_date, mx_date);
		idx_x := u4_protocol_duration(idx_ix, mn_duration, mx_duration);
		idx_xi := u4_protocol_records(idx_x, records);
		idx_xii := u4_protocol_src_cc(idx_xi, src_country);
		idx_xiii := u4_protocol_dest_cc(idx_xii, dest_country);
		idx_xiv := CHOOSEN(idx_xiii, rec_limit);
		idx_xv := F_Unpack_U4_Protocol(idx_xiv);
		get_pt_output(L_U_U4_Protocol, my_trans);
		RETURN my_trans(idx_xv);
	END;
	
	export DATASET(Mod_Data.L_Firewall_Unpacked) ds_u4(
			UNSIGNED4 s, UNSIGNED4 s_mask,
			INTEGER3 srcport,
			UNSIGNED4 d, UNSIGNED4 d_mask,
			INTEGER3 destport,
			STRING protocol,
			STRING src_cc, STRING dest_cc,
			INTEGER5 received,
			INTEGER5 records,
			INTEGER5 sent,
			INTEGER6 mn_date, INTEGER6 mx_date,
			INTEGER4 mn_tod, INTEGER4 mx_tod,
			REAL4 mn_duration, REAL4 mx_duration,
			INTEGER2 rec_limit, boolean quit) := FUNCTION
//		OUTPUT(quit, NAMED('quit'));
		ds := Mod_Data.DS_U4;
		ds0 := ds(NOT quit);
//		ds0 := IF(quit, ds(FALSE)/*CHOOSEN(ds,1)*/, ds);
		ds1 := u4_srcport(ds0, srcport);
		ds2 := u4_destport(ds1, destport);
		ds3 := u4_duration(ds2, mn_duration, mx_duration);
		ds4 := u4_snt_pckts(ds3, sent);
		ds5 := u4_rcv_pckts(ds4, received);
		ds6 := wild_u4_destip_u4(ds5, d, d_mask);
		ds7 := wild_u4_srcip_u4(ds6, s, s_mask);
		ds8 := u4_date(ds7, mn_date, mx_date);
		ds9 := u4_records(ds8, records);
		ds10 := u4_src_cc(ds9, src_cc);
		ds11 := u4_dest_cc(ds10, dest_cc);
		ds12 := u4_protocol(ds11, protocol);
		dsn := CHOOSEN(ds12, rec_limit);
		idx_j := F_Unpack_U4(dsn);
		get_pt_output(L_Unpacked_U4, my_trans);
		RETURN my_trans(idx_j);
	END;
		
	export DATASET(Mod_Data.L_Firewall_Unpacked) F_Basic_Search(
			STRING SourceIP, 
			INTEGER3 SourcePort, 
			STRING DestinationIP, 
			INTEGER3 DestinationPort,
			String protocol,
			STRING src_cc, STRING dest_cc,
			INTEGER5 PacketsSent,
			INTEGER5 PacketsReceived,
			INTEGER5 records,
			INTEGER6 mn_date, INTEGER6 mx_date,
			REAL4 mn_duration, REAL4 mx_duration,
			INTEGER4 mn_tod, INTEGER4 mx_tod,
			INTEGER2 rec_limit) := FUNCTION

		src_netmask := Mod_Octets.F_C_Mask(SourceIP);
		dest_netmask := Mod_Octets.F_C_MASK(DestinationIP);
		
		src_blanks := Mod_Octets.F_C_Blanks(SourceIP);
		dest_blanks := Mod_Octets.F_C_Blanks(DestinationIP);
		
		BOOLEAN use_src_index := src_netmask = buzzsaw.Mod_Octets.MASKALL;
		BOOLEAN use_dest_index := dest_netmask = buzzsaw.Mod_Octets.MASKALL;
		BOOLEAN use_destport_index := DestinationPort >= 0;
		BOOLEAN use_tod_index := mx_tod > mn_tod AND (mx_tod-mn_tod) <= ms_2hours;
		BOOLEAN narrow_tod := use_tod_index AND (mx_tod-mn_tod) <= ms_narrow;
		BOOLEAN use_sent_packets := PacketsSent >= 0;
		BOOLEAN use_received_packets := PacketsReceived >= 0;
		BOOLEAN use_src_cc_index := src_cc <> '' AND src_cc <> '-' AND src_cc <> 'US';
		BOOLEAN use_dest_cc_index := dest_cc <> '' AND dest_cc <> '-' AND dest_cc <> 'US';
		BOOLEAN use_protocol_index := protocol <> '';
		
		BOOLEAN use_an_index := use_src_index OR use_dest_index OR use_destport_index OR
				use_tod_index OR use_src_cc_index OR use_dest_cc_index OR use_protocol_index;
//		OUTPUT(use_an_index, NAMED('use_an_index'));
		
		RETURN MAP(
				use_src_index AND use_dest_index => ds_idx_ips
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_dest_index AND use_destport_index => ds_idx_destip
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_src_cc_index AND use_destport_index => ds_idx_src_cc
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_dest_cc_index AND use_destport_index => ds_idx_dest_cc
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_destport_index AND use_sent_packets AND use_received_packets => ds_idx_destport
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_src_index => ds_idx_ips
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_dest_index => ds_idx_destip
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				narrow_tod => ds_idx_tod
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_src_cc_index => ds_idx_src_cc
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_dest_cc_index => ds_idx_dest_cc
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_protocol_index => ds_idx_protocol
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_destport_index => ds_idx_destport
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit),
				use_tod_index => ds_idx_tod
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit, true),
				ds_u4
					(src_blanks, src_netmask, SourcePort, dest_blanks, dest_netmask, DestinationPort,
						protocol, src_cc, dest_cc, PacketsReceived, records, PacketsSent, 
						mn_date, mx_date,	mn_tod, mx_tod, mn_duration, mx_duration, rec_limit,
						use_an_index)
		);
/*
		src_blanks := Mod_Octets.F_C_Blanks(SourceIP);
		dest_blanks := Mod_Octets.F_C_Blanks(DestinationIP);
		
		
	
		ds := ds_ips_indexed(src_blanks, dest_blanks, use_src_index, use_dest_index);

		f1 := u4_srcport(ds, SourcePort);
		f2 := u4_destport(f1, DestinationPort);
		f3 := wild_u4_destip(f2, DestinationIP);
		f4 := wild_u4_srcip(f3, SourceIP);
		f5 := u4_snt_pckts(f4, PacketsSent);
		f6 := u4_rcv_pckts(f5, PacketsReceived);
		fx := f6;
		RETURN fx;
	*/				
	END;	

	export DATASET(buzzsaw.Mod_Data.L_Firewall_Threats) F_Filter_Threats(
			STRING SourceIP, 
			INTEGER3 SourcePort, 
			STRING DestinationIP, 
			INTEGER3 DestinationPort,
			STRING Protocol,
			STRING2 SourceCountry,
			STRING2 DestinationCountry,
			INTEGER5 PacketsSent,
			INTEGER5 PacketsReceived,
			STRING SourceThreat,
			STRING DestinationThreat,
			INTEGER records,
			INTEGER6 mn_date, INTEGER6 mx_date,
			REAL4 mn_duration, REAL4 mx_duration,
			INTEGER4 mn_tod, INTEGER4 mx_tod,
			INTEGER2 rec_limit
			) := FUNCTION

		ds := buzzsaw.Mod_Data.DS_Threats_Found;
		f1 := threats_srcport(ds, SourcePort);
		f2 := threats_destport(f1, DestinationPort);
		f3 := wild_threats_destip(f2, DestinationIP);
		f4 := wild_threats_srcip(f3, SourceIP);
		f5 := threats_snt_pckts(f4, PacketsSent);
		f6 := threats_rcv_pckts(f5, PacketsReceived);
		f7 := threats_src_cc(f6, SourceCountry);
		f8 := threats_dest_cc(f7, DestinationCountry);
		f9 := threats_src(f8, SourceThreat);
		f10 := threats_dest(f9, DestinationThreat);
		f11 := threats_date(f10, mn_date, mx_date);
		f12 := threats_duration(f11, mn_duration, mx_duration);
		f13 := threats_records(f12, records);
		f14 := threats_time_of_day(f12, mn_tod, mx_tod);
		fx := f14;
		RETURN choosen(fx, rec_limit);
					
	END;	
	
END;