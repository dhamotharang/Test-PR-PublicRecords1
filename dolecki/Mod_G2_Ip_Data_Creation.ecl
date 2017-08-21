export Mod_G2_Ip_Data_Creation := MODULE

	SHARED STRING ip_pattern := '^(.*)\\.(.*)\\.(.*)\\.(.*)$';

	export C_UIPL_ID := FUNCTION
		ds_uipl        := dolecki.Mod_G2_Ip_Data.DS_UIPL;
		uipl_layout    := dolecki.Mod_G2_Ip_Data.L_UIPL;
		uipl_id_layout := dolecki.Mod_G2_Ip_Data.L_UIPL_ID;

		uipl_id_layout add_id(uipl_layout l, INTEGER c) := TRANSFORM
			SELF.id := c;
			SELF := l;
		END;

		ds_uipl_id := PROJECT(ds_uipl,add_id(LEFT,COUNTER));

		output(ds_uipl_id,,dolecki.Mod_G2_Ip_Data.FN_UIPL_ID,OVERWRITE);
		
		return 'SUCCESS';
	END;
	
	export C_DDCC_ID := FUNCTION
		ds_ddcc        := dolecki.Mod_G2_Ip_Data.DS_DDCC;
		ddcc_layout    := dolecki.Mod_G2_Ip_Data.L_Firewall_Packed;
		ddcc_id_layout := dolecki.Mod_G2_Ip_Data.L_Firewall_Packed_Id;

		ddcc_id_layout add_id(ddcc_layout l, INTEGER c) := TRANSFORM
			SELF.id := c;
			SELF.srcip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, l.srcip, 1),
			SELF.srcip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, l.srcip, 2),
			SELF.srcip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, l.srcip, 3),
			SELF.srcip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, l.srcip, 4),
			SELF.destip_octet1 := (UNSIGNED1)REGEXFIND(ip_pattern, l.destip, 1),
			SELF.destip_octet2 := (UNSIGNED1)REGEXFIND(ip_pattern, l.destip, 2),
			SELF.destip_octet3 := (UNSIGNED1)REGEXFIND(ip_pattern, l.destip, 3),
			SELF.destip_octet4 := (UNSIGNED1)REGEXFIND(ip_pattern, l.destip, 4),
			SELF := l;
		END;

		ds_ddcc_id := PROJECT(ds_ddcc,add_id(LEFT,COUNTER));

		output(ds_ddcc_id,,dolecki.Mod_G2_Ip_Data.FN_DDCCI,OVERWRITE);
		
		return 'SUCCESS';
	END;
	
	export C_DDCCIL := FUNCTION
		ds_ddcci       := dolecki.Mod_G2_Ip_Data.DS_DDCCI;
		ds_uipl_idx_ip := dolecki.Mod_G2_Ip_Data.IDX_UIPL_ip;
		ddccil_layout  := dolecki.Mod_G2_Ip_Data.L_DDCCIL;
		
		ddccil_layout join_src_with_location(ds_ddcci l, ds_uipl_idx_ip r) := TRANSFORM
			SELF.protocol_id := dolecki.Mod_G2_Ip_Data.map_protocol_to_int(l.protocol);
			SELF.src_location_id := r.id;
			SELF.src_country_code := r.country_code;
			SELF.dest_location_id := 0;
			SELF.dest_country_code := '';
			SELF := l;
		END;
		
		ds_ddcil_src_joined := JOIN(
			ds_ddcci,
			ds_uipl_idx_ip,
			LEFT.srcip_octet1 = RIGHT.ip_octet1
				AND
			LEFT.srcip_octet2 = RIGHT.ip_octet2
				AND
			LEFT.srcip_octet3 = RIGHT.ip_octet3
				AND
			LEFT.srcip_octet4 = RIGHT.ip_octet4,
			join_src_with_location(LEFT,RIGHT)
		);

		ddccil_layout join_dest_with_location(ds_ddcil_src_joined l, ds_uipl_idx_ip r) := TRANSFORM
			SELF.dest_location_id := r.id;
			SELF.dest_country_code := r.country_code;
			SELF := l;
		END;

		ds_ddcil_dest_joined := JOIN(
			ds_ddcil_src_joined,
			ds_uipl_idx_ip,
			LEFT.destip_octet1 = RIGHT.ip_octet1
				AND
			LEFT.destip_octet2 = RIGHT.ip_octet2
				AND
			LEFT.destip_octet3 = RIGHT.ip_octet3
				AND
			LEFT.destip_octet4 = RIGHT.ip_octet4,
			join_dest_with_location(LEFT,RIGHT)
		);
		
		output(ds_ddcil_dest_joined,,dolecki.Mod_G2_Ip_Data.FN_DDCCIL,OVERWRITE);
		return 'SUCCESS';
	END;
	
	
END;