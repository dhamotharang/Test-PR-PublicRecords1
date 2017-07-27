/* Attribute deprecated, please use VehicleV2.Raw attribute instead */
import doxie, doxie_cbrs, ut;

export Vehicle_raw := module

	export Layout_Vehicle_Key get_vehicle_keys_from_dids(
																dataset(doxie.layout_references) in_dids,
																unsigned in_limit = 0,
																boolean excludeLessors = false,
																boolean get_minors = false) := function
		
		base_mod := IParam.getReportModule();
    in_mod := module (base_mod)
      export boolean excludeLessors := ^.excludeLessors;
      export boolean getMinors := get_minors;
    end;
		return Raw.get_Vehicle_keys_from_dids(in_mod, in_dids, in_limit);			
		
	end;

	export Layout_Vehicle_Key get_vehicle_keys_from_vehkey(dataset(Layout_Vehicle_Key) in_veh_keys,
			unsigned in_limit = 0,boolean get_minors = TRUE,boolean include_non_regulated_sources = false):= function
		return Raw.get_vehicle_keys_from_vehKey(in_veh_keys, in_limit, get_minors, include_non_regulated_sources);
	end;

	export Layout_Vehicle_Key get_vehicle_keys_from_bdids(
																dataset(doxie_cbrs.layout_references) in_bdids,
																unsigned in_limit = 0) := function
		in_mod := IParam.getReportModule();
	  RETURN Raw.get_vehicle_keys_from_bdids(in_mod, in_bdids, in_limit);
	end;
	
	export get_vehicle_keys_from_vin(
															 dataset(Layout_Vehicle_Vin) in_VIN,
															 unsigned in_limit = 0,boolean get_minors=FALSE,
															 string13 dl_num ='',	
															 string20 Vehicle_Num ='') := function
													 
    in_mod := IParam.getReportModule();
		
		RETURN Raw.get_vehicle_keys_from_vin(in_mod, in_VIN, in_limit, dl_num, vehicle_num);
	end;
	
	export get_vehicle_keys_from_title(
															 dataset(Layout_Vehicle_Title_Number) in_ttl,
															 unsigned in_limit = 0) := function
		RETURN Raw.get_vehicle_keys_from_title(in_ttl, in_limit);
	end;
	
	export get_vehicle_keys_from_dl_number(
															 dataset(Layout_Vehicle_DL_Number) in_dlnum,
															 unsigned in_limit = 0,boolean get_minors=FALSE) := function
		dlNumbers := project(in_dlnum, Layouts.Layout_Vehicle_DL_Number_New);
    RETURN Raw.get_vehicle_keys_from_dl_number(dlNumbers, in_limit, get_minors);
	end;
	
	
	shared lic_plate_mac := MACRO
						keyed(left.state_origin=right.state_origin
						or left.state_origin ='') and
						keyed(left.lname='' or right.dph_lname=metaphonelib.DMetaPhone1(left.lname)[1..6]) and
						keyed(pfe(right.pfname,left.fname) OR (LENGTH(TRIM(left.fname))<2)) and
						(get_minors or right.is_minor = FALSE)
	ENDMACRO;
	

	
	export get_vehicle_keys_from_lic_plate(
															 dataset(Layout_Vehicle_Lic_Plate) in_lic_plate,
															 unsigned in_limit = Constant.VEHICLE_PER_LIC_PLATE,boolean get_leading = FALSE,
															 boolean get_minors = TRUE,unsigned return_count = 9999,
															 unsigned starting_record = 1, unsigned2 penalt_threshold = 20,
															 unsigned max_results = 9999,string1 state_type ='C'
															 ) := module
		licPlate := project(in_lic_plate, Layouts.Layout_Vehicle_Lic_Plate_New);
		
		base_mod := IParam.getSearchModule();				
    in_mod := module (base_mod)      
      export boolean getMinors := get_minors;
    end;		
    shared getFromPlate := Raw.get_vehicle_keys_from_lic_plate(in_mod,
		licPlate, in_limit, get_leading,  
				return_count, starting_record, max_results, state_type);
		export recs := getFromPlate.recs;
		export cnt := getFromPlate.cnt;		

	end;

	export get_vehicle_keys_from_lic_plate_reverse(
															 dataset(Layout_Vehicle_Lic_Plate) in_lic_plate,
															 unsigned in_limit = Constant.VEHICLE_PER_LIC_PLATE,boolean get_leading = FALSE,
															 boolean get_minors = TRUE,unsigned return_count = 9999,
															 unsigned starting_record = 1, unsigned2 penalt_threshold = 20,
															 unsigned max_results = 9999
															 ) := MODULE
    licPlate := project(in_lic_plate, Layouts.Layout_Vehicle_Lic_Plate_New);
		base_mod := IParam.getSearchModule();				
    in_mod := module (base_mod)      
      export boolean getMinors := get_minors;
    end;
    shared getFromPlateReverse := Raw.get_vehicle_keys_from_lic_plate_reverse(in_mod,
				licPlate, in_limit , get_leading , return_count, 
				starting_record, max_results );
		
		export recs := getFromPlateReverse.recs;
		export cnt := getFromPlateReverse.cnt;	
	end;

	EXPORT get_vehicle_report(GROUPED DATASET(Layout_Vehicle_Key) in_veh_keys,
														STRING in_ssn_mask_type = '') := FUNCTION
		in_mod := IParam.getReportModule();
		RETURN Raw.get_vehicle_report(in_mod, in_veh_keys, in_ssn_mask_type);
	END;
	
	EXPORT get_vehicle_search(GROUPED DATASET(Layout_Vehicle_Key) in_veh_keys,
														STRING in_ssn_mask_type = ''):= FUNCTION
		in_mod := IParam.getSearchModule();
		RETURN Raw.get_vehicle_search(in_mod, in_veh_keys, in_ssn_mask_type);
	END;


	
	export get_vehicle_crs_report_by_Veh_key (dataset(Layout_Vehicle_Key) in_veh_keys, string in_ssn_mask_type = '') := function

		// by_did := get_vehicle_keys_from_dids (in_dids);

		sort_keys := sort(in_veh_keys, Vehicle_Key, -Iteration_Key);
		group_keys := group(sort_keys, Vehicle_key, Iteration_key);
		dedup_keys := dedup(group_keys, Vehicle_Key, Iteration_Key,sequence_key);

		vsr := ungroup(get_vehicle_report(dedup_keys));
	
		rec := record
		vsr;
		unsigned1 priority_num;
		unsigned2 srt_num;
		end;

		srt := sort(vsr, vin,-((unsigned1)is_current),
		-max(registrants,reg_latest_effective_date), -max(registrants,reg_latest_expiration_date),
		-((unsigned) iteration_key),-sequence_key,record);
		
		srt_title_holders := sort(vsr,vin,if(exists(owners),0,1),
		-max(owners,ttl_latest_issue_date),-max(owners,ttl_earliest_issue_date),
		-((unsigned) iteration_key),-sequence_key);

		rec get_num(vsr l,integer C):=transform
			self :=l;
			self.priority_num := 1;
			self.srt_num := C;
		END;
		
		ddp := project(sort(dedup(srt, vin),
		-((unsigned1)is_current),-max(registrants,reg_latest_effective_date), -max(registrants,reg_latest_expiration_date), 
		-((unsigned) iteration_key)),
		get_num(left,counter));

		rec get_num_from_reg(vsr l,rec r):=transform
			self :=l;
			self.priority_num := 2;
			self.srt_num := r.srt_num;
		END;

		title_holders := dedup(srt_title_holders,vin)(exists(owners));
		
		ddp_titles := join(title_holders,ddp(~exists(owners)),left.vin=right.vin, get_num_from_reg(left,right));
		
		return project(sort(ddp + ddp_titles,NonDMVSource,srt_num,priority_num),transform(recordof(vsr),self :=left));

	end;	
	  export get_vehicle_crs_report (dataset(doxie.layout_references) in_dids, string in_ssn_mask_type = '') := function
			in_mod := IParam.getReportModule();
			return RAW.get_vehicle_crs_report(in_mod, in_dids, in_ssn_mask_type);
	end;
	
end;
