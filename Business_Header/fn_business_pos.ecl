import corp2, doxie, doxie_cbrs, vehiclev2, uccd, uccv2, LN_PropertyV2, ut, MDR, AutoStandardI;

export fn_business_pos(
  dataset(doxie_cbrs.layout_supergroup) in_bdids,
	boolean LNBranded,
	unsigned1 DPPA_Purpose,
	boolean include_non_regulated_sources = false
) := function

  // RECORD LAYOUT
	temp_layout := record
	  doxie_cbrs.layout_supergroup;
		boolean has_sos := false;
		boolean has_ucc := false;
		boolean has_ucc_v2 := false;
		boolean has_prop := false;
		boolean has_mvr := false;
		boolean has_cont := false;
	end;
	
  // SOS
	temp_sos :=
	  join(
		  in_bdids,
			corp2.key_Corp_bdid,
			keyed(left.bdid = right.bdid),
			transform(
			  temp_layout,
				self.has_sos := (right.bdid != 0),
				self := left),
			left outer,
			keep(1));
	
	// UCC_V2
	temp_ucc_v2 :=
	  join(
		  temp_sos,
			uccv2.key_bdid_w_Type,
			keyed(left.bdid = right.bdid) and
			keyed(right.party_type='D'),
			transform(
			  temp_layout,
				self.has_ucc := (right.bdid != 0),
				self.has_ucc_v2 := (right.bdid != 0),
				self := left),
			left outer,
			limit(1000,skip),
			keep(1));
	
	// MVR
	temp_mvr :=
		rollup(
			sort(
				join(
					join(
						temp_ucc_v2,
						VehicleV2.Key_Vehicle_BDID,
						keyed(left.bdid = right.append_bdid),
						left outer,
						keep(1000)),
					VehicleV2.Key_Vehicle_Main_Key,
					keyed(left.vehicle_key != '' and left.vehicle_key = right.vehicle_key) and
					keyed(left.iteration_key = right.iteration_key) and
					(include_non_regulated_sources or right.source_code not in [MDR.sourceTools.src_infutor_veh,MDR.sourceTools.src_infutor_motorcycle_veh]),
					transform(
						temp_layout,
						self.has_mvr := if(right.vehicle_key = '',false,ut.PermissionTools.dppa.state_ok(right.state_origin,dppa_purpose,,right.source_code)),
						self := left),
					left outer,
					keep(1000)),
				group_id,
				bdid),
			left.group_id = right.group_id and
			left.bdid = right.bdid,
			transform(
				temp_layout,
				self.has_mvr := left.has_mvr or right.has_mvr,
				self := left));
					
	  // join(
		  // temp_ucc_v2,
			// VehicleV2.Key_Vehicle_BDID,
			// keyed(left.bdid = right.append_bdid),
			// transform(
			  // temp_layout,
				// self.has_mvr := (right.append_bdid != 0),
				// self := left),
			// left outer,
			// keep(1));
	
	// CONT
	// Note: rolling back changes made in #118305. No need to apply GLB here because the join below never counts hdr records (from_hdr='N')
	// Also, the additional join condition was causing more than 10000 match candidates error.
	temp_cont :=
		rollup(
			sort(
				join(
					temp_mvr,
					Business_Header.Key_Business_Contacts_BDID,
					keyed(left.bdid = right.bdid),
					transform(
						temp_layout,
						self.has_cont := map(
							right.bdid = 0 => false,
							right.from_hdr != 'N' => false,  
							mdr.sourcetools.SourceIsEBR(right.source) AND doxie.DataRestriction.EBR => false,
							true),
						self := left),
					left outer,
					keep(1000)),
				group_id,
				bdid),
			left.group_id = right.group_id and
			left.bdid = right.bdid,
			transform(
				temp_layout,
				self.has_cont := left.has_cont or right.has_cont,
				self := left));
				
			
	// PROP
	temp_prop :=
		rollup(
			sort(
				join(
					temp_cont,
					LN_PropertyV2.key_search_bdid,
					keyed(left.bdid = right.s_bid),
					transform(
						temp_layout,
						self.has_prop :=
							map(
								right.ln_fares_id = '' => false,
								right.ln_fares_id[1] = 'R' => not doxie.DataRestriction.Fares,
								LNBranded	or right.ln_fares_id[1]<>'D'),
						self := left),
					left outer,
					keep(1000)),
				group_id,
				bdid),
			left.group_id = right.group_id and
			left.bdid = right.bdid,
			transform(
				temp_layout,
				self.has_prop := left.has_prop or right.has_prop,
				self := left));
	
	return temp_prop;
end;